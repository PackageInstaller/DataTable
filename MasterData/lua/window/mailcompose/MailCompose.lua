local U = require("Common/Util")
local REF = require("Internal/injector_patch")(this)
local WU, DB = require("Common/WindowUtil")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
  WU.BindButtonEvent(REF.ButtonSend, OnSendClick)
end

function OnCancelClick()
  WU.RecycleWindow("MailCompose")
end

function OnSendClick()
  local titleText = U.trim(REF.InputTitle.UIInput.value)
  if titleText == "" then
    WU.ShowHintText(WU.GetString("WindowPartition_AccontEmpty"))
    return
  end
  local contentText = U.trim(REF.InputContent.UIInput.value)
  if contentText == "" then
    WU.ShowHintText(WU.GetString("WindowPartition_AccontEmpty"))
    return
  end
  local params = {title = titleText, content = contentText}
  this:GameRequest("/game/player/{openId}/mails/"):Post(params, OnPostMailResponse)
end

function OnPostMailResponse(response)
  this:BroadcastGameEvent("mailChanged")
end
