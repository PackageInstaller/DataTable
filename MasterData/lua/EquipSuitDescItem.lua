function Refresh(_data)
    if _data.icon then
        ResUtil.EquipSkillIcon:Load(icon,_data.icon);
    end
    CSAPI.SetText(txt_name,_data.name);
    CSAPI.SetText(txt_desc,_data.dec);
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
txt_desc=nil;
nameObj=nil;
txt_name=nil;
view=nil;
end
----#End#----