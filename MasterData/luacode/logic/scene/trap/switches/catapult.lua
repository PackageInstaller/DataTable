-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/catapult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Catapult = class("Catapult", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local SceneObj = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
Catapult.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Catapult
  ((Catapult.super).Ctor)(self, ...)
  self._viewer = (self._object):GetComponent("CatapultViewer")
end

Catapult.Activate = function(self)
  -- function num : 0_1
  self:BuildStateEffects()
  self:BuildSceneObject()
end

Catapult.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : Catapult, _ENV
  ((Catapult.super).BuildStateEffects)(self)
  local tmp = {}
  tmp[0] = (self._stateEffects)[0]
  tmp[1] = (self._stateEffects)[1]
  ;
  (tmp[1]):AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    local dialog = (DialogManager.CreateSingletonDialog)("dungeon.thrower.throwerlayer")
    dialog:SetData(self)
  end
))
  tmp[2] = (self._stateEffects)[2]
  self._stateEffects = tmp
end

Catapult.SetThrowerInfo = function(self, info)
  -- function num : 0_3
  self._info = info
end

Catapult.GetThrowerInfo = function(self)
  -- function num : 0_4
  return self._info
end

Catapult.CheckState = function(self)
  -- function num : 0_5 , upvalues : _ENV, Future
  local state = 0
  for _,v in pairs((self._effectArgs).switches) do
    local switch = (SwitchManager.GetSwitch)(v.instance, v.id)
    state = state + switch:GetState()
  end
  if state == 0 then
    return self:ToState(1)
  else
    if state == #(self._effectArgs).switches then
      return self:ToState(2)
    else
      return (Future.NoOp)()
    end
  end
end

Catapult.SetPreviewParameter = function(self, angle, power)
  -- function num : 0_6
  return (self._viewer):SetParameter((self._info).pitchangle, angle, power)
end

Catapult.SetPreviewAsset = function(self, id)
  -- function num : 0_7 , upvalues : _ENV
  local assetbundlename, assetname = (EffectUtil.GetAssetBundleNameAndAssetName)(id)
  ;
  (self._viewer):SetGuideDotInfo(assetbundlename, assetname)
end

Catapult.SetShellAsset = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  local assetbundlename, assetname = (EffectUtil.GetAssetBundleNameAndAssetName)(id)
  ;
  (self._viewer):SetShellInfo(assetbundlename, assetname)
end

Catapult.SetTargetAsset = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  local assetbundlename, assetname = (EffectUtil.GetAssetBundleNameAndAssetName)(id)
  ;
  (self._viewer):SetGuideTargetInfo(assetbundlename, assetname)
end

Catapult.Fire = function(self)
  -- function num : 0_10
  return (self._viewer):Fire()
end

return Catapult

