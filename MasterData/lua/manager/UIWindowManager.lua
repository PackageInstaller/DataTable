local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton"):Register(_ENV, "UIWindowManager")
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local ACU = require("Common/ActivityUtil")
local CO = require("Common/Coroutine")
local m_allWindowList = {}
local m_ignoreTopWindow = {
  "Messenger",
  "Navigation",
  "Resource",
  "LockInput",
  "BrowserToolbar"
}
local HeadPhotoExpireInterval = 172800
local id_ActivityShareWeekly = 24001
local m_music
local m_waitForFetch = {}
local fetcher = CO.coroutine_call(function()
  local fetchNext = true
  while true do
    if 0 < #m_waitForFetch and fetchNext then
      local fetchInfo = m_waitForFetch[#m_waitForFetch]
      info("MSDK", "start fetch for url : " .. tostring(fetchInfo.socialPicture))
      fetchNext = false
      
      local function OnFetchFinished()
        if table.empty(m_waitForFetch) then
          fetchNext = true
          return
        end
        info("MSDK", "fetch finished(success or failed) ! socialPicture url : " .. tostring(fetchInfo.socialPicture))
        table.remove(m_waitForFetch, #m_waitForFetch)
        fetchNext = true
      end
      
      MsdkHeadPhoto(fetchInfo.socialPicture, fetchInfo.playerId, OnFetchFinished, OnFetchFinished)
    end
    CO.yield_return()
  end
end)()
local m_pendingRefresh

function Awake()
  this:RegisterGameEvent("ShowMessageYesNo", OnShowMessageYesNo)
  this:RegisterGameEvent("ShowMessageOK", OnShowMessageOK)
  this:RegisterGameEvent("LoadingDetailStart", OnLoadingDetailStart)
  this:RegisterGameEvent("LoadingDetailEnd", OnLoadingDetailEnd)
  this:RegisterGameEvent("LoadingDetailProgress", OnUpdateLoadingProgress)
  this:RegisterGameEvent("ShowHintIcon", OnShowHintIcon)
  this:RegisterGameEvent("ShowHintText", OnShowHintText)
  this:RegisterGameEvent("OnShowHintRollingText", OnShowHintRollingText)
  this:RegisterGameEvent("ShowHoverTips_0", OnShowHoverTips)
  this:RegisterGameEvent("HideHoverTips", OnHideHoverTips)
  this:RegisterGameEvent("OnShowEditBox", OnShowEditBox)
  this:RegisterGameEvent("NetworkChanged", OnNetworkChanged)
  this:RegisterGameEvent("OnPlayerLevelup", OnPlayerLevelup)
  this:RegisterGameEvent("DungeonTeamInviteHint", OnDungeonTeamInviteHint)
  this:Bind("fci/item/", OnItemListener)
  this:Bind("AccountSwitch", EnableTDMDataReporter)
  this:RegisterGameEvent("OnLoginNotify", OnLogin)
  this:RegisterGameEvent("ASM_OnCollectASMSuccess", OnCollectASMSuccess)
  CS.Msdk.MsdkEvent.Instance:ShareEvent("+", OnShareEvent)
  this:RegisterGameEvent("MedalAttrAppend", OnMedalAttrAppend)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
end

function Start()
  WU.AcquireWindow("LockInput")
  WU.AcquireWindow("Floor")
  this:RegisterGameEvent("PowerFullSeconds", OnPowerFullTrigger)
  this:RegisterGameEvent("SetDeployNotify", OnDeployFinishTrigger)
  this:RegisterGameEvent("ResetNotification", OnResetNotifications)
  this:RegisterGameEvent("ClearNotification", function()
    if IsUseNativeNotification() then
      CS.NativeInterface.External_ClearLocalNotifications()
    else
      CS.Msdk.WGPlatform.Instance:WGClearLocalNotifications()
    end
  end)
  CS.UIPanel.preUpdate("+", ProcessPendingRefresh)
  this:Bind("NavigationContext", OnTopMostWindow)
end

function OnDestroy()
  CS.UIPanel.preUpdate("-", ProcessPendingRefresh)
  CS.Msdk.MsdkEvent.Instance:ShareEvent("-", OnShareEvent)
end

function OnShareEvent(shareRet)
  if shareRet.flag == CS.Msdk.eFlag.eFlag_Succ then
    warning("PlayerOption_MSDK", shareRet:ToString())
    local shareConfig = this:GetData("ShareConfig")
    if shareConfig == nil then
      return
    end
    local topWindow = WU.TopWindow()
    if topWindow == nil or topWindow.name == nil then
      return
    end
    local topWindowName = topWindow.name
    if topWindowName == "NewActorGet" then
      this:BroadcastGameEvent("ShareSuccess")
      return
    end
    local activityLists = this:GetData("ActivityList")
    local _, activityInfo = table.find(activityLists, function(k, v)
      return v.activityId == id_ActivityShareWeekly
    end)
    if activityInfo and ACU.GetStatus(activityInfo) == PB.enum.ActivityStatus.Started then
      local playerShareInfo = this:GetData("fci/share")
      if playerShareInfo then
        WeeklyShareAward(playerShareInfo, topWindowName)
      else
        this:GameRequest("fci/share"):Get(function(playerShareInfo)
          this:SetData("fci/share", playerShareInfo)
          WeeklyShareAward(playerShareInfo, topWindowName)
        end)
      end
    end
    local popupActivityId = this:GetData("PopupCoverJumpinShareRewardCurrentActivityId")
    if popupActivityId then
      DB:GameRequest("fci/popup/" .. popupActivityId):Post({}, function(resp)
        if resp then
          local popup = this:GetData("fci/popup/") or {}
          table.insert(popup, resp.activityId)
          this:SetData("fci/popup/", popup)
        end
      end)
    end
  else
    if shareRet.flag == CS.Msdk.eFlag.eFlag_WX_NotInstall or shareRet.flag == CS.Msdk.eFlag.eFlag_WX_NotSupportApi then
      WU.ShowHintText(WU.GetString("Platform_WXNotInstalled"))
    elseif shareRet.flag == CS.Msdk.eFlag.eFlag_QQ_NotInstall or shareRet.flag == CS.Msdk.eFlag.eFlag_QQ_NotSupportApi then
      WU.ShowHintText(WU.GetString("Platform_QQNotInstalled"))
    end
    warning("PlayerOption_MSDK", [[
ShareEvent error
flag:]] .. shareRet.flag .. [[

desc:]] .. shareRet.desc .. [[

extInfo: ]] .. shareRet.extInfo)
  end
end

function WeeklyShareAward(playerShareInfo)
  if playerShareInfo.weeklyRewarded then
    return
  end
  this:GameRequest("fci/share"):Post({activityId = id_ActivityShareWeekly}, function(result)
    playerShareInfo.weeklyRewarded = true
    this:SetData("fci/share", playerShareInfo)
  end)
end

function OnWindowUninited(window)
  if window ~= nil then
    local listener = this:GetData("SortCache/Listener")
    if listener ~= nil then
      listener[window.name] = nil
    end
  end
  local preferences = this:GetData("config/gamePreferences")
  local mgr = CS.UIWindowManager.Instance
  if preferences ~= nil and mgr ~= nil and mgr.gameObject.activeInHierarchy and mgr:InactiveWindowCount() >= fif(preferences.memoryControl, 4, 10) then
    this:DelayInvokeInFrames(1, function()
      mgr:ReleaseUnusedWindows()
    end)
  end
  if not table.empty(m_allWindowList) and not table.has(m_ignoreTopWindow, window.name) then
    local index = table.find(m_allWindowList, function(k, v)
      return v == window.name
    end)
    table.remove(m_allWindowList, index)
    this:SetData("allWindowNameInfo", m_allWindowList)
  end
end

function OnTopMostWindow(windowName)
  local config = PB.get("UIWindowConfig", windowName)
  local antialiasing = CS.UIBaseProcess.Instance.mCamera:GetComponent(typeof(CS.Antialiasing))
  antialiasing.enabled = config ~= nil and config.antiAliasing
end

function ProcessPendingRefresh()
  if m_pendingRefresh ~= nil then
    for k, _ in pairs(m_pendingRefresh) do
      k()
    end
    m_pendingRefresh = nil
  end
end

function PendingRefresh(callback)
  if m_pendingRefresh == nil then
    m_pendingRefresh = {}
  end
  m_pendingRefresh[callback] = true
end

function CancelPendingRefresh(callback)
  if m_pendingRefresh then
    m_pendingRefresh[callback] = nil
  end
end

function OnShowMessageYesNo(message, callback, yesText, noText, disableButtonClose)
  WU.ShowMessageYesNo(message, callback, yesText, noText, nil, disableButtonClose)
end

function OnShowMessageOK(message, callback)
  WU.ShowMessageOK(message, callback)
end

function OnLoadingDetailStart()
  WU.ShowLoadingDetail()
end

function OnUpdateLoadingProgress(progress)
  WU.UpdateLoadingProgress(progress)
end

function OnLoadingDetailEnd()
  WU.HideLoadingDetail()
end

function OnShowHintIcon(items)
  WU.ShowHintIcon(items)
end

function OnShowHintText(text, duration)
  WU.ShowHintText(text, duration)
end

function OnShowHintRollingText(text)
  WU.ShowHintTextRolling(text)
end

function OnShowHoverTips(title, desc)
  WU.ShowHoverTips(title, desc)
end

function OnHideHoverTips()
  WU.HideHoverTips()
end

function OnShowEditBox(context, confirmCallback, cancelCallback)
  WU.ShowEditBox(context, confirmCallback, cancelCallback)
end

function OnNetworkChanged(reachable)
  if reachable then
    WU.HideNetworkUnavailable()
  else
    WU.ShowNetworkUnavailable()
  end
end

function OnPlayerLevelup(lvFrom, lvTo)
  if WU.GetCurrentScene().name == "SceneCity" then
    WU.ShowPlayerLevelupResult(lvFrom, lvTo)
  else
    this:SetData("OnSceneBalance/PlayerLevelupResult", {lvFrom = lvFrom, lvTo = lvTo})
  end
end

function OnItemListener(items)
  if items == nil then
    return
  end
  local listener = this:GetData("Item/Listener")
  local showHint = false
  if listener ~= nil then
    for i = 1, #items do
      local item = items[i]
      if listener[item.id] then
        if listener[item.id].count ~= item.count then
          showHint = listener[item.id].count < item.count
          listener[item.id].displayNum = item.count - listener[item.id].count
          listener[item.id].count = item.count
        else
          listener[item.id].displayNum = nil
        end
      end
    end
    local actor = this:GetData("fci/actor/" .. listener.uid)
    showHint = showHint and actor ~= nil
  end
  if showHint then
    if WU.CurrentScene() == "City" then
      WU.AcquireWindowAsync("HintItemListener", function(ui)
        _ENV["$"](ui)["$$ShowHintListener"](listener)
      end)
    else
      this:DelayInvokeInSeconds(3, function()
        WU.AcquireWindowAsync("HintItemListener", function(ui)
          _ENV["$"](ui)["$$ShowHintListener"](listener)
        end)
      end)
    end
  end
end

local m_powerFullTriggerTime

function OnCollectASMSuccess(json)
  if json ~= nil then
    local jsonData = JsonD(json)
    local param = {}
    param.org_name = jsonData["iad-org-name"]
    param.attribution = jsonData["iad-attribution"]
    param.key_word = jsonData["iad-keyword"]
    param.adgroup_name = jsonData["iad-adgroup-name"]
    param.conversion_date = jsonData["iad-conversion-date"]
    param.campaign_id = jsonData["iad-campaign-id"]
    param.campaign_name = jsonData["iad-campaign-name"]
    param.click_date = jsonData["iad-click-date"]
    param.adgroup_id = jsonData["iad-adgroup-id"]
    this:GameRequest("fci/asmiadinfo/"):Post(param)
  end
end

function OnPowerFullTrigger(fullSeconds)
  if fullSeconds == nil then
    return
  end
  m_powerFullTriggerTime = CS.GameTime.serverNow:AddSeconds(fullSeconds)
  setActiveNotifications()
  info("messageDate", tostring(fullSeconds))
  info("serverUtc ", tostring(CS.GameTime.serverUtc))
  info("all ", tostring(CS.GameTime.serverUtc + fullSeconds))
  info("full time ", m_powerFullTriggerTime)
end

function OnDeployFinishTrigger(endTime)
  if endTime ~= nil and 0 < endTime then
    setActiveNotifications()
  end
end

function UpdateDeployNotify(response)
  local missionList = _ENV["!"]({})
  for _, mission in pairs(response.missionInfo) do
    mission.config = PB.get("DeployMission", mission.id)
    if mission.config ~= nil and mission.endTimestamp > 0 then
      table.insert(missionList, mission)
    end
  end
  table.sort(missionList, function(a, b)
    return a.endTimestamp < b.endTimestamp
  end)
  for _, mission in pairs(missionList) do
    SetDeployFinishNotify(mission.endTimestamp)
  end
end

function OnResetNotifications()
  setActiveNotifications()
end

function SetNotifyMessage(id, triggerTime)
  if CS.LocaleManager.Instance == nil then
    return
  end
  local boardActorRoleId
  local signBoardID = this:GetData("BoardActor/RoleId")
  local allEntity = PB.all("Signboard")
  for _, v in pairs(allEntity) do
    if v.signboardId == signBoardID then
      boardActorRoleId = v.roleId
      break
    end
  end
  if boardActorRoleId == nil then
    boardActorRoleId = 2
  end
  local msdkMessage = PB.get("MsdkMessage", id, boardActorRoleId, 1)
  if msdkMessage ~= nil then
    local deviceType = S:Get("ConfigDataManager").DeviceType()
    if deviceType == PB.enum.GamePlatForm.Ios then
      local message = CS.Msdk.LocalMessageIOS()
      message.fireDate = triggerTime:ToString("yyyy-MM-dd HH:mm:ss")
      message.alertBody = WU.GetString(msdkMessage.content, WU.GetString("RoleName_" .. boardActorRoleId))
      message.badge = 1
      message.alertAction = "Start"
      info("NotificationSuccess", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. "------" .. message.alertBody)
      local rtn = CS.Msdk.WGPlatform.Instance:WGAddLocalNotification(message)
      if rtn == 1 then
        info("SetNotifyMessage", "success")
      else
        info("SetNotifyMessage", "failed")
      end
    elseif deviceType == PB.enum.GamePlatForm.Android then
      if IsUseNativeNotification() then
        local msg = {}
        msg.id = id
        msg.title = WU.GetString("Window_NotifyNewMsg")
        msg.message = WU.GetString("NotepadMessage_" .. id)
        msg.number = 1
        msg.fireDate = CS.GameTime.ToSecondsForTimeZone(triggerTime) * 1000
        CS.NativeInterface.External_AddLocalNotification(JsonE(msg))
        info("Notification", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. "------" .. msg.message)
      else
        local msg = CS.Msdk.LocalMessageAndroid()
        if msg then
          local t1 = triggerTime:ToString("yyyyMMdd")
          local t2 = triggerTime:ToString("HH")
          local t3 = triggerTime:ToString("mm")
          msg.type = 1
          msg.action_type = 1
          msg.content = WU.GetString(msdkMessage.content, WU.GetString("RoleName_" .. boardActorRoleId))
          msg.title = WU.GetString("Window_NotifyNewMsg")
          msg.date = t1
          msg.hour = t2
          msg.min = t3
          local rtn = CS.Msdk.WGPlatform.Instance:WGAddLocalNotification(msg)
          info("Notification", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. "------" .. msg.content)
          info("Notification", rtn)
          if rtn ~= 0 then
            info("Notification", string.format("success %s,%s,%s", t1, t2, t3))
          else
            info("Notification", "failed")
          end
        end
      end
    end
  else
    warning("Debug", "BoardActorRoleId " .. tostring(boardActorRoleId) .. " favourLevel " .. 1)
  end
end

function IsUseNativeNotification()
  local hasNewInterface = CS.NativeInterface.External_ClearLocalNotifications ~= nil
  warning("IsUseNativeNotification", hasNewInterface)
  return hasNewInterface
end

function SetPowerFullMessage()
  if TestTimeWithServerAndClient(m_powerFullTriggerTime, PB.enum.NotifyType.Power) then
    SetNotifyMessage(PB.enum.NotifyType.Power, m_powerFullTriggerTime)
  end
end

function SetFixTimeNotify()
  local timeNow = CS.GameTime.serverNow
  local triggerTime1 = CS.System.DateTime(timeNow.Year, timeNow.Month, timeNow.Day, 11, 0, 0)
  local triggerTime2 = CS.System.DateTime(timeNow.Year, timeNow.Month, timeNow.Day, 18, 0, 0)
  if TestTimeWithServerAndClient(triggerTime1) then
    SetNotifyMessage(PB.enum.NotifyType.Hour12, triggerTime1)
  end
  if TestTimeWithServerAndClient(triggerTime2) then
    SetNotifyMessage(PB.enum.NotifyType.Hour18, triggerTime2)
  end
end

function SetDeployFinishNotify(endTime)
  local triggerTime = CS.GameTime.UtcToLocal(endTime)
  if TestTimeWithServerAndClient(triggerTime, PB.enum.NotifyType.DeployFinish) then
    SetNotifyMessage(PB.enum.NotifyType.DeployFinish, triggerTime)
  end
end

function Set48HourNoLogin()
  local timeNow = CS.GameTime.serverNow
  local newDay = timeNow:AddDays(2)
  if TestTimeWithServerAndClient(newDay) then
    SetNotifyMessage(PB.enum.NotifyType.Hour48NoLogin, newDay)
  end
end

function SetMonthCardPlayer24HourNoLogin()
  local leftDay = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[PB.enum.ResourceType.ResMonthCardDays] .. "_0")
  if leftDay and 1 < leftDay then
    local timeNow = CS.GameTime.serverNow
    local newDay = timeNow:AddDays(1)
    if TestTimeWithServerAndClient(newDay) then
      SetNotifyMessage(PB.enum.NotifyType.Hour24NoLogin, newDay)
    end
  end
end

function setActiveNotifications()
  if IsUseNativeNotification() then
    CS.NativeInterface.External_ClearLocalNotifications()
  else
    CS.Msdk.WGPlatform.Instance:WGClearLocalNotifications()
  end
  info("NotificationResult", "Clear All For Reset!")
  local timeNow = CS.GameTime.serverNow
  local m_configDataManager = S:Get("ConfigDataManager")
  local preferences = m_configDataManager.GetPreferences()
  if preferences.notify == nil then
    local time = CS.System.DateTime.Now
    preferences.notify = {
      powerFull = {
        lastSet = time:AddDays(-1).Ticks,
        lastTrigger = time:AddDays(-1).Ticks
      },
      deployFinish = {
        lastSets = _ENV["!"]({}),
        lastTrigger = time:AddDays(-1).Ticks
      }
    }
  else
    if preferences.notify.powerFull.lastSet <= timeNow.Ticks and preferences.notify.powerFull.lastSet > preferences.notify.powerFull.lastTrigger then
      preferences.notify.powerFull.lastTrigger = preferences.notify.powerFull.lastSet
    end
    preferences.notify.powerFull.lastSet = timeNow:AddDays(-1).Ticks
    local lastSets = preferences.notify.deployFinish.lastSets or _ENV["!"]({})
    for i = #lastSets, 1, -1 do
      if lastSets[i] <= timeNow.Ticks and lastSets[i] > preferences.notify.deployFinish.lastTrigger then
        preferences.notify.deployFinish.lastTrigger = lastSets[i]
        break
      end
    end
    preferences.notify.deployFinish.lastSets = _ENV["!"]({})
  end
  m_configDataManager.SetPreferences(preferences)
  Set48HourNoLogin()
  SetMonthCardPlayer24HourNoLogin()
  if preferences.energyFull and m_powerFullTriggerTime then
    SetPowerFullMessage()
  end
  if preferences.dispatchBack then
    local deployData = this:GetData("fci/deploy/mission/")
    if deployData == nil then
      this:GameRequest("fci/deploy/mission/"):Get(function(response)
        this:SetData("fci/deploy/mission/", response)
        UpdateDeployNotify(response)
      end)
    else
      UpdateDeployNotify(deployData)
    end
  end
  if preferences.drawEnergy then
    SetFixTimeNotify()
  end
end

function OnLogin()
  this:GameRequest("fci/server-update-info/"):Get(function(response)
    this:SetData("ServerUpdateTimeInfo", response.timeInfo)
  end)
  setActiveNotifications()
end

function OnDungeonTeamInviteHint(message)
  if WU.CurrentScene() ~= "SceneCity" then
    return
  end
  if this:GetData("DungeonTeamInviteHint/Hide") then
    return
  end
  WU.AcquireWindowAsync("DungeonTeamInviteHint", function(ui)
    _ENV["$"](ui)["$$SetData"](message)
  end)
end

function TestTimeWithServerAndClient(triggerTime, type)
  local timeInfo = DB:GetData("ServerUpdateTimeInfo")
  if timeInfo then
    for _, v in pairs(timeInfo) do
      if triggerTime > CS.GameTime.UtcToLocal(v.startTime) and triggerTime <= CS.GameTime.UtcToLocal(v.endTime) then
        info("NotificationResult", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. " exactly in update time!  " .. tostring(type))
        return false
      end
    end
  end
  local localTime = CS.System.DateTime.Now
  local serverTime = CS.GameTime.serverNow
  if triggerTime <= localTime then
    info("NotificationResult", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. " has passed according to localTime")
    return false
  end
  if triggerTime <= serverTime then
    info("NotificationResult", triggerTime:ToString("yyyy-MM-dd HH:mm:ss") .. " has passed according to serverTime")
    return false
  end
  if type ~= PB.enum.NotifyType.Power and type ~= PB.enum.NotifyType.DeployFinish then
    return true
  end
  local m_configDataManager = S:Get("ConfigDataManager")
  local preferences = m_configDataManager.GetPreferences()
  if preferences.notify == nil then
    return true
  end
  local pfLastSet = CS.System.DateTime(preferences.notify.powerFull.lastSet):ToString("yyyy-MM-dd HH:mm:ss")
  local pfLastTriggle = CS.System.DateTime(preferences.notify.powerFull.lastTrigger):ToString("yyyy-MM-dd HH:mm:ss")
  local testTime = triggerTime:ToString("yyyy-MM-dd HH:mm:ss")
  info("NotificationDetail", "pfLastSet:" .. pfLastSet .. "   pfLastTriggle:" .. pfLastTriggle .. "  testTime:" .. testTime)
  if type == PB.enum.NotifyType.Power then
    local cd = PB.index("Misc", 1).notifyCD.powerFull
    local t = triggerTime:AddMinutes(0 - cd).Ticks
    if t < preferences.notify.powerFull.lastTrigger then
      info("NotificationResult", "PowerFull Triggle CD")
      return false
    end
    preferences.notify.powerFull.lastSet = triggerTime.Ticks
  end
  if type == PB.enum.NotifyType.DeployFinish then
    local cd = PB.index("Misc", 1).notifyCD.deployFinish
    local t = triggerTime:AddMinutes(0 - cd).Ticks
    if t < preferences.notify.deployFinish.lastTrigger then
      info("NotificationResult", "DeployFinish Triggle CD")
      return false
    end
    local lastSets = preferences.notify.deployFinish.lastSets or _ENV["!"]({})
    if 1 <= #lastSets and t < table.last(lastSets) then
      info("NotificationResult", "DeployFinish Set CD")
      return false
    end
    table.insert(preferences.notify.deployFinish.lastSets, triggerTime.Ticks)
  end
  m_configDataManager.SetPreferences(preferences)
  return true
end

function OnMedalAttrAppend()
end

function GetTempWritablePath(path)
  return CS.System.IO.Path.Combine(CS.UnityEngine.Application.temporaryCachePath, path)
end

local m_msdkHeadPhotoCache
local m_onFetchingUrls = {}

function MsdkHeadPhotoFromCache(playerId, url)
  info("MSDK", "MsdkHeadPhotoFromCache")
  if m_msdkHeadPhotoCache == nil then
    m_msdkHeadPhotoCache = WU.GetGameDataCache("MSDKHeadPhotoCache") or {}
  end
  if m_msdkHeadPhotoCache.expireTime == nil or m_msdkHeadPhotoCache.expireTime < CS.GameTime.serverUtc then
    m_msdkHeadPhotoCache = {}
    m_msdkHeadPhotoCache.expireTime = CS.GameTime.serverUtc + HeadPhotoExpireInterval
  end
  return FindTexture(playerId, url)
end

function FindTexture(playerId, playerUrl)
  local _, url = table.find(m_msdkHeadPhotoCache, function(k, _)
    return k == playerId
  end)
  local tex2d
  if url and playerUrl == url then
    local bytes = CS.ResourceManager.Instance:ReadBytes(GetTempWritablePath(playerId))
    if bytes then
      tex2d = CS.UnityEngine.Texture2D(128, 128)
      tex2d:LoadImage(bytes)
    end
  end
  if tex2d then
    info("MSDK", "find playerId " .. playerId)
  end
  return tex2d
end

function RemoveOnFetchingUrl(url)
  local i = table.find(m_onFetchingUrls, function(_, v)
    return v == url
  end)
  table.remove(m_onFetchingUrls, i)
end

function MsdkHeadPhoto(url, playerId, callback, failCallback)
  if table.find(m_onFetchingUrls, function(_, v)
    return v == url
  end) then
    return
  end
  
  local function onSucceed(tex)
    this:BroadcastGameEvent("OnMsdkHeadPhotoFetched", playerId, tex)
    if callback then
      callback()
    end
    RemoveOnFetchingUrl(url)
  end
  
  local function onFailed()
    if failCallback then
      failCallback()
    end
    RemoveOnFetchingUrl(url)
  end
  
  local tex2d = FindTexture(playerId, url)
  if tex2d then
    onSucceed(tex2d)
  else
    info("MSDK", "begin fetch MsdkHeadPhoto for playerId : " .. playerId)
    table.insert(m_onFetchingUrls, url)
    this:GameRequest("fci/social-pic-verify/"):Post(ProtobufT("ApiSocialPicVerify", {picUrl = url}), function(result)
      if result.isValid then
        this:RemoteFetcherForTexture2D(url, 128, 128, function(fetchedTex)
          CS.ResourceManager.Instance:WriteBytes(GetTempWritablePath(playerId), fetchedTex:EncodeToPNG())
          m_msdkHeadPhotoCache[playerId] = url
          WU.SetGameDataCache("MSDKHeadPhotoCache", m_msdkHeadPhotoCache)
          onSucceed(fetchedTex)
        end, function()
          onFailed()
        end)
      else
        onFailed()
      end
    end, onFailed)
  end
end

function StopHeadPhotoFetch()
  info("MSDK", " StopHeadPhotoFetch !")
  this:StopCoroutine(fetcher)
  m_waitForFetch = {}
end

function AddSocialPicToFetcher(socialPicture, playerId)
  table.insert(m_waitForFetch, {socialPicture = socialPicture, playerId = playerId})
end

function OnWindowInited(window)
  if not table.has(m_ignoreTopWindow, window.name) then
    local currentWindowInfo = PB.get("UIWindowConfig", window.name)
    if currentWindowInfo and currentWindowInfo.depth ~= 0 then
      local index = table.find(m_allWindowList, function(k, v)
        return v == window.name
      end)
      if index then
        table.remove(m_allWindowList, index)
      end
    end
    table.insert(m_allWindowList, 1, window.name)
    this:SetData("allWindowNameInfo", m_allWindowList)
  end
end

function EnableTDMDataReporter(accountSwitch)
  if not accountSwitch then
    return
  end
  WU.EnabelTDMReport(fif(accountSwitch.TDMLogRepoterSwitch == true, true, false))
end
