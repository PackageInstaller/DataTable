local Protocols = require("protocols.protocols")
local cSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local timeutils = require("logic.utils.timeutils")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CBossRushStageShow = BeanManager.GetTableByName("dungeonselect.cbossrushstageshow")
local CWeeklyBossRushStageShow = BeanManager.GetTableByName("dungeonselect.cweeklybossrushstageshow")
local CStarryMirrorBossRushStageShow = BeanManager.GetTableByName("dungeonselect.cstarrymirrorbossboostshow")
local CAnniversaryBossRushStageShow = BeanManager.GetTableByName("dungeonselect.canniversarybossboostshow")
local CChrisBossRushStageShow = BeanManager.GetTableByName("dungeonselect.cchrisbossrushstageshow")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local CSupportTable = BeanManager.GetTableByName("friend.csupportconfig")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CDungeonSelectWorld = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
local UnLockDungeon = CSupportTable:GetRecorder(1).dungeon
local CCommunityCfg = BeanManager.GetTableByName("setting.ccommunitycfg")
local CDungeonBuffType = BeanManager.GetTableByName("sceneinteractive.cdungeonbufftype")
local CMainTownBGM = BeanManager.GetTableByName("sound.cmaintownbgm")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CCharacterLimitConfig = BeanManager.GetTableByName("overseas.ccharacterlimitconfig")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local languageID = tonumber(CVarconfig:GetRecorder(101).Value)
local UIManager = CS.PixelNeko.UI.UIManager
local UpdateManager = CS.PixelNeko.FileSystem.Update.UpdateManager
local BM_Game = class("BM_Game")

function BM_Game:Ctor()
  self._gameData = NekoData.Data.game
  self._dm = NekoData.DataManager.DM_Game
  self:SetTheValueOfFPS(CS.UnityEngine.PlayerPrefs.GetInt("TheValueOfFPS", 30))
end

function BM_Game:GetBattleEditorMode()
  return self._gameData.battleeditormode
end

function BM_Game:GetStandAloneMode()
  return self._gameData.standalonemode
end

function BM_Game:GetClosedClient()
  return self._gameData.mainClient
end

function BM_Game:GetMyRoleInfo()
  return self._gameData.myRoleInfo
end

function BM_Game:GetUIShowMode()
  if self._gameData.myRoleInfo.sysConfig[SysConfigEnum.UIDisplay] == 0 then
    return "uiMovingHideMode"
  elseif self._gameData.myRoleInfo.sysConfig[SysConfigEnum.UIDisplay] == 1 then
    return "uiAlwaysShowMode"
  end
end

function BM_Game:GetChestOpenMode()
  if self._gameData.myRoleInfo.sysConfig[SysConfigEnum.boxOpen] == 1 then
    return "confirm"
  else
    return "direct"
  end
end

function BM_Game:GetShowChannelPop(channel)
  return false
end

function BM_Game:IsSecondGuideBattleEnd()
  local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
  return self._gameData.myRoleInfo.guides[GuidTypes.NEW_GUIDE_1] and self._gameData.myRoleInfo.guides[GuidTypes.NEW_GUIDE_1] ~= 0
end

function BM_Game:IsFirstGachaEnd()
  local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
  return self._gameData.myRoleInfo.guides[GuidTypes.TEN_DRAW] and self._gameData.myRoleInfo.guides[GuidTypes.TEN_DRAW] ~= 0
end

function BM_Game:SetGuideTag(type, tag)
  self._dm:SetGuideTag(type, tag)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, nil, {guideFlag = type})
end

function BM_Game:GetGuideTagByType(type)
  return self._gameData.myRoleInfo.guides[type]
end

function BM_Game:SetBuffGuideTag(type, tag)
  self._dm:SetBuffGuideTag(type, tag)
end

function BM_Game:GetPlayBuffGuideId()
  for k, v in pairs(self._gameData.myRoleInfo.buffGuides) do
    if v == 0 then
      return CDungeonBuffType:GetRecorder(k).guideID
    end
  end
end

function BM_Game:GetLastFloorId()
  return self._gameData.lastFloorId
end

function BM_Game:GetLastWorldId()
  local id = 0
  local record = cSceneInfoStatic:GetRecorder(self._gameData.lastFloorId)
  if record then
    id = record.worldID
  end
  return id
end

function BM_Game:GetBattleResult()
  return self._gameData.battleResult
end

function BM_Game:GetDungeonObtainMoney()
  return self._gameData.getmoney
end

function BM_Game:GetResourceObtainMoney()
  if self._gameData.resourceBattleAccount.protocol then
    return self._gameData.resourceBattleAccount.protocol.awardCurrency
  end
end

function BM_Game:GetAccountBag()
  local itemList = {}
  for _, v in ipairs(self._gameData.accountBag) do
    local item
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = Item.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        item = Equip.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        item = Skill.Create(v.id)
      end
      item:InitWithItemInfo(v)
    end
    if item then
      table.insert(itemList, {
        item = item,
        num = v.number
      })
    else
      LogErrorFormat("BM_Game", "accountBag gain %s id(or key) %s num %s not in [bagtype %s]'s bag", v.gain, v.id, v.number, v.bagtype)
    end
  end
  return itemList
end

