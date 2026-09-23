function Refresh(name,colorID,desc)
    CSAPI.SetText(txt_Name,name);
    local color=Cfgs.CfgUIColorEnum:GetByID(colorID or 1);
    CSAPI.SetImgColor(titleImg,color.r,color.g,color.b,color.a,false);
    -- CSAPI.SetTextColor(txt_Name,color.r,color.g,color.b,color.a);
    CSAPI.SetText(Content,desc);
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
titleImg=nil;
txt_Name=nil;
sv=nil;
Content=nil;
view=nil;
end
----#End#----