local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local ObjectVisualEffect = class("ObjectVisualEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")

function ObjectVisualEffect:Ctor(path, isShow)
  self._path = path
  self._show = isShow
end

function ObjectVisualEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object, type = PathResolver.ResolveObject(self._path)
  if type == PathResolver.ObjectType.Portal then
    if self._show then
      object:Init()
      object:Activate()
    else
      object:RemoveMiniMapImg()
      object:Deactivate()
    end
    object:GetObject():SetActive(self._show)
  elseif type == PathResolver.ObjectType.SceneObject then
    object:GetObj():SetActive(self._show)
  else
    local gameobject = PathResolver.Resolve(self._path) or self._object
    if not gameobject then
      LogError("ObjectVisualEffect", "path " .. self._path .. " not found")
    end
    gameobject:SetActive(self._show)
  end
end

function ObjectVisualEffect:Bind(object)
  self._object = object
end

return ObjectVisualEffect
