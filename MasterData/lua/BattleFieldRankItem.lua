local data = nil
function Refresh(_data)
    data = _data
    if data then
        SetRank(1)
        SetIcon()
        SetLv()
        SetName()
        SetIntegral()
    end
end

function SetRank(num)
    CSAPI.SetText(txtIndex,num)
    if num < 4 then
        local en = {"ONE","TWO","THREE"}
        CSAPI.SetText(txtIndex2,en[num])
    end
end

function SetIcon()
    
end

function SetLv()
    
end

function SetName()
    
end

function SetIntegral()
    
end