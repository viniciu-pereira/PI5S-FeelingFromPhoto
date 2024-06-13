from transformers import pipeline


def detect_emotions(image_pil):
    """
    Detects emotions from a PIL Image object.

    Args:
      image_pil: The PIL Image object.

    Returns:
      The predicted emotion label or None if processing fails.
    """
    try:
        pipe = pipeline(
            "image-classification", model="dima806/facial_emotions_image_detection"
        )
        results = pipe(image_pil)
        print(f"Results: {results}")
        return results
    except Exception as e:
        print(f"Error processing image: {e}")
        return None
