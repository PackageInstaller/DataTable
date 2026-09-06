local TaskUIHandler = {}

function TaskUIHandler:Handle()
  DialogManager.GetGroup("Modal"):CloseAllDialog()
  NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard(6)
  local csend = LuaNetManager.CreateProtocol("protocol.yard.copenyard")
  csend:Send()
end

return TaskUIHandler
