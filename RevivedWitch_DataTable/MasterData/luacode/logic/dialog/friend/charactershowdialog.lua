-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/friend/charactershowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleBreakCfgTable = (BeanManager.GetTableByName)("role.crolebreakcfg")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CharacterShowDialog = class("CharacterShowDialog", Dialog)
CharacterShowDialog.AssetBundleName = "ui/layouts.friends"
CharacterShowDialog.AssetName = "PlayerShow"
CharacterShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterShowDialog
  ((CharacterShowDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

CharacterShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._supportRolePanel = self:GetChild("Role")
  self._supportRolePanelLive2d = self:GetChild("Role/Live2D")
  self._supportRolePanelPhoto = self:GetChild("Role/Photo")
  self._showCells = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      (self._showCells)[i] = {}
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).role = self:GetChild("Show/ShowCellNew" .. i)
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cell = self:GetChild("Show/ShowCellNew" .. i .. "/Cell")
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellDownRankBack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/DownRankBack")
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellPhoto = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Photo")
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellFrame = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Frame")
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellRank = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Rank")
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellJob = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Job")
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellLv = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Level/Num")
      -- DECOMPILER ERROR at PC100: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevelBackBlack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelBackBlack")
      -- DECOMPILER ERROR at PC109: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevelBack = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelBack")
      -- DECOMPILER ERROR at PC118: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellBreakLevel = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/BreakLevelNum")
      -- DECOMPILER ERROR at PC127: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i]).cellElementImage = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/Element")
      ;
      (((self._showCells)[i]).role):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnRoleCellClicked(i)
  end
, self)
      -- DECOMPILER ERROR at PC147: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._showCells)[i])._charUpgrade = {panel = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/CharUpgrade"), 
levelImage = {}
}
      for j = 1, 5 do
        -- DECOMPILER ERROR at PC163: Confused about usage of register: R9 in 'UnsetPending'

        ((((self._showCells)[i])._charUpgrade).levelImage)[j] = self:GetChild("Show/ShowCellNew" .. i .. "/Cell/CharUpgrade/Img" .. j)
      end
    end
  end
  self._modalArea = self:GetChild("Show/MedalFrame")
  self._modalFrame = (TableFrame.Create)(self._modalArea, self, false, false, false)
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
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._copyIdBtn):Subscribe_PointerClickEvent(self.OnCopyIDBtnClicked, self)
end

CharacterShowDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._modalFrame):Destroy()
end

CharacterShowDialog.NumberOfCell = function(self, frame)
  -- function num : 0_3 , upvalues : _ENV
  return (table.nums)(self._modalList)
end

CharacterShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_4
  return "achievement.charshowmodalcell"
end

CharacterShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_5
  local data = {}
  data.id = (self._modalList)[index]
  return data
end

CharacterShowDialog.GetVocationImageRecord = function(self, rarityId, vocation)
  -- function num : 0_6 , upvalues : CVocationCfgTable, CImagePathTable, _ENV
  local vocationRecord = CVocationCfgTable:GetRecorder(vocation)
  if rarityId == 1 then
    if not CImagePathTable:GetRecorder(vocationRecord.imgR) then
      do return DataCommon.DefaultImageAsset end
      if rarityId == 2 then
        if not CImagePathTable:GetRecorder(vocationRecord.imgSR) then
          do return DataCommon.DefaultImageAsset end
          if rarityId == 3 then
            if not CImagePathTable:GetRecorder(vocationRecord.imgSSR) then
              do return DataCommon.DefaultImageAsset end
              if rarityId == 4 then
                if not CImagePathTable:GetRecorder(vocationRecord.imgUR) then
                  do return DataCommon.DefaultImageAsset end
                  if rarityId == 5 then
                    if not CImagePathTable:GetRecorder(vocationRecord.imgEX) then
                      do return DataCommon.DefaultImageAsset end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

CharacterShowDialog.GetBreakRecord = function(self, breakType, breaklevel)
  -- function num : 0_7 , upvalues : CRoleBreakCfgTable
  for i = 1, #CRoleBreakCfgTable:GetAllIds() do
    local recorder = CRoleBreakCfgTable:GetRecorder(i)
    if recorder.breakType == breakType and breaklevel == recorder.breaklv then
      return recorder
    end
  end
end

