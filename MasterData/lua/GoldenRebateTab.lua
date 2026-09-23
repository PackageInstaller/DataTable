local func=nil
local data=nil;
function Refresh(_d, _elseData)
    local isOn = false;
    data=_d;
    local isRed=false;
    if _d then
        local str =_d.name
        CSAPI.SetText(txt1, str)
        CSAPI.SetText(txt2, str)
        isRed=data.isRed
        if _elseData and _elseData.curIdx == _d.index then
            isOn = true
        end
    end
    UIUtil:SetRedPoint(gameObject, isRed, -90, 40, 0)
    CSAPI.SetGOActive(offObj, not isOn)
    CSAPI.SetGOActive(onObj, isOn)
end

function SetClickCB(cb)
    func=cb;
end

function OnClick()
    if func then
        func(data)
    end
end