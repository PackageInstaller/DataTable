-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/msgpopcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CChatConfig = (BeanManager.GetTableByName)("chat.cchatconfig")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local MsgPopCell = class("MsgPopCell", Dialog)
MsgPopCell.AssetBundleName = "ui/layouts.chat"
MsgPopCell.AssetName = "ChatNewSmallChatCell"
MsgPopCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MsgPopCell
  ((MsgPopCell.super).Ctor)(self, ...)
end

MsgPopCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._text = self:GetChild("Text")
  self._width = (self._text):GetRectSize()
  self._size_x = (self:GetRootWindow()):GetSize()
  self._pos_x = (self:GetRootWindow()):GetPosition()
  self._text_size_x = (self._text):GetSize()
  self._text_pos_x = (self._text):GetPosition()
  self._fontSize = (self._text):GetFontSize()
  ;
  (self:GetRootWindow()):Subscribe_PointerDownEvent(self.OnMsgClick, R4_PC13)
  -- DECOMPILER ERROR at PC53: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC54: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLateUpdate, R4_PC13, nil)
end

MsgPopCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
  end
  if self._movetask then
    (GameTimer.RemoveTask)(self._movetask)
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MsgPopCell.HideDialog = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
  end
  if self._movetask then
    (GameTimer.RemoveTask)(self._movetask)
  end
  self._task = nil
  self._movetask = nil
  self.bHide = true
  self:SetActive(false)
end

MsgPopCell.IsHide = function(self)
  -- function num : 0_4
  return self.bHide
end

MsgPopCell.Refresh = function(self, data)
  -- function num : 0_5 , upvalues : ChannelType, _ENV, CChatConfig
  if data.channel == ChannelType.CHANNEL_WORLD then
    local msg = data.username .. ":" .. data.msg
    ;
    (self._text):SetText(msg)
  else
    do
      ;
      (self._text):SetText(data.msg)
      self._channelType = data.channel
      local textWidth, _ = (self._text):GetPreferredSize()
      if self._movetask then
        (GameTimer.RemoveTask)(self._movetask)
        self._movetask = nil
      end
      if self._task then
        (GameTimer.RemoveTask)(self._task)
        self._task = nil
      end
      if self._appearTask then
        self._appearTask = nil
      end
      if self._exitTask then
        self._exitTask = nil
      end
      if self._width < textWidth then
        (self._text):SetSize(self._text_size_x, textWidth, self._text_size_y, self._text_size_offset_y)
        self._dextPosX = (textWidth - self._width) * -1
        self._movetask = (GameTimer.AddTask)(0, 0.05, function()
    -- function num : 0_5_0 , upvalues : self
    self:LeftMove()
  end
, nil)
      else
        ;
        (self._text):SetXPosition(self._text_pos_x, self._text_pos_offset_x)
      end
      self._task = (GameTimer.AddTask)((CChatConfig:GetRecorder(1)).chatpoptime, 0, function()
    -- function num : 0_5_1 , upvalues : self
    self:HideDialog()
  end
, nil)
      self:PlayAppearAnim()
      self:SetActive(true)
      self.bHide = false
    end
  end
end

MsgPopCell.PlayAppearAnim = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local first = {pos = -1 * self._height}
  local last = {pos = 0}
  self._appearTask = (Tween.new)(0.3, first, last, "linear")
end

MsgPopCell.PlayExitAnim = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._appearTask then
    self._appearTask = nil
  end
  local first = {pos = 0}
  local last = {pos = self._height}
  self._exitTask = (Tween.new)(0.3, first, last, "linear")
end

MsgPopCell.OnLateUpdate = function(self, notification)
  -- function num : 0_8
  if self._appearTask then
    if (self._appearTask):update((notification.userInfo).deltaTime) then
      (self:GetRootWindow()):SetYPosition(self._pos_y, 0)
      self._appearTask = nil
    else
      ;
      (self:GetRootWindow()):SetYPosition(self._pos_y, ((self._appearTask).subject).pos)
    end
  end
  if self._exitTask then
    if (self._exitTask):update((notification.userInfo).deltaTime) then
      (self:GetRootWindow()):SetYPosition(self._pos_y, self._height)
      self._exitTask = nil
      self:HideDialog()
    else
      ;
      (self:GetRootWindow()):SetYPosition(self._pos_y, ((self._exitTask).subject).pos)
    end
  end
end

MsgPopCell.LeftMove = function(self)
  -- function num : 0_9
  if not self._offect then
    self._offect = 0
  end
  self._offect = self._offect + self._fontSize / 4
  if self._text_pos_offset_x - self._offect < self._dextPosX then
    (self._text):SetXPosition(self._text_pos_x, self._dextPosX)
  else
    ;
    (self._text):SetXPosition(self._text_pos_x, self._text_pos_offset_x - self._offect)
  end
end

MsgPopCell.OnMsgClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("chat.chatmaindialog")
  dialog:SelectChannel(self._channelType)
end

return MsgPopCell

