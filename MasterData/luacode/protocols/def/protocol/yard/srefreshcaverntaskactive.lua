-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshcaverntaskactive.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshCavernTaskActive = dataclass("SRefreshCavernTaskActive", require("framework.net.protocol"))
SRefreshCavernTaskActive.ProtocolType = 2348
SRefreshCavernTaskActive.MaxSize = 65535
SRefreshCavernTaskActive.nums = 0
SRefreshCavernTaskActive.leftRefreshTime = 0
SRefreshCavernTaskActive.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshCavernTaskActive, _ENV
  ((SRefreshCavernTaskActive.super).Ctor)(self, client)
  self.cavernTask = ((require("protocols.bean.protocol.yard.caverntask")).Create)()
end

SRefreshCavernTaskActive.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nums) then
    return false
  end
  if not (self.cavernTask):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftRefreshTime) then
    return false
  end
  return true
end

SRefreshCavernTaskActive.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.cavernTask):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshCavernTaskActive

