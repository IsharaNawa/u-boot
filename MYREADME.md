# U-Boot Build Configuration for Genesys2

## Device Tree Configuration

The U-Boot binary is generated using a specific device tree configuration. You can configure this in two ways:

### Option 1: Modify Existing Config
Edit `configs/genesys2_defconfig` and set the appropriate device tree:
```
CONFIG_DEFAULT_DEVICE_TREE="your-device-tree-name"
```

### Option 2: Create Custom Config
1. Create a new defconfig file in `configs/`
2. Update `setup_genesys2.sh` to reference your custom config file

## Important Notes

- **Confidentiality**: Do not commit device-specific `.dts` or `.dtb` files if they contain proprietary FPGA configurations
- The device tree file specified in the config must exist in `arch/riscv/dts/` or the build will fail
- You can add FPGA-specific parameters and configurations to your custom device tree

## Current Setup

The build script `setup_genesys2.sh` uses:
- **Config file**: `genesys2_defconfig`
- **Cross-compiler**: `riscv64-linux-gnu-`
- **Build directory**: `~/Research/repos/u-boot`

## Build Outputs

After running `./setup_genesys2.sh`, the following files are generated:
- `u-boot.bin` - Main binary for flashing (most commonly used)
- `u-boot` - ELF executable with debug symbols
- `u-boot.map` - Symbol/memory map
- Other format variants (`.srec`, `.sym`, etc.)
