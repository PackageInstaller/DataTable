local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local FilterDialog = class("FilterDialog")
local OpenType = {
  NONE = 0,
  FILTER = 1,
  SORT = 2
}

function FilterDialog:Ctor(...)
  self._list = {}
  self._delegate = nil
  self._conditions = {}
  self._toggle1Tag = false
  self._toggle2Tag = false
  self._cscreeningConditions = nil
  self._target = nil
  self._rootWindow = select(1, ...)
  self._openType = 0
  self._isTowerBattle = false
  self._csortCriteria = nil
  self._nameId = nil
  self._show = false
  self._shouldSendCUpdateUISortType = false
  self:Init(self._rootWindow)
end

function FilterDialog:GetChild(path)
  return UIManager.GetChildLuaWindow(self._rootWindow._uiObject, path)
end

function FilterDialog:Init(obj)
  self._rootWindow = obj
  self._back = self:GetChild("Back")
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._confirmBtnText = self:GetChild("Back/ConfirmBtn/_Text")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2103))
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

function FilterDialog:IsShow()
  return self._show
end

function FilterDialog:SetData(delegate, openType, target, ...)
  if self._openType == openType then
    return
  end
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  self._delegate = delegate
  self._target = target
  self._openType = openType
  if openType == OpenType.FILTER then
    self._conditions = select(1, ...)
    self._tag = "Filter"
    self:InitFilterType()
  elseif openType == OpenType.SORT then
    self._nameId = select(1, ...)
    self._isTowerBattle = select(2, ...)
    self._tag = "Sort"
    self:InitSortType()
  end
  if not self._show then
    self._rootWindow:SetAnimatorInteger("isShow", 1)
    self._show = true
  end
end

function FilterDialog:InitFilterType()
  self._frame = TableFrame.Create(self._framePanel, self, true, true, true)
  self._frame:SetMargin(20, 20)
  local target = self._target
  if not target or target == "Equip" or target == "EquipBook" or target == "EquipChange" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipscreeningconditions")
  elseif target == "EquipStrengthenItem" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipstrengthenitemscreeningconditions")
  elseif target == "EquipEnchantItem" then
    self._cscreeningConditions = BeanManager.GetTableByName("equip.cequipenchantitemscreeningconditions")
  elseif target == "Role" then
    self._cscreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
  elseif target == "SignBordRole" then
    self._cscreeningConditions = BeanManager.GetTableByName("role.cscreeningconditions")
  elseif target == "Monster" then
    self._cscreeningConditions = BeanManager.GetTableByName("handbook.cmonster_handbookscreeningconditions")
  elseif target == "SupportRole" then
    self._cscreeningConditions = BeanManager.GetTableByName("skill.cskillscreeningconditions")
  elseif target == "RoleHandBook" then
    self._cscreeningConditions = BeanManager.GetTableByName("handbook.cscreeningconditions_handbook")
  elseif target == "LoverChocolateRole" then
    self._cscreeningConditions = BeanManager.GetTableByName("activity.cvalentinescreeningconditions")
  elseif target == "SkinHandBook" then
    self._cscreeningConditions = BeanManager.GetTableByName("recharge.cskinconditions")
  end
  self._list = {}
  local map = {}
  for k, v in pairs(self._cscreeningConditions:GetAllIds()) do
    local record = self._cscreeningConditions:GetRecorder(v)
    if target == "EquipBook" then
      if v == 5 or v == 6 or v == 7 then
        if not map[record.type] then
          map[record.type] = {
            mType = record.type,
            list = {},
            TypeNameId = record.typename,
            target = self._target
          }
        end
        table.insert(map[record.type].list, record)
      end
    elseif target == "EquipChange" then
      if v ~= 5 and v ~= 6 and v ~= 7 then
        if not map[record.type] then
          map[record.type] = {
            mType = record.type,
            list = {},
            TypeNameId = record.typename,
            target = self._target
          }
        end
        table.insert(map[record.type].list, record)
      end
    elseif target == "RoleHandBook" then
      if not map[record.type] then
        map[record.type] = {
          mType = record.type,
          list = {},
          TypeNameId = record.typename,
          value = record.value,
          target = self._target
        }
      end
      table.insert(map[record.type].list, record)
    else
      if not map[record.type] then
        map[record.type] = {
          mType = record.type,
          list = {},
          TypeNameId = record.typename,
          target = self._target
        }
      end
      table.insert(map[record.type].list, record)
    end
  end
  for k, v in pairs(map) do
    table.sort(v.list, function(a, b)
      return a.sort < b.sort
    end)
    table.insert(self._list, v)
  end
  table.sort(self._list, function(a, b)
    return a.mType < b.mType
  end)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function FilterDialog:InitSortType()
  if self._target == "SignBordRole" then
    self._frame = GridFrame.Create(self._framePanel, self, true, 5)
  else
    self._frame = GridFrame.Create(self._framePanel, self, true, 3)
  end
  self._frame:SetMargin(20, 20)
  local target = self._target
  if not target or target == "Equip" or target == "EquipChange" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipsortcriteria")
  elseif target == "EquipStrengthenItem" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipstrengthenitemsortcriteria")
  elseif target == "EquipEnchantItem" then
    self._csortCriteria = BeanManager.GetTableByName("equip.cequipenchantitemsortcriteria")
  elseif target == "Role" then
    self._csortCriteria = BeanManager.GetTableByName("role.csortcriteria")
  elseif target == "RoleHandBook" then
    self._csortCriteria = BeanManager.GetTableByName("handbook.ccardsortcriteria")
  elseif target == "SignBordRole" then
    self._csortCriteria = BeanManager.GetTableByName("role.csortcriteria")
  elseif target == "SkinHandBook" then
    self._csortCriteria = BeanManager.GetTableByName("recharge.cskincriteria")
  end
  self._list = {}
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
  self._shouldSendCUpdateUISortType = true
