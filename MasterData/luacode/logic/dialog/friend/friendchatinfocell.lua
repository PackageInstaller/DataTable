local UIManager = CS.PixelNeko.UI.UIManager
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CChatFrameConfig = BeanManager.GetTableByName("headphoto.cchatframeconfig")
local FriendChatInfoCell = class("FriendChatInfoCell", Dialog)
FriendChatInfoCell.AssetBundleName = "ui/layouts.friends"
FriendChatInfoCell.AssetName = "FriendsChatCellLeft"

function FriendChatInfoCell:Ctor(...)
  FriendChatInfoCell.super.Ctor(self, ...)
end

function FriendChatInfoCell:OnCreate()
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
  self._time = self:GetChild("Time")
  self._bubble = self:GetChild("Bubble")
  self._imageColor = self._bubble:GetColor()
  self._text = self:GetChild("Bubble/Text")
  self._reportBtn = self:GetChild("Bubble/ReportBtn")
  self._text:Subscribe_PointerClickEvent(self.OnTextClicked, self)
  self._reportBtn:Subscribe_PointerClickEvent(self.OnReportBtnClicked, self)
  self:GetChild("PlayerInfo/HeadPhoto/Grey"):SetActive(false)
  self._text:SetText("")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._bubble:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._bubble:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function FriendChatInfoCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function FriendChatInfoCell:RefreshCell(data)
  self._data = data
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._delegate:GetSelectedFriend())
  if not friend then
    return
  end
  self._reportBtn:SetActive(false)
  local imageinfo = friend:GetHeadImagePath()
  if imageinfo then
    self._icon:SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  local userNameStr
  if friend:GetSpiritVip() == 1 then
    userNameStr = NekoData.BehaviorManager.BM_Message:GetString(2090, {
      friend:GetName()
    })
  else
    userNameStr = friend:GetName()
  end
  self._name:SetText(userNameStr)
  self._nameLight:SetText(userNameStr)
  self._name:SetActive(friend:GetSpiritVip() ~= 1)
  self._nameLight:SetActive(friend:GetSpiritVip() == 1)
  local color = ""
  if data._bubbleID >= 0 then
    local record = CChatFrameConfig:GetRecorder(data._bubbleID)
    if record then
      color = record.color or ""
      local spriteRecord = CImagePath:GetRecorder(record.leftphotoid)
      if spriteRecord then
        self._bubble:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
      end
    end
  end
  self._level:SetText(friend:GetLevel())
  self._time:SetText(data:GetChatTimeStr())
  self._text:SetText(data:GetChatMsg(), color)
  self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
  local textWidth, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  elseif textWidth > self._width then
    local line = math.floor(textWidth / self._width)
    local delta = line * self._oneline
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    local delta = self._width - textWidth
    self._bubble:SetSize(self._text_size_x, self._text_size_offset_x - delta, self._text_size_y, self._text_size_offset_y)
    self._bubble:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
  end
  if data:GetChatTime() <= NekoData.BehaviorManager.BM_FriendsChat:GetFirstNotReadMsgTime(self._delegate:GetSelectedFriend()) then
    self._delegate:HideNewMsgUI()
  end
end

function FriendChatInfoCell:OnTextClicked()
  self._reportBtn:SetActive(true)
end

function FriendChatInfoCell:OnReportBtnClicked()
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._delegate:GetSelectedFriend())
  local data = {
    reportid = friend:GetID(),
    nickname = friend:GetName(),
    content = self._data:GetChatMsg(),
    time = self._data:GetChatTime() // 1000
  }
  DialogManager.CreateSingletonDialog("report.reportplayerdialog"):SetData(data)
  self._reportBtn:SetActive(false)
end

function FriendChatInfoCell:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._reportBtn._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self._reportBtn:SetActive(false)
  end
end

return FriendChatInfoCell
