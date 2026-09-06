local StatefulSceneObject = class("StatefulSceneObject")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local PathResolver = require("logic.scene.pathresolver")

function StatefulSceneObject:Ctor(id)
  self._cfgid = id
  self._path = string.gsub("[sso $d]", "%$d", id)
  self._underlyingpath = string.gsub("[sceneobject $d]", "%$d", id)
  self._state = -1
end

function StatefulSceneObject:Destroy()
  if self._state == 0 then
  elseif self._state == 1 then
  elseif self._state == 2 then
  end
end

function StatefulSceneObject:GetID()
  return self._cfgid
end

function StatefulSceneObject:ToState(id)
  self._state = id
  return self:OnStateChange()
end

function StatefulSceneObject:OnStateChange()
  if self._state == 0 then
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(EffectFactory.CreateVisualEffect(self._path, false))
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      UIInteraction.RemoveSceneInteractiveObj(self._cfgid)
    end))
    return root
  elseif self._state == 1 then
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(EffectFactory.CreateVisualEffect(self._path, true))
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      UIInteraction.RemoveSceneInteractiveObj(self._cfgid)
    end))
    return root
  elseif self._state == 2 then
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(EffectFactory.CreateVisualEffect(self._path, true))
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      local object = PathResolver.ResolveObject(self._underlyingpath)
      local success = UIInteraction.AddSceneInteractiveObj(object)
      if success and UIInteraction.SetInteractiveData then
        UIInteraction.SetInteractiveData(object:GetInteractiveId())
      end
    end))
    return root
  else
    LogError("sceneobject", "invalid sceneobject state " .. self._state .. " for " .. self._path)
    return EffectFactory.CreateCustomEffect(function()
    end)
  end
end

return StatefulSceneObject
