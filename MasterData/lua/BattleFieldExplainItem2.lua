local data = nil
function Refresh(_data)
    data = _data
    if data then
        SetRank("")
        SetGrid()
    end
end

function SetRank(str)
   LanguageMgr:SetText(37020,str)
end

function SetGrid()
    
end