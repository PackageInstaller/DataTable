-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/rolestory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Signboard) then
    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    local dialog = (DialogManager.CreateSingletonDialog)("character.basecharacterlistalldialog")
    if dialog then
      dialog:Init(sceneController)
      dialog:JumpToRoleGift()
      dialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
      if dialog then
        dialog:OnHeartBtnClicked()
      end
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100312)
    end
  end
end

return TaskUIHandler

