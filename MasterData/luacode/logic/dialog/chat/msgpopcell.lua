local CChatConfig = BeanManager.GetTableByName("chat.cchatconfig")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local MsgPopCell = class("MsgPopCell", Dialog)
MsgPopCell.AssetBundleName = "ui/layouts.chat"
MsgPopCell.AssetName = "ChatNewSmallChatCell"

function MsgPopCell:Ctor(...)
  MsgPopCell.super.Ctor(self, ...)
end

function MsgPopCell:OnCreate()
  self._text = self:GetChild("Text")
  self._width, self._height = self._text:GetRectSize()
  self._size_x, self._size_offset_x, self._size_y, self._size_offset_y = self:GetRootWindow():GetSize()
  self._pos_x, self._pos_offset_x, self._pos_y, self._pos_offset_y = self:GetRootWindow():GetPosition()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self.text__pos_offset_y = self._text:GetPosition()
  self._fontSize = self._text:GetFontSize()
  self:GetRootWindow():Subscribe_PointerDownEvent(self.OnMsgClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
end

function MsgPopCell:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
  end
  if self._movetask then
    GameTimer.RemoveTask(self._movetask)
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function MsgPopCell:HideDialog()
  if self._task then
    GameTimer.RemoveTask(self._task)
  end
  if self._movetask then
    GameTimer.RemoveTask(self._movetask)
  end
  self._task = nil
  self._movetask = nil
  self.bHide = true
  self:SetActive(false)
end

function MsgPopCell:IsHide()
  return self.bHide
end

function MsgPopCell:Refresh(data)
  if data.channel == ChannelType.CHANNEL_WORLD then
    local msg = data.username .. ":" .. data.msg
    self._text:SetText(msg)
  else
    self._text:SetText(data.msg)
  end
  self._channelType = data.channel
  local textWidth, _ = self._text:GetPreferredSize()
  if self._movetask then
    GameTimer.RemoveTask(self._movetask)
    self._movetask = nil
  end
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if self._appearTask then
    self._appearTask = nil
  end
  if self._exitTask then
    self._exitTask = nil
  end
  if textWidth > self._width then
    self._text:SetSize(self._text_size_x, textWidth, self._text_size_y, self._text_size_offset_y)
    self._dextPosX = (textWidth - self._width) * -1
    self._movetask = GameTimer.AddTask(0, 0.05, function()
      self:LeftMove()
    end, nil)
  else
    self._text:SetXPosition(self._text_pos_x, self._text_pos_offset_x)
  end
  self._task = GameTimer.AddTask(CChatConfig:GetRecorder(1).chatpoptime, 0, function()
    self:HideDialog()
  end, nil)
  self:PlayAppearAnim()
  self:SetActive(true)
  self.bHide = false
end

function MsgPopCell:PlayAppearAnim()
  local first = {
    pos = -1 * self._height
  }
  local last = {pos = 0}
  self._appearTask = Tween.new(0.3, first, last, "linear")
end

function MsgPopCell:PlayExitAnim()
  if self._appearTask then
    self._appearTask = nil
  end
  local first = {pos = 0}
  local last = {
    pos = self._height
  }
  self._exitTask = Tween.new(0.3, first, last, "linear")
end

function MsgPopCell:OnLateUpdate(notification)
  if self._appearTask then
    if self._appearTask:update(notification.userInfo.deltaTime) then
      self:GetRootWindow():SetYPosition(self._pos_y, 0)
      self._appearTask = nil
    else
      self:GetRootWindow():SetYPosition(self._pos_y, self._appearTask.subject.pos)
    end
  end
  if self._exitTask then
    if self._exitTask:update(notification.userInfo.deltaTime) then
      self:GetRootWindow():SetYPosition(self._pos_y, self._height)
      self._exitTask = nil
      self:HideDialog()
    else
      self:GetRootWindow():SetYPosition(self._pos_y, self._exitTask.subject.pos)
    end
  end
end

function MsgPopCell:LeftMove()
  if not self._offect then
    self._offect = 0
  end
  self._offect = self._offect + self._fontSize / 4
  if self._text_pos_offset_x - self._offect < self._dextPosX then
    self._text:SetXPosition(self._text_pos_x, self._dextPosX)
  else
    self._text:SetXPosition(self._text_pos_x, self._text_pos_offset_x - self._offect)
  end
end

function MsgPopCell:OnMsgClick()
  local dialog = DialogManager.CreateSingletonDialog("chat.chatmaindialog")
  dialog:SelectChannel(self._channelType)
end

return MsgPopCell
