inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_data

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
end

function OnEnable()
  this:Bind("EquipSlotSelected", OnEquipSlotSelected)
end

function OnDisable()
  this:Unbind("EquipSlotSelected", OnEquipSlotSelected)
end

function SetData(data)
  m_data = data
  REF.WidgetIconEquip["$ResetState"]()
  REF.WidgetIconEquip["$SetData"](m_data.inBox.id)
  REF.LabelName.UILabel.text = WU.GetString("EquipName_" .. m_data.inBox.id)
  local suit = EU.GetSuit(m_data.inBox.id)
  local suitName = ""
  if suit then
    suitName = WU.GetString("Window_SuitName_" .. suit.id)
  end
  REF.LabelSuit.UILabel.text = suitName
  WU.SetActive(REF.SpriteNewEquip, m_data.isNew)
  UpdateHighlight(this:GetData("EquipSlotSelected"))
end

function OnEquipSlotSelected(selection)
  UpdateHighlight(selection)
end

function UpdateHighlight(selection)
  WU.SetActive(REF.SpriteHighlight, m_data ~= nil and m_data == selection)
end

function OnClick()
  this:SetData("EquipSlotSelected", m_data)
end
