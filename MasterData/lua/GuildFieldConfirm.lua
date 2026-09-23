--开启房间确认框
function OnOpen()
    CSAPI.SetGOActive(btnMult,data:MultJoin());
    CSAPI.SetGOActive(btnSingle,data:SingleJoin());
end

function OnClickMult()
    --多人模式
    CreateRoom(GFRoomType.MultiPlr)
end

function OnClickSingle()
    --单人模式
    CreateRoom(GFRoomType.SinglePlr)
end

--创建房间
function CreateRoom(type)
    GuildProto:GFCreateRoom(data:GetIndex(),type);
    view:Close()
end

function OnClickAnyway()
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
btnMult=nil;
txt_mult=nil;
btnSingle=nil;
txt_mult=nil;
view=nil;
end
----#End#----