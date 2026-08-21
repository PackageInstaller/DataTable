-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cshareactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CShareActivity = dataclass("CShareActivity", require("framework.net.protocol"))
CShareActivity.ProtocolType = 2447
CShareActivity.MaxSize = 65535
CShareActivity.bannerId = 0
CShareActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CShareActivity
  ((CShareActivity.super).Ctor)(self, client)
end

CShareActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bannerId) then
    return false
  end
  return true
end

CShareActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CShareActivity

