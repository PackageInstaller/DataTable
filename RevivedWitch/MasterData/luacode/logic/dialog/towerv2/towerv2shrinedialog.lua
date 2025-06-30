-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2shrinedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerV2ShrineDialog = class("TowerV2ShrineDialog", Dialog)
TowerV2ShrineDialog.AssetBundleName = "ui/layouts.mainline"
TowerV2ShrineDialog.AssetName = "TowerEventChancel"
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2ShrineDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ShrineDialog
  ((TowerV2ShrineDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerV2ShrineDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._img = self:GetChild("Model")
  self._txt = self:GetChild("Text")
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("ComfirmBtn")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
end

TowerV2ShrineDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._autoTimer then
    (GameTimer.RemoveTask)(self._autoTimer)
  end
end

TowerV2ShrineDialog.SetData = function(self, id, index, controller)
  -- function num : 0_3 , upvalues : bm_towerv2, _ENV
  self._controller = controller
  self._id = id
  self._index = index
  if bm_towerv2:IsInAutoExplore() then
    self._autoTimer = (GameTimer.AddTask)(1.5, 0, function()
    -- function num : 0_3_0 , upvalues : self
    self:OnConfirmBtnClicked()
  end
)
  end
end

TowerV2ShrineDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_TowerV2):ChooseEvent(((NekoData.BehaviorManager).BM_TowerV2):GetCurrentFloorID(), self._index - 1, 0)
  self._freeze = true
end

TowerV2ShrineDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2shrinedialog")
  ;
  (self._controller):OnDialogDestroy(self._index)
end

TowerV2ShrineDialog.OnStairFinish = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2shrinedialog")
end

return TowerV2ShrineDialog

