-- 世界boss
local this = MgrRegister("BattleFieldMgr")
BattleFieldData = require "BattleFieldData"
BattleFieldRankInfo = require "BattleFieldRankInfo"

function this:Init()
    self:Clear()
end

function this:Clear()
    self.BattleFieldInfo = nil
    self.datas = nil
    self.rewardInfo = nil
    self.bossData = nil
    self.ChangeInfo = nil
    self.rankInfos = nil
    self.cur_rank = nil
    self.max_rank = 100
    self.clearTime = nil
    self.myRank = nil
    self.isAllPass = false
end

function this:SetDatas(proto)
    -- LogError(proto)
    if proto then
        self.BattleFieldInfo = {
            id = proto.id,
            configID = proto.nConfigID,
            state = proto.state
        }
        if proto.fields then
            self.datas = self.datas or {}
            local _isAllPass = true
            for _, _data in ipairs(proto.fields) do
                local data = self.datas[_data.enemy]
                if not data then
                    data = BattleFieldData.New()
                end
                data:Init(_data)
                self.datas[_data.enemy] = data
                if _isAllPass and data:GetState() > 1 then
                    _isAllPass = false
                end
            end
            self.isAllPass = _isAllPass
            EventMgr.Dispatch(EventType.BattleField_Show_List, self.datas)
        end
    end
end

function this:GetDatas()
    return self.datas
end

-- 当前战场活动信息
function this:GetBattleFieldInfo()
    return self.BattleFieldInfo
end

-- 获取战场奖励信息
function this:GetRewardInfo(isRefresh)
    if not self.rewardInfo then
        self.rewardInfo = {}
        self.rewardInfo.cur = DungeonMgr:GetDailyData() and DungeonMgr:GetDailyData().nBattleField or 0
        self.rewardInfo.max = g_BattleFieldRewardCount or 0

        local dayDiffs = g_ActivityDiffDayTime * 3600
        self.rewardInfo.resetTime = TimeUtil:GetResetTime(dayDiffs)
    elseif isRefresh then
        self.rewardInfo.cur = DungeonMgr:GetDailyData() and DungeonMgr:GetDailyData().nBattleField or 0
    end
    return self.rewardInfo
end

function this:SetRewardInfo(_info)
    self.rewardInfo = _info
end

-- 增加已奖励次数
function this:AddRewardCur(num)
    if self.rewardInfo then
        local cur = self.rewardInfo.cur + num
        self.rewardInfo.cur = cur > self.rewardInfo.max and self.rewardInfo.max or cur
    end
end

--所有战区全压制
function this:IsAllPass()
    return self.isAllPass
end

---------------------------------------------boss----------------------------------------------

function this:SetBossData(proto)
    if proto then      
        self.bossData = proto
		EventMgr.Dispatch(EventType.BattleField_BossData_Refresh)
    end
end

function this:GetBossData()
    return self.bossData
end

function this:GetDamage()
    return self.bossData and self.bossData.nDamage
end

-- 是否有活动，开启时间和结束时间
function this:CheckIsActive()
    local isActive = false
	if self.bossData then
		local startTime = self.bossData.nBossTime or 0
		local finshTime = self.bossData.nEndTime or 0
		if startTime <= TimeUtil:GetTime() and TimeUtil:GetTime() < finshTime then
			isActive = true
		end
	end
	return isActive
end

--获取boss挑战次数信息
function this:GetBossChangeCount(isRefresh)
    if not self.ChangeInfo then
        self.ChangeInfo = {}
        self.ChangeInfo.max = g_BattleFieldBossCount or 0
        self.ChangeInfo.cur = DungeonMgr:GetDailyData() and self.ChangeInfo.max - DungeonMgr:GetDailyData().nFieldBoss or 0
    elseif isRefresh then
        self.ChangeInfo.cur = DungeonMgr:GetDailyData() and self.ChangeInfo.max - DungeonMgr:GetDailyData().nFieldBoss or 0
    end
    return self.ChangeInfo.cur,self.ChangeInfo.max
end

function this:AddBossChangeCount(num)
    if self.ChangeInfo then
        self.ChangeInfo.cur = self.ChangeInfo.cur - num
    end
end

function this:GetActivityExplain()
    if self.BattleFieldInfo then
        local cfg = Cfgs.CfgBattleField:GetByID(self.BattleFieldInfo.configID)
        if cfg then
            return cfg.desc
        end
    end
    return ""
end

function this:GetBossBuffs()
    local buffs = {}
    if self.datas then
        for k, v in pairs(self.datas) do
            local buff = {
                id = v:GetID(),
                desc = v:GetBuffDesc(),
                isGet = v:GetState() == 1
            }
            table.insert(buffs,buff)
        end
    end
    table.sort(buffs,function (a,b)
        return a.id < b.id
    end)
    return buffs
end

-- 退出战斗，返回演习界面
function this:Quit()
    SceneLoader:Load("MajorCity", function()
        local id = nil
        if self.bossData and self.bossData.nBossID then
            local cfg = Cfgs.MainLine:GetByID(self.bossData.nBossID)
            id = cfg.group
        end
        CSAPI.OpenView("BattleField",{id = id})
        PlayerProto:GetBattleBossData()
    end)
end

---------------------------------------------rank----------------------------------------------
function this:GetRankRewards()
    
end

function this:ClearRankData()
	if(not self.clearTime) then
		self.clearTime = Time.time + 1800
	else 
		if(Time.time>self.clearTime) then 
			self.cur_rank = 0 
			self.rankInfos = 0 
			self.clearTime = Time.time + 1800
		end 
	end
end

function this:GetBossRank(idx)
    PlayerProto:GetBattleBossRank(idx)
end

function this:GetBossRankRet(proto)
    if proto then
        if(proto.data and #proto.data > 0) then
            self.rankInfos = self.rankInfos or {}
            for k, v in ipairs(proto.data) do
                local info = BattleFieldRankInfo.New()
                info:Init(v)
                self.rankInfos[v.rank] = info
            end
        end
        self.myRank = proto.rank or self.myRank
    end
    EventMgr.Dispatch(EventType.BattleField_BossRank_Info)
end

function this:GetRankInfos()
    local arr = {}
    if self.rankInfos then
        for i, v in pairs(self.rankInfos) do
            table.insert(arr, v)
        end      
    end
    if(#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end	
	self.cur_rank = #arr
	return arr
end

function this:AddNextRankList()
	self.cur_rank = self.cur_rank or 0
	self.max_rank = self.max_rank or g_ArmyRankNumMax
	if(self.cur_rank < (self.max_rank - 1)) then
        local curPage = math.modf((self.cur_rank / 11) + 1)
        curPage = curPage + 1 > 10 and curPage or curPage + 1
		self:GetBossRank(curPage)
	end
end

function this:GetMyRank()
    local data = {
        id = PlayerClient:GetUid(),
        name = PlayerClient:GetName(),
        level = PlayerClient:GetLv(),
        rank = self.myRank or 101,
        icon_id = PlayerClient:GetIconId(),
        nDamage = self:GetDamage()
    }
    local info = BattleFieldRankInfo.New()
    info:Init(data)
    return info
end

return this
