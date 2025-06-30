-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/mail/operateresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local OperateResult = dataclass("OperateResult")
OperateResult.uniqueId = 0
OperateResult.result = 0
OperateResult.Ctor = function(self)
  -- function num : 0_0
end

OperateResult.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.result) then
    return false
  end
  return true
end

OperateResult.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return OperateResult

