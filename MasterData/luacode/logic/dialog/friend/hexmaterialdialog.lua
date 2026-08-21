-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/hexmaterialdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local HexMaterialDialog = class("HexMaterialDialog", Dialog)
HexMaterialDialog.AssetBundleName = "ui/layouts.friends"
HexMaterialDialog.AssetName = "FriendsAssist"
HexMaterialDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HexMaterialDialog
  ((HexMaterialDialog.super).Ctor)(self, ...)
end

HexMaterialDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._supportRole = self:GetChild("Role")
  self._supportRoleLive2D = self:GetChild("Role/Live2D")
  self._supportRolePhoto = self:GetChild("Role/Photo")
  self._supportRoleNameBack = self:GetChild("UI/Left/NameBack")
  self._supportRoleName = self:GetChild("UI/Left/NameBack/Name")
  self._supportRoleLv = self:GetChild("UI/Left/NameBack/Num")
  self._supportRoleRank = self:GetChild("UI/Left/NameBack/Rank")
  self._changeSupportRoleBtn = self:GetChild("UI/Left/ChangeBtn")
  self._addSupportRoleBtn = self:GetChild("UI/Left/AddBtn")
  ;
  (self._changeSupportRoleBtn):Subscribe_PointerClickEvent(self.OnChangeSupportRole, self)
  ;
  (self._addSupportRoleBtn):Subscribe_PointerClickEvent(self.OnChangeSupportRole, self)
  self._showCells = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

      (self._showCells)[i] = {}
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).role = self:GetChild("UI/Left/ShowCellNew" .. i)
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cell = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellDownRankBack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/DownRankBack")
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellPhoto = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Photo")
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellFrame = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Frame")
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellRank = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Rank")
      -- DECOMPILER ERROR at PC116: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellJob = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Job")
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellLv = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Level/Num")
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevelBackBlack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelBackBlack")
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevelBack = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelBack")
      -- DECOMPILER ERROR at PC152: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevel = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/BreakLevelNum")
      -- DECOMPILER ERROR at PC161: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellElementImage = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/Element")
      ;
      (((self._showCells)[i]).role):Subscribe_PointerClickEvent(self.OnChangeDisPlayRoles, self)
      ;
      (((self._showCells)[i]).cell):Subscribe_LongPressEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnRoleCellLongPress(i)
  end
)
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i])._charUpgrade = {panel = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/CharUpgrade"), 
levelImage = {}
}
      for j = 1, 5 do
        -- DECOMPILER ERROR at PC203: Confused about usage of register: R9 in 'UnsetPending'

        ((((self._showCells)[i])._charUpgrade).levelImage)[j] = self:GetChild("UI/Left/ShowCellNew" .. i .. "/Cell/CharUpgrade/Img" .. j)
      end
    end
  end
  self._modalArea = self:GetChild("UI/Left/MedalFrame")
  self._modalFrame = (TableFrame.Create)(self._modalArea, self, false, false, false)
  self._modalName = self:GetChild("UI/Left/Name")
  self._modalDetail = self:GetChild("UI/Left/Condition")
  self._modalChangeBtn = self:GetChild("UI/Left/ChangeMedalBtn")
  ;
  (self._modalChangeBtn):SetActive(false)
  ;
  (self._modalName):SetActive(false)
  ;
  (self._modalDetail):SetActive(false)
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
    -- DECOMPILER ERROR at PC295: Confused about usage of register: R5 in 'UnsetPending'

    (self._changeBtns)[i] = self:GetChild("UI/Right/ChangeBtn" .. i)
    ;
    ((self._changeBtns)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self, i
    self:OnChangeBtnClick(i)
  end
)
  end
  ;
  (self._copyIdBtn):Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
  ;
  (self._head):Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserName, Common.n_UserNameChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserIntroduce, Common.n_ChangeUserIntroduce, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadPhoto, Common.n_ChangeUserHeadPhoto, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserHeadFrame, Common.n_ChangeUserHeadFrame, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnChangeUserLikedNum, Common.n_ChangeUserLikedNum, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefresh, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSupportRolePanel, Common.n_SupportRoleChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshDisplayRolesPanel, Common.n_DisplayRolesChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshShowAchievement, Common.n_RefreshAchievementShowBag, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
end

HexMaterialDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._modalFrame):Destroy()
end

HexMaterialDialog.NumberOfCell = function(self, frame)
  -- function num : 0_3 , upvalues : _ENV
  return (table.nums)(self._modalList)
