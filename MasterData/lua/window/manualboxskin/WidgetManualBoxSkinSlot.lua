inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_data

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
end

function OnEnable()
  this:Bind("SkinSlotSelected", OnSkinSlotSelected)
end

function OnDisable()
  this:Unbind("SkinSlotSelected", OnSkinSlotSelected)
end

function SetData(data)
  m_data = data
  REF.WidgetIconSkin["$ResetState"]()
  REF.WidgetIconSkin["$SetData"](m_data.inBox.id)
  REF.LabelName.UILabel.text = WU.GetString("ActorSkinName_" .. m_data.inBox.id)
  WU.SetActive(REF.SpriteNew, m_data.isNew)
  WU.SetActive(REF.LabelPossess, not m_data.isNew)
  WU.SetActive(REF.LabelNoActor, not m_data.hasActor)
  UpdateHighlight(this:GetData("SkinSlotSelected"))
end

function OnSkinSlotSelected(selection)
  UpdateHighlight(selection)
end

function UpdateHighlight(selection)
  WU.SetActive(REF.SpriteHighlight, m_data ~= nil and m_data == selection)
end

function OnClick()
  this:SetData("SkinSlotSelected", m_data)
end
