-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/offlinepvp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).OffLinePvp) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100495)
    return 
  end
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local mlwDialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
  if mlwDialog then
    mlwDialog:Init(sceneController)
    if not ((NekoData.BehaviorManager).BM_Guide):HasCurrentStrongGuide() then
      mlwDialog:OnTypeFourBtnClicked()
      local fantasyProtocol = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictopenpanel")
      if fantasyProtocol then
        fantasyProtocol:Send()
      end
    else
      do
        LogInfo("mainlineworlddialog has a strong guide being played.")
      end
    end
  end
end

return TaskUIHandler

