-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementdetailtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAchievementMissionConfig = (BeanManager.GetTableByName)("mission.cachievemissionconfig")
local RoleAchievementDetailTip = class("RoleAchievementDetailTip", Dialog)
RoleAchievementDetailTip.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementDetailTip.AssetName = "AchievementDetailTips"
RoleAchievementDetailTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementDetailTip
  ((RoleAchievementDetailTip.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

RoleAchievementDetailTip.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("Back/Title")
  self._detail = self:GetChild("Back/Txt2")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBackBtnClicked, Common.n_GlobalPointerWillDown, nil)
end

RoleAchievementDetailTip.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RoleAchievementDetailTip.SetData = function(self, taskid)
  -- function num : 0_3 , upvalues : CAchievementMissionConfig, _ENV
  local record = CAchievementMissionConfig:GetRecorder(taskid)
  if record then
    (self._detail):SetText((TextManager.GetText)(record.instructionTextID))
    ;
    (self._title):SetText((TextManager.GetText)(record.missionnameTextID))
  end
end

RoleAchievementDetailTip.OnBackBtnClicked = function(self, args)
  -- function num : 0_4
  self:Destroy()
end

return RoleAchievementDetailTip

