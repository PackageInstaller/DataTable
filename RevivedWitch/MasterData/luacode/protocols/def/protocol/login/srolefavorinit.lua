-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/srolefavorinit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleFavorInit = dataclass("SRoleFavorInit", require("framework.net.protocol"))
SRoleFavorInit.ProtocolType = 1018
SRoleFavorInit.MaxSize = 65535
SRoleFavorInit.id = 0
SRoleFavorInit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleFavorInit, _ENV
  ((SRoleFavorInit.super).Ctor)(self, client)
  self.favor = ((require("protocols.bean.protocol.login.favor")).Create)()
end

SRoleFavorInit.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (self.favor):Marshal(buffer) then
    return false
  end
  return true
end

SRoleFavorInit.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.favor):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRoleFavorInit

