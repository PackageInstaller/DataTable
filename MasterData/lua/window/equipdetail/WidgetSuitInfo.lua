local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local m_suitInfo, m_showStatus

function Start()
  WU.BindButtonEvent(REF.SpriteBG, OnSuitClick)
end

function SetSuitInfo(suitInfo, showStatus)
  m_suitInfo = suitInfo
  m_showStatus = showStatus
  if m_suitInfo then
    REF.LabelSuitName.UIHtmlLabel.text = WU.GetString("Window_SuitName_" .. m_suitInfo.id)
    local suitAttrListHtml = ""
    for i = 1, #m_suitInfo.attrList do
      local suitAttr = m_suitInfo.attrList[i]
      local countHtml = WU.GetString("Window_SuitNum", suitAttr.suitCount)
      local suitHtml = AU.GetSpecialEffectDesc(suitAttr.id, suitAttr.effect)
      if not suitAttr.activated then
        countHtml = HU.ApplyFontColor(countHtml, U.AttrColorTable.Disabled)
        suitHtml = HU.ApplyFontColor(suitHtml, U.AttrColorTable.Disabled)
      end
      if 1 < i then
        suitAttrListHtml = suitAttrListHtml .. "<br/>"
      end
      suitAttrListHtml = suitAttrListHtml .. countHtml .. "<indent>" .. suitHtml .. "</indent>"
    end
    REF.LabelSuitAttrs.UIHtmlLabel.text = suitAttrListHtml
    REF.LabelSuitAttrs.UIHtmlLabel:MakePixelPerfect()
    if REF.GridSuits then
      local equipIds = {}
      local resEquipIds = PB.get("EquipSuitAttr", m_suitInfo.id).equipId
      for i = 1, #resEquipIds do
        equipIds[PB.get("EquipInfo", resEquipIds[i]).pos + 1] = resEquipIds[i]
      end
      for i = 1, 4 do
        local equipId = equipIds[i]
        REF.GridSuits[i - 1]["$$SetData"](PB.enum.ResourceType.ResEquip, equipId, 1)
        REF.GridSuits[i - 1]["$$SetClickCallback"](nil)
        if equipId == nil then
          REF.GridSuits[i - 1]["$$SetEmpty"](2)
        end
      end
    end
    REF.SpriteBG.UISprite:UpdateAnchors()
    if REF.PosGrid then
      REF.PosGrid.gameObject:SetActive(showStatus and m_suitInfo.status)
    end
    if showStatus and m_suitInfo.status then
      for _, pos in pairs(PB.enum.EquipPos) do
        local data = m_suitInfo.status[pos]
        local slotRef = REF.PosGrid[pos]
        if data then
          slotRef["$UISprite"].spriteName = EU.EquipPosSpriteNameTable[pos + 1]
          slotRef["$UISprite"].alpha = fif(type(data) == "number", 0.5, 1)
        else
          slotRef["$UISprite"].spriteName = "equipment_position_null"
          slotRef["$UISprite"].alpha = 0.5
        end
      end
    end
  end
end

function OnSuitClick()
  if m_suitInfo and m_showStatus then
    this:BroadcastGameEvent("EventSuitClick", m_suitInfo, REF["$transform"].position)
  end
end
