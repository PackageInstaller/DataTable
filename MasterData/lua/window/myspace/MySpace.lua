local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local NU = require("Common/NotepadUtil")
local GuildUtil = require("Common/GuildUtil")
local PU = require("Common/PlatformUtil")
local LU = require("Common/ListUtil")
local DeclareCharacterLimit = 32
local MessagePerPage = 6
local permissionPB = {
  PB.enum.PlayerMessageBoardPermission.Anyone,
  PB.enum.PlayerMessageBoardPermission.OnlyFriends,
  PB.enum.PlayerMessageBoardPermission.OnlySelf
}
local m_repeatedContext = {}
local Msdk = CS.Msdk
local m_hasNext, m_playerInfo, m_isMySelfSpace, m_selectedGroupId, m_selfPlayerId, m_curPageNumber, m_messages, m_messageTo, m_pollingMessages
local m_hasClickLike = false
local m_messageSetting, m_allowLeaveMessage
local mNormalLikeTextColor = CS.NGUIMath.HexToColor(26864127)
local mEnableLikeTextColor = CS.NGUIMath.HexToColor(4294967295)
local m_allMedals, m_medalList, m_medalListNotFight
local m_collectionsCount = _ENV["!"]({})
local m_collections = _ENV["!"]({})

function SetupWindow()
  REF.NodeGenders.gameObject:SetActive(true)
  REF.NodeTeam.gameObject:SetActive(true)
  REF.NodeFavorite.gameObject:SetActive(true)
  REF.NodeMessageBoard.gameObject:SetActive(true)
  REF.NodeCollections.gameObject:SetActive(true)
  REF.NodeMedalList.gameObject:SetActive(true)
  UpdateLikeNumber(0)
  WU.BindButtonEvent(REF.NodePlayerGender, OnClickPlayerGender)
  WU.BindButtonEvent(REF.NodePlayerDeclare, OnClickPlayerDeclare)
  WU.BindButtonEvent(REF.BtnAddFriend, OnClickAddFriend)
  WU.BindButtonEvent(REF.NameNode, OnNamePatch)
  REF.WidgetGroupMembers["$SetClickCallback"](OnClickMember)
  WU.BindButtonEvent(REF.Books, OnClickFavBook)
  WU.BindButtonEvent(REF.SpriteSend, OnMessageSubmit)
  WU.BindButtonEvent(REF.GenderMask, function()
    WU.ToggleRendering(REF.NodeGenders, false)
  end)
  WU.BindButtonEvent(REF.SettingMask, function()
    WU.ToggleRendering(REF.SettingDetailNode, false)
  end)
  WU.BindButtonEvent(REF.SpaceSettings, function()
    WU.ToggleRendering(REF.SettingDetailNode, true)
  end)
  WU.TraverseChildren(REF.GenderGrid, function(go, i)
    WU.BindButtonEvent(go, function()
      local patchTable = {
        sex = i + 1
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
        this:SetData("Space/SelectedPlayerOther", result)
        WU.ToggleRendering(REF.NodeGenders, false)
      end)
    end)
  end)
  WU.TraverseChildren(REF.Actors, function(go, i)
    WU.BindButtonEvent(go, OnClickFavActor)
  end)
  WU.TraverseChildren(REF.SettingGrid, function(go, i)
    WU.BindButtonEvent(go, function()
      for i = 1, #REF.SettingGrid do
        REF.SettingGrid[i - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_n"
      end
      _ENV["$"](go).CheckBoxSprite.UISprite.spriteName = "checkbox_s"
      local patchTable = {
        messageBoardPermission = permissionPB[i + 1]
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      end)
    end)
  end)
  WU.BindButtonEvent(REF.ToggleMessage, function()
    WU.ToggleRendering(REF.TryToDeleteMask, false)
    this:BroadcastGameEvent("ResetAllDeleteBtn")
    REF.MsgScrollView.UIScrollView:ResetPosition()
  end)
  CS.EventDelegate.Add(REF.MsgScrollView.UIScrollView.onNext, OnNext)
  CS.EventDelegate.Add(REF.MsgScrollView.UIScrollView.onPrev, function()
  end)
  WU.BindButtonEvent(REF.TryToDeleteMask, function()
    WU.ToggleRendering(REF.TryToDeleteMask, false)
    this:BroadcastGameEvent("ResetAllDeleteBtn")
  end)
  WU.BindButtonEvent(REF.BtnGuildDetail, OnGuildDetailClick)
  WU.BindButtonEvent(REF.BtnGuildInvite, OnGuildInviteClick)
  WU.BindButtonEvent(REF.NodeStar, OnClickLike)
  SetupMedalList()
  SetupCollectionList()
  Reset()
end

function UpdateLikeNumber(num)
  if m_hasClickLike then
    REF.LabelStarCntB.UILabel.color = mEnableLikeTextColor
  else
    REF.LabelStarCntB.UILabel.color = mNormalLikeTextColor
  end
  if 9999 < num then
    num = 9999
  end
  REF.LabelStarCnt.UILabel.text = tostring(num)
  REF.LabelStarCntB.UILabel.text = tostring(num)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_playerInfo)
  m_pollingMessages = true
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local playerInfo = m_repeatedContext[#m_repeatedContext]
    table.remove(m_repeatedContext, #m_repeatedContext)
    if playerInfo.playerId ~= m_playerInfo.playerId then
      m_pollingMessages = true
    end
    this:SetData("Space/SelectedPlayerOther", playerInfo)
  end
end

function InitWindow()
  this:Bind("Space/SelectedPlayerOther", OnPlayerInfo, false)
  this:RegisterGameEvent("OnLinkClick", function(param)
    if string.find(param, "MessageTo") then
      m_messageTo = U.SplitStr(param, ":")[2]
      REF.InputComment.UIInput.isSelected = true
    end
  end)
  this:RegisterGameEvent("SpaceMessageDeleted", function(msgId)
    local idx = table.find(m_messages, function(k, v)
      return v.id == msgId
    end)
    if idx ~= nil then
      table.remove(m_messages, idx)
    end
    RefreshMessages()
  end)
  this:RegisterGameEvent("TryToDeleteMask", function()
    WU.ToggleRendering(REF.TryToDeleteMask, true)
  end)
end

function UninitWindow()
  this:SetData("Space/DisplayInfo", nil)
end

function UpdateWindow()
  REF.MsgTable.UITable:Reposition()
end

function UpdateStar()
  if m_hasClickLike then
    REF.SpriteStarB01.UISprite.spriteName = "myspace_tag_01"
    REF.SpriteStarB02.UISprite.spriteName = "myspace_tag_02"
    REF.LikeIconB.UISprite.spriteName = "like_n"
  else
    REF.SpriteStarB01.UISprite.spriteName = "myspace_tag_11"
    REF.SpriteStarB02.UISprite.spriteName = "myspace_tag_12"
    REF.LikeIconB.UISprite.spriteName = "like_s"
  end
  if m_playerInfo and m_playerInfo.likeNums then
    UpdateLikeNumber(m_playerInfo.likeNums)
  else
    UpdateLikeNumber(0)
  end
end

function OnClickLike()
  if m_playerInfo and not m_hasClickLike and m_playerInfo.playerId ~= m_selfPlayerId then
    REF.BaseInfoBG.UIPlayTween:Play(true)
    this:GameRequest("fci/PageClickLikeView/" .. m_playerInfo.playerId):Post(nil, function(result)
      if result then
        if m_playerInfo.likeNums and result.isClicked == true then
          m_playerInfo.likeNums = m_playerInfo.likeNums + 1
        end
        m_hasClickLike = result.isClicked
        UpdateStar()
      end
    end)
  end
end

function SetPlayerDetail(playerId, resetToggle, selectToggle)
  if playerId ~= nil then
    Reset()
    this:GameRequest("fci/playerpageinfo/" .. playerId):Get(function(result)
      this:SetData("Space/SelectedPlayerOther", result)
    end)
    if resetToggle then
      REF.ToggleTeam.UIToggle.value = true
    end
    if selectToggle == "ToggleMedalList" then
      REF.ToggleMedalList.UIToggle.value = true
    elseif selectToggle == "ToggleTeam" then
      REF.ToggleTeam.UIToggle.value = true
    end
  end
end

function Reset()
  m_messageTo = nil
  m_pollingMessages = true
  m_curPageNumber = 0
  m_hasClickLike = false
  m_messages = {}
  UpdateStar()
  m_selfPlayerId = this:GetData("playerId")
  REF.InputComment.UIInput.defaultText = WU.GetString("Window_DefaultTextForUIInput")
  WU.ToggleRendering(REF.SettingDetailNode, false)
  WU.ToggleRendering(REF.NodeGenders, false)
  WU.ToggleRendering(REF.BtnGuildDetail, false)
  WU.ToggleRendering(REF.BtnGuildInvite, false)
  WU.ToggleRendering(REF.LabelInvited, false)
  WU.ToggleRendering(REF.BtnAddFriend, false)
  WU.ToggleRendering(REF.BtnIsApplied, false)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  WU.ToggleRendering(REF.NodeMessageBoard, false)
  WU.ToggleRendering(REF.NodeFavorite, false)
  WU.ToggleRendering(REF.Visual, false)
  WU.ToggleRendering(REF.Medals, false)
  WU.ToggleRendering(REF.Aura, false)
  WU.ToggleRendering(REF.NodeEmpty, false)
  WU.ToggleRendering(REF.NodeMedalList, false)
  WU.ToggleRendering(REF.NodeCollections, false)
end

function OnPlayerInfo(data)
  Reset()
  local isPrivilegeIgnore = false
  local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
  isPrivilegeIgnore = PU.IsPrivilegeIgnore(channel)
  if data == nil then
    return
  end
  m_playerInfo = data
  this:GameRequest("fci/PageClickLikeView/" .. m_playerInfo.playerId):Get(function(result)
    if result then
      m_hasClickLike = result.isClicked
      UpdateStar()
    end
  end)
  m_isMySelfSpace = data.playerId == m_selfPlayerId
  REF.WidgetPersonalPlatform["$SetData"](data, not isPrivilegeIgnore)
  REF.GridBaseInfo.UIGrid:Reposition()
  REF.LabelPlayerName.UILabel.text = m_playerInfo.name
  REF.LabelPlayerID.UILabel.text = m_playerInfo.playerId
  REF.LabelData.UILabel.text = m_playerInfo.level
  local levelName, curTrophy = AU.GetAchievementInfo(data.achievementPoint)
  REF.SpriteData.UISprite.spriteName = "home/cup_icon_" .. curTrophy
  REF.LabelAchievement.UILabel.text = levelName
  if U.trim(m_playerInfo.sign) == "" then
    if m_isMySelfSpace then
      REF.SignLabel.UILabel.text = WU.GetString("Window_SpaceSignEmptySelf", DeclareCharacterLimit)
    else
      REF.SignLabel.UILabel.text = WU.GetString("Window_SpaceSignEmpty")
    end
  else
    REF.SignLabel.UILabel.text = m_playerInfo.sign
  end
  REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(m_playerInfo.sex or 0, true)
  UpdateStar()
  if m_isMySelfSpace then
    this:Bind("Msdk/baseinfo/", function(msdkBaseinfo)
      if msdkBaseinfo ~= nil and m_playerInfo.sex == PB.enum.PlayerSex.None then
        REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(msdkBaseinfo.gender, true)
      end
    end)
  else
    this:Bind("fci/socialfriend/", function(socialFriendList)
      if socialFriendList ~= nil then
        local _, player = table.find(socialFriendList, function(_, v)
          return v.playerInfo.playerId == m_playerInfo.playerId
        end)
        if player ~= nil and m_playerInfo.sex == PB.enum.PlayerSex.None then
          REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(player.msdkInfo.gender, true)
        end
      end
    end)
  end
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](data)
  REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
    if not m_isMySelfSpace then
      return
    end
    WU.AcquireWindowAsync("MySpacePlayerHeadBox")
  end)
  WU.ToggleRendering(REF.Visual, true)
  if m_playerInfo.showGroup == nil then
    local members = {
      {index = 0, actorUid = 0},
      {index = 1, actorUid = 0},
      {index = 2, actorUid = 0},
      {index = 3, actorUid = 0},
      {index = 4, actorUid = 0},
      {index = 5, actorUid = 0}
    }
    m_playerInfo.showGroup = {}
    m_playerInfo.showGroup["1"] = {members = members}
  elseif m_playerInfo.showGroup["1"] == nil then
    local membersTable = m_playerInfo.showGroup
    m_playerInfo.showGroup = {}
    if membersTable == nil or table.count(membersTable.members) ~= 6 then
      membersTable = {
        members = {
          {index = 0, actorUid = 0},
          {index = 1, actorUid = 0},
          {index = 2, actorUid = 0},
          {index = 3, actorUid = 0},
          {index = 4, actorUid = 0},
          {index = 5, actorUid = 0}
        }
      }
    end
    m_playerInfo.showGroup["1"] = membersTable
  end
  local members = m_playerInfo.showGroup["1"].members
  REF.WidgetGroupMembers["$SetSpaceGroupMembers"](members, not m_isMySelfSpace)
  REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  WU.ToggleRendering(REF.WidgetGroupMembers, true)
  REF.Settings.gameObject:SetActive(m_isMySelfSpace)
  if not m_isMySelfSpace then
    REF.InputComment.UISprite.width = 960
  else
    REF.InputComment.UISprite.width = 850
  end
  if 0 < m_playerInfo.guildId then
    if m_isMySelfSpace then
      local guild = this:GetData("fci/guild/")
      REF.LabelGuild.UILabel.text = guild.name
    else
      REF.LabelGuild.UILabel.text = ""
      this:GameRequest("fci/guild/" .. m_playerInfo.guildId):Get(function(guild)
        if guild then
          REF.LabelGuild.UILabel.text = guild.baseInfo.name
          this:SetData("fci/guild/" .. m_playerInfo.guildId, guild.baseInfo)
        end
      end)
    end
    WU.ToggleRendering(REF.BtnGuildDetail, true)
  else
    REF.LabelGuild.UILabel.text = WU.GetString("Window_GuildNotExist")
    if not m_isMySelfSpace then
      local guildPlayer = this:GetData("fci/guild-player/")
      local invitedMembers = this:GetData("fci/guild/invited-members/")
      if 0 < guildPlayer.guildId and invitedMembers then
        if _ENV["!"](invitedMembers):find(function(k, v)
          return v.playerId == m_playerInfo.playerId
        end) then
          WU.ToggleRendering(REF.LabelInvited, true)
        else
          local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.Guild, nil, m_playerInfo.level)
          WU.ToggleRendering(REF.BtnGuildInvite, not locked and GuildUtil.IsGuildManager())
        end
      end
    end
  end
  OnListChange(m_playerInfo.allMedals, m_playerInfo.fightMedal)
  SetFavorite(m_playerInfo)
  WU.ToggleRendering(REF.NodeFavorite, true)
  SetMessageSetting(m_playerInfo)
  SetAura(m_playerInfo)
  WU.ToggleRendering(REF.Aura, true)
  SetCollectionData()
  WU.ToggleRendering(REF.NodeCollections, true)
  this:Bind("fci/friendlist/", function(friendlist)
    if friendlist ~= nil and not m_isMySelfSpace then
      local idx = table.find(friendlist, function(k, v)
        return v.playerId == m_playerInfo.playerId
      end)
      if idx == nil and m_messageSetting == PB.enum.PlayerMessageBoardPermission.Anyone then
        WU.ToggleRendering(REF.NodeInput, true)
      elseif idx ~= nil and m_messageSetting ~= PB.enum.PlayerMessageBoardPermission.OnlySelf then
        WU.ToggleRendering(REF.NodeInput, true)
      end
    end
    if not m_isMySelfSpace then
      WU.ToggleRendering(REF.BtnAddFriend, not m_playerInfo.isApplied and not m_playerInfo.isInRelation)
      WU.ToggleRendering(REF.BtnIsApplied, m_playerInfo.isApplied)
    else
      WU.ToggleRendering(REF.BtnAddFriend, false)
      WU.ToggleRendering(REF.NodeInput, true)
    end
  end)
  if m_pollingMessages then
    this:GameRequest("fci/player-message/" .. m_playerInfo.playerId):Page(m_curPageNumber, MessagePerPage):Get(function(result)
      if #result == MessagePerPage then
        m_hasNext = true
        m_curPageNumber = m_curPageNumber + 1
      else
        m_hasNext = false
      end
      m_messages = result
      RefreshMessages(true)
      WU.ToggleRendering(REF.NodeMessageBoard, true)
      m_pollingMessages = false
    end)
  end
end

function SetAura(playerInfo)
  local ref = REF.WidgetIconSlotAssist
  if playerInfo.auraActorId ~= nil and playerInfo.auraActorId > 0 then
    WU.ToggleRendering(REF.SpriteSlotBGAura, false)
    WU.ToggleRendering(REF.WidgetIconSlotAssist, true)
    local actorId = playerInfo.auraActorId
    ref["$SetActorCustom"]({
      id = actorId,
      quality = playerInfo.auraActorQuality
    })
    WU.ToggleRendering(REF.NoAuraLabel, false)
    WU.ToggleRendering(REF.ActorNameLabel, true)
    WU.ToggleRendering(REF.DescLabel, true)
    REF.ActorNameLabel.UILabel.text = WU.GetString("ActorName_" .. actorId)
    local actorQualityInfo = PB.get("ActorQualityInfo", actorId, playerInfo.auraActorQuality)
    REF.DescLabel.UIHtmlLabel.text = AU.RenderAuraOrMedalAttr(actorQualityInfo, nil, "MySpace")
  else
    WU.ToggleRendering(REF.SpriteSlotBGAura, not m_isMySelfSpace)
    WU.ToggleRendering(REF.WidgetIconSlotAssist, m_isMySelfSpace)
    ref["$SetEmpty"](1)
    WU.ToggleRendering(REF.NoAuraLabel, true)
    WU.ToggleRendering(REF.ActorNameLabel, false)
    WU.ToggleRendering(REF.DescLabel, false)
  end
  ref["$SetClickCallback"](function()
    if m_isMySelfSpace then
      WU.AcquireWindowAsync("MySpaceAuraEdit")
    else
      WU.AcquireWindowAsync("ItemDetail", function(window)
        _ENV["$"](window)["$$SetAuraActor"](m_playerInfo.auraActorId, m_playerInfo.auraActorQuality)
      end)
    end
  end)
