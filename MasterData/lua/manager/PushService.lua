local WU, DB = require("Common/WindowUtil")()
local S = require("Common/Singleton"):Register(_ENV, "PushService")
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local FU = require("Common/FriendUtil")
local RU = require("Common/RedMarkUtil")
local CU = require("Common/ChatUtil")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local CO = require("Common/Coroutine")
local HU = require("Common/HtmlUtil")
local TU = require("Common/TaskUtil")
local MU = require("Common/MailUtil")
local DU = require("Common/DungeonUtil")
local ACU = require("Common/ActivityUtil")
local TPU = require("Common/TopPvpUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_handler = {}
local m_loginData, m_loginCallback, m_loginTimeout
local m_hasEnterCity = false
local m_guildFunctionCoro

function LoginPushBegin(loginData, callback)
  m_loginData = loginData
  m_loginCallback = callback
  m_hasEnterCity = false
  CS.Restifizer.RestifizerManager.Instance:RegisterWebSocketKickCallback(CS.Restifizer.WebSocketTag.PushService, OnWebSocketKick)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScMatchNtf", OnRoomMatched)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScWorldChatSubChannel", onWorldChatSubChannel)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScLoginBegin", OnScLoginBegin)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScLoginTutorial", OnScLoginTutorial)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "DBGamePlayer.Actors", OnActors)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "DBGamePlayer.EquipPackage", OnEquips)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "DBGamePlayer.ItemPackage", OnItems)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "DBGamePlayer.WeaponPackage", OnWeapons)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScLoginEnd", OnScLoginEnd)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScMaasRemind", OnScMaasRemind)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScMails", MU.OnMails)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScZk", OnScZk)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScTasksChange", OnScTasksChange)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScUniqueWeaponAddNew", onScUniqueWeaponAddNew)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "BasePushMessage", OnBasePushMessage)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "WorldMessage", onWolrdMessage)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScClientError", onErrorCode)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ClearMessage", onClearMessage)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScTempEntranceSwitchInfo", onScTempEntranceSwitchInfo)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScServerUpdateTimeInfo", OnScServerUpdateTimeInfo)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ActorCultivationInfoMessage", OnActorCultivationInfo)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScTSSAntiData", onScTSSAntiData)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScFriendPvpInvite", OnScFriendPvpInvite)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScFriendPvpMatch", OnScFriendPvpMatch)
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScSurpriseEvent", onScSurpriseEvent)
  this:WebSocketSendLua(CS.Restifizer.WebSocketTag.PushService, "CsLogin", m_loginData)
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
  ClearLoginTimeout()
  m_loginTimeout = this:DelayInvokeInSeconds(20, function()
    FinishScLoginEnd(false)
  end)
end

function ClearLoginTimeout()
  if m_loginTimeout ~= nil then
    this:StopCoroutine(m_loginTimeout)
    m_loginTimeout = nil
  end
end

function OnScFriendPvpMatch(res)
  TPU.DealScFriendPvpMatch(res)
end

function OnScFriendPvpInvite(res)
  TPU.DealScFriendPvpInvite(res)
end

function OnScLoginEnd(pushData)
  ClearLoginTimeout()
  local accountCache = this:GetData("accountCache")
  local deviceType = S:Get("ConfigDataManager").DeviceType()
  local accountSwitch = this:GetData("AccountSwitch")
  local userInfo = {}
  userInfo.UserID = accountCache.openId
  userInfo.NickName = pushData.baseInfo.name
  userInfo.Region = fif(accountSwitch.qqLoginSwitch, "qq", fif(accountSwitch.wxLoginSwitch, "wx", "guest"))
  userInfo.accountType = fif(accountSwitch.qqLoginSwitch, 1, fif(accountSwitch.wxLoginSwitch, 2, 3))
  userInfo.Gender = pushData.baseInfo.sex
  userInfo.Age = -1
  userInfo.Level = pushData.baseInfo.level
  WU.RecordLogin(userInfo)
  this:SetData("ChannelsInfo", pushData.channels)
  this:GameRequest("fci/login/"):Post(nil, function(result)
    this:SetData("fci/baseinfo/", pushData.baseInfo)
    this:SetData("fci/baseresource/", pushData.baseResource)
    this:Bind("fci/baseresource/", OnBaseResourceChange)
    this:SetData("cityScene", pushData.baseInfo.homeBackGround.current)
    this:SetData("cityBGM", pushData.baseInfo.homeBackGround.bgm)
    this:SetData("CollectionsScene/isRandomMode", pushData.baseInfo.homeBackGround.isRandom)
    this:BindRemote(DB:GameRequest("fci/guild-player/"):SyncInput(false), OnGuildPlayerChange)
    S:Get("RestifizerManager").DoEnteringRequests()
    this:GameRequest("fci/dungeon/chapter"):Get(function(resp)
      if resp then
        local chapterInfos = {}
        local chapterRecords = resp.record.chapterRecord
        local dungeonRecords = resp.record.dungeonRecord
        for k, v in pairs(chapterRecords) do
          local record = {
            recordChapter = v,
            recordDungeons = {}
          }
          local chapterInfo = PB.get("ChapterInfo", k)
          if chapterInfo == nil then
            warning("ChapterInfo.xlsx", "Can't find id " .. tostring(k))
          else
            local dungeonIds = chapterInfo.dungeonId
            for i = 1, #dungeonIds do
              local dungeonId = dungeonIds[i]
              record.recordDungeons[dungeonId] = dungeonRecords[dungeonId]
            end
            chapterInfos[k] = record
          end
        end
        for k, v in pairs(chapterInfos) do
          this:SetData("fci/dungeon/chapter/" .. k, v)
        end
        this:SetData("fci/dungeon/chapter-summary", resp.summary)
        FinishScLoginEnd(true)
      end
    end)
  end, function()
    FinishScLoginEnd(false)
  end)
