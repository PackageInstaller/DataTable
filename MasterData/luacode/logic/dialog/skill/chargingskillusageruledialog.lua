local UIManager = CS.PixelNeko.UI.UIManager
local ChargingSkillUsageRuleDialog = class("ChargingSkillUsageRuleDialog", Dialog)
ChargingSkillUsageRuleDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ChargingSkillUsageRuleDialog.AssetName = "CharSkillNewTips"

function ChargingSkillUsageRuleDialog:Ctor(...)
  ChargingSkillUsageRuleDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ChargingSkillUsageRuleDialog:OnCreate()
  self._back = self:GetChild("Tips")
  self._txt = self:GetChild("Tips/Text")
  self._txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1480))
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function ChargingSkillUsageRuleDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChargingSkillUsageRuleDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ChargingSkillUsageRuleDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChargingSkillUsageRuleDialog
