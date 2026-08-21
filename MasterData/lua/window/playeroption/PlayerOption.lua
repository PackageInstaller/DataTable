local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local FU = require("Common/FriendUtil")
local DBH = require("Manager/DataBindingHandler")
local CU = require("Common/ChatUtil")
local Msdk = CS.Msdk
local m_platform, m_accountSwitch
local m_visible = false
local m_context, m_playerInfo, m_cancelCallback, m_isOptionsUpdated
local m_showTweenerGroup = 0
local m_hideTweenerGroup = 1

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonAddFriend, OnAddFriendClick)
  WU.BindButtonEvent(REF.ButtonRemoveFriend, OnRemoveFriendClick)
  WU.BindButtonEvent(REF.ButtonPrivateChat, OnPrivateChatClick)
  WU.BindButtonEvent(REF.ButtonReport, OnReportClick)
  WU.BindButtonEvent(REF.ButtonBlock, OnBlockClick)
  WU.BindButtonEvent(REF.ButtonUnblock, OnUnblockClick)
  WU.BindButtonEvent(REF.ButtonGotoSpace, OnGotoSpaceClick)
  WU.BindButtonEvent(REF.ButtonQQFriend, OnQQFriendClick)
  WU.BindButtonEvent(REF.ButtonRecall, OnRecall)
  WU.BindButtonEvent(REF.ButtonDemise, OnDemiseClick)
  WU.BindButtonEvent(REF.ButtonPromote, OnPromoteClick)
  WU.BindButtonEvent(REF.ButtonDemote, OnDemoteClick)
  WU.BindButtonEvent(REF.ButtonKick, OnKickClick)
  REF.Black["$SetCallback"](Hide)
  CS.EventDelegate.Add(REF.Content.UIPlayTween.onFinished, function()
    if m_visible == false then
      this:BroadcastGameEvent("WidgetPlayer/Unselect", false)
      WU.RecycleWindow(this)
    end
  end)
  WU.BindKeyEvent(REF.ButtonNode, Hide)
end

function InitWindow()
  WU.ToggleRendering(REF.ButtonNode, false)
  Show()
  this:Bind("fci/guild-player/", OnGuildPlayerChange, false)
end

function UpdateOptions()
  local options = this:GetData("PlayerOptions")
  if options and m_playerInfo then
    WU.TraverseChildren(REF.ButtonNode, function(go)
      go:SetActive(false)
    end)
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.Friend) then
      REF.ButtonRemoveFriend.gameObject:SetActive(false)
      REF.ButtonAddFriend.gameObject:SetActive(false)
      REF.ButtonRemoveFriend.gameObject:SetActive(m_playerInfo.isInRelation)
      REF.ButtonAddFriend.gameObject:SetActive(not m_playerInfo.isInRelation and not m_playerInfo.isApplied)
    end
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.PrivateChat) then
      REF.ButtonPrivateChat.gameObject:SetActive(true)
    end
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.Report) then
      REF.ButtonReport.gameObject:SetActive(true)
    end
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.Blacklist) then
      if FU.IsBlock(m_context.playerId) then
        REF.ButtonUnblock.gameObject:SetActive(true)
      else
        REF.ButtonBlock.gameObject:SetActive(true)
      end
    end
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.GotoSpace) then
      REF.ButtonGotoSpace.gameObject:SetActive(true)
    end
    m_platform = this:GetData("accountCache").socialPlatform
    m_accountSwitch = this:GetData("AccountSwitch")
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.QQFriend) then
      local flag = m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ and not FU.IsSocialFriend(m_playerInfo) and m_accountSwitch.PlatRelation and m_playerInfo.socialOpenId ~= nil and m_playerInfo.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ
      REF.ButtonQQFriend.gameObject:SetActive(flag)
    end
    if CS.UIPlayerOptions.HasOption(PB.enum.PlayerOption.Guild) then
      local guildPlayer = this:GetData("fci/guild-player/")
      if GU.IsGuildPresident() then
        if GU.IsGuildVicePresident(m_context) then
          REF.ButtonDemise.gameObject:SetActive(true)
          REF.ButtonDemote.gameObject:SetActive(true)
        else
          REF.ButtonPromote.gameObject:SetActive(true)
        end
        REF.ButtonKick.gameObject:SetActive(true)
      elseif GU.IsGuildVicePresident() then
        REF.ButtonKick.gameObject:SetActive(not GU.IsGuildManager(m_context))
      end
    end
    REF.ButtonNode.UIGrid:Reposition()
    WU.ToggleRendering(REF.ButtonNode, true)
    m_isOptionsUpdated = true
  end
