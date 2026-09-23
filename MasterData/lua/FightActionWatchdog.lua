


--更新信息
function UpdateInfo()
    local logInfo = fightAction:GetInfo();
    LogError(logInfo);

    local info = table.tostring(fightAction:GetData());
    
    if(fightAction.runningSubFightAction)then
        info = info .. "\n子FightAction执行中：是\n";
        local subInfo = table.tostring( fightAction.runningSubFightAction);
        info = info .. subInfo;
    else
        info = info .. "\n子FightAction执行中：否\n";
    end
    ComUtil.GetCom(gameObject,"XLuaMono").info = info;
    ComUtil.GetCom(gameObject,"XLuaMono").isComplete = fightAction.isComplete ~= nil;
end

function Set(fa)
    fightAction = fa;
    gameObject.name = FightActionTypeDesc[fa:GetType()];
    if(fa.data and fa.data.api)then
        ComUtil.GetCom(gameObject,"XLuaMono").api = fa.data.api;
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

end
----#End#----