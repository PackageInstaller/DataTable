local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local FU = require("Common/FriendUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local CO = require("Common/Coroutine")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local PU = require("Common/PlatformUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_uiManager = S:Get("UIWindowManager")
local PlayerType = {
  GameFriend = 1,
  MSDKFriend = 2,
  ApplyFriend = 3,
  RecommendFriend = 4
}
local Msdk = CS.Msdk
local m_platform
local ImgUrl = PB.all("Misc"):first().msdkFriendIcon
local m_bytes, m_wrapData, m_widgetPlayerType, m_tabMsdkFriend, m_tabGameFriend, m_tabRecommendFriend, m_resetPosition, m_applylist

function SetupWindow()
  m_tabGameFriend = REF.TabGrid[0].TabGameFriend
  m_tabMsdkFriend = REF.TabGrid[1].TabMsdkFriend
  m_tabRecommendFriend = REF.TabGrid[2].TabRecommendFriend
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  WU.BindButtonEvent(REF.InputSearch, function()
    WU.RecordButtonClick(109042)
  end)
  WU.BindButtonEvent(REF.MySpaceBtn, OnClickSpace)
  WU.BindButtonEvent(m_tabGameFriend, function()
    WU.RecordButtonClick(109001)
    FU.MarkNewFriend(false)
    GameFriend(this:GetData("fci/friendlist/"))
    REF.WrapContent.UIWrapContent:UpdateContent(#m_wrapData, true)
  end)
  WU.BindButtonEvent(m_tabRecommendFriend, function()
    WU.RecordButtonClick(109026)
    RecommendFriend(this:GetData("fci/recommendrelation/"))
    REF.WrapContent.UIWrapContent:UpdateContent(#m_wrapData, true)
  end)
  WU.BindButtonEvent(REF.FriendShipPoint, OnClickFriendship)
  WU.BindButtonEvent(REF.FriendApplicationForm, function()
    WU.RecordButtonClick(109007)
    local applylist = this:GetData("fci/applylist/") or {}
    RU.SetRedMark("Relation/Friend/NewApplier", false)
    this:SetData("applylistViewed", true)
    WU.AcquireWindowAsync("FriendApplicationForm", function(window)
      _ENV["$"](window)["$$SetMode"]("Applylist")
    end)
  end)
  WU.BindButtonEvent(REF.Blacklist, function()
    WU.RecordButtonClick(109010)
    local blackList = this:GetData("fci/blacklist/") or {}
    if #blackList == 0 then
      WU.ShowHintText(WU.GetString("WindowFriend_NoBlacklist"))
    else
      WU.AcquireWindowAsync("FriendBlackForm", function(window)
        _ENV["$"](window)["$$SetMode"]("Blacklist")
      end)
    end
  end)
  WU.BindButtonEvent(REF.RecommendFriend, function()
    WU.RecordButtonClick(109033)
    DB:SyncRemote(DB:GameRequest("fci/recommendrelation/"):Query("fields", "playerId,name,lastLogoutTime,level,headPhoto,socialPicture,sex,qqvip,socialPlatform,gamecenterLoginTime"):SyncInput(false))
  end)
  WU.BindButtonEvent(REF.SpriteSend, OnClickSearchPlayer)
  WU.BindButtonEvent(REF.BatchClean, function()
    WU.AcquireWindowAsync("FriendDelete")
  end)
  WU.BindButtonEvent(m_tabMsdkFriend, OnClickMsdkFriend)
  WU.BindButtonEvent(REF.MsdkInviteBtn, OnClickMsdkInvite)
end

function InitWindow()
  m_resetPosition = false
  m_bytes = this:GetData("InviteIcon")
  if m_bytes == nil and CS.ResourceManager.Instance ~= nil then
    m_bytes = CS.ResourceManager.Instance:GetBytes("Data/gamelogo")
    this:SetData("InviteIcon", m_bytes)
  end
  DB:GameRequest("fci/FriendRecall/"):Get(function(res)
    this:SetData("fci/FriendRecall/", res)
  end)
  WU.ToggleRendering(REF.ScrollViewList, false)
  REF.LabelInput.UILabel:UpdateAnchors()
  REF.SpriteSend.UISprite:UpdateAnchors()
  REF.InputSearch.UIInput.defaultText = WU.GetString("Window_SearchFriendDefaultText")
  _ENV["$"](REF.MySpaceBtn).LabelButton.UIHtmlLabel.text = WU.GetString("Window_MySpace")
  local switch = this:GetData("AccountSwitch")
  WU.ToggleRendering(REF.MsdkInviteBtn, false)
  m_platform = this:GetData("accountCache").socialPlatform
  REF.TabGrid[1]["$gameObject"]:SetActive(true)
  if m_platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat and switch.PlatRelation then
    m_tabMsdkFriend["$SetTab"](WU.GetString("Window_FriendByWeixin"), "Common", "friends_icon_2")
  elseif m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ and switch.PlatRelation then
    m_tabMsdkFriend["$SetTab"](WU.GetString("Window_FriendByQQ"), "Common", "friends_icon_1")
  else
    REF.TabGrid[1]["$gameObject"]:SetActive(false)
  end
  m_tabGameFriend["$SetTab"](WU.GetString("Window_MyFriend"), "Common", "friends_icon_3")
  m_tabRecommendFriend["$SetTab"](WU.GetString("Window_RecommendFriend"), "Common", "friends_icon_4")
  REF.TabGrid.UIGrid:Reposition()
  RU.BindRedMark(this, "Relation/Friend/NewApplier", function(flag)
    REF.SpriteApplicationRedMark.gameObject:SetActive(flag)
    m_tabGameFriend["$SetNew"](flag)
  end)
  RU.BindRedMark(this, "Relation/Friend/RelationPoint", function(flag)
    REF.SpriteRelationPointRedMark.gameObject:SetActive(flag)
  end)
  this:GameRequest("fci/relationpoint/"):Get(function(result)
    local dailyLimit = PB.all("Misc"):first().relationPointDailyLimit
    local dayCanGet = dailyLimit - (result.todayTotalGet or 0)
    if (0 < result.auraCanRecvCnt or 0 < result.canRecvCnt or 0 < result.pointPool) and 0 < dayCanGet then
      REF.PointSprite.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
    else
      REF.PointSprite.UISprite.color = CS.NGUIMath.HexToColor(4294967159)
    end
  end)
  this:RegisterGameEvent("PlayerOptionChange", OnPlayerOptionChange)
  this:Bind("fci/friendlist/", GameFriend)
  this:BindRemote(DB:GameRequest("fci/recommendrelation/"):Query("fields", "playerId,name,lastLogoutTime,level,headPhoto,socialPicture,sex,qqvip,socialPlatform,gamecenterLoginTime"), RecommendFriend)
  this:Bind("fci/resource/ResPlayerRelationPoint_0", function(val)
    REF.PointLabel.UILabel.text = val or 0
  end)
  CheckTopPvpFriendContinueBattle()
end

function UninitWindow()
  m_uiManager.StopHeadPhotoFetch()
end

function Goto()
  SetTab(false)
end

function CheckTopPvpFriendContinueBattle()
  local data = this:GetData("TopPvpFriendBalanceInfo")
  if data then
    m_tabGameFriend.UIToggle.value = true
    FU.MarkNewFriend(false)
    GameFriend(this:GetData("fci/friendlist/"))
    REF.WrapContent.UIWrapContent:UpdateContent(#m_wrapData, true)
  end
end

function SetTab(isFriendEmpty)
  if isFriendEmpty then
    m_tabRecommendFriend.UIToggle.value = true
    m_resetPosition = true
    RecommendFriend(this:GetData("fci/recommendrelation/"))
    m_resetPosition = false
  else
    m_tabGameFriend.UIToggle.value = true
    m_resetPosition = true
    GameFriend(this:GetData("fci/friendlist/"))
    m_resetPosition = false
  end
end

function OnPlayerOptionChange()
  if m_tabGameFriend.UIToggle.value then
    _ENV["$"](m_tabGameFriend).PlayerOption.UIPlayerOptions:UpdateOptions()
  elseif m_tabMsdkFriend.UIToggle.value then
    _ENV["$"](m_tabMsdkFriend).PlayerOption.UIPlayerOptions:UpdateOptions()
  elseif m_tabRecommendFriend.UIToggle.value then
    _ENV["$"](m_tabRecommendFriend).PlayerOption.UIPlayerOptions:UpdateOptions()
  end
end

function GameFriend(result)
  if m_tabGameFriend.UIToggle.value and result ~= nil then
    m_widgetPlayerType = PlayerType.GameFriend
    REF.LabelNoFriend.UILabel.text = WU.GetString("Window_NoFriends")
    FriendWrapContent(result)
  else
    FU.MarkNewFriend(true)
  end
end

function RecommendFriend(result)
  if m_tabRecommendFriend.UIToggle.value and result ~= nil then
    m_widgetPlayerType = PlayerType.RecommendFriend
    REF.LabelNoFriend.UILabel.text = WU.GetString("Window_NoRecommendFriends")
    FilterFriends(result)
    FriendWrapContent(result)
  end
end

function FilterFriends(list)
  local friendList = this:GetData("fci/friendlist/")
  for i = #list, 1, -1 do
    local recommendPlayerInfo = list[i]
    local find = table.find(friendList, function(_, v)
      return v.playerId == recommendPlayerInfo.playerId
    end)
    if find then
      table.remove(list, i)
    end
  end
end

function OnClickMsdkInvite()
  WU.RecordButtonClick(109008)
  local isQQ = m_platform == PB.enum.MSDKLoginPlatform.MSDK_QQ
  local isWX = m_platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat
  local platformCheck
  if isQQ then
    platformCheck = Msdk.ePlatform.ePlatform_QQ
  elseif isWX then
    platformCheck = Msdk.ePlatform.ePlatform_Weixin
  end
  if platformCheck == nil then
    return
  end
  local appInstalled = Msdk.WGPlatform.Instance:WGIsPlatformInstalled(platformCheck)
  if not appInstalled then
    local localization = fif(isQQ, "Platform_QQNotInstalled", "Platform_WXNotInstalled")
    WU.ShowMessageOK(WU.GetString(localization))
    return
  end
  local baseinfo = this:GetData("fci/baseinfo/")
  local title = WU.GetString("Msdk_Invite_Title", baseinfo.name)
  local desc = WU.GetString("Msdk_Invite_Desc")
  local bytes = m_bytes
  local len = 0
  if m_bytes ~= nil then
    len = m_bytes:len()
  end
  if isWX then
    Msdk.WGPlatform.Instance:WGSendToWeixin(title, desc, "MSG_INVITE", bytes, len, "wx_share")
  elseif isQQ then
    local targetUrl = "http://imgcache.qq.com/gc/gamecenterV2/dist/index/detail/detail.html?appid=1106429722&pf=invite&plat=qq&ADTAG=gameobj.msg_invite&originuin=61793295&platformdata=qq_share"
    targetUrl = targetUrl .. "&from=androidqq"
    Msdk.WGPlatform.Instance:WGSendToQQ(Msdk.eQQScene.QQScene_Session, title, desc, targetUrl, ImgUrl, #ImgUrl)
  end
end

function OnClickMsdkFriend()
  this:Bind("fci/socialfriend/", function(socialfriend)
    if not m_tabMsdkFriend.UIToggle.value then
      return
    end
    REF.LabelNoFriend.UILabel.text = WU.GetString("Window_NoSocialFriends")
    if socialfriend ~= nil then
      m_widgetPlayerType = PlayerType.MSDKFriend
      if socialfriend ~= nil then
        m_wrapData = socialfriend
        table.sort(m_wrapData, function(p1, p2)
          if p1.playerInfo.lastLogoutTime ~= p2.playerInfo.lastLogoutTime then
            return p1.playerInfo.lastLogoutTime > p2.playerInfo.lastLogoutTime
          else
            return p1.playerInfo.playerId < p2.playerInfo.playerId
          end
        end)
        LU.Set(REF.WrapContent, #socialfriend)
        REF.SpriteFriendEmpty.gameObject:SetActive(#socialfriend <= 0)
      end
    else
      LU.Set(REF.WrapContent, 0)
      REF.SpriteFriendEmpty.gameObject:SetActive(true)
    end
  end)
end

function FriendWrapContent(friends)
  if friends ~= nil then
    m_wrapData = table.select(friends, function(v)
      if v.playerId ~= nil and v.playerId ~= "" then
        return v
      end
    end):toarray()
    for i = 1, #m_wrapData do
      local playerInfo = m_wrapData[i]
      playerInfo.online = fif(playerInfo.lastLogoutTime == 0, 1, 0)
    end
    local xlsx = PB.get("Sort", fif(m_widgetPlayerType == PlayerType.RecommendFriend, 19, 18))
    SU.SortOnce(m_wrapData, xlsx, true)
    WU.ToggleRendering(REF.ScrollViewList, true)
    LU.Set(REF.WrapContent, #m_wrapData, m_resetPosition, not m_resetPosition)
    REF.SpriteFriendEmpty.gameObject:SetActive(#m_wrapData <= 0)
    if m_tabRecommendFriend.UIToggle.value then
      REF.LabelNoFriend.UILabel.text = WU.GetString("Window_NoRecommendFriends")
    else
      REF.LabelNoFriend.UILabel.text = WU.GetString("Window_NoFriends")
    end
  end
end

function OnClickSpace()
  WU.RecordButtonClick(109011)
  WU.AcquireWindowAsync("Account", function(ui)
    _ENV["$"](ui)["$$SetMySpace"]()
  end)
end

function OnClickSearchPlayer()
  WU.RecordButtonClick(109043)
  local text = U.trim(REF.InputSearch.UIInput.value)
  if text == "" then
    WU.ShowHintText(WU.GetString("Window_SearchPlayerEmpty"))
    return
  end
  local byid = 0
  if string.sub(text, 1, 1) == "#" then
    byid = 1
    text = string.gsub(text, "#", "")
  end
  if string.match(text, "[./?#\\\"]") then
    WU.ShowHintText(WU.GetString("Error_ContentOrNameIsDirty"))
    return
  end
  this:GameRequest("fci/playersummary/" .. text):Query("byid", byid):Get(function(result)
    if U.trim(result.playerId) == "" then
      WU.ShowHintText(WU.GetString("Window_SearchPlayerNotExist"))
      return
    end
    if result.playerId == this:GetData("playerId") then
      WU.ShowHintText(WU.GetString("WindowFriend_CantSearchSelf"))
    else
      WU.ShowPlayerDetail(result)
    end
  end)
end

function OnClickFriendship()
  WU.RecordButtonClick(109054)
  this:GameRequest("fci/relationpoint/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    REF.PointSprite.UISprite.color = CS.NGUIMath.HexToColor(4294967159)
    TU.TaskFirstCheck(PB.enum.UseFuncMTimes.GetRelationPoint)
    WU.ShowHintText(WU.GetString("Window_ReceiveFriendshipPointCount", result.getCntThisTime))
    RU.SetRedMark("Relation/Friend/RelationPoint", false)
  end)
end

function UpdateRow(rowRef, wrapIndex, realIndex)
  if m_wrapData == nil or realIndex == nil then
    return
  end
  if m_widgetPlayerType == PlayerType.MSDKFriend then
    if realIndex < #m_wrapData then
      local data = m_wrapData[realIndex + 1]
      rowRef["$$SetSocialData"](data)
    end
  elseif realIndex < #m_wrapData then
    local data = m_wrapData[realIndex + 1]
    rowRef["$$SetData"](data, m_widgetPlayerType)
  end
end

function Focus(on)
  WU.RecordWindowFocus(100109, on)
end
