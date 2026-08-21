inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local m_data, m_callback

function Start()
  REF.WidgetActorCard["$SetClickCallback"](function()
    if m_callback then
      m_callback(m_data)
    end
  end)
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetData(data)
  m_data = data
  local actor = {}
  actor.id = m_data.inBox.id
  actor.level = 1
  actor.quality, actor.star = AU.CheckActorStarRandom(actor.id, m_data.inBox.param)
  actor.bodyEquips = {}
  REF.WidgetActorCard["$SetActorOnce"](actor)
  REF.WidgetActorCard["$ShowCustom"]({
    showName = true,
    showStar = true,
    showLevel = true
  })
  WU.SetActive(REF.LabelNew, m_data.isNew)
  WU.SetActive(REF.LabelPossess, not m_data.isNew)
end
