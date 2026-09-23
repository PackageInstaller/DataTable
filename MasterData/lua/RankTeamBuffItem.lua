local item =nil
local data =nil 

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = BuffBattleMgr:GetData(_data)
    if data then
        SetItem()
    end
end

function SetItem()
    if item then
        item.Refresh(data)
    else
        ResUtil:CreateUIGOAsync("BuffBattle/BuffBattleItemR2",itemParent,function (go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(data)
        end)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end

function GetDesc()
    return data and data:GetBuffDesc() or ""
end