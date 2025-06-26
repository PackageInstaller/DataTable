-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbookactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBookActivity = dataclass("SBookActivity", require("framework.net.protocol"))
SBookActivity.ProtocolType = 2428
SBookActivity.MaxSize = 65535
SBookActivity.isOpen = 0
SBookActivity.itemId = 0
SBookActivity.itemNum = 0
SBookActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBookActivity
  ((SBookActivity.super).Ctor)(self, client)
end

SBookActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.isOpen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemNum) then
    return false
  end
  return true
end

SBookActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBookActivity

