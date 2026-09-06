local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeUserIntroduce = dataclass("SChangeUserIntroduce", require("framework.net.protocol"))
SChangeUserIntroduce.ProtocolType = 2223
SChangeUserIntroduce.MaxSize = 65535
SChangeUserIntroduce.introduce = ""

function SChangeUserIntroduce:Ctor(client)
  SChangeUserIntroduce.super.Ctor(self, client)
end

function SChangeUserIntroduce:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.introduce) then
    return false
  end
  return true
end

function SChangeUserIntroduce:Unmarshal(buffer)
  local ret = true
  ret, self.introduce = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserIntroduce
