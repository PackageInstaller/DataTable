-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/card/sbeforedrawcard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((DialogManager.GetGroup)("Guide")):SetObjectActive(false)
  ;
  ((NekoData.DataManager).DM_Gacha):SBeforeDrawCard(protocol.drawTimes)
  ;
  (DialogManager.DestroySingletonDialog)("gacha.gachamoviedialog")
  local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachamoviedialog")
  dialog:SetTenDrawGuide()
  local map = {}
  local roleList = {}
  for i,v in ipairs(protocol.roleList) do
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(v)
    local isNew = 0
    if not role and not map[v] then
      isNew = 1
      map[v] = true
    end
    ;
    (table.insert)(roleList, {cardId = v, isNew = isNew})
  end
  dialog:SetData(roleList)
  ;
  ((NekoData.DataManager).DM_Gacha):OnSBeforeDrawCard(protocol.baodiNum, protocol.share)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_DrawCard, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

