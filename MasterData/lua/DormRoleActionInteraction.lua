DormRoleActionInteraction = oo.class(DormRoleActionBase)

local this = DormRoleActionInteraction

function this:Enter(dormColData)
    -- 如果不是步行，默认先进入步行状态
    self.dormRole.dormRoleStateMachine:PlayByActionType("walk")

    self.dormColData = dormColData
    self.endTime = Time.time + self.dormColData:GetActionTime()

    self.isUp = false
    self.isAdjust = nil

    if (self.dormColData) then
        if (self.dormColData:GetColType() == DormGoType.col_area) then
            if (self.dormColData:GetIsTookDown()) then
                self.dormColData:LookAtTarget2()
                self.dormColData:Action()
                -- self.dormColData:AddBubble()
            else
                self.isAdjust = 1
            end
        elseif (self.dormColData:GetColType() == DormGoType.furniture) then
            if (self.dormColData:GetIsTookDown()) then
                self.dormColData:SetToCorrectPos()
                self.dormColData:LookAtTarget()
                self.dormColData:Action()
                -- self.dormColData:AddBubble()
            else
                self.isAdjust = 1
            end
        elseif (self.dormColData:GetColType() == DormGoType.dorm_role) then
            self.dormColData:LookAtTarget2()
            self.dormColData:Action()
            -- self.dormColData:AddBubble()	
        end
    end

    self.isEnter = true
end

function this:Update()
    if (not self.isEnter) then
        return
    end
    if (self.isAdjust) then
        self:MoveToCorrectPoint()
        return
    end
    if (Time.time > self.endTime) then
        if (not self.isUp) then
            self.isUp = true
            local b, restore = self.dormColData:ActionUp()
            if (b) then
                self.endTime = Time.time + restore
                return
            end
        end
        self:OnComplete()
    end
end

-- 移动半格到正确位置
function this:MoveToCorrectPoint()
    if (self.isAdjust == 1 and self.dormColData:MoveToCorrectPos()) then -- 转身,移动
        self.dormColData.lua1.roleAI:Stop(true)
        self.isAdjust = 2
    elseif (self.isAdjust == 2 and self.dormColData:LookAtTargetSlow()) then -- 面向目标	
        self.dormColData:LookAtTargetSlow(true)
        self.dormColData:Action()
        -- self.dormColData:AddBubble()	
        self.endTime = Time.time + self.dormColData:GetActionTime()
        self.isAdjust = nil
    end
end

function this:OnComplete()
    self.isEnter = false

    self.dormRole.AddChilds()

    self.dormRole.SetInteractionID()
    self.dormRole.ChangeAction(DormRoleActionType.walk)
end

function this:Exit()
    self.dormRole.AddChilds()
end

return this
