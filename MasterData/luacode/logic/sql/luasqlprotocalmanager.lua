local localProtols = require("localprotocols.protocols")
local LuaSqlProtocalManager = strictclass("LuaSqlProtocalManager")

function LuaSqlProtocalManager:Ctor(p1, p2)
  self._writePipe = p1
  self._readPipe = p2
end

function LuaSqlProtocalManager:Init(p1, p2)
  self._writePipe = p1
  self._readPipe = p2
end

function LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
  local luaValue = {}
  luaValue.ProtocolType = protocol.ProtocolType
  luaValue.data = {}
  protocol:Marshal(luaValue.data)
  threadsafepipe.write(self._writePipe, luaValue)
end

function LuaSqlProtocalManager:Update(bBlock)
  if not self._readPipe then
    return false
  end
  local ret, luaValue = 0
  if bBlock and not CS.PixelNeko.LuaManager.IsUnityEditor() then
    ret, luaValue = threadsafepipe.read(self._readPipe)
  else
    ret, luaValue = threadsafepipe.tryread(self._readPipe)
  end
  if ret == 1 then
    if ret == 1 and type(luaValue) == "string" and luaValue == "exit" then
      return "exit"
    end
    if type(luaValue) == "table" and luaValue.ProtocolType then
      if not localProtols[luaValue.ProtocolType] then
        LogErrorFormat("LuaSqlThread", "protocol not define! type = %s", luaValue.ProtocolType)
        return false
      else
        local protocol = require("localprotocols.process." .. localProtols[luaValue.ProtocolType]).Create()
        ret = protocol:Unmarshal(luaValue.data)
        if not ret then
          LogErrorFormat("LuaSqlThread", "localprotocol unmarshal error! type = %s", tostring(luaValue.ProtocolType))
          return false
        else
          protocol:Process()
        end
      end
    end
  end
  return true
end

return LuaSqlProtocalManager
