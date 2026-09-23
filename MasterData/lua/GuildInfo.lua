--公会详情界面
function OnOpen()
    if data then
        CSAPI.SetText(txt_name,data.name);
        CSAPI.SetText(txt_lv,tostring(data.apply_lv));
        local type=data.activity_type==GuildActivityType.Active and LanguageMgr:GetByID(27003) or LanguageMgr:GetByID(27004)
        CSAPI.SetText(txt_type,type);
        CSAPI.SetText(txt_master,data.n_name);
        CSAPI.SetText(txt_num,data.mem_cnt.."/"..g_GuildMaxMenCnt);
        local desc=LanguageMgr:GetByID(27006)
        if data.desc then
            desc=desc..data.desc;
        end
        CSAPI.SetText(txt_desc,desc);
        if data.icon then
            local cfg=Cfgs.character:GetByID(data.icon)
            if cfg then
                ResUtil.RoleCard:Load(icon, cfg.icon)
            end
        else
            CSAPI.SetRectSize(icon,0,0,0);
        end
    end
end

function OnClickOk()
    view:Close();
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
root=nil;
icon=nil;
txt_name=nil;
txt_master=nil;
txt_type=nil;
txt_lv=nil;
txt_num=nil;
txt_desc=nil;
btnOK=nil;
view=nil;
end
----#End#----