--公会战排名预制物

function Refresh(_data,_elseData)
    if _elseData.type==GuildRankType.GuildGobalRank then
        SetRank(_data.rank)
        SetIcon(_data.icon)
        SetScore(_data.score)
        SetGroup(_data.group_id)
        SetName(_data.name)
        CSAPI.SetGOActive(txt_group,true);
    elseif _elseData.type==GuildRankType.MemberGobalRank or _elseData.type==GuildRankType.MemberGuildRank then 
        SetRank(_elseData.type==GuildRankType.MemberGobalRank and _data.sum_rank or _data.rank)
        SetIcon(_data.icon_id)
        SetScore(_data.sum_score)
        SetName(_data.name)
        CSAPI.SetGOActive(txt_group,false);
        -- SetGroup(group)
    end
end

function SetRank(rank)
    local str="";
    if rank==nil or rank==0 then
        str="-";
    else
        str=tostring(rank);
    end
    CSAPI.SetText(txt_rank,str);
    if str~="-" then
        if rank==1 then
            CSAPI.SetText(txt_rankTips,"ST");
        elseif rank==2 then 
            CSAPI.SetText(txt_rankTips,"ND");
        elseif rank==3 then
            CSAPI.SetText(txt_rankTips,"RD");
        else
            CSAPI.SetText(txt_rankTips,"TH");
        end
    else
        CSAPI.SetText(txt_rankTips,"");
    end
end

function SetName(name)
    CSAPI.SetText(txt_guildName,tostring(name or "-"));
end

function SetIcon(iconName)
    if iconName then
        local cfg=Cfgs.character:GetByID(iconName)
        if cfg then
            ResUtil.RoleCard:Load(icon, cfg.icon)
        end
    else
        CSAPI.SetRectSize(icon,0,0,0);
    end
end

function SetScore(score)
    CSAPI.SetText(txt_score,"贡献："..tostring(score or "-"));
end

function SetGroup(group)
    if group then
        CSAPI.SetText(txt_group,tostring(group).."组");
    else
        CSAPI.SetText(txt_group,"");
    end
end

function SetClickCB()

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
txt_rank=nil;
txt_rankTips=nil;
txt_group=nil;
iconObj=nil;
icon=nil;
txt_guildName=nil;
scoreObj=nil;
txt_score=nil;
view=nil;
end
----#End#----