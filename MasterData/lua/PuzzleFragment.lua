--拼图碎片信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(_id,_idx,_cost,_reward,_pos,_img,_isRevice)
	self.id=_id;
	self.idx=_idx;
	self.cost=_cost;
	self.reward=_reward;
	self.pos=_pos;
	self.img=_img;
	self.isRevice=_isRevice
end

function this:GetCost()
	return self.cost or nil
end

function this:GetReward()
	return self.reward or nil;
end

function this:GetID()
	return self.id or nil;
end

function this:GetIdx()
	return self.idx or nil;
end

function this:GetPos()
	if self.pos and PuzzleEnum.PuzzleOffset and PuzzleEnum.PuzzleOffset[self.pos] then
		return PuzzleEnum.PuzzleOffset[self.pos]
	end
	return {0,0};
end

function this:GetImg()
	return self.img or nil;
end

function this:IsRevice()
	return self.isRevice or false;
end

--是否符合解锁条件
function this:IsUnlock()
	local isUnlock=false;
	if self.cost then
		local has=true;
		for k,v in ipairs(self.cost) do
			if BagMgr:GetCount(v[1])<v[2] then
				has=false;
				break;
			end
		end
		isUnlock=has;
	end
	return isUnlock;
end

--判断指定goodsId是否是解锁道具ID
function this:IsCostsID(goodsId)
	if goodsId and self.cost then
		for k,v in ipairs(self.cost) do
			if goodsId==v[1] then
				return true;
			end
		end
	end
end

return this;
