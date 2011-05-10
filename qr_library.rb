#!/usr/bin/env ruby

#--
# Copyright 2008 by Matthew Roper (mlroper@gmail.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++
require 'RMagick'
class QRImage < Magick::Image
  
  BLACK = 0
  WHITE = 65535
  
  #
  # Creates a new QR Code image that represents the passed 
  # RQRCode::QRCode instance.
  # 
  # Example:
  # 
  #   # qr - instance of RQRCode::QRCode
  #   img = QRImage.new(qr, 3)
  #    
  def initialize(qr)
    @qr = qr
    height = qr.module_count
    super(height, height)
    self.import_pixels(0, 0, height, height, "I", get_pixmap, 
      Magick::CharPixel)
    self.format = 'png'
  end
  
  private
  
  #  
  #  Create an indexed array of black and white pixels that 
  #  correspond to the associated QR Code matrix.
  #
  def get_pixmap()
    pixel_map = Array.new

    for row in 0...@qr.module_count do
      pixel_map.concat(get_pixel_row(row))
    end    

    return pixel_map
  end
  
  #
  # Returns an indexed array of black/white pixels for this +row+.
  #
  def get_pixel_row(row)
    pixel_row = Array.new(@qr.module_count)
    pixel_count = 0
    
    for col in 0...@qr.module_count do
      pixel_row[pixel_count] = (@qr.is_dark(row, col) ? BLACK : WHITE)
      pixel_count = pixel_count + 1
    end
    
    return pixel_row
    
  end
  
end
