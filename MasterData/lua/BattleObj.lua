
function Awake()
    if(openNode)then
        CSAPI.SetGOActive(openNode,false);
    end
end

function ApplyOpen()
    if(openNode)then
        CSAPI.SetGOActive(openNode,true);
    end

    if(bodyNode)then
        CSAPI.SetGOActive(bodyNode,false);
    end
end

function RemoveRes(callBack)
    FuncUtil:Call(callBack,nil,2000);
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
bodyNode=nil;
openNode=nil;
end
----#End#----