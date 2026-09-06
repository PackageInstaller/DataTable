local Switch = require("logic.scene.trap.switch")
local Catapult = class("Catapult", Switch)
local Future = require("logic.scene.luaevent.effect.future")
local SceneObj = require("logic.manager.experimental.types.sceneobj")
local UIInteraction = require("logic.scene.interaction.uiinteraction")

function Catapult:Ctor(...)
  Catapult.super.Ctor(self, ...)
  self._viewer = self._object:GetComponent("CatapultViewer")
end

function Catapult:Activate()
  self:BuildStateEffects()
  self:BuildSceneObject()
end

function Catapult:BuildStateEffects()
  Catapult.super.BuildStateEffects(self)
  local tmp = {}
  tmp[0] = self._stateEffects[0]
  tmp[1] = self._stateEffects[1]
  tmp[1]:AddEffect(EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.CreateSingletonDialog("dungeon.thrower.throwerlayer")
    dialog:SetData(self)
  end))
  tmp[2] = self._stateEffects[2]
  self._stateEffects = tmp
end

function Catapult:SetThrowerInfo(info)
  self._info = info
end

function Catapult:GetThrowerInfo()
  return self._info
end

function Catapult:CheckState()
  local state = 0
  for _, v in pairs(self._effectArgs.switches) do
    local switch = SwitchManager.GetSwitch(v.instance, v.id)
    state = state + switch:GetState()
  end
  if state == 0 then
    return self:ToState(1)
  elseif state == #self._effectArgs.switches then
    return self:ToState(2)
  else
    return Future.NoOp()
  end
end

function Catapult:SetPreviewParameter(angle, power)
  return self._viewer:SetParameter(self._info.pitchangle, angle, power)
end

function Catapult:SetPreviewAsset(id)
  local assetbundlename, assetname = EffectUtil.GetAssetBundleNameAndAssetName(id)
  self._viewer:SetGuideDotInfo(assetbundlename, assetname)
end

function Catapult:SetShellAsset(id)
  local assetbundlename, assetname = EffectUtil.GetAssetBundleNameAndAssetName(id)
  self._viewer:SetShellInfo(assetbundlename, assetname)
end

function Catapult:SetTargetAsset(id)
  local assetbundlename, assetname = EffectUtil.GetAssetBundleNameAndAssetName(id)
  self._viewer:SetGuideTargetInfo(assetbundlename, assetname)
end

function Catapult:Fire()
  return self._viewer:Fire()
end

return Catapult
