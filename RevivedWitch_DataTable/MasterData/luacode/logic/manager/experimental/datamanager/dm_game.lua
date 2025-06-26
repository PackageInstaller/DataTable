-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_game.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GraphicsCommand = (((CS.PixelNeko).P1).Render).GraphicsCommand
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CActivitySelect = (BeanManager.GetTableByName)("dungeonselect.cactivityselect")
local CStringresTable = (BeanManager.GetTableByName)("message.cstringres")
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local GuideType = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local CGMHideUICfg = (BeanManager.GetTableByName)("ui.cgmhideui")
local RuneStateEnum = (LuaNetManager.GetProtocolDef)("protocol.rune.sruneinfo")
local DM_Game = class("DM_Game")
DM_Game.LocalSystemConfigType = {EveryDayLogin = 1, SpriteFull = 2, ActivityExplore = 3, OfflineSweep = 4}
DM_Game.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, SysConfigEnum, SoundLevelTable, CGMHideUICfg, CActivitySelect
  self._gameData = (NekoData.Data).game
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).battleeditormode = false
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).standalonemode = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).mainClient = nil
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).myRoleInfo = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).lastFloorId = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).resourceBattleAccount = {protocol = nil}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).getmoney = nil
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).equipRecastTag = true
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).phoneCodeState = {tag = nil, time = nil}
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).mailCodeState = {tag = nil, time = nil}
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).accountBag = {}
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).firstAward = {}
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).contrackSkillList = {}
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).sysConfig = {}
  local map = ((self._gameData).myRoleInfo).sysConfig
  map[SysConfigEnum.music] = (((CS.UnityEngine).PlayerPrefs).GetInt)("music", 1)
  local num = (table.nums)((SoundLevelTable:GetRecorder(1)).soundLevel)
  if num < (((CS.UnityEngine).PlayerPrefs).GetInt)("musicNum") then
    map[SysConfigEnum.musicNum] = num
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("musicNum", num)
  else
    map[SysConfigEnum.musicNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("musicNum", num)
  end
  map[SysConfigEnum.soundEffect] = (((CS.UnityEngine).PlayerPrefs).GetInt)("soundEffect", 1)
  num = (table.nums)((SoundLevelTable:GetRecorder(2)).soundLevel)
  if num < (((CS.UnityEngine).PlayerPrefs).GetInt)("soundEffectNum") then
    map[SysConfigEnum.soundEffectNum] = num
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("soundEffectNum", num)
  else
    map[SysConfigEnum.soundEffectNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("soundEffectNum", 2)
  end
  map[SysConfigEnum.dubbing] = (((CS.UnityEngine).PlayerPrefs).GetInt)("dubbing", 1)
  num = (table.nums)((SoundLevelTable:GetRecorder(3)).soundLevel)
  if num < (((CS.UnityEngine).PlayerPrefs).GetInt)("dubbingNum") then
    map[SysConfigEnum.dubbingNum] = num
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("dubbingNum", num)
  else
    map[SysConfigEnum.dubbingNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("dubbingNum", num)
  end
  -- DECOMPILER ERROR at PC186: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).localSysConfig = {}
  local localSystemConfigMap = ((self._gameData).myRoleInfo).localSysConfig
  localSystemConfigMap[(self.LocalSystemConfigType).EveryDayLogin] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_everyDayLogin", 1)
  localSystemConfigMap[(self.LocalSystemConfigType).SpriteFull] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_spriteFull", 1)
  localSystemConfigMap[(self.LocalSystemConfigType).ActivityExplore] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_activityExplore", 1)
  localSystemConfigMap[(self.LocalSystemConfigType).OfflineSweep] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_offlinesweep", 1)
  -- DECOMPILER ERROR at PC238: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).SpecialShapedScreenConfig = ((((CS.PixelNeko).UI).UIManager).GetUISpecialShapedScreen)()
  -- DECOMPILER ERROR at PC240: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).resourcePanelList = nil
  -- DECOMPILER ERROR at PC242: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).dungeonList = nil
  -- DECOMPILER ERROR at PC244: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).unlockSceneList = nil
  -- DECOMPILER ERROR at PC249: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).fastMenuInfo = {sign = nil, info = nil}
  -- DECOMPILER ERROR at PC252: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).runeInfo = nil
  -- DECOMPILER ERROR at PC254: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataIsGuest = nil
  -- DECOMPILER ERROR at PC256: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataAuth = nil
  -- DECOMPILER ERROR at PC258: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataLeftTime = 0
  -- DECOMPILER ERROR at PC260: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataTimer = nil
  -- DECOMPILER ERROR at PC262: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataTotalTime = nil
  -- DECOMPILER ERROR at PC265: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).unlockFunctions = {}
  -- DECOMPILER ERROR at PC268: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).shieldFunctions = {}
  -- DECOMPILER ERROR at PC270: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).promptLongPressLevelUp = false
  -- DECOMPILER ERROR at PC272: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).resonanceTag = false
  -- DECOMPILER ERROR at PC275: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData)._gmHideUIInfo = {}
  local allIds = CGMHideUICfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGMHideUICfg:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC297: Confused about usage of register: R10 in 'UnsetPending'

    if not ((self._gameData)._gmHideUIInfo)[recorder.scene] then
      ((self._gameData)._gmHideUIInfo)[recorder.scene] = {}
    end
    -- DECOMPILER ERROR at PC311: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (((self._gameData)._gmHideUIInfo)[recorder.scene])[recorder.id] = {record = recorder, display = recorder.defaultDisplay == 1}
  end
  -- DECOMPILER ERROR at PC318: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gameData).waitResponse = {num = 0, 
protocols = {}
}
  -- DECOMPILER ERROR at PC320: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gameData).nextFloorId = nil
  -- DECOMPILER ERROR at PC322: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gameData).curPassZoneId = nil
  -- DECOMPILER ERROR at PC324: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gameData).battleResult = nil
  -- DECOMPILER ERROR at PC330: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._gameData).guideClickEffect = {count = 0, 
dialogs = {}
}
  local activityList = {}
  local ids = (CActivitySelect:GetAllIds())
  local recorder = nil
  for i,v in ipairs(ids) do
    recorder = CActivitySelect:GetRecorder(v)
    if recorder.timeActivityID == 0 then
      (table.insert)(activityList, recorder)
    end
  end
  -- DECOMPILER ERROR at PC356: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).activityList = activityList
  -- DECOMPILER ERROR at PC358: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).bookActivity = nil
  -- DECOMPILER ERROR at PC360: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).communitycfg = nil
  -- DECOMPILER ERROR at PC363: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).uiSortType = {}
  -- DECOMPILER ERROR at PC365: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).canPreEnchantEquip = true
  -- DECOMPILER ERROR at PC367: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).todayLoginTag = false
  -- DECOMPILER ERROR at PC369: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).showBossPanelRed = false
  -- DECOMPILER ERROR at PC371: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).showUndecidedRoadRed = false
  -- DECOMPILER ERROR at PC374: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackAwards = {}
  -- DECOMPILER ERROR at PC377: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackMoney = {}
  -- DECOMPILER ERROR at PC379: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self._gameData).openDeepLinkActivity = false
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DM_Game.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV, SysConfigEnum, CGMHideUICfg
  self:SaveSpecialShapedScreen()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).mainClient = nil
  if (self._gameData).myRoleInfo then
    for k,v in pairs((self._gameData).myRoleInfo) do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

      ((self._gameData).myRoleInfo)[k] = nil
    end
    self:UnInitDataBase()
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).lastFloorId = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).equipRecastTag = true
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).phoneCodeState = {tag = nil, time = nil}
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).mailCodeState = {tag = nil, time = nil}
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).resourceBattleAccount = {protocol = nil}
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).accountBag = {}
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).getmoney = nil
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).sysConfig = {}
  local map = ((self._gameData).myRoleInfo).sysConfig
  map[SysConfigEnum.music] = (((CS.UnityEngine).PlayerPrefs).GetInt)("music")
  map[SysConfigEnum.musicNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("musicNum")
  map[SysConfigEnum.soundEffect] = (((CS.UnityEngine).PlayerPrefs).GetInt)("soundEffect")
  map[SysConfigEnum.soundEffectNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("soundEffectNum")
  map[SysConfigEnum.dubbing] = (((CS.UnityEngine).PlayerPrefs).GetInt)("dubbing")
  map[SysConfigEnum.dubbingNum] = (((CS.UnityEngine).PlayerPrefs).GetInt)("dubbingNum")
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).localSysConfig = {}
  local localSystemConfigMap = ((self._gameData).myRoleInfo).localSysConfig
  localSystemConfigMap[(self.LocalSystemConfigType).EveryDayLogin] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_everyDayLogin")
  localSystemConfigMap[(self.LocalSystemConfigType).SpriteFull] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_spriteFull")
  localSystemConfigMap[(self.LocalSystemConfigType).ActivityExplore] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_activityExplore")
  localSystemConfigMap[(self.LocalSystemConfigType).OfflineSweep] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_offlinesweep")
  ;
  ((NekoData.BehaviorManager).BM_Game):SetTheValueOfFPS((((CS.UnityEngine).PlayerPrefs).GetInt)("TheValueOfFPS", 30))
  -- DECOMPILER ERROR at PC154: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).resourcePanelList = nil
  -- DECOMPILER ERROR at PC156: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).dungeonList = nil
  -- DECOMPILER ERROR at PC158: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).unlockSceneList = nil
  -- DECOMPILER ERROR at PC163: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).fastMenuInfo = {sign = nil, info = nil}
  -- DECOMPILER ERROR at PC165: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).bossPanel = nil
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).runeInfo = nil
  if (self._gameData).LeiTingDataTimer then
    (ServerGameTimer.RemoveTask)((self._gameData).LeiTingDataTimer)
    -- DECOMPILER ERROR at PC179: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._gameData).LeiTingDataTimer = nil
  end
  -- DECOMPILER ERROR at PC181: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataIsGuest = nil
  -- DECOMPILER ERROR at PC183: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataAuth = nil
  -- DECOMPILER ERROR at PC185: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataLeftTime = 0
  for k,v in pairs((self._gameData).unlockFunctions) do
    -- DECOMPILER ERROR at PC193: Confused about usage of register: R8 in 'UnsetPending'

    ((self._gameData).unlockFunctions)[k] = nil
  end
  for k,v in pairs((self._gameData).shieldFunctions) do
    -- DECOMPILER ERROR at PC203: Confused about usage of register: R8 in 'UnsetPending'

    ((self._gameData).shieldFunctions)[k] = nil
  end
  -- DECOMPILER ERROR at PC207: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).promptLongPressLevelUp = false
  -- DECOMPILER ERROR at PC209: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData).resonanceTag = false
  -- DECOMPILER ERROR at PC212: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._gameData)._gmHideUIInfo = {}
  local allIds = CGMHideUICfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGMHideUICfg:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC234: Confused about usage of register: R9 in 'UnsetPending'

    if not ((self._gameData)._gmHideUIInfo)[recorder.scene] then
      ((self._gameData)._gmHideUIInfo)[recorder.scene] = {}
    end
    -- DECOMPILER ERROR at PC248: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self._gameData)._gmHideUIInfo)[recorder.scene])[recorder.id] = {record = recorder, display = recorder.defaultDisplay == 1}
  end
  -- DECOMPILER ERROR at PC252: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._gameData).waitResponse).num = 0
  for k,v in pairs(((self._gameData).waitResponse).protocols) do
    -- DECOMPILER ERROR at PC262: Confused about usage of register: R9 in 'UnsetPending'

    (((self._gameData).waitResponse).protocols)[k] = nil
  end
  -- DECOMPILER ERROR at PC266: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).nextFloorId = nil
  -- DECOMPILER ERROR at PC268: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).curPassZoneId = nil
  -- DECOMPILER ERROR at PC270: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).battleResult = nil
  -- DECOMPILER ERROR at PC273: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._gameData).guideClickEffect).count = 0
  for k,v in pairs(((self._gameData).guideClickEffect).dialogs) do
    -- DECOMPILER ERROR at PC283: Confused about usage of register: R9 in 'UnsetPending'

    (((self._gameData).guideClickEffect).dialogs)[k] = nil
  end
  -- DECOMPILER ERROR at PC287: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).bookActivity = nil
  -- DECOMPILER ERROR at PC289: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).communitycfg = nil
  -- DECOMPILER ERROR at PC291: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).branchLineList = nil
  -- DECOMPILER ERROR at PC293: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData)._autoExploreTimes = nil
  -- DECOMPILER ERROR at PC295: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData)._autoExploreProtocol = nil
  -- DECOMPILER ERROR at PC297: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).isAutoFinishing = nil
  -- DECOMPILER ERROR at PC299: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).canPreEnchantEquip = true
  -- DECOMPILER ERROR at PC301: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).todayLoginTag = false
  -- DECOMPILER ERROR at PC303: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).showBossPanelRed = false
  -- DECOMPILER ERROR at PC305: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).showUndecidedRoadRed = false
  -- DECOMPILER ERROR at PC308: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackAwards = {}
  -- DECOMPILER ERROR at PC311: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackMoney = {}
  -- DECOMPILER ERROR at PC313: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).openDeepLinkActivity = false
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DM_Game.SetBattleEditorMode = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).battleeditormode = true
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).standalonemode = false
end

DM_Game.SetStandAloneMode = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).standalonemode = true
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).battleeditormode = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).isAutoFinishing = nil
end

DM_Game.SetMyRoleInfo = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).myRoleInfo = data
  ;
  (((CS.UnityEngine).PlayerPrefs).SetInt)("serverId", data.zoneid)
end

DM_Game.OnSetClosedClient = function(self, client)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).mainClient = client
end

DM_Game.OnSEnter = function(self, protocol)
  -- function num : 0_6 , upvalues : _ENV, CStringresTable, SysConfigEnum, CNotice
  local mydata = {}
  mydata.userid = (protocol.userInfo).userid
  mydata.isGM = (protocol.userInfo).isGM
  mydata.username = (protocol.userInfo).username
  mydata.userlevel = (protocol.userInfo).userlevel
  mydata.userexp = (protocol.userInfo).userexp
  mydata.zoneid = (protocol.userInfo).serverId
  mydata.phoneNum = (protocol.userInfo).phoneNum
  mydata.mailAddr = (protocol.userInfo).mailAddr
  mydata.isNew = (protocol.userInfo).isNew
  mydata.power = (protocol.userInfo).power
  mydata.backgroundRole = (protocol.userInfo).backgroundRole
  mydata.backgroundSkin = (protocol.userInfo).backgroundSkin
  mydata.isGuest = (protocol.userInfo).guest
  mydata.likedNum = (protocol.userInfo).likedNum
  mydata.iplocaladdr = (protocol.userInfo).iplocaladdr
  LogInfoFormat("DM_Game", "UserInfo.isGM(0否 1是) %s UserInfo.guest(0 游客 1 非游客) %s", (protocol.userInfo).isGM, (protocol.userInfo).guest)
  mydata.guides = (protocol.userInfo).guides
  mydata.buffGuides = (protocol.userInfo).buffGuides
  for k,v in pairs(mydata.guides) do
  end
  do
    if not ((self._gameData).myRoleInfo).witchSkillGuide then
      mydata.witchSkillGuide = {}
      mydata.strengthLimit = (protocol.userInfo).strengthLimit
      mydata.tips = (protocol.userInfo).tips
      mydata.npcTips = (protocol.userInfo).npcTips
      mydata.avatarId = (protocol.userInfo).avatarId
      mydata.frameId = (protocol.userInfo).frameId
      if not (protocol.userInfo).introduce or (protocol.userInfo).introduce == "" then
        mydata.introduce = (TextManager.GetText)((CStringresTable:GetRecorder(1037)).msgTextID)
      else
        mydata.introduce = (protocol.userInfo).introduce
      end
      mydata.sysConfig = {}
      for k,v in pairs((protocol.userInfo).configs) do
        -- DECOMPILER ERROR at PC117: Confused about usage of register: R8 in 'UnsetPending'

        (mydata.sysConfig)[k] = v
        if k == SysConfigEnum.music then
          (((CS.UnityEngine).PlayerPrefs).SetInt)("music", v)
        else
          if k == SysConfigEnum.musicNum then
            (((CS.UnityEngine).PlayerPrefs).SetInt)("musicNum", v)
          else
            if k == SysConfigEnum.soundEffect then
              (((CS.UnityEngine).PlayerPrefs).SetInt)("soundEffect", v)
            else
              if k == SysConfigEnum.soundEffectNum then
                (((CS.UnityEngine).PlayerPrefs).SetInt)("soundEffectNum", v)
              else
                if k == SysConfigEnum.dubbing then
                  (((CS.UnityEngine).PlayerPrefs).SetInt)("dubbing", v)
                else
                  if k == SysConfigEnum.dubbingNum then
                    (((CS.UnityEngine).PlayerPrefs).SetInt)("dubbingNum", v)
                  end
                end
              end
            end
          end
        end
      end
      mydata.localSysConfig = {}
      -- DECOMPILER ERROR at PC197: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (mydata.localSysConfig)[(self.LocalSystemConfigType).EveryDayLogin] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_everyDayLogin", 1)
      -- DECOMPILER ERROR at PC208: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (mydata.localSysConfig)[(self.LocalSystemConfigType).SpriteFull] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_spriteFull", 1)
      -- DECOMPILER ERROR at PC219: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (mydata.localSysConfig)[(self.LocalSystemConfigType).ActivityExplore] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_activityExplore", 1)
      -- DECOMPILER ERROR at PC230: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (mydata.localSysConfig)[(self.LocalSystemConfigType).OfflineSweep] = (((CS.UnityEngine).PlayerPrefs).GetInt)("cfg_offlinesweep", 1)
      if (mydata.localSysConfig)[(self.LocalSystemConfigType).EveryDayLogin] == 0 then
        local spiritNoticeRecorder = CNotice:GetRecorder(1)
        local timeTable = (os.date)("*t", (os.time)())
        -- DECOMPILER ERROR at PC255: Confused about usage of register: R5 in 'UnsetPending'

        if timeTable.hour >= 4 and timeTable.hour <= 12 then
          (self._gameData).todayLoginTag = true
        end
        if timeTable.hour < 4 then
          LogInfo("DM_Game", "CancelSchedulingWorkerByType(\'everydaylogin\')")
          ;
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("everydaylogin")
          local lastTime = ((12 - timeTable.hour - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
          LogInfoFormat("DM_Game", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
          ;
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
        else
          do
            LogInfo("DM_Game", "CancelSchedulingWorkerByType(\'everydaylogin\')")
            ;
            ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("everydaylogin")
            do
              local lastTime = ((24 - timeTable.hour + 12 - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
              LogInfoFormat("DM_Game", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime)
              ;
              ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "everydaylogin", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), lastTime, (TextManager.GetText)(spiritNoticeRecorder.titleID))
              mydata.SpecialShapedScreenConfig = ((((CS.PixelNeko).UI).UIManager).GetUISpecialShapedScreen)()
              self:SetMyRoleInfo(mydata)
              ;
              ((NekoData.BehaviorManager).BM_Game):SetTheValueOfFPS((((CS.UnityEngine).PlayerPrefs).GetInt)("TheValueOfFPS", 30))
              self:InitDataBase()
              self:RequestDungeonRedDot()
              ;
              ((NekoData.BehaviorManager).BM_Game):SetVolume()
              ;
              (((NekoData.DataManager).DM_RedDot).Init)()
            end
          end
        end
      end
    end
  end
end

DM_Game.OnStartGuide = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  LogInfoFormat("DM_Game", "sstartguide guide %s", protocol.guide)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self._gameData).myRoleInfo).guides)[protocol.guide] = 0
end

