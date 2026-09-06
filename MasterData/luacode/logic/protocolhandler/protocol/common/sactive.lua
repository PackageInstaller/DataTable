local function p1(protocol)
  if protocol.result == 1 then
    DialogManager.DestroySingletonDialog("login.logincodedialog")
  elseif protocol.result == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100037)
  elseif protocol.result == -1 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100036)
  end
end

local function p2(protocol, client)
  client:OnSLogin(protocol)
end

return {p1, p2}
