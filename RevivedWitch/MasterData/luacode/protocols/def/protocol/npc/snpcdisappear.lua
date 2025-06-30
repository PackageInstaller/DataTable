-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/npc/snpcdisappear.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SNpcDisappear = dataclass("SNpcDisappear", require("framework.net.protocol"))
SNpcDisappear.ProtocolType = 2006
SNpcDisappear.MaxSize = 65535
SNpcDisappear.sceneId = 0
SNpcDisappear.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SNpcDisappear
  ((SNpcDisappear.super).Ctor)(self, client)
  self.npcs = {}
end

SNpcDisappear.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sceneId) then
    return false
  end
  local length = (table.slen)(self.npcs)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.npcs)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SNpcDisappear.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.npcs)[i] = ((require("protocols.bean.protocol.battle.dungeonnpc")).Create)()
    if not ((self.npcs)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SNpcDisappear

