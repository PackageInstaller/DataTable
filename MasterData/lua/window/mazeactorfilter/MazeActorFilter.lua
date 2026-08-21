local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local m_actors, m_actorMainList, m_actorSubList, m_actorAllList
local m_selectedUids = {}
local m_resourcesPreview = {}
local m_chipsPreview = {}
local m_decomposeResultMap = {}
local m_coroutine
local m_talentDisplayDuration = 2
local m_bottomBarVisible = false
local m_filterFunc, m_toggleType, m_initWindow, m_dirty, m_bindKey, m_seqActor
local m_mazeId = 0
local m_maxSelectCnt = 0

function SetupWindow()
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_actors ~= nil and m_actors[dataIndex]
    end,
    updateSlot = UpdateActorSlot,
    delta = 0.01
  })
  LU.Bind(REF.SubSelectWrapContent, {
    updateRow = OnSubSelectUpdate
  })
  LU.Bind(REF.MainSelectWrapContent, {
    updateRow = OnMainSelectUpdate
  })
  WU.BindButtonEvent(REF.ButtonOK, OnBtnOK)
end

function OnBtnOK()
  local actors = {}
  local uids = {}
  local sameMap = {}
  local hasMain = false
  local hasSame = false
  for i, v in ipairs(m_seqActor) do
    actors[#actors + 1] = v.actor
    uids[#uids + 1] = v.actor.uid
    local actorInfo = PB.get("ActorConfig", v.actor.id)
    if actorInfo and actorInfo.kind == 1 then
      hasMain = true
    end
    if sameMap[v.actor.id] == nil then
      sameMap[v.actor.id] = 1
    else
      hasSame = true
    end
  end
  if #actors == 0 then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips6"))
    return
  end
  if not hasMain then
    WU.ShowHintText(WU.GetString("WindowActorGroup_AssistActorMustBeCarriedWithMain"))
    return
  end
  if hasSame then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips25"))
    return
  end
  this:GameRequest("fci/Maze/Actor/"):Post({actorUids = uids}, function()
    this:SetData("fci/Maze/Actor/", {actorUids = uids})
    WU.RecycleWindow(this)
    WU.AcquireWindow("MazeMain")
  end)
end

function OnActorClassify(actors)
  if actors == nil then
    return
  end
  AU.OnActorClassify(actors, "ActorMaze")
end

function InitWindow()
  WU.ToggleRendering(REF.DragActorList, false)
  m_selectedUids = {}
  m_decomposeResultMap = {}
  m_resourcesPreview = {}
  m_chipsPreview = {}
  m_seqActor = {}
  m_toggleType = 3
  m_initWindow = true
  LU.Set(REF.MainSelectWrapContent, 0)
  LU.Set(REF.SubSelectWrapContent, 0)
  this:Bind("SortFinished", function(data)
    if data ~= nil and data.sortMate == REF["$SortMate"] then
      OnActorClassify(data.list)
    end
  end)
  this:Bind("ActorMaze/Actor/All/", function(data)
    if data == nil then
      return
    end
    m_actorAllList = data
    if m_initWindow then
      m_initWindow = false
      m_actors = m_actorAllList
    end
    m_dirty = true
  end)
  UpdateBottomSelect()
  m_mazeId = this:GetData("fci/MazeId")
  m_maxSelectCnt = PB.get("MazeInfo", m_mazeId).maxActorCount
end

function UninitWindow()
  m_filterFunc = nil
end

function LateUpdateWindow()
  if m_dirty then
    m_dirty = false
    m_actors = m_actorAllList
    ResetWrapContent()
  end
end

function ResetWrapContent()
  WU.ToggleRendering(REF.DragActorList, true)
  REF.NodeEmpty.gameObject:SetActive(#m_actors == 0)
  local row = math.ceil(#m_actors / #REF.WrapContentActor[0]["$"])
  LU.Set(REF.WrapContentActor, row)
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActor.UIWrapContent.itemSize, 0)
  REF.BottomBarSpace.gameObject:SetActive(0 < row)
end

function UpdateAllList()
  m_actors = m_actorAllList
  ResetWrapContent()
end

function UpdateActorSlot(slotRef, actor)
  if actor ~= nil then
    slotRef["$$BindActor"](actor)
    slotRef["$$SetSelected"](m_selectedUids[actor.uid])
    if not actor.isLock then
      slotRef["$$SetClickCallback"](function()
        this:Bind("fci/actor/" .. actor.uid, function(actor)
          OnActorClick(slotRef, actor)
        end)
      end)
    end
  else
    slotRef["$$ClearSlot"]()
  end
end

function UpdateSelectSeq()
  for i, v in ipairs(m_seqActor) do
    v.ref["$$SetSeq"](i)
  end
end

function UpdateBottomSelect()
  m_actorSubList = {}
  m_actorMainList = {}
  for k, v in ipairs(m_seqActor) do
    local actorConfig = PB.get("ActorConfig", v.actor.id)
    if actorConfig then
      if actorConfig.kind == PB.enum.ActorType.Main then
        table.insert(m_actorMainList, v)
      elseif actorConfig.kind == PB.enum.ActorType.Sub then
        table.insert(m_actorSubList, v)
      end
    end
  end
  LU.Set(REF.MainSelectWrapContent, #m_actorMainList)
  LU.Set(REF.SubSelectWrapContent, #m_actorSubList)
  REF.LabelSelectNum.UILabel.text = string.format("%d/%d", #m_seqActor, m_maxSelectCnt)
end

function OnActorClick(ref, actor)
  if actor == nil or actor.id == 0 then
    return
  end
  local selected = m_selectedUids[actor.uid]
  if selected then
    m_selectedUids[actor.uid] = nil
    selected = false
    local index = 0
    for i, v in ipairs(m_seqActor) do
      if v.uid == actor.uid then
        index = i
        break
      end
    end
    if 0 < index then
      table.remove(m_seqActor, index)
    end
  elseif #m_seqActor >= m_maxSelectCnt then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips5"))
  else
    m_selectedUids[actor.uid] = actor
    selected = true
    local temp = {}
    temp.uid = actor.uid
    temp.ref = ref
    temp.actor = actor
    m_seqActor[#m_seqActor + 1] = temp
  end
  ref["$$SetSelected"](selected)
  UpdateSelectSeq()
  UpdateBottomSelect()
end

function OnSelectActorClick(slotRef, actor)
end

function OnSubSelectUpdate(slotRef, wrapIndex, realIndex)
  if m_actorSubList and realIndex ~= nil and realIndex < #m_actorSubList then
    local data = m_actorSubList[realIndex + 1]
    local actor = data.actor
    slotRef["$$BindActor"](actor)
    slotRef["$$SetClickCallback"](function()
      this:Bind("fci/actor/" .. actor.uid, function(actor)
        OnActorClick(data.ref, actor)
      end)
    end)
  end
end

function OnMainSelectUpdate(slotRef, wrapIndex, realIndex)
  if m_actorMainList and realIndex ~= nil and realIndex < #m_actorMainList then
    local data = m_actorMainList[realIndex + 1]
    local actor = data.actor
    slotRef["$$BindActor"](actor)
    slotRef["$$SetClickCallback"](function()
      this:Bind("fci/actor/" .. actor.uid, function(actor)
        OnActorClick(data.ref, actor)
      end)
    end)
  end
end

function RemoveActorFromRollerBind(bindString, uids)
  local actorTraverse = this:GetData(bindString)
  if actorTraverse ~= nil then
    for i = 1, #uids do
      local idx = table.find(actorTraverse, function(k, v)
        return v.uid == uids[i]
      end)
      if idx ~= nil then
        table.remove(actorTraverse, idx)
      end
    end
    this:SetData(bindString, actorTraverse)
  end
end
