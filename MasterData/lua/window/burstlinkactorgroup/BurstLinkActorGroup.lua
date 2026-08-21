local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local NU = require("Common/NotepadUtil")
local DU = require("Common/DungeonUtil")
local RU = require("Common/RedMarkUtil")
local m_selectActorGroupId, m_burstLinkInfo
local m_curItemSlotList = {}
local m_nextItemSlotList = {}
local m_members = {}
local m_groups, m_initWindow

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonMatch, function()
    WU.RecordButtonClick(100127202)
    this:GameRequest("fci/BurstLinkPvpActorGroup/"):Put({actorGroups = m_groups}, function(response)
      this:SetData("fci/BurstLinkPvpActorGroup/", m_groups)
      DB:HandleRemoteChanged("fci/tournament/summary")
      if not DU.IsWaitingForJob(OnMatchClick) then
        OnMatchClick()
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonReceive, OnReceiveClick)
  REF.WidgetGroupMembers.UIPlayTween.playOnEnable = false
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorSlotClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectActorGroupId)] = patchData
    this:SetData("fci/BurstLinkPvpActorGroup/", this:GetData("fci/BurstLinkPvpActorGroup/"))
  end)
end

function InitWindow()
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  WU.ToggleRendering(REF.NodeCumulativePrize, false)
  WU.ToggleRendering(REF.WinCount, false)
  WU.ToggleRendering(REF.WidgetLoseSignGridL, false)
  WU.ToggleRendering(REF.ButtonMatch, false)
  WU.ToggleRendering(REF.ButtonReceive, false)
  m_initWindow = true
  m_selectActorGroupId = 1
  m_burstLinkInfo = nil
  m_curItemSlotList = {}
  m_nextItemSlotList = {}
  m_members = {}
  this:RegisterGameEvent("BurstLink/StartMatching", OnBurstLinkMatching)
  this:BindRemote(DB:GameRequest("fci/BurstLinkPvpActorGroup/"), OnSetMembers)
  this:Bind("fci/BurstLinkPvpInfo/", OnBurstLinkInfoGet, false)
  DB:SyncRemote(DB:GameRequest("fci/BurstLinkPvpInfo/"):SyncInput(false))
  this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.PushService, "ScMatchNtf", OnMatchSuccess)
  info("pvp", "RegisterWebSocketLuaListener")
  this:RegisterGameEvent("OnNavigation", function(type)
    if type == "City" then
      OnNavigateToCity()
    end
  end)
  local pvpReason = this:GetData("FightLeaveReasonHint")
  if pvpReason ~= nil then
    this:SetData("FightLeaveReasonHint", nil)
    WU.ShowHintText(WU.GetString("PVPLeaveReasonHint"))
  end
end

function UninitWindow()
  this:SetData("Share/BurstLinkHasWin", nil)
  this:SetData("Share/DungeonBalanceBurstLink", nil)
end

