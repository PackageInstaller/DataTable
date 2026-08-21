local WU, DB, REF = require("Common/WindowUtil")(this)

function SetupWindow()
  WU.BindKeyEvent(REF.Black, OnKey)
end

function OnKey(go, keycode)
  WU.ShowMessageYesNo(WU.GetString("System_ExitGame"), OnExit)
end

function OnExit(message)
  if message == "YES" then
    CS.UnityEngine.Application.Quit()
  end
end
