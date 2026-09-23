local state=nil;
local slider=nil;
local currGFData=nil;--当前赛季数据
local endTime=nil; --结束时间
local isOpen=true;
local roomList={};--房间信息
function Awake()
    UIUtil:AddTop2("GuildFightMain", gameObject, OnClickReturn)
    --UIUtil:AddTop(gameObject, OnClickReturn)
    slider=ComUtil.GetCom(sliderBar,"Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_FightInfo_Update, OnInfoRefresh);
    eventMgr:AddListener(EventType.Guild_Info_Refresh, OnGuildInfoRefresh);
    eventMgr:AddListener(EventType.Guild_Rooms_Update,OnRoomsUpdate)
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    if openSetting==nil or openSetting==GuildFightMainOpenType.Main then
    elseif openSetting==GuildFightMainOpenType.RoomListOpen then
        CSAPI.OpenView("GuildBattleField",nil,1);
    elseif openSetting==GuildFightMainOpenType.RoomListBattle then
        CSAPI.OpenView("GuildBattleField",nil,2);
    elseif openSetting==GuildFightMainOpenType.RankList then
        OnClickRank()
    elseif openSetting==GuildFightMainOpenType.RankScore then
        OnClickScore();
    end
    -- Refresh();
end

function OnGuildInfoRefresh()
    local guildInfo=GuildMgr:GetGuildInfo();
    SetToggleState(guildInfo.open_score_add)
    if guildInfo.open_score_add==BoolType.Yes then
        CSAPI.SetText(txt_scoreType,LanguageMgr:GetByID(27025));
    else
        CSAPI.SetText(txt_scoreType,LanguageMgr:GetByID(27026));
    end
end

--公会战信息更新
function OnInfoRefresh()
    Refresh()
end

--房间信息更新
function OnRoomsUpdate()
    roomList=GuildFightMgr:GetGFRooms();
end

function SetGuildRank(rank)
    if rank~=nil and rank~=0 then
        CSAPI.SetText(txt_gfRank,tostring(rank));
        CSAPI.SetText(txt_rankTips2,LanguageMgr:GetByID(27028));
    else
        CSAPI.SetText(txt_gfRank,"");
        CSAPI.SetText(txt_rankTips2,LanguageMgr:GetByID(27027));
    end
end

function Refresh()
    if GuildMgr:GetTitle()==GuildMemberType.Normal then
        CSAPI.SetGOActive(btn_scoreToggle,false);
    else
        CSAPI.SetGOActive(btn_scoreToggle,true);
    end
    local guildInfo=GuildMgr:GetGuildInfo();
    if guildInfo==nil then
        LogError("获取不到公会信息！！！");
        return
    end
    RefreshMineInfo();
    SetToggleState(guildInfo.open_score_add)
    if guildInfo.open_score_add==BoolType.Yes then
        CSAPI.SetText(txt_scoreType,LanguageMgr:GetByID(27025));
    else
        CSAPI.SetText(txt_scoreType,LanguageMgr:GetByID(27026));
    end
    if guildInfo.guild_info~=nil and guildInfo.guild_info.group_rank~=nil and guildInfo.guild_info.group_rank~=0 then
        SetGuildRank(guildInfo.guild_info.group_rank);
    else
        SetGuildRank();
    end
    --判断活动是否开启
    currGFData=GuildFightMgr:GetCurrGFData() --当前赛季的信息
    if currGFData then
        isOpen=true;
        if next(roomList)==nil then--没有房间信息则请求一次
            GuildProto:GFRooms();
        end
        endTime=currGFData:GetEndTime()
        CSAPI.SetText(txt_fightName,currGFData:GetTitle());
        CSAPI.SetText(txt_openTime,TimeUtil:GetTimeHMS(currGFData:GetStartTime(),"%Y-%m-%d").."~"..TimeUtil:GetTimeHMS(endTime,"%Y-%m-%d"))
        local infoCfg=currGFData:GetStateCfg();
        if infoCfg then --阶段
            CSAPI.SetText(txt_state,infoCfg.name);
        else
            CSAPI.SetText(txt_state,"关闭中");
        end
        RefreshPreView(infoCfg)
        SetGuildRank(guildInfo.rank);
        if  guildInfo.guild_info~=nil and guildInfo.guild_info.group_id and guildInfo.guild_info.group_id~=0  then
            local gCfg=GuildFightMgr:GetGroupCfg(currGFData:GetID(),guildInfo.guild_info.group_id);
            CSAPI.SetText(txt_group,gCfg.rankGroup);
            CSAPI.SetGOActive(groupObj,true);
        else
            CSAPI.SetGOActive(groupObj,false);
        end
    else
        CSAPI.SetText(txt_fightName,"");
        CSAPI.SetText(txt_openTime,"")
        RefreshPreView(nil)
    end
end

--刷新实时信息板
function RefreshPreView()
    if currGFData==nil or currGFData:GetStateCfg()==nil then
        CSAPI.SetGOActive(txt_none,true);
        CSAPI.SetGOActive(preInfo,false);
        CSAPI.SetGOActive(pkInfo,false);
        return
    end
    local infoCfg=currGFData:GetStateCfg();
    CSAPI.SetGOActive(txt_none,false);
    CSAPI.SetGOActive(preInfo,infoCfg.index==1);
    CSAPI.SetGOActive(pkInfo,infoCfg.index~=1);
    local guildInfo=GuildMgr:GetGuildInfo();
    local info=GuildFightMgr:GetGFData();
    Log(infoCfg.index);
    if infoCfg.index==1 then--预赛显示当前自身公会的信息
        LoadIcon(guildIcon,guildInfo.icon);
        CSAPI.SetText(txt_guildName,guildInfo.name);
        local addNum=info and info.sum_score or 0;
        CSAPI.SetText(txt_currAdd,tostring(addNum));
    else--正赛显示自身公会和本场对比的公会信息
        if info==nil or(info and info.guild_score==nil) then
            LogError("未获取到公会战信息！");
            CSAPI.SetGOActive(txt_none,true);
            CSAPI.SetGOActive(preInfo,false);
            CSAPI.SetGOActive(pkInfo,false);
            do return end
        end
        LoadIcon(lGuildIcon,guildInfo.icon);
        LoadIcon(rGuildIcon,info.guild_icon);
        local total=info.sum_score+info.guild_score;
        local p1=(info.sum_score/total)*100
        local p2=(info.guild_score/total)*100
        CSAPI.SetText(txt_lName,guildInfo.name);
        CSAPI.SetText(txt_lVal,tostring(info.sum_score));
        CSAPI.SetText(txt_lsVal,string.format("%.1f",p1).."%");
        CSAPI.SetText(txt_rName,info.guild_name);
        CSAPI.SetText(txt_rVal,tostring(info.guild_score));
        CSAPI.SetText(txt_rsVal,string.format("%.1f",p2).."%");
        slider.fillAmount=p1;
    end
end

--刷新个人积分信息
function RefreshMineInfo()
    CSAPI.SetText(txt_name,PlayerClient:GetName());
    local info=GuildFightMgr:GetGFData();
    if info==nil then
        CSAPI.SetText(txt_dayAddVal,"0");
        CSAPI.SetText(txt_allAddVal,"0");
        CSAPI.SetText(txt_rankVal,"0");
        CSAPI.SetText(txt_guildRankVal,"0");
    else
        CSAPI.SetText(txt_dayAddVal,info.today_score==nil and "0" or tostring(info.today_score));
        CSAPI.SetText(txt_allAddVal,info.sum_score==nil and "0" or tostring(info.sum_score));
        CSAPI.SetText(txt_rankVal,info.sum_rank==nil and "0" or tostring(info.sum_rank));
        CSAPI.SetText(txt_guildRankVal,info.rank==nil and "0" or tostring(info.rank));
    end
    local pos, scale, imgName = RoleTool.GetImgPosScale(PlayerClient:GetIconId(), LoadImgType.Main);  --todo 位置可能不对
    if(pos) then
        pos.x=pos.x/3
        pos.y=pos.y/3-30;
        ResUtil.ImgCharacter:Load(roleImg, imgName);
        ResUtil.ImgCharacter:SetPos(roleImg,pos);
        ResUtil.ImgCharacter:SetScale(roleImg, 0.333);
    end
end

--刷新房间列表
function RefreshRoomsInfo()
    local isClose=currGFData==nil;
    CSAPI.SetGOActive(txt_battleNumTips,not isClose);
    CSAPI.SetGOActive(txt_timeTips,not isClose);
    CSAPI.SetGOActive(txt_dungeonName,not isClose);
    CSAPI.SetGOActive(txt_lock,isClose);
    if isClose then
        return
    end
    CSAPI.SetText(txt_dungeonName,"古代战场");
    CSAPI.SetText(txt_battleNum,#roomList);
end

function Update()
    if endTime and isOpen then
        local timer=endTime-CSAPI.GetServerTime();
        if timer>=0 then
            CSAPI.SetText(txt_time,TimeUtil:GetTimeHMS(timer,"%H:%M:%S"));
        else
            isOpen=false;
        end
        local infoCfg=currGFData:GetStateCfg();
        if infoCfg then --阶段 --需要记录阶段，时间到了需要刷新界面
            CSAPI.SetText(txt_state,infoCfg.name);
        else
            CSAPI.SetText(txt_state,"关闭中");
        end
    end
end

function LoadIcon(go,iconId)
    if iconId then
        local cfg=Cfgs.character:GetByID(iconId)
        if cfg then
            ResUtil.RoleCard:Load(go, cfg.icon)
        end
    else
        CSAPI.SetRectSize(go,0,0,0);
    end
end

--公会商店
function OnClickShop()

end

--奖励说明
function OnClickReward()
    CSAPI.OpenView("GuildReward/GuildRewardView")
end

--排名
function OnClickRank()
    CSAPI.OpenView("GuildRankList");
end

--个人战绩
function OnClickScore()
    CSAPI.OpenView("GuildBattleResult",nil,2);
end

--公会战绩
function OnClickGuildScore()
    CSAPI.OpenView("GuildBattleResult",nil,1);
end

--点击房间列表
function OnClickRoom()
    if currGFData then
        local state=currGFData:GetState();
        if state>=1 then --阶段
            CSAPI.OpenView("GuildBattleField",nil,1);
        elseif state==0 then
            Tips.ShowTips("当前赛季正处于准备阶段");
        elseif state==-1 then
            Tips.ShowTips("当前赛季阶段已结束");
        end
    end
end

--开启/关闭贡献
function OnClickScoreToggle()
    local guildInfo=GuildMgr:GetGuildInfo();
    local info={
        open_score_add = guildInfo.open_score_add==BoolType.No and BoolType.Yes or BoolType.No,
    };
    if (GuildMgr:GetTitle()==GuildMemberType.Boss or GuildMgr:GetTitle()==GuildMemberType.SubBoss) and next(info)~=nil then
        GuildProto:ModInfo(info);
    end
end

function SetToggleState(state)
    CSAPI.SetText(txt_toggleState,state==1 and LanguageMgr:GetByID(27017) or LanguageMgr:GetByID(27018));
end

function OnClickReturn()
    Close();
end

function Close()
    view:Close();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
leftTopObj=nil;
txt_gfRank=nil;
txt_rankTips2=nil;
groupObj=nil;
txt_group=nil;
btn_rank=nil;
stateObj=nil;
txt_state=nil;
scoreObj=nil;
txt_scoreType=nil;
btn_scoreToggle=nil;
txt_toggleState=nil;
rightTopObj=nil;
btn_shop=nil;
btn_reward=nil;
txt_fightName=nil;
txt_openTime=nil;
infos=nil;
txt_none=nil;
preInfo=nil;
guildIcon=nil;
txt_nameTips=nil;
txt_guildName=nil;
txt_currAddTips=nil;
txt_currAdd=nil;
pkInfo=nil;
lGuildIcon=nil;
rGuildIcon=nil;
txt_lName=nil;
txt_rName=nil;
txt_vs=nil;
sliderBar=nil;
txt_lsVal=nil;
txt_rsVal=nil;
txt_lVal=nil;
txt_rVal=nil;
details=nil;
txt_battleNumTips=nil;
txt_battleNum=nil;
txt_lock=nil;
txt_dungeonName=nil;
txt_timeTips=nil;
txt_time=nil;
btn_guildScore=nil;
btn_score=nil;
mineInfo=nil;
roleObj=nil;
roleImg=nil;
txt_name=nil;
txt_dayAdd=nil;
txt_dayAddVal=nil;
txt_allAdd=nil;
txt_allAddVal=nil;
txt_rank=nil;
txt_rankVal=nil;
txt_guildRank=nil;
txt_guildRankVal=nil;
view=nil;
end
----#End#----