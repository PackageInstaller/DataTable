-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/sql/luasqlprotocalmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local localProtols = require("localprotocols.protocols")
local LuaSqlProtocalManager = strictclass("LuaSqlProtocalManager")
LuaSqlProtocalManager.Ctor = function(self, p1, p2)
  -- function num : 0_0
  self._writePipe = p1
  self._readPipe = p2
end

LuaSqlProtocalManager.Init = function(self, p1, p2)
  -- function num : 0_1
  self._writePipe = p1
  self._readPipe = p2
end

LuaSqlProtocalManager.SendProtocolToRemoteThread = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  local luaValue = {}
  luaValue.ProtocolType = protocol.ProtocolType
  luaValue.data = {}
  protocol:Marshal(luaValue.data)
  ;
  (threadsafepipe.write)(self._writePipe, luaValue)
end

LuaSqlProtocalManager.Update = function(self, bBlock)
  -- function num : 0_3 , upvalues : _ENV, localProtols
  if not self._readPipe then
    return false
  end
  local ret, luaValue = 0, nil
  if bBlock and not (((CS.PixelNeko).LuaManager).IsUnityEditor)() then
    ret = (threadsafepipe.read)(self._readPipe)
  else
    -- DECOMPILER ERROR at PC27: Overwrote pending register: R3 in 'AssignReg'

    ret = (threadsafepipe.tryread)(self._readPipe)
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
        local protocol = ((require("localprotocols.process." .. localProtols[luaValue.ProtocolType])).Create)()
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
  do
    return true
  end
end

return LuaSqlProtocalManager

