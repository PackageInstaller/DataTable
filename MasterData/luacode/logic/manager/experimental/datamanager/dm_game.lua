local GraphicsCommand = CS.PixelNeko.P1.Render.GraphicsCommand
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local ResourceStageTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CActivitySelect = BeanManager.GetTableByName("dungeonselect.cactivityselect")
local CStringresTable = BeanManager.GetTableByName("message.cstringres")
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local GuideType = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CNotice = BeanManager.GetTableByName("notice.cnotice")
local CGMHideUICfg = BeanManager.GetTableByName("ui.cgmhideui")
local RuneStateEnum = LuaNetManager.GetProtocolDef("protocol.rune.sruneinfo")
local DM_Game = class("DM_Game")
DM_Game.LocalSystemConfigType = {
  EveryDayLogin = 1,
  SpriteFull = 2,
  ActivityExplore = 3,
  OfflineSweep = 4
}

function DM_Game:Ctor()
  self._gameData = NekoData.Data.game
  self._gameData.battleeditormode = false
  self._gameData.standalonemode = false
  self._gameData.mainClient = nil
  self._gameData.myRoleInfo = {}
  self._gameData.lastFloorId = 0
  self._gameData.resourceBattleAccount = {protocol = nil}
  self._gameData.getmoney = nil
  self._gameData.equipRecastTag = true
  self._gameData.phoneCodeState = {tag = nil, time = nil}
  self._gameData.mailCodeState = {tag = nil, time = nil}
  self._gameData.accountBag = {}
  self._gameData.firstAward = {}
  self._gameData.contrackSkillList = {}
  self._gameData.myRoleInfo.sysConfig = {}
  local map = self._gameData.myRoleInfo.sysConfig
  map[SysConfigEnum.music] = CS.UnityEngine.PlayerPrefs.GetInt("music", 1)
  local num = table.nums(SoundLevelTable:GetRecorder(1).soundLevel)
  if num < CS.UnityEngine.PlayerPrefs.GetInt("musicNum") then
    map[SysConfigEnum.musicNum] = num
    CS.UnityEngine.PlayerPrefs.SetInt("musicNum", num)
  else
    map[SysConfigEnum.musicNum] = CS.UnityEngine.PlayerPrefs.GetInt("musicNum", num)
  end
  map[SysConfigEnum.soundEffect] = CS.UnityEngine.PlayerPrefs.GetInt("soundEffect", 1)
  num = table.nums(SoundLevelTable:GetRecorder(2).soundLevel)
  if num < CS.UnityEngine.PlayerPrefs.GetInt("soundEffectNum") then
    map[SysConfigEnum.soundEffectNum] = num
    CS.UnityEngine.PlayerPrefs.SetInt("soundEffectNum", num)
  else
    map[SysConfigEnum.soundEffectNum] = CS.UnityEngine.PlayerPrefs.GetInt("soundEffectNum", 2)
  end
  map[SysConfigEnum.dubbing] = CS.UnityEngine.PlayerPrefs.GetInt("dubbing", 1)
  num = table.nums(SoundLevelTable:GetRecorder(3).soundLevel)
  if num < CS.UnityEngine.PlayerPrefs.GetInt("dubbingNum") then
    map[SysConfigEnum.dubbingNum] = num
    CS.UnityEngine.PlayerPrefs.SetInt("dubbingNum", num)
  else
    map[SysConfigEnum.dubbingNum] = CS.UnityEngine.PlayerPrefs.GetInt("dubbingNum", num)
  end
  self._gameData.myRoleInfo.localSysConfig = {}
  local localSystemConfigMap = self._gameData.myRoleInfo.localSysConfig
  localSystemConfigMap[self.LocalSystemConfigType.EveryDayLogin] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_everyDayLogin", 1)
  localSystemConfigMap[self.LocalSystemConfigType.SpriteFull] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_spriteFull", 1)
  localSystemConfigMap[self.LocalSystemConfigType.ActivityExplore] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_activityExplore", 1)
  localSystemConfigMap[self.LocalSystemConfigType.OfflineSweep] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_offlinesweep", 1)
  self._gameData.myRoleInfo.SpecialShapedScreenConfig = CS.PixelNeko.UI.UIManager.GetUISpecialShapedScreen()
  self._gameData.resourcePanelList = nil
  self._gameData.dungeonList = nil
  self._gameData.unlockSceneList = nil
  self._gameData.fastMenuInfo = {sign = nil, info = nil}
  self._gameData.myRoleInfo.runeInfo = nil
  self._gameData.LeiTingDataIsGuest = nil
  self._gameData.LeiTingDataAuth = nil
  self._gameData.LeiTingDataLeftTime = 0
  self._gameData.LeiTingDataTimer = nil
  self._gameData.LeiTingDataTotalTime = nil
  self._gameData.unlockFunctions = {}
  self._gameData.shieldFunctions = {}
  self._gameData.promptLongPressLevelUp = false
  self._gameData.resonanceTag = false
  self._gameData._gmHideUIInfo = {}
  local allIds = CGMHideUICfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGMHideUICfg:GetRecorder(allIds[i])
    if not self._gameData._gmHideUIInfo[recorder.scene] then
      self._gameData._gmHideUIInfo[recorder.scene] = {}
    end
    self._gameData._gmHideUIInfo[recorder.scene][recorder.id] = {
      record = recorder,
      display = recorder.defaultDisplay == 1
    }
  end
  self._gameData.waitResponse = {
    num = 0,
    protocols = {}
  }
  self._gameData.nextFloorId = nil
  self._gameData.curPassZoneId = nil
  self._gameData.battleResult = nil
  self._gameData.guideClickEffect = {
    count = 0,
    dialogs = {}
  }
  local activityList = {}
  local ids = CActivitySelect:GetAllIds()
  local recorder
  for i, v in ipairs(ids) do
    recorder = CActivitySelect:GetRecorder(v)
    if recorder.timeActivityID == 0 then
      table.insert(activityList, recorder)
    end
  end
  self._gameData.activityList = activityList
  self._gameData.bookActivity = nil
  self._gameData.communitycfg = nil
  self._gameData.uiSortType = {}
  self._gameData.canPreEnchantEquip = true
  self._gameData.todayLoginTag = false
  self._gameData.showBossPanelRed = false
  self._gameData.showUndecidedRoadRed = false
  self._gameData.autoExploreWithoutBackAwards = {}
  self._gameData.autoExploreWithoutBackMoney = {}
