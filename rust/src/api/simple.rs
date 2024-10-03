use caesium::{
    CSParameters, ChromaSubsampling, GifParameters, JpegParameters, PngParameters, TiffParameters,
    WebPParameters,
};

/// Compresses an image file, accepts jpeg, png, gif, webp, and tiff
///
/// # Arguments
///
/// * `input_path` - Image file input path
/// * `output_path` - Output file path (must be put in an existing directory)
/// * `quality` - Compression quality
/// * `png_optimization_level` -  if optimization is true will set the level of oxipng optimization, from 1 to 6. Default 3.
/// * `keep_metadata` - Keep metadata or discard
/// * `optimize` - Optimize image size, don't use for webp, the format is tricky
/// * `max_output_size` - (Optional) Maximum output size in bytes
pub fn compress(
    input_path: String,
    output_path: String,
    quality: u32,
    png_optimization_level: u8,
    keep_metadata: bool,
    optimize: bool,
    max_output_size: Option<usize>,
) -> Result<(), String> {
    let jpeg = JpegParameters {
        quality,
        chroma_subsampling: ChromaSubsampling::Auto,
    };
    let png = PngParameters {
        quality,
        force_zopfli: false,
        optimization_level: png_optimization_level,
    };
    let gif = GifParameters { quality };
    let webp = WebPParameters { quality };
    let tiff = TiffParameters {
        algorithm: caesium::TiffCompression::Deflate,
        deflate_level: tiff::encoder::compression::DeflateLevel::Balanced,
    };
    let mut parameters = CSParameters {
        jpeg,
        png,
        gif,
        webp,
        tiff,
        keep_metadata,
        optimize,
        width: 0,
        height: 0,
        output_size: 0,
    };

    let res = if max_output_size.is_some() {
        caesium::compress_to_size(
            input_path,
            output_path,
            &mut parameters,
            max_output_size.unwrap(),
            false,
        )
    } else {
        caesium::compress(input_path, output_path, &parameters)
    };
    match res {
        Ok(_) => Ok(()),
        Err(e) => Err(e.to_string()),
    }
}
