-- 趴地lie（纯趴/舔爪licking/翻身turn_over/退出趴地）
DormRoleActionLie = oo.class(DormRoleActionBase)

local this = DormRoleActionLie

function this:Enter()
    self.isEnter = true

    self.dormRole.dormRoleStateMachine:ActionBool("lie", true)
    self.petTimer = Time.time + 6
end

function this:Update()
    if (not self.isEnter) then
        return
    end
    if (self.petTimer and Time.time > self.petTimer) then
        self.petTimer = nil
        self:PetLies()
    end
end

-- 宠物循环自选动作
function this:PetLies()
    if (self.petExit) then
        self.petExit = nil
        self:OnComplete()
        return
    end
    local num = CSAPI.RandomInt(1, 4)
    if (num == 1) then
        self.petTimer = Time.time + 4
    elseif (num == 2) then
        self.dormRole.dormRoleStateMachine:SetTrigger("licking")
        self.petTimer = Time.time + 5
    elseif (num == 3) then
        self.dormRole.dormRoleStateMachine:SetTrigger("turn_over")
        self.petTimer = Time.time + 4
    else
        self.dormRole.dormRoleStateMachine:ActionBool("lie", false)
        self.petTimer = Time.time + 1.2
        self.petExit = true
    end
end

-- 休闲结束，准备索点移动
function this:OnComplete()
    self.isEnter = false
    local action, dormAction2 = Dorm_GetActionType("lie", self.dormRole)
    self.dormRole.ChangeAction(action, dormAction2)
end

return this
