inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_guildList, m_recruitGuilds, m_selectedIndex
local m_requestB4 = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonRefresh, OnRefreshClick)
  WU.BindButtonEvent(REF.ButtonSearch, OnSearchClick)
  WU.TraverseChildren(REF.PageSwitch, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if REF.TabRecruit.UIToggle.value then
        OnTabGuildRecruit()
      end
    end)
  end)
  LU.Bind(REF.WrapContentRecruit, {
    updateRow = UpdateRowRecruit
  })
end

function InitWindow()
  REF.TabGuild.UIToggle.value = true
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("SortFinished", OnSortFinished)
  REF.InputSearch.UIInput.value = ""
  REF.InputSearch.UIInput.defaultText = WU.GetString("Window_GuildSearchTips")
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
  m_requestB4 = false
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_guildList == nil or itemIndex > #m_guildList then
    return
  end
  refRow["@index"] = itemIndex
  refRow["$$SetData"](m_guildList[itemIndex])
  refRow["$$SetHighlight"](itemIndex == m_selectedIndex)
end

function OnSlotClick(slot)
  local newIndex = _ENV["$"](slot)["@index"]
  if newIndex ~= m_selectedIndex then
    for i = 0, #REF.WrapContent - 1 do
      if REF.WrapContent[i]["@index"] == m_selectedIndex then
        REF.WrapContent[i]["$$SetHighlight"](false)
      end
    end
    m_selectedIndex = newIndex
    _ENV["$"](slot)["$$SetHighlight"](true)
    REF.WidgetGuildPeek["$SetData"](m_guildList[m_selectedIndex])
  end
end

function UpdateRowRecruit(refRow, wrapIndex, realIndex)
  if m_recruitGuilds == nil or realIndex >= #m_recruitGuilds then
    return
  end
  local ref = _ENV["$"](refRow.root)
  local content = m_recruitGuilds[realIndex + 1]
  local guildPlayer = this:GetData("fci/guild-player/")
  local maxMemberCount = PB.index("GuildLevel", content.guildLevel).maxMemberCount
  WU.SetLabel(ref.LabelName, content.guildName)
  WU.SetLabel(ref.LabelMember, content.guildMemberCount .. "/" .. maxMemberCount)
  WU.SetLabel(ref.LabelInfo, content.bulletinContent)
  WU.SetLabel(ref.LabelHeat, content.guildScore)
  WU.SetActive(ref.ButtonApply, guildPlayer == nil or guildPlayer.guildId == 0)
  ref.SpriteIcon.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(content.guildIcon) or 1) .. "s"
  WU.ClearButtonEvent(ref.ButtonApply)
  WU.BindButtonEvent(ref.ButtonApply, function()
    local guildId = content.guildId
    if guildId and guildId ~= 0 then
      DB:GameRequest("fci/guild/" .. guildId .. "/pending-members/"):Put({
        playerId = DB:GetData("playerId")
      }, function()
        WU.ShowHintText(WU.GetString("Window_GuildApplicationSent"))
      end)
    end
  end)
  WU.ClearButtonEvent(ref.ButtonDetail)
  WU.BindButtonEvent(ref.ButtonDetail, function()
    this:GameRequest("fci/guild/" .. content.guildId .. "/members/"):Get(function(members)
      WU.AcquireWindowAsync("OtherGuildDetail", function(ui)
        _ENV["$"](ui)["$$SetData"](content, members)
      end)
    end)
  end)
end

function RequestGuildRecommend()
  this:GameRequest("fci/guild-recommend/"):Post(nil, function(guildRecommend)
    if guildRecommend then
      this:SetData("fci/guild-recommend/", guildRecommend)
      this:BroadcastGameEvent("ApplySortAlternative", REF["$SortMate"].tabIndex, REF["$SortMate"].reverse)
    end
  end)
end

function RequestGuildRecruit(func)
  this:GameRequest("fci/guild-recruit-recommend/"):Get(function(result)
    if result ~= nil and func then
      func(result)
    end
  end)
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == REF["$SortMate"] then
    UpdateGuildList(data.list)
  end
end

function UpdateGuildList(guildList)
  m_guildList = guildList or {}
  local guildCount = 0
  if m_guildList then
    guildCount = #m_guildList
  end
  REF.NodeEmpty.gameObject:SetActive(guildCount <= 0)
  m_selectedIndex = nil
  LU.Set(REF.WrapContent, guildCount)
  if 0 < guildCount then
    OnSlotClick(REF.WrapContent[0]["$gameObject"])
  else
    REF.WidgetGuildPeek["$SetData"](nil)
  end
end

function OnRefreshClick()
  if REF.TabRecruit.UIToggle.value then
    RequestGuildRecruit()
  else
    WU.RecordButtonClick(165002)
    RequestGuildRecommend()
  end
end

function OnSearchClick()
  WU.RecordButtonClick(165001)
  local keyText = U.trim(REF.InputSearch.UIInput.value)
  if keyText ~= "" then
    this:GameRequest("fci/guild-search/"):Post({idOrName = keyText}, OnSearchResponse)
  else
    WU.ShowHintText(WU.GetString("Window_GuildSearchTips"))
  end
end

function OnSearchResponse(result)
  if result then
    UpdateGuildList({result})
  else
    WU.ShowHintText(WU.GetString("Window_GuildSearchNotFound"))
  end
end

function OnTabGuildRecruit()
  if m_requestB4 then
    return
  end
  LU.Set(REF.WrapContentRecruit, 0)
  REF.NodeEmptyRecruit.gameObject:SetActive(false)
  REF.GuildListRecruit.gameObject:SetActive(false)
  RequestGuildRecruit(function(result)
    m_recruitGuilds = WU.CheckGuildExist(result.recruitContent)
    REF.NodeEmptyRecruit.gameObject:SetActive(#m_recruitGuilds <= 0)
    REF.GuildListRecruit.gameObject:SetActive(0 < #m_recruitGuilds)
    LU.Set(REF.WrapContentRecruit, #m_recruitGuilds)
    REF.ScrollViewRecruit.UIScrollView:ResetPosition()
    m_requestB4 = true
  end)
end

function Focus(on)
  WU.RecordWindowFocus(100165, on)
end
