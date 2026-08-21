local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_equipUid

function SetEquipPos(pos)
  REF.SpritePos.UISprite.spriteName = EU.EquipPosSpriteNameTable[pos + 1]
end

function BindEquip(equipUid)
  if m_equipUid then
    this:Unbind("fci/equip/" .. m_equipUid, OnEquipChange)
  end
  m_equipUid = equipUid
  if m_equipUid then
    this:Bind("fci/equip/" .. m_equipUid, OnEquipChange)
  end
  REF.NodeContent.gameObject:SetActive(m_equipUid ~= 0)
  REF.NodeEmpty.gameObject:SetActive(m_equipUid == 0)
end

function OnEquipChange(equip)
  if equip then
    REF.WidgetIconEquip["$SetEquip"](equip)
    REF.WidgetIconEquip["$ShowCustom"]({
      ownerUid = equip.actorUid
    })
  end
end
