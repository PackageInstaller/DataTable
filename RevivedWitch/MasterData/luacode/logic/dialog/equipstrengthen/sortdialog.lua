-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipstrengthen/sortdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local SortDialog = class("SortDialog", Dialog)
SortDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
SortDialog.AssetName = "BaseCharacterListSort"
SortDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SortDialog
  ((SortDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._list = {}
  self._nameId = nil
  self._tag = "Sort"
  self._delegate = nil
  self._csortCriteria = nil
  self._target = nil
end

SortDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._frame = (GridFrame.Create)(self._framePanel, self, true, 3)
  ;
  (self._frame):SetMargin(20, 20)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (self:GetRootWindow()):PlayAnimation("SortShow")
end

SortDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

SortDialog.SetData = function(self, delegate, nameId, target, isTowerBattle)
  -- function num : 0_3 , upvalues : _ENV
  self._target = target
  self._isTowerBattle = isTowerBattle
  if not target or target == "Equip" then
    self._csortCriteria = (BeanManager.GetTableByName)("equip.cequipsortcriteria")
  else
    if target == "EquipStrengthenItem" then
      self._csortCriteria = (BeanManager.GetTableByName)("equip.cequipstrengthenitemsortcriteria")
    else
      if target == "EquipEnchantItem" then
        self._csortCriteria = (BeanManager.GetTableByName)("equip.cequipenchantitemsortcriteria")
      else
        if target == "Role" then
          self._csortCriteria = (BeanManager.GetTableByName)("role.csortcriteria")
        end
      end
    end
  end
  self._delegate = delegate
  self._nameId = nameId
  while (self._list)[#self._list] do
    (table.remove)(self._list, #self._list)
  end
  for k,v in pairs((self._csortCriteria):GetAllIds()) do
    local record = (self._csortCriteria):GetRecorder(v)
    if record.id == 8 and self._isTowerBattle then
      (table.insert)(self._list, record)
    end
    ;
    (table.insert)(self._list, record)
  end
  ;
  (table.sort)(self._list, function(a, b)
    -- function num : 0_3_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
end

SortDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_4
  (self:GetRootWindow()):PlayAnimation("SortHide")
end

SortDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_5
  if stateName == "SortHide" then
    self:Destroy()
  end
end

SortDialog.SetSelectedNameId = function(self, nameId)
  -- function num : 0_6
  self._nameId = nameId
  ;
  (self._frame):FireEvent("ChangeSelectNameId")
  ;
  (self._delegate):SetSortCriteriaNameId(self._nameId)
end

SortDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._list
end

SortDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "equipstrengthen.filtersortcell"
end

SortDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._list)[index]
end

return SortDialog

