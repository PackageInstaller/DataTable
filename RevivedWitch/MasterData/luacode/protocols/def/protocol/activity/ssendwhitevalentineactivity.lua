-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendwhitevalentineactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendWhiteValentineActivity = dataclass("SSendWhiteValentineActivity", require("framework.net.protocol"))
SSendWhiteValentineActivity.ProtocolType = 2612
SSendWhiteValentineActivity.MaxSize = 65535
SSendWhiteValentineActivity.state = 0
SSendWhiteValentineActivity.id = 0
SSendWhiteValentineActivity.rewardState = 0
SSendWhiteValentineActivity.roleId = 0
SSendWhiteValentineActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendWhiteValentineActivity
  ((SSendWhiteValentineActivity.super).Ctor)(self, client)
end

SSendWhiteValentineActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardState) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

SSendWhiteValentineActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendWhiteValentineActivity

