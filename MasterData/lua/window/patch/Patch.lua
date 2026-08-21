local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_tweens = {}
local m_tweenPlayingCount = 0
local m_configDataManager = S:Get("ConfigDataManager")
local m_isHealthGameAdvicePlayed = false
local m_dragDelta
local m_publisherLogoIndex = 0
local m_retryTimes = 3
local m_startTime, m_publisherCallback, m_heroIDs
local m_curHeroIndex = 1
local m_delay
local m_dt = 0
local m_totalBytes = 0
local m_descLabelList = {}
local m_startDowner
local m_curStrDownSpeed = ""
local m_curDownBytes = 0
local m_retryDown, m_enterGame
local m_bIsRetryDown = false
local m_indexPoint, m_curSelectPoint, m_urlOpen
local m_bMoving = false
local m_lastAudioIdx, m_jumpUrl
local m_dirAccountGot = false
local m_downloadFinished = false
local m_isShowingDialog = false
local m_hasHotfix = false
local m_isCheckedAppVersion = false
local m_isAppVersionDone = false

function InitWindow()
  WU.SetActive(REF.license, false)
  m_dirAccountGot = false
  m_downloadFinished = false
  m_isCheckedAppVersion = false
  m_startTime = CS.System.DateTime(1970, 1, 1, 0, 0, 0, 0)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  this:RegisterGameEvent("SceneAwake", OnSceneAwake)
  this:RegisterGameEvent("RecvUpdateNotify", OnRecvUpdateNotify)
  this:RegisterGameEvent("DownLoadResult", OnDownLoadResult)
  this:RegisterGameEvent("NotifyDownSpeed", OnNotifyDownSpeed)
  this:RegisterGameEvent("VersionTooLow", OnVersionTooLow)
  this:RegisterGameEvent("PatchNotice/OnClose", OnPatchNoticeClosed)
  WU.BindButtonEvent(REF.ButtonCustomSrv, OnButtonCustomSrv)
  WU.BindButtonEvent(REF.ButtonNotice, OnButtonNotice)
  WU.BindButtonEvent(REF.ButtonUpdate, OnButtonUpdate)
  WU.BindButtonEvent(REF.ButtonUpdateJump, OnButtonJump)
  WU.BindButtonEvent(REF.ButtonRepair, OnButonRepair)
  this:Bind("DynamicConfig", OnDynamicConfig)
  this:Bind("config/gamePreferences", OnGamePreferencesChanged)
  UpdateText(WU.GetString("ScenePatch_Initialize"))
  m_tweens = {
    REF.Black.TweenAlpha,
    REF.MainPanel:query(typeof(CS.UITweener), function(comp)
      return comp.tweenGroup == 0
    end)
  }
  WU.ToggleRendering(REF.Bottom, false)
  PresentNextPublisher()
  m_heroIDs = GetHerosHaveOpened()
  WU.BindPressEvent(REF.DragArea, OnPress, "empty")
  WU.BindDragEvent(REF.DragArea, OnDraging)
  REF.LoadingPanel.gameObject:SetActive(false)
  WU.ToggleRendering(REF.DownHtmlLabel, false)
  UpdateProgress(0, 0, 0)
end

function OnVersionTooLow(url)
  m_jumpUrl = url
  REF.LoadingPanel.gameObject:SetActive(true)
  ShowJumpLoadingPanel()
  REF.RightNode1.gameObject:SetActive(false)
  WU.RestartTween(REF.LoadingPanel.TweenAlpha, function()
    REF.EffectEnterJump.EffectGenerator:Play()
    REF.root.Animator:Play("LoadingStart")
    CS.SoundManager.Instance:PlayMusic("Update")
    REF.RightNode1.gameObject:SetActive(true)
  end)
end

function ShowNotice(scene)
  local noticeData = CS.Msdk.WGPlatform.Instance:WGGetNoticeData(scene)
  if noticeData == nil then
    return
  end
  local list = _ENV["!"](noticeData:ToArray())
  if table.empty(list) then
    return
  end
  local notice = list[1]
  if notice == nil then
    return
  end
  if notice.content_type ~= 0 then
    CS.Msdk.WGPlatform.Instance:WGShowNotice(scene)
    return
  end
  WU.AcquireWindowAsync("NoticeMessage", function(ui)
    _ENV["$"](ui)["$$ShowNotice"](notice.msg_title, notice.msg_content)
  end)
end

function OnButtonJump()
  WU.OpenUrl(m_jumpUrl)
end

