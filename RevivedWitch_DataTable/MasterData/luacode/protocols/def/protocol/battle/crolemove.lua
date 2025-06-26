-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/crolemove.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRoleMove = dataclass("CRoleMove", require("framework.net.protocol"))
CRoleMove.ProtocolType = 1900
CRoleMove.MaxSize = 65535
CRoleMove.sceneid = 0
CRoleMove.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRoleMove, _ENV
  ((CRoleMove.super).Ctor)(self, client)
  self.position = ((require("protocols.bean.protocol.battle.point")).Create)()
end

CRoleMove.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sceneid) then
    return false
  end
  if not (self.position):Marshal(buffer) then
    return false
  end
  return true
end

CRoleMove.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.position):Unmarshal(buffer) then
    return false
  end
  return ret
end

return CRoleMove

