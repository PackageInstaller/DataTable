local this=MgrRegister("GuildFightMgr")

--公会战个人数据
function this:SetGFData(proto)
    self.gfData=proto.plr_info;
    self.inRange=proto.inRange;
end

function this:GetGFData()
    return self.gfData or nil;
end

--公会战排名数据
function this:SetGFRankData(proto)
    self.gfRankData=proto.guild_info
end

function this:GetGFRankData()
    return self.gfRankData or nil;
end

--初始化公会战配置信息
function this:InitGFDatas()
    self.gfList={};
    for k,v in pairs(Cfgs.CfgGuildFightSchedule:GetAll()) do
        local gf=GuildFightData.New();
        gf:SetCfgID(v.id);
        table.insert(self.gfList,gf);
    end
end

--进入公会战主界面
function this:EnterGFMain()
    local guildData=GuildMgr:GetGuildInfo();
    if guildData then
        local currGFData=self:GetCurrGFData();
        if self.inRange or (currGFData and currGFData:CanJoin()) then
            CSAPI.OpenView("GuildFightMain");
        elseif (currGFData and currGFData:GetState()==-1) then
            Tips.ShowTips("公会战还没有开启，无法进入");
        elseif self.inRange~=true then
            Tips.ShowTips("没有参加公会战预赛，无法进行正赛");
        end
    end
end

--返回当前赛季信息
function this:GetCurrGFData()
    if self.gfList==nil then
        self:InitGFDatas();
    end
    for k,v in ipairs(self.gfList) do
        if v:IsOpen() then
            return v;
        end
    end
    return nil;
end

--根据分组id返回分组配置表
function this:GetGroupCfg(gfId,cfgId)
    local cfg= nil;
    if gfId and cfgId and Cfgs.CfgGuildFightGroup:GetByID(gfId)~=nil then 
        local cfgs=Cfgs.CfgGuildFightGroup:GetByID(gfId)
        for k,v in ipairs(cfgs.infos) do
            if v.index==cfgId then
                cfg=v;
                break
            end
        end 
    end
    return cfg;
end

--添加战场房间信息
function this:AddGFRooms(proto)
    if proto.first then
        self.gfRooms={};
    else
        self.gfRooms=self.gfRooms or {};
    end
    local currGFData=self:GetCurrGFData();
    local gfID=currGFData and currGFData:GetID() or nil;
    local isMine=false;
    for k,v in ipairs(proto.rooms) do
        local room=GuildRoomData.New();
        room:SetData(v,gfID);
        table.insert(self.gfRooms,room);
        isMine = v.c_id ==PlayerClient:GetID();
    end
    if proto.last then
        EventMgr.Dispatch(EventType.Guild_Rooms_Update,{isCreate=isMine,rooms=self.gfRooms});
    end
end

--更新战场房间信息
function this:GFRoomsUpdate(proto)
    if proto and proto.infos then
        for k,v in ipairs(proto.infos) do
            local length=#self.gfRooms;
            for i=1,length do
                local room=self.gfRooms[i];
                if room and room:GetID()==v.id then
                    room.data.cur_hp=v.cur_hp;
                    if v.cur_hp==0 then --当前HP==0表示该房间战斗已结束
                        table.remove(self.gfRooms,i);
                    end
                    break;
                end 
            end  
        end
        EventMgr.Dispatch(EventType.Guild_Rooms_Update,{isCreate=false,rooms=self.gfRooms});
    end
end

--判断有没有创建过对应类型的房间
function this:IsCreateRoom(index)
    if self.gfRooms then
        for k,v in ipairs(self.gfRooms) do
            if index and v:GetCfg().index==index then
                return v:GetCreaterID()==PlayerClient:GetID();
            end
        end
    end
end

--上一轮公会战结果
function this:SetLastRoundResult(isWin)
    self.lastRoundResult=isWin;
end

function this:GetLastRoundResult()
    return self.lastRoundResult;
end

--返回支援的房间列表
function this:GetGFRooms()
    return self.gfRooms or {};
end

--记录当前战斗的房间ID
function this:SetCurrFightRoomID(id)
    self.currFightRoomID=id;
end

--返回当前战斗的房间信息
function this:GetCurrFightRoomInfo()
    if self.gfRooms then
        for k,v in ipairs(self.gfRooms) do
            if v:GetID()==self.currFightRoomID then
                return v;
            end
        end
    end
end

--房间战斗结束返回
function this:FightQuit()
    self.currFightRoomID=nil;
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("GuildMain");
        CSAPI.OpenView("GuildFightMain",nil,GuildFightMainOpenType.RoomListBattle);
        -- self:EnterGFMain()
    end)
end

function this:Clear()
    self.gfRooms=nil;
    self.gfData=nil;
    self.currFightRoomID=nil;
end

return this;