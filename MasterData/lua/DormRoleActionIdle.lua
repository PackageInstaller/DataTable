-- 休闲
DormRoleActionIdle = oo.class(DormRoleActionBase)

local this = DormRoleActionIdle

function this:Enter()
    local actionTime = Dorm_Action_Time("idle")
    self.endTime = Time.time + actionTime
    self.isEnter = true

    -- 播放休闲动画
    self.dormRole.dormRoleStateMachine:PlayByActionType("idle",actionTime)

    -- 动画过渡
    -- self.curSpeed = self.dormRole.animators[0]:GetFloat(DormAction1.Speed)
    -- self.endSpeed = 0
    -- if(self.curSpeed ~= self.endSpeed) then
    -- 	self.timeLen = Dorm_IdleToWall_Time * math.abs((self.curSpeed - self.endSpeed))
    -- 	self.timer = 0
    -- end
end

function this:Update()
    if (not self.isEnter) then
        return
    end

    -- 动画过渡
    -- if(self.timer) then
    -- 	self.timer = self.timer + Time.deltaTime
    -- 	local speed = self.curSpeed + self.timer / self.timeLen *(self.endSpeed - self.curSpeed)
    -- 	self.dormRole.dormRoleStateMachine:SetFloat(DormAction1.Speed, speed)
    -- 	if(self.timer >= self.timeLen) then
    -- 		self.timer = nil
    -- 	end
    -- end
    if (Time.time > self.endTime) then
        self:OnComplete()
    end
end

-- 休闲结束，准备索点移动
function this:OnComplete()
    self.isEnter = false

    local action, dormAction2 = Dorm_GetActionType("idle", self.dormRole)
    self.dormRole.ChangeAction(action, dormAction2) 
end

return this