end

function FinishScLoginEnd(succeed)
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
  if m_loginCallback ~= nil then
    m_loginCallback(succeed)
    m_loginCallback = nil
  end
  m_hasEnterCity = true
end

function OnScMaasRemind(res)
  this:BroadcastGameEvent("OnScMaasRemind", res)
end

function OnScZk(msg)
  this:BroadcastGameEvent("OnScZk", msg)
end

function OnWebSocketKick(webSocket)
  local reason = webSocket.DisconnectReason
  if reason == PB.enum.ErrorMessageBox.Error_KickReason_NeedLoginAgain then
    info("WebSocket", "Silent re-login: " .. tostring(reason))
    CS.DataBindingManager.Instance:ResetRemoteRequestTags()
    LoginPushBegin(m_loginData, function(succeed)
      if succeed then
        DU.CreateResetList()
        DU.ResetFlagExitGame()
        local cur_scene = WU.CurrentScene()
        if cur_scene ~= "SceneCity" then
          WU.ShowMessageOK(WU.GetString("System_Reconnect"), function()
            local to_city = false
            if cur_scene == "SceneCartoon" then
              CS.CartoonManager.Instance:StopCartoon(false)
              to_city = true
            elseif cur_scene == "SceneBalance" then
              to_city = true
            elseif cur_scene == "SceneFight" then
              if CS.FightBase.Instance ~= nil then
                CS.FightBase.Instance:LeaveGameLua("SceneCity")
              else
                to_city = true
              end
            end
            if to_city then
              WU.ReturnCity("")
            end
          end)
        end
      else
        SilentLoginFailed(webSocket)
      end
    end)
  else
    SilentLoginFailed(webSocket)
  end
end

function SilentLoginFailed(webSocket)
  local message = ""
  if webSocket.BanReason ~= nil and webSocket.BanReason ~= "" then
    message = webSocket.BanReason .. "\n" .. WU.GetString("Error_UnBanTime", WU.RenderTime2(webSocket.BanTime, false, false, true))
  else
    message = WU.GetString(PB.enum.ErrorMessageBox.__keys[webSocket.DisconnectReason])
  end
  WU.ShowMessageOK(message, function()
    CS.GameGlobal.Instance:ResetGame()
  end)
end

function OnScLoginBegin(pushData)
  local accountCache = this:GetData("accountCache")
  this:SetData("openId", accountCache.openId)
  this:SetData("playerId", pushData.playerId)
  this:SetData("socialPicture", pushData.socialPicture)
  this:SetData("loginTime", pushData.timeMsServer)
  CS.GameTime.serverTimeZoneToUtcOffset = pushData.utcOffsetSeconds
  CS.BuglyAgent.SetUserId(tostring(pushData.playerId))
  S:Get("IAPHandler").SyncMidas()
  local accountType = CS.TssSdk.EENTRYID.ENTRY_ID_QZONE
  local appId = ""
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    accountType = CS.TssSdk.EENTRYID.ENTRY_ID_QZONE
    appId = "1106429722"
  end
  if accountCache.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    accountType = CS.TssSdk.EENTRYID.ENTRY_ID_MM
    appId = "wx687f4629ba7c3086"
  end
  CS.TssSdk.TssSdkSetUserInfoEx(accountType, accountCache.socialEntry, appId, U.ToInt(this:GetData("worldId")), tostring(this:GetData("playerId")))
  CO.coroutine_call(function()
    local delay = CS.UnityEngine.WaitForSeconds(math.max(this:GetData("TssReportInterval") or 5, 5))
    while true do
      if m_hasEnterCity and CS.Restifizer.RestifizerManager.Instance ~= nil then
        CS.Restifizer.RestifizerManager.Instance:MTPSend()
        delay = CS.UnityEngine.WaitForSeconds(math.max(this:GetData("TssReportInterval") or 5, 5))
      end
      CO.yield_return(delay)
    end
  end, this)()
