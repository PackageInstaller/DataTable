-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/card/supdatecardpools.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local pools = ((NekoData.BehaviorManager).BM_Gacha):GetGachaPools()
  local old = false
  for _,poolInfo in ipairs(pools) do
    if not (protocol.pools)[poolInfo.id] then
      old = true
      break
    end
  end
  do
    ;
    ((NekoData.DataManager).DM_Gacha):OnSUpdateCardPools(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_DrawCard, nil, protocol)
    if old then
      ((NekoData.BehaviorManager).BM_Message):AddConfirmDialog(((NekoData.BehaviorManager).BM_Message):GetString(1302), function()
    -- function num : 0_0_0 , upvalues : _ENV
    (DialogManager.DestroySingletonDialog)("gacha.gacharesultdialog")
    local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
    if dialog then
      dialog:OnRefreshPools()
    end
  end
)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

