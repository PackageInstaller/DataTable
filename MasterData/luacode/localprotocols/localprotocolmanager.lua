-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/localprotocolmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LocalProtocolManager = {}
LocalProtocolManager.CreateProtocol = function(protocolName)
  -- function num : 0_0 , upvalues : _ENV
  return ((require("localprotocols.process." .. protocolName)).Create)()
end

LocalProtocolManager.GetProtocolDef = function(protocolName)
  -- function num : 0_1 , upvalues : _ENV
  return require("localprotocols.process." .. protocolName)
end

LocalProtocolManager.CreateBean = function(beanName)
  -- function num : 0_2 , upvalues : _ENV
  return ((require("localprotocols.bean." .. beanName)).Create)()
end

LocalProtocolManager.GetBeanDef = function(beanName)
  -- function num : 0_3 , upvalues : _ENV
  return require("localprotocols.bean." .. beanName)
end

return LocalProtocolManager

