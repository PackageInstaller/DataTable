-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sroleupdatebreaklv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRoleUpdateBreakLv = dataclass("SRoleUpdateBreakLv", require("framework.net.protocol"))
SRoleUpdateBreakLv.ProtocolType = 1017
SRoleUpdateBreakLv.MaxSize = 65535
SRoleUpdateBreakLv.roleId = 0
SRoleUpdateBreakLv.breakLv = 0
SRoleUpdateBreakLv.gainSkin = 0
SRoleUpdateBreakLv.breakType = 0
SRoleUpdateBreakLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRoleUpdateBreakLv
  ((SRoleUpdateBreakLv.super).Ctor)(self, client)
  self.passiveskill = {}
end

SRoleUpdateBreakLv.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.breakLv) then
    return false
  end
  local length = (table.slen)(self.passiveskill)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.passiveskill)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.gainSkin) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.breakType) then
    return false
  end
  return true
end

SRoleUpdateBreakLv.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.passiveskill)[i] = ((require("protocols.bean.protocol.login.passiveskill")).Create)()
    if not ((self.passiveskill)[i]):Unmarshal(buffer) then
      return false
    end
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

return SRoleUpdateBreakLv

