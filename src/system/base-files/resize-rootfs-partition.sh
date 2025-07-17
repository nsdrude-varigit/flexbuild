#!/bin/sh
set -eu

# Detect root partition (e.g., /dev/mmcblk1p2)
ROOT_PART=$(findmnt -n -o SOURCE /)

# Extract DISK_BASE and PART_NUM
case "$ROOT_PART" in
    /dev/mmcblk*p*)
        DISK_BASE=$(echo "$ROOT_PART" | sed 's/p[0-9]*$//')
        PART_NUM=$(echo "$ROOT_PART" | sed 's/^.*p\([0-9]*\)$/\1/')
        ;;
    *)
        echo "Unsupported root device format: $ROOT_PART"
        exit 1
        ;;
esac

# Count number of partitions on this disk
PART_COUNT=$(ls "${DISK_BASE}"p* 2>/dev/null | wc -l)

# Only continue if there's exactly one partition
if [ "$PART_COUNT" -ne 1 ]; then
    echo "Disk $DISK_BASE has $PART_COUNT partitions; skipping resize"
    exit 0
fi

# Resize the partition to use 100% of the disk
parted -s "$DISK_BASE" resizepart "$PART_NUM" 100%

# Resize the filesystem (assumes ext4)
resize2fs "$ROOT_PART"
