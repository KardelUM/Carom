from setuptools import setup

setup(
   name='carom',
   version='0.1.0',
   author='An Awesome Coder',
   author_email='aac@example.com',
   packages=['carom', 'tests', 'carom.dataset'],
#    scripts=['bin/script1','bin/script2'],
   url='http://pypi.python.org/pypi/Carom/',
   license='LICENSE.md',
   description='An awesome package that does something',
   long_description=open('README.md').read(),
   install_requires=[
      #   "Django >= 1.1.1",
        "imbalanced-learn==0.8.0",
        "matplotlib==3.3.4",
        "numpy==1.19.2",
        "openpyxl==3.0.5",
        "pandas==1.2.2",
        "scikit-learn==0.24.1",
        "scipy==1.6.1",
        "seaborn==0.11.1",
        "shap==0.37.0",
        "xgboost==1.3.3",
        "xlrd==2.0.1",
        "XlsxWriter==1.3.7"
   ],
)