--公会战赛季配置数据
local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:SetCfgID(cfgId)
    if cfgId then
        local cfg=Cfgs.CfgGuildFightSchedule:GetByID(cfgId);
        if cfg then
            self.cfg=cfg;
        else
            LogError("未找到赛季配置信息！");
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

--是否开启
function this:IsOpen()
    if self.cfg then
        local currTime=CSAPI.GetServerTime();
        local startTime=GCalHelp:CalTimeByArr(self.cfg.openTime);
        local endTime=GCalHelp:CalTimeByArr(self.cfg.closeTime);
        if currTime>=startTime and currTime<endTime then
            return true
        end
    end
    return false
end

--返回当前赛季阶段配置信息
function this:GetStateCfg()
    local infoCfg=nil;
    if self.cfg then
        local currTime=CSAPI.GetServerTime();
        for k,v in ipairs(self.cfg.infos) do
            local sTime=GCalHelp:CalTimeByArr(v.startTime);
            local eTime=GCalHelp:CalTimeByArr(v.endTime);
            if currTime>=sTime and currTime<eTime then
                infoCfg=v;
                break;
            end
        end
    end
    return infoCfg;
end

--返回赛季阶段 --0:代表准备阶段，-1代表结束，1代表预选，>1代表正赛
function this:GetState()
    local state=-1;
    local currTime=CSAPI.GetServerTime();
    local starTime=GCalHelp:CalTimeByArr(self.cfg.openTime);
    local endTime=GCalHelp:CalTimeByArr(self.cfg.closeTime);
    Log(self.cfg.title);
    for k,v in ipairs(self.cfg.infos) do
        local sTime=GCalHelp:CalTimeByArr(v.startTime);
        local eTime=GCalHelp:CalTimeByArr(v.endTime);
        Log(TimeUtil:GetTimeStr2(currTime).."\t"..TimeUtil:GetTimeStr2(sTime).."\t"..TimeUtil:GetTimeStr2(eTime));
        if v.index==1 and currTime>starTime and currTime<sTime then --准备阶段
            state=0;
            break;
        elseif currTime>=sTime and currTime<eTime then
            state=v.index;
            break;
        end
    end
    return state;
end

--当前阶段是否可以参与当前赛季
function this:CanJoin()
    if self.cfg then
        local state=self:GetState()
        if state==0 or state==1 then
            return true --只有准备阶段和预选战阶段可以参与当前赛季
        end
    end
    return false;
end

function this:GetTitle()
    return self.cfg.title;
end

function this:GetStartTime()
    return GCalHelp:CalTimeByArr(self.cfg.openTime);
end

function this:GetEndTime()
    return GCalHelp:CalTimeByArr(self.cfg.closeTime);
end

function this:GetRoomList()
    local list={}
    if self.cfg then
        local roomCfg=Cfgs.CfgGuildFightRoom:GetByID(self.cfg.id);
        if roomCfg then
            for k,v in ipairs(roomCfg.infos) do
                local room=GuildRoomData.New();
                room:SetCfgID(self.cfg.id,v.index);
                table.insert(list,room);
            end
        end
    end
    return list;
end
return this;