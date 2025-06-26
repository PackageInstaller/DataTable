-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/sidestory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMissionConfig = (BeanManager.GetTableByName)("mission.cmissionconfig")
local CActiveMissionConfig = (BeanManager.GetTableByName)("mission.cactivemissionconfig")
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self, id)
  -- function num : 0_0 , upvalues : _ENV, CMissionConfig, CActiveMissionConfig
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BranchLine) then
    local branchLineList = (((NekoData.BehaviorManager).BM_Game):GetBranchLineList())
    -- DECOMPILER ERROR at PC15: Overwrote pending register: R3 in 'AssignReg'

    local worldname = .end
    for _,mId in pairs(CMissionConfig:GetAllIds()) do
      local tempRecoder = CMissionConfig:GetRecorder(mId)
      if tempRecoder.jumpAim == id then
        worldname = tempRecoder.worldname
        break
      end
    end
    do
      for _,mId in pairs(CActiveMissionConfig:GetAllIds()) do
        local tempRecoder = CActiveMissionConfig:GetRecorder(mId)
        if tempRecoder.jumpAim == id then
          worldname = tempRecoder.worldname
          break
        end
      end
      do
        if worldname and branchLineList[worldname] then
          local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
          local mlwDialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
          if mlwDialog then
            mlwDialog:Init(sceneController)
            if not ((NekoData.BehaviorManager).BM_Guide):HasCurrentStrongGuide() then
              mlwDialog:OnTypeFiveBtnClicked()
              local blwDialog = (DialogManager.CreateSingletonDialog)("mainline.branchline.branchlineworldinfodialog")
              if blwDialog then
                blwDialog:Init({chapterId = worldname})
                return true
              else
                ;
                (DialogManager.DestroySingletonDialog)("mainline.mainline.mainlineworlddialog")
              end
            else
              do
                do
                  do
                    LogInfo("mainlineworlddialog has a strong guide being played.")
                    LogError("TaskUIHandler|SideStory", "Failed to create dialog.")
                    ;
                    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100257)
                    ;
                    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100258)
                    return false
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return TaskUIHandler

