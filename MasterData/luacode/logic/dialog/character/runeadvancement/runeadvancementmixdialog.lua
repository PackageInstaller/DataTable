local CRoleadvancedItemExchange = BeanManager.GetTableByName("role.croleadvanceditemexchange")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local RuneAdvancementMixDialog = class("RuneAdvancementMixDialog", Dialog)
RuneAdvancementMixDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementMixDialog.AssetName = "CharUpgradeMix"

function RuneAdvancementMixDialog:Ctor(...)
  RuneAdvancementMixDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._which = 1
end

function RuneAdvancementMixDialog:OnCreate()
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2047))
  self:GetChild("GroupBtnBack/GroupBtn1/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2043))
  self:GetChild("GroupBtnBack/GroupBtn2/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2044))
  self:GetChild("GroupBtnBack/GroupBtn3/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2045))
  self._groupBtn = {}
  for i = 1, Num do
    self._groupBtn[i] = self:GetChild("GroupBtnBack/GroupBtn" .. i)
    self._groupBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSelectWhich(i)
    end, self)
  end
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn = self:GetChild("CloseBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:OnSelectWhich(1, true)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefresh()
  end, Common.n_ItemNumModify, nil)
end

function RuneAdvancementMixDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RuneAdvancementMixDialog:OnSelectWhich(index, refresh)
  if self._which == index and not refresh then
    return
  end
  for i = 1, Num do
    self._groupBtn[i]:SetSelected(i == index)
  end
  self._which = index
  self:OnRefresh()
  self._frame:MoveToTop()
end

function RuneAdvancementMixDialog:OnRefresh()
  local lastPos = self._frame:GetCurrentPosition()
  local templist = {}
  for i, v in ipairs(CRoleadvancedItemExchange:GetAllIds()) do
    local record = CRoleadvancedItemExchange:GetRecorder(v)
    if record.itemQuality == self._which then
      table.insert(templist, record)
    end
  end
  table.sort(templist, function(a, b)
    return a.id < b.id
  end)
  self._dataList = templist
  self._frame:ReloadAllCell()
  if lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function RuneAdvancementMixDialog:OnBackBtnClicked()
  self:Destroy()
end

function RuneAdvancementMixDialog:NumberOfCell(frame)
  return #self._dataList
end

function RuneAdvancementMixDialog:CellAtIndex(frame, index)
  return "character.runeadvancement.runeadvancementmixcell"
end

function RuneAdvancementMixDialog:DataAtIndex(frame, index)
  return self._dataList[index]
end

return RuneAdvancementMixDialog
