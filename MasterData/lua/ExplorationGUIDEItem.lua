local isOn=false;
local clickCB=nil;
local canvasGroup=nil;
function Awake()
    canvasGroup=ComUtil.GetCom(txt,"CanvasGroup")
end

function Refresh(data)
    if data then
        this.data=data;
        -- local str=LanguageMgr:GetByID(data.id);
        local str=data.str;
        CSAPI.SetText(txt,str);
        isOn=data.isOn or false;
        local isRed=false;
        if data.redInfo and data.redInfo.taskTypes then
            for k,v in ipairs(data.redInfo.taskTypes) do
                -- Log(tostring(k).."\t"..tostring(v).."\t"..data.id)
                if k==data.id and v==true then
                    isRed=true;
                    break;
                end
            end
        end
        CSAPI.SetGOActive(redPoint,isRed)
        if isRed then
            UIUtil:SetRedPoint(redPoint,true);
        end
    end
    SetState(isOn);
end

function OnClick()
    if clickCB then
        clickCB(this);
    end
end

function SetIndex(i)
    this.index=i;
end

function SetState(_isOn)
    CSAPI.SetGOActive(off,not _isOn);
    CSAPI.SetGOActive(on,_isOn);
    CSAPI.SetTextColorByCode(txt,_isOn and "ffc146" or "ffffff");
    canvasGroup.alpha=_isOn and 1 or 0.5;
end

function SetClickCB(cb)
    clickCB=cb;
end