end

function UpdateWindow()
  if m_isOptionsUpdated == false then
    UpdateOptions()
  end
end

function OnGuildPlayerChange(guildPlayer)
  UpdateOptions()
end

function SetContext(data)
  m_playerInfo = nil
  m_context = data
  if m_context == nil then
    error("Player", "PlayerOption SetContext failed, parament is nil")
  else
    this:GameRequest("fci/playersummary/" .. m_context.playerId):Query("byid", 1):Get(function(result)
      m_playerInfo = result
    end)
  end
  m_isOptionsUpdated = false
end

function SetCancelCallback(callback)
  m_cancelCallback = callback
end

function Show()
  if not m_visible then
    m_visible = true
    REF.Content.UIPlayTween.tweenGroup = m_showTweenerGroup
    REF.Content.UIPlayTween:Play(true)
  end
end

function Hide()
  if m_visible then
    m_visible = false
    REF.Content.UIPlayTween.tweenGroup = m_hideTweenerGroup
    REF.Content.UIPlayTween:Play(true)
  end
  if m_cancelCallback then
    m_cancelCallback()
  end
end

function OnAddFriendClick(go)
  WU.RecordButtonClick(699)
  this:GameRequest("fci/applyfriend/"):Post({
    targetId = m_context.playerId
  }, function(result)
    if U.trim(result.playerId) == "" then
      WU.ShowHintText(WU.GetString("Window_SearchPlayerNotExist"))
      return
    end
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
  end)
end

function OnRemoveFriendClick(go)
  WU.RecordButtonClick(693)
  WU.ShowMessageYesNo(WU.GetString("Window_RemoveFriendHint"), function(result)
    if result == "YES" then
      this:GameRequest("fci/friendlist/" .. m_context.playerId):Delete(function(result)
        DBH.RelationFriendlistRemove(m_context.playerId)
        CU.AddLatestTalkTarget(m_context.playerId, m_context.name)
        Hide()
      end)
    end
  end)
end

function OnPrivateChatClick(go)
  WU.RecordButtonClick(698)
  CU.PrivateTalk(m_context)
  Hide()
end

function OnReportClick(go)
  WU.RecordButtonClick(694)
  WU.AcquireWindowAsync("PlayerReport", function(ui)
    _ENV["$"](ui).root["$SetPlayerId"](m_context.playerId)
  end)
  Hide()
end

function OnBlockClick(go)
  WU.RecordButtonClick(696)
  WU.ShowMessageYesNo(WU.GetString("Window_BlacklistHint"), function(result)
    if result == "YES" then
      FU.BlockPlayer(m_context.playerId)
    end
  end)
  Hide()
end

function OnUnblockClick(go)
  WU.RecordButtonClick(695)
  FU.UnblockPlayer(m_context.playerId)
  Hide()
end

function OnGotoSpaceClick(go)
  WU.RecordButtonClick(697)
  WU.ShowPlayerSpace(m_context.playerId, nil, "ToggleTeam")
  Hide()
end

function OnQQFriendClick(go)
  WU.RecordButtonClick(688)
  local desc = m_context.name
  local message = WU.GetString("Msdk_AddQQFriend_Message", this:GetData("fci/baseinfo").name)
  Msdk.WGPlatform.Instance:WGAddGameFriendToQQ(m_playerInfo.socialOpenId, desc, message)
end

function OnRecall()
  WU.RecordButtonClick(687)
  WU.ShowMessageYesNo(WU.GetString("Window_ConfirmRecallFriend", m_context.name), function(message)
    if message == "YES" then
      local baseinfo = this:GetData("fci/baseinfo/")
      local fopenid = m_playerInfo.socialOpenId
      local title = WU.GetString("Msdk_Recall_Title")
      local previewText = WU.GetString("Msdk_Recall_PreviewText", m_context.name, baseinfo.name)
      local tag = "MSG_INVITE"
      local callbackInfo = "msdkCallbackInfo"
      local testRtn = false
      if m_platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
        local messageExt = "inviteReCall"
        testRtn = Msdk.WGPlatform.Instance:WGSendToWXGameFriend(fopenid, title, previewText, "", messageExt, tag, callbackInfo)
      elseif m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
        local summary = "recall"
        local targetUrl = "http://gamecenter.qq.com/gcjump?game_tag=MSG_INVITE&plat=qq&pf=invite&appid=100703379&originuin=61793295"
        targetUrl = targetUrl .. "&from=androidqq"
        local imgUrl = "http://down.qq.com/dianji/fci_share/invite/title_image.png"
        testRtn = Msdk.WGPlatform.Instance:WGSendToQQGameFriend(1, fopenid, title, summary, targetUrl, imgUrl, previewText, tag, callbackInfo)
      end
      if testRtn then
        WU.ShowHintText(WU.GetString("Msdk_Recall_Success"))
      end
    end
  end)
