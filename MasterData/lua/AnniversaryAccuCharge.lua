local data= nil
local panel = nil

function Refresh(_data)
    data = _data
    if data then
        SetItem()
    end
end

function SetItem()
    local cfg = nil
    local activeId = data:GetActiveId()
    if activeId then
        local alData= ActivityMgr:GetALData(activeId)
        if alData then
            cfg = alData:GetCfg()
        end
    end
    if panel then
        panel.Refresh(nil,{cfg = cfg})
    else
        ResUtil:CreateUIGOAsync("AccuCharge/AccuChargeT",itemParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(nil,{cfg = cfg})
            panel = lua
        end)
    end
end