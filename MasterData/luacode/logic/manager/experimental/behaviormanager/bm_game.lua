-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_game.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Protocols = require("protocols.protocols")
local cSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local ChannelType = require("protocols.bean.protocol.chat.channeltype")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local timeutils = require("logic.utils.timeutils")
local CBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.cbossrushstageshow")
local CWeeklyBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.cweeklybossrushstageshow")
local CStarryMirrorBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorbossboostshow")
local CAnniversaryBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.canniversarybossboostshow")
local CChrisBossRushStageShow = (BeanManager.GetTableByName)("dungeonselect.cchrisbossrushstageshow")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local CSupportTable = (BeanManager.GetTableByName)("friend.csupportconfig")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CDungeonSelectWorld = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local UnLockDungeon = (CSupportTable:GetRecorder(1)).dungeon
local CCommunityCfg = (BeanManager.GetTableByName)("setting.ccommunitycfg")
local CDungeonBuffType = (BeanManager.GetTableByName)("sceneinteractive.cdungeonbufftype")
local CMainTownBGM = (BeanManager.GetTableByName)("sound.cmaintownbgm")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CCharacterLimitConfig = (BeanManager.GetTableByName)("overseas.ccharacterlimitconfig")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local languageID = tonumber((CVarconfig:GetRecorder(101)).Value)
local UIManager = ((CS.PixelNeko).UI).UIManager
local UpdateManager = (((CS.PixelNeko).FileSystem).Update).UpdateManager
local BM_Game = class("BM_Game")
BM_Game.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._gameData = (NekoData.Data).game
  self._dm = (NekoData.DataManager).DM_Game
  self:SetTheValueOfFPS((((CS.UnityEngine).PlayerPrefs).GetInt)("TheValueOfFPS", 30))
end

BM_Game.GetBattleEditorMode = function(self)
  -- function num : 0_1
  return (self._gameData).battleeditormode
end

BM_Game.GetStandAloneMode = function(self)
  -- function num : 0_2
  return (self._gameData).standalonemode
end

BM_Game.GetClosedClient = function(self)
  -- function num : 0_3
  return (self._gameData).mainClient
end

BM_Game.GetMyRoleInfo = function(self)
  -- function num : 0_4
  return (self._gameData).myRoleInfo
end

BM_Game.GetUIShowMode = function(self)
  -- function num : 0_5 , upvalues : SysConfigEnum
  if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.UIDisplay] == 0 then
    return "uiMovingHideMode"
  else
    if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.UIDisplay] == 1 then
      return "uiAlwaysShowMode"
    end
  end
end

BM_Game.GetChestOpenMode = function(self)
  -- function num : 0_6 , upvalues : SysConfigEnum
  if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.boxOpen] == 1 then
    return "confirm"
  else
    return "direct"
  end
end

BM_Game.GetShowChannelPop = function(self, channel)
  -- function num : 0_7
  return false
end

BM_Game.IsSecondGuideBattleEnd = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
  do return not (((self._gameData).myRoleInfo).guides)[GuidTypes.NEW_GUIDE_1] or (((self._gameData).myRoleInfo).guides)[GuidTypes.NEW_GUIDE_1] ~= 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Game.IsFirstGachaEnd = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
  do return not (((self._gameData).myRoleInfo).guides)[GuidTypes.TEN_DRAW] or (((self._gameData).myRoleInfo).guides)[GuidTypes.TEN_DRAW] ~= 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_Game.SetGuideTag = function(self, type, tag)
  -- function num : 0_10 , upvalues : _ENV
  (self._dm):SetGuideTag(type, tag)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, nil, {guideFlag = type})
end

BM_Game.GetGuideTagByType = function(self, type)
  -- function num : 0_11
  return (((self._gameData).myRoleInfo).guides)[type]
end

BM_Game.SetBuffGuideTag = function(self, type, tag)
  -- function num : 0_12
  (self._dm):SetBuffGuideTag(type, tag)
end

BM_Game.GetPlayBuffGuideId = function(self)
  -- function num : 0_13 , upvalues : _ENV, CDungeonBuffType
  for k,v in pairs(((self._gameData).myRoleInfo).buffGuides) do
    if v == 0 then
      return (CDungeonBuffType:GetRecorder(k)).guideID
    end
  end
end

BM_Game.GetLastFloorId = function(self)
  -- function num : 0_14
  return (self._gameData).lastFloorId
end

BM_Game.GetLastWorldId = function(self)
  -- function num : 0_15 , upvalues : cSceneInfoStatic
  local id = 0
  local record = cSceneInfoStatic:GetRecorder((self._gameData).lastFloorId)
  if record then
    id = record.worldID
  end
  return id
end

BM_Game.GetBattleResult = function(self)
  -- function num : 0_16
  return (self._gameData).battleResult
end

BM_Game.GetDungeonObtainMoney = function(self)
  -- function num : 0_17
  return (self._gameData).getmoney
end

BM_Game.GetResourceObtainMoney = function(self)
  -- function num : 0_18
  if ((self._gameData).resourceBattleAccount).protocol then
    return (((self._gameData).resourceBattleAccount).protocol).awardCurrency
  end
end

BM_Game.GetAccountBag = function(self)
  -- function num : 0_19 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  local itemList = {}
  for _,v in ipairs((self._gameData).accountBag) do
    local item = nil
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
        end
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = (Item.Create)(v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = (Equip.Create)(v.id)
        else
          if v.itemtype == ItemTypeEnum.SKILL then
            item = (Skill.Create)(v.id)
          end
        end
      end
      item:InitWithItemInfo(v)
    end
    if item then
      (table.insert)(itemList, {item = item, num = v.number})
    else
      LogErrorFormat("BM_Game", "accountBag gain %s id(or key) %s num %s not in [bagtype %s]\'s bag", v.gain, v.id, v.number, v.bagtype)
    end
  end
  return itemList
end

BM_Game.GetFirstAwardFromDungeon = function(self)
  -- function num : 0_20 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  local itemList = {}
  for _,itemInfo in ipairs((self._gameData).firstAward) do
    local item = nil
    if itemInfo.gain == 1 then
      if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(itemInfo.id)
      else
        if itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(itemInfo.id)
        end
      end
    else
      if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
        item = (Item.Create)(itemInfo.id)
      else
        if itemInfo.itemtype == ItemTypeEnum.EQUIP then
          item = (Equip.Create)(itemInfo.id)
        else
          if itemInfo.itemtype == ItemTypeEnum.SKILL then
            item = (Skill.Create)(itemInfo.id)
          end
        end
      end
      item:InitWithItemInfo(itemInfo)
    end
    ;
    (table.insert)(itemList, item)
  end
  return itemList
end

BM_Game.GetFirstAwardFromResource = function(self)
  -- function num : 0_21 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  if ((self._gameData).resourceBattleAccount).protocol then
    local itemList = {}
    local awardItems = (((self._gameData).resourceBattleAccount).protocol).awardItems
    for _,itemInfo in ipairs(awardItems) do
      local item = nil
      if itemInfo.gain == 1 then
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(itemInfo.id)
        else
          if itemInfo.itemtype == ItemTypeEnum.EQUIP then
            item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(itemInfo.id)
          end
        end
      else
        if itemInfo.itemtype == ItemTypeEnum.BASEITEM then
          item = (Item.Create)(itemInfo.id)
        else
          if itemInfo.itemtype == ItemTypeEnum.EQUIP then
            item = (Equip.Create)(itemInfo.id)
          else
            if itemInfo.itemtype == ItemTypeEnum.SKILL then
              item = (Skill.Create)(itemInfo.id)
            end
          end
        end
        item:InitWithItemInfo(itemInfo)
      end
      ;
      (table.insert)(itemList, item)
    end
    return itemList
  end
end

BM_Game.GetResourceAccountType = function(self)
  -- function num : 0_22
  if ((self._gameData).resourceBattleAccount).protocol then
    return (((self._gameData).resourceBattleAccount).protocol).showType
  end
end

BM_Game.GetNextFloorId = function(self)
  -- function num : 0_23
  return (self._gameData).nextFloorId
end

BM_Game.GetCurPassZoneId = function(self)
  -- function num : 0_24
  return (self._gameData).curPassZoneId
end

BM_Game.GetTopMessage = function(self)
  -- function num : 0_25
  return (self._gameData).topMessage
end

BM_Game.SetVolume = function(self)
  -- function num : 0_26 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  local configs = ((self._gameData).myRoleInfo).sysConfig
  for k,v in pairs(configs) do
    if k == SysConfigEnum.music then
      local record = SoundLevelTable:GetRecorder(1)
      if v == 0 then
        (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber((record.soundLevel)[1]))
      end
    else
      do
        -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

        if k == SysConfigEnum.musicNum and configs[SysConfigEnum.music] == 1 then
          local record = SoundLevelTable:GetRecorder(1)
          local num = tonumber((record.soundLevel)[v])
          if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
            num = (table.nums)(record.soundLevel)
          end
          ;
          (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
        end
        do
          if k == SysConfigEnum.soundEffect then
            local record = SoundLevelTable:GetRecorder(2)
            if v == 0 then
              (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber((record.soundLevel)[1]))
            end
          else
            do
              -- DECOMPILER ERROR at PC102: Unhandled construct in 'MakeBoolean' P1

              if k == SysConfigEnum.soundEffectNum and configs[SysConfigEnum.soundEffect] == 1 then
                local record = SoundLevelTable:GetRecorder(2)
                local num = tonumber((record.soundLevel)[v])
                if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
                  num = (table.nums)(record.soundLevel)
                end
                ;
                (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
              end
              do
                if k == SysConfigEnum.dubbing then
                  local record = SoundLevelTable:GetRecorder(3)
                  if v == 0 then
                    (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber((record.soundLevel)[1]))
                  end
                else
                  do
                    if k == SysConfigEnum.dubbingNum and configs[SysConfigEnum.dubbing] == 1 then
                      local record = SoundLevelTable:GetRecorder(3)
                      local num = tonumber((record.soundLevel)[v])
                      if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
                        num = (table.nums)(record.soundLevel)
                      end
                      ;
                      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
                    end
                    do
                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC198: LeaveBlock: unexpected jumping out IF_STMT

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

BM_Game.GetResourcePanelList = function(self)
  -- function num : 0_27
  return (self._gameData).resourcePanelList
end

BM_Game.IsResourceRedDotShow = function(self)
  -- function num : 0_28 , upvalues : _ENV
  if self:ShowLocalTips((DataCommon.LocalTips).Resource_1) then
    return true
  end
  if self:ShowLocalTips((DataCommon.LocalTips).Resource_2) then
    return true
  end
  if self:ShowLocalTips((DataCommon.LocalTips).Resource_3) then
    return true
  end
  if self:ShowLocalTips((DataCommon.LocalTips).Resource_4) then
    return true
  end
end

BM_Game.GetLocalTipsState = function(self, type)
  -- function num : 0_29 , upvalues : _ENV
  return (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.Default)
end

BM_Game.ShowLocalTips = function(self, type)
  -- function num : 0_30
  local value = self:GetLocalTipsState(type)
  if value ~= type.Default and value ~= type.Checked then
    return value
  end
end

BM_Game.SetLocalTipsNew = function(self, type)
  -- function num : 0_31 , upvalues : _ENV
  if self:GetLocalTipsState(type) ~= type.New then
    LogInfoFormat("BM_Game", "--SetLocalTipsNew-- Tag = %s", type.Tag)
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.New)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LocalTipsStateChanged, self, {type = type, sign = "New"})
  end
end

BM_Game.SetLocalTipsChecked = function(self, type)
  -- function num : 0_32 , upvalues : _ENV
  if self:GetLocalTipsState(type) ~= type.Checked then
    LogInfoFormat("BM_Game", "--SetLocalTipsChecked-- Tag = %s", type.Tag)
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.Checked)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LocalTipsStateChanged, self, {type = type, sign = "Checked"})
  end
end

