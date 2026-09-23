
local isOn=false;
local isFirst=true
function Refresh(_d,currIdx)
    this.data=_d
    local _isOn=this.data and currIdx==this.data.idx or false;
    if _d then
        local txt=LanguageMgr:GetByID(_d.id);
        CSAPI.SetText(txtNormal,txt);
        CSAPI.SetText(txtOn,txt);
    end
    if isFirst then
        isOn=_isOn;
        isFirst=false;
    end
    SetRed(_d and _d.isRed or false);
    SetState(_isOn);
end

function SetRed(isRed)
    CSAPI.SetGOActive(redObj,isRed);
end

function SetState(_isOn)
    CSAPI.SetGOActive(onObj,_isOn==true);
    -- CSAPI.SetGOActive(normalObj,_isOn~=true);
    if _isOn~=isOn then
        CSAPI.SetGOActive(onTween,_isOn);
        CSAPI.SetGOActive(offTween,not _isOn);
    end
    isOn=_isOn;
end

function OnClickPetTag()
    if this.data and isOn~=true then
        EventMgr.Dispatch(EventType.PetActivity_Tab_Click,GetIndex());
    end
end

function SetIndex(_i)
    this.index=_i;
end

function GetIndex()
    return this.index;
end