end

function onScTSSAntiData(message)
  if CS.Restifizer.RestifizerManager.Instance ~= nil then
    CS.Restifizer.RestifizerManager.Instance:OnMTPReceived(message.data)
  end
end

function OnScLoginTutorial(pushData)
  this:SetData("fci/tutorial/", pushData.tutorialInfo)
end

function OnActors(pushData)
  this:SetData("fci/actor/", pushData.playerActors)
  local unlockedSkins = {
    [0] = true
  }
  for i = 1, #pushData.unlockedSkins do
    unlockedSkins[pushData.unlockedSkins[i]] = true
  end
  this:SetData("fci/unlockedSkins/", unlockedSkins)
  local newSkins = {}
  for i = 1, #pushData.newSkins do
    newSkins[pushData.newSkins[i]] = true
  end
  this:SetData("fci/newSkins/", newSkins)
  for _, actor in pairs(pushData.playerActors) do
    DBH.AppendActorInfo(actor)
    this:SetData("fci/actor/" .. actor.uid, actor)
  end
end

function OnEquips(pushData)
  this:SetData("fci/equip/", pushData.equips)
  for _, equip in pairs(pushData.equips) do
    DBH.AppendEquipInfo(equip)
    this:SetData("fci/equip/" .. equip.uid, equip)
  end
end

function OnItems(pushData)
  local itemInfoList = PB.all("ItemInfo")
  for k, itemInfo in pairs(itemInfoList) do
    this:SetData("fci/item/" .. itemInfo.id, {
      id = itemInfo.id,
      gotTime = 0,
      count = 0
    })
  end
  for i = #pushData.items, 1, -1 do
    local item = pushData.items[i]
    if DBH.AppendItemInfo(item) then
      this:SetData("fci/item/" .. item.id, item)
    else
      table.remove(pushData.items, i)
    end
  end
  this:SetData("fci/item/", pushData.items)
end

function OnWeapons(pushData)
  local armArr = _ENV["!"](pushData.weapons):toarray()
  for i = #armArr, 1, -1 do
    local weapon = armArr[i]
    if DBH.AppendArmInfo(weapon) then
      this:SetData("fci/arms/" .. weapon.id, weapon)
    else
      table.remove(armArr, i)
    end
  end
  table.sort(armArr, function(a, b)
    return a.id < b.id
  end)
  this:SetData("fci/arms/", armArr)
end

function OnScTasksChange(pushData)
  DB:SetData("ActorCultivation/PlayTween", false)
  TU.InitData(pushData)
end

function OnBaseResourceChange(baseResource)
  if baseResource then
    for _, baseRes in pairs(baseResource) do
      local enumStr = PB.enum.ResourceType.__keys[baseRes.type]
      if enumStr then
        this:SetData("fci/resource/" .. enumStr .. "_" .. baseRes.id, baseRes.count)
      else
        error("Resitifizer", "PB.enum.ResourceType error , Can't find resType " .. baseRes.type)
      end
    end
  end
end

function onWorldChatSubChannel(channelInfo)
  if table.empty(channelInfo) then
    return
  end
  local lastChannel = DB:GetData("ChatRoom/WorldSubChannel")
  DB:SetData("ChatRoom/WorldSubChannelLimit", channelInfo.totalChannel)
  DB:SetData("ChatRoom/WorldSubChannel", channelInfo.channel)
  local message = {
    content = WU.GetString("Window_SwitchSubChannel", channelInfo.channel)
  }
  if lastChannel ~= channelInfo.channel then
    CU.AddChannelSwitchMsg({message})
  end
end

function onErrorCode(error)
  if error.isBox then
    WU.ShowMessageOK(WU.GetString(error.code))
  else
    WU.ShowHintText(WU.GetString(error.code))
  end
end

function onWolrdMessage(worldMessage)
  CU.HandlerChatMessages(worldMessage)
end

function OnBasePushMessage(pushMessage)
  local push_key = PB.enum.PushType.__keys[pushMessage.pushType]
  local func = m_handler[push_key]
  info("PushService", "type:" .. push_key .. " params:" .. table.dump(pushMessage.params))
  if func ~= nil then
    func(table.unpack(fif(pushMessage.binary, pushMessage.binaryParams, pushMessage.params)))
  else
    warning("PushService", "Unhandled push service: " .. push_key)
  end
end

