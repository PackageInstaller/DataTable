local isOn=false;
local data=nil;
local eventMgr=nil;
local animator=nil;
local isFirst=true;
function Awake()
    animator=ComUtil.GetCom(gameObject,"Animator")
end

function Refresh(_d,_elseData)
    data=_d;
    local name=data:GetName();
    CSAPI.SetText(txt,name);
    CSAPI.SetText(txt2,name);
    local _isRed=false;
    if _elseData then
        isOn=_elseData.id == data:GetID()
        _isRed=_elseData.isRed or false;
    end
    if isFirst then
        PlayTween("Tab_entry",500,function()
            SetState(isOn,not isFirst)
            isFirst=false;
        end)
    else
        SetState(isOn,true);
    end
    UIUtil:SetRedPoint(redNode, _isRed, 0, 0, 0)
end

function SetState(_isOn,hasTween)
    local playTween=hasTween and (isOn~=_isOn) or false;
    isOn=_isOn;
    if hasTween and playTween then
        local tweenName=isOn and "Tab_sel" or "Tab_Nsel"
        PlayTween(tweenName)
    else
        CSAPI.SetGOActive(onObj,isOn); 
        CSAPI.SetGOActive(offObj,not isOn);
        CSAPI.SetGOAlpha(onObj,isOn and 1 or 0);
        CSAPI.SetGOAlpha(offObj,not isOn and 1 or 0);
        CSAPI.SetGOAlpha(txt2,not isOn and 1 or 0);
        CSAPI.SetGOAlpha(dec,not isOn and 1 or 0);
    end
end

function PlayTween(tweenName,delayTime,func)
    delayTime=delayTime or 500;
    if IsNil(animator)==nil or tweenName==nil then 
        do return end
    end
    if animator.enabled~=true then
        animator.enabled=true;
    end
    animator:Play(tweenName, -1, 0);
    FuncUtil:Call(function()
        if IsNil(animator)~=nil then 
            animator.enabled=false;
        end
        if func~=nil then
            func();
        end
    end,nil,delayTime)
end

function OnClick()
    EventMgr.Dispatch(EventType.CharacterRaising_Tab_Click,data);
end

function OnDestroy()
    animator=nil;
    data=nil;
    gameObject=nil;
end