DM_Game.OnRecordGuide = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  LogInfoFormat("DM_Game", "srecordguide guide %s", protocol.guide)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self._gameData).myRoleInfo).guides)[protocol.guide] = 1
end

DM_Game.SetGuideTag = function(self, type, tag)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (((self._gameData).myRoleInfo).guides)[type] = tag
  if tag == 1 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.user.crecordguide")
    csend.guide = type
    csend:Send()
  end
end

DM_Game.SStartBuffGuide = function(self, protocol)
  -- function num : 0_10 , upvalues : _ENV
  LogInfoFormat("DM_Game", "sstartbuffguide guide %s", protocol.buffType)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self._gameData).myRoleInfo).buffGuides)[protocol.buffType] = 0
end

DM_Game.SetBuffGuideTag = function(self, type, tag)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  (((self._gameData).myRoleInfo).buffGuides)[type] = tag
  if tag == 1 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.user.crecordbuffguide")
    csend.buffType = type
    csend:Send()
  end
end

DM_Game.OnSSendHeadInfo = function(self, protocol)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).avatarIds = {}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).frameIds = {}
  for k,v in pairs(protocol.avatars) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    (((self._gameData).myRoleInfo).avatarIds)[k] = v
  end
  for k,v in pairs(protocol.frames) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    (((self._gameData).myRoleInfo).frameIds)[k] = v
  end
