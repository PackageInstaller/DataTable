local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_data

function Start()
end

function SetData(data)
  m_data = data
  for i = 1, 4 do
    local buff = REF[string.format("SpriteBuff%d", i)]
    local buffData = data[i]
    if buffData then
      local buffInfo = PB.get("MazeBuff", buffData.buffId)
      if buffInfo then
        buff.gameObject:SetActive(true)
        buff.UISprite.spriteName = buffInfo.buffIcon
        WU.BindButtonEvent(buff, function()
          OnClickBuff(m_data[i])
        end)
      else
        buff.gameObject:SetActive(false)
        warning("Debug", "MazeBuff xlsx no buffId:" .. buffData.buffId)
      end
    else
      buff.gameObject:SetActive(false)
    end
  end
end

function OnClickBuff(buffData)
  WU.AcquireWindowAsync("WidgetMazeBuffList", function(ui)
    _ENV["$"](ui)["$$SetData"](buffData.buffId)
  end)
end
