local UIManager = CS.PixelNeko.UI.UIManager
local RoleRelationUpTipsDialog = class("RoleRelationUpTipsDialog", Dialog)
RoleRelationUpTipsDialog.AssetBundleName = "ui/layouts.tujian"
RoleRelationUpTipsDialog.AssetName = "CharBookRelationTips"

function RoleRelationUpTipsDialog:Ctor(...)
  RoleRelationUpTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function RoleRelationUpTipsDialog:OnCreate()
  self._value = self:GetChild("Tips/Text")
  LuaNotificationCenter.AddObserver(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

function RoleRelationUpTipsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RoleRelationUpTipsDialog:SetData(data)
  self._value:SetText(data)
end

function RoleRelationUpTipsDialog:OnBackBtnClicked(args)
  self:Destroy()
end

return RoleRelationUpTipsDialog
