local WU, DB, REF = require("Common/WindowUtil")(this)

function SetupWindow()
  REF.NodeMask["$SetCallback"](OnClose)
end

function OnClose()
  WU.RecycleWindow(this)
end
