--公会战结果信息
local data=nil;
local elseData=nil;
local slider=nil;
function Awake()
    slider=ComUtil.GetCom(sliderBar,"Image");
end

function Refresh(_d,_e)
    data=_d;
    elseData=_e;
    local guildInfo=GuildMgr:GetGuildInfo();
    if elseData and elseData.listType==2 then --个人战绩
        CSAPI.SetGOActive(type1,false);
        CSAPI.SetGOActive(type2,true);
        local cfg=GuildRoomData.New()
        cfg:SetCfgID(data.f_id,data.room_cfg_id);--data.f_id是赛季季度id
        if cfg then
            SetIcon(icon,cfg:GetModel());
            CSAPI.SetText(txt_hard,cfg:GetDiffStr());
            CSAPI.SetText(txt_lv,string.format(LanguageMgr:GetTips(1009),cfg:GetLv()));
            CSAPI.SetText(txt_name,cfg:GetName());
            CSAPI.SetText(txt_uName,data.c_name);
            CSAPI.SetText(txt_fTime,TimeUtil:GetTimeHMS(data.c_time, "%Y-%m-%d"))
            CSAPI.SetText(txt_score,tostring(data.score));
            CSAPI.SetText(txt_bossResult,data.win and LanguageMgr:GetByID(27021) or LanguageMgr:GetByID(27022));
        else
            LogError("未找到公会战房间配置！"..tostring(data.room_cfg_id));
        end
    else --公会战绩
        CSAPI.SetGOActive(type1,true);
        CSAPI.SetGOActive(type2,false);
        local tips=data.win_id==guildInfo.id and LanguageMgr:GetByID(27023) or LanguageMgr:GetByID(27024)
        CSAPI.SetText(txt_title,data.group_id==nil and LanguageMgr:GetByID(27019) or LanguageMgr:GetByID(27020))
        CSAPI.SetText(txt_result,tips);
        CSAPI.SetText(txt_time,TimeUtil:GetTimeHMS(data.time, "%Y-%m-%d"));
        -- local groupCfg=Cfgs.CfgGuildFightGroup:GetByID(data.group_id);
        -- CSAPI.SetText(txt_group,groupCfg.rankGroup);
        SetIcon(lGuildIcon,data.icon_a);
        SetIcon(rGuildIcon,data.icon_b);
        CSAPI.SetText(txt_lName,data.name_a);
        CSAPI.SetText(txt_rName,data.name_b);
        local total=data.score_a+data.score_b;
        local p1=(data.score_a/total)*100
        local p2=(data.score_b/total)*100
        CSAPI.SetText(txt_lsVal,string.format("%.1f",p1).."%");
        CSAPI.SetText(txt_rsVal,string.format("%.1f",p2).."%");
        CSAPI.SetText(txt_lVal,tostring(data.score_a));
        CSAPI.SetText(txt_rVal,tostring(data.score_b));
        slider.fillAmount=data.score_a/total;
    end
end

function SetIcon(go,iconId)
    if iconId then
        local cfg=Cfgs.character:GetByID(iconId)
        if cfg then
            ResUtil.RoleCard:Load(go, cfg.icon)
        end
    else
        CSAPI.SetRectSize(go,0,0,0);
    end
end

function SetClickCB(_cb)

end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
type1=nil;
txt_title=nil;
txt_result=nil;
txt_time=nil;
line=nil;
txt_group=nil;
pkInfo=nil;
lGuildIcon=nil;
rGuildIcon=nil;
txt_lName=nil;
txt_rName=nil;
sliderBar=nil;
txt_lsVal=nil;
txt_rsVal=nil;
txt_lVal=nil;
txt_rVal=nil;
type2=nil;
icon=nil;
hardObj=nil;
txt_hard=nil;
lvObj=nil;
txt_lv=nil;
txt_name=nil;
txt_uName=nil;
txt_fTime=nil;
txt_score=nil;
txt_bossResult=nil;
view=nil;
end
----#End#----