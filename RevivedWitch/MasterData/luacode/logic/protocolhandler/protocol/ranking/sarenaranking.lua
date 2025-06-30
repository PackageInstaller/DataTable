-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/ranking/sarenaranking.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local offlinepvpmaindialog = (DialogManager.GetDialog)("mainline.offlinepvp.offlinepvpmaindialog")
  do
    if offlinepvpmaindialog then
      local offlinepvprankingdialog = (DialogManager.CreateSingletonDialog)("mainline.offlinepvp.offlinepvprankingdialog")
      if offlinepvprankingdialog then
        offlinepvprankingdialog:Init(protocol)
      end
    end
    local seasonpvpmaindialog = (DialogManager.GetDialog)("mainline.seasonpvp.seasonpvpmaindialog")
    if seasonpvpmaindialog then
      local seasonpvprankingdialog = (DialogManager.CreateSingletonDialog)("mainline.seasonpvp.seasonpvprankingdialog")
      if seasonpvprankingdialog then
        seasonpvprankingdialog:Init(protocol)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

