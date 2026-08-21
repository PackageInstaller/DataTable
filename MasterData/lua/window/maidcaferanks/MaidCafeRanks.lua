local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local LU = require("Common/ListUtil")
local m_selectedGroupId = 1
local m_groupRanksCache = {}
local m_playerGroupId, m_playerRank
local m_ranksToShow = {}
local m_rankModeInfoAll

function SetupWindow()
  WU.TraverseChildren(REF.TabGrid, function(go, index)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.root, function()
      this:SetData("MaidCafe/SelectedGroupId", ref["@groupId"])
    end)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = updateRankSlot,
    delta = 0.02
  })
end

function InitWindow()
  if this:GetData("MaidCafe/SelectedGroupId") == nil then
    this:SetData("MaidCafe/SelectedGroupId", 1)
  end
  WU.SetActive(REF.EmptyNode, false)
  WU.SetActive(REF.WrapContent, false)
  m_rankModeInfoAll = this:GetData("fci/maidcafe/rank-mode")
  local groupInfo = m_rankModeInfoAll.rankModeGroupInfo
  for i = 0, #REF.TabGrid - 1 do
    local ref = REF.TabGrid[i]
    WU.SetActive(ref.root, i < #groupInfo)
    if i < #groupInfo then
      ref["@groupId"] = groupInfo[i + 1].rankModeGroupId
      ref.GroupLabel.UILabel.text = WU.GetString("MaidCafe_RankMode_Ranks_GroupLabel", groupInfo[i + 1].levelMin, groupInfo[i + 1].levelMax)
    end
  end
  this:Bind("MaidCafe/SelectedGroupId", OnGroupChange)
  if m_rankModeInfoAll.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend] and m_rankModeInfoAll.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend].unlocked then
    m_playerGroupId = m_rankModeInfoAll.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend].rankModeGroupId
    DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode/legend-rank/my-rank/"))
    this:Bind("fci/maidcafe/rank-mode/legend-rank/my-rank/", OnPlayerRankChange)
    WU.SetActive(REF.PlayerRankInfo, true)
    WU.SetActive(REF.LegendLocked, false)
  else
    WU.SetActive(REF.PlayerRankInfo, false)
    WU.SetActive(REF.LegendLocked, true)
  end
end

function UninitWindow()
  m_groupRanksCache = {}
end

function Focus(on)
  if on then
    WU.SetWindowTitle("MaidCafeRanks", "CultivationPVPRanks")
  end
end

function OnGroupChange(groupId)
  if groupId == nil then
    return
  end
  m_selectedGroupId = groupId
  REF.TabGrid[groupId - 1].root.UIToggle.value = true
  if m_groupRanksCache[groupId] then
    if 0 < #m_groupRanksCache[groupId] then
      WU.SetActive(REF.EmptyNode, false)
      WU.SetActive(REF.WrapContent, true)
      LU.Set(REF.WrapContent, #m_groupRanksCache[groupId])
    else
      WU.SetActive(REF.EmptyNode, true)
      WU.SetActive(REF.WrapContent, false)
    end
  else
    DB:GameRequest("fci/maidcafe/rank-mode/legend-rank/" .. groupId):Get(function(resp)
      m_groupRanksCache[groupId] = resp.rankDetailInfo
      if 0 < #m_groupRanksCache[groupId] then
        WU.SetActive(REF.WrapContent, true)
        WU.SetActive(REF.EmptyNode, false)
        LU.Set(REF.WrapContent, #m_groupRanksCache[groupId])
      else
        WU.SetActive(REF.EmptyNode, true)
        WU.SetActive(REF.WrapContent, false)
      end
    end)
  end
  if m_playerRank then
    OnPlayerRankChange(m_playerRank)
  end
end

function OnPlayerRankChange(rankData)
  if rankData == nil then
    return
  end
  m_playerRank = rankData
  if m_rankModeInfoAll.rankModeInfo[PB.enum.MaidCafeRankModeType.Legend].unlocked then
    if m_selectedGroupId == m_playerGroupId then
      if m_playerRank.rank == 0 then
        REF.PlayerRank.UILabel.text = WU.GetString("MaidCafe_RankMode_NoRank")
      elseif m_playerRank.rank > 100 then
        local percentage = math.ceil(m_playerRank.rank * 100 / m_playerRank.rankTotal)
        if percentage <= 60 then
          REF.PlayerRank.UILabel.text = WU.GetString("MaidCafe_RankMode_Ranks_MyRank2", math.ceil(m_playerRank.rank * 100 / m_playerRank.rankTotal) .. "%")
        else
          REF.PlayerRank.UILabel.text = WU.GetString("MaidCafe_RankMode_Ranks_MyRank3")
        end
      else
        REF.PlayerRank.UILabel.text = WU.GetString("MaidCafe_RankMode_Ranks_MyRank1", m_playerRank.rank)
      end
    else
      REF.PlayerRank.UILabel.text = WU.GetString("MaidCafe_RankMode_Ranks_NotInCurrentGroup")
    end
  end
end

function updateRankSlot(slotRef, wrapIndex, realIndex)
  if m_groupRanksCache and m_groupRanksCache[m_selectedGroupId] and realIndex ~= nil and realIndex < #m_groupRanksCache[m_selectedGroupId] then
    local rankInfo = m_groupRanksCache[m_selectedGroupId][realIndex + 1]
    slotRef.Rank.UILabel.text = realIndex + 1
    slotRef.PlayerName.UILabel.text = rankInfo.playerName .. fif(rankInfo.guildName == "", "", "\239\188\136" .. rankInfo.guildName .. "\239\188\137")
    slotRef.WidgetDungeonGroup["$SetViewByActors"](rankInfo.actorInfo, true)
    slotRef.PlayerScore.UILabel.text = WU.GetString("MaidCafe_RankMode_Balance_ScoreDesc", rankInfo.score)
    slotRef.root.UIPlayTween:Play(true)
    WU.ToggleRendering(slotRef.root, true)
  else
    WU.ToggleRendering(slotRef.root, false)
  end
end
