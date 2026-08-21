local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function Awake()
  WU.BindButtonEvent(REF.ButtonExchange, OnGiftExchange)
end

function OnEnable()
  REF.PresentCodeInput.UIInput.value = ""
end

function OnGiftExchange()
  local url = PB.all("MsdkUrl")[1].GiftExchange
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end
