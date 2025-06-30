-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/scointasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCoinTasks = dataclass("SCoinTasks", require("framework.net.protocol"))
SCoinTasks.ProtocolType = 1628
SCoinTasks.MaxSize = 65535
SCoinTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCoinTasks
  ((SCoinTasks.super).Ctor)(self, client)
  self.tasks = {}
end

SCoinTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.tasks)) then
    return false
  end
  for key,value in pairs(self.tasks) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not value:Marshal(R9_PC18) then
      return false
    end
  end
  return true
end

SCoinTasks.Unmarshal = function(self, buffer)
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
    (self.tasks)[key] = value
  end
  return ret
end

return SCoinTasks

