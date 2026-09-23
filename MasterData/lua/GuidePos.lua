

function GetPos()
    return pos;
end

function FixPos(viewNode)
    --LogError(viewNode.name);
    if(viewNode)then
        local x,y,z = CSAPI.GetPos(viewNode);
        CSAPI.SetPos(viewPos,x,y,z);
    end
end

function Hide()
    CSAPI.SetGOActive(gameObject,false);
end

function Awake()
    if(autoFixPos)then
        AutoFixPos();
    end
end

function AutoFixPos()
    local arr = CSAPI.GetScreenSize();
    if(arr and arr[0] and arr[1])then
    
        local t = arr[0] / arr[1] - 1920/1080;

        if(t > 0)then
            local goPos = GetPos();
            local x,y = CSAPI.GetAnchor(goPos);
            x = x * (1 + t * 0.4);
            CSAPI.SetAnchor(goPos,x,y);
        end
    end
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
pos=nil;
view=nil;
end
----#End#----