local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local RockerDialog = class("RockerDialog", Dialog)
RockerDialog.AssetBundleName = "ui/layouts.playercontrols"
RockerDialog.AssetName = "ControlStick"

function RockerDialog:Ctor(...)
  RockerDialog.super.Ctor(self, ...)
  self._groupName = "Operation"
  self._rockerDisappear = true
  self._muteCount = 0
  self._moving = false
  self._width = 1
  self._height = 1
  self._axisVector = {x = 0, y = 1}
  self._axisOffset = 0
end

function RockerDialog:OnCreate()
  self:GetRootWindow():Subscribe_PointerDownEvent(self.OnPointerDown, self)
  self:GetRootWindow():Subscribe_PointerMoveEvent(self.OnPointerMove, self)
  self:GetRootWindow():Subscribe_PointerUpEvent(self.OnPointerUp, self)
  self:GetRootWindow():Subscribe_PointerCancelEvent(self.OnPointerCancel, self)
  self._image = self:GetChild("Image")
  self._stick = self:GetChild("Image/Stick")
  self._stickCancel = self:GetChild("Image/StickCancel")
  self._width, self._height = self._image:GetRectSize()
  self._sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  local rockerPos = CVarConfig:GetRecorder(29).Value
  self._pos = string.split(rockerPos, ",")
  self._pos[1] = tonumber(self._pos[1])
  self._pos[2] = tonumber(self._pos[2])
  local rockerRadius = CVarConfig:GetRecorder(30)
  self._radius = tonumber(rockerRadius.Value)
  self._animator = AnimatorStaticFunctions.Get(self:GetRootWindow()._uiObject)
  if self._sysConfig[SysConfigEnum.rockerType] == 0 then
    self._stick:SetActive(false)
    self._stickCancel:SetActive(false)
    self:GetRootWindow():PlayAnimation("Hide")
  else
    self._stick:SetActive(false)
    self._stickCancel:SetActive(true)
    self._animator:SetBool("Static", true)
    self:GetRootWindow():PlayAnimation("Hide1")
    local localPosX, localPosY = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, self._pos[1], self._pos[2])
    self._image:SetAnchoredPosition(localPosX, localPosY)
  end
  LuaNotificationCenter.AddObserver(self, self.OnRockerTypeChange, Common.n_RockerTypeChange, nil)
  NekoData.BehaviorManager.BM_Game:SetGMHideUIByDialog(DataCommon.GMHideUI.Dungeon, self)
end

function RockerDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function RockerDialog:OnPointerDown(args, luawindow)
  if self._muteCount == 0 then
    if self._sysConfig[SysConfigEnum.rockerType] == 0 then
      self._moving = true
      self._axisVector = {x = 0, y = 1}
      self._axisOffset = 0
      self._stickCancel:SetActive(false)
      self._stick:SetActive(true)
      self._animator:SetTrigger("OnPlayerTouch")
      local localPressX, localPressY = UIManager.ScreenPointToLocalPointInRectangle(luawindow._uiObject, args.position.x, args.position.y)
      self._image:SetAnchoredPosition(localPressX, localPressY)
      LuaNotificationCenter.PostNotification(Common.n_RockerBegin, RockerDialog, {
        axisVector = self._axisVector,
        axisOffset = self._axisOffset
      })
    else
      local screenEdgeWidth = UIManager.GetScreenEdgeWidth()
      local screenEdgeHeight = UIManager.GetScreenEdgeHeight()
      if (args.position.x - self._pos[1] - screenEdgeWidth) ^ 2 + (args.position.y - self._pos[2] - screenEdgeHeight) ^ 2 < self._radius ^ 2 then
        self._moving = true
        self._axisVector = {x = 0, y = 1}
        self._axisOffset = 0
        self._stickCancel:SetActive(false)
        self._stick:SetActive(true)
        self._animator:SetTrigger("OnPlayerTouch")
        local localPosX, localPosY = UIManager.ScreenPointToLocalPointInRectangle(luawindow._uiObject, self._pos[1] + screenEdgeWidth, self._pos[2] + screenEdgeHeight)
        self._image:SetAnchoredPosition(localPosX, localPosY)
        LuaNotificationCenter.PostNotification(Common.n_RockerBegin, RockerDialog, {
          axisVector = self._axisVector,
          axisOffset = self._axisOffset
        })
      end
    end
  end
