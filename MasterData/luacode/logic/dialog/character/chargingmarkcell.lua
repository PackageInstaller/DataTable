local ChargingMarkCell = class("ChargingMarkCell", Dialog)
ChargingMarkCell.AssetBundleName = "ui/layouts.basecharacterinfo"
ChargingMarkCell.AssetName = "CharSkillNewSkillMark"

function ChargingMarkCell:Ctor(...)
  ChargingMarkCell.super.Ctor(self, ...)
end

function ChargingMarkCell:OnCreate()
end

function ChargingMarkCell:OnDestroy()
end

function ChargingMarkCell:RefreshCell()
end

return ChargingMarkCell
