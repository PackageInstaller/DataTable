local FirtstRechargeTip = class("FirtstRechargeTip", Dialog)
FirtstRechargeTip.AssetBundleName = "ui/layouts.welfare"
FirtstRechargeTip.AssetName = "FirstRechargeTips"

function FirtstRechargeTip:Ctor(...)
  FirtstRechargeTip.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function FirtstRechargeTip:OnCreate()
  LuaNotificationCenter.AddObserver(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

function FirtstRechargeTip:OnDestroy()
end

function FirtstRechargeTip:RefreshTabCell()
end

function FirtstRechargeTip:OnBackBtnClicked()
  self:Destroy()
end

return FirtstRechargeTip
