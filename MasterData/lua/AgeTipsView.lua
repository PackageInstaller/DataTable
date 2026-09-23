--适龄提示
function OnOpen()
    local cfg=Cfgs.CfgExplanatoryText:GetByID(6);
    CSAPI.SetText(txt_content,cfg.desc);
end

function OnClickClose()
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
Content=nil;
txt_content=nil;
view=nil;
end
----#End#----