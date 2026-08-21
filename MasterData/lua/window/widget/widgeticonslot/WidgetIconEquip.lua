inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_id, m_equip, m_customData
local m_showBottomRight = false
local m_showNew = false

function ResetState()
  m_id = nil
  m_equip = nil
  m_customData = nil
  m_showBottomRight = false
  m_showNew = false
end

function Draw()
  local iconPath = ""
  local spriteNamePos = ""
  local spriteNameBg = ""
  local valid = m_id ~= nil
  WU.SetActive(REF.TextureIcon, valid)
  WU.SetActive(REF.SpriteEquipPos, valid)
  if valid then
    if type(m_id) == "number" and 0 < m_id then
      local equipInfo = PB.get("EquipInfo", m_id)
      if equipInfo then
        iconPath = "Texture/EquipIcon/" .. equipInfo.icon
        spriteNamePos = EU.EquipPosSpriteNameTable[equipInfo.pos + 1]
        spriteNameBg = "icon_bg_" .. equipInfo.quality
      else
        error("EquipInfo", "Cannot find EquipInfo by id: " .. tostring(m_id))
      end
    else
      WU.SetActive(REF.TextureIcon, false)
      WU.SetActive(REF.SpriteEquipPos, false)
      if m_id == -1 then
        spriteNameBg = "icon_bg_1"
      elseif m_id == -2 then
        spriteNameBg = "icon_bg_2"
      elseif m_id == -3 then
        spriteNameBg = "icon_bg_3"
      elseif m_id == "unequiped" then
        spriteNameBg = "icon_bg_blank"
      end
    end
  end
  WU.SetActive(REF.LabelBottomRight, m_equip)
  WU.SetActive(REF.SpriteOverload, false)
  WU.SetActive(REF.EffectRecommend, false)
  WU.SetActive(REF.ShowNew, false)
  WU.SetActive(REF.NodeOwner, false)
  WU.SetActive(REF.ShowLock, false)
  REF.TextureIcon.UITexture.mainTexturePath = iconPath
  REF.SpriteIconBG.UISprite.spriteName = spriteNameBg
  REF.SpriteEquipPos.UISprite.spriteName = spriteNamePos
  if m_equip then
    if REF.LabelBottomRight then
      REF.LabelBottomRight.UILabel.text = WU.GetString("Window_Level", m_equip.level)
    end
    WU.SetActive(REF.SpriteNew, m_equip.isNew)
    WU.SetActive(REF.ShowLock, m_equip.isLock or m_equip.matchIndex ~= 0)
  end
  if m_customData ~= nil then
    WU.SetActive(REF.SpriteOverload, m_customData.overload ~= nil and m_customData.overload)
    WU.SetActive(REF.EffectRecommend, m_customData.recommend ~= nil and m_customData.recommend)
    WU.SetActive(REF.ShowNew, m_customData.showNew or false)
    if m_customData.lock ~= nil then
      WU.SetActive(REF.ShowLock, m_customData.lock)
    end
    if m_customData.unknown then
      REF.TextureIcon.UITexture.alpha = 0.5
      REF.TextureIcon.UITexture.solidColor = true
      REF.SpriteIconBG.UISprite.spriteName = "head_bg"
      WU.SetActive(REF.SpriteDecoration, false)
    else
      REF.TextureIcon.UITexture.alpha = 1
      REF.TextureIcon.UITexture.solidColor = false
      WU.SetActive(REF.SpriteDecoration, true)
    end
    if REF.NodeOwner then
      WU.SetActive(REF.NodeOwner, m_customData.ownerUid and m_customData.ownerUid ~= 0)
      if m_customData.ownerUid and m_customData.ownerUid ~= 0 then
        local owner = this:GetData("fci/actor/" .. m_customData.ownerUid)
        if owner then
          REF.LabelActorLv.UILabel.text = WU.GetString("Window_Level", owner.level)
          local actorConfig = PB.get("ActorConfig", owner.id)
          if actorConfig then
            REF.SpriteActorIcon.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
          else
            error("Equip", "cannot find actorConfig by other actor Id: " .. owner.id)
          end
        end
      end
    end
  end
end

function SetData(id)
  m_id = id
  MarkAsDirty()
end

function SetEquip(equip)
  if equip then
    m_id = equip.id
    m_equip = equip
    MarkAsDirty()
  end
end

function ShowCustom(data)
  m_customData = data
  MarkAsDirty()
end
