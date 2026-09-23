--剧情故事数据
local this={}
local beginData=nil;
function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end


--初始化配置
function this:InitCfg(cfgId)
    beginData=nil;
    if(cfgId == nil)then
        LogError("初始化剧情故事数据失败！无效配置id");        
    end

    if(self.cfg == nil)then        
        self.cfg = Cfgs.StoryInfo:GetByID(cfgId);
        if(self.cfg == nil)then        
            LogError("找不到剧情故事数据！id = " .. cfgId);    
        end
    end
end

--返回ID
function this:GetID()
    return self.cfg and self.cfg.id;
end

--返回开始对话的信息
function this:GetBeginPlotData()
    if  beginData==nil then
        local id=self.cfg and self.cfg.beginId;
        if  id~=nil then
            beginData=PlotData.New();
            beginData:InitCfg(id);
        end
    end
    return beginData;
end

--返回该段剧情名称
function this:GetStoryName()
    return self.cfg and self.cfg.name;
end

--返回剧情简介
function this:GetDesc()
    local desc="";
    if self.cfg and self.cfg.desc then
        desc=string.format(self.cfg.desc,PlayerClient:GetName(), PlayerClient:GetName(),PlayerClient:GetName(), PlayerClient:GetName());
    end
    return desc;
end

--返回剧情类型
function this:GetType()
    return self.cfg and self.cfg.type or  PlotType.Normal;
end

return this;