end

function SetMessageSetting(playerInfo)
  m_messageSetting = playerInfo.messageBoardPermission
  for i = 1, #REF.SettingGrid do
    REF.SettingGrid[i - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_n"
  end
  if 0 < m_messageSetting then
    REF.SettingGrid[m_messageSetting - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_s"
  else
    REF.SettingGrid[0].CheckBoxSprite.UISprite.spriteName = "checkbox_s"
  end
  WU.ToggleRendering(REF.NodeInput, false)
  if m_messageSetting == PB.enum.PlayerMessageBoardPermission.None then
    WU.ToggleRendering(REF.NodeInput, true)
  end
end

function SetFavorite(playerInfo)
  for i = 1, 5 do
    local role = playerInfo.favorRoles[i]
    local ref = REF.Actors[i - 1]
    if role ~= nil then
      local xlsx = PB.get("Role", role)
      ref.PicSprite.UISprite.enabled = xlsx ~= nil
      if xlsx then
        ref.PicSprite.UISprite.spriteName = "actor_head_" .. xlsx.animRes
      else
        warning("MySpace", "Role.xlsx error, roleId " .. tostring(role))
      end
    else
      ref.PicSprite.UISprite.enabled = false
    end
  end
  for i = 1, 5 do
    local book = playerInfo.favorBooks[i]
    local ref = REF.Books[i - 1]
    if book ~= nil then
      ref.PicSprite.UISprite.spriteName = "book_" .. book
      ref.PicSprite.UISprite.tintAsAdd = false
      ref.PicSprite.UISprite.alpha = 1
    else
      ref.PicSprite.UISprite.spriteName = "book_1"
      ref.PicSprite.UISprite.tintAsAdd = true
      ref.PicSprite.UISprite.alpha = 0.4
    end
  end
end

function OnClickPlayerGender()
  if not m_isMySelfSpace then
    return
  end
  WU.ToggleRendering(REF.NodeGenders, true)
end

function OnClickPlayerDeclare()
  if not m_isMySelfSpace then
    return
  end
  WU.ShowEditBox({
    title = WU.GetString("WindowSpace_EditDeclareTitle"),
    subTitle = WU.GetString("WindowSpace_EditDeclareSubTitle"),
    multiple = true,
    defaultText = m_playerInfo.sign,
    characterLimit = DeclareCharacterLimit,
    allowEmpty = true
  }, function(text)
    local patchTable = {sign = text}
    local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
    this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      this:SetData("Space/SelectedPlayerOther", result)
    end)
    return true
  end)
end

function OnClickAddFriend()
  this:GameRequest("fci/applyfriend/"):Post({
    targetId = m_playerInfo.playerId
  }, function(result)
    if U.trim(result.playerId) == "" then
      WU.ShowHintText(WU.GetString("Window_SearchPlayerNotExist"))
      return
    end
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
    WU.ToggleRendering(REF.BtnAddFriend, false)
    WU.ToggleRendering(REF.BtnIsApplied, true)
  end)
end

function OnClickMember(go)
  if m_isMySelfSpace then
    this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
    this:SetData("SpaceActorSelect/Mode", "Space")
    WU.AcquireWindowAsync("SpaceActorSelect")
  else
    local actorInfo = _ENV["$"](go)["@actor"]
    local equips = _ENV["$"](go)["@equips"]
    local displayInfo = {actorInfo = actorInfo, equips = equips}
    if actorInfo ~= nil and actorInfo.id > 0 then
      WU.AcquireWindowAsync("ActorMainDisplay", function()
        this:SetData("Space/DisplayInfo", displayInfo)
      end)
    end
  end
end

function OnMedalSwitch()
  if m_isMySelfSpace then
    WU.AcquireWindowAsync("MySpaceEdit", function(window)
      _ENV["$"](window)["$$SetMode"]("Medal")
    end)
  end
end

function OnClickFavBook(go)
  if m_isMySelfSpace then
    this:SetData("MySpaceEdit/Mode", "FavBook")
    WU.AcquireWindowAsync("MySpaceEdit")
  end
end

function OnClickFavActor(go)
  if m_isMySelfSpace then
    this:SetData("MySpaceEdit/Mode", "FavActor")
    WU.AcquireWindowAsync("MySpaceEdit")
  end
end

function OnMessageSubmit()
  local inputText = REF.InputComment.UIInput.value
  if U.trim(inputText) == "" then
    WU.ShowHintText(WU.GetString("Window_SpaceMsgForUIInput"))
    return
  end
  if m_messageTo == m_selfPlayerId then
    m_messageTo = nil
  end
  inputText = string.gsub(inputText, "<", "&lt;")
  inputText = string.gsub(inputText, ">", "&gt;")
  local postData = {content = inputText, to = m_messageTo}
  this:GameRequest("fci/player-message/" .. m_playerInfo.playerId):Post(postData, function(result)
    m_messageTo = nil
    REF.InputComment.UIInput.value = ""
    table.insert(m_messages, 1, result)
    RefreshMessages(true)
  end)
end

function RefreshMessages(goTop)
  local count = #REF.MsgTable
  local tableRef = REF.MsgTable
  if count < #m_messages then
    local widget = REF.WidgetSpaceMsg.gameObject
    for i = count + 1, #m_messages do
      CS.NGUITools.AddChild(REF.MsgTable.gameObject, widget)
    end
  elseif count > #m_messages then
    for i = #m_messages + 1, count do
      tableRef[i - 1]["$gameObject"]:SetActive(false)
    end
  end
  for i = 1, #m_messages do
    local ref = tableRef[i - 1]
    ref["$gameObject"]:SetActive(true)
    ref["$$SetMessage"](m_messages[i], "MySpace")
  end
  if goTop then
    REF.MsgScrollView.UIScrollView:ResetPosition()
  end
end

function OnNext()
  if m_hasNext then
    this:GameRequest("fci/player-message/" .. m_playerInfo.playerId):Page(m_curPageNumber, MessagePerPage):Get(function(result)
      if #result == MessagePerPage then
        m_curPageNumber = m_curPageNumber + 1
      else
        m_hasNext = false
      end
      for i = 1, #result do
        table.insert(m_messages, result[i])
      end
      RefreshMessages()
    end)
  end
end

function OnGuildDetailClick()
  local guild = this:GetData("fci/guild/" .. fif(m_isMySelfSpace, "", tostring(m_playerInfo.guildId)))
  if guild then
    WU.AcquireWindowAsync("GuildDetail", function(ui)
      _ENV["$"](ui)["$$SetData"](guild)
    end)
  end
end

function OnGuildInviteClick()
  if GuildUtil.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/invited-members/"):Put({
      playerId = m_playerInfo.playerId
    }, function(result)
      local invitedMembers = this:GetData("fci/guild/invited-members")
      table.insert(invitedMembers, result)
      this:SetData("fci/guild/invited-members", invitedMembers)
      WU.ToggleRendering(REF.BtnGuildInvite, false)
      WU.ToggleRendering(REF.LabelInvited, true)
      WU.ShowHintText(WU.GetString("Window_GuildInvitationSent"))
    end)
  end
