local GridFrame = require("framework.ui.frame.grid.gridframe")
local SortDialog = class("SortDialog", Dialog)
SortDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
SortDialog.AssetName = "BaseCharacterListSort"

function SortDialog:Ctor(...)
  SortDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._list = {}
  self._nameId = nil
  self._tag = "Sort"
  self._delegate = nil
  self._csortCriteria = nil
  self._target = nil
end

function SortDialog:OnCreate()
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._frame = GridFrame.Create(self._framePanel, self, true, 3)
  self._frame:SetMargin(20, 20)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  self:GetRootWindow():PlayAnimation("SortShow")
end

function SortDialog:OnDestroy()
  self._frame:Destroy()
end

function SortDialog:SetData(delegate, nameId, target, isTowerBattle)
  self._target = target
  self._isTowerBattle = isTowerBattle
  if not target or target == "Equip" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipsortcriteria")
  elseif target == "EquipStrengthenItem" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipstrengthenitemsortcriteria")
  elseif target == "EquipEnchantItem" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipenchantitemsortcriteria")
  elseif target == "Role" then
    self._csortCriteria = BeanManager.GetTableByName("role.csortcriteria")
  end
  self._delegate = delegate
  self._nameId = nameId
  while self._list[#self._list] do
    table.remove(self._list, #self._list)
  end
  for k, v in pairs(self._csortCriteria:GetAllIds()) do
    local record = self._csortCriteria:GetRecorder(v)
    if record.id == 8 then
      if self._isTowerBattle then
        table.insert(self._list, record)
      end
    else
      table.insert(self._list, record)
    end
  end
  table.sort(self._list, function(a, b)
    return a.sort < b.sort
  end)
  self._frame:ReloadAllCell()
end

function SortDialog:OnConfirmBtnClick()
  self:GetRootWindow():PlayAnimation("SortHide")
end

function SortDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "SortHide" then
    self:Destroy()
  end
end

function SortDialog:SetSelectedNameId(nameId)
  self._nameId = nameId
  self._frame:FireEvent("ChangeSelectNameId")
  self._delegate:SetSortCriteriaNameId(self._nameId)
end

function SortDialog:NumberOfCell(frame)
  return #self._list
end

function SortDialog:CellAtIndex(frame)
  return "equipstrengthen.filtersortcell"
end

function SortDialog:DataAtIndex(frame, index)
  return self._list[index]
end

return SortDialog
