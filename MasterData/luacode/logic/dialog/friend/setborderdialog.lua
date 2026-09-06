local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CPersonalityFrameConfig = BeanManager.GetTableByName("headphoto.cpersonalityframeconfig")
local SetBorderDialog = class("SetBorderDialog", Dialog)
SetBorderDialog.AssetBundleName = "ui/layouts.friends"
SetBorderDialog.AssetName = "FriendsFrameSetting"

function SetBorderDialog:Ctor(...)
  SetBorderDialog.super.Ctor(self, ...)
end

function SetBorderDialog:OnCreate()
  self._supportRole = self:GetChild("Back/Pic/Role")
  self._supportRoleLive2D = self:GetChild("Back/Pic/Role/Live2D")
  self._supportRolePhoto = self:GetChild("Back/Pic/Role/Photo")
  self._showCells = {}
  for i = 1, 4 do
    self._showCells[i] = {}
    self._showCells[i].role = self:GetChild("Back/Pic/Show/ShowCellNew" .. i)
    self._showCells[i].cell = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell")
    self._showCells[i].cellDownRankBack = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/DownRankBack")
    self._showCells[i].cellPhoto = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Photo")
    self._showCells[i].cellFrame = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Frame")
    self._showCells[i].cellRank = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Rank")
    self._showCells[i].cellJob = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Job")
    self._showCells[i].cellLv = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Level/Num")
    self._showCells[i].cellBreakLevelBackBlack = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/BreakLevelBackBlack")
    self._showCells[i].cellBreakLevelBack = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/BreakLevelBack")
    self._showCells[i].cellBreakLevel = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/BreakLevelNum")
    self._showCells[i].cellElementImage = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/Element")
    self._showCells[i]._charUpgrade = {
      panel = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/CharUpgrade"),
      levelImage = {}
    }
    for j = 1, 5 do
      self._showCells[i]._charUpgrade.levelImage[j] = self:GetChild("Back/Pic/Show/ShowCellNew" .. i .. "/Cell/CharUpgrade/Img" .. j)
    end
  end
  self._modalArea = self:GetChild("Back/Pic/Show/MedalFrame")
  self._modalFrame = TableFrame.Create(self._modalArea, self, false, false, false)
  self._modalName = self:GetChild("Back/Pic/Show/Name")
  self._modalDetail = self:GetChild("Back/Pic/Show/Condition")
  self._modalName:SetActive(false)
  self._modalDetail:SetActive(false)
  self._IPHome = self:GetChild("Back/Pic/Detail/IP/IPTxt")
  self._id = self:GetChild("Back/Pic/Detail/ID/IDNum")
  self._name = self:GetChild("Back/Pic/Detail/NameBack/Name")
  self._head = self:GetChild("Back/Pic/Detail/HeadPhoto")
  self._headPhoto = self:GetChild("Back/Pic/Detail/HeadPhoto/Photo")
  self._headFrame = self:GetChild("Back/Pic/Detail/HeadPhoto/Frame")
  self._playerLevel = self:GetChild("Back/Pic/Detail/LvBack/Level")
  self._introduction = self:GetChild("Back/Pic/Detail/IntroductionBack/Txt")
  self._greatNum = self:GetChild("Back/Pic/Detail/ThumbsUpNum/Num")
  self.curPanelFrame = 0
  self._curSelectBorderId = 0
  self._borderList = {}
  self._customBorder = {}
  for i = 1, 4 do
    self._customBorder[i] = self:GetChild("Back/Pic/Frame" .. i)
    self._customBorder[i]:SetActive(false)
  end
  self._borderFrame = self:GetChild("FrameBack/Frame2")
  self._borderFrameHelper = TableFrame.Create(self._borderFrame, self, true, true, true)
  self._borderName = self:GetChild("Back/Current")
  self._borderName:SetText("")
  self._borderSource = self:GetChild("Back/Source")
  self._borderSource:SetText("")
  self._borderDescription = self:GetChild("Back/Description")
  self._borderDescription:SetText("")
  self._cancelBtn = self:GetChild("CancelBtn")
  self._cancelBtn:SetActive(false)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnCancelBtnClicked, self)
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._confirmBtn:SetActive(false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._confirmBtnText = self:GetChild("ConfirmBtn/_Text")
  self._confirmBtnText:SetText("")
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserIntroduce, Common.n_ChangeUserIntroduce, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  LuaNotificationCenter.AddObserver(self, self.OnChangeUserLikedNum, Common.n_ChangeUserLikedNum, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSupportRolePanel, Common.n_SupportRoleChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDisplayRolesPanel, Common.n_DisplayRolesChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshShowAchievement, Common.n_RefreshAchievementShowBag, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
  local protocol = LuaNetManager.CreateProtocol("protocol.login2.cpanelframegetinfo")
  protocol:Send()
end

function SetBorderDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._modalFrame:Destroy()
  self._borderFrameHelper:Destroy()
end

function SetBorderDialog:NumberOfCell(frame)
  if frame == self._borderFrameHelper then
    return #self._borderList
  else
    return table.nums(self._modalList)
  end
end

function SetBorderDialog:CellAtIndex(frame, index)
  if frame == self._borderFrameHelper then
    return "friend.setbordercell"
  else
    return "achievement.charshowmodalcell"
  end
end

function SetBorderDialog:DataAtIndex(frame, index)
  if frame == self._borderFrameHelper then
    return self._borderList[index]
  else
    local data = {}
    data.id = self._modalList[index]
    return data
  end
end

function SetBorderDialog:OnChangeUserName(notification)
  self._name:SetText(notification.userInfo.name)
end

function SetBorderDialog:OnChangeUserIntroduce(notification)
  self._introduction:SetText(notification.userInfo.introduce)
end

function SetBorderDialog:OnChangeUserHeadPhoto(notification)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(notification.userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SetBorderDialog:OnChangeUserHeadFrame(notification)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(notification.userInfo.frameId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SetBorderDialog:OnChangeUserLikedNum(notification)
  self:RefreshUserLikedNum(notification.userInfo.likedNum)
end

function SetBorderDialog:OnRefresh()
  self:SetData()
end

function SetBorderDialog:RefreshSupportRolePanel()
  local role = NekoData.BehaviorManager.BM_Friends:GetSupportRole()
  if role then
    self._supportRole:SetActive(true)
    if self._handler then
      self._supportRoleLive2D:Release(self._handler)
      self._handler = nil
    end
    local record = role:GetShapeLive2DRecord()
    if role:IsFashionLive2D() and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DPrefabName then
      self._supportRolePhoto:SetActive(false)
      self._handler = self._supportRoleLive2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      self._supportRolePhoto:SetActive(true)
      self._supportRolePhoto:SetSprite(role:GetShapeLiHuiImageRecord().assetBundle, role:GetShapeLiHuiImageRecord().assetName)
      local scale = role:GetPhotoScale()
      self._supportRolePhoto:SetLocalScale(scale, scale, scale)
      local photoPos = role:GetPhotoPosition()
      self._supportRolePhoto:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  else
    self._supportRole:SetActive(false)
  end
end

function SetBorderDialog:RefreshDisplayRolesPanel()
  local roleList = NekoData.BehaviorManager.BM_Friends:GetDisplayRoles()
  for i = 1, 4 do
    if i > #roleList then
      self._showCells[i].cell:SetActive(false)
    else
      self._showCells[i].cell:SetActive(true)
      local imageRecord = roleList[i]:GetShapeLittleHeadImageRecord()
      self._showCells[i].cellPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = roleList[i]:GetSmallRarityFrameRecord()
      self._showCells[i].cellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = roleList[i]:GetRarityImageRecord()
      self._showCells[i].cellRank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = roleList[i]:GetVocationImageRecord()
      self._showCells[i].cellJob:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._showCells[i].cellLv:SetText(tostring(roleList[i]:GetShowLv()))
      local breakLv = roleList[i]:GetBreakLv()
      self._showCells[i].cellBreakLevelBackBlack:SetActive(breakLv == 0)
      self._showCells[i].cellBreakLevelBack:SetActive(0 < breakLv)
      self._showCells[i].cellBreakLevel:SetActive(0 < breakLv)
      if 0 < breakLv then
        imageRecord = roleList[i]:GetCurBreakFrame2ImageRecord()
        self._showCells[i].cellBreakLevelBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._showCells[i].cellBreakLevel:SetText(breakLv)
      end
      imageRecord = roleList[i]:GetRarityBottomBackRecord()
      self._showCells[i].cellDownRankBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = roleList[i]:GetElementImageRecord()
      self._showCells[i].cellElementImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local level = roleList[i]:GetRuneLevel()
      self._showCells[i]._charUpgrade.panel:SetActive(level ~= 0)
      for j = 1, 5 do
        self._showCells[i]._charUpgrade.levelImage[j]:SetActive(level == j)
      end
    end
  end
end

function SetBorderDialog:RefreshUserInfoPanel()
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._playerLevel:SetText(userInfo.userlevel)
  self._id:SetText(tostring(userInfo.userid))
  self._name:SetText(tostring(userInfo.username))
  self._introduction:SetText(userInfo.introduce)
  self._IPHome:SetText(userInfo.iplocaladdr)
  self:RefreshUserLikedNum(userInfo.likedNum)
  local guildInfo = NekoData.BehaviorManager.BM_Guild:GetGuildInfo()
end

function SetBorderDialog:SetData()
  self:RefreshSupportRolePanel()
  self:RefreshDisplayRolesPanel()
  self:RefreshUserInfoPanel()
  self:RefreshShowAchievement()
end

function SetBorderDialog:RefreshShowAchievement()
  self._modalList = NekoData.BehaviorManager.BM_Task:GetShowBadges()
  if self._modalList then
    self._modalFrame:ReloadAllCell()
  end
end

function SetBorderDialog:OnUniqueEquipLevelUp(notification)
  self:RefreshDisplayRolesPanel()
end

function SetBorderDialog:RefreshUserLikedNum(value)
  local likeNumber = tonumber(value)
  if likeNumber then
    if likeNumber < 999999 then
      self._greatNum:SetText(tostring(value))
    else
      self._greatNum:SetText(TextManager.GetText(701179))
    end
  end
end

function SetBorderDialog:RefreshBorderList()
  self._borderList = {}
  local allIDs = CPersonalityFrameConfig:GetAllIds()
  for i, v in ipairs(allIDs) do
    local borderData = {}
    local record = CPersonalityFrameConfig:GetRecorder(v)
    borderData.record = record
    borderData.isOwned = self:IsBorderUnlock(record.id)
    borderData.isCurrent = self:IsBorderCurrent(record.id)
    if borderData.isOwned == 1 then
      table.insert(self._borderList, borderData)
    elseif record.unlockvisibleornot == 1 then
      table.insert(self._borderList, borderData)
    end
  end
  table.sort(self._borderList, function(a, b)
    if a.isCurrent == b.isCurrent then
      if a.isOwned == b.isOwned then
        return a.record.order < b.record.order
      end
      return a.isOwned > b.isOwned
    end
    return a.isCurrent > b.isCurrent
  end)
  self._borderFrameHelper:ReloadAllCell()
  self._borderFrameHelper:MoveToTop()
  self:RefreshBorderInfo(self.curPanelFrame)
end

function SetBorderDialog:RefreshBorderInfo(borderId)
  local record = CPersonalityFrameConfig:GetRecorder(borderId)
  if record then
    self._borderName:SetText(NekoData.BehaviorManager.BM_Message:GetString(2294, {
      TextManager.GetText(record.nameTextID)
    }))
    self._borderSource:SetText(TextManager.GetText(record.source))
    self._borderDescription:SetText(TextManager.GetText(record.descriptionTextID))
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
    self._borderName:SetText("")
    self._borderSource:SetText("")
    self._borderDescription:SetText("")
    for i = 1, 4 do
      self._customBorder[i]:SetActive(false)
    end
  end
end

function SetBorderDialog:OnSelectBorderCell(borderId)
  self._curSelectBorderId = borderId
  self._borderFrameHelper:FireEvent("ChooseBorder", borderId)
  self:RefreshBorderInfo(borderId)
  if self:IsBorderUnlock(borderId) == 1 then
    self._confirmBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2284))
    self._cancelBtn:SetActive(true)
  else
    self._cancelBtn:SetActive(false)
    self._confirmBtnText:SetText(NekoData.BehaviorManager.BM_Message:GetString(2285))
  end
  self._confirmBtn:SetActive(true)
end

function SetBorderDialog:OnCancelBtnClicked()
  if self._curSelectBorderId >= 0 and self:IsBorderUnlock(self._curSelectBorderId) == 1 then
    if self._curSelectBorderId == self.curPanelFrame then
      local friendsMainDlg = DialogManager.GetDialog("friend.friendsmaindialog")
      if friendsMainDlg then
        friendsMainDlg:OnGroupClick(4)
      end
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100527)
    end
  end
end

function SetBorderDialog:OnConfirmBtnClicked()
  if self._curSelectBorderId >= 0 then
    if self:IsBorderUnlock(self._curSelectBorderId) == 1 then
      if self._curSelectBorderId == self.curPanelFrame then
        local friendsMainDlg = DialogManager.GetDialog("friend.friendsmaindialog")
        if friendsMainDlg then
          friendsMainDlg:OnGroupClick(4)
        end
      else
        local protocol = LuaNetManager.CreateProtocol("protocol.login2.cpanelframesetframe")
        protocol.curPanelFrame = self._curSelectBorderId
        protocol:Send()
      end
    else
      self:CheckAndJumpShopID()
    end
  end
end

function SetBorderDialog:CheckAndJumpShopID()
  NekoData.DataManager.DM_Shop:ClientSetOpenShopID("64+65")
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

function SetBorderDialog:UpdateCurBorder(serverData)
  self.curPanelFrame = serverData.curPanelFrame
  self:RefreshBorderInfo(self.curPanelFrame)
  if self.curPanelFrame >= 0 then
    self:OnSelectBorderCell(self.curPanelFrame)
  else
    self._cancelBtn:SetActive(false)
    self._confirmBtn:SetActive(false)
  end
end

function SetBorderDialog:UpdateBorderList(serverData)
  self.serverData = serverData
  self.curPanelFrame = serverData.curPanelFrame
  self:RefreshBorderList()
  if self.curPanelFrame >= 0 then
    self:OnSelectBorderCell(self.curPanelFrame)
  else
    self._cancelBtn:SetActive(false)
    self._confirmBtn:SetActive(false)
  end
end

function SetBorderDialog:IsBorderUnlock(borderId)
  local record = CPersonalityFrameConfig:GetRecorder(borderId)
  if record and record.id == 0 then
    return 1
  end
  if not self.serverData then
    return 0
  end
  for k, v in pairs(self.serverData.had) do
    if v == borderId then
      return 1
    end
  end
  return 0
end

function SetBorderDialog:IsBorderCurrent(borderId)
  if not self.serverData then
    return 0
  end
  if self.serverData.curPanelFrame == borderId then
    return 1
  end
  return 0
end

return SetBorderDialog
