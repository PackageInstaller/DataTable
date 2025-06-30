-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceiveforesightact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveForesightAct = dataclass("CReceiveForesightAct", require("framework.net.protocol"))
CReceiveForesightAct.ProtocolType = 2657
CReceiveForesightAct.MaxSize = 65535
CReceiveForesightAct.activityId = 0
CReceiveForesightAct.dayNum = 0
CReceiveForesightAct.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveForesightAct
  ((CReceiveForesightAct.super).Ctor)(self, client)
end

CReceiveForesightAct.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dayNum) then
    return false
  end
  return true
end

CReceiveForesightAct.Unmarshal = function(self, buffer)
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
  return ret
end

return CReceiveForesightAct

