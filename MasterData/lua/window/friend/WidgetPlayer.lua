local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local DBH = require("Manager/DataBindingHandler")
local PU = require("Common/PlatformUtil")
local ACU = require("Common/ActivityUtil")
local TPU = require("Common/TopPvpUtil")
local DU = require("Common/DungeonUtil")
local Msdk = CS.Msdk
local m_data, m_playerId, m_clickCallback

function Start()
  WU.BindButtonEvent(REF.Collider, function()
    if m_clickCallback ~= nil then
      m_clickCallback()
    else
      WU.RecordButtonClick(9903)
      WU.ShowPlayerOption(m_data, function()
        SetHighLighted(false)
      end)
      SetHighLighted(true)
    end
  end)
  WU.BindButtonEvent(REF.PlayerGiftSprite, function()
    WU.AcquireWindowAsync("FriendGift")
  end)
  WU.BindButtonEvent(REF.BtnAllow, OnBtnAllowClick)
  WU.BindButtonEvent(REF.BtnRefuse, OnBtnRefuseClick)
  WU.BindButtonEvent(REF.BtnAddFriend, OnBtnAddFriend)
  WU.BindButtonEvent(REF.ButtonRecall, OnRecall)
  if REF.ButtonFight then
    WU.BindButtonEvent(REF.ButtonFight, OnBtnFight)
  end
  WU.BindButtonEvent(REF.FromQQSprite, function()
    WU.AcquireWindowAsync("PlatformStartPage", function(ui)
      _ENV["$"](ui)["$$SetData"]({socialPlatform = 2})
    end)
  end)
  REF.FromQQ.gameObject:SetActive(false)
  REF.FromWX.gameObject:SetActive(false)
  WU.ToggleRendering(REF.ButtonRecall, false)
end

function OnBtnFight()
  local isUnlockMe = ACU.IsActivityUnlocked(PB.enum.ActivityType.TopPVP)
  local isUnlockOther = TPU.IsFriendPVPUnlock(m_data.level)
  if isUnlockMe and isUnlockOther then
    local function OnMatchClick()
      TPU.InviteFriendPVP(m_playerId)
    end
    
    if not DU.IsWaitingForJob(OnMatchClick) then
      OnMatchClick()
    end
  elseif not isUnlockMe then
    WU.ShowHintText(WU.GetString("TopPvpJoin_Tips53"))
  else
    WU.ShowHintText(WU.GetString("TopPvpJoin_Tips68"))
  end
end

function OnEnable()
  this:RegisterGameEvent("WidgetPlayer/Unselect", SetHighLighted)
end

function OnDisable()
  this:UnregisterGameEvent("WidgetPlayer/Unselect", SetHighLighted)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetHighLighted(flag)
  REF.SelectSprite.gameObject:SetActive(flag)
end

function OnRecall()
  WU.RecordButtonClick(9924)
  WU.ShowMessageYesNo(WU.GetString("Window_ConfirmRecallFriend", m_data.name), function(message)
    if message == "YES" then
      local baseinfo = this:GetData("fci/baseinfo/")
      local fopenid = m_data.socialOpenId
      local title = WU.GetString("Msdk_Recall_Title")
      local previewText = WU.GetString("Msdk_Recall_PreviewText")
      local tag = "MSG_INVITE"
      local callbackInfo = "msdkCallbackInfo"
      local testRtn = false
      if m_data.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
        local messageExt = "inviteReCall"
        testRtn = CS.Msdk.WGPlatform.Instance:WGSendToWXGameFriend(fopenid, title, previewText, "", messageExt, tag, callbackInfo)
      elseif m_data.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
        local summary = WU.GetString("Msdk_Recall_QQ_Summary")
        local targetUrl = "http://gamecenter.qq.com/gcjump?game_tag=MSG_INVITE&plat=qq&pf=invite&appid=100703379&originuin=61793295"
        targetUrl = targetUrl .. "&from=androidqq"
        local imgUrl = PB.all("Misc"):first().msdkFriendIcon
        testRtn = CS.Msdk.WGPlatform.Instance:WGSendToQQGameFriend(1, fopenid, title, summary, targetUrl, imgUrl, previewText, tag, callbackInfo)
      end
      if testRtn then
        this:GameRequest("fci/FriendRecall/"):Post({
          playerId = m_data.playerId
        }, function(res)
          local data = this:GetData("fci/FriendRecall/")
          if data then
            data.players[#data.players + 1] = m_data.playerId
          end
          UpdateRecallBtn(data)
        end)
        WU.ShowHintText(WU.GetString("Msdk_Recall_Success"))
      end
    end
  end)
end

function UpdateRecallBtn(data)
  if data == nil or m_data == nil then
    return
  end
  local playerInfo = m_data
  local switch = this:GetData("AccountSwitch")
  local sinceLastLogin = PB.all("Misc"):first().recallSinceLastLogin
  local day1 = CS.GameTime.UtcToLocal(playerInfo.lastLogoutTime)
  local lastLoginTime = CS.System.DateTime(day1.Year, day1.Month, day1.Day)
  local day2 = CS.GameTime.serverNow
  local srvTime = CS.System.DateTime(day2.Year, day2.Month, day2.Day)
  local diff = CS.GameTime.ToSeconds(srvTime) - CS.GameTime.ToSeconds(lastLoginTime)
  local diffDay = math.floor(diff / 86400)
  local flag = FU.IsSocialFriend(playerInfo) and playerInfo.lastLogoutTime ~= 0 and sinceLastLogin <= diffDay and switch.Share and playerInfo.level >= 10
  WU.ToggleRendering(REF.ButtonRecall, flag)
  local bEnable = true
  if REF.ButtonRecall.gameObject.activeSelf then
    for i, v in ipairs(data.players) do
      if v == m_data.playerId then
        bEnable = false
        break
      end
    end
    REF.ButtonRecall.UISprite.graify = not bEnable
    REF.ButtonRecall.BoxCollider2D.enabled = bEnable
  end
end

function SetPlayerInfo(playerInfo)
  if playerInfo then
    m_data = playerInfo
    REF.PlayerLvLabel.UILabel.text = WU.GetString("Window_Level", playerInfo.level)
    REF.PlayerOfflineLabel.UIHtmlLabel.text = FU.LastLogoutTime(playerInfo.lastLogoutTime, REF.PlayerOfflineLabel.UIHtmlLabel.fontSize)
    REF.WidgetPlayerName["$SetData"]({playerInfo = playerInfo})
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerInfo)
    WU.ToggleRendering(REF.Visual, true)
  end
end

function SetData(data, type)
  REF.FromQQ.gameObject:SetActive(false)
  if REF.ButtonFight then
    REF.ButtonFight.gameObject:SetActive(false)
  end
  local playerInfo = data
  local accountCache = this:GetData("accountCache")
  local switch = this:GetData("AccountSwitch")
  if switch and playerInfo and playerInfo.socialPlatform and switch.QQGameCenterPrivilege and accountCache.socialPlatform == playerInfo.socialPlatform then
    local platform = U.ToEnum(CS.Msdk.ePlatform, playerInfo.socialPlatform)
    if platform == CS.Msdk.ePlatform.ePlatform_QQ then
      local now = CS.GameTime.serverNow
      local loginTime = CS.GameTime.UtcToLocal(playerInfo.gamecenterLoginTime)
      local isLogin = now.Day == loginTime.Day
      if isLogin then
        local isPrivilegeIgnore = false
        local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
        isPrivilegeIgnore = PU.IsPrivilegeIgnore(channel)
        REF.FromQQ.gameObject:SetActive(not isPrivilegeIgnore)
      end
    end
  end
  REF.FromWX.gameObject:SetActive(false)
  WU.ToggleRendering(REF.ButtonRecall, false)
  if data == nil then
    return
  end
  WU.ToggleRendering(REF.Visual, false)
  WU.TraverseChildren(REF.OptionNode, function(go)
    WU.ToggleRendering(go, false)
  end)
  if type == 1 then
    if REF.ButtonFight then
      REF.ButtonFight.gameObject:SetActive(true)
    end
    m_playerId = data.playerId
    m_playerId = data.playerId
    SetPlayerInfo(data)
    WU.ToggleRendering(REF.PlayerGiftSprite, true)
  elseif type == 3 then
    WU.ToggleRendering(REF.BtnAllow, true)
    WU.ToggleRendering(REF.BtnRefuse, true)
    SetPlayerInfo(data)
  elseif type == 4 then
    WU.ToggleRendering(REF.BtnAddFriend, true)
    SetPlayerInfo(data)
  elseif type == 5 then
    SetPlayerInfo(data)
  end
  WU.ToggleRendering(REF.SlideArrow, true)
  CheckTopPvpFriendContinueBattle()
