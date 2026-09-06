local CTipsCondition = BeanManager.GetTableByName("message.ctipscondition")
local CSceneInfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local BM_TipsCondition = class("BM_TipsCondition")

function BM_TipsCondition:Ctor()
end

function BM_TipsCondition:ConditionSatisfacted(ctipsconditionId, curSceneLoadingId)
  local tmpRes = CTipsCondition:GetRecorder(ctipsconditionId)
  local con1 = false
  if tmpRes.unlockedArea == 0 then
    con1 = true
  else
    local unlockSceneList = NekoData.BehaviorManager.BM_Game:GetUnlockSceneList()
    if unlockSceneList ~= nil then
      con1 = table.keyof(NekoData.BehaviorManager.BM_Game:GetUnlockSceneList(), tmpRes.unlockedArea) ~= nil
    end
  end
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
    con3 = NekoData.BehaviorManager.BM_AllRoles:GetRoleIsUnlock(tmpRes.unlockedCharacter)
  end
  return con1 and con2 and con3
end

return BM_TipsCondition