end

function DM_Game:Clear()
  self:SaveSpecialShapedScreen()
  self._gameData.mainClient = nil
  if self._gameData.myRoleInfo then
    for k, v in pairs(self._gameData.myRoleInfo) do
      self._gameData.myRoleInfo[k] = nil
    end
    self:UnInitDataBase()
  end
  self._gameData.lastFloorId = 0
  self._gameData.equipRecastTag = true
  self._gameData.phoneCodeState = {tag = nil, time = nil}
  self._gameData.mailCodeState = {tag = nil, time = nil}
  self._gameData.resourceBattleAccount = {protocol = nil}
  self._gameData.accountBag = {}
  self._gameData.getmoney = nil
  self._gameData.myRoleInfo.sysConfig = {}
  local map = self._gameData.myRoleInfo.sysConfig
  map[SysConfigEnum.music] = CS.UnityEngine.PlayerPrefs.GetInt("music")
  map[SysConfigEnum.musicNum] = CS.UnityEngine.PlayerPrefs.GetInt("musicNum")
  map[SysConfigEnum.soundEffect] = CS.UnityEngine.PlayerPrefs.GetInt("soundEffect")
  map[SysConfigEnum.soundEffectNum] = CS.UnityEngine.PlayerPrefs.GetInt("soundEffectNum")
  map[SysConfigEnum.dubbing] = CS.UnityEngine.PlayerPrefs.GetInt("dubbing")
  map[SysConfigEnum.dubbingNum] = CS.UnityEngine.PlayerPrefs.GetInt("dubbingNum")
  self._gameData.myRoleInfo.localSysConfig = {}
  local localSystemConfigMap = self._gameData.myRoleInfo.localSysConfig
  localSystemConfigMap[self.LocalSystemConfigType.EveryDayLogin] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_everyDayLogin")
  localSystemConfigMap[self.LocalSystemConfigType.SpriteFull] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_spriteFull")
  localSystemConfigMap[self.LocalSystemConfigType.ActivityExplore] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_activityExplore")
  localSystemConfigMap[self.LocalSystemConfigType.OfflineSweep] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_offlinesweep")
  NekoData.BehaviorManager.BM_Game:SetTheValueOfFPS(CS.UnityEngine.PlayerPrefs.GetInt("TheValueOfFPS", 30))
  self._gameData.resourcePanelList = nil
  self._gameData.dungeonList = nil
  self._gameData.unlockSceneList = nil
  self._gameData.fastMenuInfo = {sign = nil, info = nil}
  self._gameData.bossPanel = nil
  self._gameData.myRoleInfo.runeInfo = nil
  if self._gameData.LeiTingDataTimer then
    ServerGameTimer.RemoveTask(self._gameData.LeiTingDataTimer)
    self._gameData.LeiTingDataTimer = nil
  end
  self._gameData.LeiTingDataIsGuest = nil
  self._gameData.LeiTingDataAuth = nil
  self._gameData.LeiTingDataLeftTime = 0
  for k, v in pairs(self._gameData.unlockFunctions) do
    self._gameData.unlockFunctions[k] = nil
  end
  for k, v in pairs(self._gameData.shieldFunctions) do
    self._gameData.shieldFunctions[k] = nil
  end
  self._gameData.promptLongPressLevelUp = false
  self._gameData.resonanceTag = false
  self._gameData._gmHideUIInfo = {}
  local allIds = CGMHideUICfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CGMHideUICfg:GetRecorder(allIds[i])
    if not self._gameData._gmHideUIInfo[recorder.scene] then
      self._gameData._gmHideUIInfo[recorder.scene] = {}
    end
    self._gameData._gmHideUIInfo[recorder.scene][recorder.id] = {
      record = recorder,
      display = recorder.defaultDisplay == 1
    }
  end
  self._gameData.waitResponse.num = 0
  for k, v in pairs(self._gameData.waitResponse.protocols) do
    self._gameData.waitResponse.protocols[k] = nil
  end
  self._gameData.nextFloorId = nil
  self._gameData.curPassZoneId = nil
  self._gameData.battleResult = nil
  self._gameData.guideClickEffect.count = 0
  for k, v in pairs(self._gameData.guideClickEffect.dialogs) do
    self._gameData.guideClickEffect.dialogs[k] = nil
  end
  self._gameData.bookActivity = nil
  self._gameData.communitycfg = nil
  self._gameData.branchLineList = nil
  self._gameData._autoExploreTimes = nil
  self._gameData._autoExploreProtocol = nil
  self._gameData.isAutoFinishing = nil
  self._gameData.canPreEnchantEquip = true
  self._gameData.todayLoginTag = false
  self._gameData.showBossPanelRed = false
  self._gameData.showUndecidedRoadRed = false
  self._gameData.autoExploreWithoutBackAwards = {}
  self._gameData.autoExploreWithoutBackMoney = {}
