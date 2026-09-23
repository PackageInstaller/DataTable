local textMove=nil;
function Awake()
    textMove=ComUtil.GetCom(text,"TextMove");
end

function Refresh(data)
    -- CSAPI.SetText(name,data);
    if not IsNil(textMove) then
        textMove:SetText(data);
    end
end
function OnDestroy()    
    ReleaseCSComRefs();
end

function SetJumpCall()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
name=nil;
view=nil;
end
----#End#----