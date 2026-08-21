local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local Data = {
  dungeonReward = nil,
  powerMultiple = 1,
  leftTimes = 0,
  displayAttrs = false,
  displayArms = false,
  OnButtonAddTimesClick = nil,
  canAddTimes = nil,
  Fight = nil,
  showname = nil,
  showarm = nil,
  showequip = nil,
  curShow = nil
}
local m_multiPowerInitFailed, m_price
local m_initedToggle = false
local m_dungeonType = 0
local m_dungeonId = 0

function SetupWindow()
  if REF.ButtonTeamRecommend then
    REF.ButtonTeamRecommend.gameObject:SetActive(false)
  end
  if REF.ToggleAttrs then
    CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
      SetToggleMutex("displayAttrs", CS.UIToggle.current.value)
      RefreshAttrDisplay()
    end)
    this:DelayInvokeEndOfFrame(function()
      CS.EventDelegate.Add(REF.ToggleAttrs.UIToggle.onChange, function()
        WU.RecordButtonClick(fif(Data.displayAttrs, 5424, 5425))
      end)
    end)
  end
  if REF.ButtonMultiPower then
    WU.BindButtonEvent(REF.ButtonMultiPower, OnButtonMultiPowerClick)
  end
  if REF.PowerDropListButtonMask then
    WU.BindButtonEvent(REF.PowerDropListButtonMask, function()
      WU.ToggleRendering(REF.PowerDropList, false)
    end)
  end
  if REF.PowerDropListGrid then
    WU.TraverseChildren(REF.PowerDropListGrid, function(go, i)
      CS.EventDelegate.Add(REF.PowerDropListGrid[i].root.UIToggle.onChange, function()
        if CS.UIToggle.current.value then
          WU.ToggleRendering(REF.PowerDropList, false)
          Data.powerMultiple = i + 1
          if m_price then
            REF.LabelCost.UILabel.text = Data.powerMultiple * m_price.count
          end
        end
      end)
    end)
  end
  if REF.ButtonSprite then
    WU.BindButtonEvent(REF.ButtonSprite, function()
      if not DU.IsWaitingForJob(OnButtonFightClick) then
        WU.RecordButtonClick(154002)
        OnButtonFightClick()
      end
    end)
  end
  if REF["$Animator"] then
    REF["$Animator"]:Play("DelayOpen", -1, 0)
  end
  SetupToggleAutoFight()
  SetupButtonTeamRecommend()
end

function OnButtonFightClick()
  local showPlayTimesLimit = Data.dungeonReward and Data.dungeonReward.enterTimes > 0
  if showPlayTimesLimit and 0 >= Data.leftTimes then
    if Data.canAddTimes == nil or Data.canAddTimes == true then
      WU.ShowMessageYesNo(WU.GetString("Window_AskToBuyPlayTimes"), function(result)
        if result == "YES" then
          Data.OnButtonAddTimesClick()
        end
      end)
    else
      WU.ShowHintText(WU.GetString("Error_DungeonDoneTimes"))
    end
  elseif WU.IsStandaloneGame() then
    Data.Fight()
  elseif m_price and 0 < m_price.count then
    WU.TryToPay(m_price.type, m_price.id, Data.powerMultiple * m_price.count, Data.Fight, function()
      WU.ShowMessageYesNo(WU.GetString("ActorGroup_PowerNotEnough"), function(result)
        if result == "YES" then
          WU.Exchange(PB.enum.ResourceType.ResPlayerPower)
        end
      end)
    end)
  else
    Data.Fight()
  end
end

function OnDungeonInfo(dungeonId, balanceDungeonId)
  if dungeonId then
    if balanceDungeonId then
      local price1 = DU.GetDungeonPrice(dungeonId)
      local price2 = DU.GetDungeonPrice(balanceDungeonId)
      m_price = {
        type = price1.type,
        id = price1.id,
        count = price1.count + price2.count
      }
      Data.dungeonReward = PB.get("DungeonReward", balanceDungeonId)
    else
      m_price = DU.GetDungeonPrice(dungeonId)
      Data.dungeonReward = PB.get("DungeonReward", dungeonId)
    end
    WU.SetActive(REF.ButtonMultiPower, m_price.count > 0)
    if m_price then
      REF.LabelCost.UILabel.text = Data.powerMultiple * m_price.count
    end
  end
  if WU.IsStandaloneGame() then
    REF.LabelCost.gameObject:SetActive(false)
  end
end

function SetMultiPowerStatus(dungeonRecord, wheelDungeonEntrance)
  local dungeonReward = Data.dungeonReward
  m_multiPowerInitFailed = dungeonRecord == nil or dungeonReward == nil
  if m_multiPowerInitFailed then
    return
  end
  local starCount = fif(dungeonRecord.finished, #dungeonRecord.targetsDone, 1)
  local lastMultiPower = fif(dungeonRecord.multiPower == 0, 1, dungeonRecord.multiPower)
  local leftTimes = math.max(0, dungeonReward.enterTimes - (dungeonRecord.doneTimes or 0))
  Data.leftTimes = leftTimes
  local cost, costWin
  if wheelDungeonEntrance then
    local entranceReward = PB.get("DungeonReward", wheelDungeonEntrance)
    cost = entranceReward.cost or {count = 0}
    costWin = dungeonReward.costWin or {count = 0}
  else
    cost = dungeonReward.cost[1] or {count = 0}
    costWin = dungeonReward.costWin[1] or {count = 0}
  end
  for i = 0, 2 do
    local choice = REF.PowerDropListGrid[i]
    choice.LabelStarReq.UILabel.text = fif(i == 0, "", WU.GetString("Window_starCountToUnlock", i + 1))
    choice.LabelPower.ResourcePrinter:SetResource(cost.type, cost.id, (i + 1) * (cost.count + costWin.count))
    choice.root.UIToggle.optionCanBeNone = true
    choice.root.UIToggle.value = false
    choice.root.UIToggle.optionCanBeNone = false
    choice.root.BoxCollider2D.enabled = i < starCount and (leftTimes == 0 or i < leftTimes)
    choice.LabelPower.UIHtmlLabel.color = fif(i < starCount, CS.NGUIMath.HexToColor(4294967295), CS.NGUIMath.HexToColor(2948455935))
    local timesLimited = 0 < leftTimes and i >= leftTimes
    WU.ToggleRendering(choice.LabelTimeLimit, timesLimited)
    WU.ToggleRendering(choice.LabelStarReq, not timesLimited and i >= starCount)
  end
  local selectIndex = fif(leftTimes == 0 or leftTimes > lastMultiPower - 1, lastMultiPower - 1, 0)
  REF.PowerDropListGrid[selectIndex].root.UIToggle.value = true
end

function ShowStars(count)
  if count == 0 then
    REF.WidgetStarGridMTargets["$SetStar"](0)
  else
    REF.WidgetStarGridMTargets["$SetStar"](count, 3 - count)
  end
end

function OnButtonMultiPowerClick()
  if m_multiPowerInitFailed then
    warning("ActorGroup", "SetMultiPowerStatus failed!!")
    WU.ShowHintText(WU.GetString("SetMultiPowerStatus_Failed"))
    return
  end
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.MultiPower, PB.enum.UnlockWindow.MultiPower) then
    WU.ToggleRendering(REF.PowerDropList, true)
  end
end

function RefreshAttrDisplay()
  REF.WidgetGroupMembers["$DisplayAttrs"](Data.displayAttrs)
  if REF.ToggleAttrs.UIToggle.value ~= Data.displayAttrs then
    REF.ToggleAttrs.UIToggle.value = Data.displayAttrs
  end
end

function Member2FightActorInfo(members)
  if this:GetData("FightActorInfoSynced") then
    return
  end
  local actorList = {}
  for i = 1, #members do
    local member = members[i]
    local actor = {}
    if member.isNpc then
      actor = PB.get("DungeonNPC", member.npcId)
      AU.RenameDungeonNPCFields(actor)
    else
      actor = this:GetData("fci/actor/" .. member.actorUid) or {}
    end
    actorList[member.index + 1] = actor
  end
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  this:SetData("FightAgainInfo", fightActorInfo)
end

function Member2FightActorInfoTowerNew(members)
  if this:GetData("FightActorInfoSynced") then
    return
  end
  local actorList = {}
  local team = this:GetData("fci/extreme-challenge/select-actors/")
  for i = 1, #members do
    local member = members[i]
    local actor = table.find(team, function(k, v)
      if v.actor then
        return v.actor.uid == member.actor.uid
      end
    end)
    actorList[member.index + 1] = fif(actor, actor, {})
  end
  local fightActorInfo = {
    {
      playerId = this:GetData("playerId"),
      actors = actorList
    }
  }
  this:SetData("FightActorInfo", fightActorInfo)
  this:SetData("FightAgainInfo", fightActorInfo)
end

function GetData(name)
  return Data[name]
end

function SetData(name, value)
  Data[name] = value
end

function RefreshGroupMembersAndTween(members, replay)
  if members then
    REF.WidgetGroupMembers["$SetGroupMembers"](members)
    if REF.WidgetGroupCultivation then
      REF.WidgetGroupCultivation["$SetGroupMembers"](members)
    elseif REF.WidgetGroupCultivation4Group then
      REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
    end
    ModifyMemberShowOption()
    WU.ToggleRendering(REF.WidgetGroupMembers, true)
    if replay then
      REF.WidgetGroupMembers.UIPlayTween.enabled = false
      REF.WidgetGroupMembers.UIPlayTween.enabled = true
    end
  end
end

function ModifyMemberShowOption()
  REF.WidgetGroupMembers["$ShowCustom"]({
    showEquips = Data.curShow == Data.showequip,
    showName = Data.curShow == Data.showname,
    showArm = Data.curShow == Data.showarm
  })
end

function SetLeftTimes(dungeonRecord)
  local dungeonReward = Data.dungeonReward
  local showPlayTimesLimit = dungeonReward and dungeonReward.enterTimes > 0
  WU.ToggleRendering(REF.ButtonAddTimes, dungeonRecord ~= nil and showPlayTimesLimit)
  if dungeonRecord and showPlayTimesLimit then
    local leftTimes = math.max(0, dungeonReward.enterTimes - dungeonRecord.doneTimes)
    REF.LabelRestTimes.UILabel.text = leftTimes
    REF.SpriteAddTimes.gameObject:SetActive(leftTimes <= 0)
    REF.ButtonAddTimes.UIButton.isEnabled = leftTimes <= 0
    Data.leftTimes = leftTimes
  end
end

function AppendAuraAttrs(param)
  local aura = this:GetData("Assistant/Aura")
  if aura ~= nil then
    param.auraPlayerId = aura.playerId
    param.auraActorId = aura.actorId
    param.auraStranger = aura.stranger
    this:SetData("FightInfo/Aura", aura)
  end
end

function FightAfterCultivationTest(members, dungeonId)
  if this:GetData("CultivationNeverShow") then
    return true
  end
  local testResult = DU.CultivationReachExpection(members, dungeonId)
  if testResult.isReach then
    return true
  end
  return false, testResult
end

function FightCultivationHint(testResult, skipCallback)
  local actor = testResult.suggest
  if actor == nil then
    skipCallback()
    return
  end
  local tabName = AU.GetImprovePart(testResult.suggest)
  local strKey = string.sub(tabName, string.len("Tab") + 1)
  local actorName = WU.GetString("ActorName_" .. tostring(actor.id))
  local msgContent = WU.GetString("Window_SuggestImproveCultivation") .. WU.GetString("ActorRecommend_" .. strKey, actorName)
  WU.ShowMessageYesNo(msgContent, function(result, toggleSelect)
    if toggleSelect then
      this:SetData("CultivationNeverShow", true)
    end
    if result == "YES" then
      skipCallback()
    elseif result == "NO" then
      WU.AcquireWindowAsync("ActorInfo", function(window)
        this:SetData("Actor/SelectedUid", actor.uid)
        this:BroadcastGameEvent("EventSwitchTab", tabName)
      end)
    end
  end, WU.GetString("Window_SuggestImproveCultivationContinue"), WU.GetString("Window_SuggestImproveCultivationImprove"), nil, nil, true, WU.GetString("Window_NeverShowBeforeNextLogin"))
