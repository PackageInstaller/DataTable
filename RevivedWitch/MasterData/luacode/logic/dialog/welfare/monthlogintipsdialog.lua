-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/monthlogintipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MonthLoginTipsDialog = class("MonthLoginTipsDialog", Dialog)
MonthLoginTipsDialog.AssetBundleName = "ui/layouts.welfare"
MonthLoginTipsDialog.AssetName = "MonthLoginTips"
MonthLoginTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthLoginTipsDialog
  ((MonthLoginTipsDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

MonthLoginTipsDialog.OnCreate = function(self)
  -- function num : 0_1
  self._shopBuy = self:GetChild("Btn1")
  self._taskGet = self:GetChild("Btn2")
  self._closeBtn = self:GetChild("ConfirmButton")
  ;
  (self._shopBuy):Subscribe_PointerClickEvent(self.OnShopBuyClicked, self)
  ;
  (self._taskGet):Subscribe_PointerClickEvent(self.OnTaskGetClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
end

MonthLoginTipsDialog.OnDestroy = function(self)
  -- function num : 0_2
end

MonthLoginTipsDialog.OnShopBuyClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
  self:OnBackPressed()
end

MonthLoginTipsDialog.OnTaskGetClicked = function(self)
  -- function num : 0_4
  self:OnBackPressed()
end

MonthLoginTipsDialog.OnCloseBtnClicked = function(self)
  -- function num : 0_5
  self:OnBackPressed()
end

MonthLoginTipsDialog.OnBackPressed = function(self)
  -- function num : 0_6
  self:Destroy()
  return true, true
end

return MonthLoginTipsDialog