BM_Game.ClearLocalTipsState = function(self, type)
  -- function num : 0_33 , upvalues : _ENV
  if self:GetLocalTipsState(type) ~= type.Default then
    LogInfoFormat("BM_Game", "--ClearLocalTipsState-- Tag = %s", type.Tag)
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.Default)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LocalTipsStateChanged, self, {type = type, sign = "Default"})
  end
end

BM_Game.GetLocalCache = function(self, type)
  -- function num : 0_34 , upvalues : _ENV
  return (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.Default)
end

BM_Game.SetLocalCache = function(self, type, value)
  -- function num : 0_35 , upvalues : _ENV
  LogInfoFormat("BM_Game", "--SetLocalCache-- Tag = %s, value = %s", type.Tag, value)
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, value)
end

BM_Game.ClearLocalCache = function(self, type)
  -- function num : 0_36 , upvalues : _ENV
  LogInfoFormat("BM_Game", "--ClearLocalCache-- Tag = %s", type.Tag)
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. type.Tag, type.Default)
end

BM_Game.GetResourceFloorIsPassWithStageId = function(self, stageId)
  -- function num : 0_37 , upvalues : _ENV
  for _,t1 in ipairs((self._gameData).resourcePanelList) do
    for _,t2 in ipairs(t1.detailInfo) do
      for _,t3 in ipairs(t2.stageList) do
        if t3.id == stageId then
          return t3.firstGet
        end
      end
    end
  end
  return false
end

BM_Game.GetBossRushInfo = function(self)
  -- function num : 0_38
  return (self._gameData).bossPanel
end

BM_Game.GetBossRushDifficultyStr = function(self, difficultyLv, isWeekBoss)
  -- function num : 0_39 , upvalues : CBossRushStageShow, CWeeklyBossRushStageShow, _ENV
  local tableName = CBossRushStageShow
  if isWeekBoss then
    tableName = CWeeklyBossRushStageShow
  end
  local allIds = tableName:GetAllIds()
  local length = #allIds
  local str = nil
  if length - 1 <= difficultyLv then
    str = (string.gsub)((TextManager.GetText)((tableName:GetRecorder(allIds[length])).textID), "%$parameter%$", difficultyLv - length + 3)
  else
    str = (TextManager.GetText)((tableName:GetRecorder(allIds[difficultyLv + 1])).textID)
  end
  return str
end

BM_Game.GetBossRushDifficultyColorStr = function(self, difficultyLv, type, isWeekBoss)
  -- function num : 0_40 , upvalues : CBossRushStageShow, CWeeklyBossRushStageShow, CWordColor, _ENV, CStarryMirrorBossRushStageShow, CChrisBossRushStageShow, CAnniversaryBossRushStageShow
  if not type then
    local tableName = CBossRushStageShow
    if isWeekBoss then
      tableName = CWeeklyBossRushStageShow
    end
    local allIds = tableName:GetAllIds()
    local length = #allIds
    local color, textStr = nil, nil
    if length - 1 <= difficultyLv then
      color = (CWordColor:GetRecorder((tableName:GetRecorder(allIds[length])).textColor)).wordcolor
      textStr = (string.gsub)((TextManager.GetText)((tableName:GetRecorder(allIds[length])).textID), "%$parameter%$", difficultyLv - length + 3)
    else
      color = (CWordColor:GetRecorder((tableName:GetRecorder(allIds[difficultyLv + 1])).textColor)).wordcolor
      textStr = (TextManager.GetText)((tableName:GetRecorder(allIds[difficultyLv + 1])).textID)
    end
    return "<color=#" .. color .. ">" .. textStr .. "</color>"
  else
    do
      if type == "StarMirage" then
        local allIds = CStarryMirrorBossRushStageShow:GetAllIds()
        local length = #allIds
        local color, textStr = nil, nil
        local lv = difficultyLv + 1
        if length < lv then
          lv = length
        end
        color = (CWordColor:GetRecorder((CStarryMirrorBossRushStageShow:GetRecorder(allIds[lv])).textColor)).wordcolor
        textStr = (TextManager.GetText)((CStarryMirrorBossRushStageShow:GetRecorder(allIds[lv])).textID)
        return "<color=#" .. color .. ">" .. textStr .. "</color>"
      else
        do
          if type == "Christmas" then
            local allIds = CChrisBossRushStageShow:GetAllIds()
            local length = #allIds
            local color, textStr = nil, nil
            local lv = difficultyLv + 1
            if length < lv then
              lv = length
            end
            color = (CWordColor:GetRecorder((CChrisBossRushStageShow:GetRecorder(allIds[lv])).textColor)).wordcolor
            textStr = (string.gsub)((TextManager.GetText)((CChrisBossRushStageShow:GetRecorder(allIds[lv])).textID), "%$parameter%$", difficultyLv - length + 3)
            return "<color=#" .. color .. ">" .. textStr .. "</color>"
          else
            do
              if type == "Anniversary" then
                local allIds = CAnniversaryBossRushStageShow:GetAllIds()
                local length = #allIds
                local color, textStr = nil, nil
                local lv = difficultyLv + 1
                if length < lv then
                  lv = length
                end
                color = (CWordColor:GetRecorder((CAnniversaryBossRushStageShow:GetRecorder(allIds[lv])).textColor)).wordcolor
                textStr = (TextManager.GetText)((CAnniversaryBossRushStageShow:GetRecorder(allIds[lv])).textID)
                return "<color=#" .. color .. ">" .. textStr .. "</color>"
              end
            end
          end
        end
      end
    end
  end
end

BM_Game.GetActivityInfo = function(self)
  -- function num : 0_41
  return (self._gameData).activityList
end

BM_Game.IsBossRushIdUnLock = function(self, id)
  -- function num : 0_42 , upvalues : _ENV
  for _,info in pairs((self._gameData).bossPanel) do
    if info.id == id then
      return true
    end
  end
  return false
end

BM_Game.GetMyBossRushRank = function(self, id)
  -- function num : 0_43 , upvalues : _ENV
  for _,v in pairs((self._gameData).bossPanel) do
    if v.id == id then
      return (v.info).rank
    end
  end
  return 0
end

