local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("gacha.drawcardlogdialog")
  
  dialog:SetData(protocol.log)
  dialog:OnRefreshPools()
end

local function p2(protocol, client)
end

return {p1, p2}