end

function DM_Game:SetBattleEditorMode()
  self._gameData.battleeditormode = true
  self._gameData.standalonemode = false
end

function DM_Game:SetStandAloneMode()
  self._gameData.standalonemode = true
  self._gameData.battleeditormode = false
  self._gameData.isAutoFinishing = nil
end

function DM_Game:SetMyRoleInfo(data)
  self._gameData.myRoleInfo = data
  CS.UnityEngine.PlayerPrefs.SetInt("serverId", data.zoneid)
end

function DM_Game:OnSetClosedClient(client)
  self._gameData.mainClient = client
end

function DM_Game:OnSEnter(protocol)
  local mydata = {}
  mydata.userid = protocol.userInfo.userid
  mydata.isGM = protocol.userInfo.isGM
  mydata.username = protocol.userInfo.username
  mydata.userlevel = protocol.userInfo.userlevel
  mydata.userexp = protocol.userInfo.userexp
  mydata.zoneid = protocol.userInfo.serverId
  mydata.phoneNum = protocol.userInfo.phoneNum
  mydata.mailAddr = protocol.userInfo.mailAddr
  mydata.isNew = protocol.userInfo.isNew
  mydata.power = protocol.userInfo.power
  mydata.backgroundRole = protocol.userInfo.backgroundRole
  mydata.backgroundSkin = protocol.userInfo.backgroundSkin
  mydata.isGuest = protocol.userInfo.guest
  mydata.likedNum = protocol.userInfo.likedNum
  mydata.iplocaladdr = protocol.userInfo.iplocaladdr
  LogInfoFormat("DM_Game", "UserInfo.isGM(0否 1是) %s UserInfo.guest(0 游客 1 非游客) %s", protocol.userInfo.isGM, protocol.userInfo.guest)
  mydata.guides = protocol.userInfo.guides
  mydata.buffGuides = protocol.userInfo.buffGuides
  for k, v in pairs(mydata.guides) do
  end
  mydata.witchSkillGuide = self._gameData.myRoleInfo.witchSkillGuide or {}
  mydata.strengthLimit = protocol.userInfo.strengthLimit
  mydata.tips = protocol.userInfo.tips
  mydata.npcTips = protocol.userInfo.npcTips
  mydata.avatarId = protocol.userInfo.avatarId
  mydata.frameId = protocol.userInfo.frameId
  if not protocol.userInfo.introduce or protocol.userInfo.introduce == "" then
    mydata.introduce = TextManager.GetText(CStringresTable:GetRecorder(1037).msgTextID)
  else
    mydata.introduce = protocol.userInfo.introduce
  end
  mydata.sysConfig = {}
  for k, v in pairs(protocol.userInfo.configs) do
    mydata.sysConfig[k] = v
    if k == SysConfigEnum.music then
      CS.UnityEngine.PlayerPrefs.SetInt("music", v)
    elseif k == SysConfigEnum.musicNum then
      CS.UnityEngine.PlayerPrefs.SetInt("musicNum", v)
    elseif k == SysConfigEnum.soundEffect then
      CS.UnityEngine.PlayerPrefs.SetInt("soundEffect", v)
    elseif k == SysConfigEnum.soundEffectNum then
      CS.UnityEngine.PlayerPrefs.SetInt("soundEffectNum", v)
    elseif k == SysConfigEnum.dubbing then
      CS.UnityEngine.PlayerPrefs.SetInt("dubbing", v)
    elseif k == SysConfigEnum.dubbingNum then
      CS.UnityEngine.PlayerPrefs.SetInt("dubbingNum", v)
    end
  end
  mydata.localSysConfig = {}
  mydata.localSysConfig[self.LocalSystemConfigType.EveryDayLogin] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_everyDayLogin", 1)
  mydata.localSysConfig[self.LocalSystemConfigType.SpriteFull] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_spriteFull", 1)
  mydata.localSysConfig[self.LocalSystemConfigType.ActivityExplore] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_activityExplore", 1)
  mydata.localSysConfig[self.LocalSystemConfigType.OfflineSweep] = CS.UnityEngine.PlayerPrefs.GetInt("cfg_offlinesweep", 1)
  if mydata.localSysConfig[self.LocalSystemConfigType.EveryDayLogin] == 0 then
    local spiritNoticeRecorder = CNotice:GetRecorder(1)
    local timeTable = os.date("*t", os.time())
    if timeTable.hour >= 4 and timeTable.hour <= 12 then
      self._gameData.todayLoginTag = true
    end
    if timeTable.hour < 4 then
      LogInfo("DM_Game", "CancelSchedulingWorkerByType('everydaylogin')")
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.CancelSchedulingWorkerByType("everydaylogin")
      local lastTime = ((12 - timeTable.hour - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
      LogInfoFormat("DM_Game", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime)
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "everydaylogin", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime, TextManager.GetText(spiritNoticeRecorder.titleID))
    else
      LogInfo("DM_Game", "CancelSchedulingWorkerByType('everydaylogin')")
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.CancelSchedulingWorkerByType("everydaylogin")
      local lastTime = ((24 - timeTable.hour + 12 - 1) * 60 + (60 - timeTable.min - 1)) * 60 + timeTable.sec
      LogInfoFormat("DM_Game", "open the notification : scheduling everyday login worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "everydaylogin", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime)
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "everydaylogin", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), lastTime, TextManager.GetText(spiritNoticeRecorder.titleID))
    end
  end
  mydata.SpecialShapedScreenConfig = CS.PixelNeko.UI.UIManager.GetUISpecialShapedScreen()
  self:SetMyRoleInfo(mydata)
  NekoData.BehaviorManager.BM_Game:SetTheValueOfFPS(CS.UnityEngine.PlayerPrefs.GetInt("TheValueOfFPS", 30))
  self:InitDataBase()
  self:RequestDungeonRedDot()
  NekoData.BehaviorManager.BM_Game:SetVolume()
  NekoData.DataManager.DM_RedDot.Init()
