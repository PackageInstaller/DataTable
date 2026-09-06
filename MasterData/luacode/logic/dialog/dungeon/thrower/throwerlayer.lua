local UIManager = CS.PixelNeko.UI.UIManager
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local ThrowerLayer = class("ThrowerLayer", Dialog)
ThrowerLayer.AssetBundleName = "ui/layouts.dungeon"
ThrowerLayer.AssetName = "DungeonMagicBallControlStick"
local MAXLENGTH = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(33).Value)

function ThrowerLayer:Ctor(...)
  ThrowerLayer.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._freeze = false
  self._doing = false
end

function ThrowerLayer:OnCreate()
  self._back = self:GetChild("BackBtn")
  self._imgFrame = self:GetChild("Image")
  self._stickImg = self:GetChild("Image/Stick")
  self._stickCancelImg = self:GetChild("Image/StickCancel")
  self._stickMaxLengthR = self._imgFrame:GetRectSize()
  self._stickMaxLengthR = self._stickMaxLengthR / 2
  self._oriX, self._oriY = self._imgFrame:GetAnchoredPosition()
  self._stickX, self._stickOX, self._stickY, self._stickOY = self._stickImg:GetPosition()
  self._back:Subscribe_PointerClickEvent(self.OnBackClick, self)
  self:GetRootWindow():Subscribe_BeginDragEvent(self.OnPointerDown, self)
  self:GetRootWindow():Subscribe_DragEvent(self.OnPointerMove, self)
  self:GetRootWindow():Subscribe_EndDragEvent(self.OnPointerUp, self)
  self:GetRootWindow():Subscribe_CancelDragEvent(self.OnPointerUp, self)
  self:GetRootWindow():Subscribe_PointerCancelEvent(self.OnPointerUp, self)
  LuaNotificationCenter.AddObserver(self, self.OnImpactHit, Common.n_ImpactHit, nil)
  self._animator = AnimatorStaticFunctions.Get(self:GetRootWindow()._uiObject)
  self._animator:SetBool("Static", true)
  self:GetRootWindow():PlayAnimation("Hide")
end

function ThrowerLayer:OnDestroy()
  ThrowerLayer.super.OnDestroy(self)
  if self._task then
    GameTimer.RemoveTask(self._task)
  end
  LuaNotificationCenter.RemoveObserver(self)
  if self._event then
    EventManager.RemoveEvent(self._event:GetID())
  end
end

local function impact_empty(self)
  self._event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("collision", self._event:GetID(), "trap -1")
  self._event:AddTrigger(trigger:GetType(), trigger)
  self._event:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._event = nil
    self:OnImpactEmpty()
  end))
  EventManager.AddEvent(self._event)
end

function ThrowerLayer:SetData(catapult)
  self._catapult = catapult
  self._catapult:SetPreviewAsset(1064)
  self._catapult:SetShellAsset(1065)
  self._catapult:SetTargetAsset(1066)
  local info = catapult:GetThrowerInfo()
  self._range = info.range
  self._rangeValue = {
    max = math.cos(info.range.min),
    min = math.cos(info.range.max)
  }
  self._maxPower = info.maxpower
  impact_empty(self)
end

function ThrowerLayer:Refresh()
  if not self._start.x then
    return
  end
  if self._current.x > self._start.x then
    return
  end
  local length = math.sqrt((self._current.x - self._start.x) ^ 2 + (self._current.y - self._start.y) ^ 2)
  self._power = math.min(1, length / MAXLENGTH) * self._maxPower
  local angle = (self._current.y - self._start.y) / length
  if angle < self._rangeValue.min then
    self._angle = self._rangeValue.min
  elseif angle < self._rangeValue.max then
    self._angle = angle
  else
    self._angle = self._rangeValue.max
  end
  self._catapult:SetPreviewParameter(math.acos(self._angle), self._power)
  local stickLength = math.min(1, length / MAXLENGTH) * self._stickMaxLengthR
  self._stickImg:SetPosition(self._stickX, self._stickOX - stickLength * math.abs(self._current.x - self._start.x) / length, self._stickY, self._stickOY + stickLength * self._angle)
end

function ThrowerLayer:OnPointerDown(args, luawindow)
  if self._freeze then
    return
  end
  self._doing = true
  self._stickCancelImg:SetActive(false)
  self._stickImg:SetActive(true)
  self._animator:SetTrigger("OnPlayerTouch")
  local localPressX, localPressY = UIManager.ScreenPointToLocalPointInRectangle(luawindow._uiObject, args.pressPosition.x, args.pressPosition.y)
  self._imgFrame:SetAnchoredPosition(localPressX, localPressY)
  self._start = {
    x = args.pressPosition.x,
    y = args.pressPosition.y
  }
  self._current = nil
  self._back:SetActive(false)
end

function ThrowerLayer:OnPointerMove(args)
  if self._freeze or not self._doing then
    return
  end
  self._current = {
    x = args.position.x,
    y = args.position.y
  }
  self:Refresh()
end

function ThrowerLayer:OnPointerUp(args)
  if self._freeze or not self._doing then
    return
  end
  self._doing = false
  self._animator:SetTrigger("OnDisappear")
  self._stickImg:SetActive(false)
  self._stickCancelImg:SetActive(false)
  self._stickImg:SetPosition(self._stickX, self._stickOX, self._stickY, self._stickOY)
  self._last = {
    angle = self._angle,
    power = self._power
  }
  local timeout = self._catapult:Fire()
  print("timeout", timeout)
  self._start = {}
  self._current = {}
  self._freeze = true
end

function ThrowerLayer:OnBackClick()
  if self._freeze or self._doing then
    return
  end
  self._catapult:ToState(0):Run()
  DialogManager.DestroySingletonDialog("dungeon.thrower.throwerlayer")
end

local function send(self, id)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cmagiclauncher")
  req.instanceId = self._catapult:GetInstanceID()
  req.launcherId = self._catapult:GetID()
  req.targetId = id
  req.power = self._last.power or 0
  req.direction = self._last.angle or 0
  req:Send()
end

local shell_path = "CatapultRoot/shell"

function ThrowerLayer:OnImpactHit(notification)
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(shell_path, "hited", 1)
  effect:SetParam("raw")
  effect:Run()
  effect:Then(function()
    EffectFactory.CreateVisualEffect(shell_path, false):Run()
    send(self, notification.userInfo:GetID())
    self._back:SetActive(true)
    self._freeze = false
  end)
end

function ThrowerLayer:OnImpactEmpty()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(shell_path, "hited", 1)
  effect:SetParam("raw")
  effect:Run()
  effect:Then(function()
    EffectFactory.CreateVisualEffect(shell_path, false):Run()
    send(self, -1)
    impact_empty(self)
    self._back:SetActive(true)
    self._freeze = false
  end)
end

return ThrowerLayer
