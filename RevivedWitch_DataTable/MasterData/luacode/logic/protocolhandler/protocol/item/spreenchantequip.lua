-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/spreenchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):SetCanPreEnchantEquip(protocol.leftEnchant > 0)
  if protocol.leftEnchant < 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100266)
  else
    ((NekoData.DataManager).DM_BagInfo):OnSPreEnchantEquip(protocol)
    local equipFMResultDialog = (DialogManager.CreateSingletonDialog)("equipforge.equipfmresultdialog")
    equipFMResultDialog:Refresh(protocol)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_PreEnchantEquip, nil, protocol)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

