local TrapRef = require("logic.scene.scenerefs.trapref")
local InstanceTrapRef = class("InstanceTrapRef", TrapRef)

function InstanceTrapRef:CollectEnemies()
  self.enemies = {}
  local enemy_root = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "Enemy")
  if not enemy_root then
    return
  end
  local objects = CS.PixelNeko.P1.Scene.TrapHelper.GetObjectsWithID(enemy_root)
  local recorder = BeanManager.GetTableByName("dungeonbattle.cdungeonbattleconfig")
  for object, id in pairs(objects) do
    local record = recorder:GetRecorder(id)
    self.enemies[id] = {
      cfgid = id,
      object = object,
      cfg = record
    }
  end
end

return InstanceTrapRef
