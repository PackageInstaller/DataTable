-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/friendchatinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local FriendChatInfoCell = class("FriendChatInfoCell", Dialog)
FriendChatInfoCell.AssetBundleName = "ui/layouts.friends"
FriendChatInfoCell.AssetName = "FriendsChatCellLeft"
FriendChatInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FriendChatInfoCell
  ((FriendChatInfoCell.super).Ctor)(self, ...)
end

FriendChatInfoCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._icon = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._name = self:GetChild("PlayerInfo/HeadPhoto/Name")
  self._nameLight = self:GetChild("PlayerInfo/HeadPhoto/NameLight")
  self._time = self:GetChild("Time")
  self._bubble = self:GetChild("Bubble")
  self._imageColor = (self._bubble):GetColor()
  self._text = self:GetChild("Bubble/Text")
  self._reportBtn = self:GetChild("Bubble/ReportBtn")
  ;
  (self._text):Subscribe_PointerClickEvent(self.OnTextClicked, self)
  ;
  (self._reportBtn):Subscribe_PointerClickEvent(self.OnReportBtnClicked, self)
  ;
  (self:GetChild("PlayerInfo/HeadPhoto/Grey")):SetActive(false)
  ;
  (self._text):SetText("")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._bubble):GetSize()
  self._text_pos_x = (self._bubble):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
  -- DECOMPILER ERROR at PC102: Overwrote pending register: R5 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, R5_PC70, nil)
end

FriendChatInfoCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

FriendChatInfoCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((self._delegate):GetSelectedFriend())
  if not friend then
    return 
  end
  ;
  (self._reportBtn):SetActive(false)
  local imageinfo = friend:GetHeadImagePath()
  if imageinfo then
    (self._icon):SetSprite(imageinfo.assetBundle, imageinfo.assetName)
  end
  local userNameStr = nil
  if friend:GetSpiritVip() == 1 then
    userNameStr = ((NekoData.BehaviorManager).BM_Message):GetString(2090, {friend:GetName()})
  else
    userNameStr = friend:GetName()
  end
  ;
  (self._name):SetText(userNameStr)
  ;
  (self._nameLight):SetText(userNameStr)
  ;
  (self._name):SetActive(friend:GetSpiritVip() ~= 1)
  ;
  (self._nameLight):SetActive(friend:GetSpiritVip() == 1)
  ;
  (self._level):SetText(friend:GetLevel())
  ;
  (self._time):SetText(data:GetChatTimeStr())
  ;
  (self._text):SetText(data:GetChatMsg())
  ;
  (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
  local textWidth, textheight = (self._text):GetPreferredSize()
  if self._height < textheight then
    local line = (math.ceil)((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    ;
    (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  elseif self._width < textWidth then
    local line = (math.floor)(textWidth / self._width)
    local delta = line * self._oneline
    ;
    (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    ;
    (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    local delta = self._width - textWidth
    ;
    (self._bubble):SetSize(self._text_size_x, self._text_size_offset_x - delta, self._text_size_y, self._text_size_offset_y)
    ;
    (self._bubble):SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    ;
    (self:GetRootWindow()):SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
  end
  if data:GetChatTime() <= ((NekoData.BehaviorManager).BM_FriendsChat):GetFirstNotReadMsgTime((self._delegate):GetSelectedFriend()) then
    (self._delegate):HideNewMsgUI()
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

FriendChatInfoCell.OnTextClicked = function(self)
  -- function num : 0_4
  (self._reportBtn):SetActive(true)
end

FriendChatInfoCell.OnReportBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend((self._delegate):GetSelectedFriend())
  local data = {reportid = friend:GetID(), nickname = friend:GetName(), content = (self._data):GetChatMsg(), time = (self._data):GetChatTime() // 1000}
  ;
  ((DialogManager.CreateSingletonDialog)("report.reportplayerdialog")):SetData(data)
  ;
  (self._reportBtn):SetActive(false)
end

FriendChatInfoCell.OnEveryWhereClick = function(self, args)
  -- function num : 0_6 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._reportBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    (self._reportBtn):SetActive(false)
  end
end

return FriendChatInfoCell

