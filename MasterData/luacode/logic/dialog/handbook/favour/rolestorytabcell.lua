-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/rolestorytabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCardRoleConfig_HandBook = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CSkinCV = (BeanManager.GetTableByNameWithLanguage)("sound.cskincv")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local RoleStoryTabCell = class("RoleStoryTabCell", Dialog)
RoleStoryTabCell.AssetBundleName = "ui/layouts.tujian"
RoleStoryTabCell.AssetName = "CharStory"
local TabType = {Introduction = 1, BackgroundStory = 2}
RoleStoryTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleStoryTabCell
  ((RoleStoryTabCell.super).Ctor)(self, ...)
end

RoleStoryTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV, TabType
  self._roleName = self:GetChild("Back/NameBack/Name")
  self._cvTitle = self:GetChild("Back/CV/Artist")
  self._cvName = self:GetChild("Back/CV/ArtistName")
  self._artistTitle = self:GetChild("Back/Artist/Artist")
  self._artistName = self:GetChild("Back/Artist/ArtistName")
  self._tabPanel = self:GetChild("Back/Frame")
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  self._tabBtns = {}
  for _,v in pairs(TabType) do
    do
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

      (self._tabBtns)[v] = self:GetChild("Back/GroupBtn" .. v)
      ;
      ((self._tabBtns)[v]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, v
    self:OnTabBtnClick(v)
  end
)
      if v == TabType.Introduction then
        (self:GetChild("Back/GroupBtn" .. v .. "/Text")):SetText((TextManager.GetText)(502732))
      else
        ;
        (self:GetChild("Back/GroupBtn" .. v .. "/Text")):SetText((TextManager.GetText)(502733))
        self._backgroundStoryRedDot = self:GetChild("Back/GroupBtn2/RedDot")
      end
    end
  end
end

RoleStoryTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._tabFrame):Destroy()
end

RoleStoryTabCell.RefreshTabCell = function(self, refreshData, notChangePos, fromChangeRole)
  -- function num : 0_3 , upvalues : CCardRoleConfig_HandBook, CSkinCV, CSkin, _ENV, TabType
  if not self._init or refreshData then
    self._init = true
    local record = (CCardRoleConfig_HandBook:GetRecorder(((self._delegate)._role):GetId()))
    local skinCVRecord, skinRecord = nil, nil
    local fashionId = ((self._delegate)._role):GetDefaultFashion()
    if fashionId > 0 then
      skinCVRecord = CSkinCV:GetRecorder(fashionId)
      skinRecord = CSkin:GetRecorder(fashionId)
    end
    if not skinRecord or skinRecord.skinType == 0 or skinRecord.skinType == 1 then
      skinRecord = record
    end
    if not skinCVRecord then
      skinCVRecord = record
    end
    ;
    (self._roleName):SetText(((self._delegate)._role):GetRoleName())
    ;
    (self._cvTitle):SetText((TextManager.GetText)(502730))
    local curAudioResName = (LuaAudioManager.GetCurrentVoiceResName)()
    if curAudioResName == "audio-zh_Hans" then
      (self._cvName):SetText((TextManager.GetText)(skinCVRecord.cvTextIDChs))
    else
      if curAudioResName == "audio-ja_JP" then
        (self._cvName):SetText((TextManager.GetText)(skinCVRecord.cvTextIDJpn))
      end
    end
    ;
    (self._artistTitle):SetText((TextManager.GetText)(502731))
    ;
    (self._artistName):SetText((TextManager.GetText)(record.artistTextID))
    if tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(101)).Value) == 1 then
      (self._artistName):SetText((TextManager.GetText)(skinRecord.artistTextID))
    else
      ;
      (self._artistName):SetText((TextManager.GetText)(skinRecord.overseasArtistTextID))
    end
    local isShowStoryRedDot = false
    local relationLv = ((self._delegate)._role):GetRelationLevel()
    local relationReceiveMap = ((self._delegate)._role):GetRelationReceiveMap()
    local rewardList = ((self._delegate)._role):GetRelationRewardList()
    for i,v in ipairs(rewardList) do
      local favourLv = v.favourLv
      if favourLv <= relationLv then
        if not relationReceiveMap[favourLv] and v.rewardType == (DataCommon.Favour).BackgroundStory then
          isShowStoryRedDot = true
          break
        end
      else
        break
      end
    end
    do
      ;
      (self._backgroundStoryRedDot):SetActive(isShowStoryRedDot)
      do
        local tabCell = (self._tabFrame):GetCellAtIndex(TabType.BackgroundStory)
        tabCell:RefreshTabCell(refreshData, notChangePos)
        if fromChangeRole then
          tabCell = (self._tabFrame):GetCellAtIndex(TabType.Introduction)
          tabCell:RefreshTabCell(true)
        end
        if not notChangePos and not fromChangeRole then
          self:OnTabBtnClick(TabType.Introduction)
        end
      end
    end
  end
end

RoleStoryTabCell.CellAtIndex = function(self, helper, index)
  -- function num : 0_4 , upvalues : TabType
  if index == TabType.Introduction then
    return "handbook.favour.introductiontabcell"
  else
    if index == TabType.BackgroundStory then
      return "handbook.favour.backgroundstorytabcell"
    end
  end
end

RoleStoryTabCell.OnTabBtnClick = function(self, tabType)
  -- function num : 0_5 , upvalues : _ENV, TabType
  if (self._tabFrame):GetCurrentIndex() ~= tabType then
    local tabCell = (self._tabFrame):ToPage(tabType)
    tabCell:RefreshTabCell()
    for _,v in pairs(TabType) do
      ((self._tabBtns)[v]):SetSelected(v == tabType)
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return RoleStoryTabCell