end

function DM_Game:OnStartGuide(protocol)
  LogInfoFormat("DM_Game", "sstartguide guide %s", protocol.guide)
  self._gameData.myRoleInfo.guides[protocol.guide] = 0
end

function DM_Game:OnRecordGuide(protocol)
  LogInfoFormat("DM_Game", "srecordguide guide %s", protocol.guide)
  self._gameData.myRoleInfo.guides[protocol.guide] = 1
end

function DM_Game:SetGuideTag(type, tag)
  self._gameData.myRoleInfo.guides[type] = tag
  if tag == 1 then
    local csend = LuaNetManager.CreateProtocol("protocol.user.crecordguide")
    csend.guide = type
    csend:Send()
  end
end

function DM_Game:SStartBuffGuide(protocol)
  LogInfoFormat("DM_Game", "sstartbuffguide guide %s", protocol.buffType)
  self._gameData.myRoleInfo.buffGuides[protocol.buffType] = 0
end

function DM_Game:SetBuffGuideTag(type, tag)
  self._gameData.myRoleInfo.buffGuides[type] = tag
  if tag == 1 then
    local csend = LuaNetManager.CreateProtocol("protocol.user.crecordbuffguide")
    csend.buffType = type
    csend:Send()
  end
end

function DM_Game:OnSSendHeadInfo(protocol)
  self._gameData.myRoleInfo.avatarIds = {}
  self._gameData.myRoleInfo.frameIds = {}
  for k, v in pairs(protocol.avatars) do
    self._gameData.myRoleInfo.avatarIds[k] = v
  end
  for k, v in pairs(protocol.frames) do
    self._gameData.myRoleInfo.frameIds[k] = v
  end
end

function DM_Game:OnSItemConvertToFrame(protocol)
  self._gameData.myRoleInfo.frameIds[protocol.frameId] = 1
end

function DM_Game:OnSRoleConvertToAvatar(protocol)
  self._gameData.myRoleInfo.avatarIds[protocol.avatarId] = 1
end

function DM_Game:OnSSendPhoneCode(protocol)
  self._gameData.phoneCodeState = {
    tag = protocol.result,
    time = protocol.time
  }
end

function DM_Game:OnSSendMailCode(protocol)
  self._gameData.mailCodeState = {
    tag = protocol.result,
    time = protocol.time
  }
end

function DM_Game:SetSystemConfig(map)
  for k, v in pairs(map) do
    self._gameData.myRoleInfo.sysConfig[k] = v
    if k == SysConfigEnum.music then
      CS.UnityEngine.PlayerPrefs.SetInt("music", v)
    elseif k == SysConfigEnum.musicNum then
      CS.UnityEngine.PlayerPrefs.SetInt("musicNum", v)
    elseif k == SysConfigEnum.soundEffect then
      CS.UnityEngine.PlayerPrefs.SetInt("soundEffect", v)
    elseif k == SysConfigEnum.soundEffectNum then
      CS.UnityEngine.PlayerPrefs.SetInt("soundEffectNum", v)
    elseif k == SysConfigEnum.dubbing then
      CS.UnityEngine.PlayerPrefs.SetInt("dubbing", v)
    elseif k == SysConfigEnum.dubbingNum then
      CS.UnityEngine.PlayerPrefs.SetInt("dubbingNum", v)
    elseif k == SysConfigEnum.moveType then
    elseif k == SysConfigEnum.rockerType then
    end
  end
end