function ShowJumpLoadingPanel()
  REF.Loading1.gameObject:SetActive(false)
  REF.Loading2.gameObject:SetActive(false)
  REF.ButtonRepair.gameObject:SetActive(false)
  REF.LoadingJump.gameObject:SetActive(true)
end

function OnButtonUpdate()
  if m_startDowner then
    local reachability = CS.UnityEngine.Application.internetReachability
    if reachability == CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
      WU.ShowMessageYesNo(WU.GetString("ScenePatch_UpdateTipsMobile"), function(msg)
        if msg == "YES" then
          ShowDownLoadingPanel()
          m_startDowner()
        end
      end)
    elseif reachability == CS.UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
      ShowDownLoadingPanel()
      m_startDowner()
    end
  end
end

function OnButtonNotice()
  CS.SceneBaseImpl.CurrentScene:OpenNotify("/beforelogin?source=ScenePatch")
end

function OnButtonCustomSrv()
  local url = PB.all("MsdkUrl")[1].LoginCS
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function OnNotifyDownSpeed(strSpeed)
  m_curStrDownSpeed = strSpeed
  local strCurDown = CS.GameUtility.ToHumanreadable(m_curDownBytes)
  local strTotalDown = CS.GameUtility.ToHumanreadable(m_totalBytes)
  local strDown = string.format("%s %s/%s", m_curStrDownSpeed, strCurDown, strTotalDown)
  REF.DownHtmlLabel.UIHtmlLabel.text = strDown
end

function SetEnterGame(interface)
  m_enterGame = interface
end

function SetReTryDown(downer)
  m_retryDown = downer
end

function SetOpenUrl(interface)
  m_urlOpen = interface
end

function ReTryDown()
  if m_retryDown then
    m_bIsRetryDown = true
    m_retryDown()
  end
end

function OnDownLoadResult(result)
  if result == -1 then
    WU.ShowMessageOK(WU.GetString("ScenePatch_UpdateError"), function(ui)
      ReTryDown()
    end, WU.GetString("ScenePatch_UpdateRetry"))
  elseif result == 0 then
    m_hasHotfix = false
    m_downloadFinished = true
    TryEnterGame()
  end
end

function TryEnterGame()
  if m_enterGame and m_dirAccountGot and m_isCheckedAppVersion and m_downloadFinished and m_isAppVersionDone and not m_isShowingDialog and not m_hasHotfix then
    m_enterGame()
    UpdateProgress(1, m_totalBytes, m_totalBytes)
  end
end

function SetStartDowner(downer)
  m_startDowner = downer
end

function ShowLoadingPanel()
  REF.LoadingPanel.gameObject:SetActive(true)
  ShowReadyLoadingPanel()
  REF.RightNode1.gameObject:SetActive(false)
  WU.RestartTween(REF.LoadingPanel.TweenAlpha, function()
    REF.EffectEnter.EffectGenerator:Play()
    REF.root.Animator:Play("LoadingStart")
    CS.SoundManager.Instance:PlayMusic("Update")
    REF.RightNode1.gameObject:SetActive(true)
  end)
end

function ShowReadyLoadingPanel()
  initDisplayhero()
  REF.Loading1.gameObject:SetActive(true)
  REF.Loading2.gameObject:SetActive(false)
  REF.ButtonRepair.gameObject:SetActive(false)
  REF.LoadingJump.gameObject:SetActive(false)
end

function ShowDownLoadingPanel()
  m_delay = 4
  REF.Loading1.gameObject:SetActive(false)
  REF.Loading2.gameObject:SetActive(true)
  REF.ButtonRepair.gameObject:SetActive(true)
  REF.LoadingJump.gameObject:SetActive(false)
  REF.root.Animator:Play("Open")
  RandomPlaySound(m_heroIDs[m_curHeroIndex].dropActorDisplayID)
  REF.VerLoading2.UIHtmlLabel.text = WU.GetString("ScenePatch_VersionNum", m_configDataManager.FullVersion())
  WU.ToggleRendering(REF.DownHtmlLabel, true)
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
    RandomPlaySound(m_heroIDs[m_curHeroIndex].dropActorDisplayID)
  elseif m_dragDelta.x < -100 then
    m_dt = 0
    ChangeHero(1)
  elseif m_dragDelta.x > 100 then
    m_dt = 0
    ChangeHero(-1)
  end
end

function VerticalString(heroID)
  if heroID == nil then
    return
  end
  for i, v in ipairs(m_descLabelList) do
    CS.UnityEngine.GameObject.Destroy(v)
  end
  local resActorConfig = PB.get("ActorConfig", heroID)
  if resActorConfig == nil then
    error("NewActor", string.format("Id:%d does not exists in ResActorConfig", heroID))
    return
  end
  local actormainTexturePath = "Texture/ActorIntroduction/introduction_" .. resActorConfig.animRes
  REF.TextureDesc.UITexture.mainTexturePath = actormainTexturePath
end

function OnRecvUpdateNotify(totalBytes)
  m_hasHotfix = true
  m_totalBytes = totalBytes
  REF.UpdateTipsLabel.UIHtmlLabel.text = WU.GetString("ScenePatch_UpdateTips", CS.GameUtility.ToHumanreadable(m_totalBytes))
  REF.VerHtmlLabel.UIHtmlLabel.text = WU.GetString("ScenePatch_VersionNum", m_configDataManager.FullVersion())
  ShowLoadingPanel()
  ShowNotice("809")
end

function UpdateWindow()
  if m_delay then
    m_dt = m_dt + CS.GameTime.deltaTime
    if m_dt >= m_delay then
      m_dt = 0
      ChangeHero(1)
    end
  end
end

function ChangeHero(direction)
  if m_bMoving == true then
    return
  end
  local aniName
  if direction == nil then
  elseif direction == 1 then
    m_curHeroIndex = m_curHeroIndex + 1
    aniName = "Left"
  else
    m_curHeroIndex = m_curHeroIndex - 1
    aniName = "Right"
  end
  if m_curHeroIndex > #m_heroIDs then
    m_curHeroIndex = 1
  elseif m_curHeroIndex <= 0 then
    m_curHeroIndex = #m_heroIDs
  end
  if aniName then
    m_bMoving = true
    REF.root.Animator:Play(aniName, -1, 0)
    this:DelayInvokeInScaledSeconds(0.33, function()
      RandomPlaySound(m_heroIDs[m_curHeroIndex].dropActorDisplayID)
      UpdateHero(m_heroIDs[m_curHeroIndex].dropActorDisplayID)
      m_bMoving = false
    end)
  else
    UpdateHero(m_heroIDs[m_curHeroIndex].dropActorDisplayID)
  end
end

function initDisplayhero()
  if m_indexPoint == nil then
    m_indexPoint = {}
  end
  local lastPoint
  for i, v in ipairs(m_heroIDs) do
    if i == 1 then
      lastPoint = REF.SpritePoint.gameObject
      m_indexPoint[i] = lastPoint
    elseif lastPoint ~= nil then
      local obj = CS.UnityEngine.GameObject.Instantiate(REF.SpritePoint.gameObject, REF.SpritePoint.transform.parent.transform)
      obj.transform.localPosition = CS.UnityEngine.Vector3(lastPoint.transform.localPosition.x + 40, lastPoint.transform.localPosition.y, lastPoint.transform.localPosition.z)
      m_indexPoint[i] = obj
      lastPoint = obj
    end
  end
  ChangeHero()
end

