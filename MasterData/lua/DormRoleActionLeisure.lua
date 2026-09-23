-- 看ipad,打瞌睡,喝茶,打电话
DormRoleActionLeisure = oo.class(DormRoleActionBase)

local this = DormRoleActionLeisure

-- 休闲时间区间
function this:Enter(actionData)
    self.dormAction2 = actionData

    self.dormRole.AddChilds(self.dormAction2)

    local actionTime = Dorm_Action_Time(self.dormAction2)
    self.endTime = Time.time + actionTime
    self.restoreTime = Dorm_Action_RestoreTime(self.dormAction2) or 0
    self.isSet = false

    self.dormRole.dormRoleStateMachine:PlayByActionType(self.dormAction2, actionTime)

    self.isEnter = true
end

function this:Update()
    if (not self.isEnter) then
        return
    end
    if (Time.time > self.endTime) then
        self.restoreTime = self.restoreTime - Time.deltaTime
        if (self.restoreTime > 0) then
            if (not self.isSet) then
                self.isSet = true
                self.dormRole.dormRoleStateMachine:ExitLoop(self.dormAction2)
            end
        else
            self:OnComplete()
        end
    end
end

-- 休闲结束，准备索点移动
function this:OnComplete()
    self.isEnter = false

    self.dormRole.AddChilds()
    local action, dormAction2 = Dorm_GetActionType(self.dormAction2, self.dormRole)
    self.dormRole.ChangeAction(action, dormAction2)
end

function this:Exit()
    self.dormRole.AddChilds()
end

return this
