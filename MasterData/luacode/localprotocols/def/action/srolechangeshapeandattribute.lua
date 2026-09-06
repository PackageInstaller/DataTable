local SRoleChangeShapeAndAttribute = dataclass("SRoleChangeShapeAndAttribute")
SRoleChangeShapeAndAttribute.ProtocolType = 23
SRoleChangeShapeAndAttribute.entityid = 0
SRoleChangeShapeAndAttribute.shapeid = 0
SRoleChangeShapeAndAttribute.assetBundleName = ""
SRoleChangeShapeAndAttribute.prefabName = ""

function SRoleChangeShapeAndAttribute:Ctor(client)
end

function SRoleChangeShapeAndAttribute:Marshal(data)
  data.entityid = self.entityid
  data.shapeid = self.shapeid
  data.assetBundleName = self.assetBundleName
  data.prefabName = self.prefabName
end

function SRoleChangeShapeAndAttribute:Unmarshal(data)
  self.entityid = data.entityid
  self.shapeid = data.shapeid
  self.assetBundleName = data.assetBundleName
  self.prefabName = data.prefabName
  return true
end

function SRoleChangeShapeAndAttribute:CheckVariable()
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