end

DM_Game.OnSItemConvertToFrame = function(self, protocol)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self._gameData).myRoleInfo).frameIds)[protocol.frameId] = 1
end

DM_Game.OnSRoleConvertToAvatar = function(self, protocol)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (((self._gameData).myRoleInfo).avatarIds)[protocol.avatarId] = 1
end

DM_Game.OnSSendPhoneCode = function(self, protocol)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).phoneCodeState = {tag = protocol.result, time = protocol.time}
end

DM_Game.OnSSendMailCode = function(self, protocol)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).mailCodeState = {tag = protocol.result, time = protocol.time}
end

DM_Game.SetSystemConfig = function(self, map)
  -- function num : 0_17 , upvalues : _ENV, SysConfigEnum
  for k,v in pairs(map) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    (((self._gameData).myRoleInfo).sysConfig)[k] = v
    if k == SysConfigEnum.music then
      (((CS.UnityEngine).PlayerPrefs).SetInt)("music", v)
    else
      if k == SysConfigEnum.musicNum then
        (((CS.UnityEngine).PlayerPrefs).SetInt)("musicNum", v)
      else
        if k == SysConfigEnum.soundEffect then
          (((CS.UnityEngine).PlayerPrefs).SetInt)("soundEffect", v)
        else
          if k == SysConfigEnum.soundEffectNum then
            (((CS.UnityEngine).PlayerPrefs).SetInt)("soundEffectNum", v)
          else
            if k == SysConfigEnum.dubbing then
              (((CS.UnityEngine).PlayerPrefs).SetInt)("dubbing", v)
            else
              if k == SysConfigEnum.dubbingNum then
                (((CS.UnityEngine).PlayerPrefs).SetInt)("dubbingNum", v)
              else
              end
            end
          end
        end
      end
    end
  end
  if (k ~= SysConfigEnum.moveType or k == SysConfigEnum.rockerType) then
  end
