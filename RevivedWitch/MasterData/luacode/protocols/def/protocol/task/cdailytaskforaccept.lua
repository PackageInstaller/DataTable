-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cdailytaskforaccept.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDailyTaskForAccept = dataclass("CDailyTaskForAccept", require("framework.net.protocol"))
CDailyTaskForAccept.ProtocolType = 1615
CDailyTaskForAccept.MaxSize = 65535
CDailyTaskForAccept.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDailyTaskForAccept
  ((CDailyTaskForAccept.super).Ctor)(self, client)
end

CDailyTaskForAccept.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CDailyTaskForAccept.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CDailyTaskForAccept

