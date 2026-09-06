local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReqChargeHistory = dataclass("SReqChargeHistory", require("framework.net.protocol"))
SReqChargeHistory.ProtocolType = 3904
SReqChargeHistory.MaxSize = 65535
SReqChargeHistory.page = 0
SReqChargeHistory.totalpage = 0

function SReqChargeHistory:Ctor(client)
  SReqChargeHistory.super.Ctor(self, client)
  self.historyList = {}
end

function SReqChargeHistory:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.page) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalpage) then
    return false
  end
  local length = table.slen(self.historyList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.historyList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SReqChargeHistory:Unmarshal(buffer)
  local ret = true
  ret, self.page = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalpage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.historyList[i] = require("protocols.bean.goodhistoryinfo").Create()
    if not self.historyList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReqChargeHistory
