-- 驻员动画
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

this.roleLua = nil
this.currStateHash = nil
-- this.ActionTypeFuncs = {}
this.curActionType = nil
this.type_speed = "Speed" 
this.param_speed = "Speed"

-- 初始化状态机
function this:Init(roleLua)
    self.roleLua = roleLua
end

function this:Update()
    if (self.isChangeSpeed ~= nil) then
        self:UpdateSpeed()
    end

    -- 过程中说话
    if (self.actionMTalk and TimeUtil:GetTime() > self.actionMTalk[1]) then
        local id = self.actionMTalk[2]
        self.actionMTalk = nil
        self:SetTalk(id)
    end
end

-- 进入状态
function this:OnStateEnter(stateHash)
    self.currStateHash = stateHash
end

-- --播放动画
-- function this:PlayAnimByID(actionID)
-- 	local funcName = "Action" .. actionID
-- 	local func = this[funcName]
-- 	if(func) then
-- 		func(self)
-- 	end
-- end
-- 执行动作
function this:PlayByActionType(_type, _loopTime)
    self.speedToZeroCB = nil
    self.isChangeSpeed = nil

    if (self.roleLua.IsRobot()) then
        return
    end
    if (self.curActionType and self.curActionType == _type) then
        return
    end

    local cfg = Cfgs.CfgCardRoleAction:GetByID(_type)
    -- 下一动作是移动/休闲时
    if (cfg.sType == this.type_speed) then
        if (self.curActionType) then
            local _cfg = Cfgs.CfgCardRoleAction:GetByID(self.curActionType)
            if (_cfg.sType ~= this.type_speed) then
                self:ActionBool(_cfg.sType, false) -- 否则停止当前动作
            end
        end
        self:InitSpeed(_type)
    else
        -- 停止之前的所有动作（如果此时是移动，会有卡顿感，需要在移动那边将速度渐出再进入下一个动作）	
        if (self.curActionType) then
            local _cfg = Cfgs.CfgCardRoleAction:GetByID(self.curActionType)
            if (_cfg.sType == this.type_speed) then
                self:SetFloat(_cfg.sType, 0)
            else
                self:ActionBool(_cfg.sType, false)
            end
        end
        self:ActionBool(cfg.sType, true)
        self:ActionPlay(cfg)
    end

    -- 调整 
    self.roleLua.AdjustAction(_type)

    -- 文本
    self:SetActionDesc(_type, _loopTime)

    self.curActionType = _type
end

-- 文本
function this:SetActionDesc(_type, _loopTime)
    -- 提起时隐藏文本
    if (_type == "click_grab") then
        self.actionMTalk = nil
        self:SetTalk(nil)
        return
    end

    -- 前一个动作结束后的动作
    if (self.curActionType) then
        local cfg = Cfgs.CfgCardRoleAction:GetByID(self.curActionType)
        if (cfg.actionTalkID3) then
            self:SetTalk(cfg.actionTalkID3)
        end
    end
    -- 当前动作动画
    if (_type) then
        local cfg = Cfgs.CfgCardRoleAction:GetByID(_type)
        if (cfg.actionTalkID1) then
            self:SetTalk(cfg.actionTalkID1)
        end
    end

    -- 过程中的
    self.actionMTalk = nil
    local cfg = Cfgs.CfgCardRoleAction:GetByID(_type)
    local curTime = TimeUtil:GetTime()
    if (cfg.actionTalkID2 ~= nil and cfg.loop ~= nil) then
        local len = _loopTime ~= nil and _loopTime / 2 or cfg.loop[1] / 2
        self.actionMTalk = {curTime + len, cfg.actionTalkID2}
    end
end

-- 谈话文本
function this:SetTalk(id)
    if (id) then
        local cfg = Cfgs.CfgCardRoleInte:GetByID(id)
        self.roleLua.AddBubble(cfg.desc, 3, self.roleLua.CheckIsDorm())
        -- EventMgr.Dispatch(EventType.Dorm_Talk, {cfg.desc, self.roleLua.data:GetID(), 3, self.roleLua.CheckIsDorm()})
    else
        self.roleLua.AddBubble("", 3, self.roleLua.CheckIsDorm())
        -- EventMgr.Dispatch(EventType.Dorm_Talk, {"", self.roleLua.data:GetID(), 3, self.roleLua.CheckIsDorm()})
    end
