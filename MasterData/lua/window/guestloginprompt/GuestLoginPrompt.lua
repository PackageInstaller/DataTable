local WU, DB, REF = require("Common/WindowUtil")(this)
local Msdk = CS.Msdk

function SetupWindow()
  WU.BindButtonEvent(REF.GuestLogin, OnGuestLogin)
  WU.BindButtonEvent(REF.WXLogin, OnWXLogin)
  WU.BindButtonEvent(REF.QQLogin, OnQQLogin)
  CheckButton()
end

function CheckButton()
  local switch = this:GetData("AccountSwitch")
  if not switch.qqLoginSwitch then
    REF.QQLogin.gameObject:SetActive(false)
  end
  if not switch.wxLoginSwitch then
    REF.WXLogin.gameObject:SetActive(false)
  end
end

function MsdkLogin(platform)
  _ENV["$"](WU.FindWindow("Login"))["$$MsdkLogin"](platform)
  WU.RecycleWindow(this)
end

function OnGuestLogin()
  MsdkLogin(Msdk.ePlatform.ePlatform_Guest)
end

function OnWXLogin()
  MsdkLogin(Msdk.ePlatform.ePlatform_Weixin)
end

function OnQQLogin()
  MsdkLogin(Msdk.ePlatform.ePlatform_QQ)
end
