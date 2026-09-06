local function p1(protocol)
  DialogManager.DestroySingletonDialog("guide.guidenextdialog")
  
  DialogManager.DestroySingletonDialog("guide.guidedialog")
  local dialog = DialogManager.CreateSingletonDialog("gacha.gachamoviedialog")
  dialog:SetGuideTenDraw()
  dialog:SetData(protocol.cards)
  LuaNotificationCenter.PostNotification(Common.n_DrawCard, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
