-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopensidequestpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenSideQuestPanel = dataclass("SOpenSideQuestPanel", require("framework.net.protocol"))
SOpenSideQuestPanel.ProtocolType = 2422
SOpenSideQuestPanel.MaxSize = 65536
SOpenSideQuestPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenSideQuestPanel
  ((SOpenSideQuestPanel.super).Ctor)(self, client)
  self.dungeons = {}
end

SOpenSideQuestPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.dungeons)) then
    return false
  end
  for key,value in pairs(self.dungeons) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not value:Marshal(R9_PC18) then
      return false
    end
  end
  return true
end

SOpenSideQuestPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC31: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.dungeons)[key] = value
  end
  return ret
end

return SOpenSideQuestPanel

