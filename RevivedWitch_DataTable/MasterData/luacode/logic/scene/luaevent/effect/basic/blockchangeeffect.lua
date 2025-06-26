-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/blockchangeeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ObjectBlockEffect = class("ObjectBlockEffect", EffectBase)
ObjectBlockEffect.Ctor = function(self, x, y, w, h, status, gridwidth, gridheight)
  -- function num : 0_0
  self._x = x
  self._y = y
  self._w = w
  self._h = h
  self._status = status
  self._gridwidth = gridwidth or 0.4
  self._gridheight = gridheight or 0.56
end

ObjectBlockEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  for i = self._x, self._x + self._w - 1 do
    for j = self._y, self._y + self._h - 1 do
      if self._status then
        ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddBlockingPoint)((active_controller._sceneRef).builder, i, j, self._gridwidth, self._gridheight)
      else
        ;
        ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).RemoveBlockingPoint)((active_controller._sceneRef).builder, i, j, self._gridwidth, self._gridheight)
      end
    end
  end
end

return ObjectBlockEffect

