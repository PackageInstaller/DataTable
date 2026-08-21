-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/bagdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local BagDialog = class("BagDialog", Dialog)
BagDialog.AssetBundleName = "ui/layouts.workshop"
BagDialog.AssetName = "WorkShopMain"
BagDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BagDialog
  ((BagDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._baseSceneController = nil
  self._tab = nil
end

BagDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
  self._panel = self:GetChild("Frame")
  self._groupBtns = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtns)[i] = self:GetChild("GroupBtnArea/Btn" .. i .. "/GroupBtn")
      ;
      ((self._groupBtns)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupBtnClick(i)
  end
)
    end
  end
  local unlock = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).RoleReset)
  ;
  ((self._groupBtns)[4]):SetActive(unlock)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._frame = (TabFrame.Create)(self._panel, self)
  self:OnGroupBtnClick(1)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:CheckCachedFM()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

BagDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (UIBackManager.SetUIBackShow)(false)
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
end

BagDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._baseSceneController = sceneController
end

BagDialog.CheckCachedFM = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_BagInfo):HasCachedFMKey() == false then
    return 
  end
  local keyTable = ((NekoData.BehaviorManager).BM_BagInfo):GetCachedFMKeyTable()
  local fmResultTipDialog = (DialogManager.CreateSingletonDialog)("equipforge.equipfmresultdialog")
  fmResultTipDialog:RefreshFromCachedFM(keyTable)
end

BagDialog.OnGroupBtnClick = function(self, index)
  -- function num : 0_5
  if self._tab ~= index then
    self._tab = index
    local cellPage = (self._frame):ToPage(self._tab)
    if cellPage and cellPage.RefreshCell then
      cellPage:RefreshCell()
    end
  end
end

BagDialog.DidToPage = function(self, frame, index)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(self._groupBtns) do
    if k == index then
      v:SetSelected(true)
    else
      v:SetSelected(false)
    end
  end
end

BagDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if index == 1 then
    return "equip.equipbagtabcell"
  else
    if index == 2 then
      return "bag.bagdialog"
    else
      if index == 3 then
        return "bag.valuablebagtabcell"
      else
        if index == 4 then
          return "bag.rolereset.roleresetmaindialog"
        end
      end
    end
  end
end

BagDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  self:Destroy()
end

BagDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return BagDialog

