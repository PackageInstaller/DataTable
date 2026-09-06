local BattleRoleDetailCell = class("BattleRoleDetailCell", Dialog)
BattleRoleDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattleRoleDetailCell.AssetName = "BattleDetail2Cell"

function BattleRoleDetailCell:Ctor(...)
  BattleRoleDetailCell.super.Ctor(self, ...)
end

function BattleRoleDetailCell:OnCreate()
  self._name = self:GetChild("Text")
  self._whiteName = self:GetChild("Text2")
  self._whiteName:SetActive(false)
  self._num = self:GetChild("Num")
end

function BattleRoleDetailCell:OnDestroy()
end

function BattleRoleDetailCell:RefreshCell(data)
  self._name:SetText(data.name)
  self._num:SetText(data.num)
end

return BattleRoleDetailCell
