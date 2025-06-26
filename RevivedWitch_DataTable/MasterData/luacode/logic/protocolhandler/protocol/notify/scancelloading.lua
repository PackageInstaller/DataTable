-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/notify/scancelloading.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Protocols = require("protocols.protocols")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, Protocols
  LogInfoFormat("SCancelLoading", "-- protocolType = %s, protocolName = %s --", protocol.protocolType, Protocols[protocol.protocolType])
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