end

function OnNamePatch()
  if m_isMySelfSpace then
    REF.NameNode["$OnRenameClick"]()
  end
end

function HandleShareData(allActors, haveActors, window)
  for i = 1, #haveActors do
    local role = PB.get("ActorConfig", haveActors[i].id).role
    if allActors[role] then
      allActors[role].unlock = true
    end
  end
  local selectNum = 5
  local selectedActors = {}
  local favorRoles = _ENV["!"](this:GetData("Space/SelectedPlayerOther").favorRoles)
  for i = 1, #favorRoles do
    table.insert(selectedActors, allActors[favorRoles[i]])
  end
  allActors = allActors:toarray()
  _ENV["$"](window)["$$SetEditInfo"](allActors, selectNum, selectedActors, "MySpaceActor")
end

function OnListChange(list, fightMedalId)
  if list == nil then
    return
  end
  WU.ToggleRendering(REF.WrapContent, true)
  m_medalList = {}
  m_medalListNotFight = {}
  local isPreCommit = WU.IsPreCommit()
  for _, m in pairs(m_allMedals) do
    local _, obtainedMedal = table.find(list, function(k, v)
      return v == m.id
    end)
    if obtainedMedal then
      m.obtained = true
      local hideSpecial = false
      hideSpecial = m.id == 80005
      if m.obtained and not hideSpecial then
        if m_medalList == nil then
          m_medalList = {}
          m_medalListNotFight = {}
        end
        if isPreCommit then
          if m.category ~= 4 then
            if m.id ~= fightMedalId then
              m.isFight = false
              table.insert(m_medalListNotFight, m)
            else
              m.isFight = true
              table.insert(m_medalList, m)
            end
          end
        elseif m.id ~= fightMedalId then
          m.isFight = false
          table.insert(m_medalListNotFight, m)
        else
          m.isFight = true
          table.insert(m_medalList, m)
        end
      end
    end
  end
  table.sort(m_medalListNotFight, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  for i = 1, #m_medalListNotFight do
    table.insert(m_medalList, m_medalListNotFight[i])
  end
  Show()
end

function UpdateMedalSlot(ref, info)
  if info == nil then
    ref["$$ClearSlot"]()
  else
    ref["$$SetData"](PB.enum.ResourceType.ResMedal, info.id)
    ref["$$ShowCustom"]({
      isNew = info.isNew,
      name = false,
      obtained = info.obtained,
      isFight = info.isFight
    })
    ref["$$SetClickCallback"](function()
      WU.ShowMedalDetail(info.id, false, info.expireTime)
    end)
  end
end

function Show()
  local noMedal = m_medalList == nil or #m_medalList == 0
  WU.ToggleRendering(REF.NodeMedalList, true)
  WU.ToggleRendering(REF.DragBG, not noMedal)
  WU.ToggleRendering(REF.NodeEmpty, noMedal)
  if not noMedal then
    LU.Set(REF.WrapContent, math.ceil(#m_medalList / #REF.WrapContent[0].Grid))
  end
end

function SetupMedalList()
  m_allMedals = PB.all("MedalInfo"):select(function(m)
    return {
      id = m.id,
      category = m.category,
      quality = m.quality
    }
  end)
  table.sort(m_allMedals, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_medalList and m_medalList[dataIndex]
    end,
    updateSlot = UpdateMedalSlot,
    delta = 0.01,
    slotsName = "Grid"
  })
end

function Focus(on)
  WU.RecordWindowFocus(100156, on)
end

function SetupCollectionList()
  LU.Bind(REF.CollectionsWrapContent, {
    dataSource = function(dataIndex)
      return m_collections and m_collections[dataIndex]
    end,
    updateSlot = UpdateCollectionsSlot
  })
end

function SetCollectionData()
  m_collections = _ENV["!"]({})
  m_collectionsCount = _ENV["!"]({})
  m_collectionsCount[1] = AU.GetMaxAchievementPoint()
  m_collectionsCount[2] = AU.GetAllEquipNum()
  m_collectionsCount[3] = AU.GetAllArmNum()
  m_collectionsCount[4] = AU.GetAllRolesNum()
  m_collectionsCount[5] = AU.GetAllMedalsNum()
  m_collectionsCount[6] = AU.GetAllSkinNum()
  m_collectionsCount[7] = AU.GetAllStoryCartoonNum()
  m_collectionsCount[8] = AU.GetAllEmojiNum()
  local playerCollectionInfo = PB.all("PlayerCollectionInfo")
  for i = 1, #playerCollectionInfo do
    if playerCollectionInfo[i].type == 5 and m_medalList then
      playerCollectionInfo[i].progress = #m_medalList
    else
      playerCollectionInfo[i].progress = m_playerInfo[playerCollectionInfo[i].key] or 0
    end
    playerCollectionInfo[i].all = m_collectionsCount[playerCollectionInfo[i].type]
    table.insert(m_collections, playerCollectionInfo[i])
  end
  LU.Set(REF.CollectionsWrapContent, math.ceil(#m_collections / #REF.MySpaceCollectionRow))
end

function UpdateCollectionsSlot(ref, info)
  if info then
    ref.SpriteTitle.UISprite.spriteName = info.textureTitle
    ref.SpriteIcon.UITexture.mainTexturePath = info.textureIcon
    WU.SetActive(ref.LabelTrophy, info.type == 1)
    WU.SetActive(ref.SpriteTrophy, info.type == 1)
    WU.SetActive(ref.split, info.type ~= 5)
    WU.SetActive(ref.LabelProgressAll, info.type ~= 5)
    if info.progress > info.all then
      info.progress = info.all
    end
    ref.LabelProgress.UILabel.text = info.progress
    ref.LabelProgressAll.UILabel.text = info.all
    ref.Progress.UIProgressBar.value = info.progress / info.all
    ref.LabelTitle.UILabel.text = WU.GetString(info.LabelName)
    if info.type == 1 then
      local levelName, curTrophy = AU.GetAchievementInfo(info.progress)
      ref.LabelTrophy.UILabel.text = levelName
      ref.SpriteTrophy.UISprite.spriteName = "home/cup_icon_big_" .. curTrophy
    end
    WU.ToggleRendering(ref.root, true)
  else
    WU.ToggleRendering(ref.root, false)
  end
end
