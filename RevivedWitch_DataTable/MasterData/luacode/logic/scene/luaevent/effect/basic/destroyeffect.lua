-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/destroyeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DestroyEffect = class("DestroyEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
DestroyEffect.Ctor = function(self, path)
  -- function num : 0_0
  self._path = path
end

DestroyEffect.Run = function(self)
  -- function num : 0_1 , upvalues : _ENV, PathResolver, UIInteraction
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local object, type = (PathResolver.ResolveObject)(self._path)
  if type == (PathResolver.ObjectType).SceneObject then
    (object:GetObj()):SetActive(false)
    ;
    (UIInteraction.RemoveSceneInteractiveObj)(object:GetInteractiveId())
  else
    if type == (PathResolver.ObjectType).Switch then
      (object:GetObject()):SetActive(false)
      ;
      (SwitchManager.RemoveSwitch)(object:GetInstanceID(), object:GetID())
    else
      if type == (PathResolver.ObjectType).Trap then
        (object:GetObject()):SetActive(false)
        ;
        (TrapManager.RemoveTrap)(object:GetInstanceID(), object:GetID())
      else
      end
    end
  end
  if type ~= (PathResolver.ObjectType).NPC or type == (PathResolver.ObjectType).Portal then
    (object:GetObject()):SetActive(false)
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller and controller.RemovePortal then
      controller:RemovePortal(object:GetID())
    end
  else
    do
      if not type then
        object = (PathResolver.Resolve)(self._path)
        object:SetActive(false)
      end
    end
  end
end

return DestroyEffect

