local function p1(protocol)
  NekoData.DataManager.DM_Guild:OnSShowPartyDonateProcess(protocol)
  
  local dialog = DialogManager.CreateSingletonDialog("guild.guilddonatedialog")
  dialog:Init()
end

local function p2(protocol, client)
end

return {p1, p2}
