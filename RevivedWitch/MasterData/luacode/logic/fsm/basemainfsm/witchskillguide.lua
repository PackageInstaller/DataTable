-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/witchskillguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CWitchSkillUnlock = (BeanManager.GetTableByName)("role.cwitchskillunlock")
local CSkillMapTable = (BeanManager.GetTableByName)("skill.cskillmap")
local State = {}
local controllera = nil
local _witchSkillUnlockTable = {}
local progress = false
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, _witchSkillUnlockTable, CWitchSkillUnlock, progress, controllera
  LogInfo("BaseMainFSM", "WitchSkillGuide Enter")
  _witchSkillUnlockTable = {}
  for _,id in ipairs(CWitchSkillUnlock:GetAllIds()) do
    _witchSkillUnlockTable[id] = CWitchSkillUnlock:GetRecorder(id)
  end
  ;
  (controller._baseMainFSM):SetBoolean("toFunctionUnlock", true)
  progress = false
  controllera = controller
end

State.Update = function(controller)
  -- function num : 0_1 , upvalues : progress, _ENV, CSkillMapTable, _witchSkillUnlockTable, controllera, State
  if not progress then
    progress = true
    local witchSkillGuideList = ((NekoData.BehaviorManager).BM_Game):GetWitchSkillIdList()
    if witchSkillGuideList and #witchSkillGuideList ~= 0 then
      local map = {}
      local allIds = CSkillMapTable:GetAllIds()
      local len = #allIds
      for i = 1, len do
        local record = CSkillMapTable:GetRecorder(allIds[i])
        if record.roleID == 1 then
          map[record.id] = record
        end
      end
      local record = nil
      for _,r in pairs(_witchSkillUnlockTable) do
        if (map[r.skillMapNodeID]).skillID == witchSkillGuideList[1] then
          record = r
          break
        end
      end
      do
        if record then
          controllera = controller
          ;
          (LuaNotificationCenter.AddObserver)(State, State.OnDialogCloseBtnClick, Common.n_DialogCloseBtnClick, nil)
          do
            if not ((NekoData.BehaviorManager).BM_Game):GetIfFirstWitchSkillGuide() then
              local csend = (LuaNetManager.CreateProtocol)("protocol.user.cfinishwitchskillguide")
              csend.skillItemId = witchSkillGuideList[1]
              csend:Send()
            end
            do
              do
                local dialog = (DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")
                if dialog then
                  dialog:Init(record.guideID)
                  ;
                  (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
                else
                  ;
                  (controller._baseMainFSM):SetNumber("witchSkillGuideId", 0)
                end
                LogErrorFormat("BaseSceneController", "cwitchskillunlock doesnt have record with skill id %s", witchSkillGuideList[1])
                ;
                (controller._baseMainFSM):SetNumber("witchSkillGuideId", 0)
                ;
                (controller._baseMainFSM):SetNumber("witchSkillGuideId", 0)
              end
            end
          end
        end
      end
    end
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "WitchSkillGuide Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnDialogCloseBtnClick = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV, progress, controllera
  if (notification.userInfo)._dialogName == "newbattle.battleteachguidedialog" then
    local witchSkillGuideList = ((NekoData.BehaviorManager).BM_Game):GetWitchSkillIdList()
    if witchSkillGuideList and #witchSkillGuideList ~= 0 then
      local csend = (LuaNetManager.CreateProtocol)("protocol.user.cfinishwitchskillguide")
      csend.skillItemId = witchSkillGuideList[1]
      csend:Send()
      ;
      (table.remove)(witchSkillGuideList, 1)
      progress = false
    else
      do
        ;
        (controllera._baseMainFSM):SetNumber("witchSkillGuideId", 0)
      end
    end
  end
end

return State

