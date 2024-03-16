((inline) @_inline (#lua-match? @_inline "^%s*import"))
((inline) @_inline (#lua-match? @_inline "^%s*export"))
; extends
((inline) @injection.content
  (#lua-match? @injection.content "^%s*import")
  (#set! injection.language "typescript"))
((inline) @injection.content
  (#lua-match? @injection.content "^%s*export")
  (#set! injection.language "typescript"))
