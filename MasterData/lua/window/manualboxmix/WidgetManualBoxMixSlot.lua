inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_data

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
end

function OnEnable()
  this:Bind("MixSlotSelected", OnMixSlotSelected)
end

function OnDisable()
  this:Unbind("MixSlotSelected", OnMixSlotSelected)
end

function SetData(data)
  m_data = data
  REF.WidgetIconSlot["$SetData"](m_data.inBox.type, m_data.inBox.id, m_data.inBox.count)
  local name = ""
  local desc = ""
  local count = 0
  if m_data.inBox.type == PB.enum.ResourceType.ResItem then
    local item = this:GetData("fci/item/" .. m_data.inBox.id)
    name = WU.GetString("ItemName_" .. m_data.inBox.id)
    desc = WU.GetItemDesc(m_data.inBox.id)
    if item then
      count = item.count
    end
  elseif m_data.inBox.type == PB.enum.ResourceType.ResMedal then
    name = WU.GetString("MedalName_" .. m_data.inBox.id)
    desc = WU.GetString("MedalStory_" .. m_data.inBox.id)
    count = fif(this:GetData("fci/medal/" .. m_data.inBox.id), 1, 0)
  else
    name = WU.GetString("ResourceTypeName_" .. m_data.inBox.type)
    desc = WU.GetString("ResourceTypeDesc_" .. m_data.inBox.type)
    count = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[m_data.inBox.type] .. "_0")
  end
  REF.LabelName.UILabel.text = name
  REF.LabelDesc.UIHtmlLabel.text = desc
  REF.LabelStatus.UILabel.text = WU.GetString("WindowShopBuy_Possess", count)
  UpdateHighlight(this:GetData("MixSlotSelected"))
end

function OnMixSlotSelected(selection)
  UpdateHighlight(selection)
end

function UpdateHighlight(selection)
  WU.SetActive(REF.SpriteHighlight, m_data ~= nil and m_data == selection)
end

function OnClick()
  this:SetData("MixSlotSelected", m_data)
end
