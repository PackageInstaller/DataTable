local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local m_pageIndex = -1
local m_targetActors
local m_lineupGOIndexMap = {}

function SetupWindow()
  REF.LineupContent.UICenterOnChild.onCenter = OnCenterCallback
  WU.BindButtonEvent(REF.ButtonPrevious, function()
    if 0 < m_pageIndex then
      REF.LineupContent.UICenterOnChild:CenterOn(REF.LineupContent[m_pageIndex - 1]["$transform"])
    end
  end)
  WU.BindButtonEvent(REF.ButtonNext, function()
    if m_pageIndex < #REF.LineupContent - 1 then
      REF.LineupContent.UICenterOnChild:CenterOn(REF.LineupContent[m_pageIndex + 1]["$transform"])
    end
  end)
  WU.BindButtonEvent(REF.ButtonPrepare, function()
    GU.SetGroupMode(PB.enum.ActorGroupType.AsyncPvp)
    WU.AcquireWindowAsync("TournamentActorGroup", function(ui)
      _ENV["$"](ui)["$$SetUid"](m_targetActors[m_pageIndex + 1].uid)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonRefresh, OnRefreshOpponent)
end

function SetData(targetActors, curIndex)
  m_targetActors = targetActors
  m_lineupGOIndexMap = {}
  WU.TraverseChildren(REF.LineupContent, function(go, i)
    UpdateLineupList(go, i, i)
  end)
  WU.TraverseChildren(REF.PageIndicator, function(go, i)
    local isActive = false
    if m_targetActors then
      local actor = m_targetActors[i + 1]
      if actor then
        isActive = true
      end
    end
    go:SetActive(isActive)
  end)
  REF.LineupContent.UICenterOnChild.enabled = false
  local itemSize = REF.LineupContent.UIGrid.cellWidth
  REF.LineupScrollView.transform.localPosition = CS.UnityEngine.Vector3(curIndex * -itemSize, 0, 0)
  REF.LineupScrollView.UIPanel.clipOffset = CS.UnityEngine.Vector2(curIndex * itemSize, 0)
  REF.LineupContent.UICenterOnChild.enabled = true
end

function UpdateLineupList(gameObject, wrapIndex, realIndex)
  local isActive = false
  if m_targetActors then
    local gameObjectRef = _ENV["$"](gameObject)
    local actor = m_targetActors[realIndex + 1]
    if actor then
      isActive = true
      gameObjectRef.LabelTitle.UILabel.text = actor.name .. " " .. WU.GetString("Window_Level", actor.level)
      gameObjectRef.WidgetDungeonGroup["$SetViewByActors"](actor.targetBattleActors, true, true)
    end
  end
  gameObject:SetActive(isActive)
  if isActive then
    m_lineupGOIndexMap[gameObject] = realIndex
  end
end

function OnCenterCallback(gameObject)
  local centeredIndex = m_lineupGOIndexMap[gameObject]
  if centeredIndex ~= nil then
    if m_pageIndex ~= centeredIndex then
      if 0 <= m_pageIndex then
        local previousDot = REF.PageIndicator.transform:GetChild(m_pageIndex)
        previousDot:GetComponent(typeof(CS.UISprite)).spriteName = "dot_dark"
      end
      m_pageIndex = centeredIndex
      if 0 <= m_pageIndex then
        local currentDot = REF.PageIndicator.transform:GetChild(m_pageIndex)
        currentDot:GetComponent(typeof(CS.UISprite)).spriteName = "dot_light"
      end
    end
    local color = CS.NGUIMath.HexToColor(4294967295)
    if m_pageIndex == 0 then
      color = CS.NGUIMath.HexToColor(4294967167)
    end
    REF.ButtonPrevious.UISprite.color = color
    color = CS.NGUIMath.HexToColor(4294967295)
    if m_targetActors ~= nil and m_pageIndex >= #m_targetActors - 1 then
      color = CS.NGUIMath.HexToColor(4294967167)
    end
    REF.ButtonNext.UISprite.color = color
    if m_targetActors ~= nil then
      local actor = m_targetActors[m_pageIndex + 1]
      WU.ToggleRendering(REF.ButtonPrepare, not actor.isWin)
      WU.ToggleRendering(REF.ButtonRefresh, not actor.isWin)
      WU.ToggleRendering(REF.LabelDefeated, actor.isWin)
    end
  end
end

function OnRefreshOpponent()
  local all = PB.all("RefreshPrice")
  local _, info = all:find(function(k, v)
    return v.type == PB.enum.RefreshPriceType.AsyncPvpRefreshTarget
  end)
  if info then
    local resIconHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[info.cost.type] .. "_" .. info.cost.id .. "' />"
    local hasRes = 0
    if info.cost.type == PB.enum.ResourceType.ResItem then
      hasRes = this:GetData("fci/item/" .. info.cost.id).count
    else
      hasRes = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[info.cost.type] .. "_" .. info.cost.id)
    end
    local hasEnoughResource = hasRes >= info.count
    local text = WU.GetString("Tournament_AsyncPvpRefreshOpponent", info.count, resIconHtml, hasRes)
    WU.ShowMessageYesNo(text, function(result)
      if result == "YES" then
        if hasEnoughResource then
          SearchOpponent()
        else
          WU.ShowHintText(WU.GetString("Tournament_RefreshResourceNotEnough"))
        end
      end
    end)
  end
end

function SearchOpponent()
  this:GameRequest("fci/asyncpvpmatch"):Post({index = m_pageIndex}, function(result)
    if result then
      local actor = result.targetActor
      local gameObjectRef = REF.LineupContent[m_pageIndex]
      gameObjectRef.LabelTitle.UILabel.text = actor.name .. " " .. WU.GetString("Window_Level", actor.level)
      gameObjectRef.WidgetDungeonGroup["$SetViewByActors"](actor.targetBattleActors, true, true)
      this:SetData("AsyncPvpOpponentRefreshed", {targetActor = actor, index = m_pageIndex})
      DBH.ResChange(result.resChange)
    end
  end)
end
