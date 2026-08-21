local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local m_acName, m_inited

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
end

function Init(acName)
  if m_inited then
    warning("GamePlay", "ProgressTaskTabSlot" .. acName .. "has been inited!")
    return
  end
  m_inited = true
  m_acName = acName
  InitView(acName)
  RU.BindRedMark(this, "ProgressTask/" .. acName, function(flag)
    WU.SetActive(REF.SpriteNew, flag)
  end)
end

function InitView(acName)
  local config = PB.get("ProgressTaskConfig", acName)
  local tabLocale = config.tabLocale
  if tabLocale == "" then
    tabLocale = "ProgressTaskTabName_" .. config.name
  end
  REF.LabelButton.UILabel.text = WU.GetString(tabLocale)
  REF.SpriteFront.UISprite.atlasPath = config.tabIconAtlasPath
  REF.SpriteFront.UISprite.spriteName = config.tabIconSpriteName
  REF.SpriteFront.UISprite:SnapWithoutScale()
end

function SetSelected(selected)
  WU.SetActive(REF.SpriteButton, selected)
  local sColor = CS.NGUIMath.HexToColor(810386175)
  local uColor = CS.NGUIMath.HexToColor(4294967295)
  REF.SpriteFront.UISprite.color = fif(selected, sColor, uColor)
  REF.LabelButton.UILabel.color = fif(selected, sColor, uColor)
end

function OnClick()
  this:BroadcastGameEvent("ProgressTask/TabClicked", m_acName)
end
