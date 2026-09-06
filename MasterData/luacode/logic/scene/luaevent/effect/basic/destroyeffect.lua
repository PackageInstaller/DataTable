local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DestroyEffect = class("DestroyEffect", EffectBase)
local PathResolver = require("logic.scene.pathresolver")
local UIInteraction = require("logic.scene.interaction.uiinteraction")

function DestroyEffect:Ctor(path)
  self._path = path
end

function DestroyEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local object, type = PathResolver.ResolveObject(self._path)
  if type == PathResolver.ObjectType.SceneObject then
    object:GetObj():SetActive(false)
    UIInteraction.RemoveSceneInteractiveObj(object:GetInteractiveId())
  elseif type == PathResolver.ObjectType.Switch then
    object:GetObject():SetActive(false)
    SwitchManager.RemoveSwitch(object:GetInstanceID(), object:GetID())
  elseif type == PathResolver.ObjectType.Trap then
    object:GetObject():SetActive(false)
    TrapManager.RemoveTrap(object:GetInstanceID(), object:GetID())
  elseif type == PathResolver.ObjectType.NPC then
  elseif type == PathResolver.ObjectType.Portal then
    object:GetObject():SetActive(false)
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller and controller.RemovePortal then
      controller:RemovePortal(object:GetID())
    end
  elseif not type then
    object = PathResolver.Resolve(self._path)
    object:SetActive(false)
  end
end

return DestroyEffect
