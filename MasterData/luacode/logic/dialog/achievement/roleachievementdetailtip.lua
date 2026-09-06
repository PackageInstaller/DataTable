local CAchievementMissionConfig = BeanManager.GetTableByName("mission.cachievemissionconfig")
local RoleAchievementDetailTip = class("RoleAchievementDetailTip", Dialog)
RoleAchievementDetailTip.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailTip.AssetName = "AchievementDetailTips"

function RoleAchievementDetailTip:Ctor(...)
  RoleAchievementDetailTip.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function RoleAchievementDetailTip:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._detail = self:GetChild("Back/Txt2")
  LuaNotificationCenter.AddObserver(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

function RoleAchievementDetailTip:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RoleAchievementDetailTip:SetData(taskid)
  local record = CAchievementMissionConfig:GetRecorder(taskid)
  if record then
    self._detail:SetText(TextManager.GetText(record.instructionTextID))
    self._title:SetText(TextManager.GetText(record.missionnameTextID))
  end
end

function RoleAchievementDetailTip:OnBackBtnClicked(args)
  self:Destroy()
end

return RoleAchievementDetailTip