end

function this:ExitActionByType(sType)
    self:ActionBool(sType, false)
end

-- 停止循环
function this:ExitLoop(id)
    local _cfg = Cfgs.CfgCardRoleAction:GetByID(id)
    if (#_cfg.loop > 1) then
        self:ActionBool(_cfg.sType, false)
    end
end

-- 速度值过渡处理
function this:InitSpeed(_type)
    if(not self.roleLua.animators)then 
        return
    end 
    local _curSpeed = self.roleLua.animators[0]:GetFloat(this.param_speed)
    local _endSpeed = _type == "idle" and 0 or 1
    if (math.abs(_curSpeed - _endSpeed) > 0) then
        self.curSpeed = _curSpeed
        self.endSpeed = _endSpeed
        self.timeLen = Dorm_IdleToWall_Time * math.abs((self.curSpeed - self.endSpeed))
        self.timer = 0
        self.isChangeSpeed = true
    end
end

-- 将速度过渡到o
function this:ChangeSpeedToValue(value, cb)
    if(not self.roleLua.animators)then 
        return
    end 
    local _curSpeed = self.roleLua.animators[0]:GetFloat(this.param_speed)
    if (math.abs(_curSpeed - value) > 0) then
        self.speedToZeroCB = cb
        self.curSpeed = _curSpeed
        self.endSpeed = value
        self.timeLen = Dorm_IdleToWall_Time * math.abs((self.curSpeed - self.endSpeed))
        self.timer = 0
        self.isChangeSpeed = true
    else
        self:SetFloat(this.param_speed, value)
        if (cb) then
            cb()
        end
    end
end

function this:UpdateSpeed()
    local speed = self.curSpeed + self.timer / self.timeLen * (self.endSpeed - self.curSpeed)
    self:SetFloat(this.param_speed, speed)
    self.timer = self.timer + Time.deltaTime
    if (self.timer >= self.timeLen) then
        self:SetFloat(this.param_speed, self.endSpeed)
        if (self.speedToZeroCB~=nil) then
            self.speedToZeroCB()
        end
        self.speedToZeroCB = nil
        self.isChangeSpeed = nil
    end
end

function this:ActionPlay(_cfg)
    if(not self.roleLua.animators)then 
        return
    end 
    local cfg = Cfgs.CfgCardRoleAction:GetByID(_cfg.id)
    local animators = self.roleLua.animators
    local name = self:GetCorrectName(_cfg)
    for i = 0, animators.Length - 1 do
        self.roleLua.animators[i]:Play(name)
        --分层的表情
        if(cfg.faceName) then 
            self.roleLua.animators[i]:Play(name,1)
        end 
    end
end

function this:ActionBool(name, b)
    if(not self.roleLua.animators)then 
        return
    end 
    local animators = self.roleLua.animators
    for i = 0, animators.Length - 1 do
        self.roleLua.animators[i]:SetBool(name, b)
    end
end

function this:SetFloat(name, num)
    if(not self.roleLua.animators)then 
        return
    end 
    num = num < 0 and 0 or num
    num = num > 1 and 1 or num
    local animators = self.roleLua.animators
    for i = 0, animators.Length - 1 do
        self.roleLua.animators[i]:SetFloat(name, num)
    end
end

function this:SetTrigger(name)
    if(not self.roleLua.animators)then 
        return
    end 
    local animators = self.roleLua.animators
    for i = 0, animators.Length - 1 do
        self.roleLua.animators[i]:SetTrigger(name)
    end
end

-- 当前速度 
function this:GetSpeed()
    if (self.roleLua.animators) then
        return self.roleLua.animators[0]:GetFloat("Speed")
    end
    return 0
end

function this:GetCorrectName(cfg)
    if(cfg.id=="base_operatePC1") then 
        return  "base_operatePC"
    end 
    return cfg.id 
end

return this

