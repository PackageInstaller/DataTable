local function p1(protocol)
  NekoData.DataManager.DM_Team:OnSChooseSupportRole(protocol)
  
  local teamEditPreWarDialog = DialogManager.GetDialog("teamedit.teameditprewardialog")
  if teamEditPreWarDialog then
    teamEditPreWarDialog:RefreshSupportRoleInfo()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
