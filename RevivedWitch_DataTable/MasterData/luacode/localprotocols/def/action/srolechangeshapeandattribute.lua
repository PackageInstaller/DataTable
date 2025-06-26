-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/srolechangeshapeandattribute.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleChangeShapeAndAttribute = dataclass("SRoleChangeShapeAndAttribute")
SRoleChangeShapeAndAttribute.ProtocolType = 23
SRoleChangeShapeAndAttribute.entityid = 0
SRoleChangeShapeAndAttribute.shapeid = 0
SRoleChangeShapeAndAttribute.assetBundleName = ""
SRoleChangeShapeAndAttribute.prefabName = ""
SRoleChangeShapeAndAttribute.Ctor = function(self, client)
  -- function num : 0_0
end

SRoleChangeShapeAndAttribute.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.shapeid = self.shapeid
  data.assetBundleName = self.assetBundleName
  data.prefabName = self.prefabName
end

SRoleChangeShapeAndAttribute.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.shapeid = data.shapeid
  self.assetBundleName = data.assetBundleName
  self.prefabName = data.prefabName
  return true
end

SRoleChangeShapeAndAttribute.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.shapeid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.shapeid) = %s. number required.", type(self.shapeid))
    return false
  end
  if type(self.assetBundleName) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.assetBundleName) = %s. string required.", type(self.assetBundleName))
    return false
  end
  if type(self.prefabName) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.prefabName) = %s. string required.", type(self.prefabName))
    return false
  end
  return true
end

return SRoleChangeShapeAndAttribute

