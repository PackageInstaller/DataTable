--大招场景

function SetCamp(ourCamp)
    CSAPI.SetGOActive(our,false);
    CSAPI.SetGOActive(enemy,false);
    CSAPI.SetGOActive(our,ourCamp);
    CSAPI.SetGOActive(enemy,not ourCamp);
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
our=nil;
enemy=nil;
end
----#End#----