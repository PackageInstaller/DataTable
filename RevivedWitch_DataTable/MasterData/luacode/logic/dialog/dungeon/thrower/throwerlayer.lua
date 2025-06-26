-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/thrower/throwerlayer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local ThrowerLayer = class("ThrowerLayer", Dialog)
ThrowerLayer.AssetBundleName = "ui/layouts.dungeon"
ThrowerLayer.AssetName = "DungeonMagicBallControlStick"
local MAXLENGTH = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(33)).Value)
ThrowerLayer.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThrowerLayer
  ((ThrowerLayer.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._freeze = false
  self._doing = false
end

ThrowerLayer.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, AnimatorStaticFunctions
  self._back = self:GetChild("BackBtn")
  self._imgFrame = self:GetChild("Image")
  self._stickImg = self:GetChild("Image/Stick")
  self._stickCancelImg = self:GetChild("Image/StickCancel")
  self._stickMaxLengthR = (self._imgFrame):GetRectSize()
  self._stickMaxLengthR = self._stickMaxLengthR / 2
  self._oriX = (self._imgFrame):GetAnchoredPosition()
  self._stickX = (self._stickImg):GetPosition()
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackClick, R4_PC31)
  -- DECOMPILER ERROR at PC44: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_BeginDragEvent(self.OnPointerDown, R4_PC31)
  -- DECOMPILER ERROR at PC50: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_DragEvent(self.OnPointerMove, R4_PC31)
  -- DECOMPILER ERROR at PC56: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_EndDragEvent(self.OnPointerUp, R4_PC31)
  -- DECOMPILER ERROR at PC62: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_CancelDragEvent(self.OnPointerUp, R4_PC31)
  -- DECOMPILER ERROR at PC68: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_PointerCancelEvent(self.OnPointerUp, R4_PC31)
  -- DECOMPILER ERROR at PC74: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC75: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnImpactHit, R4_PC31, nil)
  self._animator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  -- DECOMPILER ERROR at PC87: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._animator):SetBool("Static", R4_PC31)
  ;
  (self:GetRootWindow()):PlayAnimation("Hide")
end

ThrowerLayer.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : ThrowerLayer, _ENV
  ((ThrowerLayer.super).OnDestroy)(self)
  if self._task then
    (GameTimer.RemoveTask)(self._task)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._event then
    (EventManager.RemoveEvent)((self._event):GetID())
  end
end

local impact_empty = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("collision", (self._event):GetID(), "trap -1")
  ;
  (self._event):AddTrigger(trigger:GetType(), trigger)
  ;
  (self._event):AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : self
    self._event = nil
    self:OnImpactEmpty()
  end
))
  ;
  (EventManager.AddEvent)(self._event)
end

ThrowerLayer.SetData = function(self, catapult)
  -- function num : 0_4 , upvalues : _ENV, impact_empty
  self._catapult = catapult
  ;
  (self._catapult):SetPreviewAsset(1064)
  ;
  (self._catapult):SetShellAsset(1065)
  ;
  (self._catapult):SetTargetAsset(1066)
  local info = catapult:GetThrowerInfo()
  self._range = info.range
  self._rangeValue = {max = (math.cos)((info.range).min), min = (math.cos)((info.range).max)}
  self._maxPower = info.maxpower
  impact_empty(self)
end

ThrowerLayer.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV, MAXLENGTH
  if not (self._start).x then
    return 
  end
  if (self._start).x < (self._current).x then
    return 
  end
  local length = (math.sqrt)((self._current).x - (self._start).x ^ 2 + (self._current).y - (self._start).y ^ 2)
  self._power = (math.min)(1, length / MAXLENGTH) * self._maxPower
  local angle = ((self._current).y - (self._start).y) / length
  if angle < (self._rangeValue).min then
    self._angle = (self._rangeValue).min
  else
    if angle < (self._rangeValue).max then
      self._angle = angle
    else
      self._angle = (self._rangeValue).max
    end
  end
  ;
  (self._catapult):SetPreviewParameter((math.acos)(self._angle), self._power)
  local stickLength = (math.min)(1, length / MAXLENGTH) * self._stickMaxLengthR
  ;
  (self._stickImg):SetPosition(self._stickX, self._stickOX - stickLength * (math.abs)((self._current).x - (self._start).x) / length, self._stickY, self._stickOY + stickLength * self._angle)
end

ThrowerLayer.OnPointerDown = function(self, args, luawindow)
  -- function num : 0_6 , upvalues : UIManager
  if self._freeze then
    return 
  end
  self._doing = true
  ;
  (self._stickCancelImg):SetActive(false)
  ;
  (self._stickImg):SetActive(true)
  ;
  (self._animator):SetTrigger("OnPlayerTouch")
  local localPressX, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)(luawindow._uiObject, (args.pressPosition).x, (args.pressPosition).y)
  ;
  (self._imgFrame):SetAnchoredPosition(localPressX, localPressY)
  self._start = {x = (args.pressPosition).x, y = (args.pressPosition).y}
  self._current = nil
  ;
  (self._back):SetActive(false)
end

ThrowerLayer.OnPointerMove = function(self, args)
  -- function num : 0_7
  if self._freeze or not self._doing then
    return 
  end
  self._current = {x = (args.position).x, y = (args.position).y}
  self:Refresh()
end

ThrowerLayer.OnPointerUp = function(self, args)
  -- function num : 0_8 , upvalues : _ENV
  if self._freeze or not self._doing then
    return 
  end
  self._doing = false
  ;
  (self._animator):SetTrigger("OnDisappear")
  ;
  (self._stickImg):SetActive(false)
  ;
  (self._stickCancelImg):SetActive(false)
  ;
  (self._stickImg):SetPosition(self._stickX, self._stickOX, self._stickY, self._stickOY)
  self._last = {angle = self._angle, power = self._power}
  local timeout = (self._catapult):Fire()
  print("timeout", timeout)
  self._start = {}
  self._current = {}
  self._freeze = true
end

ThrowerLayer.OnBackClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._freeze or self._doing then
    return 
  end
  ;
  ((self._catapult):ToState(0)):Run()
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.thrower.throwerlayer")
end

local send = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cmagiclauncher")
  req.instanceId = (self._catapult):GetInstanceID()
  req.launcherId = (self._catapult):GetID()
  req.targetId = id
  req.power = (self._last).power or 0
  req.direction = (self._last).angle or 0
  req:Send()
end

local shell_path = "CatapultRoot/shell"
ThrowerLayer.OnImpactHit = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV, shell_path, send
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(shell_path, "hited", 1)
  effect:SetParam("raw")
  effect:Run()
  effect:Then(function()
    -- function num : 0_11_0 , upvalues : _ENV, shell_path, send, self, notification
    ((EffectFactory.CreateVisualEffect)(shell_path, false)):Run()
    send(self, (notification.userInfo):GetID())
    ;
    (self._back):SetActive(true)
    self._freeze = false
  end
)
end

ThrowerLayer.OnImpactEmpty = function(self)
  -- function num : 0_12 , upvalues : _ENV, shell_path, send, impact_empty
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(shell_path, "hited", 1)
  effect:SetParam("raw")
  effect:Run()
  effect:Then(function()
    -- function num : 0_12_0 , upvalues : _ENV, shell_path, send, self, impact_empty
    ((EffectFactory.CreateVisualEffect)(shell_path, false)):Run()
    send(self, -1)
    impact_empty(self)
    ;
    (self._back):SetActive(true)
    self._freeze = false
  end
)
end

return ThrowerLayer

