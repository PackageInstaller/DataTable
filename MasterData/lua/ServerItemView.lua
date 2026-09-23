--服务器Item
local text_serverName
local sourceData=nil;
function Awake()
    text_serverName=ComUtil.GetCom(serverName,"Text");
    CSAPI.SetGOActive(hasRole,false);
    CSAPI.SetGOActive(newObj,false);
    CSAPI.SetGOActive(txt_tips,false);
end

function Init(data)
    if data==nil then
        return;
    end
    sourceData=data;
    text_serverName.text=data.serverName;
    CSAPI.SetGOActive(hasRole,data.hasRole);
    CSAPI.SetGOActive(newObj,data.isNew);
    local color=GetStateImgColor(data.state);
	CSAPI.SetImgColor(stateImg,color[1],color[2],color[3],color[4]);
end

--点击了组件
function OnClickItem()
    EventMgr.Dispatch(EventType.Login_Select_Server,sourceData);
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
ServerItem=nil;
bg=nil;
stateImg=nil;
serverName=nil;
newObj=nil;
view=nil;
end
----#End#----