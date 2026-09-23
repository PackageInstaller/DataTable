

function OnOpen()
    UIUtil:ShowAction(rootNode, nil, UIUtil.active2);
    if data then
        local cfg = Cfgs.CfgSkillDesc:GetByID(data.id)
        if cfg then
            CSAPI.SetText(text_skillName,cfg.name);
            CSAPI.SetText(text_lv,string.format(LanguageMgr:GetTips(1009),tostring(data.lv)));
            CSAPI.SetText(text_lv2,"");
            -- CSAPI.SetText(text_lv2,data.lv ~= nil and "LV." or "");
            CSAPI.SetText(text_desc,cfg.desc);
            -- ResUtil.IconSkill:Load(icon,data.icon,true);
            -- CSAPI.SetRTSize(icon,120,120)
        end
    end
end

function OnClickMask()
    UIUtil:HideAction(rootNode, function()
        view:Close();
    end, UIUtil.active4);
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
rootNode=nil;
line=nil;
text_lv=nil;
text_lv2=nil;
text_skillName=nil;
text_desc=nil;
view=nil;
end
----#End#----