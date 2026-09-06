local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local CPersonalityFrameConfig = BeanManager.GetTableByName("headphoto.cpersonalityframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local HexMaterialDialog = class("HexMaterialDialog", Dialog)
HexMaterialDialog.AssetBundleName = "ui/layouts.friends"
HexMaterialDialog.AssetName = "FriendsAssist"

function HexMaterialDialog:Ctor(...)
  HexMaterialDialog.super.Ctor(self, ...)
end

function HexMaterialDialog:OnCreate()
  self._supportRole = self:GetChild("Role")
  self._supportRoleLive2D = self:GetChild("Role/Live2D")
  self._supportRolePhoto = self:GetChild("Role/Photo")
  self._supportRoleNameBack = self:GetChild("UI/Left/NameBack")
  self._supportRoleName = self:GetChild("UI/Left/NameBack/Name")
  self._supportRoleLv = self:GetChild("UI/Left/NameBack/Num")
  self._supportRoleRank = self:GetChild("UI/Left/NameBack/Rank")
  self._changeSupportRoleBtn = self:GetChild("UI/Left/ChangeBtn")
  self._addSupportRoleBtn = self:GetChild("UI/Left/AddBtn")
  self._changeSupportRoleBtn:Subscribe_PointerClickEvent(self.OnChangeSupportRole, self)
  self._addSupportRoleBtn:Subscribe_PointerClickEvent(self.OnChangeSupportRole, self)
  self._showCells = {}
  for i = 1, 4 do
    self._showCells[i] = {}
    self._showCells[i].role = self:GetChild("UI/Left/ShowCellNew" .. i)
    self._showCells[i].cell = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell")
    self._showCells[i].cellDownRankBack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/DownRankBack")
    self._showCells[i].cellPhoto = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Photo")
    self._showCells[i].cellFrame = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Frame")
    self._showCells[i].cellRank = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Rank")
    self._showCells[i].cellJob = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Job")
    self._showCells[i].cellLv = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Level/Num")
    self._showCells[i].cellBreakLevelBackBlack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelBackBlack")
    self._showCells[i].cellBreakLevelBack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelBack")
    self._showCells[i].cellBreakLevel = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelNum")
    self._showCells[i].cellElementImage = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Element")
    self._showCells[i].role:Subscribe_PointerClickEvent(self.OnChangeDisPlayRoles, self)
    self._showCells[i].cell:Subscribe_LongPressEvent(function()
      self:OnRoleCellLongPress(i)
    end)
    self._showCells[i]._charUpgrade = {
      panel = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/CharUpgrade"),
      levelImage = {}
    }
    for j = 1, 5 do
      self._showCells[i]._charUpgrade.levelImage[j] = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/CharUpgrade/Img" .. j)
    end
  end
  self._modalArea = self:GetChild("UI/Left/MedalFrame")
  self._modalFrame = TableFrame.Create(self._modalArea, self, false, false, false)
  self._modalName = self:GetChild("UI/Left/Name")
  self._modalDetail = self:GetChild("UI/Left/Condition")
  self._modalChangeBtn = self:GetChild("UI/Left/ChangeMedalBtn")
  self._modalChangeBtn:SetActive(false)
  self._modalName:SetActive(false)
  self._modalDetail:SetActive(false)
  self._IPHome = self:GetChild("UI/Right/IP/IPTxt")
  self._id = self:GetChild("UI/Right/ID/IDNum")
  self._copyIdBtn = self:GetChild("UI/Right/CopyBtn")
  self._name = self:GetChild("UI/Right/NameBack/Name")
  self._head = self:GetChild("UI/Right/HeadPhoto")
  self._headPhoto = self:GetChild("UI/Right/HeadPhoto/Photo")
  self._headFrame = self:GetChild("UI/Right/HeadPhoto/Frame")
  self._playerLevel = self:GetChild("UI/Right/LvBack/Level")
  self._introduction = self:GetChild("UI/Right/IntroductionBack/Txt")
  self._greatNum = self:GetChild("UI/Right/ThumbsUpNum/Num")
  self._changeBtns = {}
  for i = 1, 3 do
    self._changeBtns[i] = self:GetChild("UI/Right/ChangeBtn" .. i)
    self._changeBtns[i]:Subscribe_PointerClickEvent(function()
      self:OnChangeBtnClick(i)
    end)
  end
  self._copyIdBtn:Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  self._head:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._customBorder = {}
  for i = 1, 4 do
    self._customBorder[i] = self:GetChild("Frame" .. i)
    self._customBorder[i]:SetActive(false)
  end
  self._guildBack = self:GetChild("UI/Right/Guild")
  self._guildBack:SetActive(false)
  self._guildName = self:GetChild("UI/Right/Guild/GuildTxt")
  self._guildName:SetText("")
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

function HexMaterialDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._modalFrame:Destroy()
end

function HexMaterialDialog:NumberOfCell(frame)
  return table.nums(self._modalList)
end

function HexMaterialDialog:CellAtIndex(frame, index)
  return "achievement.charshowmodalcell"
end

function HexMaterialDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._modalList[index]
  return data
end

function HexMaterialDialog:OnCellClick(id)
  self:OnChangeModalBtnClicked()
end

function HexMaterialDialog:OnChangeModalBtnClicked()
  DialogManager.CreateSingletonChildDialog("achievement.roleachievementgetmodalshowdialog", self._delegate._dialogName, self._delegate:GetRootWindow()):SetData()
end

function HexMaterialDialog:OnChangeUserName(notification)
  self._name:SetText(notification.userInfo.name)
end

function HexMaterialDialog:OnChangeUserIntroduce(notification)
  self._introduction:SetText(notification.userInfo.introduce)
end

function HexMaterialDialog:OnChangeUserHeadPhoto(notification)
  local headPhotoRecord = HeadPhotoTable:GetRecorder(notification.userInfo.avatarId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
  self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function HexMaterialDialog:OnChangeUserHeadFrame(notification)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(notification.userInfo.frameId)
  local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
  self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function HexMaterialDialog:OnChangeUserLikedNum(notification)
  self:RefreshUserLikedNum(notification.userInfo.likedNum)
end

function HexMaterialDialog:OnRefresh()
  self:SetData()
end

function HexMaterialDialog:RefreshSupportRolePanel()
  local role = NekoData.BehaviorManager.BM_Friends:GetSupportRole()
  if role then
    self._supportRole:SetActive(true)
    self._supportRoleNameBack:SetActive(true)
    self._addSupportRoleBtn:SetActive(false)
    self._changeSupportRoleBtn:SetActive(true)
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
    self._supportRoleName:SetText(role:GetRoleName())
    self._supportRoleLv:SetText(role:GetLevel())
    if not role:GetIsLeader() then
      self._supportRoleRank:SetActive(true)
      self._supportRoleRank:SetSprite(role:GetRoleInfoRarityImageRecord().assetBundle, role:GetRoleInfoRarityImageRecord().assetName)
    else
      self._supportRoleRank:SetActive(false)
    end
  else
    self._supportRole:SetActive(false)
    self._supportRoleNameBack:SetActive(false)
    self._addSupportRoleBtn:SetActive(true)
    self._changeSupportRoleBtn:SetActive(false)
  end
end

function HexMaterialDialog:RefreshDisplayRolesPanel()
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

function HexMaterialDialog:RefreshUserInfoPanel()
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
  self._guildBack:SetActive(true)
  if string.len(guildInfo.partyName) > 0 then
    self._guildName:SetText(guildInfo.partyName)
  else
    self._guildName:SetText(TextManager.GetText(CStringRes:GetRecorder(2296).msgTextID))
  end
end

function HexMaterialDialog:SetData()
  self:RefreshSupportRolePanel()
  self:RefreshDisplayRolesPanel()
  self:RefreshUserInfoPanel()
  self:RefreshShowAchievement()
end

function HexMaterialDialog:RefreshShowAchievement()
  self._modalList = NekoData.BehaviorManager.BM_Task:GetShowBadges()
  if self._modalList then
    self._modalFrame:ReloadAllCell()
  end
end

function HexMaterialDialog:OnUniqueEquipLevelUp(notification)
  self:RefreshDisplayRolesPanel()
end

function HexMaterialDialog:RefreshUserLikedNum(value)
  local likeNumber = tonumber(value)
  if likeNumber then
    if likeNumber < 999999 then
      self._greatNum:SetText(tostring(value))
    else
      self._greatNum:SetText(TextManager.GetText(701179))
    end
  end
end

function HexMaterialDialog:OnChangeSupportRole()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(19) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(19)
  end
  DialogManager.CreateSingletonDialog("assistbattle.changesupportroledialog")
end

function HexMaterialDialog:OnChangeDisPlayRoles()
  DialogManager.CreateSingletonDialog("assistbattle.changedisplayrolesdialog")
end

function HexMaterialDialog:OnRoleCellLongPress(index)
  local role
  if index == 5 then
    role = NekoData.BehaviorManager.BM_Friends:GetSupportRole()
  else
    role = NekoData.BehaviorManager.BM_Friends:GetDisplayRoles()[index]
  end
  local dialog = DialogManager.GetDialog("character.newcharacterinfodialog")
  if not dialog and role then
    dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    dialog:Refresh(role)
  end
end

function HexMaterialDialog:OnCopyIDBtnClicked()
  self:GetRootWindow():CopyToClipBoard(tostring(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid))
  NekoData.BehaviorManager.BM_Message:SendMessageById(100079)
end

function HexMaterialDialog:OnHeadPhotoClicked()
  DialogManager.CreateSingletonDialog("systemsetting.editheaddialog")
end

function HexMaterialDialog:OnChangeBtnClick(index)
  if index == 1 then
    DialogManager.CreateSingletonDialog("systemsetting.changenamedialog")
  elseif index == 2 then
  else
    DialogManager.CreateSingletonDialog("systemsetting.introductiondialog")
  end
end

function HexMaterialDialog:RefreshBorderList()
  self:RefreshBorderInfo(self.curPanelFrame)
end

function HexMaterialDialog:RefreshBorderInfo(borderId)
  local record = CPersonalityFrameConfig:GetRecorder(borderId)
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

function HexMaterialDialog:UpdateCurBorder(serverData)
  self.curPanelFrame = serverData.curPanelFrame
  self:RefreshBorderList()
end

function HexMaterialDialog:UpdateBorderList(serverData)
  self.serverData = serverData
  self.curPanelFrame = serverData.curPanelFrame
  self:RefreshBorderList()
end

return HexMaterialDialog
