local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(_cfg)
	self.cfg = _cfg
end

function this:GetIcon()
	return self.cfg and self.cfg.icon
end

function this:InitData(_data)
    if _data then
		self.id = _data.nodeId
		self.type = _data.nodeType
		self.stage = _data.stageId
		self.progress = _data.progressCur
		self.maxProgress = _data.progressMax
		self.state = _data.state
		self.dupId = _data.dupId
	end
end

--id
function this:GetID()
	return self.id
end

--类型 1：普通（包含三阶段）2：黑雾 3：核心
function this:GetType()
	return self.type
end

--所属阶段
function this:GetStage()
	return self.stage
end

--进度
function this:GetProgress()
	return self.progress,self.maxProgress
end

--状态
function this:GetState()
	return self.state
end

--关卡id
function this:GetDungeonId()
	return self.dupId
end

function this:IsPass()
	return self.progress <= 0
end

return this;