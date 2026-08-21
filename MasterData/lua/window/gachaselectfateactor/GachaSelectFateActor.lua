local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local SU = require("Common/SortUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local NU = require("Common/NotepadUtil")
local m_pool, m_displayOption, m_fateActorMain
local m_mainList = {}
local m_subList = {}
local m_chooseCallback, m_backWindowCallback

function SetupWindow()
  for i = 1, 5 do
    m_mainList[i] = nil
    m_subList[i] = nil
  end
  WU.BindButtonEvent(REF.ButtonActorCollections, OnClickButtonActorCollections)
  WU.BindButtonEvent(REF.ButtonComplete, OnClickButtonComplete)
  WU.TraverseChildren(REF.WrapContentActor, function(row)
    WU.TraverseChildren(_ENV["$"](row)["$"], function(go)
      _ENV["$"](go)["$$SetClickCallback"](OnActorCardClick)
    end)
  end)
  WU.TraverseChildren(_ENV["$"](REF.Main).Container, function(go)
    WU.SetActive(_ENV["$"](go).root, false)
  end)
  WU.TraverseChildren(_ENV["$"](REF.Sub).Container, function(go)
    WU.SetActive(_ENV["$"](go).root, false)
  end)
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_pool and m_pool[dataIndex]
    end,
    updateSlot = UpdateSlot,
    delta = 0.03
  })
  WU.SetActive(REF.ActorList, false)
  this:GameRequest("fci/gacha-custom/pool/"):Get(function(pool)
    this:GameRequest("fci/gacha-custom/choose-pool/"):Get(function(choosePool)
      m_pool = {}
      for k, v in pairs(pool.poolRes) do
        local actor = PB.get("ActorConfig", v.chooseResId)
        local index, value = table.find(choosePool.choosePoolRes, function(k, v)
          return actor.id == v.chooseResId
        end)
        actor.selected = index ~= nil
        table.insert(m_pool, PB.get("ActorConfig", v.chooseResId))
        if actor.selected then
          do
            local selectedList, container
            if actor.kind == 1 then
              selectedList = m_mainList
              container = _ENV["$"](REF.Main).Container
            elseif actor.kind == 2 then
              selectedList = m_subList
              container = _ENV["$"](REF.Sub).Container
            end
            AddActor(selectedList, container, actor)
          end
        end
      end
      table.sort(m_pool, function(a, b)
        if a.kind == b.kind then
          return a.id < b.id
        else
          return a.kind < b.kind
        end
      end)
      WU.SetActive(REF.NodeEmpty, table.count(m_pool) == 0)
      LU.Set(REF.WrapContentActor, math.ceil(#m_pool / #REF.WrapContentActor))
      WU.SetActive(REF.ActorList, true)
    end)
  end)
end

function InitWindow()
end

function UpdateSlot(widget, actor)
  WU.ToggleRendering(widget["$"], actor ~= nil)
  if actor ~= nil then
    widget["@actor"] = actor
    widget["$$SetActorDataById"](actor.id)
    widget["$$SetSelected"](actor.selected)
  end
end

function OnActorCardClick(go)
  local widget = _ENV["$"](go)
  local actor = widget["@actor"]
  local selected = actor.selected
  local selectedList, container
  if actor.kind == 1 then
    selectedList = m_mainList
    container = _ENV["$"](REF.Main).Container
  elseif actor.kind == 2 then
    selectedList = m_subList
    container = _ENV["$"](REF.Sub).Container
  end
  local num = GetActorNum(selectedList)
  if selected then
    widget["$$SetSelected"](false)
    actor.selected = false
    RemoveActor(selectedList, container, actor)
  elseif num < 5 then
    widget["$$SetSelected"](true)
    actor.selected = true
    AddActor(selectedList, container, actor)
  else
    WU.ShowHintText(WU.GetString("Window_ChooseUpToFiveActor", fif(actor.kind == 1, "\228\184\187\230\136\152", "\230\143\180\230\138\164")))
  end
end

function GetActorNum(selectedList)
  local num = 0
  for i = 1, 5 do
    if selectedList[i] ~= nil then
      num = num + 1
    end
  end
  return num
end

function RemoveActor(selectedList, container, actor)
  local removeIndex
  for i = 1, 5 do
    if actor == selectedList[i] then
      selectedList[i] = nil
      WU.SetActive(container[i - 1].root, false)
      removeIndex = i
      break
    end
  end
  for i2 = 1, 5 do
    if i2 >= removeIndex then
      SetActor(selectedList, container, i2, selectedList[i2 + 1])
    end
  end
end

function AddActor(selectedList, container, actor)
  for i = 1, 5 do
    if selectedList[i] == nil then
      SetActor(selectedList, container, i, actor)
      break
    end
  end
end

function SetActor(selectedList, container, index, actor)
  if actor ~= nil then
    selectedList[index] = actor
    local widgetIconActor = container[index - 1]
    WU.SetActive(widgetIconActor.root, true)
    widgetIconActor["$$SetData"](actor.id)
    widgetIconActor["$$ShowCustom"]({
      name = false,
      showStar = false,
      showActorLevel = false
    })
  else
    selectedList[index] = nil
    WU.SetActive(container[index - 1].root, false)
  end
end

function OnClickButtonActorCollections()
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
    NU.GetCollectionsActor(function()
      WU.AcquireWindowAsync("CollectionsActor")
    end)
  end
end

function OnClickButtonComplete()
  if GetActorNum(m_mainList) == 5 and GetActorNum(m_subList) == 5 then
    local chooseRes = {}
    for i = 1, 5 do
      table.insert(chooseRes, {
        chooseResId = m_mainList[i].id,
        chooseResType = 15
      })
    end
    for i = 1, 5 do
      table.insert(chooseRes, {
        chooseResId = m_subList[i].id,
        chooseResType = 15
      })
    end
    WU.AcquireWindowAsync("GachaSelectFateActorMain", function(w)
      _ENV["$"](w)["$$SetFateActors"](chooseRes)
      _ENV["$"](w)["$$SetChooseCallback"](function(actorId)
        WU.RecycleWindow(this)
        if m_chooseCallback then
          m_chooseCallback(actorId)
          m_chooseCallback = nil
        end
      end)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_MustFillTen"))
  end
end

function SetChooseCallback(callback)
  m_chooseCallback = callback
end

function SetBackWindowCallback(callback)
  m_backWindowCallback = callback
end

function BackWindow()
  if m_backWindowCallback then
    m_backWindowCallback()
    m_backWindowCallback = nil
  end
end
