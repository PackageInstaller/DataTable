-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_tipscondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTipsCondition = (BeanManager.GetTableByName)("message.ctipscondition")
local CSceneInfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local BM_TipsCondition = class("BM_TipsCondition")
BM_TipsCondition.Ctor = function(self)
  -- function num : 0_0
end

BM_TipsCondition.ConditionSatisfacted = function(self, ctipsconditionId, curSceneLoadingId)
  -- function num : 0_1 , upvalues : CTipsCondition, _ENV
  local tmpRes = CTipsCondition:GetRecorder(ctipsconditionId)
  local con1 = false
  if tmpRes.unlockedArea == 0 then
    con1 = true
  else
    local unlockSceneList = ((NekoData.BehaviorManager).BM_Game):GetUnlockSceneList()
    if (table.keyof)(((NekoData.BehaviorManager).BM_Game):GetUnlockSceneList(), tmpRes.unlockedArea) == nil then
      do
        con1 = unlockSceneList == nil
        local con2 = false
        if tmpRes.goingScenceID == 0 or curSceneLoadingId == 0 then
          con2 = true
        else
          con2 = tmpRes.goingScenceID == curSceneLoadingId
        end
        local con3 = false
        if tmpRes.unlockedCharacter == 0 then
          con3 = true
        else
          con3 = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(tmpRes.unlockedCharacter)
        end
        do return not con1 or not con2 or con3 end
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

return BM_TipsCondition

