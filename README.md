
# Dev Environment Setup

- download Win10 ISO from MSDN
- create keys.json
```
   1   │ [
   2   │   {
   3   │     "Product": "Windows Server 2016",
   4   │     "Key": "..."
   5   │   },
   6   │   {
   7   │     "Product": "Windows Server 2012 R2",
   8   │     "Key": "..."
   9   │   },
  10   │   {
  11   │     "Product": "Windows 10 Pro",
  12   │     "Key": "..."
  13   │   }
  14   │ ]
```
- run packer_build.sh to create vagrant box file
- edit Vagrantfile with appropriate chocolatey installations
- `vagrant up`
