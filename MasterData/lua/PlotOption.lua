--剧情选项数据
local this = {}
function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end


--初始化配置
function this:InitCfg(cfgId)
	if(cfgId == nil) then
		LogError("初始化剧情选项数据失败！无效配置id");		
	end
	
	if(self.cfg == nil) then		
		self.cfg = Cfgs.TalkOption:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到剧情选项数据！id = " .. cfgId);	
		end
	end
end

--返回选项ID
function this:GetID()
	return self.cfg and self.cfg.id;
end

--返回选项内容
function this:GetContent()
	local str = "";
	if self.cfg and self.cfg.content then
		str = self.cfg.content;
		str = string.format(str, PlayerClient:GetName());
	end
	return str;
end

--返回下一段对话内容数据
function this:GetNextPlotInfo()
	local nextIds = self.cfg and self.cfg.nextId or {- 1};
	local nextId = nextIds[1]
	if #nextIds > 1 and self.cfg and self.cfg.nextType then
		if self.cfg.nextType == 1 then --性别
			nextId = PlayerClient:GetSex() == 1 and nextIds[1] or nextIds[2]
		end
	end
	local next = nil;
	if nextId == - 1 then
		return nil
	else
		next = PlotData.New();
		next:InitCfg(nextId);
	end
	return next;
end

--返回奖励信息
function this:GetRewardInfo()
	
end

--返回选项框宽度
function this:GetWidth()
	return self.cfg and self.cfg.width
end

function this:GetKey()
	return "PlotOption"
end

return this; 