--会员预制物
local data=nil;
function Refresh(_data)
    data=_data
    if data then
       CSAPI.SetText(txt_name,data.name);
       --加载icon
    --    CSAPI.LoadImg();
        if data.icon_id then
            local cfg=Cfgs.character:GetByID(data.icon_id)
            if cfg then
                ResUtil.RoleCard:Load(icon, cfg.icon)
            end
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
        if data.title==GuildMemberType.Boss then
            CSAPI.SetGOActive(titleObj,true);
            CSAPI.SetText(txt_title,LanguageMgr:GetByID(27007));
        elseif data.title==GuildMemberType.SubBoss then
            CSAPI.SetGOActive(titleObj,true);
            CSAPI.SetText(txt_title,LanguageMgr:GetByID(27008));
        else
            CSAPI.SetGOActive(titleObj,false);
        end
        CSAPI.SetText(txt_lv,tostring(data.lv));
        CSAPI.SetText(txt_time,string.format(LanguageMgr:GetByID(27002),TimeUtil:GetTimeShortStr2(CSAPI.GetServerTime()-data.pre_online)));
    end
end

--查看详情
function OnClickLook()
    if data then
        --打开详情界面
        CSAPI.OpenView("GuildMemInfo",data)
    end
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
icon=nil;
titleObj=nil;
txt_title=nil;
txt_name=nil;
txt_lv=nil;
txt_time=nil;
btnLook=nil;
view=nil;
end
----#End#----