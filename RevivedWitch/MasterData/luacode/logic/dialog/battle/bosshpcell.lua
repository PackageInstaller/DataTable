-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/bosshpcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local AttributeComponent = require("logic.battle.component.attributecomponent")
local CSharpBattlerComponent = require("logic.battle.component.csharpbattlercomponent")
local BuffComponent = require("logic.battle.component.buffcomponent")
local CCbuffConfigTable = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BossHPCell = class("BossHPCell", Dialog)
BossHPCell.AssetBundleName = "ui/layouts.battle"
BossHPCell.AssetName = "BossHP"
BossHPCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossHPCell
  ((BossHPCell.super).Ctor)(self, ...)
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

BossHPCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame
  self._progressBar = self:GetChild("HPBar/HPBarBoss")
  self._buffFrameWindow = self:GetChild("HPBar/BuffFrame")
  self._hpCurrent = self:GetChild("HPBar/HPNum/HPNum")
  self._hpMax = self:GetChild("HPBar/HPNum/MaxHP")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHPChanged, Common.n_HpChanged, nil)
  self._frame = (GridFrame.Create)(self._buffFrameWindow, self, true, 4)
  ;
  (self._frame):ReloadAllCell()
end

BossHPCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BossHPCell.OnAnimationEnd = function(self)
  -- function num : 0_3
  if self._needDelete then
    self:Destroy()
  end
end

BossHPCell.OnUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:UpdateBuffs()
  local delta = ((CS.UnityEngine).Time).deltaTime
  if self._delay then
    self._time = self._time + delta
    if self._delayTime < self._time then
      self._delay = false
      if self._redTaskNew then
        self._redTask = self._redTaskNew
        self._redTaskNew = nil
      end
    end
  end
  if self._redTask then
    if (self._redTask):update(delta) then
      (self._progressBar):SetSecondValue(((self._redTask).subject).value)
      self._redTask = nil
    else
      ;
      (self._progressBar):SetSecondValue(((self._redTask).subject).value)
    end
  end
  if self._greenTask then
    if (self._greenTask):update(delta) then
      (self._progressBar):SetFirstValue(((self._greenTask).subject).value)
      self._greenTask = nil
      self._delay = true
      self._time = 0
    else
      ;
      (self._progressBar):SetFirstValue(((self._greenTask).subject).value)
    end
  end
end

BossHPCell.OnHPChanged = function(self, notification)
  -- function num : 0_5 , upvalues : AttributeComponent, _ENV
  if ((notification.userInfo).battler)._entityId == (self._battler)._entityId then
    local attributeComponent = (self._battler):GetComponent(AttributeComponent)
    ;
    (self._hpCurrent):SetText(attributeComponent._hp)
    ;
    (self._hpMax):SetText(attributeComponent._hpMax)
    local greenStartValue = (self._progressBar):GetFirstValue()
    if self._greenTask then
      greenStartValue = ((self._greenTask).target).value
      self._greenTask = nil
    end
    ;
    (self._progressBar):SetFirstValue(greenStartValue)
    local greenEndValue = attributeComponent._hp / attributeComponent._hpMax
    self._greenTask = (Tween.new)(self._greenTotalTime, {value = greenStartValue}, {value = greenEndValue}, "linear")
    local redStartValue = greenStartValue
    local redEndValue = greenEndValue
    if self._redTaskNew then
      redStartValue = ((self._redTaskNew).subject).value
    end
    self._redTaskNew = (Tween.new)(self._readTotalTime, {value = redStartValue}, {value = redEndValue}, "outCubic")
  end
end

BossHPCell.SetBattlerInfo = function(self, battler)
  -- function num : 0_6 , upvalues : AttributeComponent
  local attributeComponent = battler:GetComponent(AttributeComponent)
  self._battler = battler
  ;
  (self._progressBar):SetFirstValue(attributeComponent._hp / attributeComponent._hpMax)
  ;
  (self._progressBar):SetSecondValue(attributeComponent._hp / attributeComponent._hpMax)
  ;
  (self._hpCurrent):SetText(attributeComponent._hp)
  ;
  (self._hpMax):SetText(attributeComponent._hpMax)
end

BossHPCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._continualBuffs
end

BossHPCell.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "battle.buffcell"
end

BossHPCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._continualBuffs)[index]
end

return BossHPCell

