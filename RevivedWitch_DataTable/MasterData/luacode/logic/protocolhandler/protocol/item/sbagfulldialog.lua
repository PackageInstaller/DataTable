-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sbagfulldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  if dialog then
    dialog:OnDrawCardResult()
  end
  local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
  local bagType = protocol.bagtype
  if bagType == BagTypeEnum.EQUIPBAG then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(29, nil, function()
    -- function num : 0_0_0 , upvalues : _ENV
    (DialogManager.CreateSingletonDialog)("equip.bagdialog")
  end
, {}, nil, {})
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

