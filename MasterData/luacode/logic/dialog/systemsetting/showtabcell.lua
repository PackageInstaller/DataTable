local ShowTabCell = class("ShowTabCell", Dialog)
ShowTabCell.AssetBundleName = "ui/layouts.setting"
ShowTabCell.AssetName = "SettingShow"

function ShowTabCell:Ctor(...)
  ShowTabCell.super.Ctor(self, ...)
end

function ShowTabCell:OnCreate()
end

function ShowTabCell:OnDestroy()
end

return ShowTabCell
