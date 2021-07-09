from setuptools import setup
import os
import PyInstaller.__main__

# os.system("export ")
PyInstaller.__main__.run([])
setup(
    name='carom-sblab',
    version='0.1.1',
    author='Kardel',
    author_email='kardel@umich.edu',
    packages=['carom', 'tests', 'carom.dataset'],
    url='http://pypi.python.org/pypi/carom/',
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
    classifiers=[
        'Development Status :: 3 - Alpha',
        # Chose either "3 - Alpha", "4 - Beta" or "5 - Production/Stable" as the current state of your package
        'Intended Audience :: Developers',  # Define that your audience are developers
        'Topic :: Software Development :: Build Tools',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        #  'Programming Language :: Python :: 3.6',
    ],
    entry_points={"console_scripts": ["realpython=reader.__main__:main"]},

)
