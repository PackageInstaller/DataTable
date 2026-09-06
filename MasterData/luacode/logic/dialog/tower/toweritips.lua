local UIManager = CS.PixelNeko.UI.UIManager
local TowerITips = class("TowerITips", Dialog)
TowerITips.AssetBundleName = "ui/layouts.mainline"
TowerITips.AssetName = "TowerDetailTips"

function TowerITips:Ctor(...)
  TowerITips.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function TowerITips:OnCreate()
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function TowerITips:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerITips:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function TowerITips:OnBackBtnClicked()
  self:Destroy()
end

return TowerITips
