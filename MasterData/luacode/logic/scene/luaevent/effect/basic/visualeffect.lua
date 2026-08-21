-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/visualeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ObjectVisualEffect = class("ObjectVisualEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
ObjectVisualEffect.Ctor = function(self, path, isShow)
  -- function num : 0_0
  self._path = path
  self._show = isShow
end

ObjectVisualEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local object, type = (PathResolver.ResolveObject)(self._path)
  if type == (PathResolver.ObjectType).Portal then
    if self._show then
      object:Init()
      object:Activate()
    else
      object:RemoveMiniMapImg()
      object:Deactivate()
    end
    ;
    (object:GetObject()):SetActive(self._show)
  else
    if type == (PathResolver.ObjectType).SceneObject then
      (object:GetObj()):SetActive(self._show)
    else
      if not (PathResolver.Resolve)(self._path) then
        local gameobject = self._object
      end
      if not gameobject then
        LogError("ObjectVisualEffect", "path " .. self._path .. " not found")
      end
      gameobject:SetActive(self._show)
    end
  end
end

ObjectVisualEffect.Bind = function(self, object)
  -- function num : 0_2
  self._object = object
end

return ObjectVisualEffect

