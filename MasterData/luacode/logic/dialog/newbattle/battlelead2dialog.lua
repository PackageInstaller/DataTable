local BattleLead2Dialog = class("BattleLead2Dialog", Dialog)
BattleLead2Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead2Dialog.AssetName = "BattleNewTutorial2"

function BattleLead2Dialog:Ctor(...)
  BattleLead2Dialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function BattleLead2Dialog:OnCreate()
end

function BattleLead2Dialog:OnDestroy()
end

return BattleLead2Dialog
