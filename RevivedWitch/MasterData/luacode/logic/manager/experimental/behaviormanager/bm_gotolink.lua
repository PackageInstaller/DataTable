-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_gotolink.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_GotoLink = class("BM_GotoLink")
BM_GotoLink.Ctor = function(self)
  -- function num : 0_0
end

local _handler = {}
_handler.gacha = function(index)
  -- function num : 0_1 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Gacha) then
    return 
  end
  local id = tonumber(index)
  for _,v in pairs(((NekoData.BehaviorManager).BM_Gacha):GetGachaPools()) do
    if v.id == id then
      local dlg = (DialogManager.CreateSingletonDialog)("gacha.gachamaindialog")
      dlg:Init((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base))
      dlg:OnPoolCellClick({id = id})
    end
  end
end

BM_GotoLink.HandleGoto = function(self, link)
  -- function num : 0_2 , upvalues : _ENV, _handler
  local tabs = (string.split)(link, ":")
  if #tabs == 0 then
    return 
  end
  if tabs[1] == "url" then
    local addr = ""
    if tabs[2] == "https" or tabs[2] == "http" then
      addr = (table.concat)(tabs, ":", 2)
    else
      addr = "http://" .. (table.concat)(tabs, "", 2)
    end
    LogWarning("[OpenURL]: ", addr, "config url: ", link)
    ;
    ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)(addr)
  else
    do
      LogWarning("[Goto]", (table.concat)(tabs, "", 2))
      local args = (tabs[2]):split("/")
      ;
      (_handler[(args[1]):lower()])((table.unpack)(args, 2))
    end
  end
end

return BM_GotoLink

