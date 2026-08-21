-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/scheckchallengerecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local BattleType = (LuaNetManager.CreateBean)("protocol.activity.challengerecord")
  if protocol.battleType == BattleType.SEASON then
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadrecorddialog")
    if dialog then
      dialog:SetData(protocol)
    end
  else
    do
      local dialog = (DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadbossrecorddialog")
      if dialog then
        dialog:SetData(protocol)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

