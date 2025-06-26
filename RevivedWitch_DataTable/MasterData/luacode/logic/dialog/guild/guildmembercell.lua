-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildmembercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
local GetTimeStr = function(ms)
  -- function num : 0_0 , upvalues : SecToDay, _ENV, CStringRes, SecToHour
  local sec = ms // 1000
  local str = nil
  if SecToDay * 7 < sec then
    sec = SecToDay * 7 - 1
    str = (TextManager.GetText)((CStringRes:GetRecorder(1463)).msgTextID)
    local day = (os.date)("!%d", sec)
    str = (string.gsub)(str, "%$parameter1%$", tonumber(day))
  else
    do
      if SecToDay < sec then
        str = (TextManager.GetText)((CStringRes:GetRecorder(1463)).msgTextID)
        local day = (os.date)("!%d", sec)
        str = (string.gsub)(str, "%$parameter1%$", tonumber(day))
      else
        do
          if SecToHour < sec then
            str = (TextManager.GetText)((CStringRes:GetRecorder(1462)).msgTextID)
            local hour = (os.date)("!%H", sec)
            str = (string.gsub)(str, "%$parameter1%$", tonumber(hour))
          else
            do
              str = (TextManager.GetText)((CStringRes:GetRecorder(1461)).msgTextID)
              do
                local min = (os.date)("!%M", sec)
                str = (string.gsub)(str, "%$parameter1%$", tonumber(min))
                return str
              end
            end
          end
        end
      end
    end
  end
end

local JobColor = {[1] = 29, [2] = 30, [3] = 31}
local GuildMemberCell = class("GuildMemberCell", Dialog)
GuildMemberCell.AssetBundleName = "ui/layouts.guild"
GuildMemberCell.AssetName = "GuildMainMemberCell"
GuildMemberCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : GuildMemberCell
  ((GuildMemberCell.super).Ctor)(self, ...)
end

GuildMemberCell.OnCreate = function(self)
  -- function num : 0_2
  self._back = self:GetChild("Back")
  self._photo = self:GetChild("Back/HeadPhoto/Photo")
  self._photoFrame = self:GetChild("Back/HeadPhoto/Frame")
  self._lv = self:GetChild("Back/LvBack/Level")
  self._name = self:GetChild("Back/NameBack/Name")
  self._onLinePanel = self:GetChild("Back/Online")
  self._lastActivePanel = self:GetChild("Back/Num")
  self._lastActiveNum = self:GetChild("Back/Num/Num")
  self._contributionValue = self:GetChild("Back/Contribute/Num")
  self._job = self:GetChild("Back/Job")
  self._jobText = self:GetChild("Back/JobTxt")
  self._jobTextStr = (self._jobText):GetText()
  self._editBtn = self:GetChild("Back/EditBtn")
  ;
  (self._photoFrame):Subscribe_PointerClickEvent(self.OnPhotoClicked, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnEditBtnClicked, self)
end

GuildMemberCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePath, _ENV, HeadPhotoFrameTable, GetTimeStr, JobColor, CWordColor
  local imageRecord = nil
  local headPhotoRecord = HeadPhotoTable:GetRecorder(data.avatarId)
  if headPhotoRecord then
    if not CImagePath:GetRecorder(headPhotoRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildMemberCell", "userInfo.avatarId %s is wrong", data.avatarId)
  end
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.frameId)
  if headPhotoFrameRecord then
    if not CImagePath:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("GuildMemberCell", "userInfo.frameId %s is wrong", data.frameId)
  end
  ;
  (self._lv):SetText(data.userLevel)
  ;
  (self._name):SetText(data.username)
  ;
  (self._contributionValue):SetText(data.donate)
  ;
  (self._onLinePanel):SetActive(data.lastTime == 0)
  ;
  (self._lastActivePanel):SetActive(data.lastTime ~= 0)
  do
    if data.lastTime ~= 0 then
      local str = GetTimeStr(data.lastTime)
      ;
      (self._lastActiveNum):SetText(str)
    end
    local jobstr = ((NekoData.BehaviorManager).BM_Guild):GetJobStr(data.position)
    local colorId = JobColor[data.position]
    if colorId then
      jobstr = "<color=#" .. (CWordColor:GetRecorder(colorId)).wordcolor .. ">" .. jobstr .. "</color>"
      local jobTextStr = nil
      jobTextStr = "<color=#" .. (CWordColor:GetRecorder(colorId)).wordcolor .. ">" .. self._jobTextStr .. "</color>"
      ;
      (self._jobText):SetText(jobTextStr)
    else
      (self._jobText):SetText(self._jobTextStr)
    end
    ;
    (self._job):SetText(jobstr)
    ;
    (self._editBtn):SetActive(data.userId ~= ((NekoData.BehaviorManager).BM_Game):GetUserId())
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

GuildMemberCell.OnEditBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._cellData).userId == ((NekoData.BehaviorManager).BM_Game):GetUserId() then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("guild.guildmanagedialog")
  if dialog then
    dialog:Init(self._cellData)
  end
end

GuildMemberCell.OnPhotoClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.chat.clookotherinfo")
  protocol.userId = (self._cellData).userId
  protocol:Send()
end

return GuildMemberCell

