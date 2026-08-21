local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activityManager = S:Get("ActivityManager")
local m_data

function Awake()
  WU.BindButtonEvent(REF.root, GotoCollectionsActor)
end

function SetData(data)
  m_data = data
  REF.WidgetIconSlot["$SetData"](m_data.type, m_data.id, m_data.count)
  REF.LabelName.UILabel.text = WU.GetString("ItemName_" .. m_data.id)
  REF.LabelOwe.UIHtmlLabel.text = fif(m_data.owe, WU.GetString("Window_AlreadyOweActor"), WU.GetString("Window_NotOweActor"))
  REF.LabelCultivation.gameObject:SetActive(m_data.cultivation ~= 0)
  REF.LabelCultivation.UILabel.text = WU.GetString("Window_ActorCultivationDegree", m_data.cultivation)
end

function GotoCollectionsActor()
  NU.GetCollectionsActor(function(actors)
    local actor = {}
    local index, actor = table.find(actors, function(k, v)
      return v.id == m_data.actorId
    end)
    if actor then
      WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
        _ENV["$"](w)["$$SetActor"](actor)
      end)
    else
      WU.AcquireWindowAsync("CollectionsActor")
    end
  end)
end
