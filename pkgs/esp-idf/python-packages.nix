# Versions based on
# https://dl.espressif.com/dl/esp-idf/espidf.constraints.v6.1.txt
# on 2026-10-26.
#
# Versions found by running this script:
# ./pkgs/esp-idf/update-python-packages.sh release/v6.1
{
  fetchPypi,
  fetchurl,
  pythonPackages,
}:
with pythonPackages;
rec {
  idf-component-manager = buildPythonPackage rec {
    pname = "idf-component-manager";
    version = "3.1.2";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "idf_component_manager";
      sha256 = "sha256-da2eRFLRv0K+oKd9cq9nlxTiuxR2J9kmzuEUEituM6A=";
    };

    build-system = [
      setuptools
    ];
    doCheck = false;

    propagatedBuildInputs = [
      esp-pylib
      jsonref
      pathvalidate

      pydantic
      pydantic-core
      pydantic-settings
      pyparsing

      psutil
      rich
      rich-click
      ruamel-yaml
      requests
      requests-file
      requests-toolbelt
      typing-extensions
      truststore
    ];

    meta = {
      homepage = "https://github.com/espressif/idf-component-manager";
    };
  };

  esp-coredump = buildPythonPackage rec {
    pname = "esp-coredump";
    version = "1.17.2";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "esp_coredump";
      sha256 = "sha256-fA6zJATI+SvlCvDoOyuxSjPuxIC2ysdqhngw1WQHSmo=";
    };

    build-system = [
      setuptools
    ];

    doCheck = false;

    propagatedBuildInputs = [
      construct
      pygdbmi
      esptool
      esp-pylib
      click
      rich-click
      rich
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-coredump";
    };
  };

  esptool = buildPythonPackage rec {
    pname = "esptool";
    version = "5.6.0";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-hscknpzDqCTgMu3puiCrrQV6LEniMUGMxPArF3uzb0I=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      intelhex
      cryptography
      pyserial
      reedsolo
      pyyaml
      rich-click
      click
      esp-pylib
      websockets
    ];

    # esptool 5.x still installs deprecated esptool.py/espefuse.py/espsecure.py
    # shims into bin/. Once wrapped they shadow the esptool package on
    # sys.path, so drop them like nixpkgs does. ESP-IDF calls `python -m esptool`.
    postInstall = ''
      rm -v $out/bin/*.py
    '';

    meta = {
      homepage = "https://github.com/espressif/esptool";
    };
  };

  esp-idf-kconfig = buildPythonPackage rec {
    pname = "esp-idf-kconfig";
    version = "3.14.0";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_kconfig";
      sha256 = "sha256-Pd3P0s5L5gKxIx2VqNL3mF3QuaYgAtzGgJFkyUpuu8U=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      esp-pylib
      click
      rich-click
      pyparsing
      textual
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-kconfig";
    };
  };

  esp-idf-monitor = buildPythonPackage rec {
    pname = "esp-idf-monitor";
    version = "1.10.0";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_monitor";
      sha256 = "sha256-ettpJ6/aqoVG+0uO7XptIMypsKqAz6WDnYAXG47XkPU=";
    };

    build-system = [
      setuptools
    ];

    doCheck = false;

    propagatedBuildInputs = [
      pyserial
      esp-coredump
      pyelftools
      esp-idf-panic-decoder
      esp-pylib
      click
      rich-click
      rich
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-monitor";
    };
  };

  esp-idf-size = buildPythonPackage rec {
    pname = "esp-idf-size";
    version = "2.3.2";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_size";
      sha256 = "sha256-2ZR5vZA/Q2s/aLnt1WgBCKvo7IXQ8BXmV+IPguSLWmY=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      esp-pylib
      click
      rich-click
      websockets
      rich
      pyyaml
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-size";
    };
  };

  esp-idf-nvs-partition-gen = buildPythonPackage rec {
    pname = "esp-idf-nvs-partition-gen";
    version = "0.1.9";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_nvs_partition_gen";
      hash = "sha256-Q6ObVLJDGJ6REJpOmZaMhk8y4g4Ne5wzBSu9JqXxaQ8=";
    };

    build-system = [
      setuptools
    ];

    dependencies = [
      cryptography
    ];

    pythonImportsCheck = [ "esp_idf_nvs_partition_gen" ];

    meta = {
      homepage = "https://pypi.org/project/esp-idf-nvs-partition-gen/";
    };
  };

  pyclang = buildPythonPackage rec {
    pname = "pyclang";
    version = "0.7.0";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-s9SHh7tnSJFk0G7wNDMo1lGDG0Xw62fg/skiHvompfU=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      esp-pylib
      click
      rich-click
      rich
    ];

    meta = {
      homepage = "https://pypi.org/project/pyclang/";
    };
  };

  freertos_gdb = buildPythonPackage rec {
    pname = "freertos-gdb";
    version = "1.0.4";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-lH/dlTX2PuZ89rX5zzpedHkqHvdVy+h6BzJ8rVFmkb8=";
    };

    doCheck = false;

    meta = {
      homepage = "https://github.com/espressif/freertos-gdb";
    };
  };

  esp-idf-panic-decoder = buildPythonPackage rec {
    pname = "esp-idf-panic-decoder";
    version = "1.5.0";
    pyproject = true;

    build-system = [
      setuptools
    ];

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_panic_decoder";
      sha256 = "sha256-ewk/ehul/f135CqWBIe1pDP2Dc2r84zJgXbykfw6iPs=";
    };

    doCheck = false;

    propagatedBuildInputs = [
      pyelftools
      pyparsing
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-panic-decoder";
    };
  };

  esp-idf-diag = buildPythonPackage {
    pname = "esp-idf-diag";
    version = "0.2.0";
    pyproject = true;

    src = fetchurl {
      url = "https://github.com/espressif/esp-idf-diag/archive/refs/tags/v0.2.0.tar.gz";
      sha256 = "sha256-YEwLBYOveUl1xmZeZScXzY98PLCEWGgomt3t1WjJPJQ=";
    };

    build-system = [
      setuptools
    ];

    doCheck = false;

    propagatedBuildInputs = [
      pyyaml
      rich
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-diag";
      description = "Diagnostic tool for ESP-IDF";
    };
  };

  esp-pylib = buildPythonPackage rec {
    pname = "esp-pylib";
    version = "1.2.0";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "esp_pylib";
      sha256 = "sha256-UfDESg96kv3e2cq1S96SRBsitGT31oTtF5r7VwAL7XA=";
    };

    build-system = [
      setuptools
      wheel
    ];

    doCheck = false;

    propagatedBuildInputs = [
      rich
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-pylib";
    };
  };

  esp-idf-sbom = buildPythonPackage rec {
    pname = "esp-idf-sbom";
    version = "1.4.0";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "esp_idf_sbom";
      sha256 = "sha256-V4kjwdWPflxDJ4BhHQVasWPGQimpGhCAe6wAv7YIyEQ=";
    };

    build-system = [
      setuptools
    ];

    doCheck = false;

    propagatedBuildInputs = [
      pyyaml
      schema
      license-expression
      rich
      pyparsing
      esp-pylib
      click
      rich-click
    ];

    meta = {
      homepage = "https://github.com/espressif/esp-idf-sbom";
    };
  };

  idf-drivers-gdb = buildPythonPackage rec {
    pname = "idf-drivers-gdb";
    version = "0.1.1";
    pyproject = true;

    src = fetchPypi {
      inherit version;
      pname = "idf_drivers_gdb";
      sha256 = "sha256-3Jct+5sQawuIO0G7+MPtnL7oqXNnx17uq3csVzyEVcA=";
    };

    build-system = [
      setuptools
    ];

    doCheck = false;

    meta = {
      homepage = "https://pypi.org/project/idf-drivers-gdb/";
    };
  };
}
