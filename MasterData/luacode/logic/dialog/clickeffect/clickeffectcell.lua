local ClickEffectCell = class("ClickEffectCell", Dialog)
ClickEffectCell.AssetBundleName = "ui/layouts"
ClickEffectCell.AssetName = "ClickCell"

function ClickEffectCell:Ctor(...)
  ClickEffectCell.super.Ctor(self, ...)
end

function ClickEffectCell:OnCreate()
end

function ClickEffectCell:OnDestroy()
end

function ClickEffectCell:PlayEffect()
  self:GetRootWindow():SetAnimatorTrigger("OnClick")
end

function ClickEffectCell:PlayAudio(audioId)
  LuaAudioManager.PlayBGM(audioId, true)
end

return ClickEffectCell
