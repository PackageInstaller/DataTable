--折扣券下拉子物体
local click=nil;
function Refresh(_d,index)
    local isSelect=false;
    this.data=_d;
    if _d then
        CSAPI.SetText(txt,_d.txt);
        CSAPI.SetText(txt2,_d.txt2);
        if IsNil(txt3)~=true then
            CSAPI.SetText(txt3,_d.txt);
            if _d.txt2==nil or _d.txt2=="" then
                CSAPI.SetGOActive(txt,false)
                CSAPI.SetGOActive(txt3,true)
            else
                CSAPI.SetGOActive(txt3,false)
                CSAPI.SetGOActive(txt,true)
            end
        end
        isSelect=this.index==index and true or false;
    end
    SetSelect(isSelect);
end

function SetSelect(_isSelect)
    if _isSelect then
        -- CSAPI.SetImgColorByCode(bg,"FFC146");
        CSAPI.SetTextColorByCode(txt,"1b1b1b");
        if IsNil(txt3)~=true then
            CSAPI.SetTextColorByCode(txt3,"1b1b1b");
        end
        CSAPI.SetTextColorByCode(txt2,"e46262");
    else
        -- CSAPI.SetImgColorByCode(bg,this.index%2==1 and "21212b" or "0f0f19");
        CSAPI.SetTextColorByCode(txt,"aeaea");
        CSAPI.SetTextColorByCode(txt2,"828282");
        if IsNil(txt3)~=true then
            CSAPI.SetTextColorByCode(txt3,"aeaea");
        end
    end
    CSAPI.SetGOActive(bg,_isSelect)
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
