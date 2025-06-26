-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/schangeskin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, CSkin
  local dialog = (DialogManager.GetDialog)("shop.fashionbuyresultdialog")
  if dialog then
    dialog:Destroy()
  end
  if protocol.skin2Change > 0 then
    ((NekoData.DataManager).DM_AllRoles):OnSChangeSkin(protocol)
    local skinRecord = CSkin:GetRecorder(protocol.skin2Change)
    if skinRecord then
      ((NekoData.BehaviorManager).BM_AllRoles):SetSkinRedDotChecked(skinRecord)
    else
      LogErrorFormat("schangeskin", "recorder with id %s is not exist in cskin", protocol.skin2Change)
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RefreshFashion, nil, protocol)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

