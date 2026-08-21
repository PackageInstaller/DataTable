inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local TextureIcon = REF.TextureIcon.UITexture
local NodeBG = REF.NodeBG.UIWidget
local SpriteIconBG = REF.SpriteIconBG.UISprite
local LabelBottomRight = REF.LabelBottomRight.UIHtmlLabel
local m_id, m_count, m_item, m_custom, m_expReturn, m_composeRequire

function ResetState()
  WU.SetActive(REF.SpriteNew, false)
  WU.SetActive(REF.SpriteUp, false)
  WU.SetActive(REF.SpriteTimeLimitBg, false)
  WU.SetActive(REF.ShowNew, false)
  NodeBG.alpha = 1
  TextureIcon.graify = false
  TextureIcon.solidColor = false
  TextureIcon.alpha = 1
  WU.SetActive(LabelBottomRight, true)
  m_id = nil
  m_count = nil
  m_item = nil
  m_custom = nil
  m_expReturn = nil
  m_composeRequire = nil
  WU.SetActive(REF.TextureIcon, true)
end

function SetCountFontSize(size)
  LabelBottomRight.fontSize = size
end

function Draw()
  local itemInfo
  if m_id ~= nil then
    local textureName = ""
    local spriteNameBg = ""
    if 0 <= m_id then
      itemInfo = PB.get("ItemInfo", m_id)
      spriteNameBg = "icon_bg_0"
      if m_composeRequire then
        LabelBottomRight.text = m_count .. "/" .. m_composeRequire
      else
        LabelBottomRight.text = m_count
      end
      if itemInfo then
        textureName = itemInfo.icon
        local iconRes = ACU.ReplaceIconRes(m_id)
        if iconRes ~= nil and iconRes ~= "" then
          textureName = iconRes
        end
        if itemInfo.type == PB.enum.ItemType.ActorChip then
          spriteNameBg = "icon_bg_" .. itemInfo.quality
        elseif itemInfo.type == PB.enum.ItemType.ActivityDrop then
          WU.SetActive(REF.SpriteTimeLimitBg, true)
          WU.SetActive(REF.SpriteTimeLimit, true)
          WU.SetActive(REF.SpriteExpReturn, false)
          spriteNameBg = "icon_bg_" .. itemInfo.quality
        else
          spriteNameBg = "icon_bg_" .. itemInfo.quality
        end
      else
        error("ItemInfo", "Cannot find ItemInfo by id: " .. tostring(m_id))
      end
    else
      spriteNameBg = "icon_bg_0"
      if m_id == -1 then
        textureName = "ResunknowItem_0"
        LabelBottomRight.text = WU.GetString("ResourceTypeName_11")
      elseif m_id == -2 then
        textureName = "ResunknowActor_0"
        LabelBottomRight.text = WU.GetString("ResourceTypeName_15")
      elseif m_id == -3 then
        textureName = "ResunkownEquip_0"
        LabelBottomRight.text = WU.GetString("ResourceTypeName_12")
      elseif m_id == -4 then
        textureName = "ResunkownActorChip_0"
        LabelBottomRight.text = WU.GetString("ResourceTypeName_15")
      else
        textureName = "ResunknownAllThings_0"
        LabelBottomRight.text = ""
      end
    end
    TextureIcon.mainTexturePath = "Texture/ItemIcon/" .. textureName
    SpriteIconBG.spriteName = spriteNameBg
  end
  if m_item ~= nil then
    WU.SetActive(REF.SpriteNew, m_item.isNew)
  end
  if m_custom ~= nil then
    TextureIcon.graify = m_custom.gray ~= nil and m_custom.gray
    TextureIcon.solidColor = m_custom.unknown ~= nil and m_custom.unknown
    local alpha = fif(m_custom.unknown ~= nil and m_custom.unknown, 0.5, 1)
    TextureIcon.alpha = alpha
    WU.SetActive(REF.SpriteUp, m_custom.dropUp or false)
    WU.SetActive(REF.ShowNew, m_custom.showNew or false)
    WU.SetActive(REF.SpriteTimeLimitBg, m_custom.showTimeLimit or false)
    WU.SetActive(REF.SpriteTimeLimit, true)
    WU.SetActive(REF.SpriteExpReturn, false)
    if m_custom.hideBG then
      NodeBG.alpha = 0
    end
    WU.SetActive(LabelBottomRight, not m_custom.hideCount)
  end
  if m_expReturn then
    WU.SetActive(REF.SpriteTimeLimitBg, m_expReturn)
    WU.SetActive(REF.SpriteExpReturn, m_expReturn)
    WU.SetActive(REF.SpriteTimeLimit, not m_expReturn)
  end
  if itemInfo and itemInfo.type == PB.enum.ItemType.Buff then
    WU.SetActive(REF.LabelBottomRight, false)
  end
end

function SetData(id, count)
  m_id = id
  m_count = count
  MarkAsDirty()
end

function SetItem(item)
  SetData(item.id, item.count)
  m_item = item
  MarkAsDirty()
end

function ShowCustom(data)
  m_custom = data
  MarkAsDirty()
end

function ShowExpReturn(data)
  m_expReturn = data
  MarkAsDirty()
end

function ShowComposeRequire(data)
  m_composeRequire = data
  MarkAsDirty()
end