function OnGuildPlayerChange(guildPlayer)
  if guildPlayer then
    local preGuildId = this:GetData("guildId")
    this:SetData("guildId", guildPlayer.guildId)
    for k, v in pairs(guildPlayer.rentedActors) do
      v.actor.isGuildActor = true
      v.actor.posEquip = v.posEquip
    end
    if guildPlayer.guildId ~= 0 then
      if preGuildId ~= guildPlayer.guildId then
        m_handler.GuildChange()
        if m_guildFunctionCoro then
          this:StopCoroutine(m_guildFunctionCoro)
          m_guildFunctionCoro = nil
        end
        local delaySeconds = math.max(0, guildPlayer.limitEndTime - CS.GameTime.serverUtc)
        if 0 < delaySeconds then
          m_guildFunctionCoro = this:DelayInvokeInSeconds(delaySeconds, function()
            DB:SyncRemote(DB:GameRequest("fci/profit/"):SyncInput(false))
            m_guildFunctionCoro = nil
          end)
        end
      end
      this:SetData("fci/guild-player/invited/", nil)
    else
      if m_guildFunctionCoro then
        this:StopCoroutine(m_guildFunctionCoro)
        m_guildFunctionCoro = nil
      end
      this:SetData("fci/guild/", nil)
      this:SetData("fci/guild/members/", nil)
      this:SetData("fci/guild/pending-members/", nil)
      this:SetData("fci/guild/skill/", nil)
      this:SetData("fci/guild/vote/", nil)
      this:SetData("fci/guild/donate/", nil)
      GU.UpdateGuildDungeonRedPoint(true)
      DB:SyncRemote(DB:GameRequest("fci/guild-player/invited/"):SyncInput(false))
    end
  end
  local guildPendingMembers = this:GetData("fci/guild/pending-members/")
  RU.SetRedMark("Relation/Guild/Pending", guildPendingMembers and 0 < #guildPendingMembers and GU.IsGuildManager())
end

function OnScServerUpdateTimeInfo(pushData)
  this:SetData("ServerUpdateTimeInfo", pushData.timeInfo)
  info("timeInfo", table.dump(pushData.timeInfo))
  this:BroadcastGameEvent("ResetNotification")
end

function m_handler.RelationAppyListNew()
  DB:GameRequest("fci/applylist"):Get(function(resp)
    DB:SetData("fci/applylist", resp)
  end)
end

function m_handler.RelationAppyListDelete(target)
  DB:HandleRemoteDeleted("fci/applylist/" .. target)
end

function m_handler.RelationFriendListNew(target)
  FU.RemoveLatestTalkTarget(target)
  FU.RemoveFromRecommendlist(target)
  DB:HandleRemoteChanged("fci/friendlist/" .. target)
  FU.MarkNewFriend(true)
end

function m_handler.RelationFriendListDelete(target)
  DB:HandleRemoteDeleted("fci/friendlist/" .. target)
end

function m_handler.RelationFriendLoginOrLogout(target, status)
  FU.HandlerFriendInfoChanged(target, {
    lastLogoutTime = tonumber(status)
  })
end

function m_handler.RelationFriendInfoChanged(playerId, name, level, socialPicture, guildId)
  FU.HandlerFriendInfoChanged(playerId, {
    name = name,
    level = tonumber(level),
    guildId = tonumber(guildId),
    socialPicture = socialPicture
  })
end

function m_handler.GuildMessage(senderId, sender, content, time, headPhoto, headFrame, socialPicture)
  local msg = {
    content = content,
    senderId = senderId,
    sender = sender,
    time = tonumber(time),
    headPhoto = tonumber(headPhoto),
    headFrame = tonumber(headFrame),
    socialPicture = socialPicture
  }
  CU.HandlerNewMsg(msg, 2)
end

function m_handler.GuildSystemMessage(content)
  local msg = {
    content = content,
    time = CS.GameTime.serverUtc
  }
  CU.HandlerNewMsg(msg, 3)
end

function m_handler.ChipExchangePosRefresh()
  S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
    if activity == nil then
      return
    end
    DU.IsDungeonUnlocked(this:GetData("fci/dungeon/chapter-summary"), 5102, function(unlocked)
      local dungeonUnlock = unlocked
      local status = ACU.GetStatus(activity[1])
      if status == PB.enum.ActivityStatus.None then
        return
      end
      if status == PB.enum.ActivityStatus.Finished or status == PB.enum.ActivityStatus.Close or not dungeonUnlock then
        this:BroadcastGameEvent("UpdateChapterRewardSlot")
        return
      end
      RU.SetRedMark("Welfare/ActorChipExchange", true)
      DB:GameRequest("fci/chipexchange/"):Get(function(resp)
        this:SetData("fci/chipexchange/", resp)
        if status == PB.enum.ActivityStatus.PreHeat then
          RU.SetRedMark("Welfare/ActorChipExchange", #resp.settlePosInfo <= 0)
        else
          RU.SetRedMark("Welfare/ActorChipExchange", true)
        end
      end)
    end)
  end)
end

function m_handler.GuildRecordChange()
  RU.SetRedMark("Relation/Guild/Message/Record", true)
end

function m_handler.PlayerGuildScoreChange(memberScoreRecord)
  warning("PlayerGuildScore", tostring(memberScoreRecord))
  local guildPlayer = this:GetData("fci/guild-player/")
  if guildPlayer then
    guildPlayer.guildScoreRecord = tonumber(memberScoreRecord)
    this:SetData("fci/guild-player/", guildPlayer)
  end
end

function m_handler.GuildScoreChange(score, memberId, memberScoreRecord)
  local guild = this:GetData("fci/guild/")
  if guild then
    guild.score = tonumber(score)
    this:SetData("fci/guild/", guild)
  end
  local guildMembers = this:GetData("fci/guild/members/")
  if guildMembers then
    for _, member in pairs(guildMembers) do
      if member.playerId == memberId then
        member.guildScoreRecord = tonumber(memberScoreRecord)
      end
    end
  end
  if this:GetData("playerId") == memberId then
    local guildPlayer = this:GetData("fci/guild-player/")
    if guildPlayer then
      guildPlayer.guildScoreRecord = tonumber(memberScoreRecord)
      this:SetData("fci/guild-player/", guildPlayer)
    end
  end
end

function m_handler.GuildExpChange(guildId, guildLevel, guildExp)
  local guild = this:GetData("fci/guild/")
  if guild and guild.id == tonumber(guildId) then
    guild.level = tonumber(guildLevel)
    guild.exp = tonumber(guildExp)
    this:SetData("fci/guild/", guild)
  end
end

function m_handler.GuildSkillChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/skill/"):SyncInput(false):Get(OnGuildSkillChange)
  end
end

function OnGuildSkillChange(guildSkills)
  this:SetData("fci/guild/skill/", guildSkills)
end

function m_handler.GuildDonateListChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    this:GameRequest("fci/guild/{guildId}/donate/"):SyncInput(false):Get(OnGuildDonateChange)
  end
end

function OnGuildDonateChange(guildDonate)
  this:SetData("fci/guild/donate/", guildDonate)
end

function m_handler.NewPrivateMsg(senderId, sender, content, time, headPhoto, headFrame, socialPicture)
  local msg = {
    content = content,
    senderId = senderId,
    sender = sender,
    time = tonumber(time),
    headPhoto = tonumber(headPhoto),
    headFrame = tonumber(headFrame),
    socialPicture = socialPicture
  }
  CU.HandlerNewMsg(msg, 1)
end

function m_handler.SignboardChange(signboardId)
  local data = this:GetData("BoardActor/AllUnlocked")
  if data ~= nil then
    table.insert(data, U.ToInt(signboardId))
    this:SetData("BoardActor/AllUnlocked", data)
  end
end

function m_handler.BaseResChange()
  DB:HandleRemoteChanged("fci/baseresource/")
  DB:BroadcastGameEvent("BaseResChanged")
end

function m_handler.BaseInfoChange()
  DB:HandleRemoteChanged("fci/baseinfo/")
end

function m_handler.NewPlayerSignInChange()
  local config = PB.all("WelfareConfig")
  local welfareId = table.find(config, function(_, v)
    return v.relatedActivityType == PB.enum.ActivityType.NewPlayerSignIn
  end)
  this:GameRequest(string.format("fci/NewPlayerSignIn/%d/", config[welfareId].relatedActivityIds[1])):Get(function(result)
    local data = result.signInfo
    local maxLoginDayNum = #PB.all("NewPlayerSignReward")
    data.rewardDays = math.min(data.rewardDays, maxLoginDayNum)
    data.signDays = math.min(data.signDays, maxLoginDayNum)
    this:SetData("fci/NewPlayerSignIn/", data)
  end)
end

function m_handler.ItemChange(itemId)
  DB:HandleRemoteChanged("fci/item/" .. itemId)
end

function m_handler.ActorNew(uid)
  DB:HandleRemoteChanged("fci/actor/" .. uid)
  DB:BroadcastGameEvent("ActorNew")
end

function m_handler.ActorChange(uid)
  DB:HandleRemoteChanged("fci/actor/" .. uid)
end

function m_handler.ActorDelete(actorId)
  DB:HandleRemoteDeleted("fci/actor/" .. actorId)
  DB:BroadcastGameEvent("ActorRemoved")
end

function m_handler.ActorChangeAll()
  DB:HandleRemoteDeleted("fci/SelectedGroupId/StoryMode/")
  DB:HandleRemoteDeleted("fci/SelectedGroupId/ChallengeMode/")
  DB:HandleRemoteDeleted("fci/ActorGroup/")
  local actors = this:GetData("fci/actor")
  for _, actor in pairs(actors) do
    this:SetData("fci/actor/" .. actor.uid, nil)
  end
  this:SetData("fci/actor", {})
end

function m_handler.EquipNew(uid)
  DB:HandleRemoteChanged("fci/equip/" .. uid)
  this:BroadcastGameEvent("EquipNew")
end

function m_handler.EquipChange(uid)
  DB:HandleRemoteChanged("fci/equip/" .. uid)
end

function m_handler.EquipDelete(equipId)
  DB:HandleRemoteDeleted("fci/equip/" .. equipId)
end

function m_handler.BattleRoomInfoChange()
  this:BroadcastGameEvent("OnBattleActorChange")
end

function m_handler.BattleInstanceStart()
  this:BroadcastGameEvent("OnBattleInstanceStart")
end

function m_handler.FightActiveDataChange()
end

function m_handler.ExtremeChallengeRefresh()
end

function OnRoomMatched(message)
  if message.dungeonInfo.dungeonType == PB.enum.DungeonType.TopPVP or message.dungeonInfo.dungeonType == PB.enum.DungeonType.RelaxedPVP then
    local ui = WU.FindWindow("TopPvpJoin")
    if ui and ui.gameObject.activeSelf then
      _ENV["$"](ui)["$$OnRoomMatched"](message)
    else
      TPU.EnterFight(message)
    end
  elseif message.dungeonInfo.dungeonType == PB.enum.DungeonType.FriendPvp then
    this:BroadcastGameEvent("OnRoomMatchedNotify", message)
    TPU.EnterFight(message)
  end
end

function m_handler.ShareInfoChange()
  DB:HandleRemoteChanged("fci/share", true)
end

function m_handler.ShopRefreshed(shopId)
  this:SetData("fci/Shop/" .. shopId .. "/Goods/", nil)
  this:BindRemote(DB:GameRequest("fci/Shop/" .. shopId .. "/Goods/"), function(goods)
  end)
end

function m_handler.AchievementChange()
  DB:HandleRemoteChanged("fci/achievement/", true)
end

function m_handler.AchievementDone(achievementId)
  RU.SetRedMark("Journey/Achievement", true)
  WU.UnlockAchievement(achievementId)
end

function m_handler.GachaCountRefresh()
  DB:HandleRemoteChanged("fci/gachainfo/", true)
end

function m_handler.GuildPlayerChange()
  DB:SyncRemote(DB:GameRequest("fci/guild-player/"):SyncInput(false))
end

function m_handler.GuildChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/"):SyncInput(false):Get(OnGuildChange)
  end
end

function m_handler.GuildDungeonRedPointRefresh()
  local guildId = this:GetData("guildId")
  if guildId == nil or guildId == 0 then
    return
  end
  local start, open = GU.IsGuildDungeonOn()
  if open then
    warning("A DungeonGuild Red Refresh Get And Activity Open")
    local summaryPath = "fci/guild-dungeon/v2/summary/" .. guildId
    this:GameRequest(summaryPath):Get(function(res)
      GU.HandleGuildDungeonSummary(res)
      this:SetData("DungeonGuild/Summary", res)
      GU.UpdateGuildDungeonRedPoint()
    end)
  else
    GU.UpdateGuildDungeonRedPoint(true)
  end
end

function OnGuildChange(guild)
  this:SetData("fci/guild/", guild.baseInfo)
  OnGuildMembersChange(guild.members)
  OnGuildPendingMembersChange(guild.pendingMembers)
  OnGuildInvitedMembersChange(guild.invitedMembers)
  OnGuildSkillChange(guild.skills)
  OnGuildVoteChange(guild.voteInfo)
  OnGuildDonateChange(guild.donateInfo)
end

function m_handler.GuildVoteChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/vote/"):SyncInput(false):Get(OnGuildVoteChange)
  end
end

function OnGuildVoteChange(guildVote)
  this:SetData("fci/guild/vote/", guildVote)
end

function m_handler.GuildMemberChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/members/"):SyncInput(false):Get(OnGuildMembersChange)
  end
end

function OnGuildMembersChange(guildMembers)
  this:SetData("fci/guild/members/", guildMembers)
end

function m_handler.GuildInvitationChange()
  DB:SyncRemote(DB:GameRequest("fci/guild-player/invited/"):SyncInput(false))
end

function m_handler.GuildPendingMemberChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/pending-members/"):SyncInput(false):Get(OnGuildPendingMembersChange)
  end
end

function OnGuildPendingMembersChange(guildPendingMembers)
  if guildPendingMembers then
    this:SetData("fci/guild/pending-members/", guildPendingMembers)
  end
  RU.SetRedMark("Relation/Guild/Pending", guildPendingMembers and 0 < #guildPendingMembers and GU.IsGuildManager())
end

function m_handler.GuildInvitedMemberChange()
  local guildId = this:GetData("guildId")
  if guildId and 0 < guildId then
    DB:GameRequest("fci/guild/{guildId}/invited-members/"):SyncInput(false):Get(OnGuildInvitedMembersChange)
  end
end

function OnGuildInvitedMembersChange(guildInvitedMembers)
  if guildInvitedMembers then
    this:SetData("fci/guild/invited-members/", guildInvitedMembers)
  end
end

function m_handler.TowerRefreshed()
  DB:HandleRemoteChanged("fci/tower/summary/", true)
  DB:HandleRemoteChanged("fci/tower/actorgroup/", true)
  DB:HandleRemoteChanged("fci/tower/actorgroup-confirm/", true)
end

function m_handler.AsyncPvpDailyRefresh()
  this:GameRequest("fci/asyncpvprecord/"):Get(function(response)
    this:SetData("fci/asyncpvprecord/", response)
    this:BroadcastGameEvent("AsyncPvpDailyRefresh")
  end)
end

function m_handler.SigninInfoChange()
  DB:SyncRemote(DB:GameRequest("fci/signin/"))
end

function m_handler.DeployMissionChanged()
  DB:HandleRemoteChanged("fci/deploy/mission/", true)
end

function m_handler.DeployMissionEnd()
  RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.DeployMission), true)
