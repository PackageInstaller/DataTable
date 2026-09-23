
function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    if data then
        SetDesc()
        SetRed()
    end
end

function SetDesc()
    CSAPI.SetText(txtDesc,data:GetDesc())
end

function SetRed()
    UIUtil:SetRedPoint(redParent,data:GetIsNew())
end

function OnClick()
    CSAPI.OpenView("PlayerInfoView",{uid = data:GetUID()})
end