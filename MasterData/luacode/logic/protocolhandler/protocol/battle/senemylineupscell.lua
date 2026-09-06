local function p1(protocol)
  NekoData.DataManager.DM_Battle:SetArenaEnemysName(protocol.lineupsInfo)
  
  local dialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvpmaindialog")
  if dialog then
    dialog:Init(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
