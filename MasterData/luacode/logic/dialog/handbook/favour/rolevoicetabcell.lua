local CSoundHandbook = BeanManager.GetTableByName("sound.csoundhandbook")
local CSoundLinesHandbook = BeanManager.GetTableByName("sound.csoundlineshandbook")
local CSoundAnimationHandbook = BeanManager.GetTableByName("sound.clive2dmotionhandbook")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CSoundLinesHandbook_skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlineshandbook_skin")
local CSoundTitle = BeanManager.GetTableByName("sound.csoundtitle")
local CSoundTitle_skin = BeanManager.GetTableByNameWithLanguage("sound.csoundtitle_skin")
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CCardRoleConfig_HandBook = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local CSkinCV = BeanManager.GetTableByNameWithLanguage("sound.cskincv")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 4
local RoleVoiceTabCell = class("RoleVoiceTabCell", Dialog)
RoleVoiceTabCell.AssetBundleName = "ui/layouts.tujian"
RoleVoiceTabCell.AssetName = "CharVoice"

function RoleVoiceTabCell:Ctor(...)
  RoleVoiceTabCell.super.Ctor(self, ...)
  self._voiceList = {}
end

function RoleVoiceTabCell:OnCreate()
  self:GetChild("Back/Title/Text"):SetText(TextManager.GetText(502734))
  self._roleName = self:GetChild("Back/NameBack/Name")
  self._cvTitle = self:GetChild("Back/CV/Artist")
  self._cvName = self:GetChild("Back/CV/ArtistName")
  self._artistTitle = self:GetChild("Back/Artist/Artist")
  self._artistName = self:GetChild("Back/Artist/ArtistName")
  self._black = self:GetChild("Back/Black")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._width, self._height = self._panel:GetRectSize()
  self._black:SetActive(false)
  self._black:Subscribe_PointerClickEvent(self.OnBlackClicked, self)
end

function RoleVoiceTabCell:OnDestroy()
  self._frame:Destroy()
end

function RoleVoiceTabCell:RefreshTabCell(refreshData, notChangePos)
  local lastPos = self._frame:GetCurrentPosition()
  if not self._init or refreshData then
    self._init = true
    self._roleId = self._delegate._role:GetId()
    self._favourLv = self._delegate._role:GetRelationLevel()
    local maxLv = self._delegate._role:GetRelationMaxLevel()
    self._maxHeartNum = math.ceil(CFavourExp:GetRecorder(maxLv).heartnum / 10)
    local soundHandbookRecord = CSoundHandbook:GetRecorder(self._roleId)
    local soundLinesHandbookRecord = CSoundLinesHandbook:GetRecorder(self._roleId)
    local soundAnimationHandbookRecorder = CSoundAnimationHandbook:GetRecorder(self._roleId)
    local soundTitleRecord = CSoundTitle:GetRecorder(self._roleId)
    local soundLinesHandbookRecord
    local fashionId = self._delegate._role:GetDefaultFashion()
    if 0 < fashionId then
      soundLinesHandbookRecord = CSoundLinesHandbook_skin:GetRecorder(fashionId)
    end
    soundLinesHandbookRecord = soundLinesHandbookRecord or CSoundLinesHandbook:GetRecorder(self._roleId)
    local soundTitleRecord
    local fashionId = self._delegate._role:GetDefaultFashion()
    if 0 < fashionId then
      soundTitleRecord = CSoundTitle_skin:GetRecorder(fashionId)
    end
    soundTitleRecord = soundTitleRecord or CSoundTitle:GetRecorder(self._roleId)
    local record = CCardRoleConfig_HandBook:GetRecorder(self._delegate._role:GetId())
    self._roleName:SetText(self._delegate._role:GetRoleName())
    self._cvTitle:SetText(TextManager.GetText(502730))
    local skinCVRecord, skinRecord
    local fashionId = self._delegate._role:GetDefaultFashion()
    if 0 < fashionId then
      skinCVRecord = CSkinCV:GetRecorder(fashionId)
      skinRecord = CSkin:GetRecorder(fashionId)
    end
    if not skinRecord or skinRecord.skinType == 0 or skinRecord.skinType == 1 then
      skinRecord = record
    end
    skinCVRecord = skinCVRecord or record
    local curAudioResName = LuaAudioManager.GetCurrentVoiceResName()
    if curAudioResName == "audio-zh_Hans" then
      self._cvName:SetText(TextManager.GetText(skinCVRecord.cvTextIDChs))
    elseif curAudioResName == "audio-ja_JP" then
      self._cvName:SetText(TextManager.GetText(skinCVRecord.cvTextIDJpn))
    end
    self._artistTitle:SetText(TextManager.GetText(502731))
    if tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(101).Value) == 1 then
      self._artistName:SetText(TextManager.GetText(skinRecord.artistTextID))
    else
      self._artistName:SetText(TextManager.GetText(skinRecord.overseasArtistTextID))
    end
    while self._voiceList[#self._voiceList] do
      table.remove(self._voiceList, #self._voiceList)
    end
    if self._delegate._role:CanPlayVoice() then
      local rewardList = self._delegate._role:GetRelationRewardList()
      for i, v in ipairs(rewardList) do
        if v.rewardType == DataCommon.Favour.Voice then
          local voiceId = soundHandbookRecord.relationVoice[v.rewardId]
          if soundLinesHandbookRecord.relationVoice[v.rewardId] ~= -1 then
            table.insert(self._voiceList, {
              tag = "Favour",
              reward = v,
              titleId = soundTitleRecord.relationTitle[v.rewardId],
              voiceId = voiceId,
              voiceIndex = v.rewardId,
              contentId = soundLinesHandbookRecord.relationVoice[v.rewardId],
              animation = soundAnimationHandbookRecorder.relationVoice[v.rewardId]
            })
          end
        end
      end
      for i, v in ipairs(soundHandbookRecord.otherVoice) do
        if soundLinesHandbookRecord.otherVoice[i] ~= -1 then
          table.insert(self._voiceList, {
            tag = "Other",
            titleId = soundTitleRecord.otherTitle[i],
            voiceId = v,
            voiceIndex = i,
            contentId = soundLinesHandbookRecord.otherVoice[i],
            animation = soundAnimationHandbookRecorder.otherVoice[i]
          })
        end
      end
    end
    self._frame:ReloadAllCell()
  end
  if not notChangePos then
    self._frame:MoveToTop()
  elseif lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function RoleVoiceTabCell:OnBlackClicked()
  self._delegate:SetVoiceIdNil()
end

function RoleVoiceTabCell:NumberOfCell(frame)
  return #self._voiceList
end

function RoleVoiceTabCell:CellAtIndex(frame, index)
  return "handbook.favour.rolevoicecell"
end

function RoleVoiceTabCell:DataAtIndex(frame, index)
  return self._voiceList[index]
end

function RoleVoiceTabCell:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return RoleVoiceTabCell
