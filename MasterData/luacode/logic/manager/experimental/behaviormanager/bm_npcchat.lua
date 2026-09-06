local BM_NPCChat = class("BM_NPCChat")
local Effects = require("data.dungeondata.dialog.cdialogeffectconfig")

function BM_NPCChat:CheckNormalOption(jumpid)
  local recorder = BeanManager.GetTableByName("jump.cdialogjumpconfig"):GetRecorder(jumpid)
  local effect = Effects[recorder.jump_value]()
  effect:Run()
end

return BM_NPCChat
