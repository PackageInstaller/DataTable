local CMissionConfig = BeanManager.GetTableByName("mission.cmissionconfig")
local CActiveMissionConfig = BeanManager.GetTableByName("mission.cactivemissionconfig")
local TaskUIHandler = {}

function TaskUIHandler:Handle(id)
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BranchLine) then
    local branchLineList = NekoData.BehaviorManager.BM_Game:GetBranchLineList()
    local worldname
    for _, mId in pairs(CMissionConfig:GetAllIds()) do
      local tempRecoder = CMissionConfig:GetRecorder(mId)
      if tempRecoder.jumpAim == id then
        worldname = tempRecoder.worldname
        break
      end
    end
    for _, mId in pairs(CActiveMissionConfig:GetAllIds()) do
      local tempRecoder = CActiveMissionConfig:GetRecorder(mId)
      if tempRecoder.jumpAim == id then
        worldname = tempRecoder.worldname
        break
      end
    end
    if worldname and branchLineList[worldname] then
      local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
      local mlwDialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if mlwDialog then
        mlwDialog:Init(sceneController)
        if not NekoData.BehaviorManager.BM_Guide:HasCurrentStrongGuide() then
          mlwDialog:OnTypeFiveBtnClicked()
          local blwDialog = DialogManager.CreateSingletonDialog("mainline.branchline.branchlineworldinfodialog")
          if blwDialog then
            blwDialog:Init({chapterId = worldname})
            return true
          else
            DialogManager.DestroySingletonDialog("mainline.mainline.mainlineworlddialog")
          end
        else
          LogInfo("mainlineworlddialog has a strong guide being played.")
        end
      end
      LogError("TaskUIHandler|SideStory", "Failed to create dialog.")
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100257)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100258)
  end
  return false
end

return TaskUIHandler
