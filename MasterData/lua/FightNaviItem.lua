local isOn=false;
local group=0;
local isMult=false;
local caller=nil;
local id=nil;
function Set(_id,_title,_isOn,_group,_isMult,_caller)
    id=_id;
    isOn=_isOn;
    isMult=_isMult;
    group=_group;
    caller=_caller;
    CSAPI.SetText(text,tostring(_title));
    SetState(isOn);
end

function GetID()
    return id;
end

function GetState()
    return isOn;
end

function SetState(_isOn)
    isOn=_isOn;
    local code=isOn and "FFC146" or "FFFFFF"
    CSAPI.SetImgColorByCode(stateObj,code);
    CSAPI.SetTextColorByCode(text,code);
end

function OnClickItem()
    if caller then
        caller(this,id,group,isMult);
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
stateObj=nil;
text=nil;
view=nil;
end
----#End#----