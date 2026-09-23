--搜索栏下拉物体
local click=nil;
function Refresh(_d,index)
    local isSelect=false;
    this.data=_d;
    if _d then
        CSAPI.SetText(txtVal,_d.txt);
        CSAPI.SetText(txtVal2,_d.txt);
        isSelect=this.index==index and true or false;
    end
    SetSelect(isSelect);
end

function SetSelect(_isSelect)
    CSAPI.SetGOActive(selectImg,_isSelect)
    CSAPI.SetGOActive(txtVal,not _isSelect)
end

function SetIndex(i)
    this.index=i;
end

function GetIndex()
    return this.index;
end

function SetClickCB(_click)
    click=_click;
end

function OnClickItem()
    if click then
        click(this);
    end
end
