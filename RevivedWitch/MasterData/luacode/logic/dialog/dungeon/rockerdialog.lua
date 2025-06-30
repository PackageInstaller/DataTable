-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/rockerdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local RockerDialog = class("RockerDialog", Dialog)
RockerDialog.AssetBundleName = "ui/layouts.playercontrols"
RockerDialog.AssetName = "ControlStick"
RockerDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RockerDialog
  ((RockerDialog.super).Ctor)(self, ...)
  self._groupName = "Operation"
  self._rockerDisappear = true
  self._muteCount = 0
  self._moving = false
  self._width = 1
  self._height = 1
  self._axisVector = {x = 0, y = 1}
  self._axisOffset = 0
end

RockerDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CVarConfig, AnimatorStaticFunctions, SysConfigEnum, UIManager
  (self:GetRootWindow()):Subscribe_PointerDownEvent(self.OnPointerDown, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerMoveEvent(self.OnPointerMove, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerUpEvent(self.OnPointerUp, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerCancelEvent(self.OnPointerCancel, self)
  self._image = self:GetChild("Image")
  self._stick = self:GetChild("Image/Stick")
  self._stickCancel = self:GetChild("Image/StickCancel")
  self._width = (self._image):GetRectSize()
  self._sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  local rockerPos = (CVarConfig:GetRecorder(29)).Value
  self._pos = (string.split)(rockerPos, ",")
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._pos)[1] = tonumber((self._pos)[1])
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._pos)[2] = tonumber((self._pos)[2])
  local rockerRadius = CVarConfig:GetRecorder(30)
  self._radius = tonumber(rockerRadius.Value)
  self._animator = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  if (self._sysConfig)[SysConfigEnum.rockerType] == 0 then
    (self._stick):SetActive(false)
    ;
    (self._stickCancel):SetActive(false)
    ;
    (self:GetRootWindow()):PlayAnimation("Hide")
  else
    ;
    (self._stick):SetActive(false)
    ;
    (self._stickCancel):SetActive(true)
    ;
    (self._animator):SetBool("Static", true)
    ;
    (self:GetRootWindow()):PlayAnimation("Hide1")
    local localPosX, localPosY = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, (self._pos)[1], (self._pos)[2])
    ;
    (self._image):SetAnchoredPosition(localPosX, localPosY)
  end
  do
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRockerTypeChange, Common.n_RockerTypeChange, nil)
    ;
    ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).Dungeon, self)
  end
end

RockerDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

RockerDialog.OnPointerDown = function(self, args, luawindow)
  -- function num : 0_3 , upvalues : SysConfigEnum, UIManager, _ENV, RockerDialog
  if self._muteCount == 0 then
    if (self._sysConfig)[SysConfigEnum.rockerType] == 0 then
      self._moving = true
      self._axisVector = {x = 0, y = 1}
      self._axisOffset = 0
      ;
      (self._stickCancel):SetActive(false)
      ;
      (self._stick):SetActive(true)
      ;
      (self._animator):SetTrigger("OnPlayerTouch")
      local localPressX, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)(luawindow._uiObject, (args.position).x, (args.position).y)
      ;
      (self._image):SetAnchoredPosition(localPressX, localPressY)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RockerBegin, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
    else
      do
        local screenEdgeWidth = (UIManager.GetScreenEdgeWidth)()
        local screenEdgeHeight = (UIManager.GetScreenEdgeHeight)()
        if (args.position).x - (self._pos)[1] - screenEdgeWidth ^ 2 + (args.position).y - (self._pos)[2] - screenEdgeHeight ^ 2 < self._radius ^ 2 then
          self._moving = true
          self._axisVector = {x = 0, y = 1}
          self._axisOffset = 0
          ;
          (self._stickCancel):SetActive(false)
          ;
          (self._stick):SetActive(true)
          ;
          (self._animator):SetTrigger("OnPlayerTouch")
          local localPosX, localPosY = (UIManager.ScreenPointToLocalPointInRectangle)(luawindow._uiObject, (self._pos)[1] + screenEdgeWidth, (self._pos)[2] + screenEdgeHeight)
          ;
          (self._image):SetAnchoredPosition(localPosX, localPosY)
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_RockerBegin, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
        end
      end
    end
  end
