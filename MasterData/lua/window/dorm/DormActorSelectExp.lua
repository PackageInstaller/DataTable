local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_dormInfo, m_arrangementData, m_floor, m_actorList, m_inEditMode, m_extendExpSeatCost, m_expSeats

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonAddActor, function()
    SetExpEdit()
  end)
  WU.BindButtonEvent(REF.ButtonOK, OnClickOK)
  LU.Bind(REF.WrapContentExp, {
    updateRow = UpdateSlotExp
  })
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateSlotCardS
  })
end

function InitWindow()
  m_actorList = _ENV["!"](this:GetData("fci/actor")):where(function(k, v)
    return true
  end)
  m_floor = this:GetData("Dorm/CurrentFloor")
  this:Bind("fci/dorm/{playerId}", OnDormChange)
end

function UninitWindow()
  m_inEditMode = nil
end

function OnDormChange(dormData)
  if dormData then
    m_dormInfo = dormData.dormInfo
    local _
    _, m_arrangementData = table.find(m_dormInfo.dormArrangement, function(k, v)
      return v.floor == m_floor
    end)
    if m_dormInfo.feedSeatMax < PB.index("Misc", 1).dormFeedSeatMax then
      m_extendExpSeatCost = PB.get("DormExtensionCost", PB.enum.DormExtensionType.FeedSeat, m_dormInfo.feedSeatMax + 1).cost[1]
    end
    m_expSeats = _ENV["!"](m_dormInfo.feedSeat):where(function(k, v)
      return v ~= 0
    end):toarray()
    ResetView()
  end
end

function ResetView()
  if m_inEditMode == nil then
    m_inEditMode = false
  end
  if m_inEditMode then
    SetExpEdit()
  else
    SetExpDisplay()
  end
end

function DeactiveAll()
  WU.SetActive(REF.NodeScrollViewExp, false)
  WU.SetActive(REF.NodeEdit, false)
  WU.SetActive(REF.NodeOperation, false)
end

function SetNodeActive(...)
  DeactiveAll()
  local nodes = {
    ...
  }
  for i = 1, #nodes do
    WU.SetActive(nodes[i], true)
  end
end

function SetExpDisplay()
  m_inEditMode = false
  SetNodeActive(REF.NodeScrollViewExp, REF.NodeEdit)
  REF.NodeScrollViewExp.transform.localPosition = CS.UnityEngine.Vector3.zero
  SetExpList()
  SetCount()
end

function SetExpEdit()
  m_inEditMode = true
  SetNodeActive(REF.NodeScrollViewExp, REF.NodeOperation)
  REF.NodeScrollViewExp.transform.localPosition = CS.UnityEngine.Vector3(0, 66, 0)
  SetExpList()
  LU.Set(REF.ActorSelectWidgetGrid, #m_actorList)
  SetCount()
end

function SetExpList()
  local isMax = m_dormInfo.feedSeatMax >= PB.index("Misc", 1).dormFeedSeatMax
  LU.Set(REF.WrapContentExp, m_dormInfo.feedSeatMax + fif(isMax, 0, 1))
  this:DelayInvokeInFrames(1, function()
    REF.ScrollViewExp.UIScrollView:ForceResetPosition()
  end)
end

function SetCount()
  REF.LabelCount.UILabel.text = WU.GetString("WindowActorListSort_FilteredCount", string.format("%s/%s", #m_expSeats, m_dormInfo.feedSeatMax))
end

function UpdateSlotExp(goRef, wrapIndex, realIndex)
  if realIndex and m_expSeats and realIndex + 1 <= PB.index("Misc", 1).dormFeedSeatMax then
    if realIndex < #m_expSeats then
      local uid = m_expSeats[realIndex + 1]
      local expAddMap = this:GetData("Dorm/ExpAddMap")
      local expAddPerHour = this:GetData("Dorm/ExpAddPerHour")
      local expAdd = expAddMap and expAddMap[uid] and expAddMap[uid].expAdd or 0
      if expAdd > expAddPerHour / 60 then
        goRef["$$SetExp"](uid, expAddMap[uid], expAddPerHour)
        expAddMap[uid] = nil
      else
        goRef["$$SetActor"](uid)
      end
      goRef["$$SetClickCallback"](SetExpEdit)
    elseif realIndex + 1 <= m_dormInfo.feedSeatMax then
      goRef["$$SetEmpty"]()
      goRef["$$SetClickCallback"](SetExpEdit)
    else
      goRef["$$SetBuy"](m_extendExpSeatCost)
      goRef["$$SetClickCallback"](OnClickExtendExpSeat)
    end
  end
end

function UpdateSlotCardS(goRef, wrapIndex, realIndex)
  if realIndex and realIndex < #m_actorList then
    local actor = m_actorList[realIndex + 1]
    goRef["$$BindActor"](actor)
    goRef["$$SetClickCallback"](OnClickCardS)
    goRef["$$SetHoldCallback"](nil)
    goRef["@uid"] = actor.uid
    goRef["$$SetActor"](actor)
    goRef["$$SetSelected"](table.has(m_expSeats, actor.uid))
  end
end

function OnClickCardS(go)
  local valid = false
  local uid = _ENV["$"](go)["@uid"]
  local idx = table.find(m_expSeats, function(k, v)
    return v == uid
  end)
  if idx then
    table.remove(m_expSeats, idx)
    valid = true
  elseif #m_expSeats < m_dormInfo.feedSeatMax then
    table.insert(m_expSeats, uid)
    valid = true
  end
  if valid then
    _ENV["$"](go)["$$SetSelected"](idx == nil)
    ResetView()
  end
end

function OnClickOK()
  m_dormInfo.feedSeat = m_expSeats
  this:GameRequest("fci/dorm-actor-seat/"):Post({feedSeat = m_expSeats}, function(resp)
    this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
    SetExpDisplay()
  end)
end

function OnClickExtendExpSeat()
  if m_extendExpSeatCost then
    WU.TryToPay(m_extendExpSeatCost.type, m_extendExpSeatCost.id, m_extendExpSeatCost.count, function()
      DU.ShowExtendMessage(PB.enum.DormExtensionType.FeedSeat, m_dormInfo.feedSeatMax + 1, function()
        m_dormInfo.feedSeatMax = m_dormInfo.feedSeatMax + 1
        this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
      end)
    end, function()
      WU.ShowHintText(WU.GetString("Error_CostResourceNotEnough"))
    end)
  else
    error("GamePlay", "dorm extend exp seat cost is none")
  end
end