end

DM_Game.SetLocalSystemConfig = function(self, map)
  -- function num : 0_18 , upvalues : _ENV
  for k,v in pairs(map) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    (((self._gameData).myRoleInfo).localSysConfig)[k] = v
    if k == (self.LocalSystemConfigType).EveryDayLogin then
      (((CS.UnityEngine).PlayerPrefs).SetInt)("cfg_everyDayLogin", v)
    else
      if k == (self.LocalSystemConfigType).SpriteFull then
        (((CS.UnityEngine).PlayerPrefs).SetInt)("cfg_spriteFull", v)
      else
        if k == (self.LocalSystemConfigType).ActivityExplore then
          (((CS.UnityEngine).PlayerPrefs).SetInt)("cfg_activityExplore", v)
        else
          if k == (self.LocalSystemConfigType).OfflineSweep then
            (((CS.UnityEngine).PlayerPrefs).SetInt)("cfg_offlinesweep", v)
          end
        end
      end
    end
  end
end

DM_Game.OnSChangeSystemConfig = function(self, protocol)
  -- function num : 0_19
end

DM_Game.OnSCreateUser = function(self, protocol)
  -- function num : 0_20
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).username = protocol.username
end

DM_Game.OnSChangeUserName = function(self, protocol)
  -- function num : 0_21
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).username = protocol.name
end

DM_Game.OnSCheckPhoneCode = function(self, protocol)
  -- function num : 0_22
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).phoneNum = protocol.num
end

DM_Game.OnSCheckMailCode = function(self, protocol)
  -- function num : 0_23
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).mailAddr = protocol.address
end

DM_Game.OnSChangeUserIntroduce = function(self, protocol)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).introduce = protocol.introduce
end

DM_Game.OnSChangeUserAvatar = function(self, protocol)
  -- function num : 0_25
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).avatarId = protocol.avatarId
end

DM_Game.OnSChangeUserFrame = function(self, protocol)
  -- function num : 0_26
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).frameId = protocol.frameId
end

DM_Game.OnSChangeUserLikedNum = function(self, protocol)
  -- function num : 0_27
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).likedNum = protocol.likedNum
end

DM_Game.OnSEnterMainCity = function(self, protocol)
  -- function num : 0_28 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).lastFloorId = protocol.lastFloorId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).battleResult = protocol.battleResult
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).getmoney = protocol.money
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).accountBag = {}
  for i,v in ipairs(protocol.exploreawards) do
    (table.insert)((self._gameData).accountBag, v)
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).firstAward = {}
  for _,itemInfo in ipairs(protocol.firstPassAward) do
    (table.insert)((self._gameData).firstAward, itemInfo)
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).tip = protocol.tip
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).dungeonType = protocol.dungeonType
end

DM_Game.InitDataBase = function(self)
  -- function num : 0_29 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  DataCommon.SqlClientId = DataCommon.SqlClientId + 1
  local protocol = (BattleClientProtocolManager.CreateProtocol)("database.ccreatedatabase")
  protocol.userId = ((self._gameData).myRoleInfo).userid
  protocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

DM_Game.UnInitDataBase = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("database.cclosedatabase")
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

DM_Game.OnSResourcePanel = function(self, userInfo)
  -- function num : 0_31 , upvalues : _ENV, ResourceStageTable
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).resourcePanelList = userInfo
  for i,v in ipairs((self._gameData).resourcePanelList) do
    local info = nil
    for k,value in pairs(DataCommon.LocalTips) do
      if value.typeId and value.typeId == v.id then
        info = value
        break
      end
    end
    do
      do
        if info then
          local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. info.Tag, info.Default)
          if value == info.Default and not v.lock and v.open and not v.clearAll then
            (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. info.Tag, info.New)
          end
        end
        -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local data = userInfo[1]
  if data and not data.lock and data.open then
    local list = (data.detailInfo)[1]
    if list and list.open and #list.stageList > 1 then
      local index = nil
      for i,v in ipairs(list.stageList) do
        local record = ResourceStageTable:GetRecorder(v.id)
        if not v.lock and record.level <= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
          index = i
        end
      end
      if index > 1 then
        local value = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).Resource_Mana).Tag, ((DataCommon.LocalTips).Resource_Mana).Default)
        local lastValue = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).Resource_Mana).LastTag, ((DataCommon.LocalTips).Resource_Mana).Default)
        if value == ((DataCommon.LocalTips).Resource_Mana).Default or lastValue ~= ((list.stageList)[index]).id then
          (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).Resource_Mana).Tag, ((list.stageList)[index]).id)
          ;
          (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. ((DataCommon.LocalTips).Resource_Mana).LastTag, ((list.stageList)[index]).id)
        end
      end
    end
  end
end

DM_Game.OnSOpenBossPanel = function(self, protocol)
  -- function num : 0_32 , upvalues : _ENV
  local cbossrush = (BeanManager.GetTableByName)("dungeonselect.cbossrush")
  local bossList = {}
  for _,v in pairs(protocol.bosses) do
    local recorder = cbossrush:GetRecorder(v.id)
    if recorder then
      local t = {id = v.id, cfg = recorder, info = v}
      bossList[#bossList + 1] = t
    end
  end
  ;
  (table.sort)(bossList, function(lhs, rhs)
    -- function num : 0_32_0
    do return (lhs.cfg).sortID < (rhs.cfg).sortID end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).bossPanel = bossList
  self:CheckBossPanelRed()
end

DM_Game.OnSResiveBossPanelStageAward = function(self, protocol)
  -- function num : 0_33 , upvalues : _ENV
  for _,v in pairs((self._gameData).bossPanel) do
    if v.id == protocol.id then
      (table.insert)((v.info).awardGot, protocol.stageId)
      break
    end
  end
  do
    self:CheckBossPanelRed()
  end
end

DM_Game.OnSBossRedPoint = function(self)
  -- function num : 0_34
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).showBossPanelRed = true
end

DM_Game.OnSFragmentRedPoint = function(self)
  -- function num : 0_35
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).showFragmentPanelRed = true
end

DM_Game.CheckFragmentPanelRed = function(self)
  -- function num : 0_36 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).showFragmentPanelRed = false
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.ccloseshatteredredpoint")
  csend:Send()
end

DM_Game.OnSUndecidedRoadRedPoint = function(self)
  -- function num : 0_37
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).showUndecidedRoadRed = true
end

DM_Game.CheckUndecidedRoadRed = function(self)
  -- function num : 0_38
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).showUndecidedRoadRed = false
end

DM_Game.CheckBossPanelRed = function(self)
  -- function num : 0_39 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).bossPanelRed = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).showBossPanelRed = false
  for _,v in pairs((self._gameData).bossPanel) do
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

    if (table.nums)((v.info).awardGot) < (v.info).awardTotalNum then
      ((self._gameData).bossPanelRed)[v.id] = true
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self._gameData).showBossPanelRed = true
    end
  end
end

DM_Game.SetEquipRecastTag = function(self)
  -- function num : 0_40
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).equipRecastTag = false
end

DM_Game.OnSOpenDungeonList = function(self, userInfo)
  -- function num : 0_41 , upvalues : _ENV, CDungeonSelectMainLine
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData)._dungeonProgress = {}
  local temp = {world = -1, floor = -1}
  local passFloorId = -1
  for _,world in ipairs(userInfo) do
    if temp.world < world.worldId then
      temp.world = world.worldId
    end
    for _,floor in ipairs(world.floorDetail) do
      if passFloorId == -1 then
        passFloorId = 0
      end
      local floorRecord = CDungeonSelectMainLine:GetRecorder(floor.floor)
      local tempRecord = CDungeonSelectMainLine:GetRecorder(temp.floor)
      local passRecord = (CDungeonSelectMainLine:GetRecorder(passFloorId))
      local floorSort, tempSort, passSort = nil, nil, nil
      if floorRecord then
        floorSort = floorRecord.sort
      else
        LogErrorFormat("dm_game", "GetRecorder in CDungeonSelectMainLine failed")
        floorSort = -1
      end
      if tempRecord then
        tempSort = tempRecord.sort
        if tempSort < floorSort then
          temp.floor = floor.floor
        end
      else
        temp.floor = floor.floor
      end
      if floor.firstGet == true then
        if passRecord then
          passSort = passRecord.sort
          if passSort < floorSort then
            passFloorId = floor.floor
          end
        else
          passFloorId = floor.floor
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).dungeonList = userInfo
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData)._dungeonProgress = temp
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData)._dungeonPassProgress = passFloorId
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._gameData).unlockSceneList = {}
  for _,value1 in pairs((self._gameData).dungeonList) do
    local world = CDungeonSelectMainLine:GetRecorder(value1.worldId)
    if world.unlockLv <= ((self._gameData).myRoleInfo).userlevel then
      (table.insert)((self._gameData).unlockSceneList, world.sceneid)
      for _,value2 in pairs(value1.floorDetail) do
        for _,value3 in pairs(value2.smallPoint) do
          (table.insert)((self._gameData).unlockSceneList, value3.sceneId)
        end
      end
    end
  end
end

DM_Game.SetSpecialShapedScreenValue = function(self, value)
  -- function num : 0_42
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).SpecialShapedScreenConfig = value
end

DM_Game.SaveSpecialShapedScreen = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local value = ((self._gameData).myRoleInfo).SpecialShapedScreenConfig
  if value then
    LogInfoFormat("DM_Game", "UISpecialShapedScreen record int value %d", value)
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("UISpecialShapedScreen", value)
  end
end

DM_Game.SetTheValueOfFPS = function(self, fps)
  -- function num : 0_44 , upvalues : _ENV, GraphicsCommand
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

  if (self._gameData).myRoleInfo and ((self._gameData).myRoleInfo).TheValueOfFPS ~= fps then
    ((self._gameData).myRoleInfo).TheValueOfFPS = fps
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("TheValueOfFPS", fps)
    ;
    (GraphicsCommand.SetTargetFrameRate)(fps)
    LogInfo("FPS", "Set FPS " .. tostring(fps))
    return true
  end
  LogError("DM_Game", "fps set failed, myRoleInfo hasnt been initialized")
end

DM_Game.SetFastMenuSignFromCourtyard = function(self, sign, itemTipsJumpInfo)
  -- function num : 0_45
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self._gameData).fastMenuInfo).sign = sign
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self._gameData).fastMenuInfo).info = itemTipsJumpInfo
end

DM_Game.OnSCompleteZone = function(self, protocol)
  -- function num : 0_46 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).getmoney = protocol.money
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).accountBag = {}
  if protocol.exploreAwards then
    for i,v in ipairs(protocol.exploreAwards) do
      (table.insert)((self._gameData).accountBag, v)
    end
  end
  do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._gameData).firstAward = {}
    if protocol.firstPassAward then
      for _,itemInfo in ipairs(protocol.firstPassAward) do
        (table.insert)((self._gameData).firstAward, itemInfo)
      end
    end
    do
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).topMessage = nil
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).topMessage = protocol.topMessage
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).nextFloorId = protocol.zoneId
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).curPassZoneId = protocol.currentZone
    end
  end
end

DM_Game.OnSFinishAutoExplore = function(self, protocol)
  -- function num : 0_47
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).autoType = protocol.dungeonType
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).isAutoFinishing = true
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).battleResult = protocol.battleResult
end

DM_Game.OnSReceiveDungeonWorldAward = function(self, worldId)
  -- function num : 0_48 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    if worldData.worldId == worldId then
      worldData.isReceived = 1
      break
    end
  end
end

DM_Game.OnSReceiveDungeonPointAward = function(self, floorId)
  -- function num : 0_49 , upvalues : _ENV
  for _,worldData in ipairs((self._gameData).dungeonList) do
    for _,floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == floorId then
        floorData.isReceived = 1
        return 
      end
    end
  end
end

DM_Game.OnSStartWitchSkillGuide = function(self, protocol)
  -- function num : 0_50
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._gameData).myRoleInfo).witchSkillGuide then
    ((self._gameData).myRoleInfo).witchSkillGuide = {}
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self._gameData).myRoleInfo).witchSkillGuide).guide = protocol.guide
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self._gameData).myRoleInfo).witchSkillGuide).skillIdList = protocol.skillItemIds
  end
end

DM_Game.RequestDungeonRedDot = function(self)
  -- function num : 0_51 , upvalues : _ENV
  local protocol = (BattleClientProtocolManager.CreateProtocol)("dungeonreddot.cgetdungeonequipreddot")
  protocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

DM_Game.OnSRuneInfo = function(self, protocol)
  -- function num : 0_52 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).runeInfo = protocol
  LogInfoFormat("DM_Game", "--- state = %s, dialogId = %s ---", protocol.state, protocol.dialogId)
end

DM_Game.OnSRune = function(self)
  -- function num : 0_53 , upvalues : RuneStateEnum, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (((self._gameData).myRoleInfo).runeInfo).state = RuneStateEnum.RUNE
  LogInfoFormat("DM_Game", "--- state = %s ---", RuneStateEnum.RUNE)
end

DM_Game.OnSLeiTingAntiAddiction = function(self, protocol)
  -- function num : 0_54 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).LeiTingDataAuth = protocol.auth
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataIsGuest = protocol.isGuest
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataLeftTime = protocol.lefttime
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).LeiTingDataTotalTime = protocol.totaltime
  if protocol.isGuest == 1 then
    if (self._gameData).LeiTingDataTimer then
      (ServerGameTimer.RemoveTask)((self._gameData).LeiTingDataTimer)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).LeiTingDataTimer = nil
    end
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._gameData).LeiTingDataTimer = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_54_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    (self._gameData).LeiTingDataLeftTime = (self._gameData).LeiTingDataLeftTime - 1
    if (self._gameData).LeiTingDataLeftTime == 900 then
      ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(15, 6)
      if (self._gameData).LeiTingDataTimer then
        (ServerGameTimer.RemoveTask)((self._gameData).LeiTingDataTimer)
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (self._gameData).LeiTingDataTimer = nil
      end
    end
    if (self._gameData).LeiTingDataLeftTime == 1800 then
      ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(30, 6)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self._gameData).LeiTingDataIs30 = true
    end
  end
, nil)
  else
    if protocol.auth == 0 then
      if (self._gameData).LeiTingDataTimer then
        (ServerGameTimer.RemoveTask)((self._gameData).LeiTingDataTimer)
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (self._gameData).LeiTingDataTimer = nil
      end
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self._gameData).LeiTingDataTimer = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_54_1 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    (self._gameData).LeiTingDataLeftTime = (self._gameData).LeiTingDataLeftTime - 1
    if (self._gameData).LeiTingDataLeftTime == 900 then
      ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(15, 5)
      if (self._gameData).LeiTingDataTimer then
        (ServerGameTimer.RemoveTask)((self._gameData).LeiTingDataTimer)
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (self._gameData).LeiTingDataTimer = nil
      end
    end
    if (self._gameData).LeiTingDataLeftTime == 1800 then
      ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(30, 5)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self._gameData).LeiTingDataIs30 = true
    end
  end
, nil)
    else
    end
  end
  if protocol.auth == 2 then
  end
end

DM_Game.OnSAllUnlockFunc = function(self, protocol)
  -- function num : 0_55 , upvalues : _ENV
  for i,v in ipairs(protocol.funcLisk) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._gameData).unlockFunctions)[v.funId] = true
  end
end

DM_Game.OnSUnlockFunc = function(self, protocol)
  -- function num : 0_56 , upvalues : _ENV
  for i,v in ipairs(protocol.funcLisk) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._gameData).unlockFunctions)[v.funId] = true
    LogInfoFormat("DM_Game", "-OnSUnlockFunc- unlockFuncId = %s ---", v.funId)
  end
end

DM_Game.OnSShieldFunction = function(self, protocol)
  -- function num : 0_57 , upvalues : _ENV
  for k,v in pairs((self._gameData).shieldFunctions) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ((self._gameData).shieldFunctions)[k] = nil
  end
  local str = ""
  for i,v in ipairs(protocol.shieldFunction) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ((self._gameData).shieldFunctions)[v] = true
    str = str .. v .. ", "
  end
  LogInfoFormat("DM_Game", "ShieldFunction：%s", str)
end

DM_Game.SetPromptLongPressLevelUp = function(self)
  -- function num : 0_58
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).promptLongPressLevelUp = true
end

DM_Game.SetResonanceTag = function(self)
  -- function num : 0_59
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).resonanceTag = true
end

DM_Game.OnSShowObtainPanel = function(self, protocol)
  -- function num : 0_60
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).resourceBattleAccount).protocol = protocol
end

DM_Game.OnSPlayerLevelUp = function(self, protocol)
  -- function num : 0_61
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).strengthLimit = protocol.strengthLimit
end

DM_Game.OnSResSpirit = function(self, protocol)
  -- function num : 0_62
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).strengthLimit = protocol.strengthLimit
end

