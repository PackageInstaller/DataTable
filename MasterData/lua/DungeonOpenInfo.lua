--活动副本开启

local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:InitOpenCfg(cfg)
    self.openCfg = cfg
    if self.openCfg and self.openCfg.config and self.openCfg.nConfigID then
        if Cfgs[self.openCfg.config] == nil then
            LogError("活动入口表获取不到表数据！！！" .. self.openCfg.config)
            return 
        end
        self.cfg = Cfgs[self.openCfg.config]:GetByID(self.openCfg.nConfigID)
    end
end

function this:Init(_data)
    self.data = _data
end

function this:GetData()
    return self.data
end

function this:GetID()
    return self.data and self.data.id
end

--开启相关配置
function this:GetOpenCfg()
    return self.openCfg
end

--关联配置
function this:GetCfg()
    return self.cfg
end

function this:GetCfgID()
    return self.cfg and self.cfg.id
end

function this:GetType()
    return self.cfg and self.cfg.type
end

--活动开启
function this:IsOpen()
    if self.data and self.data.nBegTime and self.data.nEndTime then
        local time = TimeUtil:GetTime()
        return time > self.data.nBegTime and time <= self.data.nEndTime
    end
    return false
end

--副本开启
function this:IsDungeonOpen()
    if self.data and self.data.nBegTime and self.data.nBattleendTime then
        return TimeUtil:GetTime() >= self.data.nBegTime and TimeUtil:GetTime() < self.data.nBattleendTime,LanguageMgr:GetTips(24003)
    end
    return false,""
end

--困难本开启
function this:IsHardOpen()
    local timeStr = ""
    if self.openCfg and self.openCfg.hardBegTime then
        timeStr = self.openCfg.hardBegTime
    end
    if self.data and self.data.nHardBegTime and self:IsDungeonOpen()  then
        local tips = LanguageMgr:GetTips(24007, timeStr)
        return TimeUtil:GetTime() >= self.data.nHardBegTime,tips
    end
    return true,""
end

--EX本开启
function this:IsExtreOpen()
    local timeStr = ""
    if self.openCfg and self.openCfg.exBegTime then
        timeStr = self.openCfg.exBegTime
    end
    if self.data and self.data.nExBegTime and self:IsDungeonOpen() then
        local tips = LanguageMgr:GetTips(24007, timeStr)
        return TimeUtil:GetTime() >= self.data.nExBegTime,tips
    end
    return false,""
end

function this:GetTimeStrs()
    local strs = {}
    if self.cfg and self.cfg.actionTime  then
        local s1 = StringUtil:split(self.cfg.actionTime,"-")
        if #s1>1 then
            local s2 = StringUtil:split(s1[1]," ")
            if #s2 > 1 then
                table.insert(strs,s2[1])
                table.insert(strs,s2[2])
            end
            local s3 = StringUtil:split(s1[2]," ")
            if #s3 > 1 then
                table.insert(strs,s3[1])
                table.insert(strs,s3[2])
            end
        end
    end
    return strs
end

function this:GetCloseTimeStr()
    return self.cfg and self.cfg.actionCloseTime or ""
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetShopID()
    return self.cfg and self.cfg.shopID
end

function this:GetJumpID()
    return self.cfg and self.cfg.jumpId
end

function this:GetHardTime()
    return self.data and self.data.nHardBegTime
end

function this:GetStartTime()
    return self.data and self.data.nBegTime or 0
end

--获取剩余时间
function this:GetEndTime()
    return self.data and self.data.nEndTime or 0
end

function this:GetDungeonEndTime()
    return self.data and self.data.nBattleendTime or 0
end

function this:GetSectionID()
    return self.cfg and self.cfg.sectionID
end

function this:IsSelf(_sid)
    if self.cfg and _sid then
        if self.cfg.infos and #self.cfg.infos > 0 then
            for i, v in ipairs(self.cfg.infos) do
                if v.sectionID and v.sectionID == _sid then
                    return true
                end
            end
        elseif self.cfg.sectionID then
            return self.cfg.sectionID == _sid
        end
    end
    return false
end

function this:CheckIsRed()
    if self.openCfg and self.openCfg.checkRed then
        return true
    end
    return false
end
-----------------------------------------------十二星宫-----------------------------------------------
function this:GetInfos()
    local infos = {}
    if self.data and self.data.sectionTables and #self.data.sectionTables>0 then
        for k, v in pairs(self.data.sectionTables) do
            table.insert(infos,v)
        end
    end
    if #infos>0 then
        table.sort(infos,function (a,b)
            return a.id < b.id
        end)
    end
    return infos
end

--获取最近的开启关闭时间，若关闭中会向后获取最新开启时间，若开启中会向后获取最新关闭时间
function this:IsSectionOpen(sid)
    local infos = self:GetInfos()
    if sid and infos and #infos > 0 then
        for i, v in ipairs(infos) do
            if v.id == sid then
                if v.startTime > self:GetEndTime() then --防止开启时间在活动结束后
                    return false,0,0
                end
                if v.startTime <= TimeUtil:GetTime() and v.closeTime > TimeUtil:GetTime() then
                    if v.closeTime > self:GetEndTime() then --防止结束时间在活动结束后
                        return true,v.startTime,self:GetEndTime()
                    else
                        return true,v.startTime,v.closeTime
                    end
                else
                    return false,v.startTime,v.closeTime
                end
            end
        end
    end
    return false,0,0
end
-----------------------------------------------试炼-----------------------------------------------
function this:GetUpTime(sid)
    if self.upTimes and self.upTimes[sid] then
        return self.upTimes[sid] - TimeUtil:GetTime(),self.upTimes[sid]
    else
        self.upTimes = self.upTimes or {}
        local infos = self.cfg and self.cfg.infos
        if sid and infos and #infos > 0 then
            for i, v in ipairs(infos) do
                if v.sectionID == sid  then
                    if v.upStartTime and v.upEndTime then
                        local sTime = TimeUtil:GetTimeStampBySplit(v.upStartTime)
                        local eTime = TimeUtil:GetTimeStampBySplit(v.upEndTime)
                        if TimeUtil:GetTime() >= sTime and TimeUtil:GetTime() < eTime then
                            self.upTimes[sid] = eTime
                            return eTime - TimeUtil:GetTime(),sTime,eTime
                        end
                    end
                    break
                end
            end
        end
    end
    return 0,0,0
end

return this 