function DM_Game:SetLocalSystemConfig(map)
  for k, v in pairs(map) do
    self._gameData.myRoleInfo.localSysConfig[k] = v
    if k == self.LocalSystemConfigType.EveryDayLogin then
      CS.UnityEngine.PlayerPrefs.SetInt("cfg_everyDayLogin", v)
    elseif k == self.LocalSystemConfigType.SpriteFull then
      CS.UnityEngine.PlayerPrefs.SetInt("cfg_spriteFull", v)
    elseif k == self.LocalSystemConfigType.ActivityExplore then
      CS.UnityEngine.PlayerPrefs.SetInt("cfg_activityExplore", v)
    elseif k == self.LocalSystemConfigType.OfflineSweep then
      CS.UnityEngine.PlayerPrefs.SetInt("cfg_offlinesweep", v)
    end
  end
end

function DM_Game:OnSChangeSystemConfig(protocol)
end

function DM_Game:OnSCreateUser(protocol)
  self._gameData.myRoleInfo.username = protocol.username
end

function DM_Game:OnSChangeUserName(protocol)
  self._gameData.myRoleInfo.username = protocol.name
end

function DM_Game:OnSCheckPhoneCode(protocol)
  self._gameData.myRoleInfo.phoneNum = protocol.num
end

function DM_Game:OnSCheckMailCode(protocol)
  self._gameData.myRoleInfo.mailAddr = protocol.address
end

function DM_Game:OnSChangeUserIntroduce(protocol)
  self._gameData.myRoleInfo.introduce = protocol.introduce
end

function DM_Game:OnSChangeUserAvatar(protocol)
  self._gameData.myRoleInfo.avatarId = protocol.avatarId
end

function DM_Game:OnSChangeUserFrame(protocol)
  self._gameData.myRoleInfo.frameId = protocol.frameId
end

function DM_Game:OnSChangeUserLikedNum(protocol)
  self._gameData.myRoleInfo.likedNum = protocol.likedNum
end

function DM_Game:OnSEnterMainCity(protocol)
  self._gameData.lastFloorId = protocol.lastFloorId
  self._gameData.battleResult = protocol.battleResult
  self._gameData.getmoney = protocol.money
  self._gameData.accountBag = {}
  for i, v in ipairs(protocol.exploreawards) do
    table.insert(self._gameData.accountBag, v)
  end
  self._gameData.firstAward = {}
  for _, itemInfo in ipairs(protocol.firstPassAward) do
    table.insert(self._gameData.firstAward, itemInfo)
  end
  self._gameData.tip = protocol.tip
  self._gameData.dungeonType = protocol.dungeonType
end

function DM_Game:InitDataBase()
  DataCommon.SqlClientId = DataCommon.SqlClientId + 1
  local protocol = BattleClientProtocolManager.CreateProtocol("database.ccreatedatabase")
  protocol.userId = self._gameData.myRoleInfo.userid
  protocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_Game:UnInitDataBase()
  local protocol = BattleClientProtocolManager.CreateProtocol("database.cclosedatabase")
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_Game:OnSResourcePanel(userInfo)
  self._gameData.resourcePanelList = userInfo
  for i, v in ipairs(self._gameData.resourcePanelList) do
    local info
    for k, value in pairs(DataCommon.LocalTips) do
      if value.typeId and value.typeId == v.id then
        info = value
        break
      end
    end
    if info then
      local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. info.Tag, info.Default)
      if value == info.Default and not v.lock and v.open and not v.clearAll then
        CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. info.Tag, info.New)
      end
    end
  end
  local data = userInfo[1]
  if data and not data.lock and data.open then
    local list = data.detailInfo[1]
    if list and list.open and 1 < #list.stageList then
      local index
      for i, v in ipairs(list.stageList) do
        local record = ResourceStageTable:GetRecorder(v.id)
        if not v.lock and record.level <= NekoData.BehaviorManager.BM_Game:GetUserLevel() then
          index = i
        end
      end
      if 1 < index then
        local value = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.Resource_Mana.Tag, DataCommon.LocalTips.Resource_Mana.Default)
        local lastValue = CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.Resource_Mana.LastTag, DataCommon.LocalTips.Resource_Mana.Default)
        if value == DataCommon.LocalTips.Resource_Mana.Default or lastValue ~= list.stageList[index].id then
          CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.Resource_Mana.Tag, list.stageList[index].id)
          CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.LocalTips.Resource_Mana.LastTag, list.stageList[index].id)
        end
      end
    end
  end
end