DM_Game.AddPlayerExp = function(self, exp)
  -- function num : 0_63 , upvalues : CPlayerLevel
  local allIds = CPlayerLevel:GetAllIds()
  local recorder = CPlayerLevel:GetRecorder(((self._gameData).myRoleInfo).userlevel)
  local currentLevelExpMax = recorder.exp
  local maxLevel = (CPlayerLevel:GetRecorder(#allIds)).id
  local maxLevelMaxExp = (CPlayerLevel:GetRecorder(#allIds)).exp
  if ((self._gameData).myRoleInfo).userlevel == maxLevel and maxLevelMaxExp <= ((self._gameData).myRoleInfo).userexp then
    return 
  end
  if currentLevelExpMax <= ((self._gameData).myRoleInfo).userexp + exp then
    local lv = ((self._gameData).myRoleInfo).userlevel
    for i = lv, #allIds do
      local max = (CPlayerLevel:GetRecorder(i)).exp
      if max <= ((self._gameData).myRoleInfo).userexp + exp then
        exp = exp - max
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R13 in 'UnsetPending'

        if ((self._gameData).myRoleInfo).userlevel == maxLevel then
          ((self._gameData).myRoleInfo).userexp = maxLevelMaxExp
          break
        end
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self._gameData).myRoleInfo).userlevel = ((self._gameData).myRoleInfo).userlevel + 1
      else
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R13 in 'UnsetPending'

        ;
        ((self._gameData).myRoleInfo).userexp = ((self._gameData).myRoleInfo).userexp + (exp)
        break
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self._gameData).myRoleInfo).userexp = ((self._gameData).myRoleInfo).userexp + (exp)
    end
  end
end

DM_Game.OnSBookActivity = function(self, protocol)
  -- function num : 0_64
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).bookActivity = {isOpen = protocol.isOpen, itemNum = protocol.itemNum, itemId = protocol.itemId}
end

DM_Game.CloseBookActivity = function(self)
  -- function num : 0_65
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  if (self._gameData).bookActivity ~= nil then
    ((self._gameData).bookActivity).isOpen = 0
  end
end

DM_Game.OnSOpenSideQuestPanel = function(self, userInfo)
  -- function num : 0_66
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).branchLineList = userInfo
end

DM_Game.OnSUpdateSideQuestDungeon = function(self, dungeons)
  -- function num : 0_67
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).branchLineList)[dungeons.DungeonID] = dungeons
end

DM_Game.OnSUpdateUISortType = function(self, protocol)
  -- function num : 0_68 , upvalues : _ENV
  local OrderType = {Ascending = 1, Descending = 2}
  for uiType,sortNumValue in pairs(protocol.uiSortTypes) do
    local ascending = true
    if sortNumValue % 10 == 2 then
      ascending = false
    end
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self._gameData).uiSortType)[uiType] = {nameTxtId = sortNumValue // 10, isAscending = ascending}
  end
end

DM_Game.RecorderUISortType = function(self, sortedType, nameTxtId, isAscending)
  -- function num : 0_69
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ((self._gameData).uiSortType)[sortedType] = {nameTxtId = nameTxtId, isAscending = isAscending}
end

DM_Game.SetAutoExploreTimes = function(self, autoExploreTimes)
  -- function num : 0_70
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData)._autoExploreTimes = autoExploreTimes
end

DM_Game.OnAutoExploreFinishiOnce = function(self)
  -- function num : 0_71
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  if (self._gameData)._autoExploreTimes then
    ((self._gameData)._autoExploreTimes).current = ((self._gameData)._autoExploreTimes).current + 1
  end
end

DM_Game.SetAutoExploreProtocol = function(self, autoExploreProtocol)
  -- function num : 0_72
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData)._autoExploreProtocol = autoExploreProtocol
end

DM_Game.ClearAutoExploreData = function(self)
  -- function num : 0_73
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData)._autoExploreTimes = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData)._autoExploreProtocol = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).isAutoFinishing = nil
end

DM_Game.SetCurrentCardPoolID = function(self, id)
  -- function num : 0_74
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData)._currentCardPoolID = id
end

DM_Game.ClearCurrentCardPoolID = function(self)
  -- function num : 0_75
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData)._currentCardPoolID = nil
end

DM_Game.SetCanPreEnchantEquip = function(self, canPreEnchantEquip)
  -- function num : 0_76
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).canPreEnchantEquip = canPreEnchantEquip
end

DM_Game.SetTodayLoginTag = function(self, flag)
  -- function num : 0_77
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).todayLoginTag = flag
end

DM_Game.SetIfHaveAskForNotificationPermission = function(self, flag)
  -- function num : 0_78 , upvalues : _ENV
  (((CS.UnityEngine).PlayerPrefs).SetInt)("IfHaveAskForNotificationPermission", flag)
end

DM_Game.OnSChooseBackground = function(self, protocol)
  -- function num : 0_79
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._gameData).myRoleInfo).backgroundRole = protocol.roleId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._gameData).myRoleInfo).backgroundSkin = protocol.skin
end

DM_Game.ClearLastDungeonType = function(self)
  -- function num : 0_80
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).dungeonType = nil
end

DM_Game.ClearFirstAward = function(self)
  -- function num : 0_81
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).firstAward = {}
end

DM_Game.ClearTip = function(self)
  -- function num : 0_82
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).tip = 0
end

DM_Game.ClearLastAutoDungeonType = function(self)
  -- function num : 0_83
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).autoType = nil
end

DM_Game.OnSFinishAutoExploreWithoutBack = function(self, protocol)
  -- function num : 0_84
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._gameData).autoExploreWithoutBackAwards = protocol.exploreawards
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackMoney = protocol.money
end

DM_Game.ClearExploreWithoutBackAwards = function(self)
  -- function num : 0_85
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).autoExploreWithoutBackAwards = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._gameData).autoExploreWithoutBackMoney = {}
end

DM_Game.OnSOpenDeepLinkActivity = function(self)
  -- function num : 0_86
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._gameData).openDeepLinkActivity = true
end

return DM_Game

