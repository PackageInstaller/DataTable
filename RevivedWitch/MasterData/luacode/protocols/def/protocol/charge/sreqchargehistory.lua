-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/sreqchargehistory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReqChargeHistory = dataclass("SReqChargeHistory", require("framework.net.protocol"))
SReqChargeHistory.ProtocolType = 3904
SReqChargeHistory.MaxSize = 65535
SReqChargeHistory.page = 0
SReqChargeHistory.totalpage = 0
SReqChargeHistory.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReqChargeHistory
  ((SReqChargeHistory.super).Ctor)(self, client)
  self.historyList = {}
end

SReqChargeHistory.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.page) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalpage) then
    return false
  end
  local length = (table.slen)(self.historyList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.historyList)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SReqChargeHistory.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.historyList)[i] = ((require("protocols.bean.goodhistoryinfo")).Create)()
    if not ((self.historyList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReqChargeHistory

