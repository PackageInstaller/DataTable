local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local m_pillList = {}
local m_actorList = {}
local m_towerSumry
local m_countTotal = 0
local m_maxCountTeam = 0
local m_maxCountMain = 0
local m_maxCountSub = 0
local m_mainCount = 0
local m_subCount = 0
local m_rowCount = 10
local m_acLegal = false
local m_maxPill = 30
local m_heightSelected = 770
local m_heightNoSelected = 620
local m_buffRes, m_acRes

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonPills, function()
    this:SetData("Tower/JumpFromPreview", true)
    WU.AcquireWindowAsync("TowerNewPills")
  end)
  WU.BindButtonEvent(REF.ButtonTeam, function()
    this:SetData("Tower/JumpFromPreview", true)
    WU.AcquireWindowAsync("TowerNewTeam")
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    WU.ShowMessageYesNo(WU.GetString("Tower_ComfirmPillArmy"), function(result)
      if result == "YES" then
        local pillChoice = this:GetData("TowerNew/PillChoice")
        local actorSumry = {}
        for i = 1, #m_actorList do
          actorSumry[i] = m_actorList[i].uid or m_actorList[i].actor.uid
        end
        if pillChoice == nil or pillChoice <= 0 then
          WU.ShowHintText(WU.GetString("Tower_SetPillNotLegal"))
          return
        end
        if not m_acLegal then
          WU.ShowHintText(WU.GetString("Tower_AtleastOneMain"))
          return
        end
        local param = {selectGroup = pillChoice, actorUids = actorSumry}
        this:GameRequest("fci/extreme-challenge/select-actors-buffitems/"):Post(param, function(response)
          m_towerSumry.challengeItems = response.resChange
          m_towerSumry.itemSelectFloor = response.itemSelectFloor
          m_towerSumry.memberSelected = true
          this:SetData("fci/extreme-challenge/summary/", m_towerSumry)
          this:SetData("fci/extreme-challenge/select-actors/", {
            actors = response.actors
          })
          this:BroadcastGameEvent("OnNavigation", "TowerNewPrepare")
        end)
      else
        return
      end
    end)
  end)
end

function InitWindow()
  REF.GridPills.gameObject:SetActive(false)
  REF.ScrollViewContent.UIScrollView:ResetPosition()
  m_towerSumry = this:GetData("fci/extreme-challenge/summary/")
  local selected = m_towerSumry.itemSelectFloor >= m_towerSumry.curFloor and m_towerSumry.memberSelected
  local height = fif(selected, m_heightSelected, m_heightNoSelected)
  local width = REF.ScrollViewContent.UIPanel.width
  local pos = REF.ScrollViewContent.transform.localPosition
  REF.ScrollViewContent.UIPanel:SetRect(0, 0, width, height)
  REF.ScrollViewContent.transform.localPosition = CS.UnityEngine.Vector3(0, -20, 0)
  REF.BgBottom.gameObject:SetActive(not selected)
  REF.ContentActors.gameObject:SetActive(false)
  REF.BgWhite.UISprite.height = fif(not selected, 732, 890)
  if m_towerSumry.memberSelected then
    this:BindRemote(DB:GameRequest("fci/extreme-challenge/select-actors/"), function(result)
      OnTeamChange(result, false)
    end)
  else
    this:Bind("TowerNew/SelectedActorsLocal", function(result)
      OnTeamChange(result, true)
    end)
  end
  this:Bind("TowerNew/PillsGot", OnPillChange)
  REF.NodeChange.gameObject:SetActive(not m_towerSumry.memberSelected and m_towerSumry.itemSelectFloor < m_towerSumry.curFloor)
end

function Focus(on)
  if on then
    this:SetData("Tower/JumpFromPreview", false)
  end
end

function OnTeamChange(team, isLocal)
  if team == nil then
    return
  end
  m_actorList = team.actors or team
  if isLocal then
    m_actorList = WU.CheckActorsLocal(m_actorList)
  end
  m_maxCountSub = PB.get("ExtremeChallengeDungeon", m_towerSumry.curDifficulty).subLimit
  m_maxCountMain = PB.get("ExtremeChallengeDungeon", m_towerSumry.curDifficulty).mainLimit
  m_maxCountTeam = m_maxCountMain + m_maxCountSub
  UpdateActors()
  REF.ContentActors.gameObject:SetActive(true)
  REF.GridPills.gameObject:SetActive(true)
end

function OnPillChange(pill)
  if pill == nil then
    pill = m_towerSumry.challengeItems
  end
  m_pillList = WU.SplitItems(pill)
  table.sort(m_pillList, SortPill)
  REF.LabelPillCount.UIHtmlLabel.text = WU.GetString("Tower_Consumables") .. " : " .. #m_pillList
  WU.TraverseChildren(REF.GridPills, function(parGo, parIdx)
    local ref = _ENV["$"](parGo)
    parGo.gameObject:SetActive(parIdx + 1 <= m_maxPill / m_rowCount)
    for i = 1, m_rowCount do
      local data = m_pillList[parIdx * m_rowCount + i]
      local root = _ENV["$"](ref["Item" .. i])
      if data then
        root["$$SetData"](data.type, data.id, data.count)
        root["$$SetClickCallback"](function()
          WU.AcquireWindowAsync("TowerNewPillDetail", function(ui)
            _ENV["$"](ui)["$$SetPillDetail"](data)
          end)
        end)
      else
        root["$$SetData"](PB.enum.ResourceType.ResExtremeChallengeItem, nil, nil)
      end
    end
  end)
end

function UpdateActors()
  local mainList = {}
  local subList = {}
  for k, v in pairs(m_actorList) do
    local actor = v.actor or v
    actor.hp = v.hp
    local kind = actor.kind or v.kind
    if kind == 1 then
      table.insert(mainList, actor)
    elseif kind == 2 then
      table.insert(subList, actor)
    end
  end
  
  local function SetData(Ref, dataSource, limit)
    WU.TraverseChildren(Ref, function(parGo, parIdx)
      local ref = _ENV["$"](parGo)
      for i = 1, m_rowCount do
        local root = _ENV["$"](ref["Item" .. i])
        local boxIndex = parIdx * m_rowCount + i
        local data = dataSource[boxIndex]
        local limitReach = boxIndex > limit
        root.AlphaControl.UIWidget.alpha = 1
        root.SpriteDead.gameObject:SetActive(false)
        root.NodeAcSelected.gameObject:SetActive(false)
        root.SpriteEmpty.gameObject:SetActive(data == nil)
        if limitReach then
          root.NodeNextLock.gameObject:SetActive(boxIndex == limit + 1)
          root.LabelLock.gameObject:SetActive(boxIndex == limit + 1)
          root.SpriteLock.gameObject:SetActive(boxIndex ~= limit + 1)
          root.LabelLock.UILabel.text = WU.GetString("Tower_BoxLimit_" .. boxIndex)
          root.Visual.gameObject:SetActive(false)
        else
          root.NodeNextLock.gameObject:SetActive(false)
          root.SpriteLock.gameObject:SetActive(false)
          root.Visual.gameObject:SetActive(data ~= nil)
          if data then
            ref["Item" .. i]["$SetActor"](data)
            if data.hp == nil then
              data.hp = 1
            end
            root.AlphaControl.UIWidget.alpha = fif(data.hp < 0, 0.5, 1)
            root.SpriteDead.gameObject:SetActive(data.hp < 0)
          end
        end
      end
    end)
  end
  
  SetData(REF.GridMain, mainList, m_maxCountMain)
  SetData(REF.GridSub, subList, m_maxCountSub)
  m_subCount = #subList
  m_mainCount = #mainList
  m_countTotal = m_mainCount + m_subCount
  m_acLegal = 0 < m_mainCount and m_mainCount <= m_maxCountMain and m_subCount <= m_maxCountSub
  REF.ButtonConfirm.gameObject:SetActive(not m_towerSumry.memberSelected)
  REF.LabelSubCount.UILabel.text = WU.GetString("Tower_SubActors") .. string.format(" : %s / %s", m_subCount, m_maxCountSub)
  REF.LabelMainCount.UILabel.text = WU.GetString("Tower_MainActors") .. string.format(" : %s / %s", m_mainCount, m_maxCountMain)
end

function SortPill(a, b)
  local info1 = PB.get("ExtremeChallengeBuffItem", a.id)
  local info2 = PB.get("ExtremeChallengeBuffItem", b.id)
  
  local function Compare(param1, param2, reverse)
    if not param1 and not param2 then
      return false
    elseif param1 and not param2 then
      return true
    elseif not param1 and param2 then
      return false
    elseif param1 and param2 and param1 ~= param2 then
      if reverse then
        return param1 < param2
      else
        return param2 < param1
      end
    end
  end
  
  if info1.quality ~= info2.quality then
    return info1.quality > info2.quality
  else
    local score = Compare(info1.score, info2.score)
    if score ~= nil then
      return score
    end
    local drug = Compare(info1.isDragfastGlobal, info2.isDragfastGlobal)
    if drug ~= nil then
      return drug
    end
    return a.id < b.id
  end
end

function CheckResponse()
  if m_buffRes and m_acRes then
    m_towerSumry.challengeItems = m_pillList
    m_towerSumry.itemSelectFloor = m_buffRes.itemSelectFloor
    m_towerSumry.memberSelected = true
    this:SetData("fci/extreme-challenge/summary/", m_towerSumry)
    this:SetData("fci/extreme-challenge/select-actors/", m_acRes)
    this:BroadcastGameEvent("OnNavigation", "TowerNewPrepare")
  end
end
