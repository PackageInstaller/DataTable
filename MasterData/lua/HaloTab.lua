local index=0;
local callBack=nil;
function Refresh(_d,_elseData)
    CSAPI.SetText(txt,LanguageMgr:GetByID(_d));
    if _elseData then
        CSAPI.SetGOActive(line,index<_elseData.maxNum);
        SetIsSelect(index==_elseData.curIdx);
    end
end

function SetIsSelect(isSelect)
    CSAPI.SetGOActive(selectObj,isSelect);
    CSAPI.SetTextColorByCode(txt,isSelect and "FFFFFF" or "C3c3C8");
end

function SetIndex(_idx)
    index=_idx;
end

function GetIndex()
    return index;
end

function SetClickCB(_cb)
    callBack=_cb
end

function OnClick()
    if callBack~=nil then
        callBack(this)
    end
end