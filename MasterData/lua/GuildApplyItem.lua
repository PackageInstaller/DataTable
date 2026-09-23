--公会申请记录子物体
local data=nil;
function Refresh(_data)
    data=_data
    if data then
       CSAPI.SetText(txt_name,data.name);
       --加载icon
        if data.icon_id then
            local cfg=Cfgs.character:GetByID(data.icon_id)
            if cfg then
                ResUtil.RoleCard:Load(icon, cfg.icon)
            end
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
    --    CSAPI.LoadImg();
        CSAPI.SetText(txt_lv,tostring(data.lv));
        CSAPI.SetText(txt_time,string.format(LanguageMgr:GetByID(27002),TimeUtil:GetTimeShortStr2(CSAPI.GetServerTime()-data.t_apply)));
    end
end

--同意
function OnClickOk()
    if data then
        GuildProto:ApplyOp(data.uid,true);
    end
end

--拒绝
function OnClickCancel()
    if data then
        GuildProto:ApplyOp(data.uid,false);
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
txt_name=nil;
txt_lv=nil;
txt_time=nil;
btnOK=nil;
btnCancel=nil;
view=nil;
end
----#End#----