end

RockerDialog.OnPointerMove = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : UIManager, _ENV, RockerDialog
  if self._muteCount == 0 and self._moving then
    local localPressX, localPressY = (UIManager.ScreenPointToLocalPointInRectangle)((self._image)._uiObject, (args.position).x, (args.position).y)
    if localPressX ^ 2 + localPressY ^ 2 > 0 then
      local offsetX, offsetY = localPressX, localPressY
      local offsetDis = (math.sqrt)(offsetX ^ 2 + offsetY ^ 2)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

      -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self._axisVector).x = offsetX / offsetDis
      self._axisOffset = 2 * offsetDis / self._width
      if self._axisOffset > 1 then
        self._axisOffset = 1
        offsetX = (self._axisVector).x * self._width / 2
        offsetY = (self._axisVector).y * self._width / 2
      end
      ;
      (self._stick):SetAnchoredPosition(offsetX, offsetY)
    end
    do
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RockerMove, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
    end
  end
end

RockerDialog.OnPointerUp = function(self, args, luawindow)
  -- function num : 0_5 , upvalues : _ENV, RockerDialog
  if self._muteCount == 0 and self._moving then
    self._moving = false
    ;
    (self._animator):SetTrigger("OnDisappear")
    ;
    (self._stick):SetAnchoredPosition(0, 0)
    ;
    (self._stick):SetActive(false)
    ;
    (self._stickCancel):SetActive(true)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RockerEnd, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
  end
end

RockerDialog.OnPointerCancel = function(self, args, luawindow)
  -- function num : 0_6 , upvalues : _ENV, RockerDialog
  if self._muteCount == 0 and self._moving then
    self._moving = false
    ;
    (self._animator):SetTrigger("OnDisappear")
    ;
    (self._stick):SetAnchoredPosition(0, 0)
    ;
    (self._stickCancel):SetActive(true)
    ;
    (self._stick):SetActive(false)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RockerEnd, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
  end
end

RockerDialog.Mute = function(self)
  -- function num : 0_7 , upvalues : _ENV, RockerDialog
  self._muteCount = self._muteCount + 1
  if self._moving then
    self._moving = false
    ;
    (self._animator):SetTrigger("OnDisappear")
    ;
    (self._stick):SetAnchoredPosition(0, 0)
    ;
    (self._stick):SetActive(false)
    ;
    (self._stickCancel):SetActive(true)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RockerEnd, RockerDialog, {axisVector = self._axisVector, axisOffset = self._axisOffset})
  end
end

RockerDialog.UnMute = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._muteCount = (math.max)(0, self._muteCount - 1)
end

RockerDialog.IsMoving = function(self)
  -- function num : 0_9
  return self._moving
end

RockerDialog.OnRockerTypeChange = function(self, notification)
  -- function num : 0_10 , upvalues : SysConfigEnum, UIManager
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  ;
  (self._animator):SetBool("Static", not (self._animator):GetBool("Static"))
  if (self._sysConfig)[SysConfigEnum.rockerType] == 0 then
    (self:GetRootWindow()):PlayAnimation("Hide")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("Hide1")
    local localPosX, localPosY = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, (self._pos)[1], (self._pos)[2])
    ;
    (self._image):SetAnchoredPosition(localPosX, localPosY)
  end
  do
    self:OnPointerCancel(nil, nil)
  end
end

RockerDialog.SwichTipAnim = function(self, condition)
  -- function num : 0_11
  if condition then
    (self._animator):SetTrigger("GuideOn")
  else
    ;
    (self._animator):SetTrigger("GuideOff")
  end
end

return RockerDialog

