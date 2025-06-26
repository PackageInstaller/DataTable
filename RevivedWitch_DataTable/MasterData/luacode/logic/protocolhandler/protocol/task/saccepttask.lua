-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/task/saccepttask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Task):OnSAcceptTask(protocol)
  local task = ((NekoData.BehaviorManager).BM_Task):GetTask((protocol.taskinfo).taskid)
  local id = task:GetAcceptMsgID()
  if task:GetStatus() ~= 3 then
    ((NekoData.BehaviorManager).BM_Message):SendTopMessage(id, {task:GetName()}, not id)
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
    if controller and controller._hasTriggerGuide then
      controller._hasTriggerGuide = false
      controller:StartLevelUpGuide()
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

