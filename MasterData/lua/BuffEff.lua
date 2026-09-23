
function Awake()
    if(isShow)then
        SetShowState(isShow);
    end    
end

function Set(targetCfg,caller)       
    cfg = targetCfg; 
    if(cfg == nil)then         
        return;
    end

    if(caller)then
        callers = callers or {};
        callers[caller] = 1;
    end
    UpdateBuffCtrl();
    if(isLoaded == nil)then
        isLoaded = 1;

        local key = cfg.key;
        local res = cfg.res or key;     
        
        local bodySize = targetCharacter and targetCharacter.GetBodySize();

        ResUtil:CreateBuffEff(res,effNode,OnCreated,bodySize);    
        --LogError("创建特效：" .. tostring(res) .. "\n" .. table.tostring(cfg));
    end

    if(cfg.time)then
        FuncUtil:Call(Remove,nil,cfg.time);
    end
end
--更新buff控制
function UpdateBuffCtrl()
    if(buffCtrl)then
        local tierLv = 0;
        if(callers)then
            for caller,v in pairs(callers)do
                if(v)then
                    tierLv = tierLv + 1;
                end
            end
        end
        if(buffCtrl.SetTierLv)then
            buffCtrl.SetTierLv(tierLv);
        end
    end
end

function OnCreated(go)
    if(IsNil(gameObject))then
        CSAPI.RemoveGO(go);
        return;
    end
   
    if(not IsNil(go))then
        buffCtrl = ComUtil.GetLuaTable(go);
        if (targetCharacter and buffCtrl and buffCtrl.SetCharacter) then
            buffCtrl.SetCharacter(targetCharacter);
        end
    end
end


--设置角色
function SetCharacter(ownerCharacter)    
    targetCharacter = ownerCharacter;
    if (targetCharacter and buffCtrl and buffCtrl.SetCharacter) then
        buffCtrl.SetCharacter(targetCharacter);
    end
end 
function GetKey()
    return cfg.key;
end
--获取播放频道
function GetPlayCannel()
    return cfg.play_channel or 0;
end
--获取播放优先级
function GetPlayPriority()
    return cfg.play_priority or 0;
end
function GetCfg()
    return cfg;
end
--设置显示状态
function SetShowState(showState)
    if(isRemoved)then
        return;
    end

    if(showState == nil)then
        showState = false;
    end
    if(isShow and isShow == showState)then
        return;
    end

    isShow = showState;
    CSAPI.SetGOActive(effNode,isShow);
 
end
function IsShow()
    return isShow;
end

function Remove(caller)
    if(isRemoved)then
        return;
    end
    
    if(callers and caller)then
        callers[caller] = nil;
        UpdateBuffCtrl();
        for _,v in pairs(callers)do
            if(v)then
                return;
            end
        end
    end
    isRemoved = 1;
    CSAPI.RemoveGO(gameObject);

    if(targetCharacter and targetCharacter.RemoveBuffEff)then
        targetCharacter.RemoveBuffEff(this);
        targetCharacter = nil;
    end
end

function TryCall(funcName)
    local func = buffCtrl and buffCtrl[funcName];
    if(func)then
        func();
    end
end

function OnDestroy()
    if(buffCtrl and buffCtrl.Remove)then
        buffCtrl.Remove();
    end
end