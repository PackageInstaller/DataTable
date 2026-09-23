-- 送快递 
--[[  
    1、idle状态下飞机带货飞入
    2、收货，无货飞机飞出
    3、拿货闲逛（速度大于0）
    4、拿货呆立，无货飞机飞入
    5、收货
    6、带货飞机飞出，人物做其他行为
]] DormRoleActionHandlingData = oo.class(DormRoleActionBase)

local this = DormRoleActionHandlingData

-- 休闲时间区间
function this:Enter(actionData)
    self.dormAction2 = actionData

    self.animators = {}

    self.index = 1
    self.startPos = UnityEngine.Vector3(0, 6, 4)
    self.endPos = UnityEngine.Vector3(0, 2.5, 0)
    self.outPos = UnityEngine.Vector3(0, 6, -4)
    self.cacheSpeed = 0
    self.endTime = nil
    self.moveing = false

    self.actionTime = Dorm_Action_Time(self.dormAction2)

    -- idle
    self.dormRole.dormRoleStateMachine:PlayByActionType("idle")
    -- 生成飞机
    local cfg = Cfgs.CfgCardRoleAction:GetByID(self.dormAction2)
    local uavPath = cfg.childs[1]
    local boxPath = cfg.childs[2] .. CSAPI.RandomInt(1, 5)
    CSAPI.CreateGOAsync("Dormitory/" .. uavPath, 0, 0, 0, self.dormRole.node, function(go1)
        self.uav = go1
        CSAPI.SetLocalPos(go1, self.startPos.x, self.startPos.y, self.startPos.z)
        --CSAPI.SetAngle(go1, 0, 0, 0)
        -- 货
        CSAPI.CreateGOAsync("Dormitory/" .. boxPath, 0, 0, 0, go1, function(go2)
            local anim2 = ComUtil.GetComsInChildren(go2, "Animator")
            table.insert(self.animators, anim2[0])
            self.box = go2
            self.isEnter = true
        end)
    end)
end

function this:Update()
    if (not self.isEnter) then
        return
    end

    --箱子动画
    if (self.moveing) then
        for i, v in pairs(self.animators) do
            self.animators[i]:SetFloat("Speed", self.dormRole.dormRoleStateMachine:GetSpeed())
        end
    end

    if (self.index == 1) then
        -- 飞机带货飞入
        if (UnityEngine.Vector3.Distance(self.uav.transform.localPosition, self.endPos) > 0.1) then
            local cachePos = UnityEngine.Vector3.Lerp(self.uav.transform.localPosition, self.endPos, Time.deltaTime * 3)
            self.uav.transform.localPosition = cachePos
        else
            self.index = 2
        end
    elseif (self.index == 2) then
        -- 收货
        CSAPI.SetParent(self.box, self.dormRole.node)
        self.dormRole.dormRoleStateMachine:PlayByActionType(self.dormAction2, self.actionTime)
        for i, v in pairs(self.animators) do
            self.animators[i]:SetBool("leisure", true)
            self.animators[i]:Play(self.dormAction2)
        end
        -- 特效
        ResUtil:CreateEffect("Dormitory/Zr_normalEffect_transmission",0, 0, 0.185, self.uav, function(go)
            CSAPI.SetAngle(go, -90, 0, 0)
            downEffect = go
        end)
        self.indexTimer = Time.time + 1
        self.index = 3
    elseif (self.index == 3 and Time.time > self.indexTimer) then
        -- 飞走
        if (UnityEngine.Vector3.Distance(self.uav.transform.localPosition, self.outPos) > 0.1) then
            if (self.cacheSpeed < 7) then
                self.cacheSpeed = self.cacheSpeed + 0.04
            end
            self.uav.transform.localPosition = UnityEngine.Vector3.MoveTowards(self.uav.transform.localPosition,
                self.outPos, Time.deltaTime * self.cacheSpeed)
        else
            CSAPI.SetGOActive(self.uav, false)
            if (downEffect) then
                CSAPI.SetGOActive(downEffect, false)
            end
            self.index = 3.1
        end
    elseif (self.index == 3.1) then
        -- 闲逛
        if (not self.endTime) then
            self.endTime = Time.time + self.actionTime
        end
        if (Time.time < self.endTime) then
            if (not self.moveing) then
                self.dormRole.dormRoleStateMachine:ChangeSpeedToValue(1)
                self.dormRole.RandomToMove() -- 随机移动
                self.moveing = true
            end
            if (self.moveing and not self.dormRole.roleAI.ai.isStopped and self.dormRole.roleAI.ai.remainingDistance <
                DormInteDis) then
                self.moveing = false
            end
        else
            self.dormRole.roleAI:Stop(true)
            self.dormRole.dormRoleStateMachine:ChangeSpeedToValue(0) -- 呆立
            CSAPI.SetLocalPos(self.uav, self.startPos.x, self.startPos.y, self.startPos.z)
            CSAPI.SetGOActive(self.uav, true)
            self.index = 4
        end
    elseif (self.index == 4) then
        -- 飞机飞入
        if (UnityEngine.Vector3.Distance(self.uav.transform.localPosition, self.endPos) > 0.1) then
            local cachePos = UnityEngine.Vector3.Lerp(self.uav.transform.localPosition, self.endPos, Time.deltaTime * 3)
            self.uav.transform.localPosition = cachePos
        else
            local cfg = Cfgs.CfgCardRoleAction:GetByID(self.dormAction2)
            self.dormRole.dormRoleStateMachine:ExitActionByType(cfg.sType)
            for i, v in pairs(self.animators) do
                self.animators[i]:SetBool("leisure", false)
            end
            -- 特效
            ResUtil:CreateEffect("Dormitory/Zr_normalEffect_UPtransmission", 0, 0, 0.185, self.uav, function(go)
                CSAPI.SetAngle(go, -90, 0, 0)
            end)

            self.indexTimer = Time.time + 1 -- 快递移动时间
            self.index = 5
        end
    elseif (self.index == 5 and Time.time > self.indexTimer) then
        -- 快递移动完成，转移父类
        CSAPI.SetParent(self.box, self.uav, false)
        self.index = 6
    elseif (self.index == 6) then
        -- 飞走
        if (self.uav.activeSelf) then
            if (UnityEngine.Vector3.Distance(self.uav.transform.localPosition, self.outPos) > 0.1) then
                if (self.cacheSpeed < 7) then
                    self.cacheSpeed = self.cacheSpeed + 0.04
                end
                self.uav.transform.localPosition = UnityEngine.Vector3.MoveTowards(self.uav.transform.localPosition,
                    self.outPos, Time.deltaTime * self.cacheSpeed)
            else
                CSAPI.SetGOActive(self.uav, false)
                self:OnComplete()
                self.index = 7
            end
        end
    end
end

function this:RemoveChilds()
    if (self.uav) then
        CSAPI.RemoveGO(self.uav)
    end
    self.uav = nil
    if (self.box) then
        CSAPI.RemoveGO(self.box)
    end
    self.uav = nil
end

-- 休闲结束，准备索点移动
function this:OnComplete()
    self.isEnter = false

    self:RemoveChilds()

    local action, dormAction2 = Dorm_GetActionType(self.dormAction2, self.dormRole)
    self.dormRole.ChangeAction(action, dormAction2)
end

function this:Exit()
    self:RemoveChilds()
end

return this
