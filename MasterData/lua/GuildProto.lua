--公会协议
GuildProto={}

--搜索公会信息
function GuildProto:Search(id)
    local proto = {"GuildProto:Search", {id=id}}
	NetMgr.net:Send(proto);
end

function GuildProto:SearchRet(proto)
    EventMgr.Dispatch(EventType.Guild_Recoment_Update,{list=proto.info});
end

--获取推荐列表
function GuildProto:Recoment(isRefresh)
    local proto = {"GuildProto:Recoment",{flush=isRefresh==true}}
    if isRefresh==true then
        GuildMgr:SetRecomentTime(); --记录刷新列表时间
    end
	NetMgr.net:Send(proto);
end

function GuildProto:RecomentRet(proto)
    EventMgr.Dispatch(EventType.Guild_Recoment_Update,{list=proto.info,isRecoment=true});
end

--发送加入公会申请
function GuildProto:Join(id)
    local proto = {"GuildProto:Join",{id=id}}
	NetMgr.net:Send(proto);
end

function GuildProto:JoinRet(proto)--这个方法只返回申请记录，不代表玩家已经成功加入工会
    --缓存申请记录
    GuildMgr:AddRequestInfo(proto.info);
    EventMgr.Dispatch(EventType.Guild_ApplyLog_Update,proto.info);
end

--取消申请
function GuildProto:CancleApply(id)
    local proto = {"GuildProto:CancleApply",{id=id}}
	NetMgr.net:Send(proto);
end

function GuildProto:CancleApplyRet(proto)
    --删除缓存
    GuildMgr:RemoveRequestInfo(proto.id);
    EventMgr.Dispatch(EventType.Guild_Apply_Cancel,proto.id);
end

--创建工会
function GuildProto:Create(data)
    local proto = {"GuildProto:Create",{info=data}}
	NetMgr.net:Send(proto);
end

function GuildProto:CreateRet(proto)
    GuildMgr:SetData({info=proto.info,title=GuildMemberType.Boss});
    if proto and proto.info then
        --设置当前公会ID
        -- PlayerClient:SetGuildID(proto.info.id);
        CSAPI.CloseAllOpenned()
        --刷新界面，进入主界面
        JumpMgr:Jump(170001);
    end
end

