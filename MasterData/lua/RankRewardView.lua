local info = nil
local cfg = nil
local layout = nil
local curDatas = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Rank/RankRewardItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.Refresh(_data,info and info.elseData,info and info.rankType)
    end
end

-- info = {
--     id 
--     title 
--     cfgView
--     cfg 
--     path 
--     desc1 
--     desc12 
--     elseData 
-- }
function Refresh(_data)
    info = _data
    cfg = info and info.cfg
    if cfg then
        SetDatas()
        SetItems()
    end
end

function SetDatas()
    if curDatas == nil then
        curDatas = {}
        if cfg.infos and #cfg.infos > 0 then
            for i, info in ipairs(cfg.infos) do
                table.insert(curDatas, info)
            end
            if #curDatas > 0 then
                table.sort(curDatas, function(a, b)
                    return a.index < b.index
                end)
            end
        end
    end
end

function SetItems()
    layout:IEShowList(#curDatas, nil, 1)
end


