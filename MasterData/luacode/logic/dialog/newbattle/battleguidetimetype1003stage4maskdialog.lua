local BattleGuideTimeType1003Stage4MaskDialog = class("BattleGuideTimeType1003Stage4MaskDialog", Dialog)
BattleGuideTimeType1003Stage4MaskDialog.AssetBundleName = "ui/layouts"
BattleGuideTimeType1003Stage4MaskDialog.AssetName = "WindowMask"

function BattleGuideTimeType1003Stage4MaskDialog:Ctor(...)
  BattleGuideTimeType1003Stage4MaskDialog.super.Ctor(self, ...)
  self._groupName = "Guide"
end

function BattleGuideTimeType1003Stage4MaskDialog:OnCreate()
  LogInfo("BattleGuideTimeType1003Stage4MaskDialog", "OnCreate")
end

function BattleGuideTimeType1003Stage4MaskDialog:OnDestroy()
  LogInfo("BattleGuideTimeType1003Stage4MaskDialog", "OnDestroy")
end

return BattleGuideTimeType1003Stage4MaskDialog
