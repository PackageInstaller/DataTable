local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local AttributeComponent = require("logic.battle.component.attributecomponent")
local CSharpBattlerComponent = require("logic.battle.component.csharpbattlercomponent")
local BuffComponent = require("logic.battle.component.buffcomponent")
local CCbuffConfigTable = BeanManager.GetTableByName("buff.ccbuffconfig")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local HPCell = class("HPCell", Dialog)
HPCell.AssetBundleName = "ui/layouts.battle"
HPCell.AssetName = "HPCell"

function HPCell:Ctor(...)
  HPCell.super.Ctor(self, ...)
  self._redMove = false
  self._greenMove = false
  self._redDelta = 0.01
  self._greenDelta = 0.08
  self._delayTime = 0.3
  self._greenTotalTime = 0.01
  self._readTotalTime = 0.5
  self._greenTask = nil
  self._redTask = nil
  self._redTaskNew = nil
  self._time = 0
  self._delay = false
  self._continualBuffs = {}
end

function HPCell:OnCreate()
  self._progressBar = self:GetChild("HPCell")
  self._buffFrameWindow = self:GetChild("BuffFrame")
  self._progressBar:Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  LuaNotificationCenter.AddObserver(self, self.OnHPChanged, Common.n_HpChanged, nil)
  self._frame = GridFrame.Create(self._buffFrameWindow, self, true, 4)
  self._frame:ReloadAllCell()
end

function HPCell:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function HPCell:OnAnimationEnd()
  if self._needDelete then
    self:Destroy()
  end
end

function HPCell:UpdatePosition()
  local csharpBattlerComponent = self._battler:GetComponent(CSharpBattlerComponent)
  local px, py, pz = TransformStaticFunctions.GetPosition(TransformStaticFunctions.GetChild(csharpBattlerComponent._object, "HitPoint_Head"))
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(nil, UIManager.WorldToScreenPointInMargin("BattleMain", px, py, pz))
  self:GetRootWindow():SetAnchoredPosition(x, y)
end

function HPCell:UpdateBuffs()
  local buffComponent = self._battler:GetComponent(BuffComponent)
  self._continualBuffs = {}
  for k, v in pairs(buffComponent._buffs) do
    local record = CCbuffConfigTable:GetRecorder(v:GetBuffId())
    if record and record.inbattle == 1 then
      table.insert(self._continualBuffs, record)
    end
  end
  self._frame:ReloadAllCell()
end

function HPCell:OnUpdate()
  self:UpdatePosition()
  self:UpdateBuffs()
  local delta = CS.UnityEngine.Time.deltaTime
  if self._delay then
    self._time = self._time + delta
    if self._time > self._delayTime then
      self._delay = false
      if self._redTaskNew then
        self._redTask = self._redTaskNew
        self._redTaskNew = nil
      end
    end
  end
  if self._redTask then
    if self._redTask:update(delta) then
      self._progressBar:SetSecondValue(self._redTask.subject.value)
      self._redTask = nil
    else
      self._progressBar:SetSecondValue(self._redTask.subject.value)
    end
  end
  if self._greenTask then
    if self._greenTask:update(delta) then
      self._progressBar:SetFirstValue(self._greenTask.subject.value)
      self._greenTask = nil
      self._delay = true
      self._time = 0
    else
      self._progressBar:SetFirstValue(self._greenTask.subject.value)
    end
  end
end

function HPCell:OnHPChanged(notification)
  if notification.userInfo.battler._entityId == self._battler._entityId then
    local attributeComponent = self._battler:GetComponent(AttributeComponent)
    if attributeComponent._hp == 0 then
      self:Show(false)
      self._needDelete = true
    end
    local greenStartValue = self._progressBar:GetFirstValue()
    if self._greenTask then
      greenStartValue = self._greenTask.target.value
      self._greenTask = nil
    end
    self._progressBar:SetFirstValue(greenStartValue)
    local greenEndValue = attributeComponent._hp / attributeComponent._hpMax
    self._greenTask = Tween.new(self._greenTotalTime, {value = greenStartValue}, {value = greenEndValue}, "linear")
    local redStartValue = greenStartValue
    local redEndValue = greenEndValue
    if self._redTaskNew then
      redStartValue = self._redTaskNew.subject.value
    end
    self._redTaskNew = Tween.new(self._readTotalTime, {value = redStartValue}, {value = redEndValue}, "outCubic")
  end
end

function HPCell:SetBattlerInfo(battler)
  local attributeComponent = battler:GetComponent(AttributeComponent)
  self:Show(true)
  self._battler = battler
  self._progressBar:SetFirstValue(attributeComponent._hp / attributeComponent._hpMax)
  self._progressBar:SetSecondValue(attributeComponent._hp / attributeComponent._hpMax)
  self:UpdatePosition()
end

function HPCell:Show(show)
  if show then
    self:GetRootWindow():PlayAnimation("HPCellShow")
  else
    self:GetRootWindow():PlayAnimation("HPCellHide")
  end
end

function HPCell:NumberOfCell(frame)
  return #self._continualBuffs
end

function HPCell:CellAtIndex(frame)
  return "battle.buffcell"
end

function HPCell:DataAtIndex(frame, index)
  return self._continualBuffs[index]
end

return HPCell
