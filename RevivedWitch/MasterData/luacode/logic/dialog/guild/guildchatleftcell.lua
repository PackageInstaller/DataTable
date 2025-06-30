-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildchatleftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local GuildChatLeftCell = class("GuildChatLeftCell", Dialog)
GuildChatLeftCell.AssetBundleName = "ui/layouts.guild"
GuildChatLeftCell.AssetName = "GuildChatLeft"
local SecToDay = 86400
local JobColor = {[1] = 29, [2] = 30, [3] = 31}
local GetTimeStr = function(ms)
  -- function num : 0_0 , upvalues : _ENV, SecToDay
  local interval = ((ServerGameTimer.GetServerTime)() - ms) // 1000
  local sec = ms // 1000
  if interval < SecToDay then
    local lt = (os.date)("*t", sec)
    return (string.format)("%02d:%02d", lt.hour, lt.min)
  else
    do
      if interval < SecToDay * 30 then
        local lt = (os.date)("*t", sec)
        return (string.format)("%02d-%02d %02d:%02d", lt.month, lt.day, lt.hour, lt.min)
      else
        do
          if interval < SecToDay * 30 * 12 then
            local lt = (os.date)("*t", sec)
            return (string.format)("%04d-%02d-%02d %02d:%02d", lt.year, lt.month, lt.day, lt.hour, lt.min)
          end
        end
      end
    end
  end
end

GuildChatLeftCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildChatLeftCell
  ((GuildChatLeftCell.super).Ctor)(self, ...)
end

GuildChatLeftCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._photo = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/Name")
  self._nameLight = self:GetChild("PlayerInfo/NameLight")
  self._job = self:GetChild("PlayerInfo/Position")
  self._jobText = self:GetChild("PlayerInfo/Position/Txt")
  ;
  (self._photoFrame):Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
  self._text = self:GetChild("Bubble/Text")
  self._bubble = self:GetChild("Bubble")
  self._time = self:GetChild("Time")
  self._lv = self:GetChild("LvBack/Level")
  self._width = (self._text):GetRectSize()
  local _ = 0
  _ = (self._text):GetPreferredSize()
  self._text_size_x = (self._bubble):GetSize()
  self._text_pos_x = (self._bubble):GetPosition()
  self._talk_size_x = (self:GetRootWindow()):GetSize()
  self._talk_pos_x = (self:GetRootWindow()):GetPosition()
  self._name_width = (self._name):GetRectSize()
  self._name_text_size_x = (self._name):GetSize()
  self._name_pos_x = (self._name):GetPosition()
  self._job_pos_x = (self._job):GetPosition()
  self._reportBtn = self:GetChild("Bubble/ReportBtn")
  ;
  (self._text):Subscribe_PointerClickEvent(self.OnTextClicked, R5_PC59)
  -- DECOMPILER ERROR at PC124: Overwrote pending register: R5 in 'AssignReg'

  ;
  (self._reportBtn):Subscribe_PointerClickEvent(self.OnReportBtnClicked, R5_PC59)
  -- DECOMPILER ERROR at PC130: Overwrote pending register: R5 in 'AssignReg'

  -- DECOMPILER ERROR at PC131: Overwrote pending register: R5 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, R5_PC59, nil)
end

GuildChatLeftCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

GuildChatLeftCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : HeadPhotoTable, CImagePath, _ENV, HeadPhotoFrameTable, JobColor, CWordColor, GetTimeStr
  self._data = data.data
  ;
  (self._reportBtn):SetActive(false)
  local imageRecord = nil
  local headPhotoRecord = HeadPhotoTable:GetRecorder(((self._data).baseUserData).avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildChatLeftCell", "userInfo.avatarId %s is wrong", ((self._data).baseUserData).avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(((self._data).baseUserData).frameId)
  if headPhotoFrameRecord then
    if not CImagePath:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildChatLeftCell", "userInfo.frameId %s is wrong", ((self._data).baseUserData).frameId)
  end
  ;
  (self._job):SetActive((self._data).position ~= 4)
  local jobstr = ((NekoData.BehaviorManager).BM_Guild):GetJobStr((self._data).position)
  local colorId = JobColor[(self._data).position]
  if colorId then
    jobstr = "<color=#" .. (CWordColor:GetRecorder(colorId)).wordcolor .. ">" .. jobstr .. "</color>"
    ;
    (self._jobText):SetText(jobstr)
  else
    (self._jobText):SetText(jobstr)
  end
  local userNameStr = nil
  if ((self._data).baseUserData).spiritvip == 1 then
    userNameStr = ((NekoData.BehaviorManager).BM_Message):GetString(2090, {((self._data).baseUserData).userName})
  else
    userNameStr = ((self._data).baseUserData).userName
  end
  ;
  (self._name):SetText(userNameStr)
  ;
  (self._nameLight):SetText(userNameStr)
  ;
  (self._name):SetActive(((self._data).baseUserData).spiritvip ~= 1)
  ;
  (self._nameLight):SetActive(((self._data).baseUserData).spiritvip == 1)
  local textWidth, textheight = (self._name):GetPreferredSize()
  local delta = self._name_width - textWidth
  ;
  (self._name):SetSize(self._name_text_size_x, self._name_text_size_offset_x - delta, self._name_text_size_y, self._name_text_size_offset_y)
  ;
  (self._nameLight):SetSize(self._name_text_size_x, self._name_text_size_offset_x - delta, self._name_text_size_y, self._name_text_size_offset_y)
  ;
  (self._job):SetPosition(self._job_pos_x, self._job_pos_offset_x - delta, self._job_pos_y, self._job_pos_offset_y)
  ;
  (self._lv):SetText(((self._data).baseUserData).userLv)
  ;
  (self._text):SetText((self._data).msg)
  ;
  (self._time):SetActive(data.showTime)
  if data.showTime then
    (self._time):SetText(GetTimeStr((self._data).sendTime))
  end
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
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

GuildChatLeftCell.OnPhotoClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = (((self._cellData).data).baseUserData).userId
  protocol:Send()
end

GuildChatLeftCell.OnTextClicked = function(self)
  -- function num : 0_6
  (self._reportBtn):SetActive(true)
end

GuildChatLeftCell.OnReportBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local data = {reportid = ((self._data).baseUserData).userId, nickname = ((self._data).baseUserData).userName, content = (self._data).msg, time = (self._data).sendTime // 1000, type = 3}
  ;
  ((DialogManager.CreateSingletonDialog)("report.reportplayerdialog")):SetData(data)
  ;
  (self._reportBtn):SetActive(false)
end

GuildChatLeftCell.OnEveryWhereClick = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._reportBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    (self._reportBtn):SetActive(false)
  end
end

return GuildChatLeftCell

