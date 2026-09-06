local AprilFoolsDayClickEffectCell = class("AprilFoolsDayClickEffectCell", Dialog)
AprilFoolsDayClickEffectCell.AssetBundleName = "ui/layouts"
AprilFoolsDayClickEffectCell.AssetName = "ActivityAprilFoolsClickCell"

function AprilFoolsDayClickEffectCell:Ctor(...)
  AprilFoolsDayClickEffectCell.super.Ctor(self, ...)
end

function AprilFoolsDayClickEffectCell:OnCreate()
end

function AprilFoolsDayClickEffectCell:OnDestroy()
end

function AprilFoolsDayClickEffectCell:PlayEffect()
  self:GetRootWindow():SetAnimatorTrigger("OnClick")
end

function AprilFoolsDayClickEffectCell:PlayAudio(audioId)
  LuaAudioManager.PlayBGM(audioId, true)
end

return AprilFoolsDayClickEffectCell
