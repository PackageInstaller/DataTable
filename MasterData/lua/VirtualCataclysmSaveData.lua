local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(_data)
    if _data then
		self.id = _data.nodeId
		self.index = _data.idx
		self.score = _data.score
		self.cards = _data.cards
		self.rewards = _data.rewards
		self.damage = _data.nDamage
		self.time = _data.saveTime
	end
end

function this:GetID()
    return self.id
end

function this:GetIndex()
    return self.index
end

function this:GetScore()
    return self.score or 0
end

function this:GetDamage()
	return self.damage or 0
end

function this:GetTime()
	return self.time or 0
end

function this:GetCards()
	local cards = {}
	for i = 1, 5 do
		if self.cards and self.cards[i] then
			table.insert(cards,RoleMgr:GetData(self.cards[i]))
		else
			table.insert(cards,{isEmpty = true})
		end
	end
    return cards
end

function this:GetRewards()
    return self.rewards
end

return this;