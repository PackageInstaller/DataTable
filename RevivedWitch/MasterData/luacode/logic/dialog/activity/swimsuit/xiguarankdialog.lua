-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguarankdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BossChallenge = (LuaNetManager.GetBeanDef)("protocol.ranking.bosschallenge")
local TopToBottom = 4
local XiGuaRankDialog = class("XiGuaRankDialog", Dialog)
XiGuaRankDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankDialog.AssetName = "ActivitySummerXiGuaRank"
XiGuaRankDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaRankDialog
  ((XiGuaRankDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._selectedBossCellIndex = 0
  self._fatherData = {}
  self._bossData = {}
  self._personRankData = {}
  self._totalRankData = {}
end

XiGuaRankDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, TableFrame
  self._emptyTxt = self:GetChild("EmptyTxt")
  self._bossPanel = self:GetChild("BossFrame")
  self._playerPanel = self:GetChild("Frame")
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._bossFrame = (TableFrame.Create)(self._bossPanel, self, true, true, true)
  self._playerFrame = (TableFrame.Create)(self._playerPanel, self, true, true, true)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._selfRankPanel = self:GetChild("Char/ActivitySummerXiGuaRankCell")
  self._selfBack = {[1] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Back1"), [2] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Back2"), [3] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Back3")}
  self._selfBackNormal = self:GetChild("Char/ActivitySummerXiGuaRankCell/Back")
  self._selfBackPlayer = self:GetChild("Char/ActivitySummerXiGuaRankCell/BackPlayer")
  self._selfRank = {[1] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/Rank1"), [2] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/Rank2"), [3] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/Rank3")}
  self._selfRankNormal = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/Rank")
  self._selfPhoto = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/PlayerInfo/HeadPhoto/Photo")
  self._selfPhotoFrame = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/PlayerInfo/HeadPhoto/Frame")
  self._selfName = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/PlayerInfo/NameBack/Name")
  self._selfLevel = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/PlayerInfo/LvBack/Level")
  self._selfRole = {[1] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack3/Char"), [2] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack2/Char"), [3] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack1/Char")}
  self._selfRoleBack = {[1] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack3"), [2] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack2"), [3] = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/CharBack1")}
  self._selfMaxDamageNum = self:GetChild("Char/ActivitySummerXiGuaRankCell/Panel/Num")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._selfRankPanel):Subscribe_PointerClickEvent(self.OnSelfRankPanel, self)
end

XiGuaRankDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._bossFrame):Destroy()
  ;
  (self._playerFrame):Destroy()
end

XiGuaRankDialog.SetData = function(self, data)
  -- function num : 0_3
  self._fatherData = data.totalData
  self._constructionId = data.constructionID
  self:RefreshBossData()
  self:OneBossCellSelect(1)
end

XiGuaRankDialog.RefreshBossData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for key,_ in pairs(self._bossData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._bossData)[key] = nil
  end
  for _,value in ipairs(self._fatherData) do
    if value.isUnlock then
      (table.insert)(self._bossData, 1, {cfg = value.cfg})
    end
  end
  ;
  (table.sort)(self._bossData, function(a, b)
    -- function num : 0_4_0
    do return (a.cfg).sort < (b.cfg).sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._bossFrame):ReloadAllCell()
end

XiGuaRankDialog.OnSwaterMelonChallengeRanking = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  local index = nil
  for key,value in ipairs(self._bossData) do
    if (value.cfg).id == protocol.id then
      index = key
      break
    end
  end
  do
    if index == nil then
      return 
    end
    self._selectedBossCellIndex = index
    ;
    (self._bossFrame):FireEvent("ChangedSelected", index)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._personRankData)[index] = protocol.personRank
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._totalRankData)[index] = protocol.ranking
    self:RefreshPersonRankData(index)
    self:RefreshTotalRankData(index)
  end
end

