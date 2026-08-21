local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_furnId, m_schemeId, m_clickCallback

function Awake()
  WU.BindButtonEvent(REF.root, function()
    m_clickCallback(REF.root.gameObject)
  end)
end

function ResetState()
  WU.SetActive(REF.TextureIcon, false)
  WU.SetActive(REF.LabelSchemeName, false)
  WU.SetActive(REF.NodeCount, false)
  WU.SetActive(REF.SpriteNewScheme, false)
  WU.SetActive(REF.NodeComfort, false)
  WU.SetActive(REF.SpriteScheme, false)
  WU.SetActive(REF.TextureShopTheme, false)
end

function SetFurniture(furnData)
  ResetState()
  m_furnId = furnData.furnId
  WU.SetActive(REF.TextureIcon, true)
  REF.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/ResItem_" .. m_furnId
  local remainCount = furnData.totalCount - furnData.usedCount
  WU.SetActive(REF.NodeCount, furnData.totalCount > 1)
  REF.LabelCount.UILabel.text = remainCount
  REF.TextureIcon.UITexture.graify = remainCount <= 0
  WU.SetActive(REF.NodeComfort, true)
  REF.LabelComfort.UILabel.text = PB.get("FurnitureConfig", m_furnId).comfort
end

function SetScheme(data)
  ResetState()
  WU.SetActive(REF.LabelSchemeName, true)
  m_schemeId = data.uid
  REF.LabelSchemeName.UILabel.text = data.name
  WU.SetActive(REF.SpriteScheme, true)
end

function SetNewScheme()
  ResetState()
  WU.SetActive(REF.SpriteNewScheme, true)
  REF.LabelSchemeName.UILabel.text = WU.GetString("Dorm_CustomSchemeNew")
end

function SetTheme(themeId)
  ResetState()
  WU.SetActive(REF.TextureShopTheme, true)
  WU.SetActive(REF.LabelSchemeName, true)
  REF.LabelSchemeName.UILabel.text = WU.GetString("FurnitureThemeName_" .. themeId)
  REF.TextureShopTheme.UITexture.mainTexturePath = string.format("Texture/Dormitory/theme_suit_%d_s", themeId)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end
