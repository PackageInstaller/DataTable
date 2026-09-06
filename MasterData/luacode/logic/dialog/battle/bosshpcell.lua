local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local AttributeComponent = require("logic.battle.component.attributecomponent")
local CSharpBattlerComponent = require("logic.battle.component.csharpbattlercomponent")
local BuffComponent = require("logic.battle.component.buffcomponent")
local CCbuffConfigTable = BeanManager.GetTableByName("buff.ccbuffconfig")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BossHPCell = class("BossHPCell", Dialog)
BossHPCell.AssetBundleName = "ui/layouts.battle"
BossHPCell.AssetName = "BossHP"

function BossHPCell:Ctor(...)
  BossHPCell.super.Ctor(self, ...)
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

function BossHPCell:OnCreate()
  self._progressBar = self:GetChild("HPBar/HPBarBoss")
  self._buffFrameWindow = self:GetChild("HPBar/BuffFrame")
  self._hpCurrent = self:GetChild("HPBar/HPNum/HPNum")
  self._hpMax = self:GetChild("HPBar/HPNum/MaxHP")
  LuaNotificationCenter.AddObserver(self, self.OnHPChanged, Common.n_HpChanged, nil)
  self._frame = GridFrame.Create(self._buffFrameWindow, self, true, 4)
  self._frame:ReloadAllCell()
end

function BossHPCell:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BossHPCell:OnAnimationEnd()
  if self._needDelete then
    self:Destroy()
  end
end

function BossHPCell:OnUpdate()
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

function BossHPCell:OnHPChanged(notification)
  if notification.userInfo.battler._entityId == self._battler._entityId then
    local attributeComponent = self._battler:GetComponent(AttributeComponent)
    self._hpCurrent:SetText(attributeComponent._hp)
    self._hpMax:SetText(attributeComponent._hpMax)
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

function BossHPCell:SetBattlerInfo(battler)
  local attributeComponent = battler:GetComponent(AttributeComponent)
  self._battler = battler
  self._progressBar:SetFirstValue(attributeComponent._hp / attributeComponent._hpMax)
  self._progressBar:SetSecondValue(attributeComponent._hp / attributeComponent._hpMax)
  self._hpCurrent:SetText(attributeComponent._hp)
  self._hpMax:SetText(attributeComponent._hpMax)
end

function BossHPCell:NumberOfCell(frame)
  return #self._continualBuffs
end

function BossHPCell:CellAtIndex(frame)
  return "battle.buffcell"
end

function BossHPCell:DataAtIndex(frame, index)
  return self._continualBuffs[index]
end

return BossHPCell
