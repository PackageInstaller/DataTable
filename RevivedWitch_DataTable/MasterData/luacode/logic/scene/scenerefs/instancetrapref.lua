-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/instancetrapref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TrapRef = require("logic.scene.scenerefs.trapref")
local InstanceTrapRef = class("InstanceTrapRef", TrapRef)
InstanceTrapRef.CollectEnemies = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.enemies = {}
  local enemy_root = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Enemy")
  if not enemy_root then
    return 
  end
  local objects = (((((CS.PixelNeko).P1).Scene).TrapHelper).GetObjectsWithID)(enemy_root)
  local recorder = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
  for object,id in pairs(objects) do
    local record = recorder:GetRecorder(id)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.enemies)[id] = {cfgid = id, object = object, cfg = record}
  end
end

return InstanceTrapRef

