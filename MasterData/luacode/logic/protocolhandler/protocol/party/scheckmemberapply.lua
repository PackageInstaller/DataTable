local function p1(protocol)
  local list = protocol.applyMembers
  
  if list then
    table.sort(list, function(a, b)
      if a.applyTime < b.applyTime then
        return true
      end
      return false
    end)
  end
  if #list == 0 then
    NekoData.DataManager.DM_Guild:ClientCancelApplyRedpoint()
  end
  local dialog = DialogManager.CreateSingletonDialog("guild.guildcheckdialog")
  if dialog then
    dialog:Init(list)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