end

function CheckTopPvpFriendContinueBattle()
  local data = this:GetData("TopPvpFriendBalanceInfo")
  if data and data.playerId == m_playerId then
    this:SetData("TopPvpFriendBalanceInfo", nil)
    this:DelayInvokeInSeconds(0.1, function()
      OnBtnFight()
    end)
  end
end

function SetSocialData(data)
  REF.FromQQ.gameObject:SetActive(false)
  REF.FromWX.gameObject:SetActive(false)
  local playerInfo = data.playerInfo
  local accountCache = this:GetData("accountCache")
  local switch = this:GetData("AccountSwitch")
  if switch and playerInfo and playerInfo.socialPlatform and switch.QQGameCenterPrivilege and accountCache.socialPlatform == playerInfo.socialPlatform then
    local platform = U.ToEnum(CS.Msdk.ePlatform, playerInfo.socialPlatform)
    if platform == CS.Msdk.ePlatform.ePlatform_QQ then
      local now = CS.GameTime.serverNow
      local loginTime = CS.GameTime.UtcToLocal(playerInfo.gamecenterLoginTime)
      local isLogin = now.Day == loginTime.Day
      local isPrivilegeIgnore = false
      local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
      isPrivilegeIgnore = PU.IsPrivilegeIgnore(channel)
      REF.FromQQ.gameObject:SetActive(isLogin and not isPrivilegeIgnore)
    end
  end
  if REF.ButtonFight then
    REF.ButtonFight.gameObject:SetActive(true)
  end
  WU.TraverseChildren(REF.OptionNode, function(go)
    WU.ToggleRendering(go, false)
  end)
  m_data = data.playerInfo
  m_playerId = m_data.playerId
  local msdkInfo = data.msdkInfo
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](playerInfo)
  if msdkInfo ~= nil then
    WU.ToggleRendering(REF.PlayerGiftSprite, true)
    REF.PlayerGiftSprite.gameObject:SetActive(true)
    this:Unbind("fci/FriendRecall/", UpdateRecallBtn)
    this:Bind("fci/FriendRecall/", UpdateRecallBtn)
  else
    error("MSDK", "no msdkInfo ")
  end
  if playerInfo ~= nil then
    REF.PlayerOfflineLabel.UIHtmlLabel.text = FU.LastLogoutTime(playerInfo.lastLogoutTime, REF.PlayerOfflineLabel.UIHtmlLabel.fontSize)
    REF.PlayerLvLabel.UILabel.text = "Lv." .. playerInfo.level
  else
    error("MSDK", "no playerInfo ")
  end
  REF.WidgetPlayerName["$SetData"]({msdkInfo = msdkInfo, playerInfo = playerInfo})
  WU.ToggleRendering(REF.SlideArrow, true)
end

function OnBtnAddFriend(go)
  WU.RecordButtonClick(9927)
  this:GameRequest("fci/applyfriend/"):Post({
    targetId = m_data.playerId
  }, function(result)
    if U.trim(result.playerId) == "" then
      WU.ShowHintText(WU.GetString("Window_SearchPlayerNotExist"))
      return
    end
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
    FU.RemoveFromRecommendlist(result.playerId)
  end)
end

function OnBtnAllowClick(go)
  WU.RecordButtonClick(9926)
  this:GameRequest("fci/applylist/"):Post({
    targetId = m_data.playerId,
    isAgree = true
  }, function(result)
    FU.RemoveLatestTalkTarget(result.playerId)
    FU.RemoveFromRecommendlist(result.playerId)
    DBH.RelationApplylistRemove(result)
    DBH.RelationFriendlistChange(result)
  end)
end

function OnBtnRefuseClick(go)
  WU.RecordButtonClick(9925)
  this:GameRequest("fci/applylist/"):Post({
    targetId = m_data.playerId,
    isAgree = false
  }, function(result)
    DBH.RelationApplylistRemove(result)
  end)
end
