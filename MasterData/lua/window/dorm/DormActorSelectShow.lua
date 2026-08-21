local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_dormInfo, m_floor, m_floorLevel, m_actorList, m_inEditMode, m_floorConfig, m_showSeats

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonAddActor, function()
    SetShowEdit()
  end)
  WU.BindButtonEvent(REF.ButtonExtend, OnClickExtendShowSeat)
  WU.BindButtonEvent(REF.ButtonOK, OnClickOK)
  LU.Bind(REF.WrapContentShow, {
    updateRow = UpdateSlotShow
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
    m_floorLevel = PB.get("DormConfig", m_dormInfo.dormLevel).floorLevel[m_floor]
    m_floorConfig = PB.get("DormFloorConfig", m_floorLevel)
    local _, showActors = table.find(m_dormInfo.showActors, function(k, v)
      return v.floor == m_floor
    end)
    if showActors then
      m_showSeats = _ENV["!"](showActors.actorsUid):duplicate()
    else
      m_showSeats = _ENV["!"]({})
    end
    ResetView()
  end
end

function ResetView()
  if m_inEditMode == nil then
    m_inEditMode = false
  end
  if m_inEditMode then
    SetShowEdit()
  else
    SetShowDisplay()
  end
end

function DeactiveAll()
  WU.SetActive(REF.NodeScrollViewShow, false)
  WU.SetActive(REF.NodeEdit, false)
  WU.SetActive(REF.NodeOperation, false)
  WU.SetActive(REF.ButtonExtend, false)
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

function SetShowDisplay()
  m_inEditMode = false
  SetNodeActive(REF.NodeScrollViewShow, REF.NodeEdit, REF.ButtonExtend)
  REF.NodeScrollViewShow.transform.localPosition = CS.UnityEngine.Vector3.zero
  SetShowList()
  SetCount()
end

function SetShowEdit()
  m_inEditMode = true
  SetNodeActive(REF.NodeScrollViewShow, REF.NodeOperation)
  REF.NodeScrollViewShow.transform.localPosition = CS.UnityEngine.Vector3(0, 100, 0)
  SetShowList()
  LU.Set(REF.ActorSelectWidgetGrid, #m_actorList)
  SetCount()
end

function SetShowList()
  local isMax = m_floorLevel >= #PB.all("DormFloorConfig")
  local nextSeatCnt
  if not isMax then
    nextSeatCnt = PB.get("DormFloorConfig", m_floorLevel + 1).showSeatCount
  end
  LU.Set(REF.WrapContentShow, nextSeatCnt or m_floorConfig.showSeatCount)
  this:DelayInvokeInFrames(1, function()
    REF.ScrollViewShow.UIScrollView:ForceResetPosition()
  end)
end

function SetCount()
  REF.LabelCount.UILabel.text = WU.GetString("WindowActorListSort_FilteredCount", string.format("%s/%s", #m_showSeats, m_floorConfig.showSeatCount))
end

function UpdateSlotShow(goRef, wrapIndex, realIndex)
  if realIndex and m_showSeats then
    if realIndex < #m_showSeats then
      local uid = m_showSeats[realIndex + 1]
      local actorId = this:GetData("fci/actor/" .. uid).id
      goRef["$$SetActor"](actorId)
      goRef["$$SetClickCallback"](SetShowEdit)
    elseif realIndex + 1 <= PB.get("DormFloorConfig", m_floorLevel).showSeatCount then
      goRef["$$SetEmpty"]()
      goRef["$$SetClickCallback"](SetShowEdit)
    else
      goRef["$$SetExtend"]()
      goRef["$$SetClickCallback"](nil)
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
    goRef["$$SetSelected"](table.has(m_showSeats, actor.uid))
  end
end

function OnClickCardS(go)
  local valid = false
  local uid = _ENV["$"](go)["@uid"]
  local idx = table.find(m_showSeats, function(k, v)
    return v == uid
  end)
  if idx then
    table.remove(m_showSeats, idx)
    valid = true
  elseif #m_showSeats < m_floorConfig.showSeatCount then
    table.insert(m_showSeats, uid)
    valid = true
  end
  if valid then
    _ENV["$"](go)["$$SetSelected"](idx == nil)
    ResetView()
  end
end

function OnClickOK()
  this:GameRequest("fci/dorm/show-actor"):Post({floor = m_floor, actorsUid = m_showSeats}, function(resp)
    local idx = table.find(m_dormInfo.showActors, function(k, v)
      return v.floor == m_floor
    end)
    local showActors = {floor = m_floor, actorsUid = m_showSeats}
    if idx then
      m_dormInfo.showActors[idx] = showActors
    else
      table.insert(m_dormInfo.showActors, showActors)
    end
    this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
    SetShowDisplay()
  end)
end

function OnClickExtendShowSeat()
  DU.ShowExtendFloorMessage(function()
    WU.ShowHintText("Dorm_UpgradeDormSucceed")
  end)
end
