local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_suitInfo

function Start()
  for i = 0, #REF.EquipGrid - 1 do
    WU.BindButtonEvent(REF.EquipGrid[i]["$"], OnSlotClick)
  end
end

function SetSuitInfo(suitInfo)
  m_suitInfo = suitInfo
  REF.EquipGrid.UIGrid:Reposition()
  if m_suitInfo then
    for _, pos in pairs(PB.enum.EquipPos) do
      SetEquip(REF.EquipGrid[pos], m_suitInfo.status[pos])
    end
  end
end

function SetEquip(slotRef, data)
  local uiContext
  slotRef["@data"] = data
  if data then
    if type(data) == "number" then
      local equipInfo = PB.get("EquipInfo", data)
      if equipInfo then
        local hasEquip = HasEquipWithId(data)
        uiContext = {
          frame = {
            spriteName = fif(hasEquip, "icon_bg_" .. equipInfo.quality, "head_bg")
          },
          icon = {
            iconName = equipInfo.icon,
            alpha = fif(hasEquip, 1, 0.5),
            solidColor = not hasEquip
          },
          showDot = hasEquip,
          showBadge = hasEquip,
          showMask = hasEquip
        }
      end
    else
      local equipInfo = PB.get("EquipInfo", data.id)
      if equipInfo then
        uiContext = {
          frame = {
            spriteName = "icon_bg_" .. equipInfo.quality
          },
          icon = {
            iconName = equipInfo.icon,
            alpha = 1,
            solidColor = false
          },
          showDot = true,
          showBadge = false,
          showMask = false
        }
      end
    end
  else
    uiContext = {
      frame = {spriteName = "head_bg"},
      icon = {
        iconName = "",
        alpha = 1,
        solidColor = false
      },
      showDot = false,
      showBadge = false,
      showMask = false
    }
  end
  slotRef.TextureIcon.gameObject:SetActive(data)
  slotRef.TextureEmpty.gameObject:SetActive(not data)
  slotRef.SpriteFrame.UISprite.spriteName = uiContext.frame.spriteName
  slotRef.TextureIcon.UITexture.mainTexturePath = "Texture/EquipIcon/" .. uiContext.icon.iconName
  slotRef.TextureIcon.UITexture.alpha = uiContext.icon.alpha
  slotRef.TextureIcon.UITexture.solidColor = uiContext.icon.solidColor
  slotRef.SpriteDot.gameObject:SetActive(uiContext.showDot)
  slotRef.SpriteBadge.gameObject:SetActive(uiContext.showBadge)
  slotRef.SpriteMask.gameObject:SetActive(uiContext.showMask)
end

function HasEquipWithId(equipId)
  local equips = _ENV["!"](CS.DataBindingManager.Instance:GetData("fci/equip/"))
  local _, equip = equips:find(function(k, v)
    return v.id == equipId
  end)
  return equip ~= nil
end

function OnSlotClick(go)
  local data = _ENV["$"](go)["@data"]
  if data then
    if type(data) == "number" then
      if HasEquipWithId(data) then
        local equipInfo = PB.get("EquipInfo", data)
        if equipInfo then
          this:BroadcastGameEvent("EventLocateEquip", equipInfo.pos, data)
        end
      else
        WU.ShowEquipDetailById(data)
      end
    else
      WU.AcquireWindowAsync("ActorEquipCompare", function(window)
        _ENV["$"](window)["$$SetEquip"](data)
      end)
    end
  end
end
