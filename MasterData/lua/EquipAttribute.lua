function Refresh(data)
    if data then
        local cfg=Cfgs.CfgCardPropertyEnum:GetByID(data.id);
        CSAPI.SetText(txt_name,cfg.sName);
        CSAPI.SetText(txt_val,data.val);
    end
end

function SetClickCB(cb)
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
txt_name=nil;
txt_val=nil;
view=nil;
end
----#End#----