end

function m_handler.PurchaseBuyRecord(...)
  this:BroadcastGameEvent("PushTypePurchaseBuyRecord", {
    ...
  })
end

function m_handler.RacePVPMatchFail(...)
  this:BroadcastGameEvent("RacePVPMatchFail")
end

function m_handler.BurstLinkMatchFail(...)
  this:BroadcastGameEvent("BurstLinkMatchFail")
end

function m_handler.FightSvrErr()
  this:BroadcastGameEvent("FightSvrErr")
end

function m_handler.MedalChange(...)
  local params = {
    ...
  }
  local all = this:GetData("fci/medal/")
  if all == nil then
    return
  end
  for i, id in pairs(params) do
    this:GameRequest("fci/medal/" .. id):Get(function(result)
      local index, _ = _ENV["!"](all):find(function(k, v)
        return v.id == tonumber(id)
      end)
      if result == nil or result.id == nil then
        table.remove(all, index)
      elseif index ~= nil then
        all[index] = result
      else
        table.insert(all, result)
      end
      if i == #params then
        this:SetData("fci/medal/", all)
      end
    end)
  end
end

function m_handler.NotePadUnlockRole(roleId)
  DB:HandleRemoteChanged("fci/RoleNotePad/" .. roleId)
end

function m_handler.PurchaseGoodsNew(goodsId)
  this:BroadcastGameEvent("HandlePurchaseGoodsNew", goodsId)
