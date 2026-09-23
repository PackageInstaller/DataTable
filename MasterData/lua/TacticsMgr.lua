--指挥官战术数据管理
local this = {
}

--初始化
function this:Init()
	self.tactics = {};
	for k, v in pairs(Cfgs.CfgPlrSkillGroup:GetAll()) do
		local tactic = TacticsData.New();
		tactic:InitCfg(v.id);
		table.insert(self.tactics, tactic);
	end
	-- AbilityProto:GetSkillGroup();
end

--设置数据
function this:SetData(data)
	self:Init();
	if data then
		for k, v in pairs(data) do
			local item = self:GetDataByID(k);
			if item then
				item:SetData(v);
			end
		end
	end
end

--==============================--
--desc:升级技能组
--time:2019-09-18 10:53:16
--@args:
--@return 
--==============================--
function this:UpdateData(group)
	if(group) then
		for k, v in ipairs(self.tactics) do
			if v:GetCfgID() == group.id then
				table.remove(self.tactics,k);
				break;
			end
		end
		local tactic = TacticsData.New();
		tactic:SetData(group);
		table.insert(self.tactics, tactic);
    end 
end

--返回数据
function this:GetData()
	return self.tactics;
end

--返回解锁的技能数据
function this:GetUnLockData()
	local unlockList={};
	if self.tactics then
		for k,v in ipairs(self.tactics) do
			if v:IsUnLock() then
				table.insert(unlockList,v);
			end
		end 
	end
	return unlockList;
end

function this:GetDataByID(id)
	if id and self.tactics then
		for k, v in ipairs(self.tactics) do
			if v:GetCfgID() == id then
				return v;
			end
		end
	end
end

return this; 