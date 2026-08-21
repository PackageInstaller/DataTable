-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/party/scheckpartyinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local data = {}
  data.partyInfo = protocol.partyInfo
  data.allMember = protocol.allMember
  data.partyDeclaration = protocol.partyDeclaration
  ;
  (table.sort)(data.allMember, function(a, b)
    -- function num : 0_0_0
    if a.position < b.position then
      return true
    else
      if a.position == b.position then
        if a.lastTime < b.lastTime then
          return true
        else
          if a.lastTime == b.lastTime then
            if b.userLevel < a.userLevel then
              return true
            else
              if a.userLevel == b.userLevel and b.donate < a.donate then
                return true
              end
            end
          end
        end
      end
    end
    return false
  end
)
  local dialog = (DialogManager.CreateSingletonDialog)("guild.guilddetaildialog")
  if dialog then
    dialog:Init(protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

