local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_equips, m_lastBindUid, m_lastBindEquipUids

function SetData(actorInfo)
  if actorInfo ~= nil and actorInfo.uid ~= 0 then
    m_equips = {}
    if actorInfo.bodyEquips == nil then
      if m_lastBindUid ~= nil then
        this:Unbind("fci/actor/" .. m_lastBindUid, SetEquipByRemoteActor)
      end
      m_lastBindUid = actorInfo.uid
      this:Bind("fci/actor/" .. actorInfo.uid, SetEquipByRemoteActor)
    else
      SetEquipByRemoteActor(actorInfo)
    end
  end
end

function SetEquipByRemoteActor(actor)
  if actor ~= nil then
    if m_lastBindEquipUids ~= nil then
      for i = 1, #m_lastBindEquipUids do
        this:Unbind("fci/equip/" .. m_lastBindEquipUids[i], SetDetailSlot)
      end
    end
    m_lastBindEquipUids = {}
    for _, pos in pairs(PB.enum.EquipPos) do
      local equipUid = actor.bodyEquips[tostring(pos)]
      local ref = REF["$"][pos]
      if equipUid ~= nil then
        table.insert(m_lastBindEquipUids, equipUid)
        this:Bind("fci/equip/" .. equipUid, SetDetailSlot)
      else
        SetEquip(ref)
      end
    end
  end
end

function SetDetailSlot(equip)
  if equip ~= nil then
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo ~= nil then
      local ref = REF["$"][equipInfo.pos]
      SetEquip(ref, equip)
    end
  end
end

function SetEquip(ref, equip)
  local isShow = equip ~= nil
  ref.TextureIcon.gameObject:SetActive(isShow)
  ref.SpriteDecoration.gameObject:SetActive(isShow)
  ref.SpriteEquipPos.gameObject:SetActive(isShow)
  ref.LabelBottomRight.gameObject:SetActive(isShow)
  if isShow then
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo then
      ref.SpriteIconBG.UISprite.spriteName = "icon_bg_" .. equipInfo.quality
      ref.TextureIcon.UITexture.mainTexturePath = "Texture/EquipIcon/" .. equipInfo.icon
      ref.SpriteEquipPos.UISprite.spriteName = EU.EquipPosSpriteNameTable[equipInfo.pos + 1]
    end
    ref.LabelBottomRight.UILabel.text = WU.GetString("Window_Level", equip.level)
  else
    ref.SpriteIconBG.UISprite.spriteName = "icon_bg_blank"
  end
end
