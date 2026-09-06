local TabFrame = require("framework.ui.frame.tab.tabframe")
local CDungeonSelectMainlineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CResourceDungeonStage = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local DungeonSelectDetailDialog = class("DungeonSelectDetailDialog", Dialog)
DungeonSelectDetailDialog.AssetBundleName = "ui/layouts.mainline"
DungeonSelectDetailDialog.AssetName = "DungeonSelectDetail"

function DungeonSelectDetailDialog:Ctor(...)
  DungeonSelectDetailDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = nil
end

function DungeonSelectDetailDialog:OnCreate()
  self._groupBtnInfo = {}
  self._groupBtnInfo[1] = {}
  self._groupBtnInfo[1].btn = self:GetChild("CharGroupBtn")
  self._groupBtnInfo[1].btn:Subscribe_PointerClickEvent(function()
    self:OnGroupClick(1)
  end)
  self._groupBtnInfo[2] = {}
  self._groupBtnInfo[2].btn = self:GetChild("BossGroupBtn")
  self._groupBtnInfo[2].btn:Subscribe_PointerClickEvent(function()
    self:OnGroupClick(2)
  end)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._panelWnd = self:GetChild("Frame")
  self._pageHelper = TabFrame.Create(self._panelWnd, self)
  self._menuBtn:SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() ~= "Dungeon")
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
end

function DungeonSelectDetailDialog:OnDestroy()
  self._pageHelper:Destroy()
  UIBackManager.SetUIBackShow(false)
end

function DungeonSelectDetailDialog:Init(data)
  self._data = data
  local recommendIds
  if data.type == "MainLine" then
    recommendIds = CDungeonSelectMainlineTable:GetRecorder(data.id).recommendid
  elseif data.type == "Resource" then
    recommendIds = CResourceDungeonStage:GetRecorder(data.id).recommendid
  end
  self._groupBtnInfo[1].btn:SetActive(recommendIds and 0 < #recommendIds)
  self._pageHelper:ToPage(2)
end

function DungeonSelectDetailDialog:OnGroupClick(index)
  self._pageHelper:ToPage(index)
end

function DungeonSelectDetailDialog:DidToPage(helper, index)
  local dlg = self._pageHelper:GetCellAtIndex(index)
  if dlg.Refresh then
    dlg:Refresh(self._data)
  end
  for i = 1, 2 do
    self._groupBtnInfo[i].btn:SetSelected(index == i)
  end
end

function DungeonSelectDetailDialog:CellAtIndex(helper, index)
  if index == 1 then
    return "mainline.recommendchar.recommendchardialog"
  elseif index == 2 then
    return "mainline.dungeonselectdetail.monstertabcell"
  end
end

function DungeonSelectDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

function DungeonSelectDetailDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return DungeonSelectDetailDialog
