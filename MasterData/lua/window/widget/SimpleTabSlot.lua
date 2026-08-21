local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local m_clickCallback

function Awake()
  WU.BindButtonEvent(REF.root, function()
    if m_clickCallback then
      m_clickCallback(REF.root.gameObject)
    end
  end)
end

function SetLabel(mainText, subText)
  REF.LabelMain.UIHtmlLabel.text = mainText or ""
  REF.LabelSub.UIHtmlLabel.text = subText or ""
end

function SetSelected(selected)
  WU.SetActive(REF.SpriteButton, selected)
  local sColor = CS.NGUIMath.HexToColor(810386175)
  local uColor = CS.NGUIMath.HexToColor(4294967295)
  REF.LabelMain.UIHtmlLabel.color = fif(selected, sColor, uColor)
  REF.LabelSub.UIHtmlLabel.color = fif(selected, sColor, uColor)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end
