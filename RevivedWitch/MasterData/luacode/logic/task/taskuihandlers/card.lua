-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/card.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Gacha) then
    return 
  end
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local csend = (LuaNetManager.CreateProtocol)("protocol.card.crefreshcardui")
  csend:Send()
  local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachamaindialog")
  if dialog then
    dialog:Init(sceneController)
  end
end

return TaskUIHandler