--公会转让
function GuildProto:SetBoss(uid)
    local proto = {"GuildProto:SetBoss",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:SetBossRet(proto)
   --设置最新的权限
   GuildMgr:SetTitle(GuildMemberType.Normal);
   if GuildMgr.guildData then
        GuildMgr.guildData.n_uid=proto.uid;
        GuildMgr.guildData.n_name=proto.name;
   end
   --刷新UI
   EventMgr.Dispatch(EventType.Guild_Info_Refresh)
   EventMgr.Dispatch(EventType.Guild_MemTitle_Change,{{uid=proto.uid,title=GuildMemberType.Boss},{uid=PlayerClient:GetUid(),title=GuildMemberType.Normal}});
end

--设置副会长
function GuildProto:SetSubBoss(uid)
    local proto = {"GuildProto:SetSubBoss",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:SetSubBossRet(proto)
    EventMgr.Dispatch(EventType.Guild_MemTitle_Change,{{uid=proto.uid,title=GuildMemberType.SubBoss}});
end

--移除公会成员
function GuildProto:DelMem(uid)
    local proto = {"GuildProto:DelMem",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:DelMemRet(proto)
    if GuildMgr.guildData then
        GuildMgr.guildData.mem_cnt=GuildMgr.guildData.mem_cnt-1;
    end
    EventMgr.Dispatch(EventType.Guild_GuildMem_Change,{uid=proto.uid,isRemove=true});
end

--处理玩家加入申请
function GuildProto:ApplyOp(uid,isOK)
    local proto = {"GuildProto:ApplyOp",{uid=uid,is_allow=isOK}}
	NetMgr.net:Send(proto);
end

function GuildProto:ApplyOpRet(proto)
    EventMgr.Dispatch(EventType.Guild_GuildApply_Return,proto);
end

--查看会员信息
function GuildProto:MemberInfo(uid)
    local proto = {"GuildProto:MemberInfo",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:MemberInfoRet(proto)
    EventMgr.Dispatch(EventType.Guild_GuildMem_Info,proto);
end

--退出公会
function GuildProto:Quit()
    local proto = {"GuildProto:Quit"}
	NetMgr.net:Send(proto);
end

function GuildProto:QuitRet()
    GuildProto:ClearGuild()
    CSAPI.CloseAllOpenned();
end

--修改公会设置
function GuildProto:ModInfo(info)
    local proto = {"GuildProto:ModInfo",{info=info}}
	NetMgr.net:Send(proto);
end

function GuildProto:ModInfoRet(proto)
    --刷新缓存
    GuildMgr:UpdateGuildInfo(proto.info);
    EventMgr.Dispatch(EventType.Guild_Info_Refresh);
end

--查看玩家队伍
function GuildProto:LookTeam(uid)
    local proto = {"GuildProto:LookTeam",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:LookTeamRet(proto)
    EventMgr.Dispatch(EventType.Guild_MemTeam_Info,proto);
end

--查看自己的申请记录
function GuildProto:LookPlrApplyLog()
    local proto = {"GuildProto:LookPlrApplyLog"}
	NetMgr.net:Send(proto);
end

function GuildProto:LookPlrApplyLogRet(proto)
    GuildMgr:SetMineApplyLog(proto);
end

--查看公会的申请记录
function GuildProto:LookGuildApplyLog()
    local proto = {"GuildProto:LookGuildApplyLog"}
	NetMgr.net:Send(proto);
end

function GuildProto:LookGuildApplyLogRet(proto)
    EventMgr.Dispatch(EventType.Guild_GuildApply_Update,proto.infos);
end

--服务器通知申请公会结果
function GuildProto:ApplyRetNotice(proto)
    if proto and proto.is_join==true then
        --获取公会信息
        GuildProto:GuildInfo();
        EventMgr.Dispatch(EventType.Guild_ApplyRet_Notice);
    end
end

--公会成员列表
function GuildProto:MemberList()
    local proto = {"GuildProto:MemberList"}
	NetMgr.net:Send(proto);
end

function GuildProto:MemberListRet(proto)
    EventMgr.Dispatch(EventType.Guild_GuildMem_Update,proto.members);
end

--解散公会
function GuildProto:DelGuild()
    local proto = {"GuildProto:DelGuild"}
	NetMgr.net:Send(proto);
end

function GuildProto:DelGuildRet()
    GuildProto:ClearGuild();
end

--获取公会信息
function GuildProto:GuildInfo()
    local proto = {"GuildProto:GuildInfo"}
	NetMgr.net:Send(proto);
end

function GuildProto:GuildInfoRet(proto)
    GuildMgr:SetData(proto);
    EventMgr.Dispatch(EventType.Guild_Info_Refresh);
end

--取消副会长权限
function GuildProto:UnSetSubBoss(uid)
    local proto = {"GuildProto:UnSetSubBoss",{uid=uid}}
	NetMgr.net:Send(proto);
end

function GuildProto:UnSetSubBossRet(proto)
    EventMgr.Dispatch(EventType.Guild_MemTitle_Change,{{uid=proto.uid,title=GuildMemberType.Normal}});
end

--申请通知
function GuildProto:JoinNotice(proto)
    EventMgr.Dispatch(EventType.Guild_GuildApply_Add);
end

--通过申请通知
function GuildProto:AllowNotice(proto)
    if GuildMgr.guildData then
        GuildMgr.guildData.mem_cnt=GuildMgr.guildData.mem_cnt+1;
    end
    EventMgr.Dispatch(EventType.Guild_GuildMem_Change,{uid=proto.uid,isRemove=false});
end

--离开通知
function GuildProto:LeaveNotice(proto)
    if GuildMgr.guildData then
        GuildMgr.guildData.mem_cnt=GuildMgr.guildData.mem_cnt-1;
    end
    EventMgr.Dispatch(EventType.Guild_GuildMem_Change,{uid=proto.uid,isRemove=true});
end

--服务器通知被踢的信息
function GuildProto:DelNotice(proto)
    EventMgr.Dispatch(EventType.Guild_GuildMem_Change,{uid=PlayerClient:GetUid(),isRemove=true});
    GuildProto:ClearGuild()
end

--服务器通知公会解散的消息
function GuildProto:DelGuildNotice()
    EventMgr.Dispatch(EventType.Guild_GuildMem_Change,{uid=PlayerClient:GetUid(),isRemove=true});
    GuildProto:ClearGuild();
end

--权限变更
function GuildProto:MemberUpdateNotice(proto)
    if proto then
        for k,v in ipairs(proto.infos) do 
            if v.uid==PlayerClient:GetUid() then--自身的职位变更
                GuildMgr:SetTitle(v.title);
            end
            if v.title==GuildMemberType.Boss and GuildMgr.guildData~=nil then --会长变更
                GuildMgr.guildData.n_uid=v.uid;
                GuildMgr.guildData.n_name=v.name;
            end
        end
    end
    EventMgr.Dispatch(EventType.Guild_MemTitle_Change,proto.infos);
end

function GuildProto:ClearGuild()
    GuildMgr:ClearGuildInfo();
end

--------------------------------------------------公会战协议--------------------------------------
--获取公会战数据
function GuildProto:GFinfo(callBack)
    local proto = {"GuildProto:GFinfo"}
    self.gfInfoBack=callBack;
	NetMgr.net:Send(proto);
end

function GuildProto:GFinfoRet(proto)
    GuildFightMgr:SetGFData(proto);
    GuildFightMgr:SetGFRankData(proto);
    EventMgr.Dispatch(EventType.Guild_FightInfo_Update);
    if self.gfInfoBack then
        self.gfInfoBack(proto)
    end
end

--获取开放的房间
function GuildProto:GFRooms()
    local proto = {"GuildProto:GFRooms"}
	NetMgr.net:Send(proto);
end

--获取开放的房间信息
function GuildProto:GFRoomsAdd(proto)
    GuildFightMgr:AddGFRooms(proto)
end

--获取个人记录
function GuildProto:GFSelfFightLog(index)
    index=index or 1;
    local proto = {"GuildProto:GFSelfFightLog",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFSelfFightLogRet(proto)
    EventMgr.Dispatch(EventType.Guild_LogInfo_Ret,proto); 
end

--获取公会记录返回
function GuildProto:GFGuildFightLog(index)
    index=index or 1;
    local proto = {"GuildProto:GFGuildFightLog",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFGuildFightLogRet(proto)
    EventMgr.Dispatch(EventType.Guild_LogInfo_Ret,proto); 
end

--获取公会全局排名
function GuildProto:GFGuildGobalRank(index)
    index=index or 1;
    local proto = {"GuildProto:GFGuildGobalRank",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFGuildGobalRankRet(proto)
   EventMgr.Dispatch(EventType.Guild_RankInfo_Ret,proto); 
end

--获取公会分组内排名
function GuildProto:GFGuildGroupRank(index)
    index=index or 1;
    local proto = {"GuildProto:GFGuildGroupRank",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFGuildGroupRankRet(proto)
    EventMgr.Dispatch(EventType.Guild_RankInfo_Ret,proto); 
end

--获取公会内会员的排名
function GuildProto:GFMemberGuildRank(index)
    index=index or 1;
    local proto = {"GuildProto:GFMemberGuildRank",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFMemberGuildRankRet(proto)
    EventMgr.Dispatch(EventType.Guild_RankInfo_Ret,proto); 
end

--获取公会成员全局排名
function GuildProto:GFMemberGobalRank(index)
    index=index or 1;
    local proto = {"GuildProto:GFMemberGobalRank",{ix=index}}
	NetMgr.net:Send(proto);
end

function GuildProto:GFMemberGobalRankRet(proto)
    EventMgr.Dispatch(EventType.Guild_RankInfo_Ret,proto); 
end

--加入房间（开始战斗）
function GuildProto:GFJoinRoom(roomId,roomCfgId)
    local proto={"GuildProto:GFJoinRoom",{id=roomId,cfg_id=roomCfgId}}
    NetMgr.net:Send(proto);
end

--房间信息更新
function GuildProto:GFRoomsUpdate(proto)
    GuildFightMgr:GFRoomsUpdate(proto);
end

--创建房间
function GuildProto:GFCreateRoom(roomCfgId,type)
    local proto={"GuildProto:GFCreateRoom",{cfg_id=roomCfgId,type=type}}
    NetMgr.net:Send(proto);
end

--公会战信息更新
function GuildProto:GFInfoUpdate(proto)
    if proto then
        if proto.guild_info then
            GuildFightMgr:SetGFRankData(proto);
        end
        if proto.plr_info then
            GuildFightMgr.gfData=proto.plr_info;
        end
        GuildFightMgr:SetLastRoundResult(proto.is_win);
        EventMgr.Dispatch(EventType.Guild_FightInfo_Update);
    end
end

--获取公会战进程(暂时无用)
function GuildProto:GFSchedue()
    local proto={"GuildProto:GFCreateRoom"}
    NetMgr.net:Send(proto);
end

--获取公会战进程返回
function GuildProto:GFSchedueRet(proto)

end

--公会战房间BOSS血量更新
function GuildProto:GFRoomUpdateHp(proto)
    GuildFightMgr:GFRoomsUpdate(proto);
end