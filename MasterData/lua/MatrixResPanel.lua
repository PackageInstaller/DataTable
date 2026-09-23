-- 资源收取界面
local isShow = false
local timer = 0

function OnInit()
    UIUtil:AddTop2("MatrixResPanel", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_Update, RefreshPanel)
    -- eventMgr:AddListener(EventType.Matrix_Building_Get, function(proto)
    -- 	RefreshPanel()
    -- 	SetAdd(rewards)
    -- end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- function Update()
-- 	if(isShow and timer < Time.time) then
-- 		isShow = false
-- 		SetAdd(nil)
-- 	end
-- end
function OnOpen()
    buildData = MatrixMgr:GetBuildingDataByType(BuildsType.ProductionCenter)
    if (not buildData) then
        view:Close()
        return
    end
    cfg = buildData:GetCfg()
    RefreshPanel()
end

-- function Refresh()
-- 	-- --max
-- 	-- local max = buildData:GetCfg().desc2
-- 	-- LanguageMgr:SetText(txtMax, 10055, max)
-- 	--RefreshPanel()
-- 	--add
-- 	--SetAdd(nil)
-- end
function RefreshPanel()
    SetTop()
    SetMiddle()

    -- mat
    -- SetRes()
    -- left
    -- SetLList()
end

function SetTop()
    topItems = topItems or {}
    topDatas = {}
    for i, id in ipairs(g_CraftingCenterItems) do
        local num = BagMgr:GetCount(id)
        table.insert(topDatas, {id, num})
    end
    ItemUtil.AddItems("Matrix/MatrixResItem1", topItems, topDatas, materialGrids1)
end

-- (a-b)如果结果是小数，会出问题 https://blog.csdn.net/weixin_43284350/article/details/118312126
function SetMiddle()
    middleItems = middleItems or {}
    middleDatas = {}
    local rewardCfg = Cfgs.RewardInfo:GetByID(cfg.rewardId)
    for i, id in ipairs(g_CraftingCenterItems) do
        -- 效率 
        local num1 = 0
        for k, m in ipairs(rewardCfg.item) do
            if (m.id == id) then
                num1 = m.count
                break
            end
        end
        local num2 = math.ceil(cfg.rewardDiff / 60)
        -- add
        local add = 0
        local maxAdd = 0
        local productAdd = buildData:GetData().productAdd
        if (productAdd) then
            for k, v in pairs(productAdd) do
                if (v.id == id) then
                    add = v.num
                    maxAdd = v.limit
                    break
                end
            end
        end
        local num1AddStr = ""
        if (add ~= 0) then
            if (add > 0) then
                num1AddStr = StringUtil:SetByColor("+" .. add, "FFCC00")
            else
                num1AddStr = StringUtil:SetByColor(add, "FF0040")
            end
        end
        local minStr = LanguageMgr:GetByID(11011) or "MIN"
        local ratioStr = string.format("%s/%s %s", num1 .. num1AddStr, num2,minStr)
        -- 当前数量/上限
        arrGifts = buildData:GetMaterials()
        local count = 0
        for k, m in ipairs(arrGifts) do
            if (m.id == id) then
                count = count + m.num
            end
        end
        local countMax = 1
        for k, m in ipairs(cfg.rewardLimits) do
            if (m[1] == id) then
                countMax = m[2] + maxAdd
                break
            end
        end
        table.insert(middleDatas, {id, ratioStr, count, countMax})
    end
    ItemUtil.AddItems("Matrix/MatrixResItem2", middleItems, middleDatas, materialGrids2, ItemClickCB2, 1, nil,
        function()
            ItemAnims()
        end)
end

-- function SetMiddle()
--     middleItems = middleItems or {}
--     middleDatas = {}
--     local rewardCfg = Cfgs.RewardInfo:GetByID(cfg.rewardId) 
--     local benefit = buildData:GetBenefit()
--     for i, id in ipairs(g_CraftingCenterItems) do
--         -- 效率 
--         local num1 = 0
--         for k, m in ipairs(rewardCfg.item) do
--             if (m.id == id) then
--                 num1 = m.count
--                 break
--             end
--         end
--         local num2 = math.ceil(cfg.rewardDiff / 60)
--         -- add
--         local roleAbilitys = buildData:GetData().roleAbilitys or {}
--         local per = roleAbilitys[id] or 0
--         per = benefit * ((100 + per)) - 100 -- 总效率   (a-b)如果结果是小数，会出问题 https://blog.csdn.net/weixin_43284350/article/details/118312126
--         local num1Add, color = "", FFCC00
--         if (per ~= 0) then
--             if (per > 0) then
--                 num1Add = "+" .. math.floor(num1 * per / 100)
--             else
--                 num1Add = math.floor(num1 * per / 100)
--                 color = "FF0040"
--             end
--         end
--         local num1AddStr = per ~= 0 and StringUtil:SetByColor(num1Add, color) or ""
--         local ratioStr = string.format("%s/%s MIN", num1 .. num1AddStr, num2)
--         -- 当前数量/上限
--         arrGifts = buildData:GetMaterials()
--         local count = 0
--         for k, m in ipairs(arrGifts) do
--             if (m.id == id) then
--                 count = count + m.num
--             end
--         end
--         local countMax = 1
--         for k, m in ipairs(cfg.rewardLimits) do
--             if (m[1] == id) then
--                 countMax = m[2]
--                 break
--             end
--         end
--         table.insert(middleDatas, {id, ratioStr, count, countMax})
--     end
--     ItemUtil.AddItems("Matrix/MatrixResItem2", middleItems, middleDatas, materialGrids2, ItemClickCB2, 1, nil,
--         function()
--             ItemAnims()
--         end)
-- end

function ItemAnims()
    if (isFirst) then
        return
    end
    isFirst = 1
    for i, v in ipairs(middleItems) do
        local delay = (i - 1) * 20
        UIUtil:SetObjFade(v.bg, 0, 1, nil, 300, delay)
        local y1 = -i * 20
        UIUtil:SetPObjMove(v.bg, 0, 0, y1, 0, 0, 0, nil, 200, delay)
    end
end

function ItemClickCB2(rewardId)
    local _id = buildData:GetId()
    local _giftsIds = {}
    local gifts = buildData:GetData().gifts
    if (gifts) then
        if (gifts[rewardId]) then
            table.insert(_giftsIds, rewardId)
        end
    end
    local _giftsExIds = {}
    local giftsEx = buildData:GetData().giftsEx
    if (giftsEx) then
        if (giftsEx[rewardId]) then
            table.insert(_giftsExIds, rewardId)
        end
    end
    if (#_giftsIds > 0 or #_giftsExIds > 0) then
        BuildingProto:GetOneReward(_id, _giftsIds, _giftsExIds)
    end
end

-- --设置素材 
-- function SetRes()
-- 	arrGifts = buildData:GetMaterials()
-- 	local giftsDic = {}
-- 	for i, v in ipairs(arrGifts) do
-- 		giftsDic[v.id] = v.num
-- 	end
-- 	for i = 1, 4 do
-- 		CSAPI.SetGOActive(this["Image" .. i], i <= #arrGifts)
-- 	end
-- 	grids = grids and grids or {}
-- 	for i = #arrGifts + 1, #grids do
-- 		CSAPI.SetGOActive(grids[i].gameObject, false)
-- 	end
-- 	-- for i, v in ipairs(grids) do
-- 	-- 	CSAPI.SetGOActive(v.gameObject, false)
-- 	-- end
-- 	local rewardLimits = buildData:GetCfg().rewardLimits
-- 	local item, go = nil, nil
-- 	for i, v in ipairs(rewardLimits) do
-- 		if(i <= #grids) then
-- 			item = grids[i]
-- 			CSAPI.SetGOActive(item.gameObject, true)
-- 		else
-- 			go, item = ResUtil:CreateGridItem(materialGrids.transform)
-- 			table.insert(grids, item)
-- 		end
-- 		local fodderData = BagMgr:GetFakeData(v[1], v[2])
-- 		item.Refresh(fodderData)
-- 		local num = giftsDic[v[1]] and giftsDic[v[1]] or 0
-- 		item.SetCount(num)
-- 	end
-- grids = grids and grids or {}
-- for i, v in ipairs(grids) do
-- 	CSAPI.SetGOActive(v.gameObject, false)
-- end
-- local item, go = nil, nil
-- for i, v in ipairs(arrGifts) do
-- 	if(i <= #grids) then
-- 		item = grids[i]
-- 		CSAPI.SetGOActive(item.gameObject, true)
-- 	else
-- 		go, item = ResUtil:CreateGridItem(materialGrids.transform)
-- 		table.insert(grids, item)
-- 	end
-- 	local fodderData = BagMgr:GetFakeData(v.id, v.num)
-- 	item.Refresh(fodderData)
-- 	item.SetCount(v.num)
-- 	--item.SetClickCB(GridClickFunc.OpenInfo)
-- end
-- CSAPI.SetGOActive(btnGet, #arrGifts > 0)
-- end
-- function SetLList()
-- 	ids = {}
-- 	local rewardLimits = buildData:GetCfg().rewardLimits
-- 	lGrids = lGrids and lGrids or {}
-- 	for i = #rewardLimits + 1, #lGrids do
-- 		CSAPI.SetGOActive(lGrids[i].gameObject, false)
-- 	end
-- 	-- for i, v in ipairs(lGrids) do
-- 	-- 	CSAPI.SetGOActive(v.gameObject, false)
-- 	-- end
-- 	local item, go = nil, nil
-- 	for i, v in ipairs(rewardLimits) do
-- 		if(i <= #lGrids) then
-- 			item = lGrids[i]
-- 			CSAPI.SetGOActive(item.gameObject, true)
-- 		else
-- 			go, item = ResUtil:CreateGridItem(this["item" .. i].transform)
-- 			CSAPI.SetScale(go, 0.43, 0.43, 1)
-- 			table.insert(lGrids, item)
-- 		end
-- 		local fodderData = BagMgr:GetFakeData(v[1], v[2])
-- 		item.Refresh(fodderData)
-- 		item.SetCount()
-- 		local num = BagMgr:GetCount(v[1])
-- 		CSAPI.SetText(this["txtBase" .. i], num .. "")
-- 		--item.SetClickCB(GridClickFunc.OpenInfo)  
-- 		ids[v[1]] = i
-- 	end
-- end
-- function SetAdd(rewards)
-- 	CSAPI.SetGOActive(lGrid, rewards ~= nil)
-- 	if(rewards == nil) then
-- 		for i = 1, 3 do
-- 			CSAPI.SetText(this["txtAdd" .. i], "")
-- 		end
-- 	else
-- 		for i, v in ipairs(rewards) do
-- 			local index = ids[v.id]
-- 			CSAPI.SetText(this["txtAdd" .. index], "+" .. v.num)
-- 		end
-- 		timer = Time.time + 3
-- 		isShow = true
-- 	end
-- end
-- 获取
function OnClickGet()
    if (arrGifts and #arrGifts > 0) then
        -- BuildingProto:GetRewards({buildData:GetId()}, function(rewards)
        -- 	RefreshPanel()
        -- 	--SetAdd(rewards)
        -- end)
        BuildingProto:GetRewards({buildData:GetId()})
    end
end

