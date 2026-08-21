-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sopenbosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenBossPanel = dataclass("SOpenBossPanel", require("framework.net.protocol"))
SOpenBossPanel.ProtocolType = 1951
SOpenBossPanel.MaxSize = 65535
SOpenBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenBossPanel
  ((SOpenBossPanel.super).Ctor)(self, client)
  self.bosses = {}
end

SOpenBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.bosses)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.bosses)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SOpenBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.bosses)[i] = ((require("protocols.bean.protocol.battle.bossbean")).Create)()
    if not ((self.bosses)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBossPanel

