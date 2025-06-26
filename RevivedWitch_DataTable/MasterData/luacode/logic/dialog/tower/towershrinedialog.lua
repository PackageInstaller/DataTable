-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towershrinedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TowerShrineDialog = class("TowerEventEffectTips", Dialog)
TowerShrineDialog.AssetBundleName = "ui/layouts.mainline"
TowerShrineDialog.AssetName = "TowerEventChancel"
TowerShrineDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerShrineDialog
  ((TowerShrineDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerShrineDialog.OnCreate = function(self)
  -- function num : 0_1
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
end

TowerShrineDialog.OnDestroy = function(self)
  -- function num : 0_2
end

TowerShrineDialog.SetData = function(self, index)
  -- function num : 0_3
  self._index = index
end

TowerShrineDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Tower):ActivateShrine(self._index)
  self._freeze = true
end

TowerShrineDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._freeze then
    return 
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towershrinedialog")
end

return TowerShrineDialog

