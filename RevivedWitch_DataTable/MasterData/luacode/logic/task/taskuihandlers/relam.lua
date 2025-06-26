-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/relam.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100199)
    return 
  end
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
  if dialog then
    dialog:Init(sceneController)
    dialog:ItemTipsJump({gainType = (DataCommon.GainTypeEnum).Resource, worldId = nil})
  end
end

return TaskUIHandler

