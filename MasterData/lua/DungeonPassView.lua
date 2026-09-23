
function OnOpen()
    UIUtil:ShowAction(gameObject, nil, UIUtil.active2);
end

function OnClickMask()
    view:Close();
    DungeonMgr:Quit(false, jump);
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

view=nil;
end
----#End#----