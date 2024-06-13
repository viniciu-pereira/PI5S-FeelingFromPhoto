from PIL import Image
from flask import Flask, request, jsonify
from model import detect_emotions


app = Flask(__name__)


@app.route("/detect-emotions", methods=["POST"])
def detect_emotions_endpoint():
    try:
        if "image_file" not in request.files:
            return jsonify({"error": "Missing image file"}), 400

        image_file = request.files["image_file"]
        print(f"Image file: {image_file}")

        if image_file.mimetype not in ["image/jpeg", "image/png"]:
            return (
                jsonify({"error": "Invalid image format. Only JPEG and PNG supported"}),
                400,
            )

        image_data_bytes = image_file.stream

        print("Processing image data..")
        image_pil = Image.open(image_data_bytes)
        emotions = detect_emotions(image_pil)

        print(emotions)
        return jsonify({"emotions": emotions})

    except Exception as e:
        print(e)
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
