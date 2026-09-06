local function p1(protocol)
  local data = {}
  
  data.partyInfo = protocol.partyInfo
  data.allMember = protocol.allMember
  data.partyDeclaration = protocol.partyDeclaration
  table.sort(data.allMember, function(a, b)
    if a.position < b.position then
      return true
    elseif a.position == b.position then
      if a.lastTime < b.lastTime then
        return true
      elseif a.lastTime == b.lastTime then
        if a.userLevel > b.userLevel then
          return true
        elseif a.userLevel == b.userLevel and a.donate > b.donate then
          return true
        end
      end
    end
    return false
  end)
  local dialog = DialogManager.CreateSingletonDialog("guild.guilddetaildialog")
  if dialog then
    dialog:Init(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