BM_Game.IsBossPanelShowRed = function(self)
  -- function num : 0_44
  return (self._gameData).showBossPanelRed
end

BM_Game.IsFragmentPanelShowRed = function(self)
  -- function num : 0_45
  return (self._gameData).showFragmentPanelRed
end

BM_Game.IsUndecidedRoadShowRed = function(self)
  -- function num : 0_46
  return (self._gameData).showUndecidedRoadRed
end

BM_Game.GetBossPanelRedInfo = function(self, ...)
  -- function num : 0_47
  return (self._gameData).bossPanelRed
end

BM_Game.GetEquipRecastTag = function(self)
  -- function num : 0_48
  return (self._gameData).equipRecastTag
end

BM_Game.GetPhoneCodeState = function(self)
  -- function num : 0_49
  return (self._gameData).phoneCodeState
end

BM_Game.GetMailCodeState = function(self)
  -- function num : 0_50
  return (self._gameData).mailCodeState
end

BM_Game.GetTip = function(self)
  -- function num : 0_51
  return (self._gameData).tip
end

BM_Game.GetMainLineProgress = function(self)
  -- function num : 0_52
  return (self._gameData)._dungeonProgress
end

BM_Game.GetSpecialShapedScreenValue = function(self)
  -- function num : 0_53
  return ((self._gameData).myRoleInfo).SpecialShapedScreenConfig
end

BM_Game.FinishDungeonReward = function(self)
  -- function num : 0_54 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.cdungeonclose")
  req:Send()
end

BM_Game.GetTheValueOfFPS = function(self)
  -- function num : 0_55
  return ((self._gameData).myRoleInfo).TheValueOfFPS
end

BM_Game.SetTheValueOfFPS = function(self, fps)
  -- function num : 0_56 , upvalues : _ENV
  if ((NekoData.DataManager).DM_Game):SetTheValueOfFPS(fps) then
    (LuaNotificationCenter.PostNotification)(Common.n_FPSChanged, nil, {fps = fps})
  end
end

BM_Game.GetLastDungeonType = function(self)
  -- function num : 0_57
  return (self._gameData).dungeonType
end

BM_Game.GetLastAutoDungeonType = function(self)
  -- function num : 0_58
  return (self._gameData).autoType
end

BM_Game.IsGM = function(self)
  -- function num : 0_59
  do return ((self._gameData).myRoleInfo).isGM == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetDungeonList = function(self)
  -- function num : 0_60
  return (self._gameData).dungeonList
end

BM_Game.GetFastMenuSignFromCourtyard = function(self)
  -- function num : 0_61
  return ((self._gameData).fastMenuInfo).sign
end

BM_Game.GetFastMenuInfoFromCourtyard = function(self)
  -- function num : 0_62
  return ((self._gameData).fastMenuInfo).info
end

BM_Game.GetLastPassFloorId = function(self)
  -- function num : 0_63
  return (self._gameData)._dungeonPassProgress
end

BM_Game.GetLastNotPassFloorId = function(self)
  -- function num : 0_64 , upvalues : _ENV, CDungeonSelectMainLine
  local lastPassFloorId = (self._gameData)._dungeonPassProgress
  if lastPassFloorId == nil or lastPassFloorId == -1 then
    return nil
  end
  if lastPassFloorId == 0 then
    for _,tempId in ipairs(CDungeonSelectMainLine:GetAllIds()) do
      if (CDungeonSelectMainLine:GetRecorder(tempId)).sort == 1 then
        return tempId
      end
    end
    return nil
  end
  local tmpSort = (CDungeonSelectMainLine:GetRecorder(lastPassFloorId)).sort
  if tmpSort then
    local resSort = tmpSort + 1
    for _,tempId in ipairs(CDungeonSelectMainLine:GetAllIds()) do
      if (CDungeonSelectMainLine:GetRecorder(tempId)).sort == resSort then
        return tempId
      end
    end
  end
  do
    return nil
  end
end

BM_Game.GetFloorIsNeedToBack = function(self, floorID)
  -- function num : 0_65 , upvalues : CDungeonSelectMainLine
  local recorder = CDungeonSelectMainLine:GetRecorder(floorID)
  if recorder.back ~= 1 then
    do return not recorder end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Game.GetFloorIDWithSceneID = function(self, sceneID)
  -- function num : 0_66 , upvalues : _ENV, CDungeonSelectMainLine
  for _,value in pairs(CDungeonSelectMainLine:GetAllIds()) do
    local recorder = CDungeonSelectMainLine:GetRecorder(value)
    if recorder.sceneid == sceneID then
      return recorder.id
    end
    for _,value in pairs(recorder.smallnodeid) do
      if value == sceneID then
        return recorder.id
      end
    end
  end
end

BM_Game.GetFloorAutoExploreBySceneId = function(self, sceneid)
  -- function num : 0_67 , upvalues : _ENV
  if sceneid == nil then
    return false
  end
  for _,worldData in ipairs((self._gameData).dungeonList) do
    for _,floorData in ipairs(worldData.floorDetail) do
      for _,v in ipairs(floorData.smallPoint) do
        if floorData.autoExplore ~= 1 then
          do
            do return v.sceneId ~= sceneid end
            -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

BM_Game.GetFloorIsPassWithMainLineId = function(self, id)
  -- function num : 0_68 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    for _,floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == id then
        return floorData.firstGet
      end
    end
  end
  return false
end

BM_Game.GetFloorIsUnlockWithMainLineId = function(self, id)
  -- function num : 0_69 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    for _,floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == id then
        return true
      end
    end
  end
  return false
end

BM_Game.GetUnlockWorldPlayerLevelWithWorldId = function(self, worldId)
  -- function num : 0_70 , upvalues : _ENV, CDungeonSelectMainLine
  for _,worldData in ipairs((self._gameData).dungeonList) do
    if worldData.worldId == worldId and (worldData.floorDetail)[1] then
      local firstFloorId = ((worldData.floorDetail)[1]).floor
      local record = CDungeonSelectMainLine:GetRecorder(firstFloorId)
      if record then
        return record.unlockLv
      end
    end
  end
  return nil
