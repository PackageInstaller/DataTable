
function OnEnter()
    local target = GetTarget();
    local data = { go = target };
    EventMgr.Dispatch(EventType.UI_Eff_Enter,data);
end

function OnExit()
    local target = GetTarget();
    local data = { go = target };
    EventMgr.Dispatch(EventType.UI_Eff_Exit,data);
end

function GetTarget()
    if(not action)then
        action = ComUtil.GetCom(gameObject,"ActionBase");
    end
    if(not action)then
        return nil;
    end
    return action.target;
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

end
----#End#----