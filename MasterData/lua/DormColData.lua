-- 碰撞数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

-- lua1:碰撞者  lua2：被碰撞者
function this:InitData(_lua1, _lua2, _colType, _targetGO, _isTookDown)
    self.lua1 = _lua1
    self.lua2 = _lua2
    self.colType = _colType
    self.targetGO = _targetGO
    self.isTookDown = _isTookDown

    self.curData = {}
end

function this:GetColType()
    return self.colType
end

function this:GetIsTookDown()
    return self.isTookDown
end

-- 是否有碰撞（并非所有碰撞都是有效的）
function this:CheckColExist()
    if (self.lua2 == nil or self:GetColType() == nil) then
        return false
    end

    if (self.colType == DormGoType.col_area) then
        self.curData.actionType = "base_operatePC" -- 操作电脑
        self.curData.desc = nil
        self.curData.actionTime = 5
        return true
    elseif (self.colType == DormGoType.furniture) then
        -- 有概率，看是否触发
        local cfg2 = self.lua2.data:GetCfg()
        local inteRate = cfg2.inteRate or 0
        if (inteRate == 0) then
            return false
        end
        if (self.lua1.IsPet()) then
            local actionType = self.lua2.data:GetPetInteActionID()
            if (actionType) then
                self.curData.actionType = actionType
                self.curData.desc = ""
                self.curData.actionTime = Dorm_Action_Time(self.curData.actionType)
                return true
            end
        else
            self.curData.actionType = self.lua2.data:GetInteActionID(self.targetGO)
            self.curData.desc = cfg2.interDesc
            self.curData.actionTime = Dorm_Action_Time(self.curData.actionType)
            return true
        end
    elseif (self.colType == DormGoType.dorm_role) then
        -- 交叉角度判断：
        -- 如果A和B与碰撞点的角度均小于45度，则发生交互
        -- 如果A与碰撞点的角度小于45度,但B不是，则A停止移动进入休息，B继续行走
        -- 如果没有角度小于xx，则两者继续行走
        -- 对方是休闲或者移动才能触发交互

        local id1 = self.lua1.data:GetID()
        local id2 = self.lua2.data:GetID()

        -- 休闲或者移动时才能交互
        if (not self.lua2.CheckCanInteraction(id1)) then
            return false
        end
        if (self.lua1.IsPet() and self.lua2.IsPet()) then
            return false
        end
        local angle1, angle2 = self.lua1.GetColAngle()
        -- 两人距离是1
        local dis = UnityEngine.Vector3.Distance(self.lua1.transform.position, self.lua2.transform.position)
        if (math.abs(dis - 1) > 0.05) then
            return false
        end
        if (self.lua1.IsPet() or self.lua2.IsPet()) then
            -- 抱猫         
            if (self.lua1.IsPet() and math.abs(angle1) > DormRoleHitAngle2 and math.abs(angle2) < DormRoleHitAngle) then
                self.curData.actionType = "hug"
                self.curData.desc = nil
                self.curData.actionTime = Dorm_Action_Time(self.curData.actionType)
                self.lua1.SetInteractionID(id2)
                return true
            elseif (self.lua2.IsPet() and math.abs(angle1) < DormRoleHitAngle and math.abs(angle2) > DormRoleHitAngle2) then
                self.curData.actionType = "role_hug"
                self.curData.desc = nil
                self.curData.actionTime = Dorm_Action_Time(self.curData.actionType)
                self.lua1.SetInteractionID(id2)
                return true
            end
        else
            -- 击掌
            if (math.abs(angle1) < DormRoleHitAngle and math.abs(angle2) < DormRoleHitAngle) then
                local canInte = self.lua1.data:CheckCanInte(id2) -- 是否是可交互的角色
                if (canInte) then
                    -- 对方是不是无交互对象，或者交互对象是我（有这一步是因为OnTriggerEnter存在先后）
                    local canHf = self.lua2.CheckCanHighfive(id1)
                    if (not canHf) then
                        return false
                    end
                    self.lua1.SetInteractionID(id2)
                    self.curData.actionType = id1 < id2 and "role_highfive_01" or "role_highfive_02"
                    self.curData.desc = nil
                    self.curData.actionTime = Dorm_Action_Time(self.curData.actionType)
                end
                return canInte
            end
        end
    end
    return false
end

-- -- 击掌 id小的用左手，大的用右手
-- function this:GetHighFiveID()
--     local id1 = self.lua1.data:GetID()
--     local id2 = self.lua2.data:GetID()
--     return id1 < id2 and "role_highfive_01" or "role_highfive_02"
-- end

-- 缓慢朝向目标 角色、区域、家具 
function this:LookAtTargetSlow(imm)
    if (imm or self.colType == DormGoType.furniture) then
        local angleOffset = self:GetActionAngleOffset()
        local x, y, z = CSAPI.GetWorldAngle(self.targetGO)
        CSAPI.SetWorldAngle(self.lua1.gameObject, 0, y + angleOffset, 0)
        return true
    else
        return self.lua1.Rotation(self.targetGO)
    end