function BM_Game:GetFirstAwardFromDungeon()
  local itemList = {}
  for _, itemInfo in ipairs(self._gameData.firstAward) do
    local item
    if itemInfo.gain == 1 then
      if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
        item = NekoData.BehaviorManager.BM_BagInfo:GetItem(itemInfo.id)
      elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
        item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(itemInfo.id)
      end
    else
      if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
        item = Item.Create(itemInfo.id)
      elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
        item = Equip.Create(itemInfo.id)
      elseif itemInfo.itemtype == ItemTypeEnum.SKILL then
        item = Skill.Create(itemInfo.id)
      end
      item:InitWithItemInfo(itemInfo)
    end
    table.insert(itemList, item)
  end
  return itemList
end

function BM_Game:GetFirstAwardFromResource()
  if self._gameData.resourceBattleAccount.protocol then
    local itemList = {}
    local awardItems = self._gameData.resourceBattleAccount.protocol.awardItems
    for _, itemInfo in ipairs(awardItems) do
      local item
      if itemInfo.gain == 1 then
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = NekoData.BehaviorManager.BM_BagInfo:GetItem(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(itemInfo.id)
        end
      else
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = Item.Create(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = Equip.Create(itemInfo.id)
        elseif itemInfo.itemtype == ItemTypeEnum.SKILL then
          item = Skill.Create(itemInfo.id)
        end
        item:InitWithItemInfo(itemInfo)
      end
      table.insert(itemList, item)
    end
    return itemList
  end
end

function BM_Game:GetResourceAccountType()
  if self._gameData.resourceBattleAccount.protocol then
    return self._gameData.resourceBattleAccount.protocol.showType
  end
end

function BM_Game:GetNextFloorId()
  return self._gameData.nextFloorId
end

function BM_Game:GetCurPassZoneId()
  return self._gameData.curPassZoneId
end

function BM_Game:GetTopMessage()
  return self._gameData.topMessage
end

function BM_Game:SetVolume()
  local configs = self._gameData.myRoleInfo.sysConfig
  for k, v in pairs(configs) do
    if k == SysConfigEnum.music then
      local record = SoundLevelTable:GetRecorder(1)
      if v == 0 then
        LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(record.soundLevel[1]))
      end
    elseif k == SysConfigEnum.musicNum then
      if configs[SysConfigEnum.music] == 1 then
        local record = SoundLevelTable:GetRecorder(1)
        local num = tonumber(record.soundLevel[v])
        if not num or num < tonumber(record.soundLevel[1]) or num > table.nums(record.soundLevel) then
          num = table.nums(record.soundLevel)
        end
        LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(num))
      end
    elseif k == SysConfigEnum.soundEffect then
      local record = SoundLevelTable:GetRecorder(2)
      if v == 0 then
        LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(record.soundLevel[1]))
      end
    elseif k == SysConfigEnum.soundEffectNum then
      if configs[SysConfigEnum.soundEffect] == 1 then
        local record = SoundLevelTable:GetRecorder(2)
        local num = tonumber(record.soundLevel[v])
        if not num or num < tonumber(record.soundLevel[1]) or num > table.nums(record.soundLevel) then
          num = table.nums(record.soundLevel)
        end
        LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(num))
      end
    elseif k == SysConfigEnum.dubbing then
      local record = SoundLevelTable:GetRecorder(3)
      if v == 0 then
        LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(record.soundLevel[1]))
      end
    elseif k == SysConfigEnum.dubbingNum and configs[SysConfigEnum.dubbing] == 1 then
      local record = SoundLevelTable:GetRecorder(3)
      local num = tonumber(record.soundLevel[v])
      if not num or num < tonumber(record.soundLevel[1]) or num > table.nums(record.soundLevel) then
        num = table.nums(record.soundLevel)
      end
      LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(num))
    end
  end
end

function BM_Game:GetResourcePanelList()
  return self._gameData.resourcePanelList
end

function BM_Game:IsResourceRedDotShow()
  if self:ShowLocalTips(DataCommon.LocalTips.Resource_1) then
    return true
  end
  if self:ShowLocalTips(DataCommon.LocalTips.Resource_2) then
    return true
  end
  if self:ShowLocalTips(DataCommon.LocalTips.Resource_3) then
    return true
  end
  if self:ShowLocalTips(DataCommon.LocalTips.Resource_4) then
    return true
  end
end

function BM_Game:GetLocalTipsState(type)
  return CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.Default)
end

function BM_Game:ShowLocalTips(type)
  local value = self:GetLocalTipsState(type)
  if value ~= type.Default and value ~= type.Checked then
    return value
  end
end

function BM_Game:SetLocalTipsNew(type)
  if self:GetLocalTipsState(type) ~= type.New then
    LogInfoFormat("BM_Game", "--SetLocalTipsNew-- Tag = %s", type.Tag)
    CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.New)
    LuaNotificationCenter.PostNotification(Common.n_LocalTipsStateChanged, self, {type = type, sign = "New"})
  end
end

function BM_Game:SetLocalTipsChecked(type)
  if self:GetLocalTipsState(type) ~= type.Checked then
    LogInfoFormat("BM_Game", "--SetLocalTipsChecked-- Tag = %s", type.Tag)
    CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.Checked)
    LuaNotificationCenter.PostNotification(Common.n_LocalTipsStateChanged, self, {type = type, sign = "Checked"})
  end
