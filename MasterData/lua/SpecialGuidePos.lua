local item = nil
local cfg = nil

function Refresh(_data)
    cfg = _data
    if cfg then
        SetItem()
    end
end

function SetItem()
    if item then
        item.Refresh(cfg)
    else
        ResUtil:CreateUIGOAsync("SpecialGuide/SpecialGuideItem",pos,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(cfg)
            item = lua
        end)
    end
end