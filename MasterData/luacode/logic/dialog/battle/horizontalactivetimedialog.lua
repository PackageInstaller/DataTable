local HorizontalActiveTimeDialog = class("HorizontalActiveTimeDialog", Dialog)
HorizontalActiveTimeDialog.AssetBundleName = "ui/layouts.battle"
HorizontalActiveTimeDialog.AssetName = "ATB"

function HorizontalActiveTimeDialog:Ctor(...)
  HorizontalActiveTimeDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._cellFrame = nil
  self._activeCell = nil
  self._cellTable = nil
  self._backCellTable = nil
  self._animator = nil
  self._cellInfoTable = nil
  self._isReallyStart = nil
end

function HorizontalActiveTimeDialog:OnCreate()
  self._cellFrame = self:GetChild("CellFrame")
  self._activeCell = DialogManager.CreateDialog("battle.horizontalactivetimecurrentcell", self:GetChild("CellFrame/Pos_0"):GetUIObject())
  self._activeCell:SetActive(false)
  self._cellTable = {}
  self._backCellTable = {}
  local cellFrameGameObject = self._cellFrame:GetUIObject()
  local cellFrameTransform = cellFrameGameObject.transform
  for i = 1, cellFrameTransform.childCount - 1 do
    local cellParentWindow = self:GetChild("CellFrame/Pos_" .. i):GetUIObject()
    local backCell = DialogManager.CreateDialog("battle.horizontalactivetimecell", cellParentWindow)
    backCell:SetActive(false)
    self._backCellTable[i] = backCell
    local cell = DialogManager.CreateDialog("battle.horizontalactivetimecell", cellParentWindow)
    cell:SetActive(false)
    self._cellTable[i] = cell
  end
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  self._cellInfoTable = {}
  self._isReallyStart = false
  LuaNotificationCenter.AddObserver(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

function HorizontalActiveTimeDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function HorizontalActiveTimeDialog:OnBattleEnd()
  self:Destroy()
end

function HorizontalActiveTimeDialog:Show(show)
  self._rootWindow:GetUIObject():SetActive(show)
  if show then
    for index, cell in ipairs(self._cellTable) do
      cell:SetActive(true)
      cell:Show()
      self._backCellTable[index]:SetActive(true)
      self._backCellTable[index]:Show()
    end
    self._animator:SetTrigger("ATBShow")
  else
    self._animator:SetTrigger("ATBHide")
  end
end

function HorizontalActiveTimeDialog:SetActiveBattler(entityId, orientation, shapeId)
  if self._isReallyStart == false then
    self._isReallyStart = true
    self._activeCell:SetActive(true)
  end
  self._activeCell:Refresh(entityId, orientation, shapeId)
end

function HorizontalActiveTimeDialog:SetActiveTimeForecast(forecast)
  for index, info in ipairs(forecast) do
    local oldInfo = self._cellInfoTable[index]
    if oldInfo == nil then
      self._cellInfoTable[index] = info
      self._cellTable[index]:Refresh(info)
    elseif info.entityId ~= oldInfo.entityId then
      self._cellInfoTable[index] = info
      local backCell = self._backCellTable[index]
      local cell = self._cellTable[index]
      backCell:Refresh(info)
      backCell:In()
      cell:Out()
      local tempCell = backCell
      self._backCellTable[index] = cell
      self._cellTable[index] = tempCell
    end
  end
end

return HorizontalActiveTimeDialog
