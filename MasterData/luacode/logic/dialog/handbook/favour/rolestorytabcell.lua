local CCardRoleConfig_HandBook = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local CSkinCV = BeanManager.GetTableByNameWithLanguage("sound.cskincv")
local CSkin = BeanManager.GetTableByName("role.cskin")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local RoleStoryTabCell = class("RoleStoryTabCell", Dialog)
RoleStoryTabCell.AssetBundleName = "ui/layouts.tujian"
RoleStoryTabCell.AssetName = "CharStory"
local TabType = {Introduction = 1, BackgroundStory = 2}

function RoleStoryTabCell:Ctor(...)
  RoleStoryTabCell.super.Ctor(self, ...)
end

function RoleStoryTabCell:OnCreate()
  self._roleName = self:GetChild("Back/NameBack/Name")
  self._cvTitle = self:GetChild("Back/CV/Artist")
  self._cvName = self:GetChild("Back/CV/ArtistName")
  self._artistTitle = self:GetChild("Back/Artist/Artist")
  self._artistName = self:GetChild("Back/Artist/ArtistName")
  self._tabPanel = self:GetChild("Back/Frame")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._tabBtns = {}
  for _, v in pairs(TabType) do
    self._tabBtns[v] = self:GetChild("Back/GroupBtn" .. v)
    self._tabBtns[v]:Subscribe_PointerClickEvent(function()
      self:OnTabBtnClick(v)
    end)
    if v == TabType.Introduction then
      self:GetChild("Back/GroupBtn" .. v .. "/Text"):SetText(TextManager.GetText(502732))
    else
      self:GetChild("Back/GroupBtn" .. v .. "/Text"):SetText(TextManager.GetText(502733))
      self._backgroundStoryRedDot = self:GetChild("Back/GroupBtn2/RedDot")
    end
  end
end

function RoleStoryTabCell:OnDestroy()
  self._tabFrame:Destroy()
end

function RoleStoryTabCell:RefreshTabCell(refreshData, notChangePos, fromChangeRole)
  if not self._init or refreshData then
    self._init = true
    local record = CCardRoleConfig_HandBook:GetRecorder(self._delegate._role:GetId())
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
    self._roleName:SetText(self._delegate._role:GetRoleName())
    self._cvTitle:SetText(TextManager.GetText(502730))
    local curAudioResName = LuaAudioManager.GetCurrentVoiceResName()
    if curAudioResName == "audio-zh_Hans" then
      self._cvName:SetText(TextManager.GetText(skinCVRecord.cvTextIDChs))
    elseif curAudioResName == "audio-ja_JP" then
      self._cvName:SetText(TextManager.GetText(skinCVRecord.cvTextIDJpn))
    end
    self._artistTitle:SetText(TextManager.GetText(502731))
    self._artistName:SetText(TextManager.GetText(record.artistTextID))
    if tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(101).Value) == 1 then
      self._artistName:SetText(TextManager.GetText(skinRecord.artistTextID))
    else
      self._artistName:SetText(TextManager.GetText(skinRecord.overseasArtistTextID))
    end
    local isShowStoryRedDot = false
    local relationLv = self._delegate._role:GetRelationLevel()
    local relationReceiveMap = self._delegate._role:GetRelationReceiveMap()
    local rewardList = self._delegate._role:GetRelationRewardList()
    for i, v in ipairs(rewardList) do
      local favourLv = v.favourLv
      if relationLv >= favourLv then
        if not relationReceiveMap[favourLv] and v.rewardType == DataCommon.Favour.BackgroundStory then
          isShowStoryRedDot = true
          break
        end
      else
        break
      end
    end
    self._backgroundStoryRedDot:SetActive(isShowStoryRedDot)
    local tabCell = self._tabFrame:GetCellAtIndex(TabType.BackgroundStory)
    tabCell:RefreshTabCell(refreshData, notChangePos)
    if fromChangeRole then
      tabCell = self._tabFrame:GetCellAtIndex(TabType.Introduction)
      tabCell:RefreshTabCell(true)
    end
  end
  if not notChangePos and not fromChangeRole then
    self:OnTabBtnClick(TabType.Introduction)
  end
end

function RoleStoryTabCell:CellAtIndex(helper, index)
  if index == TabType.Introduction then
    return "handbook.favour.introductiontabcell"
  elseif index == TabType.BackgroundStory then
    return "handbook.favour.backgroundstorytabcell"
  end
end

function RoleStoryTabCell:OnTabBtnClick(tabType)
  if self._tabFrame:GetCurrentIndex() ~= tabType then
    local tabCell = self._tabFrame:ToPage(tabType)
    tabCell:RefreshTabCell()
    for _, v in pairs(TabType) do
      self._tabBtns[v]:SetSelected(v == tabType)
    end
  end
end

return RoleStoryTabCell
