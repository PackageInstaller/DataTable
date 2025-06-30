-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/common/filterdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local FilterDialog = class("FilterDialog")
local OpenType = {NONE = 0, FILTER = 1, SORT = 2}
FilterDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : _ENV
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

FilterDialog.GetChild = function(self, path)
  -- function num : 0_1 , upvalues : UIManager
  return (UIManager.GetChildLuaWindow)((self._rootWindow)._uiObject, path)
end

FilterDialog.Init = function(self, obj)
  -- function num : 0_2 , upvalues : _ENV
  self._rootWindow = obj
  self._back = self:GetChild("Back")
  self._framePanel = self:GetChild("Back/Frame")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  self._confirmBtnText = self:GetChild("Back/ConfirmBtn/_Text")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  ;
  (self._confirmBtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2103))
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
end

FilterDialog.IsShow = function(self)
  -- function num : 0_3
  return self._show
end

FilterDialog.SetData = function(self, delegate, openType, target, ...)
  -- function num : 0_4 , upvalues : OpenType, _ENV
  if self._openType == openType then
    return 
  end
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  self._delegate = delegate
  self._target = target
  self._openType = openType
  if openType == OpenType.FILTER then
    self._conditions = select(1, ...)
    self._tag = "Filter"
    self:InitFilterType()
  else
    if openType == OpenType.SORT then
      self._nameId = select(1, ...)
      self._isTowerBattle = select(2, ...)
      self._tag = "Sort"
      self:InitSortType()
    end
  end
  if not self._show then
    (self._rootWindow):SetAnimatorInteger("isShow", 1)
    self._show = true
  end
end