end

BM_Game.GetChapternumByFloorId = function(self, floorId)
  -- function num : 0_71 , upvalues : _ENV, CDungeonSelectWorld
  for _,worldData in ipairs((self._gameData).dungeonList) do
    local record = CDungeonSelectWorld:GetRecorder(worldData.worldId)
    if (table.isContain)(record.floorlist, floorId) then
      return record.chapternum
    end
  end
  LogErrorFormat("BM_Game", "cannot find chapternum by floorId:%d", floorId)
  return nil
end

BM_Game.GetUnlockSceneList = function(self)
  -- function num : 0_72
  return (self._gameData).unlockSceneList
end

BM_Game.GetMoveTypeMobileMode = function(self)
  -- function num : 0_73 , upvalues : SysConfigEnum
  if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.moveType] == 0 then
    return "clickMobileMode"
  else
    if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.moveType] == 1 then
      return "rockerMobileMode"
    end
  end
end

BM_Game.GetBuffShowMode = function(self)
  -- function num : 0_74 , upvalues : SysConfigEnum
  if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.showBuff] == 0 then
    return "Hide"
  else
    if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.showBuff] == 1 then
      return "Show"
    end
  end
end

BM_Game.GetAutoBattleMode = function(self)
  -- function num : 0_75 , upvalues : SysConfigEnum
  local AutoBattleModeType = {Optional = 1, Default = 2}
  if (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.autoBattleMode] == 0 then
    return AutoBattleModeType.Optional
  else
    if not (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.autoBattleMode] or (((self._gameData).myRoleInfo).sysConfig)[SysConfigEnum.autoBattleMode] == 1 then
      return AutoBattleModeType.Default
    end
  end
end

BM_Game.GetIfNeedEveryDayLoginNotification = function(self)
  -- function num : 0_76
  do return (((self._gameData).myRoleInfo).localSysConfig)[((self._dm).LocalSystemConfigType).EveryDayLogin] == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetIfNeedSpriteFullNotification = function(self)
  -- function num : 0_77
  do return (((self._gameData).myRoleInfo).localSysConfig)[((self._dm).LocalSystemConfigType).SpriteFull] == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetIfNeedActivityExploreNotification = function(self)
  -- function num : 0_78
  do return (((self._gameData).myRoleInfo).localSysConfig)[((self._dm).LocalSystemConfigType).ActivityExplore] == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetIfNeedOfflineSweepNotification = function(self)
  -- function num : 0_79
  do return (((self._gameData).myRoleInfo).localSysConfig)[((self._dm).LocalSystemConfigType).OfflineSweep] == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetIfAllDungeonWorldAndZoneAwardReceive = function(self)
  -- function num : 0_80 , upvalues : _ENV
  if not (self._gameData).dungeonList then
    return true
  end
  for _,worldData in ipairs((self._gameData).dungeonList) do
    if worldData.totalZones ~= 0 and worldData.clearZones == worldData.totalZones and worldData.isReceived == 0 then
      return false
    end
    for _,floorData in ipairs(worldData.floorDetail) do
      if floorData.totalBoxes ~= 0 and floorData.openedBoxes == floorData.totalBoxes and floorData.isReceived == 0 then
        return false
      end
    end
  end
  return true
end

BM_Game.GetIfDungeonWorldAwardReceiveByWorldId = function(self, worldId)
  -- function num : 0_81 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
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

BM_Game.GetIfDungeonWorldAllZoneAwardReceive = function(self, worldId)
  -- function num : 0_82 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    if worldData.worldId == worldId then
      for _,floorData in ipairs(worldData.floorDetail) do
        if floorData.totalBoxes ~= 0 and floorData.openedBoxes == floorData.totalBoxes and floorData.isReceived == 0 then
          return false
        end
      end
      break
    end
  end
  do
    return true
  end
end

BM_Game.GetIfDungeonWorldZoneAwardReceiveByFloorId = function(self, floorId)
  -- function num : 0_83 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    for _,floorData in ipairs(worldData.floorDetail) do
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

BM_Game.GetIfFirstWitchSkillGuide = function(self)
  -- function num : 0_84
  do return (((self._gameData).myRoleInfo).witchSkillGuide).guide == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetWitchSkillIdList = function(self)
  -- function num : 0_85
  return (((self._gameData).myRoleInfo).witchSkillGuide).skillIdList
end

BM_Game.GetUserId = function(self)
  -- function num : 0_86
  return ((self._gameData).myRoleInfo).userid
end

BM_Game.GetServerId = function(self)
  -- function num : 0_87
  return ((self._gameData).myRoleInfo).zoneid
end

BM_Game.GetPreciseDecimal = function(self, nNum, n)
  -- function num : 0_88 , upvalues : _ENV
  if type(nNum) ~= "number" then
    return nNum
  end
  if not n then
    n = 0
  end
  n = (math.floor)(n)
  if n < 0 then
    n = 0
  end
  local nDecimal = 10 ^ n
  local nTemp = (math.floor)(nNum * nDecimal)
  local nRet = nTemp / nDecimal
  return nRet
end

BM_Game.GetRuneInfo = function(self)
  -- function num : 0_89
  return ((self._gameData).myRoleInfo).runeInfo
end

local GetFloorSort = function(floor)
  -- function num : 0_90 , upvalues : CDungeonSelectMainLine, _ENV
  local record = CDungeonSelectMainLine:GetRecorder(floor)
  if record then
    return record.sort
  else
    LogError("bm_game", "GetRecorder in CDungeonSelectMainLine failed")
    return -1
  end
end

BM_Game.IsUnlockAssistBattle = function(self)
  -- function num : 0_91 , upvalues : GetFloorSort, UnLockDungeon
  local progress = self:GetMainLineProgress()
  local FloorSort = GetFloorSort(progress.floor)
  local UnLockDungeonSort = GetFloorSort(UnLockDungeon + 1)
  do return UnLockDungeonSort <= FloorSort end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetLeiTingDataTotalTime = function(self)
  -- function num : 0_92
  return (self._gameData).LeiTingDataTotalTime
