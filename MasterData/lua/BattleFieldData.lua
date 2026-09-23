local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(info)
	self.init = info.init
	self.total = info.total
	self.curr = info.curr
	self.cfg = Cfgs.MainLine:GetByID(info.enemy)
end

function this:GetCfg()
	return self.cfg 
end

function this:GetID()
	return self.cfg and self.cfg.id
end

function this:GetName()
	return self.cfg and self.cfg.name
end

function this:GetBuff()
	return self.cfg and self.cfg.nBuffer
end

--获取buff说明
function this:GetBuffDesc()
	return self.cfg and self.cfg.bufferDesc
end

function this:GetTeamNum()
	return self.cfg and self.cfg.teamNum or 1
end

function this:GetEnemyID()
	if self.cfg and self.cfg.enemyPreview then
		return self.cfg.enemyPreview[1]
	end
	return 0
end

function this:GetLv()
	return self.cfg and self.cfg.previewLv
end

--当前状态 1.全面压制 2.战况压制 3.阵线维持 4.战况紧张 5.全面溃败
function this:GetState()
	local precent = (self.total - self.curr) / self.init * 100
	local state = 3
	if precent <= 0  then
		state = 1
	elseif precent < 50 then
		state = 2
	elseif precent >= 200 then
		state = 5
	elseif precent > 150 then
		state = 4
	end
	return state
end

--获取敌人类型id
function this:GetEnemyDesc()
	return self.cfg and self.cfg.enemyDesc
end

function this:GetCurrEnemy()
	return (self.total - self.curr) or 0
end

function this:GetInit()
	return self.init
end

function this:GetPos()
	return self.cfg and self.cfg.pos
end

return this