-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/skill/chargingskillusageruledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local ChargingSkillUsageRuleDialog = class("ChargingSkillUsageRuleDialog", Dialog)
ChargingSkillUsageRuleDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ChargingSkillUsageRuleDialog.AssetName = "CharSkillNewTips"
ChargingSkillUsageRuleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChargingSkillUsageRuleDialog
  ((ChargingSkillUsageRuleDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ChargingSkillUsageRuleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("Tips")
  self._txt = self:GetChild("Tips/Text")
  ;
  (self._txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1480))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

ChargingSkillUsageRuleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChargingSkillUsageRuleDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_3 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ChargingSkillUsageRuleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return ChargingSkillUsageRuleDialog