end

BM_Game.SetSystemConfig = function(self, map)
  -- function num : 0_93 , upvalues : _ENV, SysConfigEnum
  ((NekoData.DataManager).DM_Game):SetSystemConfig(map)
  for k,v in pairs(map) do
    if k == SysConfigEnum.moveType then
      (LuaNotificationCenter.PostNotification)(Common.n_MoveTypeChange, self, v)
    else
      if k == SysConfigEnum.rockerType then
        (LuaNotificationCenter.PostNotification)(Common.n_RockerTypeChange, self, v)
      end
    end
  end
end

BM_Game.IsUnlockFunction = function(self, functionId)
  -- function num : 0_94
  return ((self._gameData).unlockFunctions)[functionId]
end

BM_Game.IsShieldFunction = function(self, functionId)
  -- function num : 0_95
  return ((self._gameData).shieldFunctions)[functionId]
end

BM_Game.GetPromptLongPressLevelUp = function(self)
  -- function num : 0_96
  return (self._gameData).promptLongPressLevelUp
end

BM_Game.GetResonanceTag = function(self)
  -- function num : 0_97
  return (self._gameData).resonanceTag
end

BM_Game.GetUserLevel = function(self)
  -- function num : 0_98
  return ((self._gameData).myRoleInfo).userlevel
end

BM_Game.CanSendResponseWaitProtocol = function(self, protocolType, waitProtocol)
  -- function num : 0_99 , upvalues : _ENV, Protocols
  local map = (((self._gameData).waitResponse).protocols)[protocolType]
  if not map or map[waitProtocol] <= 0 then
    return true
  else
    LogInfoFormat("BM_Game", "Cannot send the same protocol(:%s) continuously.", Protocols[protocolType])
    return false
  end
end

BM_Game.OpenResponseWaitDialog = function(self, protocolType, waitProtocol)
  -- function num : 0_100 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not (((self._gameData).waitResponse).protocols)[protocolType] then
    (((self._gameData).waitResponse).protocols)[protocolType] = {}
  end
  local map = (((self._gameData).waitResponse).protocols)[protocolType]
  if not map[waitProtocol] then
    map[waitProtocol] = 0
  end
  map[waitProtocol] = map[waitProtocol] + 1
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._gameData).waitResponse).num = ((self._gameData).waitResponse).num + 1
  LogInfoFormat("OpenResponseWaitDialog", "waitResponseNum = %s", ((self._gameData).waitResponse).num)
  if ((self._gameData).waitResponse).num == 1 then
    (DialogManager.CreateSingletonDialog)("login.responsewaitdialog")
    LogInfo("CreateResponseWaitDialog")
  end
end

BM_Game.CloseResponseWaitDialog = function(self, sProtocol)
  -- function num : 0_101 , upvalues : Protocols, _ENV
  local waitProtocol = Protocols[sProtocol.ProtocolType]
  local protocolType = sProtocol.protocolType
  local map = (((self._gameData).waitResponse).protocols)[protocolType]
  if map and map[waitProtocol] then
    map[waitProtocol] = map[waitProtocol] - 1
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._gameData).waitResponse).num = ((self._gameData).waitResponse).num - 1
  else
    return 
  end
  LogInfoFormat("CloseResponseWaitDialog", "waitResponseNum = %s", ((self._gameData).waitResponse).num)
  if ((self._gameData).waitResponse).num <= 0 then
    (DialogManager.DestroySingletonDialog)("login.responsewaitdialog")
    LogInfo("DestroyResponseWaitDialog")
  end
end

BM_Game.GetGMHideUIInfo = function(self)
  -- function num : 0_102
  return (self._gameData)._gmHideUIInfo
end

local ShowUI = function(child, display)
  -- function num : 0_103 , upvalues : _ENV, UIManager
  if child then
    if display then
      (((((CS.PixelNeko).P1).UI).GMUIControl).ShowUI)(child._uiObject)
      if (child._uiObject).name == "BattleProgressBack" then
        (UIManager.SetLayer)((child._uiObject).transform, ((((child._uiObject).transform).parent).gameObject).layer)
      end
    else
      ;
      (((((CS.PixelNeko).P1).UI).GMUIControl).HideUI)(child._uiObject)
      if (child._uiObject).name == "BattleProgressBack" then
        (UIManager.SetLayer)((child._uiObject).transform, Layers.InvisibleLayerID)
      end
    end
  end
end

BM_Game.SetGMHideUIInfo = function(self, scene, id, display)
  -- function num : 0_104 , upvalues : _ENV, ShowUI
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if self:IsGM() then
    ((((self._gameData)._gmHideUIInfo)[scene])[id]).display = display
    local record = ((((self._gameData)._gmHideUIInfo)[scene])[id]).record
    local dialog = (DialogManager.GetDialog)(record.fileName)
    if dialog then
      local child = nil
      if record.nodePath ~= "" then
        local childList = (string.split)(record.nodePath, ",")
        for i,chidNodePath in ipairs(childList) do
          child = dialog:GetChild(chidNodePath)
          ShowUI(child, display)
        end
      else
        do
          child = dialog._rootWindow
          ShowUI(child, display)
        end
      end
    end
  end
end

local HideUI = function(child, display)
  -- function num : 0_105 , upvalues : _ENV, UIManager
  if child and not display then
    (((((CS.PixelNeko).P1).UI).GMUIControl).HideUI)(child._uiObject)
    if (child._uiObject).name == "BattleProgressBack" then
      (UIManager.SetLayer)((child._uiObject).transform, Layers.InvisibleLayerID)
    end
  end
end

BM_Game.SetGMHideUIByDialog = function(self, scene, dialog)
  -- function num : 0_106 , upvalues : _ENV, HideUI
  if self:IsGM() then
    local map = ((self._gameData)._gmHideUIInfo)[scene]
    for k,v in pairs(map) do
      if dialog._dialogName == (v.record).fileName then
        local child = nil
        if (v.record).nodePath ~= "" then
          local childList = (string.split)((v.record).nodePath, ",")
          for i,chidNodePath in ipairs(childList) do
            child = dialog:GetChild(chidNodePath)
            HideUI(child, v.display)
          end
        else
          do
            do
              child = dialog._rootWindow
              HideUI(child, v.display)
              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

