function SetClickCB(_cb)
    cb = _cb
end

function Refresh(iconRes,isNative)
    CSAPI.LoadImg(icon,"UIs/" .. iconRes ..".png",isNative,nil,true)
    if not isNative then
       CSAPI.SetRTSize(icon,152,55)
    end
end

function SetTextColor(code)
    if code and code~="" then
        CSAPI.SetTextColorByCode(txt_title,code)
    end
end

function OnClick()
    if cb then
        cb()
    end
end