end

function BM_Game:ClearLocalTipsState(type)
  if self:GetLocalTipsState(type) ~= type.Default then
    LogInfoFormat("BM_Game", "--ClearLocalTipsState-- Tag = %s", type.Tag)
    CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.Default)
    LuaNotificationCenter.PostNotification(Common.n_LocalTipsStateChanged, self, {type = type, sign = "Default"})
  end
end

function BM_Game:GetLocalCache(type)
  return CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.Default)
end

function BM_Game:SetLocalCache(type, value)
  LogInfoFormat("BM_Game", "--SetLocalCache-- Tag = %s, value = %s", type.Tag, value)
  CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, value)
end

function BM_Game:ClearLocalCache(type)
  LogInfoFormat("BM_Game", "--ClearLocalCache-- Tag = %s", type.Tag)
  CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. type.Tag, type.Default)
end

function BM_Game:GetResourceFloorIsPassWithStageId(stageId)
  for _, t1 in ipairs(self._gameData.resourcePanelList) do
    for _, t2 in ipairs(t1.detailInfo) do
      for _, t3 in ipairs(t2.stageList) do
        if t3.id == stageId then
          return t3.firstGet
        end
      end
    end
  end
  return false
end

function BM_Game:GetBossRushInfo()
  return self._gameData.bossPanel
end

function BM_Game:GetBossRushDifficultyStr(difficultyLv, isWeekBoss)
  local tableName = CBossRushStageShow
  if isWeekBoss then
    tableName = CWeeklyBossRushStageShow
  end
  local allIds = tableName:GetAllIds()
  local length = #allIds
  local str
  if difficultyLv >= length - 1 then
    str = string.gsub(TextManager.GetText(tableName:GetRecorder(allIds[length]).textID), "%$parameter%$", difficultyLv - length + 3)
  else
    str = TextManager.GetText(tableName:GetRecorder(allIds[difficultyLv + 1]).textID)
  end
  return str
end

function BM_Game:GetBossRushDifficultyColorStr(difficultyLv, type, isWeekBoss)
  if not type then
    local tableName = CBossRushStageShow
    if isWeekBoss then
      tableName = CWeeklyBossRushStageShow
    end
    local allIds = tableName:GetAllIds()
    local length = #allIds
    local color, textStr
    if difficultyLv >= length - 1 then
      color = CWordColor:GetRecorder(tableName:GetRecorder(allIds[length]).textColor).wordcolor
      textStr = string.gsub(TextManager.GetText(tableName:GetRecorder(allIds[length]).textID), "%$parameter%$", difficultyLv - length + 3)
    else
      color = CWordColor:GetRecorder(tableName:GetRecorder(allIds[difficultyLv + 1]).textColor).wordcolor
      textStr = TextManager.GetText(tableName:GetRecorder(allIds[difficultyLv + 1]).textID)
    end
    return "<color=#" .. color .. ">" .. textStr .. "</color>"
  elseif type == "StarMirage" then
    local allIds = CStarryMirrorBossRushStageShow:GetAllIds()
    local length = #allIds
    local color, textStr
    local lv = difficultyLv + 1
    if length < lv then
      lv = length
    end
    color = CWordColor:GetRecorder(CStarryMirrorBossRushStageShow:GetRecorder(allIds[lv]).textColor).wordcolor
    textStr = TextManager.GetText(CStarryMirrorBossRushStageShow:GetRecorder(allIds[lv]).textID)
    return "<color=#" .. color .. ">" .. textStr .. "</color>"
  elseif type == "Christmas" then
    local allIds = CChrisBossRushStageShow:GetAllIds()
    local length = #allIds
    local color, textStr
    local lv = difficultyLv + 1
    if length < lv then
      lv = length
    end
    color = CWordColor:GetRecorder(CChrisBossRushStageShow:GetRecorder(allIds[lv]).textColor).wordcolor
    textStr = string.gsub(TextManager.GetText(CChrisBossRushStageShow:GetRecorder(allIds[lv]).textID), "%$parameter%$", difficultyLv - length + 3)
    return "<color=#" .. color .. ">" .. textStr .. "</color>"
  elseif type == "Anniversary" then
    local allIds = CAnniversaryBossRushStageShow:GetAllIds()
    local length = #allIds
    local color, textStr
    local lv = difficultyLv + 1
    if length < lv then
      lv = length
    end
    color = CWordColor:GetRecorder(CAnniversaryBossRushStageShow:GetRecorder(allIds[lv]).textColor).wordcolor
    textStr = TextManager.GetText(CAnniversaryBossRushStageShow:GetRecorder(allIds[lv]).textID)
    return "<color=#" .. color .. ">" .. textStr .. "</color>"
  end
end

function BM_Game:GetActivityInfo()
  return self._gameData.activityList
end

function BM_Game:IsBossRushIdUnLock(id)
  for _, info in pairs(self._gameData.bossPanel) do
    if info.id == id then
      return true
    end
  end
  return false
end

function BM_Game:GetMyBossRushRank(id)
  for _, v in pairs(self._gameData.bossPanel) do
    if v.id == id then
      return v.info.rank
    end
  end
  return 0
