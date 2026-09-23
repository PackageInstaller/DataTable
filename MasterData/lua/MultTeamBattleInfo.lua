local this = {}
--多队boss战斗类
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end
function this:InitCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化递归沙盒配置失败！cfgId不能为nil！");
    end
    self.cfg = Cfgs.CfgMultiteamBattle:GetByID(cfgId);
    if self.cfg == nil then
		LogError("找不到递归沙盒配置！id = " .. cfgId);	
    end
end

function this:SetData(_d)
	self.data =_d
	if self.data then
		self:InitCfg(self.data.id)
	end
end

function this:GetData()
	return self.data;
end

function this:GetRound()
	return self.data and self.data.round or 1;
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

--活动开放时间
function this:GetBegTime()
	return self:GetCfgTime("begTime");
end

--活动关闭时间
function this:GetEndTime()
	return self:GetCfgTime("endTime");
end

function this:GetCfg()
	return self.cfg or nil
end

--活动结算时间
function this:GetSettlementTime()
	return self:GetCfgTime("settlementTime");
end

--返回活动状态
function this:GetActivityState()
	local time=TimeUtil:GetTime()
	local begTime=self:GetBegTime();
	local endTime=self:GetEndTime();
	local setTime=self:GetSettlementTime();
	if begTime~=0 and setTime~=0 and endTime~=0 and time>=begTime and time<setTime and time<=endTime then
		return MultTeamActivityState.Open
	elseif endTime~=0 and setTime~=0 and time>=setTime and time<=endTime then
		return MultTeamActivityState.Settlement
	elseif begTime~=0 and endTime~=0 and time<begTime and time>endTime then
		return MultTeamActivityState.Over;
	end
end

function this:GetCfgTime(key)
	local time=0
	if self.cfg and self.cfg[key] then
		time=TimeUtil:GetTimeStampBySplit(self.cfg[key])
	end
	return time
end

--返回任务组ID
function this:GetMissionGroup()
	return self.cfg and self.cfg.missionGp or nil;
end

--普通商店
function this:OpenShop()
	CSAPI.OpenView("ShopView",self.cfg.shopGp);
end

--讨伐商店
function this:GetJumpId()
	return self.cfg and self.cfg.jumpId or nil;
end

--返回积分道具信息
function this:GetPointGoods()

end

function this:GetCardArrs()
	local list={};
	if self.data and self.data.arrCard then
		for k, v in ipairs(self.data.arrCard) do
			table.insert(list,RoleMgr:GetData(v));
		end
	end
	return list;
end

--当前卡牌是否可以使用
function this:CardCanUse(cid)
    local canUse=true;
    local lID=nil;
    if cid and self.data and self.data.arrCard then
        for k, v in ipairs(self.data.arrCard) do
            if v==cid or (RoleMgr:IsSexInitCardIDs(v) and RoleMgr:IsSexInitCardIDs(cid)) then
                canUse=false;
                lID=77035;
                break;
            end
        end
    end
    return canUse,lID;
end

--怪物是否已击败
function this:IsPass(mId)
	if mId and self.data and self.data.arrPass then
		for k, v in ipairs(self.data.arrPass) do
			if v==mId then
				return true;
			end
		end
	end
	return false;
end

--是否领取过结算奖励
function this:IsSettle()
	return self.data and self.data.isSettle or false
end

function this:GetEnterGoods()
	local goods=nil;
	if self.cfg and self.cfg.EnterId then
		goods=BagMgr:GetFakeData(self.cfg.EnterId);
	end
	return goods
end

function this:GetBossInfo(dupId)
	if dupId and self.data and self.data.dupData then
		for k,v in ipairs(self.data.dupData) do
			if v.dupId==dupId then
				return v;
			end
		end
	end
	return nil;
end

function this:GetRewardCfg()
	if self.cfg then
		local rewardInfo=Cfgs.CfgSettlementRewards:GetByID(self.cfg.rewardGp);
		return rewardInfo
	end
	return nil;
end

function this:IsSettle()
	return self.data and self.data.isSettle or false;
end

return this;