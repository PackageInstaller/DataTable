local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_spriteName

function SetStar(count, darkCount, leftAlign, darkStyle)
  if leftAlign then
    REF.root.UIGrid.pivot = CS.UIWidget.Pivot.Left
  else
    REF.root.UIGrid.pivot = CS.UIWidget.Pivot.Center
  end
  darkCount = darkCount or 0
  for i = 0, #REF["$"] - 1 do
    local star = REF["$"][i]
    if m_spriteName == nil then
      m_spriteName = star["$UISprite"].spriteName
    end
    if i < count then
      star["$UISprite"].spriteName = m_spriteName
      star["$gameObject"]:SetActive(true)
    elseif i < count + darkCount then
      if darkStyle then
        star["$UISprite"].spriteName = m_spriteName .. "_dark_" .. darkStyle
      else
        star["$UISprite"].spriteName = m_spriteName .. "_dark"
      end
      star["$gameObject"]:SetActive(true)
    else
      star["$gameObject"]:SetActive(false)
    end
  end
  REF["$UIGrid"]:Reposition()
  REF["$UIGrid"].repositionNow = true
end

function PlayTween(forward)
  if REF["$UIPlayTween"] then
    REF["$UIPlayTween"].Play(forward)
  end
end