BM_Game.CreateGuideClickEffectDialog = function(self, parentNode, effectId)
  -- function num : 0_107 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self._gameData).guideClickEffect).count = ((self._gameData).guideClickEffect).count + 1
  local dialog = (DialogManager.CreateDialog)("guide.guideclickeffectdialog", parentNode._uiObject)
  if not effectId then
    dialog:SetEffectId(1058)
  else
    dialog:SetEffectId(effectId)
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self._gameData).guideClickEffect).dialogs)[((self._gameData).guideClickEffect).count] = dialog
  return ((self._gameData).guideClickEffect).count
end

BM_Game.DestroyGuideClickEffectDialog = function(self, guideClickEffectCount)
  -- function num : 0_108
  if guideClickEffectCount then
    local dialog = (((self._gameData).guideClickEffect).dialogs)[guideClickEffectCount]
    if dialog then
      dialog:Destroy()
      dialog:RootWindowDestroy()
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((self._gameData).guideClickEffect).dialogs)[guideClickEffectCount] = nil
    end
  end
end

BM_Game.GetReadTips = function(self)
  -- function num : 0_109
  return ((self._gameData).myRoleInfo).tips
end

BM_Game.GetReadNpcTips = function(self)
  -- function num : 0_110
  return ((self._gameData).myRoleInfo).npcTips
end

BM_Game.GetTipsCanUse = function(self, tipTable, tipId, curSceneLoadingId)
  -- function num : 0_111 , upvalues : _ENV
  local tmpRes = tipTable:GetRecorder(tipId)
  local effect = true
  local defect = false
  if tmpRes.effectCondition ~= 0 then
    effect = ((NekoData.BehaviorManager).BM_TipsCondition):ConditionSatisfacted(tmpRes.effectCondition, curSceneLoadingId)
  end
  if tmpRes.defectCondition ~= 0 then
    defect = ((NekoData.BehaviorManager).BM_TipsCondition):ConditionSatisfacted(tmpRes.defectCondition, curSceneLoadingId)
  end
  if effect and not defect then
    return true
  end
  return false
end

BM_Game.GetBookActivity = function(self)
  -- function num : 0_112
  return (self._gameData).bookActivity
end

BM_Game.GetBranchLineList = function(self)
  -- function num : 0_113
  return (self._gameData).branchLineList
end

BM_Game.GetBranchLineCurrentZoneByWordId = function(self, wordId)
  -- function num : 0_114 , upvalues : _ENV
  local zones = (((self._gameData).branchLineList)[wordId]).questInfo
  for k,v in pairs(zones) do
    if v == 1 or v == 2 then
      return k
    end
  end
end

BM_Game.GetBranchLineIsFinishiByWordId = function(self, wordId)
  -- function num : 0_115 , upvalues : _ENV
  local zones = (((self._gameData).branchLineList)[wordId]).questInfo
  for k,v in pairs(zones) do
    if v ~= 3 then
      return false
    end
  end
  return true
end