XiGuaRankDialog.RefreshPersonRankData = function(self, selectIndex)
  -- function num : 0_6 , upvalues : BossChallenge, _ENV, CStringRes, HeadPhotoTable, CImagePathTable, HeadPhotoFrameTable, CSkin, CNpcShapeTable, RoleConfigTable
  if (self._personRankData)[selectIndex] then
    (self._selfRankPanel):SetActive(true)
    local personRank = ((self._personRankData)[selectIndex]).rank
    local personBossData = ((self._personRankData)[selectIndex]).watermelonPanelData
    for i = 1, 3 do
      ((self._selfBack)[i]):SetActive(i == personRank)
      ;
      ((self._selfRank)[i]):SetActive(i == personRank)
    end
    if personRank > 3 then
      (self._selfBackPlayer):SetActive(true)
      ;
      (self._selfRankNormal):SetActive(true)
      ;
      (self._selfRankNormal):SetText(personRank)
    elseif personRank == BossChallenge.NOT_ON_LIST then
      (self._selfBackPlayer):SetActive(true)
      ;
      (self._selfRankNormal):SetActive(true)
      ;
      (self._selfRankNormal):SetText((TextManager.GetText)((CStringRes:GetRecorder(1421)).msgTextID))
    elseif personRank == BossChallenge.NOT_Challenge then
      (self._selfBackPlayer):SetActive(true)
      ;
      (self._selfRankNormal):SetActive(true)
      ;
      (self._selfRankNormal):SetText((TextManager.GetText)((CStringRes:GetRecorder(1420)).msgTextID))
    else
      (self._selfBackPlayer):SetActive(false)
      ;
      (self._selfRankNormal):SetActive(false)
    end
    ;
    (self._selfBackNormal):SetActive(false)
    if personRank == BossChallenge.NOT_ON_LIST or personRank == BossChallenge.NOT_Challenge then
      local userInfo = ((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()
      ;
      (self._selfName):SetText(userInfo.username)
      ;
      (self._selfLevel):SetText(userInfo.userlevel)
      local headPhotoRecord = HeadPhotoTable:GetRecorder(userInfo.avatarId)
      if headPhotoRecord then
        if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._selfPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        (self._selfPhoto):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
        LogErrorFormat("XiGuaRankDialog", "headPhotoRecord not found. avatarId = %s", userInfo.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(userInfo.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._selfPhotoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        (self._selfPhotoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
        LogErrorFormat("XiGuaRankDialog", "headPhotoFrameRecord not found. frameId = %s", userInfo.frameId)
      end
    else
      local personUserData = ((self._personRankData)[selectIndex]).baseUserData
      ;
      (self._selfName):SetText(personUserData.userName)
      ;
      (self._selfLevel):SetText(personUserData.userLv)
      local headPhotoRecord = HeadPhotoTable:GetRecorder(personUserData.avatarId)
      if headPhotoRecord then
        if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._selfPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        (self._selfPhoto):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
        LogErrorFormat("XiGuaRankDialog", "headPhotoRecord not found. avatarId = %s", personUserData.avatarId)
      end
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(personUserData.frameId)
      if headPhotoFrameRecord then
        if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
          local imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (self._selfPhotoFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        (self._selfPhotoFrame):SetSprite((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
        LogErrorFormat("XiGuaRankDialog", "headPhotoFrameRecord not found. frameId = %s", personUserData.frameId)
      end
    end
    if personRank == BossChallenge.NOT_Challenge then
      (self._selfMaxDamageNum):SetActive(false)
      for i = 1, 3 do
        ((self._selfRole)[i]):SetActive(false)
        ;
        ((self._selfRoleBack)[i]):SetActive(false)
      end
    else
      (self._selfMaxDamageNum):SetActive(true)
      ;
      (self._selfMaxDamageNum):SetText(personBossData.damage)
      for index,roleID in ipairs(personBossData.roleIdList) do
        if (self._selfRole)[index] then
          if roleID > 0 then
            ((self._selfRole)[index]):SetActive(true)
            local shapeCfg = nil
            local skinID = (personBossData.roleSkinList)[index]
            if skinID > 0 then
              local skin = CSkin:GetRecorder(skinID)
              shapeCfg = CNpcShapeTable:GetRecorder(skin.shapeID)
            else
              local roleCfg = RoleConfigTable:GetRecorder(roleID)
              shapeCfg = CNpcShapeTable:GetRecorder(roleCfg.shapeID)
            end
            if not CImagePathTable:GetRecorder(shapeCfg.skillHeadID) then
              local imageRecord = DataCommon.DefaultImageAsset
            end
            ;
            ((self._selfRole)[index]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          else
            ((self._selfRole)[index]):SetActive(false)
          end
        end
      end
    end
  else
    (self._selfRankPanel):SetActive(false)
  end
  -- DECOMPILER ERROR: 27 unprocessed JMP targets
end

XiGuaRankDialog.RefreshTotalRankData = function(self, selectIndex)
  -- function num : 0_7
  if #(self._totalRankData)[self._selectedBossCellIndex] == 0 then
    (self._emptyTxt):SetActive(true)
  else
    ;
    (self._emptyTxt):SetActive(false)
  end
  ;
  (self._playerFrame):ReloadAllCell()
  ;
  (self._playerFrame):MoveToTop()
end

XiGuaRankDialog.OneBossCellSelect = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  if (self._bossData)[index] then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.ranking.cwatermelonchallengeranking")
    if protocol then
      protocol.id = (((self._bossData)[index]).cfg).id
      protocol:Send()
    end
  end
end

XiGuaRankDialog.OnePalyerCellClicked = function(self, rankDataIndex, fatherClick)
  -- function num : 0_9 , upvalues : _ENV
  local dialogName = "activity.swimsuit.xiguarankteamdialog"
  local dialog = (DialogManager.GetDialog)(dialogName)
  if not dialog then
    dialog = (DialogManager.CreateSingletonDialog)(dialogName)
  end
  if fatherClick then
    dialog:SetData((self._bossData)[self._selectedBossCellIndex], (self._personRankData)[self._selectedBossCellIndex])
  else
    dialog:SetData((self._bossData)[self._selectedBossCellIndex], ((self._totalRankData)[self._selectedBossCellIndex])[rankDataIndex])
  end
end

XiGuaRankDialog.OnSelfRankPanel = function(self)
  -- function num : 0_10 , upvalues : BossChallenge
  if (self._personRankData)[self._selectedBossCellIndex] == nil or ((self._personRankData)[self._selectedBossCellIndex]).rank == BossChallenge.NOT_Challenge or ((self._personRankData)[self._selectedBossCellIndex]).rank == BossChallenge.NOT_ON_LIST then
    return 
  end
  self:OnePalyerCellClicked(nil, true)
end

XiGuaRankDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_11
  if frame == self._bossFrame then
    return #self._bossData
  else
    if frame == self._playerFrame then
      return #(self._totalRankData)[self._selectedBossCellIndex]
    end
  end
end

XiGuaRankDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._bossFrame then
    return "activity.swimsuit.xiguarankbosscell"
  else
    if frame == self._playerFrame then
      return "activity.swimsuit.xiguarankplayercell"
    end
  end
end

XiGuaRankDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._bossFrame then
    return {index = index, data = (self._bossData)[index]}
  else
    if frame == self._playerFrame then
      return {index = index, data = ((self._totalRankData)[self._selectedBossCellIndex])[index]}
    end
  end
end

XiGuaRankDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

XiGuaRankDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

XiGuaRankDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_16
  local width, height = (self._playerPanel):GetRectSize()
  local total = (self._playerFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return XiGuaRankDialog

