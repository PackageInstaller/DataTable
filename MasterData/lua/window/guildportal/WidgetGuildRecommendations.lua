local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local LU = require("Common/ListUtil")
local m_guildList
local m_selectedIndex = 0

function Start()
  WU.BindButtonEvent(REF.ButtonRefresh, OnRefreshClick)
  WU.BindButtonEvent(REF.ButtonSearch, OnSearchClick)
  WU.BindButtonEvent(REF.ButtonJoin, OnJoinClick)
end

function OnEnable()
  REF.InputSearch.UIInput.value = ""
  REF.InputSearch.UIInput.defaultText = WU.GetString("Window_GuildSearchTips")
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
  this:Bind("SortFinished", OnSortFinished)
end

function OnDisable()
  this:Unbind("SortFinished", OnSortFinished)
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == REF["$SortMate"] then
    OnGuildRecommendChange(data.list)
  end
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
    local guild = m_guildList[m_selectedIndex]
    REF.WidgetGuildPeek["$SetData"](guild)
    local guildPlayer = this:GetData("fci/guild-player/")
    local applyed = table.find(guildPlayer.pendingGuildId, function(k, v)
      return v == guild.id
    end)
    REF.NodePending.gameObject:SetActive(applyed)
    REF.ButtonJoin.gameObject:SetActive(not applyed)
  end
end

function RequestGuildRecommend()
  this:GameRequest("fci/guild-recommend/"):Post(nil, function(guildRecommend)
    if guildRecommend then
      this:SetData("fci/guild-recommend/", guildRecommend)
      this:BroadcastGameEvent("ApplySortAlternative", REF["$SortMate"].tabIndex, REF["$SortMate"].reverse)
    end
  end)
end

function OnGuildRecommendChange(guildRecommend)
  UpdateGuildList(guildRecommend)
end

function UpdateGuildList(guildList)
  m_guildList = guildList
  local guildCount = 0
  if m_guildList then
    guildCount = #m_guildList
  end
  REF.NodeEmpty.gameObject:SetActive(guildCount <= 0)
  REF.NodeContent.gameObject:SetActive(0 < guildCount)
  REF.RIGHT.gameObject:SetActive(0 < guildCount)
  m_selectedIndex = nil
  LU.Set(REF.WrapContent, guildCount)
  if 0 < guildCount then
    OnSlotClick(REF.WrapContent[0]["$gameObject"])
  end
end

function OnRefreshClick()
  WU.RecordButtonClick(160003)
  RequestGuildRecommend()
end

function OnSearchClick()
  WU.RecordButtonClick(160002)
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

function OnJoinClick()
  WU.RecordButtonClick(160004)
  if m_guildList and m_selectedIndex then
    local guild = m_guildList[m_selectedIndex]
    this:GameRequest("fci/guild/" .. guild.id .. "/pending-members/"):Put({
      playerId = this:GetData("playerId")
    }, OnApplySucceed)
  end
end

function OnApplySucceed(result)
  if m_guildList ~= nil then
    local guild = m_guildList[m_selectedIndex]
    local guildPlayer = this:GetData("fci/guild-player/")
    table.insert(guildPlayer.pendingGuildId, guild.id)
    REF.NodePending.gameObject:SetActive(true)
    REF.ButtonJoin.gameObject:SetActive(false)
    WU.ShowHintText(WU.GetString("Window_GuildApplicationSent"))
  end
end
