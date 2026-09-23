--布局家具数据
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:Refresh(_cfg, _num, _isMax, _isUse)
	
end

function this:GetCfg()
	
end

function this:GetNum()
	
end

function this:GetIsMax()
	
end

function this:GetIsUse()
	
end

return this 