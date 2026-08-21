
local _M = class("XipuFrogWrapSdk", require "XipuWrapSdkBase")
local cjson = require("cjson")

function _M:ctor()
    self.super.ctor(self)
end

function _M:getChannel()
    return GE.Channel.Channel_Xipu_Abroad
end

return _M