end

function OnDemiseClick(go)
  WU.RecordButtonClick(692)
  WU.ShowMessageYesNo(WU.GetString("Window_GuildDemiseConfirm", m_context.name), function(result)
    if result == "YES" then
      this:GameRequest("fci/guild/{guildId}/president/"):Post({
        newPresident = m_context.playerId
      }, function(result)
        this:SetData("fci/guild/", result)
        local guildPlayer = this:GetData("fci/guild-player/")
        if guildPlayer then
          guildPlayer.type = PB.enum.GuildMemberType.Normal
          this:SetData("fci/guild-player/", guildPlayer)
        end
        local guildMembers = this:GetData("fci/guild/members/")
        local oldPresidentPlayerId = this:GetData("playerId")
        local _, oldPresident = _ENV["!"](guildMembers):find(function(k, v)
          return v.playerId == oldPresidentPlayerId
        end)
        if oldPresident then
          oldPresident.type = PB.enum.GuildMemberType.Normal
        end
        local _, newPresident = _ENV["!"](guildMembers):find(function(k, v)
          return v.playerId == m_context.playerId
        end)
        if newPresident then
          newPresident.type = PB.enum.GuildMemberType.President
          m_context = newPresident
        end
        this:SetData("fci/guild/members/", guildMembers)
        UpdateOptions()
        WU.ShowHintText(WU.GetString("Window_GuildMemberThrone", m_context.name))
      end)
    end
  end)
end

function OnPromoteClick(go)
  WU.RecordButtonClick(691)
  this:GameRequest("fci/guild/{guildId}/vice-president/"):Put({
    playerId = m_context.playerId
  }, function(result)
    this:SetData("fci/guild/", result)
    local guildMembers = this:GetData("fci/guild/members/")
    local _, member = _ENV["!"](guildMembers):find(function(k, v)
      return v.playerId == m_context.playerId
    end)
    if member then
      member.type = PB.enum.GuildMemberType.VicePresident
      m_context = member
      this:SetData("fci/guild/members/", guildMembers)
    end
    UpdateOptions()
    WU.ShowHintText(WU.GetString("Window_GuildMemberPromoted", m_context.name))
  end)
end

function OnDemoteClick(go)
  WU.RecordButtonClick(690)
  this:GameRequest("fci/guild/{guildId}/vice-president/" .. m_context.playerId):Delete(function(result)
    this:SetData("fci/guild/", result)
    local guildMembers = this:GetData("fci/guild/members/")
    local _, member = _ENV["!"](guildMembers):find(function(k, v)
      return v.playerId == m_context.playerId
    end)
    if member then
      member.type = PB.enum.GuildMemberType.Normal
      m_context = member
      this:SetData("fci/guild/members/", guildMembers)
    end
    UpdateOptions()
    WU.ShowHintText(WU.GetString("Window_GuildMemberDemoted", m_context.name))
  end)
end

function OnKickClick(go)
  WU.RecordButtonClick(689)
  WU.ShowMessageYesNo(WU.GetString("Window_GuildKickMemberConfirm", m_context.name), function(result)
    if result == "YES" then
      this:GameRequest("fci/guild/{guildId}/members/" .. m_context.playerId):Delete(function(result)
        this:SetData("fci/guild/", result)
        local guildMembers = this:GetData("fci/guild/members/")
        local index, _ = _ENV["!"](guildMembers):find(function(k, v)
          return v.playerId == m_context.playerId
        end)
        if index then
          table.remove(guildMembers, index)
          this:SetData("fci/guild/members/", guildMembers)
        end
        Hide()
      end)
    end
  end)
end
