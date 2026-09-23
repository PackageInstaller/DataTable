function Refresh(data)
    CSAPI.SetText(txt_desc,data.cfg.sDetailed);
    CSAPI.SetTextColorByCode(txt_desc,data.isLight and "FFC146" or "929296")
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
txt_desc=nil;
this=nil;  
view=nil;
end
----#End#----