end

-- 立即朝向目标 家具  
function this:LookAtTarget()
    local angleOffset = self:GetActionAngleOffset()
    local x, y, z = CSAPI.GetWorldAngle(self.targetGO)
    CSAPI.SetWorldAngle(self.lua1.gameObject, 0, y + angleOffset, 0)
end

-- 立即朝向目标 区域，角色  
function this:LookAtTarget2()
    if (self.lua1.IsPet()) then
        local awayFromTarget = self.lua1.transform.position - self.targetGO.transform.position
        self.lua1.transform.rotation = UnityEngine.Quaternion.LookRotation(awayFromTarget, UnityEngine.Vector3.up)
    else
        self.lua1.transform:LookAt(self.targetGO.transform, UnityEngine.Vector3.up)
    end
end

-- 动作
function this:Action()
    local actionType = self.curData.actionType
    if (actionType ~= nil) then
        self.lua1.dormRoleStateMachine:PlayByActionType(actionType)

        self.lua1.AddChilds(actionType)
    end
    -- 家具动作
    self:FurnitureAction(true)
end

function this:FurnitureAction(b)
    if (self.colType == DormGoType.furniture) then
        local cfg2 = self.lua2.data:GetCfg()
        if (cfg2.playAnim) then
            self.lua2.PlayAnim(b)
        end
        if (cfg2.eff) then
            self.lua2.CreateEffect(b)
        end
    end
end

-- 退出动作 （起身动作）
function this:ActionUp()
    local actionType = self.curData.actionType
    if (actionType ~= nil) then
        local cfg = Cfgs.CfgCardRoleAction:GetByID(actionType)
        if (cfg.restore) then
            self.lua1.dormRoleStateMachine:ExitActionByType(cfg.sType)
            return true, cfg.restore
        end
    end
    return false, 0
end

-- 交互时朝向额外角度
function this:GetActionAngleOffset()
    if (not self.angleOffset) then
        local actionType = self.curData.actionType
        if (actionType ~= nil) then
            local cfg = Cfgs.CfgCardRoleAction:GetByID(actionType)
            self.angleOffset = cfg.inteDir and 0 or 180
        end
    end
    return self.angleOffset
end

-- 获取交互文本
function this:GetRoleInte(id)
    if (id) then
        local id = CSAPI.RandomInt(1, 10) -- todo 
        local cfg = Cfgs.CfgCardRoleInte:GetByID(id)
        return cfg and cfg.desc or ""
    end
    return ""
end

function this:GetActionTime()
    return self.curData.actionTime
end

-- -- 弹出文本
-- function this:AddBubble()
--     local _desc = self.curData.desc
--     if (_desc) then
--         self.lua1.AddBubble(_desc, self.lua1.data:GetID(), self:GetActionTime())
--     end
-- end

-- 与交互中心点的距离
function this:GetDis()
    local _pos1 = self.lua1.transform.position
    local pos1 = UnityEngine.Vector3(_pos1.x, 0, _pos1.z)
    local x, y, z = CSAPI.GetPos(self.targetGO)
    local pos2 = UnityEngine.Vector3(x, 0, z)
    return UnityEngine.Vector3.Distance(pos1, pos2)
end

function this:GetTargetGO()
    return self.targetGO
end

-- 设置到可触发交互的位置
function this:SetToCorrectPos()
    if (self.colType == DormGoType.col_area) then
        return self:SetToCorrectPos2()
    else
        return self:SetToCorrectPos1()
    end
end

-- 设置到可触发交互的位置
function this:SetToCorrectPos1()
    if (not self.correctPos) then
        self.correctPos = self.targetGO.transform.position + self.targetGO.transform.forward * 0.25 -- 025格是间隔
        self.correctPos.y = 0
    end
    self.lua1.transform.position = self.correctPos
end

-- 交互区域
function this:SetToCorrectPos2()
    if (not self.correctPos) then
        self.correctPos = self.targetGO.transform.position
        self.correctPos.y = 0
    end
    self.lua1.transform.position = self.correctPos
end

-- update 
function this:MoveToCorrectPos()
    -- if(self.colType == DormGoType.col_area) then
    -- return self:MoveToCorrectPos2()
    -- else
    return self:MoveToCorrectPos1()
    -- end
end

-- 移动到可触发交互的位置
function this:MoveToCorrectPos1()
    if (not self.correctPos) then
        self.correctPos = self.targetGO.transform.position + self.targetGO.transform.forward * 0.5 -- todo 
        -- self.correctPos.y = self.lua1.transform.position.y
        self.lua1.roleAI:SetTarget(self.correctPos)
    end
    if (not self.lua1.roleAI.ai.isStopped and self.lua1.roleAI.ai.remainingDistance <= DormInteDis) then
        return true
    end
    return false

    -- return self.lua1.MoveTo(self.correctPos)
end

return this
