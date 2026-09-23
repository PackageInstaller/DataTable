function OnOpen()
    local plrCfg = Cfgs.CfgPlrHot:GetByID(PlayerClient:GetLv())
    local costCfg = Cfgs.CfgPlrHotBuyCosts:GetByID(plrCfg.buyCostId)
    local infos = costCfg.infos
    -- local arr = {}
    -- if (#infos == 1) then
    --     table.insert(arr, {
    --         x1 = 1,
    --         x2 = nil,
    --         info[1]
    --     })
    -- else
    --     local index = 1
    --     local spend = nil
    --     for i, v in ipairs(infos) do
    --         if (spend == nil) then
    --             index = i
    --             spend = v.costs[1][2]
    --             if (i == #infos) then
    --                 table.insert(arr, {
    --                     x1 = index,
    --                     x2 = i,
    --                     costs = v.costs
    --                 })
    --             end
    --         elseif (spend ~= v.costs[1][2]) then
    --             table.insert(arr, {
    --                 x1 = index,
    --                 x2 = i,
    --                 costs = v.costs
    --             })
    --             spend = nil
    --         else
    --             if (i == #infos) then
    --                 table.insert(arr, {
    --                     x1 = index,
    --                     x2 = i,
    --                     costs = v.costs
    --                 })
    --             end
    --         end
    --     end
    -- end


    local _arr = {1}
    local num = infos[1].costs[1][2]
    if (#infos >= 1) then
        for i, v in ipairs(infos) do
            if (num ~= v.costs[1][2]) then
                table.insert(_arr, i)
				num = v.costs[1][2]
            end
        end
    end

    local arr = {}
    local len = #_arr
    for k, v in ipairs(_arr) do
        local x2Num = k < len and _arr[k+1] - 1 or #infos
        table.insert(arr, {
            x1 = v,
            x2 = x2Num,
			costs = infos[v].costs
        })
    end
    items = items or {}
    ItemUtil.AddItems("Hot/HotDetailItem", items, arr, Content)
end

function OnClickMask()
    view:Close()
end
