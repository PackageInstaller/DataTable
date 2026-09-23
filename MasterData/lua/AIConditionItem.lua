function Refresh(_data,_isSelect,_callBack)
    this.index=_data.index;
    this.callBack=_callBack;
    CSAPI.SetText(txt,tostring(_data.txt));
    CSAPI.SetGOActive(choosie,_isSelect==true);
    CSAPI.SetTextColorByCode(txt,_isSelect==true and "ffc146" or "ffffff");
end

function ShowLine(isShow)
    CSAPI.SetGOActive(line,isShow);
end

function OnClickSelf()
    if this.callBack then
        this.callBack(this)
    end
end