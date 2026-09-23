--公会数据管理
local this=MgrRegister("GuildMgr")

function this:SetData(proto)
    self.guildData=proto.info;
    self.title=proto.title;
end

function this:UpdateGuildInfo(data)
    if self.guildData and data then
        self.guildData.name=data.name or self.guildData.name
        self.guildData.icon=data.icon or self.guildData.icon;
        self.guildData.activity_type=data.activity_type or self.guildData.activity_type;
        self.guildData.mem_cnt=data.mem_cnt or self.guildData.mem_cnt;
        self.guildData.n_uid=data.n_uid or self.guildData.n_uid;
        self.guildData.n_name=data.n_name or self.guildData.n_name;
        self.guildData.rank=data.rank or self.guildData.rank;
        self.guildData.ratify_type=data.ratify_type or self.guildData.ratify_type;
        self.guildData.apply_lv=data.apply_lv or self.guildData.apply_lv;
        self.guildData.desc=data.desc or self.guildData.desc;
        self.guildData.open_score_add=data.open_score_add or self.guildData.open_score_add;
    end
end

--设置申请记录
function this:SetMineApplyLog(proto)
    self.applyLog=proto.infos;
end

function this:AddRequestInfo(data)
    self.applyLog=self.applyLog or {};
    if data then
        local hasLog=false;
        for k,v in ipairs(self.applyLog) do
            if v.id==data.id then
                hasLog=true;
                break;
            end
        end
        if hasLog~=true then
            table.insert(self.applyLog,data);
        end
    end
end

function this:RemoveRequestInfo(id)
    if self.applyLog then
        for k,v in ipairs(self.applyLog) do
            if v.id==id then
                table.remove(self.applyLog,k);
                break;
            end
        end
    end
end

function this:GetMineApplyLog()
    return self.applyLog or {};
end

--是否存在某个公会的申请记录
function this:HasRequestInfo(id)
    local has=false;
    if self.applyLog then
        for k,v in ipairs(self.applyLog) do
            if v.id==id then
                has =true;
                break;
            end
        end
    end
    return has;
end

--返回当前公会的信息
function this:GetGuildInfo()
    return self.guildData
end

function this:SetTitle(title)
    self.title=title;
end

--返回职务
function this:GetTitle()
    return self.title;
end

--清空当前公会信息
function this:ClearGuildInfo()
    self.guildData=nil;
    self.title=nil;
end

--还能否加入工会
function this:CanJoinGuild()
    return self.guildData==nil;
end

--设置上次刷新的时间
function this:SetRecomentTime()
    self.lRecomentTime=CSAPI.GetServerTime();
end

function this:GetRecomentTime()
    return self.lRecomentTime;
end

function this:Clear()
    this:ClearGuildInfo()
    self.lRecomentTime=nil;
    self.protoIndex=nil;
end

return this;