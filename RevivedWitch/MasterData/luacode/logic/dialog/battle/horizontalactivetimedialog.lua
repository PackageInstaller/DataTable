-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/horizontalactivetimedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HorizontalActiveTimeDialog = class("HorizontalActiveTimeDialog", Dialog)
HorizontalActiveTimeDialog.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeDialog.AssetName = "ATB"
HorizontalActiveTimeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HorizontalActiveTimeDialog
  ((HorizontalActiveTimeDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._cellFrame = nil
  self._activeCell = nil
  self._cellTable = nil
  self._backCellTable = nil
  self._animator = nil
  self._cellInfoTable = nil
  self._isReallyStart = nil
end

HorizontalActiveTimeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cellFrame = self:GetChild("CellFrame")
  self._activeCell = (DialogManager.CreateDialog)("battle.horizontalactivetimecurrentcell", (self:GetChild("CellFrame/Pos_0")):GetUIObject())
  ;
  (self._activeCell):SetActive(false)
  self._cellTable = {}
  self._backCellTable = {}
  local cellFrameGameObject = (self._cellFrame):GetUIObject()
  local cellFrameTransform = cellFrameGameObject.transform
  for i = 1, cellFrameTransform.childCount - 1 do
    local cellParentWindow = (self:GetChild("CellFrame/Pos_" .. i)):GetUIObject()
    local backCell = (DialogManager.CreateDialog)("battle.horizontalactivetimecell", cellParentWindow)
    backCell:SetActive(false)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._backCellTable)[i] = backCell
    local cell = (DialogManager.CreateDialog)("battle.horizontalactivetimecell", cellParentWindow)
    cell:SetActive(false)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self._cellTable)[i] = cell
  end
  self._animator = ((self._rootWindow):GetUIObject()):GetComponent("Animator")
  self._cellInfoTable = {}
  self._isReallyStart = false
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

HorizontalActiveTimeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

HorizontalActiveTimeDialog.OnBattleEnd = function(self)
  -- function num : 0_3
  self:Destroy()
end

HorizontalActiveTimeDialog.Show = function(self, show)
  -- function num : 0_4 , upvalues : _ENV
  ((self._rootWindow):GetUIObject()):SetActive(show)
  if show then
    for index,cell in ipairs(self._cellTable) do
      cell:SetActive(true)
      cell:Show()
      ;
      ((self._backCellTable)[index]):SetActive(true)
      ;
      ((self._backCellTable)[index]):Show()
    end
    ;
    (self._animator):SetTrigger("ATBShow")
  else
    ;
    (self._animator):SetTrigger("ATBHide")
  end
end

HorizontalActiveTimeDialog.SetActiveBattler = function(self, entityId, orientation, shapeId)
  -- function num : 0_5
  if self._isReallyStart == false then
    self._isReallyStart = true
    ;
    (self._activeCell):SetActive(true)
  end
  ;
  (self._activeCell):Refresh(entityId, orientation, shapeId)
end

HorizontalActiveTimeDialog.SetActiveTimeForecast = function(self, forecast)
  -- function num : 0_6 , upvalues : _ENV
  for index,info in ipairs(forecast) do
    local oldInfo = (self._cellInfoTable)[index]
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

    if oldInfo == nil then
      (self._cellInfoTable)[index] = info
      ;
      ((self._cellTable)[index]):Refresh(info)
    else
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

      if info.entityId ~= oldInfo.entityId then
        (self._cellInfoTable)[index] = info
        local backCell = (self._backCellTable)[index]
        local cell = (self._cellTable)[index]
        backCell:Refresh(info)
        backCell:In()
        cell:Out()
        local tempCell = backCell
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._backCellTable)[index] = cell
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self._cellTable)[index] = tempCell
      end
    end
  end
end

return HorizontalActiveTimeDialog