function RandomPlaySound(actorId)
  local resActorConfig = PB.get("ActorConfig", actorId)
  if resActorConfig == nil then
    warning("NewActor", string.format("Id:%d does not exists in ResActorConfig", actorId))
    return
  end
  local audioInfo = this:GetData("WidgetActorRollerAudioInfo") or {id = 0, audioSource = nil}
  local audioSource = audioInfo.audioSource
  if not (audioInfo.id == actorId and audioSource) or not audioSource.isPlaying then
    if audioSource then
      audioSource:Stop()
    end
    if #resActorConfig.chooseAudio > 1 then
      local idx
      if audioInfo.id == actorId and m_lastAudioIdx ~= nil then
        idx = math.random(1, #resActorConfig.chooseAudio)
        while idx == m_lastAudioIdx do
          idx = math.random(1, #resActorConfig.chooseAudio)
        end
      else
        idx = math.random(1, #resActorConfig.chooseAudio)
      end
      m_lastAudioIdx = idx
      audioSource = CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.chooseAudio[idx], 1.0)
    elseif 0 < #resActorConfig.chooseAudio then
      info("Actor", "Actor id " .. actorId .. " only have one chooseAudio source")
      audioSource = CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.chooseAudio[1], 1.0)
    end
    this:SetData("WidgetActorRollerAudioInfo", {id = actorId, audioSource = audioSource})
  end
end

function UpdateHero(heroID)
  if heroID == nil then
    return
  end
  local resActorConfig = PB.get("ActorConfig", heroID)
  if resActorConfig == nil then
    error("NewActor", string.format("Id:%d does not exists in ResActorConfig", heroID))
    return
  end
  local actormainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. resActorConfig.animRes
  local actorName = "update_name_" .. resActorConfig.animRes
  REF.RoleTexture.UITexture.mainTexturePath = actormainTexturePath
  REF.RoleTextureShadow.UITexture.mainTexturePath = actormainTexturePath
  REF.SpriteName.UISprite.spriteName = actorName
  local uiSprite = m_indexPoint[m_curHeroIndex]:GetComponent(typeof(CS.UISprite))
  uiSprite.spriteName = "dot_light"
  if m_curSelectPoint then
    local uiSprite = m_curSelectPoint:GetComponent(typeof(CS.UISprite))
    uiSprite.spriteName = "dot_dark"
    m_curSelectPoint = m_indexPoint[m_curHeroIndex]
  end
  m_curSelectPoint = m_indexPoint[m_curHeroIndex]
  REF.LabelCV.UILabel.text = WU.GetString("ActorCV_" .. resActorConfig.id)
  VerticalString(heroID)
end

function OnWindowInited(window)
  if window.name == "Login" then
    WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
    m_tweenPlayingCount = #m_tweens
    for i = 1, m_tweenPlayingCount do
      WU.RestartTween(m_tweens[i], function()
        m_tweenPlayingCount = m_tweenPlayingCount - 1
        if m_tweenPlayingCount == 0 then
          WU.DestroyWindow(this)
          WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
        end
      end)
    end
    WU.RestartTween(REF.Bottom.TweenAlpha)
  end
end

function SaveRequestFaild(key, bClear)
  local tag = "CheckConnectSrvFail" .. key
  local data = WU.GetGameDataCache(tag)
  if data then
    data.faild = data.faild + 1
    if data.faild >= m_retryTimes and data.startTime == 0 then
      local nowSpan = CS.System.DateTime.UtcNow - m_startTime
      data.startTime = nowSpan.TotalSeconds
    end
  else
    data = {}
    data.faild = 1
    data.startTime = 0
    data.timerCount = 0
  end
  if bClear then
    data.faild = 0
    data.startTime = 0
    data.timerCount = 0
  end
  WU.SetGameDataCache(tag, data)
end

function CheckCanRequest(key)
  local tag = "CheckConnectSrvFail" .. key
  local data = WU.GetGameDataCache(tag)
  if data then
    local waitTime = 10
    local nowSpan = CS.System.DateTime.UtcNow - m_startTime
    local afterTime = math.floor(nowSpan.TotalSeconds - data.startTime)
    if data.timerCount > 0 then
      waitTime = 300
    end
    local diff = waitTime - afterTime
    if 0 < diff and data.faild >= m_retryTimes then
      local tips = WU.GetString("Platform_ServerBusy", WU.RenderCountDownTime(diff, 38))
      WU.ShowMessageOK(tips, function()
        CS.GameGlobal.Instance:ResetGame()
      end)
      return false
    elseif diff <= 0 and 0 < data.faild and data.startTime > 0 then
      data.faild = 0
      data.startTime = 0
      data.timerCount = 1
      WU.SetGameDataCache(tag, data)
    end
  end
  return true
end

function OnDynamicConfig(config)
  local dirKey = "/dirsvr/DirAccount/"
  local accountKey = "/ClickGame/"
  if not CheckCanRequest(dirKey) or not CheckCanRequest(accountKey) then
    return
  end
  if config ~= nil then
    local luaTable = S:Get("ConfigDataManager").ClientBasicInfo()
    local wireFormatTable = ProtobufT("ReqDirAccount", luaTable)
    this:DirRequest("/dirsvr/DirAccount/"):Post(wireFormatTable, function(response)
      SaveRequestFaild(dirKey, true)
      CS.Restifizer.RestifizerManager.Instance.AccountServerUrl = response.accountUrl
      CS.Restifizer.RestifizerManager.Instance.AccountWebServerUrl = response.accountWebUrl
      local ClientInfo = m_configDataManager.ClientBasicInfo()
      local ClientInfoWireFormat = ProtobufT("ApiClickGame", ClientInfo)
      this:AccountRequest("/ClickGame/"):Post(ClientInfoWireFormat, function()
        SaveRequestFaild(accountKey, true)
      end, function()
        SaveRequestFaild(accountKey)
        return false
      end)
      this:SetData("AccountSwitch", response.accountSwitch)
      m_dirAccountGot = true
      CheckLatestVersion()
      if m_downloadFinished then
        TryEnterGame()
      end
    end, function()
      SaveRequestFaild(dirKey)
      return false
    end)
  end
end

function OnGamePreferencesChanged()
  SetVersion(m_configDataManager.FullVersion())
end

function UpdateProgress(progress, curDown, totalDown)
  REF.UpdateProgress.UISprite.fillAmount = progress
  m_curDownBytes = curDown
  local strCurDown = CS.GameUtility.ToHumanreadable(curDown)
  local strTotalDown = CS.GameUtility.ToHumanreadable(totalDown)
  local strDown = string.format("%s %s/%s", m_curStrDownSpeed, strCurDown, strTotalDown)
  REF.DownHtmlLabel.UIHtmlLabel.text = strDown
end

function UpdateText(text)
  REF.Process_Label.UILabel.text = text
end

function ShowProgressBar(show)
  WU.ToggleRendering(REF.Bottom, show)
end

function SetVersion(version)
  REF.Label_Version.UILabel.text = WU.GetString("TXVersion", version)
  CS.BuglyAgent.PrintLog(CS.LogSeverity.LogInfo, "Client version: " .. version)
end

function OnSceneAwake(scene)
  if scene == "SceneLogin" then
    WU.BringToFront(this, 9999)
  end
end

function SetPublisherCallback(callback)
  m_publisherCallback = callback
end

function PlayRandomLogoVoice()
  local actorConfig = PB.all("ActorConfig"):where(function(k, v)
    return v.enableStartVoice
  end):toarray()
  if actorConfig == nil then
    return
  end
  local selected = actorConfig[math.random(1, #actorConfig)]
  CS.SoundManager.Instance:PlaySound("Voice/" .. selected.voiceRes .. "/Event/Start", 1.0)
end

function PresentNextPublisher()
  PlayRandomLogoVoice()
  WU.RestartTween(REF.MainPanel:query(typeof(CS.UITweener), function(comp)
    return comp.tweenGroup == 1
  end), function()
    m_publisherCallback()
  end)
end

function GetHerosHaveOpened()
  local patchLoadingHeros = PB.all("PatchLoadingHeroDisplay")
  local openedHeros = {}
  for i = 1, #patchLoadingHeros do
    local heroInfo = PB.get("ActorConfig", patchLoadingHeros[i].dropActorDisplayID)
    if heroInfo ~= nil then
      local isOpen = AU.IsActorOpen(heroInfo.id, heroInfo.openTime)
      if isOpen then
        table.insert(openedHeros, {
          dropActorDisplayID = heroInfo.id
        })
      end
    end
  end
  return openedHeros
end

function UninitWindow()
end

function OnPatchNoticeClosed()
  m_isShowingDialog = false
  TryEnterGame()
end

function CheckLatestVersion()
  if m_isCheckedAppVersion then
    TryEnterGame()
    return
  end
  local contractPath = "app_version/"
  contractPath = contractPath .. "?api_version=2"
  contractPath = contractPath .. "&version=" .. m_configDataManager.FullVersion()
  contractPath = contractPath .. "&channel=" .. CS.ResourceManager.Instance.ConstConfig.ChannelId
  contractPath = contractPath .. "&gid=" .. CS.ResourceManager.Instance.ConstConfig.GameId
  local platform = "&platform=pc"
  platform = "&platform=android"
  contractPath = contractPath .. platform
  contractPath = contractPath .. "&publisher_install_channel=" .. CS.Msdk.WGPlatform.Instance:WGGetChannelId()
  contractPath = contractPath .. "&publisher_regsiter_channel=" .. CS.Msdk.WGPlatform.Instance:WGGetRegisterChannelId()
  m_isAppVersionDone = false
  this:VersionRequest(contractPath):Get(function(resp)
    m_isAppVersionDone = true
    if resp and resp.app_url then
      m_isShowingDialog = true
      local window = WU.AcquireWindow("PatchNotice")
      _ENV["$"](window)["$$SetNoticeData"](resp)
    else
      TryEnterGame()
    end
  end, function()
    m_isAppVersionDone = true
    TryEnterGame()
  end)
  m_isCheckedAppVersion = true
end

function OnButonRepair()
  WU.ShowMessageYesNo(WU.GetString("ScenePatch_RepairCheck"), function(result)
    if result == "YES" then
      CS.ScenePatch.Instance:CleanPatch()
      CS.GameGlobal.Instance:ResetGame()
    end
  end)
end