end

function m_handler.GetCommandGiftSuccess()
  WU.ShowHintText(WU.GetString("WindowChat_GetCommandGiftSuccess"))
end

function m_handler.MessageBox(text)
  WU.ShowMessageOK(text)
end

function m_handler.ProfitChange()
  DB:HandleRemoteChanged("fci/profit/")
end

function m_handler.RolePresent(presentId)
  DB:SyncRemote(DB:GameRequest("fci/RolePresent/"):SyncInput(false))
end

function m_handler.DunDoneTimesRefresh()
  local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
  if chapterSummary and chapterSummary.unlockedChapterId then
    local chapterIds = chapterSummary.unlockedChapterId
    for i = 1, #chapterIds do
      local chapter = this:GetData("fci/dungeon/chapter/" .. chapterIds[i])
      if chapter then
        for k, v in pairs(chapter.recordDungeons) do
          v.doneTimes = 0
        end
        this:SetData("fci/dungeon/chapter/" .. chapterIds[i], chapter)
      end
    end
  end
  this:GameRequest("fci/event-dungeon/record/"):Get(function(result)
    this:SetData("fci/event-dungeon/record/", result)
  end)
end

function m_handler.RelationPointRedPoint()
  RU.SetRedMark("Relation/Friend/RelationPoint", true)