function SetShareInfo()
  local balance = DB:GetData("fci/BurstLinkPvpBalance")
  this:SetData("ShareConfig", {
    shareName = "DungeonBalanceBurstLink",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local groupData = DB:GetData("fci/BurstLinkPvpActorGroup/")
  local actorPool = DB:GetData("fci/BurstLinkPvpActor")
  local balance = DB:GetData("fci/BurstLinkPvpBalance")
  local winNum = 0
  if m_burstLinkInfo.baseInfo then
    winNum = m_burstLinkInfo.baseInfo.winNum
  end
  local data = {
    groupData = m_groups,
    resultInfo = {winNum = winNum},
    actorPool = actorPool
  }
  this:SetData("Share/DungeonBalanceBurstLink", data)
end

function OnBurstLinkMatching()
  this:MatchRequest("match/BurstLinkPVPMatch"):Post({}, function(response)
    WU.AcquireWindowAsync("BurstLinkMatching", function(ui)
      _ENV["$"](ui)["$$Show"](response)
    end)
  end)
end

function OnMatchSuccess(response)
  info("pvp", "OnMatchSuccess")
  local dungeonInfo = response.dungeonInfo
  local team = dungeonInfo.teams
  CS.Restifizer.RestifizerManager.Instance:SetFightWebSocketUrl(response.fightsvrUrl)
  local fightActorInfo = {
    {
      playerId = team[1].members[1].playerId,
      actors = team[1].members[1].actors,
      name = team[1].members[1].name,
      level = team[1].members[1].level
    },
    {
      playerId = team[2].members[1].playerId,
      actors = team[2].members[1].actors,
      name = team[2].members[1].name,
      level = team[2].members[1].level
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  local myId = this:GetData("playerId")
  local teamNum = 0
  local robot = false
  if myId == team[1].members[1].playerId then
    teamNum = 1
    robot = team[2].members[1].isRobot
  elseif myId == team[2].members[1].playerId then
    teamNum = 2
    robot = team[1].members[1].isRobot
  end
  local playerNum = 2
  if robot then
    playerNum = 1
    info("GamePlay", "---------pvp is robot---------")
  end
  this:SetData("FightPlayerCount", playerNum)
  if teamNum ~= 0 then
    WU.AcquireWindowAsync("BurstLinkMatchSuccess", function(window)
      this:BroadcastGameEvent("BurstLinkMatchSuccess")
      _ENV["$"](window).root["$SetCallback"](function()
        WU.EnterGameLevel(dungeonInfo.dungeonUid, nil, dungeonInfo.dungeonId, PB.enum.DungeonType.BurstLinkPvp, teamNum, false)
      end)
    end)
  else
    warning("BurstLinkPvp, not in the team")
  end
end

function OnActorSlotClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  GU.SetGroupMode(PB.enum.ActorGroupType.BurstLinkPvp)
  WU.AcquireWindowAsync("BurstLinkFormation")
end

function OnMatchClick()
  local memberCount = 0
  for i = 1, #m_members do
    if 0 < m_members[i].actorUid then
      memberCount = memberCount + 1
    end
  end
  if memberCount < 6 then
    WU.ShowHintText(WU.GetString("Tournament_BurstLinkActorNotEnough"))
    return
  end
  this:BroadcastGameEvent("BurstLink/StartMatching")
end

function OnBurstLinkInfoGet(burstLinkInfo)
  if burstLinkInfo then
    m_burstLinkInfo = burstLinkInfo
    RefreshBaseInfo()
  end
end

function OnSetMembers(groups)
  if groups then
    m_groups = groups
    local actors = this:GetData("fci/BurstLinkPvpActor")
    if actors == nil then
      this:GameRequest("fci/BurstLinkPvpActor"):Get(function(actorPool)
        if actorPool ~= nil and actorPool.actor then
          for _, v in pairs(actorPool.actor) do
            DBH.AppendActorInfo(v)
          end
          this:SetData("fci/BurstLinkPvpActor", actorPool.actor)
          m_members = groups[tostring(m_selectActorGroupId)].members
          REF.WidgetGroupMembers["$SetBurstLinkGroupMembers"](m_members, actorPool.actor)
          REF.WidgetGroupMembers["$ShowCustom"]({
            showQuality = false,
            showStar = false,
            showLevel = false,
            showNew = false,
            showName = true,
            showSpeed = true
          })
          WU.ToggleRendering(REF.WidgetGroupMembers, true)
          if m_initWindow then
            m_initWindow = false
            REF.WidgetGroupMembers.UIPlayTween:Play(true)
          end
        end
      end)
    else
      for _, v in pairs(actors) do
        DBH.AppendActorInfo(v)
      end
      m_members = groups[tostring(m_selectActorGroupId)].members
      REF.WidgetGroupMembers["$SetBurstLinkGroupMembers"](m_members, actors)
      REF.WidgetGroupMembers["$ShowCustom"]({
        showQuality = false,
        showStar = false,
        showLevel = false,
        showNew = false,
        showName = true,
        showSpeed = true
      })
      WU.ToggleRendering(REF.WidgetGroupMembers, true)
      if m_initWindow then
        m_initWindow = false
        REF.WidgetGroupMembers.UIPlayTween:Play(true)
      end
    end
  end
end

function RefreshBaseInfo()
  if m_burstLinkInfo then
    local maxWinCount = PB.all("Misc"):first().pvpMaxWinNum
    local maxLoseCount = PB.all("Misc"):first().pvpMaxDieNum
    local winCount = 0
    local failCount = 0
    if m_burstLinkInfo.baseInfo then
      winCount = m_burstLinkInfo.baseInfo.winNum
      failCount = m_burstLinkInfo.baseInfo.failNum
    end
    this:SetData("Share/BurstLinkHasWin", 0 < winCount)
    REF.LabelWinCount.UILabel.text = WU.GetString("Tournament_BurstLinkWinCount", winCount, tostring(maxWinCount))
    REF.LabelWinCountBMF.UILabel.text = tostring(winCount)
    REF.LabelLoseCount.UILabel.text = WU.GetString("Tournament_BurstLinkLoseCount", failCount, tostring(maxLoseCount))
    WU.ToggleRendering(REF.WidgetLoseSignGridL, true)
    REF.WidgetLoseSignGridL["$SetStar"](failCount, maxLoseCount - failCount, true)
    local burstLinkFinish = false
    if maxWinCount <= winCount or maxLoseCount <= failCount then
      burstLinkFinish = true
    end
    SetPrizePreview(m_burstLinkInfo.reward, winCount, burstLinkFinish)
    SetButtonDisplay(burstLinkFinish)
    WU.ToggleRendering(REF.WinCount, true)
    REF.root.Animator:Play("DelayOpen", -1, 0)
  end
end

function SetWinCountProgress(winCount, maxWinCount)
  REF.WinCountProgress.gameObject:SetActive(true)
  local winCountSprite = REF.GridWinCount[0]["$gameObject"]
  local winCountSpriteSpace = 0
  if winCountSprite then
    winCountSpriteSpace = REF.GridWinCount.UIGrid.cellWidth - REF.GridWinCount[0]["$UISprite"].width
    while winCount > #REF.GridWinCount do
      CS.UnityEngine.GameObject.Instantiate(winCountSprite, REF.GridWinCount.transform)
    end
    for i = 0, #REF.GridWinCount - 1 do
      local ref = REF.GridWinCount[i].root
      ref.gameObject:SetActive(i < winCount)
    end
  end
  REF.GridWinCount.UIGrid:Reposition()
  local progressBgWidth = REF.GridWinCount.UIGrid.cellWidth * maxWinCount - REF.WinCountProgressBg.transform.localPosition.x * 2 - winCountSpriteSpace
  REF.WinCountProgressBg.UISprite.width = progressBgWidth
end

function SetPrizePreview(rewards, winCount, burstLinkFinish)
  if rewards and 0 < #rewards then
    table.sort(rewards, function(prize1, prize2)
      return prize1.id < prize2.id
    end)
    local _, curReward = table.find(rewards, function(k, v)
      return v.id == winCount
    end)
    if curReward and curReward.reward and #curReward.reward then
      local prizeWidget = _ENV["$"](REF.NodeCumulativePrize).WidgetBurstLinkGroupPrize
      prizeWidget["$SetPrizeData"](curReward.reward)
      prizeWidget["$SetPrizeTitle"](WU.GetString("Tournament_BurstLinkCumulativePrize"))
      prizeWidget["$SetPreviewCallback"](OnPrizePreview)
      WU.ToggleRendering(REF.NodeCumulativePrize, true)
    end
  end
end

function OnPrizePreview()
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("BurstLink")
  end)
end

function OnReceiveClick()
  WU.RecordButtonClick(100127201)
  this:GameRequest("fci/BurstLinkPvpBalance/"):Post({}, function(response)
    DBH.ResChange(response.resChange)
    WU.ShowRewards(response.resChange, function()
      this:GameRequest("fci/tournament/summary/"):Get(OnTournamentSummaryGet)
    end)
    DB:SyncRemote(DB:GameRequest("fci/BurstLinkPvpInfo/"):SyncInput(false))
  end)
end

function SetButtonDisplay(burstLinkFinish)
  WU.ToggleRendering(REF.ButtonMatch, not burstLinkFinish)
  WU.ToggleRendering(REF.ButtonReceive, burstLinkFinish)
end

function OnTournamentSummaryGet(summaryInfo)
  if summaryInfo then
    this:SetData("fci/tournament/summary/", summaryInfo)
    this:SetData("fci/BurstLinkPvpActor", nil)
    local activityId = this:GetData("fci/tournament/curId")
    local tournamentInfo = ACU.GetTournamentById(activityId)
    if tournamentInfo and tournamentInfo.activity then
      local needDisplay = ACU.NeedDisplay(tournamentInfo.activity)
      if needDisplay then
        local status = ACU.GetTournamentStatus(activityId)
        if status == PB.enum.TournamentStatus.NoParticipation then
          WU.AcquireWindowAsync("BurstLinkJoin", function(ui)
            _ENV["$"](ui)["$$SetTournamentInfo"](tournamentInfo.activity, nil)
          end, true)
        else
          WU.RecycleWindow(this)
        end
      else
        WU.RecycleWindow(this)
      end
    else
      WU.RecycleWindow(this)
    end
  end
end

function OnNavigateToCity()
  local condition = NU.CheckBoardSpeech(PB.enum.SpeechType.BurstLink, function(params)
    local pWinNum = tonumber(params[1])
    local pLoseNum = tonumber(params[2])
    local isFinish = false
    if m_burstLinkInfo and m_burstLinkInfo.baseInfo then
      local info = m_burstLinkInfo.baseInfo
      isFinish = pWinNum and pWinNum <= info.winNum or pLoseNum and pLoseNum <= info.failNum
    end
    return isFinish
  end)
  if condition ~= nil then
    this:BroadcastGameEvent("BoardActorSpeech", condition.id)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001272, on)
end