end

function BM_Game:IsBossPanelShowRed()
  return self._gameData.showBossPanelRed
end

function BM_Game:IsFragmentPanelShowRed()
  return self._gameData.showFragmentPanelRed
end

function BM_Game:IsUndecidedRoadShowRed()
  return self._gameData.showUndecidedRoadRed
end

function BM_Game:GetBossPanelRedInfo(...)
  return self._gameData.bossPanelRed
end

function BM_Game:GetEquipRecastTag()
  return self._gameData.equipRecastTag
end

function BM_Game:GetPhoneCodeState()
  return self._gameData.phoneCodeState
end

function BM_Game:GetMailCodeState()
  return self._gameData.mailCodeState
end

function BM_Game:GetTip()
  return self._gameData.tip
end

function BM_Game:GetMainLineProgress()
  return self._gameData._dungeonProgress
end

function BM_Game:GetSpecialShapedScreenValue()
  return self._gameData.myRoleInfo.SpecialShapedScreenConfig
end

function BM_Game:FinishDungeonReward()
  local req = LuaNetManager.CreateProtocol("protocol.battle.cdungeonclose")
  req:Send()
end

function BM_Game:GetTheValueOfFPS()
  return self._gameData.myRoleInfo.TheValueOfFPS
end

function BM_Game:SetTheValueOfFPS(fps)
  if NekoData.DataManager.DM_Game:SetTheValueOfFPS(fps) then
    LuaNotificationCenter.PostNotification(Common.n_FPSChanged, nil, {fps = fps})
  end
end

function BM_Game:GetLastDungeonType()
  return self._gameData.dungeonType
end

function BM_Game:GetLastAutoDungeonType()
  return self._gameData.autoType
end

function BM_Game:IsGM()
  return self._gameData.myRoleInfo.isGM == 1
end

function BM_Game:GetDungeonList()
  return self._gameData.dungeonList
end

function BM_Game:GetFastMenuSignFromCourtyard()
  return self._gameData.fastMenuInfo.sign
end

function BM_Game:GetFastMenuInfoFromCourtyard()
  return self._gameData.fastMenuInfo.info
end

function BM_Game:GetLastPassFloorId()
  return self._gameData._dungeonPassProgress
end

function BM_Game:GetLastNotPassFloorId()
  local lastPassFloorId = self._gameData._dungeonPassProgress
  if lastPassFloorId == nil or lastPassFloorId == -1 then
    return nil
  end
  if lastPassFloorId == 0 then
    for _, tempId in ipairs(CDungeonSelectMainLine:GetAllIds()) do
      if CDungeonSelectMainLine:GetRecorder(tempId).sort == 1 then
        return tempId
      end
    end
    return nil
  end
  local tmpSort = CDungeonSelectMainLine:GetRecorder(lastPassFloorId).sort
  if tmpSort then
    local resSort = tmpSort + 1
    for _, tempId in ipairs(CDungeonSelectMainLine:GetAllIds()) do
      if CDungeonSelectMainLine:GetRecorder(tempId).sort == resSort then
        return tempId
      end
    end
  end
  return nil
end

function BM_Game:GetFloorIsNeedToBack(floorID)
  local recorder = CDungeonSelectMainLine:GetRecorder(floorID)
  if recorder then
    return recorder.back == 1
  end
  return false
end

function BM_Game:GetFloorIDWithSceneID(sceneID)
  for _, value in pairs(CDungeonSelectMainLine:GetAllIds()) do
    local recorder = CDungeonSelectMainLine:GetRecorder(value)
    if recorder.sceneid == sceneID then
      return recorder.id
    end
    for _, value in pairs(recorder.smallnodeid) do
      if value == sceneID then
        return recorder.id
      end
    end
  end
end

function BM_Game:GetFloorAutoExploreBySceneId(sceneid)
  if sceneid == nil then
    return false
  end
  for _, worldData in ipairs(self._gameData.dungeonList) do
    for _, floorData in ipairs(worldData.floorDetail) do
      local oneline = CDungeonSelectMainLine:GetRecorder(floorData.floor)
      if oneline and oneline.sceneid == sceneid then
        return floorData.autoExplore == 1
      end
      for _, v in ipairs(floorData.smallPoint) do
        if v.sceneId == sceneid then
          return floorData.autoExplore == 1
        end
      end
    end
  end
  return false
end

function BM_Game:GetFloorIsPassWithMainLineId(id)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    for _, floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == id then
        return floorData.firstGet
      end
    end
  end
  return false
end

function BM_Game:GetFloorIsUnlockWithMainLineId(id)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    for _, floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == id then
        return true
      end
    end
  end
  return false
end