BM_Game.GetBranchHasPassedByWordId = function(self, wordId)
  -- function num : 0_116
  do return (((self._gameData).branchLineList)[wordId]).hasPassed == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetBranchLineLastZoneByWordId = function(self, wordId)
  -- function num : 0_117 , upvalues : CSideStoryChapter
  local recorder = CSideStoryChapter:GetRecorder(wordId)
  if recorder then
    return (recorder.floorlist)[#recorder.floorlist]
  end
end

BM_Game.GetSupportCommunityCfg = function(self)
  -- function num : 0_118 , upvalues : _ENV, CCommunityCfg
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if (self._gameData).communitycfg == nil then
    (self._gameData).communitycfg = {}
    for _,cId in ipairs(CCommunityCfg:GetAllIds()) do
      local channelId = (CCommunityCfg:GetRecorder(cId)).ChannelID
      if channelId ~= "" then
        local channelIds = (string.split)(channelId, ";")
        if (table.keyof)(channelIds, (SdkManager.GetChannelID)()) ~= nil then
          (table.insert)((self._gameData).communitycfg, cId)
        end
      else
        do
          do
            ;
            (table.insert)((self._gameData).communitycfg, cId)
            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  return (self._gameData).communitycfg
end

BM_Game.GetUISortType = function(self, sortedType)
  -- function num : 0_119
  return ((self._gameData).uiSortType)[sortedType]
end

BM_Game.GetAutoExploreTimes = function(self)
  -- function num : 0_120
  return (self._gameData)._autoExploreTimes
end

BM_Game.IsFinishiAllExplore = function(self)
  -- function num : 0_121
  if ((self._gameData)._autoExploreTimes).current ~= ((self._gameData)._autoExploreTimes).totle then
    do return not (self._gameData)._autoExploreTimes end
    do return true end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

BM_Game.GetAutoExploreProtocol = function(self)
  -- function num : 0_122
  return (self._gameData)._autoExploreProtocol
end

BM_Game.IsAutoFinishing = function(self)
  -- function num : 0_123
  return (self._gameData).isAutoFinishing
end

BM_Game.GetCurrentCardPoolID = function(self, id)
  -- function num : 0_124
  return (self._gameData)._currentCardPoolID
end

BM_Game.GetCanPreEnchantEquip = function(self)
  -- function num : 0_125
  return (self._gameData).canPreEnchantEquip
end

BM_Game.GetTodayLoginTag = function(self)
  -- function num : 0_126
  return (self._gameData).todayLoginTag
end

BM_Game.GetIfHaveAskForNotificationPermission = function(self)
  -- function num : 0_127 , upvalues : _ENV
  do return (((CS.UnityEngine).PlayerPrefs).GetInt)("IfHaveAskForNotificationPermission", 0) == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.IsGuest = function(self)
  -- function num : 0_128
  do return ((self._gameData).myRoleInfo).isGuest == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Game.GetUpAndDownLimitsByFuncId = function(self, funcId)
  -- function num : 0_129 , upvalues : CCharacterLimitConfig, languageID, _ENV
  local record = CCharacterLimitConfig:GetRecorder(funcId)
  if record then
    if languageID == 1 then
      return tonumber(record.cn_top), tonumber(record.cn_floor)
    else
      if languageID == 2 then
        return tonumber(record.en_top), tonumber(record.en_floor)
      else
        if languageID == 3 then
          return tonumber(record.kr_top), tonumber(record.kr_floor)
        else
          if languageID == 4 then
            return tonumber(record.jp_top), tonumber(record.jp_floor)
          end
        end
      end
    end
  else
    LogErrorFormat("BM_Game", "characterLimit with id %s is not exist in ccharacterlimitconfig", funcId)
  end
end

BM_Game.GetAutoExploreWithoutBackAwards = function(self)
  -- function num : 0_130 , upvalues : _ENV
  if #(self._gameData).autoExploreWithoutBackAwards > 0 or (table.nums)((self._gameData).autoExploreWithoutBackMoney) > 0 then
    return {money = (self._gameData).autoExploreWithoutBackMoney, item = (self._gameData).autoExploreWithoutBackAwards}
  end
end

BM_Game.JumpToTheStore = function(self, type)
  -- function num : 0_131 , upvalues : _ENV, UpdateManager
  local platform = (SdkManager.GetPlatform)()
  if SdkManager.IsOverseas then
    local channelName = (SdkManager.GetChannelName)()
    if channelName == "kr" then
      if platform == "iOS" then
        ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(DataCommon.apple_URL_KR)
      else
        ;
        ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(DataCommon.android_URL_KR)
      end
    else
      if platform == "iOS" then
        ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(DataCommon.apple_URL_EN)
      else
        ;
        ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(DataCommon.android_URL_EN)
      end
    end
  else
    do
      if (SdkManager.GetChannel)() == "none" then
        return 
      end
      if type == 1 and platform == "iOS" then
        ((((CS.PixelNeko).P1).PlatformManager).Invoke)("ShowStoreReview")
        return 
      end
      if type == 2 and UpdateManager.HasLatestAppVersion and UpdateManager.ExecuteAppUpdate then
        (UpdateManager.ExecuteAppUpdate)()
      else
        if platform == "iOS" or not ((SdkManager.GetAgent)()):IsChannelPackage() then
          if platform ~= "iOS" then
            local media = ((((CS.PixelNeko).P1).PlatformManager).GetData)("GetProperty", "media")
            if not (DataCommon.Media_URL)[media] then
              local url = (DataCommon.Media_URL)[""]
            end
            if url then
              ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(url)
            else
              LogErrorFormat("BM_Game", "URL Can\'t find, media = %s", media)
            end
          else
            do
              ;
              ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(DataCommon.apple_URL)
              local channelID = tonumber((SdkManager.GetChannelID)())
              local marketPkg = (DataCommon.ChannelID_MarketPkg)[channelID]
              if marketPkg then
                if type ~= 2 and UpdateManager.HasLatestAppVersion and UpdateManager.ExecuteAppUpdate then
                  local jsonStr = (JSON.encode)(marketPkg)
                  ;
                  ((((CS.PixelNeko).P1).PlatformManager).Invoke)("rateToShop", jsonStr)
                else
                  do
                    ;
                    ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(marketPkg.appurl)
                    LogErrorFormat("BM_Game", "MarketPkg Can\'t find, channelID = %s", tostring(channelID))
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

BM_Game.GetOpenDeepLinkActivityTag = function(self)
  -- function num : 0_132
  return (self._gameData).openDeepLinkActivity
end

BM_Game.ClearOpenDeepLinkActivityTag = function(self)
  -- function num : 0_133
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).openDeepLinkActivity = false
end

BM_Game.StartSpeedTask = function(self)
  -- function num : 0_134 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).speedTask = (GameTimer.AddTask)(15, 20, function()
    -- function num : 0_134_0 , upvalues : _ENV
    local req = (LuaNetManager.CreateProtocol)("protocol.timer.timespeedcheck")
    req.clientTime = (math.ceil)(((CS.UnityEngine).Time).time * 1000)
    req.serverTime = (ServerGameTimer.GetServerTimeForecast)()
    req:Send()
  end
)
end

BM_Game.StopSpeedTask = function(self)
  -- function num : 0_135 , upvalues : _ENV
  if (self._gameData).speedTask then
    (GameTimer.RemoveTask)((self._gameData).speedTask)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._gameData).speedTask = nil
  end
end

BM_Game.GetMainCityBgmID = function(self)
  -- function num : 0_136 , upvalues : CMainTownBGM, _ENV, timeutils
  local allIDs = CMainTownBGM:GetAllIds()
  local currentTime = ((ServerGameTimer.GetServerTime)())
  local startTime, endTime, recorder, defaultBgmId, bgmID = nil, nil, nil, nil, nil
  for i,v in ipairs(allIDs) do
    recorder = CMainTownBGM:GetRecorder(v)
    if recorder.startTime == "" and recorder.endTime == "" then
      defaultBgmId = recorder.soundid
    else
      startTime = (timeutils.GetConfigFormatTimeStamp)(recorder.startTime)
      endTime = (timeutils.GetConfigFormatTimeStamp)(recorder.endTime)
      if startTime < currentTime and currentTime < endTime then
        local mainLineProgress = ((NekoData.BehaviorManager).BM_Game):GetMainLineProgress()
        if mainLineProgress and mainLineProgress.floor and tonumber(recorder.chapterLimit) < mainLineProgress.floor then
          bgmID = recorder.soundid
          return bgmID
        end
      end
    end
  end
  if ((NekoData.BehaviorManager).BM_YardMusic):GetSyncMainCity() then
    return ((NekoData.BehaviorManager).BM_YardMusic):GetPlayingAudioId()
  else
    return defaultBgmId
  end
end

BM_Game.IsSkillItemId = function(self, id)
  -- function num : 0_137 , upvalues : CSkillItemTable
  return CSkillItemTable:GetRecorder(id)
end

return BM_Game

