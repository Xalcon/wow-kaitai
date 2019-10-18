meta:
  id: blp
  file-extension: blp
  endian: le
seq:
  - id: header
    type: header
  - id: ofs_mipmaps
    type: u4
    repeat: expr
    repeat-expr: 16
  - id: ofs_sizes
    type: u4
    repeat: expr
    repeat-expr: 16
  - id: color_palette
    type: u4
    repeat: expr
    repeat-expr: 256
  - id: mipmaps
    type: mipmap(_index)
    repeat: expr
    repeat-expr: 16
types:
  header:
    seq:
      - id: magic
        contents: BLP2
      - id: version
        type: u4
        enum: format_version
      - id: color_encoding
        type: u1
        enum: color_encoding
      - id: alpha_depth
        type: u1
      - id: alpha_encoding
        type: u1
        enum: alpha_encoding
      - id: has_mipmaps
        type: u1
      - id: width
        type: u4
      - id: height
        type: u4
  mipmap:
    params:
      - id: i
        type: u4
    instances:
      data:
        pos: _root.ofs_mipmaps[i]
        size: _root.ofs_sizes[i]
enums:
  format_version:
    0: jpeg_compression
    1: uncompressed_or_dxt
  color_encoding:
    0: jpeg
    1: use_palette
    2: compressed_dxt
    3: color_argb8888
    4: color_argb8888_dup # same decompression, likely other PIXEL_FORMAT
  alpha_encoding:
    0: pixel_dxt1
    1: pixel_dxt3
    2: pixel_argb8888
    3: pixel_argb1555
    4: pixel_argb4444
    5: pixel_rgb565
    6: pixel_a8
    7: pixel_dxt5
    8: unspecified
    9: pixel_argb2565
    11: pixel_bc5_unorm
