-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshcaverntask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshCavernTask = dataclass("SRefreshCavernTask", require("framework.net.protocol"))
SRefreshCavernTask.ProtocolType = 2319
SRefreshCavernTask.MaxSize = 65535
SRefreshCavernTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshCavernTask, _ENV
  ((SRefreshCavernTask.super).Ctor)(self, client)
  self.task = ((require("protocols.bean.protocol.yard.caverntask")).Create)()
end

SRefreshCavernTask.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.task):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshCavernTask.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.task):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshCavernTask

