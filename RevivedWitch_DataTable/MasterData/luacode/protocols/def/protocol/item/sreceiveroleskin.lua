-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sreceiveroleskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveRoleSkin = dataclass("SReceiveRoleSkin", require("framework.net.protocol"))
SReceiveRoleSkin.ProtocolType = 1251
SReceiveRoleSkin.MaxSize = 65535
SReceiveRoleSkin.roleId = 0
SReceiveRoleSkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveRoleSkin, _ENV
  ((SReceiveRoleSkin.super).Ctor)(self, client)
  self.skins = ((require("protocols.bean.protocol.item.beans.skininfo")).Create)()
end

SReceiveRoleSkin.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (self.skins):Marshal(buffer) then
    return false
  end
  return true
end

SReceiveRoleSkin.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.skins):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SReceiveRoleSkin