end

function onClearMessage(clearMessage)
  if clearMessage ~= nil then
    info("Chat", " recieve onClearMessage playerId : " .. tostring(clearMessage.senderId))
    local playerId = clearMessage.senderId
    local worldCache = this:GetData("ChatRoom/ChatContentWorld") or {}
    for i = #worldCache, 1, -1 do
      if worldCache[i].senderId == playerId then
        table.remove(worldCache, i)
      end
    end
    local guildCache = this:GetData("GuildMsg") or {}
    for i = #guildCache, 1, -1 do
      if guildCache[i].senderId == playerId then
        table.remove(guildCache, i)
      end
    end
    if playerId ~= this:GetData("playerId") then
      this:SetData("ChatRoom/PrivateMsg/" .. playerId, nil)
    else
      local targets = this:GetData("LatestChatTargets")
      for i = 1, #targets do
        local playerId = targets[i].senderId
        this:SetData("ChatRoom/PrivateMsg/" .. playerId, nil)
      end
      local friends = this:GetData("ChatRoom/Friends")
      for i = 1, #friends do
        local playerId = friends[i].senderId
        this:SetData("ChatRoom/PrivateMsg/" .. playerId, nil)
      end
    end
    this:SetData("ChatRoom/ChatContentWorld", nil)
    this:SetData("ChatRoom/ChatContentWorldUpdate", nil)
    this:SetData("ChatRoom/ChatContentGuild", nil)
    this:SetData("ChatRoom/ChatContentGuildUpdate", nil)
    this:SetData("GuildMsg", nil)
    this:SetData("GuildMsg", guildCache)
    this:SetData("ChatRoom/ChatContentWorld", worldCache)
  end
