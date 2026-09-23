

function SetCallBack(clickCallBack)
    callBack = clickCallBack;
    CSAPI.SetText(Text,gameObject.name);
end

function OnClick()
    callBack(gameObject);
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
Text=nil;
end
----#End#----