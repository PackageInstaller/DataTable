local info = nil

function Refresh(_data)
    info = _data
    if info then
        SetIcon()
        SetPass()
    end
end

function SetIcon()
    local name = info.isCool and 0 or 1
    name = info.isLost and 2 or name
    name = info.isPass and 1 or name
    CSAPI.LoadImg(icon,"UIs/RogueMapBattle/img_23_0" .. name .. ".png",true,nil,true)
end

function SetPass()
    CSAPI.SetGOActive(passImg,info.isPass)
end