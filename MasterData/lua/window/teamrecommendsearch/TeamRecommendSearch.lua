local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local m_selectedActors = {}
local m_availableActors = {}
local m_activeData = {}
local m_indice = {}

function SetupWindow()
  CS.EventDelegate.Add(REF.ToggleViewBtn.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      local i = 1
      while i <= #m_indice do
        if AU.HasActorWithID(m_indice[i]) then
          i = i + 1
        else
          m_selectedActors[m_indice[i]] = nil
          table.remove(m_indice, i)
        end
      end
      UpdateSelectedActors()
      AU.HasActorWithID(0)
      InitViewData(this:GetData("ActorIDSet"):keys():sort())
    else
      InitViewData(m_availableActors)
    end
  end)
  WU.TraverseChildren(REF.SelectedActor, function(GO, index)
    local ref = _ENV["$"](GO)
    ref["$$SetClickCallback"](function()
      RemoveSlot(index + 1)
    end)
  end)
  WU.BindButtonEvent(REF.BtnSearch, function()
    if #m_indice == 0 then
      return WU.ShowHintText(WU.GetString("TeamRCMD_SelectedEmpty"))
    end
    WU.AcquireWindowAsync("TeamRecommendResult", function(UI)
      WU.RecycleWindow(this)
      _ENV["$"](UI)["$$SetData"](m_indice)
    end)
  end)
  local actorConfig = PB.all("ActorConfig")
  for _, v in ipairs(actorConfig) do
    if U.IsTimeOpen(v.openTime) then
      table.insert(m_availableActors, v.id)
    end
  end
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_activeData ~= nil and m_activeData[dataIndex]
    end,
    updateSlot = UpdateActorSlot
  })
end

function InitWindow()
  InitViewData()
  UpdateSelectedActors()
end

function SetData(indice)
  m_indice = indice
  for _, v in ipairs(indice) do
    m_selectedActors[v] = REF
  end
  InitViewData()
end

function InitViewData(datas)
  if datas then
    local reset = #datas < #m_activeData
    m_activeData = datas
    LU.Set(REF.WrapContentActor, #m_activeData, reset)
  else
    LU.Set(REF.WrapContentActor, #m_activeData, false)
  end
end

function UpdateActorSlot(ref, actorID)
  ref["$$SetActorCustom"]({id = actorID})
  ref["$$SetClickCallback"](SlotCallBack)
  ref["@actorID"] = actorID
  ref["$$SetSelected"](m_selectedActors[actorID])
  if m_selectedActors[actorID] then
    m_selectedActors[actorID] = ref
  end
end

function SlotCallBack(gameObj)
  local ref = _ENV["$"](gameObj)
  local ID = ref["@actorID"]
  local selected = m_selectedActors[ID]
  if not selected and 6 <= #m_indice then
    return WU.ShowHintText(WU.GetString("TeamRCMD_SelectedFull"))
  end
  ref["$$SetSelected"](not selected)
  if selected then
    m_selectedActors[ID] = nil
    for i, v in ipairs(m_indice) do
      if v == ID then
        table.remove(m_indice, i)
        break
      end
    end
  else
    m_selectedActors[ID] = ref
    table.insert(m_indice, ID)
  end
  UpdateSelectedActors()
end

function RemoveSlot(index)
  local actorID = m_indice[index]
  local ref = m_selectedActors[actorID]
  if ref["@actorID"] == actorID then
    ref["$$SetSelected"](false)
  end
  table.remove(m_indice, index)
  m_selectedActors[actorID] = nil
  UpdateSelectedActors()
end

function UpdateSelectedActors()
  local mainCount = 0
  local subCount = 0
  local i = 0
  for i, v in ipairs(m_indice) do
    local actor = PB.get("ActorConfig", v)
    if actor.kind == PB.enum.ActorType.Main then
      mainCount = mainCount + 1
      if 3 < mainCount then
        RemoveSlot(i)
        return WU.ShowHintText(WU.GetString("TeamRCMD_MainLimit"))
      end
    elseif actor.kind == PB.enum.ActorType.Sub then
      subCount = subCount + 1
      if 3 < subCount then
        RemoveSlot(i)
        return WU.ShowHintText(WU.GetString("TeamRCMD_SubLimit"))
      end
    end
  end
  for _, v in ipairs(m_indice) do
    WU.SetActive(REF.SelectedActor[i]["$"], true)
    REF.SelectedActor[i]["$$SetActorCustom"]({id = v})
    i = i + 1
  end
  for j = i, 5 do
    WU.SetActive(REF.SelectedActor[j]["$"], false)
  end
end
