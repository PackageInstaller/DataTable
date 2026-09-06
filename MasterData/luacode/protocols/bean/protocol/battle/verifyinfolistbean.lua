local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local VerifyInfoListBean = dataclass("VerifyInfoListBean")

function VerifyInfoListBean:Ctor()
  self.beanList = {}
end

function VerifyInfoListBean:Marshal(buffer)
  local length = table.slen(self.beanList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.beanList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function VerifyInfoListBean:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.beanList[i] = require("protocols.bean.protocol.battle.battleverifyinfo").Create()
    if not self.beanList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return VerifyInfoListBean
