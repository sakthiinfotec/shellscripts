# --------- Server side -----------
import gzip
from io import BytesIO as IO

from flask import make_response

def gzip_encode(data):
    gzip_buffer = IO()
    gzip_file = gzip.GzipFile(mode='wb', fileobj=gzip_buffer)
    gzip_file.write(json.dumps(data).encode())
    gzip_file.close()
    return gzip_buffer.getvalue()

def gzipped_resp():
    data = {"name":"Flask Framework"}
    gzip_data = gzip_encode(data)    
    resp = make_response(gzip_data)
    resp.headers['content-encoding'] = 'gzip'
    resp.headers['content-length'] = str(len(gzip_data))
    return resp


# -------- Client side -----------
import gzip
import json

# gzip_dat = ??
data = json.loads(gzip.decompress(gzip_data).decode())
