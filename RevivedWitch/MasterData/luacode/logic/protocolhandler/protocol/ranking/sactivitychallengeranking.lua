-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/ranking/sactivitychallengeranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeEnum = {[(DataCommon.Activities).StarMirage] = true, [(DataCommon.Activities).Anniversary] = true, [(DataCommon.Activities).StarMirageCopy] = true}
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : TypeEnum, _ENV
  if TypeEnum[protocol.activity] then
    local dialog = (DialogManager.GetDialog)("activity.starmirage.rankmaindialog")
    if dialog then
      dialog:OnRefreshRankList(protocol)
    end
  else
    do
      if protocol.activity == (DataCommon.Activities).Christmas then
        local dialog = (DialogManager.GetDialog)("activity.christmas.rankmaindialog")
        if dialog then
          dialog:OnRefreshRankList(protocol)
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

