local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local HU = require("Common/HtmlUtil")
local m_showPreview, m_actors, m_currentSelection, m_lastSelectedRef

function SetupWindow()
  LU.Bind(REF.WrapContentActors, {
    dataSource = function(dataIndex)
      return m_actors and m_actors[dataIndex]
    end,
    updateSlot = OnUpdateSlot,
    delta = 0.02
  })
  WU.BindButtonEvent(REF.BtnFinish, function()
    local patchTable = {auraActorUid = m_currentSelection}
    local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
    this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      this:SetData("Space/SelectedPlayer", result)
      WU.RecycleWindow(this)
    end)
  end)
end

function InitWindow()
  SortFocusBase.InitWindowActor()
  WU.ToggleRendering(REF.AnchorScrollViewActors, false)
  this:Bind("SortFinished", OnSortFinished)
  this:Bind("Space/SelectedPlayer", function(playerInfo)
    if playerInfo ~= nil then
      m_currentSelection = playerInfo.auraActorUid
      if m_currentSelection ~= nil then
        local actorRaw = this:GetData("fci/actor/" .. m_currentSelection)
        if actorRaw ~= nil then
          REF.NodePreview["$Show"]()
          m_showPreview = true
          SetElem(actorRaw)
        end
      end
    end
  end)
end

function OnSortFinished(data)
  if data ~= nil and data.sortMate == REF["$SortMate"] then
    m_actors = data.list
    ResetWrapContent(true)
  end
end

function UninitWindow()
  if m_showPreview then
    m_showPreview = false
    REF.NodePreview["$Hide"]()
  end
end

function OnElemSelected(widget)
  if m_showPreview ~= true then
    REF.NodePreview["$Show"]()
    m_showPreview = true
  end
  local widgetRef = _ENV["$"](widget)
  local actor = widgetRef["@actor"]
  if m_currentSelection ~= nil then
    GU.GroupUidsReset({m_currentSelection}, PB.enum.ActorGroupType.Aura)
  end
  m_currentSelection = actor.uid
  GU.GroupUidsAdd({m_currentSelection}, PB.enum.ActorGroupType.Aura)
  if m_lastSelectedRef ~= nil then
    m_lastSelectedRef["$$SetHighlighted"](false)
  end
  widgetRef["$$SetHighlighted"](true)
  m_lastSelectedRef = widgetRef
  SetElem(actor)
end

function SetElem(actor)
  local ref = _ENV["$"](REF.WidgetElemSpace)
  local iconSlot = ref.WidgetIconSlot
  iconSlot["$SetActorCustom"]({
    id = actor.id,
    quality = actor.quality
  })
  REF.ActorNameLabel.UILabel.text = WU.GetString("ActorName_" .. actor.id)
  local actorQualityInfo = PB.get("ActorQualityInfo", actor.id, actor.quality)
  REF.DescLabel.UIHtmlLabel.text = AU.RenderAuraOrMedalAttr(actorQualityInfo)
end

function OnUpdateSlot(ref, actor)
  WU.ToggleRendering(ref["$"], actor ~= nil)
  if actor ~= nil then
    ref["$UIPlayTween"]:Play(true)
    ref["@actor"] = actor
    ref["$$SetActorCustom"]({
      id = actor.id,
      quality = actor.quality
    })
    ref["$$SetHighlighted"](actor.uid == m_currentSelection)
    if actor.uid == m_currentSelection then
      m_lastSelectedRef = ref
    end
    ref["$$SetClickCallback"](function(go)
      OnElemSelected(go)
    end)
  end
end

function FilterActors(actors)
  local recorded = {}
  local _, actor = table.find(actors, function(k, v)
    return v.uid == m_currentSelection
  end)
  if actor ~= nil then
    table.insert(recorded, actor.quality .. actor.id)
  end
  for i = #actors, 1, -1 do
    if actors[i].uid ~= m_currentSelection then
      local tag = actors[i].quality .. actors[i].id
      if table.find(recorded, function(k, v)
        return v == tag
      end) then
        table.remove(actors, i)
      else
        table.insert(recorded, tag)
      end
    end
  end
end

function ResetWrapContent(resetPosition)
  if m_actors ~= nil then
    FilterActors(m_actors)
    local idx, actor = table.find(m_actors, function(k, v)
      return v.uid == m_currentSelection
    end)
    if idx ~= nil then
      table.remove(m_actors, idx)
      table.insert(m_actors, 1, actor)
    end
    local col = REF.WidgetSlotRow8.transform.childCount
    local row = math.ceil(#m_actors / col)
    WU.ToggleRendering(REF.AnchorScrollViewActors, true)
    REF.NodeEmpty.gameObject:SetActive(#m_actors == 0)
    LU.Set(REF.WrapContentActors, row, resetPosition)
    REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContentActors.UIWrapContent.itemSize, 0)
    REF.BottomBarSpace.gameObject:SetActive(0 < row)
  end
end

function Focus(on)
  SortFocusBase.FocusActor(on)
end