function BM_Game:GetUnlockWorldPlayerLevelWithWorldId(worldId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    if worldData.worldId == worldId and worldData.floorDetail[1] then
      local firstFloorId = worldData.floorDetail[1].floor
      local record = CDungeonSelectMainLine:GetRecorder(firstFloorId)
      if record then
        return record.unlockLv
      end
    end
  end
  return nil
end

function BM_Game:GetChapternumByFloorId(floorId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    local record = CDungeonSelectWorld:GetRecorder(worldData.worldId)
    if table.isContain(record.floorlist, floorId) then
      return record.chapternum
    end
  end
  LogErrorFormat("BM_Game", "cannot find chapternum by floorId:%d", floorId)
  return nil
end

function BM_Game:GetUnlockSceneList()
  return self._gameData.unlockSceneList
end

function BM_Game:GetMoveTypeMobileMode()
  if self._gameData.myRoleInfo.sysConfig[SysConfigEnum.moveType] == 0 then
    return "clickMobileMode"
  elseif self._gameData.myRoleInfo.sysConfig[SysConfigEnum.moveType] == 1 then
    return "rockerMobileMode"
  end
end

function BM_Game:GetBuffShowMode()
  if self._gameData.myRoleInfo.sysConfig[SysConfigEnum.showBuff] == 0 then
    return "Hide"
  elseif self._gameData.myRoleInfo.sysConfig[SysConfigEnum.showBuff] == 1 then
    return "Show"
  end
end

function BM_Game:GetAutoBattleMode()
  local AutoBattleModeType = {Optional = 1, Default = 2}
  local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
  if battleType and battleType == CBattleStartProtocol.FANTASY_CONFLICT then
    return AutoBattleModeType.Default
  end
  if self._gameData.myRoleInfo.sysConfig[SysConfigEnum.autoBattleMode] == 0 then
    return AutoBattleModeType.Optional
  elseif not self._gameData.myRoleInfo.sysConfig[SysConfigEnum.autoBattleMode] or self._gameData.myRoleInfo.sysConfig[SysConfigEnum.autoBattleMode] == 1 then
    return AutoBattleModeType.Default
  end
end

function BM_Game:GetIfNeedEveryDayLoginNotification()
  return self._gameData.myRoleInfo.localSysConfig[self._dm.LocalSystemConfigType.EveryDayLogin] == 0
end

function BM_Game:GetIfNeedSpriteFullNotification()
  return self._gameData.myRoleInfo.localSysConfig[self._dm.LocalSystemConfigType.SpriteFull] == 0
end

function BM_Game:GetIfNeedActivityExploreNotification()
  return self._gameData.myRoleInfo.localSysConfig[self._dm.LocalSystemConfigType.ActivityExplore] == 0
end

function BM_Game:GetIfNeedOfflineSweepNotification()
  return self._gameData.myRoleInfo.localSysConfig[self._dm.LocalSystemConfigType.OfflineSweep] == 0
end

function BM_Game:GetIfAllDungeonWorldAndZoneAwardReceive()
  if not self._gameData.dungeonList then
    return true
  end
  for _, worldData in ipairs(self._gameData.dungeonList) do
    if worldData.totalZones ~= 0 and worldData.clearZones == worldData.totalZones and worldData.isReceived == 0 then
      return false
    end
    for _, floorData in ipairs(worldData.floorDetail) do
      if floorData.totalBoxes ~= 0 and floorData.openedBoxes == floorData.totalBoxes and floorData.isReceived == 0 then
        return false
      end
    end
  end
  return true
end

function BM_Game:GetIfDungeonWorldAwardReceiveByWorldId(worldId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    if worldData.worldId == worldId then
      if worldData.totalZones ~= 0 and worldData.clearZones == worldData.totalZones and worldData.isReceived == 0 then
        return false
      else
        return true
      end
    end
  end
  return false
end

function BM_Game:GetIfDungeonWorldAllZoneAwardReceive(worldId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    if worldData.worldId == worldId then
      for _, floorData in ipairs(worldData.floorDetail) do
        if floorData.totalBoxes ~= 0 and floorData.openedBoxes == floorData.totalBoxes and floorData.isReceived == 0 then
          return false
        end
      end
      break
    end
  end
  return true
end

function BM_Game:GetIfDungeonWorldZoneAwardReceiveByFloorId(floorId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    for _, floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == floorId then
        if floorData.totalBoxes ~= 0 and floorData.openedBoxes == floorData.totalBoxes and floorData.isReceived == 0 then
          return false
        else
          return true
        end
      end
    end
  end
  return false
end

function BM_Game:GetIfFirstWitchSkillGuide()
  return self._gameData.myRoleInfo.witchSkillGuide.guide == 0
end

function BM_Game:GetWitchSkillIdList()
  return self._gameData.myRoleInfo.witchSkillGuide.skillIdList
end

function BM_Game:GetUserId()
  return self._gameData.myRoleInfo.userid
end

function BM_Game:GetServerId()
  return self._gameData.myRoleInfo.zoneid
end

function BM_Game:GetPreciseDecimal(nNum, n)
  if type(nNum) ~= "number" then
    return nNum
  end
  n = n or 0
  n = math.floor(n)
  if n < 0 then
    n = 0
  end
  local nDecimal = 10 ^ n
  local nTemp = math.floor(nNum * nDecimal)
  local nRet = nTemp / nDecimal
  return nRet
end

function BM_Game:GetRuneInfo()
  return self._gameData.myRoleInfo.runeInfo
end

local function GetFloorSort(floor)
  local record = CDungeonSelectMainLine:GetRecorder(floor)
  if record then
    return record.sort
  else
    LogError("bm_game", "GetRecorder in CDungeonSelectMainLine failed")
    return -1
  end
end

function BM_Game:IsUnlockAssistBattle()
  local progress = self:GetMainLineProgress()
  local FloorSort = GetFloorSort(progress.floor)
  local UnLockDungeonSort = GetFloorSort(UnLockDungeon + 1)
  return FloorSort >= UnLockDungeonSort
end

function BM_Game:GetLeiTingDataTotalTime()
  return self._gameData.LeiTingDataTotalTime
end

function BM_Game:SetSystemConfig(map)
  NekoData.DataManager.DM_Game:SetSystemConfig(map)
  for k, v in pairs(map) do
    if k == SysConfigEnum.moveType then
      LuaNotificationCenter.PostNotification(Common.n_MoveTypeChange, self, v)
    elseif k == SysConfigEnum.rockerType then
      LuaNotificationCenter.PostNotification(Common.n_RockerTypeChange, self, v)
    end
  end
end

function BM_Game:IsUnlockFunction(functionId)
  return self._gameData.unlockFunctions[functionId]
end

function BM_Game:IsShieldFunction(functionId)
  return self._gameData.shieldFunctions[functionId]
end

function BM_Game:GetPromptLongPressLevelUp()
  return self._gameData.promptLongPressLevelUp
end

function BM_Game:GetResonanceTag()
  return self._gameData.resonanceTag
end

function BM_Game:GetUserLevel()
  return self._gameData.myRoleInfo.userlevel
end

function BM_Game:CanSendResponseWaitProtocol(protocolType, waitProtocol)
  local map = self._gameData.waitResponse.protocols[protocolType]
  if not map or map[waitProtocol] <= 0 then
    return true
  else
    LogInfoFormat("BM_Game", "Cannot send the same protocol(:%s) continuously.", Protocols[protocolType])
    return false
  end
end

function BM_Game:OpenResponseWaitDialog(protocolType, waitProtocol)
  if not self._gameData.waitResponse.protocols[protocolType] then
    self._gameData.waitResponse.protocols[protocolType] = {}
  end
  local map = self._gameData.waitResponse.protocols[protocolType]
  if not map[waitProtocol] then
    map[waitProtocol] = 0
  end
  map[waitProtocol] = map[waitProtocol] + 1
  self._gameData.waitResponse.num = self._gameData.waitResponse.num + 1
  LogInfoFormat("OpenResponseWaitDialog", "waitResponseNum = %s", self._gameData.waitResponse.num)
  if self._gameData.waitResponse.num == 1 then
    DialogManager.CreateSingletonDialog("login.responsewaitdialog")
    LogInfo("CreateResponseWaitDialog")
  end
end

function BM_Game:CloseResponseWaitDialog(sProtocol)
  local waitProtocol = Protocols[sProtocol.ProtocolType]
  local protocolType = sProtocol.protocolType
  local map = self._gameData.waitResponse.protocols[protocolType]
  if map and map[waitProtocol] then
    map[waitProtocol] = map[waitProtocol] - 1
    self._gameData.waitResponse.num = self._gameData.waitResponse.num - 1
  else
    return
  end
  LogInfoFormat("CloseResponseWaitDialog", "waitResponseNum = %s", self._gameData.waitResponse.num)
  if self._gameData.waitResponse.num <= 0 then
    DialogManager.DestroySingletonDialog("login.responsewaitdialog")
    LogInfo("DestroyResponseWaitDialog")
  end
end

function BM_Game:GetGMHideUIInfo()
  return self._gameData._gmHideUIInfo
end

local function ShowUI(child, display)
  if child then
    if display then
      CS.PixelNeko.P1.UI.GMUIControl.ShowUI(child._uiObject)
      if child._uiObject.name == "BattleProgressBack" then
        UIManager.SetLayer(child._uiObject.transform, child._uiObject.transform.parent.gameObject.layer)
      end
    else
      CS.PixelNeko.P1.UI.GMUIControl.HideUI(child._uiObject)
      if child._uiObject.name == "BattleProgressBack" then
        UIManager.SetLayer(child._uiObject.transform, Layers.InvisibleLayerID)
      end
    end
  end
end

function BM_Game:SetGMHideUIInfo(scene, id, display)
  if self:IsGM() then
    self._gameData._gmHideUIInfo[scene][id].display = display
    local record = self._gameData._gmHideUIInfo[scene][id].record
    local dialog = DialogManager.GetDialog(record.fileName)
    if dialog then
      local child
      if record.nodePath ~= "" then
        local childList = string.split(record.nodePath, ",")
        for i, chidNodePath in ipairs(childList) do
          child = dialog:GetChild(chidNodePath)
          ShowUI(child, display)
        end
      else
        child = dialog._rootWindow
        ShowUI(child, display)
      end
    end
  end
end

local function HideUI(child, display)
  if child and not display then
    CS.PixelNeko.P1.UI.GMUIControl.HideUI(child._uiObject)
    if child._uiObject.name == "BattleProgressBack" then
      UIManager.SetLayer(child._uiObject.transform, Layers.InvisibleLayerID)
    end
  end
end

function BM_Game:SetGMHideUIByDialog(scene, dialog)
  if self:IsGM() then
    local map = self._gameData._gmHideUIInfo[scene]
    for k, v in pairs(map) do
      if dialog._dialogName == v.record.fileName then
        local child
        if v.record.nodePath ~= "" then
          local childList = string.split(v.record.nodePath, ",")
          for i, chidNodePath in ipairs(childList) do
            child = dialog:GetChild(chidNodePath)
            HideUI(child, v.display)
          end
        else
          child = dialog._rootWindow
          HideUI(child, v.display)
        end
      end
    end
  end
end

function BM_Game:CreateGuideClickEffectDialog(parentNode, effectId)
  self._gameData.guideClickEffect.count = self._gameData.guideClickEffect.count + 1
  local dialog = DialogManager.CreateDialog("guide.guideclickeffectdialog", parentNode._uiObject)
  if not effectId then
    dialog:SetEffectId(1058)
  else
    dialog:SetEffectId(effectId)
  end
  self._gameData.guideClickEffect.dialogs[self._gameData.guideClickEffect.count] = dialog
  return self._gameData.guideClickEffect.count
end

function BM_Game:DestroyGuideClickEffectDialog(guideClickEffectCount)
  if guideClickEffectCount then
    local dialog = self._gameData.guideClickEffect.dialogs[guideClickEffectCount]
    if dialog then
      dialog:Destroy()
      dialog:RootWindowDestroy()
      self._gameData.guideClickEffect.dialogs[guideClickEffectCount] = nil
    end
  end
end

function BM_Game:GetReadTips()
  return self._gameData.myRoleInfo.tips
end

function BM_Game:GetReadNpcTips()
  return self._gameData.myRoleInfo.npcTips
end

function BM_Game:GetTipsCanUse(tipTable, tipId, curSceneLoadingId)
  local tmpRes = tipTable:GetRecorder(tipId)
  local effect = true
  local defect = false
  if tmpRes.effectCondition ~= 0 then
    effect = NekoData.BehaviorManager.BM_TipsCondition:ConditionSatisfacted(tmpRes.effectCondition, curSceneLoadingId)
  end
  if tmpRes.defectCondition ~= 0 then
    defect = NekoData.BehaviorManager.BM_TipsCondition:ConditionSatisfacted(tmpRes.defectCondition, curSceneLoadingId)
  end
  if effect and not defect then
    return true
  end
  return false
end

function BM_Game:GetBookActivity()
  return self._gameData.bookActivity
end

function BM_Game:GetBranchLineList()
  return self._gameData.branchLineList
end

function BM_Game:GetBranchLineCurrentZoneByWordId(wordId)
  local zones = self._gameData.branchLineList[wordId].questInfo
  for k, v in pairs(zones) do
    if v == 1 or v == 2 then
      return k
    end
  end
end

function BM_Game:GetBranchLineIsFinishiByWordId(wordId)
  local zones = self._gameData.branchLineList[wordId].questInfo
  for k, v in pairs(zones) do
    if v ~= 3 then
      return false
    end
  end
  return true
end

function BM_Game:GetBranchHasPassedByWordId(wordId)
  return self._gameData.branchLineList[wordId].hasPassed == 1
end

function BM_Game:GetBranchLineLastZoneByWordId(wordId)
  local recorder = CSideStoryChapter:GetRecorder(wordId)
  if recorder then
    return recorder.floorlist[#recorder.floorlist]
  end
end

function BM_Game:GetSupportCommunityCfg()
  if self._gameData.communitycfg == nil then
    self._gameData.communitycfg = {}
    for _, cId in ipairs(CCommunityCfg:GetAllIds()) do
      local channelId = CCommunityCfg:GetRecorder(cId).ChannelID
      if channelId ~= "" then
        local channelIds = string.split(channelId, ";")
        if table.keyof(channelIds, SdkManager.GetChannelID()) ~= nil then
          table.insert(self._gameData.communitycfg, cId)
        end
      else
        table.insert(self._gameData.communitycfg, cId)
      end
    end
  end
  return self._gameData.communitycfg
end

function BM_Game:GetUISortType(sortedType)
  return self._gameData.uiSortType[sortedType]
end

function BM_Game:GetAutoExploreTimes()
  return self._gameData._autoExploreTimes
end

function BM_Game:IsFinishiAllExplore()
  if self._gameData._autoExploreTimes then
    return self._gameData._autoExploreTimes.current == self._gameData._autoExploreTimes.totle
  else
    return true
  end
end

function BM_Game:GetAutoExploreProtocol()
  return self._gameData._autoExploreProtocol
end

function BM_Game:IsAutoFinishing()
  return self._gameData.isAutoFinishing
end

function BM_Game:GetCurrentCardPoolID(id)
  return self._gameData._currentCardPoolID
end

function BM_Game:GetCanPreEnchantEquip()
  return self._gameData.canPreEnchantEquip
end

function BM_Game:GetTodayLoginTag()
  return self._gameData.todayLoginTag
end

function BM_Game:GetIfHaveAskForNotificationPermission()
  return CS.UnityEngine.PlayerPrefs.GetInt("IfHaveAskForNotificationPermission", 0) == 1
end

function BM_Game:IsGuest()
  return self._gameData.myRoleInfo.isGuest == 0
end

function BM_Game:GetUpAndDownLimitsByFuncId(funcId)
  local record = CCharacterLimitConfig:GetRecorder(funcId)
  if record then
    if languageID == 1 then
      return tonumber(record.cn_top), tonumber(record.cn_floor)
    elseif languageID == 2 then
      return tonumber(record.en_top), tonumber(record.en_floor)
    elseif languageID == 3 then
      return tonumber(record.kr_top), tonumber(record.kr_floor)
    elseif languageID == 4 then
      return tonumber(record.jp_top), tonumber(record.jp_floor)
    end
  else
    LogErrorFormat("BM_Game", "characterLimit with id %s is not exist in ccharacterlimitconfig", funcId)
  end
end

function BM_Game:GetAutoExploreWithoutBackAwards()
  if #self._gameData.autoExploreWithoutBackAwards > 0 or 0 < table.nums(self._gameData.autoExploreWithoutBackMoney) then
    return {
      money = self._gameData.autoExploreWithoutBackMoney,
      item = self._gameData.autoExploreWithoutBackAwards
    }
  end
end

function BM_Game:JumpToTheStore(type)
  local platform = SdkManager.GetPlatform()
  if SdkManager.IsOverseas then
  else
    if SdkManager.GetChannel() == "none" then
      return
    end
    if type == 1 then
      local url = ""
      if platform == "iOS" then
        url = "https://apps.apple.com/us/app/%E5%A4%8D%E8%8B%8F%E7%9A%84%E9%AD%94%E5%A5%B3-%E5%8D%83%E6%8A%BD%E5%8D%81%E8%BF%9E%E4%BB%BB%E9%80%89ur/id6744319779"
      elseif platform == "Android" then
        url = "https://l.taptap.cn/JIsEuJsA?channel=rep-rep_gjtsnwsgjja"
      end
      CS.PixelNeko.Tools.ShareHelper.OpenURL(url)
      return
    end
    if type == 2 and UpdateManager.HasLatestAppVersion and UpdateManager.ExecuteAppUpdate then
      UpdateManager.ExecuteAppUpdate()
    elseif platform == "iOS" or not SdkManager.GetAgent():IsChannelPackage() then
      if platform ~= "iOS" then
        local media = CS.PixelNeko.P1.PlatformManager.GetData("GetProperty", "media")
        local url = DataCommon.Media_URL[media] or DataCommon.Media_URL[""]
        if url then
          CS.PixelNeko.Tools.ShareHelper.OpenURL(url)
        else
          LogErrorFormat("BM_Game", "URL Can't find, media = %s", media)
        end
      else
        CS.PixelNeko.Tools.ShareHelper.OpenURL(DataCommon.apple_URL)
      end
    else
      local channelID = tonumber(SdkManager.GetChannelID())
      local marketPkg = DataCommon.ChannelID_MarketPkg[channelID]
      if marketPkg then
        if type ~= 2 and UpdateManager.HasLatestAppVersion and UpdateManager.ExecuteAppUpdate then
          local jsonStr = JSON.encode(marketPkg)
          CS.PixelNeko.P1.PlatformManager.Invoke("rateToShop", jsonStr)
        else
          CS.PixelNeko.Tools.ShareHelper.OpenURL(marketPkg.appurl)
        end
      else
        LogErrorFormat("BM_Game", "MarketPkg Can't find, channelID = %s", tostring(channelID))
      end
    end
  end
end

function BM_Game:StartSpeedTask()
  self._gameData.speedTask = GameTimer.AddTask(15, 20, function()
    local req = LuaNetManager.CreateProtocol("protocol.timer.timespeedcheck")
    req.clientTime = math.ceil(CS.UnityEngine.Time.time * 1000)
    req.serverTime = ServerGameTimer.GetServerTimeForecast()
    req:Send()
  end)
end

function BM_Game:StopSpeedTask()
  if self._gameData.speedTask then
    GameTimer.RemoveTask(self._gameData.speedTask)
    self._gameData.speedTask = nil
  end
end

function BM_Game:GetMainCityBgmID()
  local allIDs = CMainTownBGM:GetAllIds()
  local currentTime = ServerGameTimer.GetServerTime()
  local startTime, endTime, recorder, defaultBgmId, bgmID
  for i, v in ipairs(allIDs) do
    recorder = CMainTownBGM:GetRecorder(v)
    if recorder.startTime == "" and recorder.endTime == "" then
      defaultBgmId = recorder.soundid
    else
      startTime = timeutils.GetConfigFormatTimeStamp(recorder.startTime)
      endTime = timeutils.GetConfigFormatTimeStamp(recorder.endTime)
      if currentTime > startTime and currentTime < endTime then
        local mainLineProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
        if mainLineProgress and mainLineProgress.floor and mainLineProgress.floor > tonumber(recorder.chapterLimit) then
          bgmID = recorder.soundid
          return bgmID
        end
      end
    end
  end
  if NekoData.BehaviorManager.BM_YardMusic:GetSyncMainCity() then
    return NekoData.BehaviorManager.BM_YardMusic:GetPlayingAudioId()
  else
    return defaultBgmId
  end
end

function BM_Game:IsSkillItemId(id)
  return CSkillItemTable:GetRecorder(id)
end

return BM_Game
