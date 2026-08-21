local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_attrIndices = {
  1,
  3,
  5,
  14,
  6,
  13
}

function SetMixedAttrs(suitInfoList, totalAttrs)
  local suitCount = #suitInfoList
  for i = 1, 4 do
    local suitRef = REF.root[i - 1]
    suitRef["$gameObject"]:SetActive(i <= suitCount)
    if i <= suitCount then
      suitRef["$$SetSuitInfo"](suitInfoList[i], true)
    end
  end
  REF.LabelTotalAttrs.UIHtmlLabel.text = RenderTotalAttrs(totalAttrs)
  _ENV["$"](REF.TotalAttr).SpriteBG.UISprite:UpdateAnchors()
  REF["$"].UITable:Reposition()
end

function RenderTotalAttrs(attrs)
  local result = ""
  local attrCount = #m_attrIndices
  for i = 1, attrCount do
    local attrType = m_attrIndices[i]
    local attr = attrs[attrType]
    if i % 2 == 1 then
      result = result .. "<l width=100% valign=center>"
    end
    result = result .. "<c width=25%>" .. WU.GetString("Window_ActorAttrName_" .. attrType) .. "</c>" .. "<c width=16% align=right>" .. U.FormatAttrValue(attr) .. "</c>"
    if i % 2 == 1 then
      result = result .. "<c width=18%></c>"
    end
    if i % 2 == 0 or i == attrCount then
      result = result .. "</l>"
    end
  end
  return result
end
