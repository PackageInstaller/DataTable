local Config = {}
local self = Config
local function GetConfig(self,id)
   if self[id] ==nil then
      package.loaded["Config.SsUnit."..id] = nil
      self[id] = require ("Config.SsUnit."..id)
   end
   return self[id]
end
Config.GetConfig=GetConfig
return Config