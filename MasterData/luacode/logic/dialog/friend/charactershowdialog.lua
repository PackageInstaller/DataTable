local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleBreakCfgTable = BeanManager.GetTableByName("role.crolebreakcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CPersonalityFrameConfig = BeanManager.GetTableByName("headphoto.cpersonalityframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CharacterShowDialog = class("CharacterShowDialog", Dialog)
CharacterShowDialog.AssetBundleName = "ui/layouts.friends"
CharacterShowDialog.AssetName = "PlayerShow"

function CharacterShowDialog:Ctor(...)
  CharacterShowDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function CharacterShowDialog:OnCreate()
  self._supportRolePanel = self:GetChild("Role")
  self._supportRolePanelLive2d = self:GetChild("Role/Live2D")
  self._supportRolePanelPhoto = self:GetChild("Role/Photo")
  self._showCells = {}
  for i = 1, 4 do
    self._showCells[i] = {}
    self._showCells[i].role = self:GetChild("Show/ShowCellNew" .. i)
    self._showCells[i].cell = self:GetChild("Show/ShowCellNew" .. i .. "/Cell")
    self._showCells[i].cellDownRankBack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/DownRankBack")
    self._showCells[i].cellPhoto = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Photo")
    self._showCells[i].cellFrame = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Frame")
    self._showCells[i].cellRank = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Rank")
    self._showCells[i].cellJob = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Job")
    self._showCells[i].cellLv = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Level/Num")
    self._showCells[i].cellBreakLevelBackBlack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelBackBlack")
    self._showCells[i].cellBreakLevelBack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelBack")
    self._showCells[i].cellBreakLevel = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelNum")
    self._showCells[i].cellElementImage = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Element")
    self._showCells[i].role:Subscribe_PointerClickEvent(function()
      self:OnRoleCellClicked(i)
    end, self)
    self._showCells[i]._charUpgrade = {
      panel = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/CharUpgrade"),
      levelImage = {}
    }
    for j = 1, 5 do
      self._showCells[i]._charUpgrade.levelImage[j] = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/CharUpgrade/Img" .. j)
    end
  end
  self._modalArea = self:GetChild("Show/MedalFrame")
  self._modalFrame = TableFrame.Create(self._modalArea, self, false, false, false)
  self._modalName = self:GetChild("Show/Name")
  self._modalDetail = self:GetChild("Show/Condition")
  self._id = self:GetChild("Detail/ID/IDNum")
  self._copyIdBtn = self:GetChild("Detail/CopyBtn")
  self._name = self:GetChild("Detail/NameBack/Name")
  self._head = self:GetChild("Detail/HeadPhoto")
  self._headPhoto = self:GetChild("Detail/HeadPhoto/Photo")
  self._headFrame = self:GetChild("Detail/HeadPhoto/Frame")
  self._title = self:GetChild("Detail/Title/Name")
  self._introduction = self:GetChild("Detail/IntroductionBack/Txt")
  self._level = self:GetChild("Detail/LvBack/Level")
  self._greatNum = self:GetChild("Detail/ThumbsUpNum/Num")
  self._IPHome = self:GetChild("Detail/IP/IPTxt")
  self._closeBtn = self:GetChild("BackBtn")
  self._addBtn = self:GetChild("AddBtn")
  self._friendTitle = self:GetChild("TitleFriend")
  self._otherTitle = self:GetChild("TitlePlayer")
  self._newBack = self:GetChild("NewBack")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._copyIdBtn:Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  self._customBorder = {}
  for i = 1, 4 do
    self._customBorder[i] = self:GetChild("Frame" .. i)
    self._customBorder[i]:SetActive(false)
  end
  self._guildBack = self:GetChild("Detail/Guild")
  self._guildBack:SetActive(false)
  self._guildName = self:GetChild("Detail/Guild/GuildTxt")
  self._guildName:SetText("")
  LuaNotificationCenter.AddObserver(self, self.Destroy, Common.n_BattleStateEnter, nil)
  UIBackManager.SetUIBackShow(true)
end

function CharacterShowDialog:OnDestroy()
  self._modalFrame:Destroy()
  UIBackManager.SetUIBackShow(false)
end

function CharacterShowDialog:NumberOfCell(frame)
  return table.nums(self._modalList)
end

function CharacterShowDialog:CellAtIndex(frame, index)
  return "achievement.charshowmodalcell"
end

function CharacterShowDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._modalList[index]
  return data
end

function CharacterShowDialog:GetVocationImageRecord(rarityId, vocation)
  local vocationRecord = CVocationCfgTable:GetRecorder(vocation)
  if rarityId == 1 then
    return CImagePathTable:GetRecorder(vocationRecord.imgR) or DataCommon.DefaultImageAsset
  end
  if rarityId == 2 then
    return CImagePathTable:GetRecorder(vocationRecord.imgSR) or DataCommon.DefaultImageAsset
  end
  if rarityId == 3 then
    return CImagePathTable:GetRecorder(vocationRecord.imgSSR) or DataCommon.DefaultImageAsset
  end
  if rarityId == 4 then
    return CImagePathTable:GetRecorder(vocationRecord.imgUR) or DataCommon.DefaultImageAsset
  end
  if rarityId == 5 then
    return CImagePathTable:GetRecorder(vocationRecord.imgEX) or DataCommon.DefaultImageAsset
  end
end

function CharacterShowDialog:GetBreakRecord(breakType, breaklevel)
  for i = 1, #CRoleBreakCfgTable:GetAllIds() do
    local recorder = CRoleBreakCfgTable:GetRecorder(i)
    if recorder.breakType == breakType and breaklevel == recorder.breaklv then
      return recorder
    end
  end
end

function CharacterShowDialog:RefreshSupportRolePanel(protocol)
  local roleId = protocol.support.roleId
  local roleConfig = RoleConfigTable:GetRecorder(roleId)
  if roleConfig then
    self._supportRolePanel:SetActive(true)
    local data = Role.Create(roleId)
    if data then
      data:UpdateShape(protocol.support.skin)
      local record = data:GetShapeLive2DRecord()
      if self._handler then
        self._supportRolePanelLive2d:Release(self._handler)
      end
      if data:IsFashionLive2D() and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
        self._supportRolePanelPhoto:SetActive(false)
        self._handler = self._supportRolePanelLive2d:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
      else
        self._supportRolePanelPhoto:SetActive(true)
        self._supportRolePanelPhoto:SetSprite(data:GetShapeLiHuiImageRecord().assetBundle, data:GetShapeLiHuiImageRecord().assetName)
        local scale = data:GetPhotoScale()
        self._supportRolePanelPhoto:SetLocalScale(scale, scale, scale)
        local photoPos = data:GetPhotoPosition()
        self._supportRolePanelPhoto:SetAnchoredPosition(photoPos[1], photoPos[2])
      end
    else
      LogErrorFormat("CharacterShowDialog", "support role id %s create with wrong", roleId)
    end
  else
    self._supportRolePanel:SetActive(false)
  end
end

function CharacterShowDialog:RefreshDisplayRolesPanel(protocol)
  for i = 1, 4 do
    if i > #protocol.display then
      self._showCells[i].cell:SetActive(false)
    else
      local role = Role.Create(protocol.display[i].id)
      role:UpdateShape(protocol.display[i].skin)
      self._showCells[i].cell:SetActive(true)
      local imageRecord = role:GetShapeLittleHeadImageRecord()
      self._showCells[i].cellPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetSmallRarityFrameRecord()
      self._showCells[i].cellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetRarityImageRecord()
      self._showCells[i].cellRank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetVocationImageRecord()
      self._showCells[i].cellJob:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      role:SetLevel(protocol.display[i].lv)
      role:SetBreakLv(protocol.display[i].breakLv)
      self._showCells[i].cellLv:SetText(role:GetShowLv())
      local breakLv = protocol.display[i].breakLv
      self._showCells[i].cellBreakLevelBackBlack:SetActive(breakLv == 0)
      self._showCells[i].cellBreakLevelBack:SetActive(0 < breakLv)
      self._showCells[i].cellBreakLevel:SetActive(0 < breakLv)
      if 0 < breakLv then
        imageRecord = role:GetCurBreakFrame2ImageRecord()
        self._showCells[i].cellBreakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._showCells[i].cellBreakLevel:SetText(breakLv)
      end
      imageRecord = role:GetRarityBottomBackRecord()
      self._showCells[i].cellDownRankBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetElementImageRecord()
      self._showCells[i].cellElementImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      role:SetRuneLevel(protocol.display[i].runeLevel)
      local level = role:GetRuneLevel()
      self._showCells[i]._charUpgrade.panel:SetActive(level ~= 0)
      for j = 1, 5 do
        self._showCells[i]._charUpgrade.levelImage[j]:SetActive(level == j)
      end
    end
  end
end

function CharacterShowDialog:RefreshUserInfoPanel(protocol)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(protocol.baseUserData.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(protocol.baseUserData.frameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._id:SetText(tostring(protocol.baseUserData.userId))
  self._name:SetText(tostring(protocol.baseUserData.userName))
  self._title:SetText(tostring(protocol.title))
  self._level:SetText(tostring(protocol.baseUserData.userLv))
  self._introduction:SetText(protocol.introduce)
  self._IPHome:SetText(protocol.baseUserData.iplocaladdr)
  self._userId = protocol.baseUserData.userId
  self._guildBack:SetActive(true)
  if string.len(protocol.partyName) > 0 then
    self._guildName:SetText(protocol.partyName)
  else
    self._guildName:SetText(TextManager.GetText(CStringRes:GetRecorder(2296).msgTextID))
  end
end

function CharacterShowDialog:SetData(protocol)
  self:RefreshSupportRolePanel(protocol)
  self:RefreshDisplayRolesPanel(protocol)
  self:RefreshUserInfoPanel(protocol)
  self:RefreshBorderInfo(protocol)
  self._roleInfoList = protocol.display
  self._modalList = NekoData.BehaviorManager.BM_Task:GetOtherShowBadges(protocol.baseUserData.showBadges)
  if self._modalList then
    self._modalFrame:ReloadAllCell()
  end
  local isFriend = NekoData.BehaviorManager.BM_Friends:IsFriend(protocol.baseUserData.userId)
  self._addBtn:SetActive(not isFriend)
  self._friendTitle:SetActive(isFriend)
  self._otherTitle:SetActive(not isFriend)
  local likeNumber = tonumber(protocol.likedNum)
  if likeNumber then
    if likeNumber < 999999 then
      self._greatNum:SetText(tostring(protocol.likedNum))
    else
      self._greatNum:SetText(TextManager.GetText(701179))
    end
  end
  if DialogManager.GetDialog("activity.chrismascall.maindialog") then
    self._newBack:SetActive(true)
  else
    self._newBack:SetActive(false)
  end
end

function CharacterShowDialog:OnCopyIDBtnClicked()
  self:GetRootWindow():CopyToClipBoard(tostring(self._userId))
  NekoData.BehaviorManager.BM_Message:SendMessageById(100079)
end

function CharacterShowDialog:OnRoleCellClicked(index)
  if self._roleInfoList[index] then
    DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog"):Init({
      roleList = self._roleInfoList,
      index = index
    }, CheckOtherRoleInfoDialog.ShowType.FriendShow)
  end
end

function CharacterShowDialog:OnAddBtnClicked()
  if NekoData.BehaviorManager.BM_Game:GetUserId() == self._userId then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100043)
    return
  end
  local friend = NekoData.BehaviorManager.BM_Friends:GetFriend(self._userId)
  if friend and friend:IsBlack() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100046)
    return
  end
  NekoData.BehaviorManager.BM_Friends:RequesAddFriend(self._userId)
end

function CharacterShowDialog:OnBackBtnClicked()
  self:Destroy()
end

function CharacterShowDialog:RefreshBorderInfo(protocol)
  local record = CPersonalityFrameConfig:GetRecorder(protocol.baseUserData.panelFrame)
  if record then
    if record.id > 0 then
      for i = 1, 4 do
        self._customBorder[i]:SetActive(true)
      end
      local imageRecord = CImagePathTable:GetRecorder(record.photoleft1)
      self._customBorder[1]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = CImagePathTable:GetRecorder(record.photoright1)
      self._customBorder[2]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = CImagePathTable:GetRecorder(record.photoleft2)
      self._customBorder[3]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = CImagePathTable:GetRecorder(record.photoright2)
      self._customBorder[4]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      for i = 1, 4 do
        self._customBorder[i]:SetActive(false)
      end
    end
  else
    for i = 1, 4 do
      self._customBorder[i]:SetActive(false)
    end
  end
end

return CharacterShowDialog
