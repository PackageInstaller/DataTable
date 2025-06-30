-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/statefulsceneobject.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StatefulSceneObject = class("StatefulSceneObject")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local PathResolver = require("logic.scene.pathresolver")
StatefulSceneObject.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : _ENV
  self._cfgid = id
  self._path = (string.gsub)("[sso $d]", "%$d", id)
  self._underlyingpath = (string.gsub)("[sceneobject $d]", "%$d", id)
  self._state = -1
end

StatefulSceneObject.Destroy = function(self)
  -- function num : 0_1
  if ((self._state == 0 and self._state ~= 1) or self._state == 2) then
  end
end

StatefulSceneObject.GetID = function(self)
  -- function num : 0_2
  return self._cfgid
end

StatefulSceneObject.ToState = function(self, id)
  -- function num : 0_3
  self._state = id
  return self:OnStateChange()
end

StatefulSceneObject.OnStateChange = function(self)
  -- function num : 0_4 , upvalues : _ENV, UIInteraction, PathResolver
  if self._state == 0 then
    local root = (EffectFactory.CreateComposedEffect)()
    root:AddEffect((EffectFactory.CreateVisualEffect)(self._path, false))
    root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_0 , upvalues : UIInteraction, self
    (UIInteraction.RemoveSceneInteractiveObj)(self._cfgid)
  end
))
    return root
  else
    do
      if self._state == 1 then
        local root = (EffectFactory.CreateComposedEffect)()
        root:AddEffect((EffectFactory.CreateVisualEffect)(self._path, true))
        root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_1 , upvalues : UIInteraction, self
    (UIInteraction.RemoveSceneInteractiveObj)(self._cfgid)
  end
))
        return root
      else
        do
          if self._state == 2 then
            local root = (EffectFactory.CreateComposedEffect)()
            root:AddEffect((EffectFactory.CreateVisualEffect)(self._path, true))
            root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_2 , upvalues : PathResolver, self, UIInteraction
    local object = (PathResolver.ResolveObject)(self._underlyingpath)
    local success = (UIInteraction.AddSceneInteractiveObj)(object)
    if success and UIInteraction.SetInteractiveData then
      (UIInteraction.SetInteractiveData)(object:GetInteractiveId())
    end
  end
))
            return root
          else
            do
              LogError("sceneobject", "invalid sceneobject state " .. self._state .. " for " .. self._path)
              do return (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_3
  end
) end
            end
          end
        end
      end
    end
  end
end

return StatefulSceneObject

