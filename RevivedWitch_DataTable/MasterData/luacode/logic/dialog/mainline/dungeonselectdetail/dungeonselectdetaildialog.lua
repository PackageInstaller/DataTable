-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/dungeonselectdetail/dungeonselectdetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CDungeonSelectMainlineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CResourceDungeonStage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local DungeonSelectDetailDialog = class("DungeonSelectDetailDialog", Dialog)
DungeonSelectDetailDialog.AssetBundleName = "ui/layouts.mainline"
DungeonSelectDetailDialog.AssetName = "DungeonSelectDetail"
DungeonSelectDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonSelectDetailDialog
  ((DungeonSelectDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = nil
end

DungeonSelectDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._groupBtnInfo = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._groupBtnInfo)[1] = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._groupBtnInfo)[1]).btn = self:GetChild("CharGroupBtn")
  ;
  (((self._groupBtnInfo)[1]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnGroupClick(1)
  end
)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._groupBtnInfo)[2] = {}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._groupBtnInfo)[2]).btn = self:GetChild("BossGroupBtn")
  ;
  (((self._groupBtnInfo)[2]).btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnGroupClick(2)
  end
)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._panelWnd = self:GetChild("Frame")
  self._pageHelper = (TabFrame.Create)(self._panelWnd, self)
  ;
  (self._menuBtn):SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() ~= "Dungeon")
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonSelectDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._pageHelper):Destroy()
  ;
  (UIBackManager.SetUIBackShow)(false)
end

DungeonSelectDetailDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : CDungeonSelectMainlineTable, CResourceDungeonStage
  self._data = data
  local recommendIds = nil
  if data.type == "MainLine" then
    recommendIds = (CDungeonSelectMainlineTable:GetRecorder(data.id)).recommendid
  else
    if data.type == "Resource" then
      recommendIds = (CResourceDungeonStage:GetRecorder(data.id)).recommendid
    end
  end
  ;
  (((self._groupBtnInfo)[1]).btn):SetActive(not recommendIds or #recommendIds > 0)
  ;
  (self._pageHelper):ToPage(2)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DungeonSelectDetailDialog.OnGroupClick = function(self, index)
  -- function num : 0_4
  (self._pageHelper):ToPage(index)
end

DungeonSelectDetailDialog.DidToPage = function(self, helper, index)
  -- function num : 0_5
  local dlg = (self._pageHelper):GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh(self._data)
  end
  for i = 1, 2 do
    (((self._groupBtnInfo)[i]).btn):SetSelected(index == i)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonSelectDetailDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_6
  if index == 1 then
    return "mainline.recommendchar.recommendchardialog"
  else
    if index == 2 then
      return "mainline.dungeonselectdetail.monstertabcell"
    end
  end
end

DungeonSelectDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

DungeonSelectDetailDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return DungeonSelectDetailDialog

