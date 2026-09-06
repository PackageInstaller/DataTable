local SChangeEntityHpCellVisible = dataclass("SChangeEntityHpCellVisible")
SChangeEntityHpCellVisible.ProtocolType = 35
SChangeEntityHpCellVisible.entityid = 0
SChangeEntityHpCellVisible.visible = 0
SChangeEntityHpCellVisible.spritevisible = 0

function SChangeEntityHpCellVisible:Ctor(client)
end

function SChangeEntityHpCellVisible:Marshal(data)
  data.entityid = self.entityid
  data.visible = self.visible
  data.spritevisible = self.spritevisible
end

function SChangeEntityHpCellVisible:Unmarshal(data)
  self.entityid = data.entityid
  self.visible = data.visible
  self.spritevisible = data.spritevisible
  return true
end

function SChangeEntityHpCellVisible:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.visible) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.visible) = %s. number required.", type(self.visible))
    return false
  end
  if type(self.spritevisible) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.spritevisible) = %s. number required.", type(self.spritevisible))
    return false
  end
  return true
end

return SChangeEntityHpCellVisible