end

function RockerDialog:OnPointerMove(args, luawindow)
  if self._muteCount == 0 and self._moving then
    local localPressX, localPressY = UIManager.ScreenPointToLocalPointInRectangle(self._image._uiObject, args.position.x, args.position.y)
    if 0 < localPressX ^ 2 + localPressY ^ 2 then
      local offsetX, offsetY = localPressX, localPressY
      local offsetDis = math.sqrt(offsetX ^ 2 + offsetY ^ 2)
      self._axisVector.x, self._axisVector.y = offsetX / offsetDis, offsetY / offsetDis
      self._axisOffset = 2 * offsetDis / self._width
      if self._axisOffset > 1 then
        self._axisOffset = 1
        offsetX = self._axisVector.x * self._width / 2
        offsetY = self._axisVector.y * self._width / 2
      end
      self._stick:SetAnchoredPosition(offsetX, offsetY)
    end
    LuaNotificationCenter.PostNotification(Common.n_RockerMove, RockerDialog, {
      axisVector = self._axisVector,
      axisOffset = self._axisOffset
    })
  end
end

function RockerDialog:OnPointerUp(args, luawindow)
  if self._muteCount == 0 and self._moving then
    self._moving = false
    self._animator:SetTrigger("OnDisappear")
    self._stick:SetAnchoredPosition(0, 0)
    self._stick:SetActive(false)
    self._stickCancel:SetActive(true)
    LuaNotificationCenter.PostNotification(Common.n_RockerEnd, RockerDialog, {
      axisVector = self._axisVector,
      axisOffset = self._axisOffset
    })
  end
end

function RockerDialog:OnPointerCancel(args, luawindow)
  if self._muteCount == 0 and self._moving then
    self._moving = false
    self._animator:SetTrigger("OnDisappear")
    self._stick:SetAnchoredPosition(0, 0)
    self._stickCancel:SetActive(true)
    self._stick:SetActive(false)
    LuaNotificationCenter.PostNotification(Common.n_RockerEnd, RockerDialog, {
      axisVector = self._axisVector,
      axisOffset = self._axisOffset
    })
  end
end

function RockerDialog:Mute()
  self._muteCount = self._muteCount + 1
  if self._moving then
    self._moving = false
    self._animator:SetTrigger("OnDisappear")
    self._stick:SetAnchoredPosition(0, 0)
    self._stick:SetActive(false)
    self._stickCancel:SetActive(true)
    LuaNotificationCenter.PostNotification(Common.n_RockerEnd, RockerDialog, {
      axisVector = self._axisVector,
      axisOffset = self._axisOffset
    })
  end
end

function RockerDialog:UnMute()
  self._muteCount = math.max(0, self._muteCount - 1)
end

function RockerDialog:IsMoving()
  return self._moving
end

function RockerDialog:OnRockerTypeChange(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  self._animator:SetBool("Static", not self._animator:GetBool("Static"))
  if self._sysConfig[SysConfigEnum.rockerType] == 0 then
    self:GetRootWindow():PlayAnimation("Hide")
  else
    self:GetRootWindow():PlayAnimation("Hide1")
    local localPosX, localPosY = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, self._pos[1], self._pos[2])
    self._image:SetAnchoredPosition(localPosX, localPosY)
  end
  self:OnPointerCancel(nil, nil)
end

function RockerDialog:SwichTipAnim(condition)
  if condition then
    self._animator:SetTrigger("GuideOn")
  else
    self._animator:SetTrigger("GuideOff")
  end
end

return RockerDialog
