local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--状态配置
this.cfg = nil;

--FireBall配置
this.cfgsFireBall = nil;
this.indexFireBall = nil;

--角色
this.character = nil;
--状态播放进度
--this.playProgress = nil;
--状态已开始时间
this.elapseTime = nil;

--初始化状态
function this:Init(cfg,character)
    if(self.character ~= nil)then
        LogError(self.character.gameObject.GetInstanceID());
    end
    self.character = character;
    --self.stateMachine = character.stateMachine;
    self.cfg = cfg;
    self:InitCfgsFireBall();
end
--初始化FireBall配置
function this:InitCfgsFireBall()
    local cfgArr = Cfgs.character_state_fireball:GetGroup(self.character:GetModelID());
    if(cfgArr ~= nil)then
        local index = 1;
        for i,v in pairs(cfgArr)do     
            --Log(v.state .. " : " .. self.cfg.name);     
            if(v.state == self.cfg.name)then
                self.cfgsFireBall = self.cfgsFireBall or {};
                self.cfgsFireBall[index] = v;
                index = index + 1;
            end
        end
    end
end

--获取状态类型
--function this:GetStateType()
--    local stateType = 0;
--    if(self.cfg ~= nil and self.cfg.state_type ~= nil)then
--        stateType = self.cfg.state_type;
--    end
--    return stateType;
--end

--进入
function this:Enter()
    self:Reset();

     --CameraMgr:ApplyCameraAction(self.cfg.camera_actions,self.character.fightAction); 
end
--退出
function this:Exit()
    self:Reset();
end
function this:Reset()
    self.indexFireBall = 1;
    self.elapseTime = 0;
end

--更新
function this:Update()
    self.elapseTime = self.elapseTime + Time.deltaTime;
    --self.playProgress = self.character.cAnimator.playProgress;
    --self:UpdateFireBall();
end

--是否可以使用技能
--function this:IsCanCast()   
--    local stateType = self.cfg.state_type;
--    return stateType == 0 or stateType == 1;--待机或者移动状态使用技能
--end

return this;