CharacterShowDialog.RefreshSupportRolePanel = function(self, protocol)
  -- function num : 0_8 , upvalues : RoleConfigTable, Role, _ENV
  local roleId = (protocol.support).roleId
  local roleConfig = RoleConfigTable:GetRecorder(roleId)
  if roleConfig then
    (self._supportRolePanel):SetActive(true)
    local data = (Role.Create)(roleId)
    if data then
      data:UpdateShape((protocol.support).skin)
      local record = data:GetShapeLive2DRecord()
      if self._handler then
        (self._supportRolePanelLive2d):Release(self._handler)
      end
      if data:IsFashionLive2D() and (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
        (self._supportRolePanelPhoto):SetActive(false)
        self._handler = (self._supportRolePanelLive2d):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
      else
        ;
        (self._supportRolePanelPhoto):SetActive(true)
        ;
        (self._supportRolePanelPhoto):SetSprite((data:GetShapeLiHuiImageRecord()).assetBundle, (data:GetShapeLiHuiImageRecord()).assetName)
        local scale = data:GetPhotoScale()
        ;
        (self._supportRolePanelPhoto):SetLocalScale(scale, scale, scale)
        local photoPos = data:GetPhotoPosition()
        ;
        (self._supportRolePanelPhoto):SetAnchoredPosition(photoPos[1], photoPos[2])
      end
    else
      do
        do
          LogErrorFormat("CharacterShowDialog", "support role id %s create with wrong", roleId)
          ;
          (self._supportRolePanel):SetActive(false)
        end
      end
    end
  end
end

CharacterShowDialog.RefreshDisplayRolesPanel = function(self, protocol)
  -- function num : 0_9 , upvalues : Role
  for i = 1, 4 do
    if #protocol.display < i then
      (((self._showCells)[i]).cell):SetActive(false)
    else
      local role = (Role.Create)(((protocol.display)[i]).id)
      role:UpdateShape(((protocol.display)[i]).skin)
      ;
      (((self._showCells)[i]).cell):SetActive(true)
      local imageRecord = role:GetShapeLittleHeadImageRecord()
      ;
      (((self._showCells)[i]).cellPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetSmallRarityFrameRecord()
      ;
      (((self._showCells)[i]).cellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetRarityImageRecord()
      ;
      (((self._showCells)[i]).cellRank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetVocationImageRecord()
      ;
      (((self._showCells)[i]).cellJob):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      role:SetLevel(((protocol.display)[i]).lv)
      role:SetBreakLv(((protocol.display)[i]).breakLv)
      ;
      (((self._showCells)[i]).cellLv):SetText(role:GetShowLv())
      local breakLv = ((protocol.display)[i]).breakLv
      ;
      (((self._showCells)[i]).cellBreakLevelBackBlack):SetActive(breakLv == 0)
      ;
      (((self._showCells)[i]).cellBreakLevelBack):SetActive(breakLv > 0)
      ;
      (((self._showCells)[i]).cellBreakLevel):SetActive(breakLv > 0)
      if breakLv > 0 then
        imageRecord = role:GetCurBreakFrame2ImageRecord()
        ;
        (((self._showCells)[i]).cellBreakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (((self._showCells)[i]).cellBreakLevel):SetText(breakLv)
      end
      imageRecord = role:GetRarityBottomBackRecord()
      ;
      (((self._showCells)[i]).cellDownRankBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = role:GetElementImageRecord()
      ;
      (((self._showCells)[i]).cellElementImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      role:SetRuneLevel(((protocol.display)[i]).runeLevel)
      local level = role:GetRuneLevel()
      ;
      ((((self._showCells)[i])._charUpgrade).panel):SetActive(level ~= 0)
      for j = 1, 5 do
        (((((self._showCells)[i])._charUpgrade).levelImage)[j]):SetActive(level == j)
      end
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

CharacterShowDialog.RefreshUserInfoPanel = function(self, protocol)
  -- function num : 0_10 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  local headPhotoRecord = HeadPhotoTable:GetRecorder((protocol.baseUserData).avatarId)
  if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder((protocol.baseUserData).frameId)
  if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._headFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._id):SetText(tostring((protocol.baseUserData).userId))
  ;
  (self._name):SetText(tostring((protocol.baseUserData).userName))
  ;
  (self._title):SetText(tostring(protocol.title))
  ;
  (self._level):SetText(tostring((protocol.baseUserData).userLv))
  ;
  (self._introduction):SetText(protocol.introduce)
  ;
  (self._IPHome):SetText((protocol.baseUserData).iplocaladdr)
  self._userId = (protocol.baseUserData).userId
end

CharacterShowDialog.SetData = function(self, protocol)
  -- function num : 0_11 , upvalues : _ENV
  self:RefreshSupportRolePanel(protocol)
  self:RefreshDisplayRolesPanel(protocol)
  self:RefreshUserInfoPanel(protocol)
  self._roleInfoList = protocol.display
  self._modalList = ((NekoData.BehaviorManager).BM_Task):GetOtherShowBadges((protocol.baseUserData).showBadges)
  if self._modalList then
    (self._modalFrame):ReloadAllCell()
  end
  local isFriend = ((NekoData.BehaviorManager).BM_Friends):IsFriend((protocol.baseUserData).userId)
  ;
  (self._addBtn):SetActive(not isFriend)
  ;
  (self._friendTitle):SetActive(isFriend)
  ;
  (self._otherTitle):SetActive(not isFriend)
  local likeNumber = tonumber(protocol.likedNum)
  if likeNumber then
    if likeNumber < 999999 then
      (self._greatNum):SetText(tostring(protocol.likedNum))
    else
      ;
      (self._greatNum):SetText((TextManager.GetText)(701179))
    end
  end
  if (DialogManager.GetDialog)("activity.chrismascall.maindialog") then
    (self._newBack):SetActive(true)
  else
    ;
    (self._newBack):SetActive(false)
  end
end

CharacterShowDialog.OnCopyIDBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (self:GetRootWindow()):CopyToClipBoard(tostring(self._userId))
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100079)
end

CharacterShowDialog.OnRoleCellClicked = function(self, index)
  -- function num : 0_13 , upvalues : _ENV, CheckOtherRoleInfoDialog
  if (self._roleInfoList)[index] then
    ((DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")):Init({roleList = self._roleInfoList, index = index}, (CheckOtherRoleInfoDialog.ShowType).FriendShow)
  end
end

CharacterShowDialog.OnAddBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):GetUserId() == self._userId then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100043)
    return 
  end
  local friend = ((NekoData.BehaviorManager).BM_Friends):GetFriend(self._userId)
  if friend and friend:IsBlack() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100046)
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Friends):RequesAddFriend(self._userId)
end

CharacterShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

return CharacterShowDialog

