DormRoleActionMove = oo.class(DormRoleActionBase)

local this = DormRoleActionMove

function this:Enter()
    self.dormRole.dormRoleStateMachine:PlayByActionType("walk")
    self.dormRole.RandomToMove() -- 随机移动
    self.oldPos = nil  --cao ni ma
    self.isEnter = true
end

function this:Update()
    if (not self.isEnter) then
        return
    end
    if (not self.dormRole.roleAI.ai.isStopped and self.dormRole.roleAI.ai.remainingDistance < DormInteDis) then
        self:OnComplete()
    else
        -- 如果移动时被堵住2s，则完成移动
        if (not self.oldPos) then
            self.oldPos = self.dormRole.transform.position
            self.stopTimer = Time.time + 1
        end
        if (Time.time > self.stopTimer) then
            local newPos = self.dormRole.transform.position
            local dis = UnityEngine.Vector3.Distance(self.oldPos, newPos)
            if (dis < 0.1) then
                self:OnComplete()
            else
                self.stopTimer = Time.time + 1
                self.oldPos = newPos
            end
        end
    end
end

-- 移动结束，进入休闲
function this:OnComplete()
    self.isEnter = false
    if (self.dormRole.IsRobot()) then
        local action, dormAction2 = Dorm_GetActionType("walk", self.dormRole)
        self.dormRole.ChangeAction(action, dormAction2)
    else
        self.dormRole.dormRoleStateMachine:ChangeSpeedToValue(0, function()
            self:ChangeSpeedToValueCB()
        end)
    end
end

function this:ChangeSpeedToValueCB()
    local action, dormAction2 = Dorm_GetActionType("walk", self.dormRole)
    self.dormRole.ChangeAction(action, dormAction2)
end

function this:Exit()
    self.isEnter = false
end

-- 出现穿透和擦边
return this
