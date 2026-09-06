local BattleLead1Dialog = class("BattleLead1Dialog", Dialog)
BattleLead1Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead1Dialog.AssetName = "BattleNewTutorial1"

function BattleLead1Dialog:Ctor(...)
  BattleLead1Dialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function BattleLead1Dialog:OnCreate()
end

function BattleLead1Dialog:OnDestroy()
end

return BattleLead1Dialog
