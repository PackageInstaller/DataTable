local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("guild.guildcreatedialog")
  
  dialog:Init(protocol.number)
end

local function p2(protocol, client)
end

return {p1, p2}
