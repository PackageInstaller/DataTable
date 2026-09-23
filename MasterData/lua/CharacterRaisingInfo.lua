local this = {}

function this.New()
    this.__index = this.__index or this;
    local tab = {};
    setmetatable(tab, this);
    return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg = Cfgs.CfgRoleTrainGuide:GetByID(cfgId);
    end
    if self.cfg == nil then
        LogError("CfgRoleTrainGuide中找不到对应ID：" .. tostring(cfgId) .. "的配置信息");
    end
end

function this:SetData(_data)
    self.data = _data;
    if self.data == nil then
        return;
    end
    self:InitCfg(self.data.id);
    self.count = self.data.data[1];
    self.reviceIdx=self.data.data[2];--已领取的奖励下标
end

function this:GetData()
    return self.data;
end

function this:GetName()
    return self.cfg and self.cfg.sActivityName or "";
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetFinishCount()
    return self.count or 0;
end

-- 获取当前阶段的奖励配置表和解锁状态
function this:GetCurrStageReward()
    local reward = nil;
    if self.cfg.rewardIds == nil then
        return reward;
    end
    local taskCounts = self:GetFinishCount();
    local idx = (self.reviceIdx and self.reviceIdx>0) and self.reviceIdx or 1;
    local isLock = false;
    local limits = self:GetBuyLimit();
    local rewardId = self.cfg.rewardIds[idx] or nil;
    if rewardId then
        reward = Cfgs.RewardInfo:GetByID(rewardId);
    else
        LogError("培养引导活动id：" .. self:GetID() .. "的第" .. tostring(idx) .. "个RewardID不存在");
    end
    if limits then
        for i=idx, #limits do
            local v=limits[i];
            local rewardID = self.cfg.rewardIds[i] or nil;
            if rewardID then
                reward = Cfgs.RewardInfo:GetByID(rewardId);
                isLock = v > taskCounts;
                if not self:IsRevice(rewardID) then --当前阶段的奖励尚未领取
                    break;
                end
            end
            if taskCounts>=v and idx<#limits then
                idx=idx+1;
            end
        end
    end
    return reward, isLock,idx;
end

function this:IsRevice(rewardId)
    local isRevice=false;
    if rewardId and self.cfg and self.cfg.rewardIds then
        local idx=self.reviceIdx or 0;
        for k, v in ipairs(self.cfg.rewardIds) do
            if v == rewardId and k <= idx then
                isRevice = true;
                break;
            end
        end
    end
    return isRevice;
end

function this:GetBuyLimitByIndex(idx)
    local limits = self:GetBuyLimit();
    if limits and idx >= 1 and idx <= #limits then
        return limits[idx];
    end
    return 0;
end

-- 解锁条件
function this:GetBuyLimit()
    return self.cfg and self.cfg.buyLimitTaskCnt or nil;
end

function this:GetCard()
    local card = nil;
    if self.cfg and self.cfg.cardId then
        card = RoleMgr:GetFakeData(self.cfg.cardId);
    end
    return card;
end

function this:GetTaskList()
    local group = self:GetTaskGroup();
    if group then
        return MissionMgr:GetActivityDatas(eTaskType.RoleTrainGuild,group);
    end
    return nil;
end

function this:GetTaskGroup()
    if self.cfg and self.cfg.taskGroup then
        return self.cfg.taskGroup;
    end
    return nil;
end

function this:GetStartTime()
    return self.cfg and self.cfg.openTime or nil;
end

function this:GetEndTime()
    return self.cfg and self.cfg.closeTime or nil;
end

function this:IsOpen()
    local sTime = self:GetStartTimeStamp();
    local eTime = self:GetEndTimeStamp();
    local cTime = TimeUtil:GetTime();
    local isOpen = false;
    if (sTime == 0 and eTime == 0) then
        isOpen = false;
    elseif (sTime ~= 0 and cTime >= sTime) then
        if (eTime ~= 0 and cTime < eTime) then
            isOpen = true
        elseif eTime == 0 then
            isOpen = true;
        end
    end
    return isOpen;
end

--检查当前是否有可领取的任务奖励
function this:HasTaskReward()
	local taskDatas = self:GetTaskList();
	if taskDatas then
		for k,v in pairs(taskDatas) do
			if v:IsFinish() and not v:IsGet() then
				return true;
			end
		end
	end
	return false;
end

function this:GetOffset()
    return self.cfg and self.cfg.pos or 0;
end

function this:GetStartTimeStamp()
    local time = 0;
    if self:GetStartTime() ~= nil then
        if type(self:GetStartTime()) == "number" then
            time = self:GetStartTime()
        else
            time = TimeUtil:GetTimeStampBySplit(self:GetStartTime())
        end
    end
    return time;
end

function this:GetEndTimeStamp()
    local time = 0;
    if self:GetEndTime() ~= nil then
        if type(self:GetEndTime()) == "number" then
            time = self:GetEndTime()
        else
            time = TimeUtil:GetTimeStampBySplit(self:GetEndTime())
        end
    end
    return time;
end

return this;
