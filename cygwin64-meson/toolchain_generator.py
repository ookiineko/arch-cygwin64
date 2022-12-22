#!/usr/bin/env python
import argparse
import configparser
import os


class CrossFileGenerator:

	def __init__(self, output_file, need_exe_wrapper):
		self.target = 'x86_64-pc-cygwin'
		self.output_file = output_file
		self.need_exe_wrapper = need_exe_wrapper
		self.cflags = os.environ['CFLAGS'] if 'CFLAGS' in os.environ else ''
		self.cxxflags = os.environ["CXXFLAGS"] if 'CXXFLAGS' in os.environ else ''
		self.ldflags = os.environ["LDFLAGS"] if 'LDFLAGS' in os.environ else ''
		self.cpu_family = 'x86_64'
		self.processor = 'x86_64'

	def generate(self):
		config = configparser.ConfigParser()
		config['binaries'] = self.get_binaries_section()
		config['properties'] = self.get_properties_section()
		config['built-in options'] = self.get_builtin_options_section()
		config['host_machine'] = self.get_host_machine_section()
		with open(self.output_file, 'w') as configfile:
			config.write(configfile)

	def get_binaries_section(self):
		binaries = {'c':"'{}-gcc'".format(self.target),
				'cpp':"'{}-g++'".format(self.target),
				'fortran':"'{}-gfortran'".format(self.target),
				'ar':"'{}-gcc-ar'".format(self.target),
				'pkgconfig':"'{}-pkg-config'".format(self.target),
				'ranlib':"'{}-gcc-ranlib'".format(self.target),
				'strip':"'{}-strip'".format(self.target),
				'windres':"'{}-windres'".format(self.target),
				'cmake':"'{}-cmake'".format(self.target),
				'dlltool':"'{}-dlltool'".format(self.target),
				'libgcrypt-config':"'/usr/{}/bin/libgcrypt-config'".format(self.target),
				}
		if self.need_exe_wrapper:
			binaries.update({'exe_wrapper':"'{}-wine'".format(self.target)})
		return binaries

	def get_properties_section(self):
		return {'root':"'{}'".format(self.target),
			'sys_root':"'/usr/{}'".format(self.target),
			'needs_exe_wrapper':'true'
			}

	def get_builtin_options_section(self):
		return {'c_args':[f for f in self.cflags.split(" ") if f],
			'cpp_args':[f for f in self.cxxflags.split(" ") if f],
			'c_link_args':[f for f in self.ldflags.split(" ") if f],
			'cpp_link_args':[f for f in self.ldflags.split(" ") if f]
			}

	def get_host_machine_section(self):
		return {'system':"'cygwin'",
			'cpu_family':"'{}'".format(self.cpu_family),
			'cpu':"'{}'".format(self.processor),
			'endian':"'little'"
			}


if __name__ == '__main__':
	parser = argparse.ArgumentParser(description='Generate a meson cross file using CFLAGS/CXXFLAGS/LDFLAGS from env vars',
									add_help=False)
	required = parser.add_argument_group('required arguments')
	optional = parser.add_argument_group('optional arguments')
	required.add_argument('--output-file', type=str, required=True, help='Write the generated cross file to this path')
	optional.add_argument('-h', '--help', action='help', default=argparse.SUPPRESS,
						help='show this help message and exit')
	optional.add_argument("--need-exe-wrapper", dest='need_exe_wrapper', action='store_true', help="Add wine as exe wrapper")
	args = parser.parse_args()
	generator = CrossFileGenerator(args.output_file, args.need_exe_wrapper)
	generator.generate()
