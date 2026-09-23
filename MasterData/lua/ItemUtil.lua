-- item生成工具
local this = {}

-- ==============================--
-- desc: 异步生成item
-- time:2020-05-12 11:35:23
-- @items:容器
-- @itemPath:路径
-- @datas:全部数据
-- @parent:父类
-- @cb: 点击回调（需实现 SetClickCB（））
-- @scale: 大小，默认为1
-- @return 
-- ==============================--
function this.AddItems(itemPath, items, datas, parent, cb, scale, elseData, loadSuccess)
    if (StringUtil:IsEmpty(itemPath) or parent == nil) then
        return
    end
    items = items or {}

    local len1 = #items
    local len2 = #datas

    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    for i, v in ipairs(datas) do
        if (i <= len1) then
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)

            -- 全部加载完成后执行
            if (i == len2 and loadSuccess) then
                loadSuccess()
            end
        else
            scale = scale or 1
            ResUtil:CreateUIGOAsync(itemPath, parent, function(go)
                CSAPI.SetScale(go, scale, scale, 1)
                local item = ComUtil.GetLuaTable(go)
                if (item.SetIndex) then
                    item.SetIndex(i)
                end
                if (item.SetClickCB) then
                    item.SetClickCB(cb)
                end
                item.Refresh(v, elseData)
                table.insert(items, item)
                -- 全部加载完成后执行
                if (#items == len2 and loadSuccess) then
                    loadSuccess()
                end
            end)
        end
    end
    return items
end

-- 同步生成
function this.AddItemsImm(itemPath, items, datas, parent, cb, scale, elseData)
    if (StringUtil:IsEmpty(itemPath) or parent == nil) then
        return
    end
    items = items or {}
    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    for i, v in ipairs(datas) do
        if (#items >= i) then
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)
        else
            scale = scale or 1
            local go = ResUtil:CreateUIGO(itemPath, parent.transform)
            CSAPI.SetScale(go, scale, scale, 1)
            local item = ComUtil.GetLuaTable(go)
            if (item.SetIndex) then
                item.SetIndex(i)
            end
            if (item.SetClickCB) then
                item.SetClickCB(cb)
            end
            item.Refresh(v, elseData)
            table.insert(items, item)
        end
    end
    return items
end

-- ==============================--
-- desc: 从左到右，上到下异步生成倾斜格子
-- time:2020-05-12 11:38:39
-- @items:
-- @itemPath: 如 Common/Item”
-- @datas:
-- @parent: gameObject
-- @cb:
-- @scaleX:格子长
-- @scaleX:格子宽
-- @ranks:几列
-- @spaceX:左到右格子间的间距
-- @spaceY：上到下格子间的间距
-- @angle:倾斜角度（下->左） 31.5
-- @scale: 大小，默认为1
-- @return 
-- ==============================--
function this.AddSlopeItems(items, datas, itemPath, parent, cb, scaleX, scaleY, ranks, spaceX, spaceY, angle, scale,
    elseData)
    if (StringUtil:IsEmpty(itemPath) or parent == nil) then
        return
    end
    angle = angle == nil and 31.5 or angle
    scale = scale or 1
    items = items or {}
    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    for i, v in ipairs(datas) do
        local rank = math.floor((i - 1) / ranks)
        local y = (scaleY + spaceY) * rank
        local x = (i - rank * ranks - 1) * (scaleX + spaceX) - math.tan(math.pi * angle / 180) * y
        if (#items >= i) then
            CSAPI.SetAnchor(items[i].gameObject, x, -y)
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)
        else
            ResUtil:CreateUIGOAsync(itemPath, parent, function(go)
                CSAPI.SetAnchor(go, x, -y)
                CSAPI.SetScale(go, scale, scale, 1)
                local item = ComUtil.GetLuaTable(go)
                if (item.SetIndex) then
                    item.SetIndex(i)
                end
                if (item.SetClickCB) then
                    item.SetClickCB(cb)
                end
                item.Refresh(v, elseData)
                table.insert(items, item)
            end)
        end
    end
    return items
end

-- ==============================--
-- desc: 从左到右，上到下异步生成倾斜格子
-- time:2020-05-12 11:38:39
-- @items:
-- @itemPath: 如 Common/Item”
-- @datas:
-- @parent: gameObject
-- @cb: 设置回调
-- @scaleX:格子长
-- @scaleX:格子宽
-- @ranks:几列
-- @spaceX:格子间的间距
-- @spaceY：格子间的间距
-- @angle:倾斜角度（下->左） 31.5
-- @scale: 大小，默认为1
-- @return 
-- ==============================--
function this.AddSlopeItems2(items, datas, itemPath, parent, cb, scaleX, scaleY, ranks, spaceX, spaceY, addX, scale,
    elseData)
    if (StringUtil:IsEmpty(itemPath) or parent == nil) then
        return
    end
    scale = scale or 1
    items = items or {}
    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    for i, v in ipairs(datas) do
        -- 当前所在行 0 开始
        local rank = math.floor((i - 1) / ranks)
        local y = (scaleY + spaceY) * rank
        local x = (i - rank * ranks - 1) * (scaleX + spaceX) + addX * rank
        if (#items >= i) then
            CSAPI.SetAnchor(items[i].gameObject, x, -y)
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)
        else
            ResUtil:CreateUIGOAsync(itemPath, parent, function(go)
                CSAPI.SetAnchor(go, x, -y)
                CSAPI.SetScale(go, scale, scale, 1)
                local item = ComUtil.GetLuaTable(go)
                if (item.SetIndex) then
                    item.SetIndex(i)
                end
                if (item.SetClickCB) then
                    item.SetClickCB(cb)
                end
                item.Refresh(v, elseData)
                table.insert(items, item)
            end)
        end
    end
    return items
end

-- ==============================--
-- desc: 居中对齐异步生成倾斜格子（1列）
-- time:2020-05-12 11:38:39
-- @items:
-- @itemPath: 如 Common/Item”
-- @datas:
-- @parent: gameObject
-- @cb:
-- @discY：上到下格子的中心间距
-- @angle:倾斜角度（下->左） 31.5
-- @scale: 大小，默认为1
-- @return 
-- ==============================--
function this.AddSlopeItemsByM(items, datas, itemPath, parent, cb, discY, angle, scale, elseData)
    if (StringUtil:IsEmpty(itemPath) or parent == nil) then
        return
    end
    angle = angle == nil and 31.5 or angle
    scale = scale or 1
    items = items or {}
    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    local startY = (#datas - 1) / 2 * discY
    for i, v in ipairs(datas) do
        local y = startY - (i - 1) * discY
        local x = math.tan(math.pi * angle / 180) * y
        if (#items >= i) then
            CSAPI.SetAnchor(items[i].gameObject, x, -y)
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)
        else
            ResUtil:CreateUIGOAsync(itemPath, parent, function(go)
                CSAPI.SetAnchor(go, x, -y)
                CSAPI.SetScale(go, scale, scale, 1)
                local item = ComUtil.GetLuaTable(go)
                if (item.SetIndex) then
                    item.SetIndex(i)
                end
                if (item.SetClickCB) then
                    item.SetClickCB(cb)
                end
                item.Refresh(v, elseData)
                table.insert(items, item)
            end)
        end
    end
    return items
end

-- 仅刷新列表
function this.RefreshItems(items, datas, elseData)
    for i = #datas + 1, #items do
        CSAPI.SetGOActive(items[i].gameObject, false)
    end
    for i, v in ipairs(datas) do
        if (#items >= i) then
            CSAPI.SetGOActive(items[i].gameObject, true)
            items[i].Refresh(v, elseData)
        end
    end
end

-- ==============================--
-- desc: 无限滚动列表 item异步生成
-- time:2020-05-13 10:26:12
-- @element: item挂点
-- @itemPath:item路径
-- @data: 当前数据
-- @elseData: 额外数据
-- @cb:
-- @scale: 大小，默认为1
-- @return
-- ==============================--
function this.AddCircularItems(element, itemPath, data, elseData, cb, scale)
    local elementTab = ComUtil.GetLuaTable(element.gameObject)
    local item = elementTab.GetItem(itemPath)
    if (item) then
        if (item.SetIndex) then
            item.SetIndex(tonumber(element.name) + 1)
        end
        if (item.SetClickCB) then
            item.SetClickCB(cb)
        end
        CSAPI.SetGOActive(item.gameObject, true) -- 保险
        item.Refresh(data, elseData)
    else
        elementTab.SetCellScale(0)
        scale = scale or 1
        ResUtil:CreateUIGOAsync(itemPath, elementTab.GetCell(), function(go)
            CSAPI.SetGOActive(go, true) -- 保险
            local goRect = ComUtil.GetCom(go, "RectTransform")
            goRect.pivot = UnityEngine.Vector2(0, 1)
            CSAPI.SetScale(go, scale, scale, 1)
            local item = ComUtil.GetLuaTable(go)
            if (item.SetIndex) then -- 加入位置
                item.SetIndex(tonumber(element.name) + 1)
            end
            if (item.SetClickCB) then
                item.SetClickCB(cb)
            end
            item.Refresh(data, elseData)
            elementTab.SetItem(item, itemPath)
            elementTab.SetCellScale(1)
        end)
    end
end

-- 添加无限滚动item
function this.AddUISVItem(element, itemPath, data, elseData, cb, scale)

end

return this