end

function ResetAuraSelection()
  this:SetData("Assistant/Aura", nil)
  this:SetData("fci/dungeon-assistants/", {})
  local token = this:GetData("AuraToken") or 0
  this:SetData("AuraToken", token + 1)
  REF.LoadingHint.gameObject:SetActive(false)
  REF.AuraDragScrollView.gameObject:SetActive(false)
  REF.WidgetAuraSelection["$SetLoadingHint"]()
  this:GameRequest("fci/dungeon-assistants/"):SyncInput(false):Post({
    token = token + 1
  }, function(assistants)
    this:BroadcastGameEvent("UnforcedTutorial/ActorGroup", #assistants)
    if table.empty(assistants) then
      return
    end
    local newestToken = this:GetData("AuraToken")
    if assistants[1].token == newestToken then
      this:SetData("fci/dungeon-assistants/", assistants)
      REF.WidgetAuraSelection["$OnAuraClick"](REF.AuraWrapContent[0]["$gameObject"])
    end
  end, function()
    this:BroadcastGameEvent("UnforcedTutorial/ActorGroup", 0)
  end)
end

function SetupToggleAutoFight()
  if REF.ToggleAutoFight then
    CS.EventDelegate.Add(REF.ToggleAutoFight.UIToggle.onChange, function()
      if m_initedToggle then
        DU.SetAutoFight(m_dungeonType, CS.UIToggle.current.value)
        DU.SendAutoFightSetting()
      end
    end)
  else
  end
end

function InitAutoFight(dungeonType)
  m_dungeonType = dungeonType
  if REF.ToggleAutoFight then
    local unlock = not WU.WindowIsLocked(PB.enum.UnlockWindow.AutoFight)
    REF.ToggleAutoFight.gameObject:SetActive(unlock)
    REF.ToggleAutoFight.UIToggle.value = DU.IsAutoFightOpen(m_dungeonType)
    m_initedToggle = true
  else
  end
  if REF.RightBottomGrid then
    REF.RightBottomGrid.UIGrid:Reposition()
  end
  this:Bind("DisplayOptionChange", OnDisplayOptionChange)
end

function OnDisplayOptionChange(data)
  local optionKey = WU.GetGameDataCache("LocalDisplayOption") or "name"
  Data.showname = false
  Data.showarm = false
  Data.showequip = false
  Data["show" .. optionKey] = true
  Data.curShow = Data["show" .. optionKey]
  ModifyMemberShowOption()
end

function SetToggleMutex(prioritiy, flag)
  Data.displayAttrs = false
  Data.displayArms = false
  local toggleVals = {
    Data.displayAttrs,
    Data.displayArms
  }
  local toggleRef = {
    "ToggleAttrs",
    "ToggleArms"
  }
  Data[prioritiy] = flag
  for k, v in pairs(toggleRef) do
    if REF[v] and REF[v].UIToggle.value ~= toggleVals[k] then
      REF[v].UIToggle.value = toggleVals[k]
    end
  end
  RefreshAttrDisplay()
end

function SetupButtonTeamRecommend()
  if REF.ButtonTeamRecommend then
    WU.BindButtonEvent(REF.ButtonTeamRecommend, function()
      WU.AcquireWindowAsync("TeamRecommendActorGroup", function(window)
        _ENV["$"](window)["$$SetData"]({dungeonType = m_dungeonType, dungeonId = m_dungeonId})
      end)
    end)
  end
end

function InitTeamRecommend(dungeonType, dungeonId)
  m_dungeonType = dungeonType
  m_dungeonId = dungeonId
  if REF.ButtonTeamRecommend then
    local dungeonReward = PB.get("DungeonReward", dungeonId)
    WU.SetActive(REF.ButtonTeamRecommend, dungeonReward and dungeonReward.recommendActorGroup)
    WU.SetActive(REF.ButtonTeamRecommend, false)
  end
end
