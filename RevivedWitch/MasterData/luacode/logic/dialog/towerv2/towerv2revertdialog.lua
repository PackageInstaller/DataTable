-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2revertdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2RevertDialog = class("TowerEventBoxTips", Dialog)
TowerV2RevertDialog.AssetBundleName = "ui/layouts.stair"
TowerV2RevertDialog.AssetName = "StairRevert"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2RevertDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2RevertDialog
  ((TowerV2RevertDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2RevertDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._restart = self:GetChild("RestartBtn")
  self._continue = self:GetChild("NearbyBTn")
  self._confirm = self:GetChild("ConfirmBtn")
  self._buff = self:GetChild("CardNum")
  self._count = self:GetChild("CardNum/ZhuFuNum")
  self._selected = {self:GetChild("RestartBtn/Choose1"), self:GetChild("NearbyBTn/Choose2")}
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  ;
  (self._restart):Subscribe_PointerClickEvent(self.OnRestartClick, self)
  ;
  (self._continue):Subscribe_PointerClickEvent(self.OnContinueClick, self)
  ;
  (self._confirm):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self:OnRestartClick()
  self:Refresh()
end

TowerV2RevertDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2RevertDialog.OnRestartClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._type = 1
  for i,v in pairs(self._selected) do
    v:SetActive(i == 1)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerV2RevertDialog.OnContinueClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self._type = 2
  for i,v in pairs(self._selected) do
    v:SetActive(i == 2)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerV2RevertDialog.Refresh = function(self)
  -- function num : 0_5 , upvalues : bm_towerv2
  local num = bm_towerv2:GetInitBuffChances()
  ;
  (self._buff):SetActive(num ~= 0)
  ;
  (self._count):SetText(num)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerV2RevertDialog.OnConfirmClick = function(self)
  -- function num : 0_6 , upvalues : bm_towerv2
  if self._clicked then
    return 
  end
  bm_towerv2:Reset(self._type)
  self._clicked = true
end

TowerV2RevertDialog.OnNewStairs = function(self)
  -- function num : 0_7
  self:Destroy()
end

return TowerV2RevertDialog

