package net.moocowstudio.modelaircraft.database {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.display.Loader;
    import flash.utils.ByteArray;

    import mx.controls.Image;
    import mx.graphics.ImageSnapshot;
    import mx.utils.Base64Decoder;
    import mx.utils.Base64Encoder;

    public class Helper {
        public function Helper() {
        }

        public static function takeSnapshot(source : IBitmapDrawable) : Bitmap {
            var imageBitmapData : BitmapData = ImageSnapshot.captureBitmapData(source);
            return new Bitmap(imageBitmapData);
        }


        public static function imageToByteArray(image : BitmapData) : ByteArray {
            var binaryImage : ByteArray = new ByteArray();
            var bmpWidth : Number;
            var bmpHeight : Number;
            bmpWidth = image.width;
            bmpHeight = image.height;

            for (var i : uint = 0; i < bmpWidth; i++) {
                for (var j : uint = 0; j < bmpHeight; j++) {
                    binaryImage.writeUnsignedInt(image.getPixel(i, j));
                }
            }
            return binaryImage;
        }

        public static function imageToBase64(source : Image) : String {
            var ba : ByteArray = (Helper.imageToByteArray(Helper.takeSnapshot(source).bitmapData));
            var b64encoder : Base64Encoder = new Base64Encoder();
            b64encoder.encodeBytes(ba);
            var b64String : String = b64encoder.flush();
            return b64String;
        }

        public static function byteArrayToBase64(ba : ByteArray) : String {
            var b64encoder : Base64Encoder = new Base64Encoder();
            b64encoder.encodeBytes(ba);
            var b64String : String = b64encoder.flush();
            return b64String;
        }

        public static function base64ToByteArray(base64String : String) : ByteArray {
            var base64Dec : Base64Decoder;
            var byteArr : ByteArray;
            base64Dec = new Base64Decoder();
            base64Dec.decode(base64String);
            byteArr = base64Dec.toByteArray();
            base64Dec.flush();
            return byteArr;
        }

        public static function byteArrayToImage(byteArray : ByteArray) : BitmapData {
            var loader : Loader = new Loader();
            loader.loadBytes(byteArray);
            var content : * = loader.content;
            var bitmapData : BitmapData = new BitmapData(content.width, content.height);
            bitmapData.draw(content);
            return bitmapData;
        }

    }
}