end

HexMaterialDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_4
  return "achievement.charshowmodalcell"
end

HexMaterialDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_5
  local data = {}
  data.id = (self._modalList)[index]
  return data
end

HexMaterialDialog.OnCellClick = function(self, id)
  -- function num : 0_6
  self:OnChangeModalBtnClicked()
end

HexMaterialDialog.OnChangeModalBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonChildDialog)("achievement.roleachievementgetmodalshowdialog", (self._delegate)._dialogName, (self._delegate):GetRootWindow())):SetData()
end

HexMaterialDialog.OnChangeUserName = function(self, notification)
  -- function num : 0_8
  (self._name):SetText((notification.userInfo).name)
end

HexMaterialDialog.OnChangeUserIntroduce = function(self, notification)
  -- function num : 0_9
  (self._introduction):SetText((notification.userInfo).introduce)
end

HexMaterialDialog.OnChangeUserHeadPhoto = function(self, notification)
  -- function num : 0_10 , upvalues : HeadPhotoTable, CImagePathTable, _ENV
  local headPhotoRecord = HeadPhotoTable:GetRecorder((notification.userInfo).avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

HexMaterialDialog.OnChangeUserHeadFrame = function(self, notification)
  -- function num : 0_11 , upvalues : HeadPhotoFrameTable, CImagePathTable, _ENV
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((notification.userInfo).frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

HexMaterialDialog.OnChangeUserLikedNum = function(self, notification)
  -- function num : 0_12
  self:RefreshUserLikedNum((notification.userInfo).likedNum)
end

HexMaterialDialog.OnRefresh = function(self)
  -- function num : 0_13
  self:SetData()
end

HexMaterialDialog.RefreshSupportRolePanel = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local role = ((NekoData.BehaviorManager).BM_Friends):GetSupportRole()
  if role then
    (self._supportRole):SetActive(true)
    ;
    (self._supportRoleNameBack):SetActive(true)
    ;
    (self._addSupportRoleBtn):SetActive(false)
    ;
    (self._changeSupportRoleBtn):SetActive(true)
    if self._handler then
      (self._supportRoleLive2D):Release(self._handler)
      self._handler = nil
    end
    local record = role:GetShapeLive2DRecord()
    if role:IsFashionLive2D() and (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName then
      (self._supportRolePhoto):SetActive(false)
      self._handler = (self._supportRoleLive2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      ;
      (self._supportRolePhoto):SetActive(true)
      ;
      (self._supportRolePhoto):SetSprite((role:GetShapeLiHuiImageRecord()).assetBundle, (role:GetShapeLiHuiImageRecord()).assetName)
      local scale = role:GetPhotoScale()
      ;
      (self._supportRolePhoto):SetLocalScale(scale, scale, scale)
      local photoPos = role:GetPhotoPosition()
      ;
      (self._supportRolePhoto):SetAnchoredPosition(photoPos[1], photoPos[2])
    end
    do
      do
        ;
        (self._supportRoleName):SetText(role:GetRoleName())
        ;
        (self._supportRoleLv):SetText(role:GetLevel())
        if not role:GetIsLeader() then
          (self._supportRoleRank):SetActive(true)
          ;
          (self._supportRoleRank):SetSprite((role:GetRoleInfoRarityImageRecord()).assetBundle, (role:GetRoleInfoRarityImageRecord()).assetName)
        else
          ;
          (self._supportRoleRank):SetActive(false)
        end
        ;
        (self._supportRole):SetActive(false)
        ;
        (self._supportRoleNameBack):SetActive(false)
        ;
        (self._addSupportRoleBtn):SetActive(true)
        ;
        (self._changeSupportRoleBtn):SetActive(false)
      end
    end
  end
end

HexMaterialDialog.RefreshDisplayRolesPanel = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_Friends):GetDisplayRoles()
  for i = 1, 4 do
    if #roleList < i then
      (((self._showCells)[i]).cell):SetActive(false)
    else
      ;
      (((self._showCells)[i]).cell):SetActive(true)
      local imageRecord = (roleList[i]):GetShapeLittleHeadImageRecord()
      ;
      (((self._showCells)[i]).cellPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (roleList[i]):GetSmallRarityFrameRecord()
      ;
      (((self._showCells)[i]).cellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (roleList[i]):GetRarityImageRecord()
      ;
      (((self._showCells)[i]).cellRank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (roleList[i]):GetVocationImageRecord()
      ;
      (((self._showCells)[i]).cellJob):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (((self._showCells)[i]).cellLv):SetText(tostring((roleList[i]):GetShowLv()))
      local breakLv = (roleList[i]):GetBreakLv()
      ;
      (((self._showCells)[i]).cellBreakLevelBackBlack):SetActive(breakLv == 0)
      ;
      (((self._showCells)[i]).cellBreakLevelBack):SetActive(breakLv > 0)
      ;
      (((self._showCells)[i]).cellBreakLevel):SetActive(breakLv > 0)
      if breakLv > 0 then
        imageRecord = (roleList[i]):GetCurBreakFrame2ImageRecord()
        ;
        (((self._showCells)[i]).cellBreakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._showCells)[i]).cellBreakLevel):SetText(breakLv)
      end
      imageRecord = (roleList[i]):GetRarityBottomBackRecord()
      ;
      (((self._showCells)[i]).cellDownRankBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (roleList[i]):GetElementImageRecord()
      ;
      (((self._showCells)[i]).cellElementImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local level = (roleList[i]):GetRuneLevel()
      ;
      ((((self._showCells)[i])._charUpgrade).panel):SetActive(level ~= 0)
      for j = 1, 5 do
        (((((self._showCells)[i])._charUpgrade).levelImage)[j]):SetActive(level == j)
      end
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

HexMaterialDialog.RefreshUserInfoPanel = function(self)
  -- function num : 0_16 , upvalues : _ENV, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable
  local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
  local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._playerLevel):SetText(userInfo.userlevel)
  ;
  (self._id):SetText(tostring(userInfo.userid))
  ;
  (self._name):SetText(tostring(userInfo.username))
  ;
  (self._introduction):SetText(userInfo.introduce)
  ;
  (self._IPHome):SetText(userInfo.iplocaladdr)
  self:RefreshUserLikedNum(userInfo.likedNum)
end

HexMaterialDialog.SetData = function(self)
  -- function num : 0_17
  self:RefreshSupportRolePanel()
  self:RefreshDisplayRolesPanel()
  self:RefreshUserInfoPanel()
  self:RefreshShowAchievement()
end

HexMaterialDialog.RefreshShowAchievement = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self._modalList = ((NekoData.BehaviorManager).BM_Task):GetShowBadges()
  if self._modalList then
    (self._modalFrame):ReloadAllCell()
  end
end

HexMaterialDialog.OnUniqueEquipLevelUp = function(self, notification)
  -- function num : 0_19
  self:RefreshDisplayRolesPanel()
end

HexMaterialDialog.RefreshUserLikedNum = function(self, value)
  -- function num : 0_20 , upvalues : _ENV
  local likeNumber = tonumber(value)
  if likeNumber then
    if likeNumber < 999999 then
      (self._greatNum):SetText(tostring(value))
    else
      ;
      (self._greatNum):SetText((TextManager.GetText)(701179))
    end
  end
end

HexMaterialDialog.OnChangeSupportRole = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(19) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(19)
  end
  ;
  (DialogManager.CreateSingletonDialog)("assistbattle.changesupportroledialog")
end

HexMaterialDialog.OnChangeDisPlayRoles = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("assistbattle.changedisplayrolesdialog")
end

HexMaterialDialog.OnRoleCellLongPress = function(self, index)
  -- function num : 0_23 , upvalues : _ENV
  local role = nil
  if index == 5 then
    role = ((NekoData.BehaviorManager).BM_Friends):GetSupportRole()
  else
    role = (((NekoData.BehaviorManager).BM_Friends):GetDisplayRoles())[index]
  end
  local dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if not dialog and role then
    dialog = (DialogManager.CreateSingletonDialog)("character.newcharacterinfodialog")
    dialog:Refresh(role)
  end
end

HexMaterialDialog.OnCopyIDBtnClicked = function(self)
  -- function num : 0_24 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring((((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userid))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

HexMaterialDialog.OnHeadPhotoClicked = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.editheaddialog")
end

HexMaterialDialog.OnChangeBtnClick = function(self, index)
  -- function num : 0_26 , upvalues : _ENV
  if index == 1 then
    (DialogManager.CreateSingletonDialog)("systemsetting.changenamedialog")
  else
  end
  if index == 2 then
    (DialogManager.CreateSingletonDialog)("systemsetting.introductiondialog")
  end
end

return HexMaterialDialog

