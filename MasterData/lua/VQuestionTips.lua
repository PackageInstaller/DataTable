
function Refresh(txt)
    CSAPI.SetGOAlpha(gameObject,this.index%2==0 and 0 or 1)
    CSAPI.SetText(txtQuestion,txt);
end

function SetIndex(_i)
    this.index=_i;
end