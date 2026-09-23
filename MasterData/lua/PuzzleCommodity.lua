local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(data)
	self.data=data;
	self.cfg=data.cfg;
end

function this:GetID()
	return self.cfg and self.cfg.idx or nil;
end

function this:CanBuy()
	if self.data then
		return self.data.canBuy
	end
	return true;
end

function this:GetCosts()
	local costs=nil;
	if self.cfg then
		if self.cfg.cost1 then
			costs=costs or {}
			for k,v in ipairs(self.cfg.cost1) do
				table.insert(costs,{id = v[1], num = v[2]}); 
			end
		end
		if self.cfg.cost2 then
			costs=costs or {}
			for k,v in ipairs(self.cfg.cost2) do
				table.insert(costs,{id = v[1], num = v[2]}); 
			end
		end
	end
	return costs;
end

function this:GetGoods()
	local goods=nil;
	if self.cfg and self.cfg.reward then
		goods=BagMgr:GetFakeData(self.cfg.reward[1][1]);
	end
	return goods;
end

function this:GetNum()
	local num=0;
	if self.cfg and self.cfg.reward then
		num=self.cfg.reward[1][2];
	end
	return num;
end

return this;