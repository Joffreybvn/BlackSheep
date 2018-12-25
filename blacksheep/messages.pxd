# cython: language_level=3, embedsignature=True
# Copyright (C) 2018-present Roberto Prevato
#
# This module is part of BlackSheep and is released under
# the MIT License https://opensource.org/licenses/MIT

from .url cimport URL
from .exceptions cimport BadRequestFormat
from .headers cimport HttpHeaders, HttpHeader
from .cookies cimport HttpCookie, parse_cookie, datetime_to_cookie_format
from .contents cimport HttpContent, extract_multipart_form_data_boundary, parse_www_form_urlencoded, parse_multipart_form_data


cdef class HttpMessage:
    cdef public HttpHeaders headers
    cdef readonly HttpContent content
    cdef dict _cookies
    cdef bytearray _raw_body
    cdef public object complete
    cdef object _form_data

    cdef void on_body(self, bytes chunk)
    cpdef void extend_body(self, bytes chunk)
    cpdef void set_content(self, HttpContent content)


cdef class HttpRequest(HttpMessage):
    cdef public bint active
    cdef public dict route_values
    cdef public URL url
    cdef public bytes method
    cdef public str client_ip
    cdef dict __dict__


cdef class HttpResponse(HttpMessage):
    cdef public int status
    cdef public bint active
    cdef dict __dict__

    cpdef bint is_redirect(self)
