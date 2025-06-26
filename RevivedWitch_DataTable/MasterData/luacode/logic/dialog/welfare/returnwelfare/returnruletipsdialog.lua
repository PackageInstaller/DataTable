-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnruletipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ReturnRuleTipsDialog = class("ReturnRuleTipsDialog", Dialog)
ReturnRuleTipsDialog.AssetBundleName = "ui/layouts.welfare"
ReturnRuleTipsDialog.AssetName = "ReturnTips"
ReturnRuleTipsDialog.TipsType = {InvitePlayer = 1, GiftPack = 2}
ReturnRuleTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnRuleTipsDialog
  ((ReturnRuleTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

ReturnRuleTipsDialog.OnCreate = function(self)
  -- function num : 0_1
  self._Text = self:GetChild("Back/Frame/Text")
  self._Title = self:GetChild("Back/Title")
  self._CloseBtn = self:GetChild("CloseBtn")
  ;
  (self._CloseBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

ReturnRuleTipsDialog.Init = function(self, type)
  -- function num : 0_2 , upvalues : _ENV
  if type == (self.TipsType).InvitePlayer then
    (self._Text):SetText((TextManager.GetText)(701611))
  else
    if type == (self.TipsType).GiftPack then
      (self._Text):SetText((TextManager.GetText)(701610))
    end
  end
  ;
  (self._Title):SetText((TextManager.GetText)(701612))
end

ReturnRuleTipsDialog.OnDestroy = function(self)
  -- function num : 0_3
end

ReturnRuleTipsDialog.OnCloseBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return ReturnRuleTipsDialog

