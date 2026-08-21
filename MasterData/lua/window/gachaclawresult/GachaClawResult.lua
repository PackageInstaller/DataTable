local WU, DB, REF = require("Common/WindowUtil")(this)
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local m_drop
local m_gachaTicketId = 60001

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonResDrop, OnDropClick)
  REF.EquipDrop["$SetClickCallback"](OnDropClick)
  REF.TicketDrop["$SetClickCallback"](OnDropClick)
end

function ManageReschange(resChange)
  for i = 1, #resChange do
    if resChange[i].baseRes then
      if resChange[i].baseRes.countDelta > 0 then
        m_drop = resChange[i]
        break
      end
    elseif resChange[i].equip then
      m_drop = resChange[i]
      break
    end
  end
  SetContent()
  REF["$Animator"]:Play("Open", -1, 0)
end

function SetResultLabel(str)
  REF.LabelScore.UILabel.text = str
end

function SetContent()
  REF.NodeResDrop.gameObject:SetActive(m_drop.baseRes ~= nil and m_drop.baseRes.id ~= m_gachaTicketId)
  REF.NodeEquipDrop.gameObject:SetActive(m_drop.baseRes == nil)
  REF.NodeTicketDrop.gameObject:SetActive(m_drop.baseRes ~= nil and m_drop.baseRes.id == m_gachaTicketId)
  if m_drop.baseRes then
    if m_drop.baseRes.id == m_gachaTicketId then
      REF.TicketDrop["$SetData"](m_drop.baseRes.type, m_drop.baseRes.id)
    else
      REF.TextureResADD.UITexture.mainTexturePath = "Texture/AutumnActivity/ResItem_" .. m_drop.baseRes.id
      REF.TextureRes.UITexture.mainTexturePath = "Texture/AutumnActivity/ResItem_" .. m_drop.baseRes.id
    end
    REF.LabelGet.UILabel.text = WU.GetString("ItemName_" .. m_drop.baseRes.id)
  elseif m_drop.equip then
    REF.EquipDrop["$SetEquip"](m_drop.equip)
    REF.LabelGet.UILabel.text = WU.GetString("EquipName_" .. m_drop.equip.id)
  end
end

function OnDropClick()
  if m_drop.baseRes then
    WU.ShowResourceDetail(m_drop.baseRes.type, m_drop.baseRes.id)
  elseif m_drop.equip then
    WU.ShowEquipDetailByUid(m_drop.equip.uid, {
      enhance = true,
      equipped = true,
      share = false
    })
  end
end
