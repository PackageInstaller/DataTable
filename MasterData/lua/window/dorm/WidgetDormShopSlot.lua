local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_clickCallback

function Awake()
  WU.BindButtonEvent(REF.root, function()
    if m_clickCallback then
      m_clickCallback(REF.root.gameObject)
    end
  end)
end

function SetFurniture(goodInfo, soldOut, showDetail)
  local good = goodInfo[1].goods
  local furnId = good.id
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResItem, furnId, good.count)
  for i = 1, 2 do
    local good = goodInfo[i]
    WU.SetActive(REF["LabelCost" .. i], good ~= nil)
    if good then
      local cost = good.cost[1]
      REF["LabelCost" .. i].ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  end
  REF.GroupCost.UIGrid:Reposition()
  REF.WidgetIconSlot["$SetTips"](fif(soldOut, "soldOut", nil))
  WU.SetActive(REF.SpriteSlotBGMask, soldOut)
  WU.SetActive(REF.NodeDetail, showDetail)
  REF.WidgetIconSlot.transform.localPosition = {
    x = 0,
    y = fif(showDetail, 100, 0),
    z = 0
  }
  if showDetail then
    REF.LabelComfort.UILabel.text = PB.get("FurnitureConfig", furnId).comfort
    REF.LabelName.UILabel.text = WU.GetString("FurnitureName_" .. furnId)
  end
end

function SetTheme(themeId, manifests, soldOut, showDetail)
  for i = 1, 2 do
    local cost = manifests[i] and manifests[i].cost
    WU.SetActive(REF["LabelCost" .. i], cost ~= nil)
    if cost then
      REF["LabelCost" .. i].ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
    end
  end
  REF.GroupCost.UIGrid:Reposition()
  WU.SetActive(REF.SpriteSoldOut, soldOut)
  WU.SetActive(REF.SpriteSlotBGMask, soldOut)
  WU.SetActive(REF.NodeDetail, showDetail)
  REF.TextureTheme.transform.localPosition = {
    x = 0,
    y = fif(showDetail, 100, 0),
    z = 0
  }
  REF.TextureTheme.UITexture.mainTexturePath = "Texture/Dormitory/theme_suit_" .. themeId
  if showDetail then
    REF.LabelName.UILabel.text = WU.GetString("FurnitureThemeName_" .. themeId)
    REF.LabelDesc.UILabel.text = WU.GetString("FurnitureThemeDesc_" .. themeId)
    local comfort = 0
    local furnConfigs = PB.all("FurnitureConfig")
    for i = 1, #furnConfigs do
      local config = furnConfigs[i]
      if config.theme == themeId then
        comfort = comfort + config.comfort
      end
    end
    REF.LabelComfort.UILabel.text = comfort
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end
