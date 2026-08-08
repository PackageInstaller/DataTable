local dcompress = require "dcompress"


dcompress.openZip()
local compressed = dcompress.gzc("hahaaa")
print(dcompress.gzd(compressed))
dcompress.close()
