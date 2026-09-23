local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId,cfgIdx)
     if cfgId and cfgIdx then
        self.tempCfg = Cfgs.cfgMonopolyGrid:GetByID(cfgId)
        if self.tempCfg == nil then
            LogError("大富翁活动表：cfgMonopolyGrid中未找到ID：" .. tostring(cfgId) .. "对应的数据");
			do return end
        end
		if #self.tempCfg.infos>=cfgIdx then
			self.cfg=self.tempCfg.infos[cfgIdx];
		end
		self.performCfg=self:GetPerform();
    end
end

function this:GetID()
	return self.cfg and self.cfg.index or nil;
end

function this:GetTempID()
	return self.tempCfg and self.tempCfg.id or nil;
end

function this:GetType()
	return self.cfg and self.cfg.type or RichManEnum.GridType.Move;
end

function this:GetValue1()
	return self.cfg and self.cfg.value1 or nil;
end

function this:GetValue2()
	return self.cfg and self.cfg.value2 or nil;
end

function this:GetValue3()
	return self.cfg and self.cfg.value3 or nil;
end

--对应格子位置ID
function this:GetPos()
	return self.cfg and self.cfg.pos or nil;
end

function this:GetSort()
	return self.cfg and self.cfg.sort or nil;
end

--触发类型
function this:GetTriggerType()
	return self.cfg and self.cfg.triggerType or RichManEnum.TriggerType.None;
end

--表现ID
function this:GetPerformId()
	return self.cfg and self.cfg.performId or nil;
end

--返回格子表现配置
function this:GetPerform()
	--查找格子表现配置
	local performId=self:GetPerformId();
	if performId~=nil then
		return Cfgs.cfgMonopolyPerform:GetByID(performId);
	end
end

function this:GetQuality()
	return self.performCfg and self.performCfg.quality or 3;
end

function this:GetIcon()
	return self.performCfg and self.performCfg.icon or nil;
end

function this:GetEffect()
	return self.performCfg and self.performCfg.effect or nil;
end

function this:GetSound()
	return self.performCfg and self.performCfg.sound or nil;
end

function this:IsShowNum()
	return self.performCfg and self.performCfg.showNum==1 or false
end

function this:GetShowType()
	return self.performCfg and self.performCfg.showType or 1;
end

function this:GetName()
	return self.performCfg and self.performCfg.name or ""
end

function this:GetDesc()
return self.performCfg and self.performCfg.desc or ""
end

return this;