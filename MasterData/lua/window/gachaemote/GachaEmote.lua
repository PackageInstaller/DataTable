local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local PU = require("Common/PlatformUtil")
local S = require("Common/Singleton")
local m_gachaId, m_gachaInfo, m_callback, m_onOk, m_cenimatic, m_lastTickSec, m_willFreeTime, m_limitAct, m_hasOrangeActor, m_hasReviewed

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonPlay, function(go)
    local data = this:GetData("fci/gacha-plot-emote/")
    if data then
      local url = data.actorVideoUrl
      WU.OpenUrl(url)
    end
  end)
  WU.BindButtonEvent(REF.SpriteClose, function(go)
    WU.RecycleWindow(this)
  end)
end
