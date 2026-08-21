local PB = require("Common/PbHelper")
local TU = require("Common/TextUtil")
local SE = require("Common/SkillEffect")
local FH = {}

function FH.getBuffDescribe(data, val, rate, level)
  for i = 1, #data.paramInt do
    data["P" .. tostring(i - 1)] = data.paramInt[i]
  end
  for i = 1, #data.paramInt do
    data["PX" .. tostring(i - 1)] = math.floor(data.paramInt[i] * rate + 0.5)
  end
  for i = 1, #data.paramStr do
    data["S" .. tostring(i - 1)] = data.paramStr[i]
  end
  data.VAL = val
  local extra = SE.GetBuffDataExtraInfo(data, level)
  data["type" .. data.type] = extra
  return TU.render(data.describe, data)
end

function FH.SetEnergySprite(uisprite, count)
  local UISpriteData = uisprite:GetAtlasSprite()
  local widthSingleSprite = 0
  if UISpriteData then
    widthSingleSprite = UISpriteData.width
  end
  local widthPerCell = uisprite.intervalX + widthSingleSprite
  local widthSprite = widthPerCell * count - uisprite.intervalX
  uisprite.width = widthSprite
end

return FH
