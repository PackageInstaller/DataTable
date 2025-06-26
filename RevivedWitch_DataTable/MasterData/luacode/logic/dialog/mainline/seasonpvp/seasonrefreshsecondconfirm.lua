-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonrefreshsecondconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CArenaRefreshMatchCost = (BeanManager.GetTableByName)("dungeonselect.carenarefreshmatchcost")
local Item = require("logic.manager.experimental.types.item")
local SeasonRefreshSecondConfirm = class("SeasonRefreshSecondConfirm", Dialog)
SeasonRefreshSecondConfirm.AssetBundleName = "ui/layouts.offlinepvp"
SeasonRefreshSecondConfirm.AssetName = "OffLinePVPSecondConfirm2"
SeasonRefreshSecondConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonRefreshSecondConfirm
  ((SeasonRefreshSecondConfirm.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SeasonRefreshSecondConfirm.OnCreate = function(self)
  -- function num : 0_1
  self._time = self:GetChild("Panel/Refresh/Time")
  self._title = self:GetChild("Panel/Text")
  self._coinIcon = self:GetChild("Panel/Num/Icon")
  self._coinNum = self:GetChild("Panel/Num/Text")
  self._cancelBtn = self:GetChild("Panel/CancelButton")
  self._confirmButton = self:GetChild("Panel/ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

SeasonRefreshSecondConfirm.OnDestroy = function(self)
  -- function num : 0_2
end

SeasonRefreshSecondConfirm.Init = function(self, times)
  -- function num : 0_3
end

SeasonRefreshSecondConfirm.OnConfirmBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictresetenemy")
  if csend then
    csend:Send()
  end
  self:Destroy()
end

SeasonRefreshSecondConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return SeasonRefreshSecondConfirm

