local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendCommand = dataclass("CSendCommand", require("framework.net.protocol"))
CSendCommand.ProtocolType = 1301
CSendCommand.MaxSize = 65535
CSendCommand.cmd = ""

function CSendCommand:Ctor(client)
  CSendCommand.super.Ctor(self, client)
end

function CSendCommand:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.cmd) then
    return false
  end
  return true
end

function CSendCommand:Unmarshal(buffer)
  local ret = true
  ret, self.cmd = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSendCommand
