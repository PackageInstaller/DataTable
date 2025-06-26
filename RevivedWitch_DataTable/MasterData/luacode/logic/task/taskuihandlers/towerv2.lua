-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/towerv2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Tower) then
    return 
  end
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:Init(sceneController)
    if not ((NekoData.BehaviorManager).BM_Guide):HasCurrentStrongGuide() then
      dialog:OnTypeFourBtnClicked()
    else
      LogInfo("mainlineworlddialog has a strong guide being played.")
    end
  end
end

return TaskUIHandler

