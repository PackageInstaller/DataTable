--拼图行奖励信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId,idx)
    if cfgId and idx then
		local rewardCfg=Cfgs.CfgPuzzleReward:GetByID(cfgId);
		if rewardCfg and idx then
			if rewardCfg.infos[idx]==nil then
				LogError("CfgPuzzleReward中未找到id:"..tostring(cfgId).."\t idx"..tostring(idx).."的配置信息");
			else
				self.cfg=rewardCfg.infos[idx];
			end
		end
	end
end

function this:GetIdx()
	return self.cfg and self.cfg.idx or nil;
end

--{id,idx,state}
function this:SetData(_d)
	if _d then
		self:InitCfg(_d.id,_d.idx);
		self.data=_d;
	end
end

--返回当前按钮状态
function this:GetState()
	return self.data and self.data.state or 1;
end

function this:GetIdx()
	return self.cfg and self.cfg.rewardId or nil;
end

function this:GetPos()
	return self.cfg and self.cfg.position or {0,0};
end

function this:GetReward()
	return self.cfg and self.cfg.reward or nil;
end

function this:GetRewardShow()
	return self.cfg and self.cfg.rewardShow or nil;
end


function this:GetGoodsInfo(idx)
	local goods=nil
	if self.cfg and self.cfg.reward then
		goods=BagMgr:GetFakeData(self.cfg.reward[idx][1],self.cfg.reward[idx][2]);
	end
	return goods;
end

return this;