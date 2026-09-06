local SceneRef = require("logic.scene.scenerefs.sceneref")
local TopDownRef = class("TopDownRef", SceneRef)

function TopDownRef:Init()
  TopDownRef.super.Init(self)
  local transform = self._rootGameObject.transform
  self.actor = {
    object = transform:Find("Actor").gameObject,
    animator = transform:Find("Actor").gameObject:GetComponent("Animator")
  }
  self.builder = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "Builder")
  self:CollectEnemies()
end

function TopDownRef:GetSceneControllerName()
  return "logic.scene.firstscenetopdown.topdowncontroller"
end

function TopDownRef:CollectEnemies()
  self.enemies = {}
  local enemy_root = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._rootGameObject, "Enemy")
  if not enemy_root then
    return
  end
  local objects = CS.PixelNeko.P1.Scene.TrapHelper.GetObjectsWithID(enemy_root)
  local recorder = BeanManager.GetTableByName("dungeonbattle.cdungeonbattleconfig")
  for object, id in pairs(objects) do
    local record = recorder:GetRecorder(id)
    self.enemies[#self.enemies + 1] = {
      cfgid = id,
      object = object,
      cfg = record
    }
  end
end

return TopDownRef
