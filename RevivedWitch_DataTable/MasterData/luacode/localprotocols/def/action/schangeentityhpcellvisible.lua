-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/schangeentityhpcellvisible.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeEntityHpCellVisible = dataclass("SChangeEntityHpCellVisible")
SChangeEntityHpCellVisible.ProtocolType = 35
SChangeEntityHpCellVisible.entityid = 0
SChangeEntityHpCellVisible.visible = 0
SChangeEntityHpCellVisible.spritevisible = 0
SChangeEntityHpCellVisible.Ctor = function(self, client)
  -- function num : 0_0
end

SChangeEntityHpCellVisible.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.visible = self.visible
  data.spritevisible = self.spritevisible
end

SChangeEntityHpCellVisible.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.visible = data.visible
  self.spritevisible = data.spritevisible
  return true
end

SChangeEntityHpCellVisible.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
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