end

function onScTempEntranceSwitchInfo(pushData)
  S:Get("RestifizerManager").OnTempEntranceSwitch(pushData)
end

function m_handler.TeamDungeonInvite(playerId, name, url, roomId, activityId, dungeonId, type)
  local function DoInviteMsg(dungeonName, level)
    local msg = {
      content = HU.ApplyFontColor(WU.GetString("TeamDungeonInviteMsg", dungeonName, level) .. "</a>", "#0199e9"),
      
      senderId = playerId,
      sender = name,
      time = CS.GameTime.serverUtc,
      hyperLinkPrefix = "<a href='{\"dungeonTeam\":{\"url\":\"" .. url .. "\",\"roomId\":" .. tonumber(roomId) .. ",\"activityId\":" .. activityId .. ",\"dungeonId\":" .. dungeonId .. "}}'>"
    }
    if tonumber(type) == PB.enum.TeamDungeonInviteFrom.Friend then
      CU.HandlerNewMsg(msg, 1)
    else
      CU.HandlerNewMsg(msg, 2)
    end
    local data = {
      playerId = playerId,
      name = name,
      url = url,
      roomId = tonumber(roomId),
      type = type,
      activityId = tonumber(activityId),
      dungeonId = tonumber(dungeonId)
    }
    this:BroadcastGameEvent("DungeonTeamInviteHint", data)
  end
  
  local function GetTitle(activityId2GroupId)
    local dungeonReward = PB.get("DungeonReward", tonumber(dungeonId))
    local level = 0
    if dungeonReward then
      level = dungeonReward.difficultLevelLow
    else
      warning("DungeonTeam", "DungeonReward.xlsx no dungeonId : " .. dungeonId)
    end
    local activityName = WU.GetString("DungeonTeamName_" .. activityId2GroupId[tostring(activityId)])
    return activityName, level
  end
  
  local activityId2GroupId = this:GetData("fci/teamdungeongroups/")
  if activityId2GroupId == nil then
    this:GameRequest("fci/teamdungeongroups/"):Get(function(result)
      this:SetData("fci/teamdungeongroups/", result)
      DoInviteMsg(GetTitle(result))
    end)
  else
    DoInviteMsg(GetTitle(activityId2GroupId))
  end
end

function m_handler.TriggeredEventAdd(id, type, key, senderId, friendSend, createTime, lastTime, eventLevel, senderName, headPhoto, headFrame, socialPicture)
  local event = {
    eventId = tonumber(id),
    eventType = tonumber(type),
    eventKey = key,
    senderId = senderId,
    friendSend = friendSend,
    createTime = tonumber(createTime),
    lastTime = tonumber(lastTime),
    eventLevel = tonumber(eventLevel),
    senderName = senderName,
    headPhoto = tonumber(headPhoto),
    headFrame = tonumber(headFrame),
    socialPicture = socialPicture
  }
  if tonumber(type) == PB.enum.TriggeredEventType.Dungeon then
    DBH.TriggeredEventChange(event)
    this:BroadcastGameEvent("TriggeredEventNew")
    local msg = {
      content = HU.ApplyFontColor(WU.GetString("TriggeredEvent_Happened", WU.GetString("DungeonName_" .. id), WU.GetString("Window_Level", eventLevel)), "#0199e9"),
      senderId = senderId,
      sender = senderName,
      time = CS.GameTime.serverUtc,
      hyperLinkPrefix = "<a href='{\"event\":{\"eventKey\":\"" .. key .. "\"}}'>",
      headPhoto = tonumber(headPhoto),
      headFrame = tonumber(headFrame),
      socialPicture = socialPicture
    }
    CU.HandlerNewMsg(msg, 4)
  else
    warning("todo", "todo")
  end
end

function m_handler.TriggeredEventDelete(message)
  local triggeredEventData = this:GetData("fci/triggered-event/")
  if triggeredEventData then
    DBH.DBRemove(triggeredEventData.eventInfo, "eventKey", message)
  end
end

function m_handler.CustomActorCultivationStart(pushData)
  DB:SyncRemote(DB:GameRequest("fci/custom-actor-cultivation"))
end

function m_handler.LotteryTaskFinished(times)
  S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.Lottery, function(acs)
    if acs == nil or acs[1] == nil then
      return
    end
    if ACU.IsOpenForDoing(acs[1]) then
      RU.SetRedMark("Welfare/Lottery", tonumber(times) > 0)
    end
  end)
end

function OnActorCultivationInfo(pushData)
  this:SetData("fci/actor-cultivation", pushData.info)
end

function onScSurpriseEvent(pushData)
  this:SetData("surpriseEventInfo", pushData)
end

function onScUniqueWeaponAddNew(pushData)
  DBH.ResChange(pushData.resChange)
end
