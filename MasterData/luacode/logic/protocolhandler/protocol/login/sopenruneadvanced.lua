local function p1(protocol)
  local dialog = DialogManager.GetDialog("character.runeadvancement.runeadvancementmaindialog")
  
  if not dialog then
    dialog = DialogManager.CreateSingletonDialog("character.runeadvancement.runeadvancementmaindialog")
    dialog:SetData(protocol)
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSOpenruneAdvanced, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