FilterDialog.InitFilterType = function(self)
  -- function num : 0_5 , upvalues : TableFrame, _ENV
  self._frame = (TableFrame.Create)(self._framePanel, self, true, true, true)
  ;
  (self._frame):SetMargin(20, 20)
  local target = self._target
  if not target or target == "Equip" or target == "EquipBook" or target == "EquipChange" then
    self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipscreeningconditions")
  else
    if target == "EquipStrengthenItem" then
      self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipstrengthenitemscreeningconditions")
    else
      if target == "EquipEnchantItem" then
        self._cscreeningConditions = (BeanManager.GetTableByName)("equip.cequipenchantitemscreeningconditions")
      else
        if target == "Role" then
          self._cscreeningConditions = (BeanManager.GetTableByName)("role.cscreeningconditions")
        else
          if target == "SignBordRole" then
            self._cscreeningConditions = (BeanManager.GetTableByName)("role.cscreeningconditions")
          else
            if target == "Monster" then
              self._cscreeningConditions = (BeanManager.GetTableByName)("handbook.cmonster_handbookscreeningconditions")
            else
              if target == "SupportRole" then
                self._cscreeningConditions = (BeanManager.GetTableByName)("skill.cskillscreeningconditions")
              else
                if target == "RoleHandBook" then
                  self._cscreeningConditions = (BeanManager.GetTableByName)("handbook.cscreeningconditions_handbook")
                else
                  if target == "LoverChocolateRole" then
                    self._cscreeningConditions = (BeanManager.GetTableByName)("activity.cvalentinescreeningconditions")
                  else
                    if target == "SkinHandBook" then
                      self._cscreeningConditions = (BeanManager.GetTableByName)("recharge.cskinconditions")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  self._list = {}
  local map = {}
  for k,v in pairs((self._cscreeningConditions):GetAllIds()) do
    local record = (self._cscreeningConditions):GetRecorder(v)
    -- DECOMPILER ERROR at PC134: Unhandled construct in 'MakeBoolean' P1

    if target == "EquipBook" and (v == 5 or v == 6 or v == 7) then
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    end
    -- DECOMPILER ERROR at PC165: Unhandled construct in 'MakeBoolean' P1

    if target == "EquipChange" and v ~= 5 and v ~= 6 and v ~= 7 then
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    end
    if target == "RoleHandBook" then
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, value = record.value, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    else
      if not map[record.type] then
        map[record.type] = {mType = record.type, 
list = {}
, TypeNameId = record.typename, target = self._target}
      end
      ;
      (table.insert)((map[record.type]).list, record)
    end
  end
  for k,v in pairs(map) do
    (table.sort)(v.list, function(a, b)
    -- function num : 0_5_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (table.insert)(self._list, v)
  end
  ;
  (table.sort)(self._list, function(a, b)
    -- function num : 0_5_1
    do return a.mType < b.mType end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

FilterDialog.InitSortType = function(self)
  -- function num : 0_6 , upvalues : GridFrame, _ENV
  if self._target == "SignBordRole" then
    self._frame = (GridFrame.Create)(self._framePanel, self, true, 5)
  else
    self._frame = (GridFrame.Create)(self._framePanel, self, true, 3)
  end
  ;
  (self._frame):SetMargin(20, 20)
  local target = self._target
  if not target or target == "Equip" or target == "EquipChange" then
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
        else
          if target == "RoleHandBook" then
            self._csortCriteria = (BeanManager.GetTableByName)("handbook.ccardsortcriteria")
          else
            if target == "SignBordRole" then
              self._csortCriteria = (BeanManager.GetTableByName)("role.csortcriteria")
            else
              if target == "SkinHandBook" then
                self._csortCriteria = (BeanManager.GetTableByName)("recharge.cskincriteria")
              end
            end
          end
        end
      end
    end
  end
  self._list = {}
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
    -- function num : 0_6_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  self._shouldSendCUpdateUISortType = true
end

FilterDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_7
  (self._rootWindow):SetAnimatorInteger("isShow", 0)
  self._show = false
  self._openType = 0
  if self._shouldSendCUpdateUISortType then
    (self._delegate):SendCUpdateUISortType()
  end
end

FilterDialog.checkReset = function(self, objName)
  -- function num : 0_8 , upvalues : OpenType
  if (objName == "FliterBtn" and self._openType ~= OpenType.FILTER) or objName == "LevelBtn" and self._openType ~= OpenType.LEVEL then
    return true
  end
  return false
end

FilterDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not self._show then
    return 
  end
  local win1 = (args.userInfo).luaWindow
  if self._delegate then
    local fliterBtn = (self._delegate):GetChild("FliterBtn")
  end
  if self._delegate then
    local levelBtn = (self._delegate):GetChild("LevelBtn")
  end
  if self._delegate then
    local redPointFliterBtn = (self._delegate)._redPointBtn
  end
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    if (win1 == fliterBtn or win1 == levelBtn or win1 == redPointFliterBtn) and self._show then
      return 
    else
      if self._frame then
        (self._frame):Destroy()
        self._frame = nil
      end
      if self._show then
        self._openType = 0
        self._show = false
        ;
        (self._rootWindow):SetAnimatorInteger("isShow", 0)
      end
    end
  end
end

FilterDialog.GetRootWindow = function(self)
  -- function num : 0_10
  return self._rootWindow
end

FilterDialog.SetSelectedNameId = function(self, data)
  -- function num : 0_11 , upvalues : OpenType, _ENV
  if self._openType == OpenType.FILTER then
    local index = self:IsInFilterConditions(data.type, data.nameid)
    if index then
      (table.remove)((self._conditions)[data.type], index)
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      if not (self._conditions)[data.type] then
        (self._conditions)[data.type] = {}
      end
      ;
      (table.insert)((self._conditions)[data.type], data)
    end
    ;
    (self._frame):FireEvent("ChangeSelectNameId")
    ;
    (self._delegate):SetScreeningConditions(self._conditions)
  else
    do
      if self._openType == OpenType.SORT then
        self._nameId = data
        ;
        (self._frame):FireEvent("ChangeSelectNameId")
        ;
        (self._delegate):SetSortCriteriaNameId(self._nameId)
      end
    end
  end
end

FilterDialog.IsInFilterConditions = function(self, type, nameId)
  -- function num : 0_12 , upvalues : _ENV
  for k,v in pairs(self._conditions) do
    if k == type then
      for index,value in ipairs(v) do
        if value.nameid == nameId then
          return index
        end
      end
    end
  end
  return nil
end

FilterDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  return #self._list
end

FilterDialog.CellAtIndex = function(self, frame)
  -- function num : 0_14 , upvalues : OpenType
  if self._openType == OpenType.FILTER then
    if self._target == "SignBordRole" then
      return "common.signbordrolefilterframe"
    else
      if self._target == "EquipChange" then
        return "common.equipfilterframe"
      else
        return "common.filterframe"
      end
    end
  else
    if self._openType == OpenType.SORT then
      if self._target == "EquipChange" then
        return "common.equipfilterframecell"
      end
      return "common.filterframecell"
    end
  end
end

FilterDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  return (self._list)[index]
end

FilterDialog.ShouldLengthChange = function(self)
  -- function num : 0_16
  return true
end

FilterDialog.Destroy = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  self._rootWindow = nil
  self._list = nil
  self._openType = 0
  self._show = false
  ;
  (self._confirmBtn):Unsubscribe_PointerClickEvent(self.OnConfirmBtnClick)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

FilterDialog.ShouldLengthChange = function(self)
  -- function num : 0_18
  return true
end

return FilterDialog

