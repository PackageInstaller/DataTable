-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/chat/chatselftimecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local FrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ChatSelfTimeCell = class("ChatSelfTimeCell", Dialog)
ChatSelfTimeCell.AssetBundleName = "ui/layouts.chat"
ChatSelfTimeCell.AssetName = "ChatNewCharCellRightTime"
ChatSelfTimeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChatSelfTimeCell
  ((ChatSelfTimeCell.super).Ctor)(self, ...)
  self._name = nil
  self._photo = nil
  self._info = nil
end

ChatSelfTimeCell.OnCreate = function(self)
  -- function num : 0_1
  self._time = self:GetChild("Time")
  self._photo = self:GetChild("PlayerInfo/HeadPhoto/Photo")
  self._frame = self:GetChild("PlayerInfo/HeadPhoto/Frame")
  self._name = self:GetChild("PlayerInfo/Name")
  self._level = self:GetChild("PlayerInfo/LvBack/Level")
  self._info = self:GetChild("Bubble/Text")
  self._talk = self:GetChild("Bubble")
  ;
  (self._info):Subscribe_BeginLongPressEvent(self.OnBeginLongPress, self)
  self._imageColor = (self._talk):GetColor()
  local _ = 0
  ;
  (self._info):SetText("")
  self._talk_size_x = (self._talk):GetSize()
  self._cell_size_x = (self:GetRootWindow()):GetSize()
  self._info_size_x = (self._info):GetSize()
  self._talkHeight = self._talk_size_y * self._cell_size_offset_y + self._talk_size_offset_y
  self._infoHeight = self._info_size_y * self._talkHeight + self._info_size_offset_y
end

ChatSelfTimeCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChatSelfTimeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadTable, ImageTable, _ENV, FrameTable
  local temp = HeadTable:GetRecorder(data.headid)
  do
    if temp then
      if not ImageTable:GetRecorder(temp.photoid) then
        local gamerInfo = DataCommon.DefaultImageAsset
      end
      ;
      (self._photo):SetSprite(gamerInfo.assetBundle, gamerInfo.assetName)
    end
    temp = FrameTable:GetRecorder(data.frameid)
    do
      if temp then
        if not ImageTable:GetRecorder(temp.photoid) then
          local gamerInfo = DataCommon.DefaultImageAsset
        end
        ;
        (self._frame):SetSprite(gamerInfo.assetBundle, gamerInfo.assetName)
      end
      do
        if data.username == "" then
          local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1217)).msgTextID)
          data.username = str
        end
        ;
        (self._name):SetText(data.username)
        ;
        (self._level):SetText(data.level)
        ;
        (self._info):SetText(data.msg)
        ;
        (self._time):SetText((ServerGameTimer.GetTimeHourMinStr)(data.receiveTime))
        local fontsize = (self._info):GetFontSize()
        local _, textheight = (self._info):GetPreferredSize()
        if self._infoHeight < textheight then
          local delta = textheight - self._infoHeight + 10
          ;
          (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y + delta)
        else
          do
            ;
            (self:GetRootWindow()):SetSize(self._cell_size_x, self._cell_size_offset_x, self._cell_size_y, self._cell_size_offset_y)
          end
        end
      end
    end
  end
end

ChatSelfTimeCell.OnBeginLongPress = function(self, args)
  -- function num : 0_4
  (self._delegate):SetColorInCell(self._talk, self._imageColor)
  local _1, x, _2, y = (self:GetRootWindow()):GetPosition()
  ;
  (self._delegate):CopyCellInfo(x, y, true, (self._info):GetText())
end

return ChatSelfTimeCell