end

function FilterDialog:OnConfirmBtnClick()
  self._rootWindow:SetAnimatorInteger("isShow", 0)
  self._show = false
  self._openType = 0
  if self._shouldSendCUpdateUISortType then
    self._delegate:SendCUpdateUISortType()
  end
end

function FilterDialog:checkReset(objName)
  if objName == "FliterBtn" and self._openType ~= OpenType.FILTER or objName == "LevelBtn" and self._openType ~= OpenType.LEVEL then
    return true
  end
  return false
end

function FilterDialog:OnGlobalPointerDown(args)
  if not self._show then
    return
  end
  local win1 = args.userInfo.luaWindow
  local fliterBtn = self._delegate and self._delegate:GetChild("FliterBtn")
  local levelBtn = self._delegate and self._delegate:GetChild("LevelBtn")
  local redPointFliterBtn = self._delegate and self._delegate._redPointBtn
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    if (win1 == fliterBtn or win1 == levelBtn or win1 == redPointFliterBtn) and self._show then
      return
    else
      if self._frame then
        self._frame:Destroy()
        self._frame = nil
      end
      if self._show then
        self._openType = 0
        self._show = false
        self._rootWindow:SetAnimatorInteger("isShow", 0)
      end
    end
  end
end

function FilterDialog:GetRootWindow()
  return self._rootWindow
end

function FilterDialog:SetSelectedNameId(data)
  if self._openType == OpenType.FILTER then
    local index = self:IsInFilterConditions(data.type, data.nameid)
    if index then
      table.remove(self._conditions[data.type], index)
    else
      if not self._conditions[data.type] then
        self._conditions[data.type] = {}
      end
      table.insert(self._conditions[data.type], data)
    end
    self._frame:FireEvent("ChangeSelectNameId")
    self._delegate:SetScreeningConditions(self._conditions)
  elseif self._openType == OpenType.SORT then
    self._nameId = data
    self._frame:FireEvent("ChangeSelectNameId")
    self._delegate:SetSortCriteriaNameId(self._nameId)
  end
end

function FilterDialog:IsInFilterConditions(type, nameId)
  for k, v in pairs(self._conditions) do
    if k == type then
      for index, value in ipairs(v) do
        if value.nameid == nameId then
          return index
        end
      end
    end
  end
  return nil
end

function FilterDialog:NumberOfCell(frame)
  return #self._list
end

function FilterDialog:CellAtIndex(frame)
  if self._openType == OpenType.FILTER then
    if self._target == "SignBordRole" then
      return "common.signbordrolefilterframe"
    elseif self._target == "EquipChange" then
      return "common.equipfilterframe"
    else
      return "common.filterframe"
    end
  elseif self._openType == OpenType.SORT then
    if self._target == "EquipChange" then
      return "common.equipfilterframecell"
    end
    return "common.filterframecell"
  end
end

function FilterDialog:DataAtIndex(frame, index)
  return self._list[index]
end

function FilterDialog:ShouldLengthChange()
  return true
end

function FilterDialog:Destroy()
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  self._rootWindow = nil
  self._list = nil
  self._openType = 0
  self._show = false
  self._confirmBtn:Unsubscribe_PointerClickEvent(self.OnConfirmBtnClick)
  LuaNotificationCenter.RemoveObserver(self)
end

function FilterDialog:ShouldLengthChange()
  return true
end

return FilterDialog
