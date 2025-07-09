import chardet

def detect_encoding(file_path):
    '''
    detect the encoding of a text file
    '''
    with open(file_path, 'rb') as f:
        raw_data = f.read()
    result = chardet.detect(raw_data)
    return result['encoding'], result['confidence']