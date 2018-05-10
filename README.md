# readw-dockerized

This is a dockerized version of [ReAdW](https://github.com/PedrioliLab/ReAdW) for use in the [Cravatt lab](https://scripps.edu/cravatt). This allows us to convert .RAW files collected from Thermo mass spectrometers to .mzXMLs for downstream analysis. ReAdW was designed for use in Windows but this project makes it available on Linux through the use of Docker and wine.


## Use

```bash
docker run --rm -v path_to_raw_files:/raw -v $PWD/output:/output radusuciu/readw-dockerized /raw/experiment_123
```

The last argument above can be a folder containing `.raw` files, or it can be a `.raw` file itself. You may specify multiple `.raw` files, or folders by just adding more arguments. Matching for the `.raw` extension is case insensitive as some machines output `.RAW` files by default.

Output files will be placed in the output directory of your choice. You can change the second mount above to that effect.


## Installation Requirements

Docker is required to build and run this image. Additionally, the following .dll files must be obtained from a licensed install of Xcalibur:

- `fileio.dll`
- `fregistry.dll`
- `XRawfile2.dll`
- `zlib1.dll`

These must be placed in the `readw` folder. After that you can simply `docker build .` to build the image. 


## Useful Links:

- https://github.com/PedrioliLab/docker-readw
- https://github.com/PedrioliLab/ReAdW
- http://proteomicsresource.washington.edu/protocols06/wine/
