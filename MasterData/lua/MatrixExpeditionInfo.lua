--远征任务
MatrixExpeditionInfo = {}
local this = MatrixExpeditionInfo
function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);	
	return ins;
end

function this:SetName(_name)
	self.name = _name
end

function this:SetData(_cfg, _serverData, _buildID, _i)
	self.cfg = _cfg
	self.serverData = _serverData
	self.buildID = _buildID
	self.i = _i
end

function this:GetCfg()
	return self.cfg
end

function this:GetServerData()
	return self.serverData
end

function this:GetBuildID()
	return self.buildID
end

function this:GetI()
	return self.i
end

--时限
function this:GetEndTime()
	if(self.serverData) then
		return self.serverData.endTime or nil
	end
	return nil
end

--当前时间进度
function this:GetTCur()
	if(self.serverData) then
		return self.serverData.tCur or nil
	end
	return nil
end
--当前时间进度
function this:GetTF()
	if(self.serverData) then
		return self.serverData.tf or nil
	end
	return nil
end
--结束时间  
function this:GetCrateEndTime()
	return self.serverData.num or 0
end

--排序
function this:GetSortIndex()
	local bei = self.serverData.cfgId == 4 and 10 or 100
	return self.serverData.cfgId * bei + self.serverData.id
end

--闲置1  行动中2  完成3 
function this:GetState()
	if(self.serverData.endTime ~= nil) then
		return 1
	elseif(self.serverData.num and self.serverData.num > TimeUtil:GetTime()) then
		return 2
	else
		return 3
	end
end

--小球数量
function this:GetBallCount()
	local count = self.cfg.ballCnt
	local buildData = MatrixMgr:GetBuildingDataById(self.buildID)
	if(buildData:GetData().roleAbilitys and buildData:GetData().roleAbilitys[RoleAbilityType.ExplorLeader]) then
		local _val = buildData:GetData().roleAbilitys[RoleAbilityType.ExplorLeader].vals[1] or 0
		count = count + val
	end
	return count
end


return this