function DM_Game:OnSOpenBossPanel(protocol)
  local cbossrush = BeanManager.GetTableByName("dungeonselect.cbossrush")
  local bossList = {}
  for _, v in pairs(protocol.bosses) do
    local recorder = cbossrush:GetRecorder(v.id)
    if recorder then
      local t = {
        id = v.id,
        cfg = recorder,
        info = v
      }
      bossList[#bossList + 1] = t
    end
  end
  table.sort(bossList, function(lhs, rhs)
    return lhs.cfg.sortID < rhs.cfg.sortID
  end)
  self._gameData.bossPanel = bossList
  self:CheckBossPanelRed()
end

function DM_Game:OnSResiveBossPanelStageAward(protocol)
  for _, v in pairs(self._gameData.bossPanel) do
    if v.id == protocol.id then
      table.insert(v.info.awardGot, protocol.stageId)
      break
    end
  end
  self:CheckBossPanelRed()
end

function DM_Game:OnSBossRedPoint()
  self._gameData.showBossPanelRed = true
end

function DM_Game:OnSFragmentRedPoint()
  self._gameData.showFragmentPanelRed = true
end

function DM_Game:CheckFragmentPanelRed()
  self._gameData.showFragmentPanelRed = false
  local csend = LuaNetManager.CreateProtocol("protocol.battle.ccloseshatteredredpoint")
  csend:Send()
end

function DM_Game:OnSUndecidedRoadRedPoint()
  self._gameData.showUndecidedRoadRed = true
end

function DM_Game:CheckUndecidedRoadRed()
  self._gameData.showUndecidedRoadRed = false
end

function DM_Game:CheckBossPanelRed()
  self._gameData.bossPanelRed = {}
  self._gameData.showBossPanelRed = false
  for _, v in pairs(self._gameData.bossPanel) do
    if table.nums(v.info.awardGot) < v.info.awardTotalNum then
      self._gameData.bossPanelRed[v.id] = true
      self._gameData.showBossPanelRed = true
    end
  end
end

function DM_Game:SetEquipRecastTag()
  self._gameData.equipRecastTag = false
end

function DM_Game:OnSOpenDungeonList(userInfo)
  self._gameData._dungeonProgress = {}
  local temp = {world = -1, floor = -1}
  local passFloorId = -1
  for _, world in ipairs(userInfo) do
    if world.worldId > temp.world then
      temp.world = world.worldId
    end
    for _, floor in ipairs(world.floorDetail) do
      if passFloorId == -1 then
        passFloorId = 0
      end
      local floorRecord = CDungeonSelectMainLine:GetRecorder(floor.floor)
      local tempRecord = CDungeonSelectMainLine:GetRecorder(temp.floor)
      local passRecord = CDungeonSelectMainLine:GetRecorder(passFloorId)
      local floorSort, tempSort, passSort
      if floorRecord then
        floorSort = floorRecord.sort
      else
        LogErrorFormat("dm_game", "GetRecorder in CDungeonSelectMainLine failed")
        floorSort = -1
      end
      if tempRecord then
        tempSort = tempRecord.sort
        if floorSort > tempSort then
          temp.floor = floor.floor
        end
      else
        temp.floor = floor.floor
      end
      if floor.firstGet == true then
        if passRecord then
          passSort = passRecord.sort
          if floorSort > passSort then
            passFloorId = floor.floor
          end
        else
          passFloorId = floor.floor
        end
      end
    end
  end
  self._gameData.dungeonList = userInfo
  self._gameData._dungeonProgress = temp
  self._gameData._dungeonPassProgress = passFloorId
  self._gameData.unlockSceneList = {}
  for _, value1 in pairs(self._gameData.dungeonList) do
    local world = CDungeonSelectMainLine:GetRecorder(value1.worldId)
    if world.unlockLv <= self._gameData.myRoleInfo.userlevel then
      table.insert(self._gameData.unlockSceneList, world.sceneid)
      for _, value2 in pairs(value1.floorDetail) do
        for _, value3 in pairs(value2.smallPoint) do
          table.insert(self._gameData.unlockSceneList, value3.sceneId)
        end
      end
    end
  end
end

function DM_Game:SetSpecialShapedScreenValue(value)
  self._gameData.myRoleInfo.SpecialShapedScreenConfig = value
end

function DM_Game:SaveSpecialShapedScreen()
  local value = self._gameData.myRoleInfo.SpecialShapedScreenConfig
  if value then
    LogInfoFormat("DM_Game", "UISpecialShapedScreen record int value %d", value)
    CS.UnityEngine.PlayerPrefs.SetInt("UISpecialShapedScreen", value)
  end
end

function DM_Game:SetTheValueOfFPS(fps)
  if self._gameData.myRoleInfo then
    if self._gameData.myRoleInfo.TheValueOfFPS ~= fps then
      self._gameData.myRoleInfo.TheValueOfFPS = fps
      CS.UnityEngine.PlayerPrefs.SetInt("TheValueOfFPS", fps)
      GraphicsCommand.SetTargetFrameRate(fps)
      LogInfo("FPS", "Set FPS " .. tostring(fps))
      return true
    end
  else
    LogError("DM_Game", "fps set failed, myRoleInfo hasnt been initialized")
  end
end

function DM_Game:SetFastMenuSignFromCourtyard(sign, itemTipsJumpInfo)
  self._gameData.fastMenuInfo.sign = sign
  self._gameData.fastMenuInfo.info = itemTipsJumpInfo
end

function DM_Game:OnSCompleteZone(protocol)
  self._gameData.getmoney = protocol.money
  self._gameData.accountBag = {}
  if protocol.exploreAwards then
    for i, v in ipairs(protocol.exploreAwards) do
      table.insert(self._gameData.accountBag, v)
    end
  end
  self._gameData.firstAward = {}
  if protocol.firstPassAward then
    for _, itemInfo in ipairs(protocol.firstPassAward) do
      table.insert(self._gameData.firstAward, itemInfo)
    end
  end
  self._gameData.topMessage = nil
  self._gameData.topMessage = protocol.topMessage
  self._gameData.nextFloorId = protocol.zoneId
  self._gameData.curPassZoneId = protocol.currentZone
end

function DM_Game:OnSFinishAutoExplore(protocol)
  self._gameData.autoType = protocol.dungeonType
  self._gameData.isAutoFinishing = true
  self._gameData.battleResult = protocol.battleResult
end

function DM_Game:OnSReceiveDungeonWorldAward(worldId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    if worldData.worldId == worldId then
      worldData.isReceived = 1
      break
    end
  end
end

function DM_Game:OnSReceiveDungeonPointAward(floorId)
  for _, worldData in ipairs(self._gameData.dungeonList) do
    for _, floorData in ipairs(worldData.floorDetail) do
      if floorData.floor == floorId then
        floorData.isReceived = 1
        return
      end
    end
  end
end

function DM_Game:OnSStartWitchSkillGuide(protocol)
  self._gameData.myRoleInfo.witchSkillGuide = self._gameData.myRoleInfo.witchSkillGuide or {}
  self._gameData.myRoleInfo.witchSkillGuide.guide = protocol.guide
  self._gameData.myRoleInfo.witchSkillGuide.skillIdList = protocol.skillItemIds
end

function DM_Game:RequestDungeonRedDot()
  local protocol = BattleClientProtocolManager.CreateProtocol("dungeonreddot.cgetdungeonequipreddot")
  protocol.clientId = DataCommon.SqlClientId
  LuaSqlProtocalManager:SendProtocolToRemoteThread(protocol)
end

function DM_Game:OnSRuneInfo(protocol)
  self._gameData.myRoleInfo.runeInfo = protocol
  LogInfoFormat("DM_Game", "--- state = %s, dialogId = %s ---", protocol.state, protocol.dialogId)
end

function DM_Game:OnSRune()
  self._gameData.myRoleInfo.runeInfo.state = RuneStateEnum.RUNE
  LogInfoFormat("DM_Game", "--- state = %s ---", RuneStateEnum.RUNE)
end

function DM_Game:OnSLeiTingAntiAddiction(protocol)
  self._gameData.LeiTingDataAuth = protocol.auth
  self._gameData.LeiTingDataIsGuest = protocol.isGuest
  self._gameData.LeiTingDataLeftTime = protocol.lefttime
  self._gameData.LeiTingDataTotalTime = protocol.totaltime
  if protocol.isGuest == 1 then
    if self._gameData.LeiTingDataTimer then
      ServerGameTimer.RemoveTask(self._gameData.LeiTingDataTimer)
      self._gameData.LeiTingDataTimer = nil
    end
    self._gameData.LeiTingDataTimer = GameTimer.AddTask(0, 1, function()
      self._gameData.LeiTingDataLeftTime = self._gameData.LeiTingDataLeftTime - 1
      if self._gameData.LeiTingDataLeftTime == 900 then
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(15, 6)
        if self._gameData.LeiTingDataTimer then
          ServerGameTimer.RemoveTask(self._gameData.LeiTingDataTimer)
          self._gameData.LeiTingDataTimer = nil
        end
      end
      if self._gameData.LeiTingDataLeftTime == 1800 then
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(30, 6)
        self._gameData.LeiTingDataIs30 = true
      end
    end, nil)
  elseif protocol.auth == 0 then
    if self._gameData.LeiTingDataTimer then
      ServerGameTimer.RemoveTask(self._gameData.LeiTingDataTimer)
      self._gameData.LeiTingDataTimer = nil
    end
    self._gameData.LeiTingDataTimer = GameTimer.AddTask(0, 1, function()
      self._gameData.LeiTingDataLeftTime = self._gameData.LeiTingDataLeftTime - 1
      if self._gameData.LeiTingDataLeftTime == 900 then
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(15, 5)
        if self._gameData.LeiTingDataTimer then
          ServerGameTimer.RemoveTask(self._gameData.LeiTingDataTimer)
          self._gameData.LeiTingDataTimer = nil
        end
      end
      if self._gameData.LeiTingDataLeftTime == 1800 then
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(30, 5)
        self._gameData.LeiTingDataIs30 = true
      end
    end, nil)
  elseif protocol.auth == 2 then
  end
end

function DM_Game:OnSAllUnlockFunc(protocol)
  for i, v in ipairs(protocol.funcLisk) do
    self._gameData.unlockFunctions[v.funId] = true
  end
end

function DM_Game:OnSUnlockFunc(protocol)
  for i, v in ipairs(protocol.funcLisk) do
    self._gameData.unlockFunctions[v.funId] = true
    LogInfoFormat("DM_Game", "-OnSUnlockFunc- unlockFuncId = %s ---", v.funId)
  end
end

function DM_Game:OnSShieldFunction(protocol)
  for k, v in pairs(self._gameData.shieldFunctions) do
    self._gameData.shieldFunctions[k] = nil
  end
  local str = ""
  for i, v in ipairs(protocol.shieldFunction) do
    self._gameData.shieldFunctions[v] = true
    str = str .. v .. ", "
  end
  LogInfoFormat("DM_Game", "ShieldFunction：%s", str)
end

function DM_Game:SetPromptLongPressLevelUp()
  self._gameData.promptLongPressLevelUp = true
end

function DM_Game:SetResonanceTag()
  self._gameData.resonanceTag = true
end

function DM_Game:OnSShowObtainPanel(protocol)
  self._gameData.resourceBattleAccount.protocol = protocol
end

function DM_Game:OnSPlayerLevelUp(protocol)
  self._gameData.myRoleInfo.strengthLimit = protocol.strengthLimit
end

function DM_Game:OnSResSpirit(protocol)
  self._gameData.myRoleInfo.strengthLimit = protocol.strengthLimit
end

function DM_Game:AddPlayerExp(exp)
  local allIds = CPlayerLevel:GetAllIds()
  local recorder = CPlayerLevel:GetRecorder(self._gameData.myRoleInfo.userlevel)
  local currentLevelExpMax = recorder.exp
  local maxLevel = CPlayerLevel:GetRecorder(#allIds).id
  local maxLevelMaxExp = CPlayerLevel:GetRecorder(#allIds).exp
  if self._gameData.myRoleInfo.userlevel == maxLevel and maxLevelMaxExp <= self._gameData.myRoleInfo.userexp then
    return
  end
  if currentLevelExpMax <= self._gameData.myRoleInfo.userexp + exp then
    local lv = self._gameData.myRoleInfo.userlevel
    for i = lv, #allIds do
      local max = CPlayerLevel:GetRecorder(i).exp
      if max <= self._gameData.myRoleInfo.userexp + exp then
        exp = exp - max
        if self._gameData.myRoleInfo.userlevel == maxLevel then
          self._gameData.myRoleInfo.userexp = maxLevelMaxExp
          break
        end
        self._gameData.myRoleInfo.userlevel = self._gameData.myRoleInfo.userlevel + 1
      else
        self._gameData.myRoleInfo.userexp = self._gameData.myRoleInfo.userexp + exp
        break
      end
    end
  else
    self._gameData.myRoleInfo.userexp = self._gameData.myRoleInfo.userexp + exp
  end
end

function DM_Game:OnSBookActivity(protocol)
  self._gameData.bookActivity = {
    isOpen = protocol.isOpen,
    itemNum = protocol.itemNum,
    itemId = protocol.itemId
  }
end

function DM_Game:CloseBookActivity()
  if self._gameData.bookActivity ~= nil then
    self._gameData.bookActivity.isOpen = 0
  end
end

function DM_Game:OnSOpenSideQuestPanel(userInfo)
  self._gameData.branchLineList = userInfo
end

function DM_Game:OnSUpdateSideQuestDungeon(dungeons)
  self._gameData.branchLineList[dungeons.DungeonID] = dungeons
end

function DM_Game:OnSUpdateUISortType(protocol)
  local OrderType = {Ascending = 1, Descending = 2}
  for uiType, sortNumValue in pairs(protocol.uiSortTypes) do
    local ascending = true
    if sortNumValue % 10 == 2 then
      ascending = false
    end
    self._gameData.uiSortType[uiType] = {
      nameTxtId = sortNumValue // 10,
      isAscending = ascending
    }
  end
end

function DM_Game:RecorderUISortType(sortedType, nameTxtId, isAscending)
  self._gameData.uiSortType[sortedType] = {nameTxtId = nameTxtId, isAscending = isAscending}
end

function DM_Game:SetAutoExploreTimes(autoExploreTimes)
  self._gameData._autoExploreTimes = autoExploreTimes
end

function DM_Game:OnAutoExploreFinishiOnce()
  if self._gameData._autoExploreTimes then
    self._gameData._autoExploreTimes.current = self._gameData._autoExploreTimes.current + 1
  end
end

function DM_Game:SetAutoExploreProtocol(autoExploreProtocol)
  self._gameData._autoExploreProtocol = autoExploreProtocol
end

function DM_Game:ClearAutoExploreData()
  self._gameData._autoExploreTimes = nil
  self._gameData._autoExploreProtocol = nil
  self._gameData.isAutoFinishing = nil
end

function DM_Game:SetCurrentCardPoolID(id)
  self._gameData._currentCardPoolID = id
end

function DM_Game:ClearCurrentCardPoolID()
  self._gameData._currentCardPoolID = nil
end

function DM_Game:SetCanPreEnchantEquip(canPreEnchantEquip)
  self._gameData.canPreEnchantEquip = canPreEnchantEquip
end

function DM_Game:SetTodayLoginTag(flag)
  self._gameData.todayLoginTag = flag
end

function DM_Game:SetIfHaveAskForNotificationPermission(flag)
  CS.UnityEngine.PlayerPrefs.SetInt("IfHaveAskForNotificationPermission", flag)
end

function DM_Game:OnSChooseBackground(protocol)
  self._gameData.myRoleInfo.backgroundRole = protocol.roleId
  self._gameData.myRoleInfo.backgroundSkin = protocol.skin
end

function DM_Game:ClearLastDungeonType()
  self._gameData.dungeonType = nil
end

function DM_Game:ClearFirstAward()
  self._gameData.firstAward = {}
end

function DM_Game:ClearTip()
  self._gameData.tip = 0
end

function DM_Game:ClearLastAutoDungeonType()
  self._gameData.autoType = nil
end

function DM_Game:OnSFinishAutoExploreWithoutBack(protocol)
  self._gameData.autoExploreWithoutBackAwards = protocol.exploreawards
  self._gameData.autoExploreWithoutBackMoney = protocol.money
end

function DM_Game:ClearExploreWithoutBackAwards()
  self._gameData.autoExploreWithoutBackAwards = {}
  self._gameData.autoExploreWithoutBackMoney = {}
end

return DM_Game
