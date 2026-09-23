-- 角色列表  正常打开+分解
local listType = RoleListType.Normal
local curTab = nil
-- local sellRewardIDs = {10001, 10005}
-- local isAuto = false
-- local canAutoCount = 0
-- local isInLock = false  --批量锁定中
local curState = 0 -- 当前状态 0：无状态  1：分解  2：批量锁定
-- local lockSelectIDs = {} --当前选择的批量锁定的id(变动的)
-- local resolveSelectIDs = {}
-- local curResolveNum = 0
-- local resolveMax = 40   --分解选择上限
local recordBeginTime = 0
local isAnimEnd = false -- 动画是否已展示完毕
-- local scrollBarIsShow=true
function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("RoleListNormal", gameObject)
    -- 记录
    recordBeginTime = CSAPI.GetRealTime()

    layout = ComUtil.GetCom(sv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/RoleCard/RoleCard", LayoutCallBack, true)
    animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal, "showlvbar")

    -- InitScrollBarAnima()
    -- numTween = ComUtil.GetCom(curNum, "ActionTextRand")
    -- 出售获得
    -- local iconName = Cfgs.ItemInfo:GetByID(sellRewardIDs[1]).icon
    -- ResUtil.IconGoods:Load(money1, iconName)
    -- local iconName2 = Cfgs.ItemInfo:GetByID(sellRewardIDs[2]).icon
    -- ResUtil.IconGoods:Load(money2, iconName2)
    CSAPI.SetGOActive(mask, true)

    -- 试玩时的缓存
    local cacheSortData = RoleMgr:GetRoleListSortData()
    if (cacheSortData) then
        SortMgr:SetData(1, cacheSortData)
    end
    RoleMgr:ClearRoleListSortData()

    -- 排序
    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Init(1, RefreshPanel)
    end)
end

local elseData = {}
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        -- if(curState == 1) then
        -- 	elseData.key = "IsInSell"
        -- 	elseData.isSelect = resolveSelectIDs[_data:GetID()] ~= nil and true or false
        -- elseif(curState == 2) then
        -- 	elseData.key = "IsInLock"
        -- 	local isSelect = lockSelectIDs[_data:GetID()] ~= nil
        -- 	local lockState = RoleMgr:GetData(_data:GetID()):IsLock()
        -- 	if(lockState) then
        -- 		elseData.isSelect = not isSelect
        -- 	else
        -- 		elseData.isSelect = isSelect
        -- 	end
        -- else
        -- 	elseData = {}
        -- end
        elseData.checkRed = true
        elseData.isAnimEnd = isAnimEnd
        elseData.listType = listType
        lua.SetIndex(index)
        lua.Refresh(_data, elseData)
        if (index == 1) then
            local x1, y1 = CSAPI.GetAnchor(lua.gameObject)
            CSAPI.SetAnchor(firstPoint, x1, y1, 0)
        end
    end
end

function OnInit()
    UIUtil:AddTop2("RoleListNormal", top, function()
        -- if(curState ~= 0) then
        -- 	if(curState == 1) then
        -- 		OnClickReturn()
        -- 	else
        -- 		OnClickLock()
        -- 	end
        -- else
        view:Close()
        -- end
    end, nil, {})
    InitEvent()
end

function InitEvent()
    eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.Role_Card_GridAdd, SetCount)    --格子
    eventMgr:AddListener(EventType.Role_Card_Add, RefreshPanel) -- 卡牌添加
    -- eventMgr:AddListener(EventType.Role_Card_Delete, RefreshPanel) --卡牌删除
    eventMgr:AddListener(EventType.Role_Card_Change, NextCard) -- 卡牌切换
    eventMgr:AddListener(EventType.Role_Card_Click, OnClickCard) -- 点击卡牌
    -- 分解
    -- eventMgr:AddListener(EventType.Role_Create_Disintegrate, function(proto)
    -- 	if(proto) then
    -- 		equip_ids = proto.equip_ids
    -- 		if(proto.rewards and #proto.rewards > 0) then
    -- 			UIUtil:OpenReward({proto.rewards})
    -- 		end
    -- 	end
    -- 	--isAuto = false
    -- 	resolveSelectIDs = {}
    -- 	curResolveNum = 0
    -- 	RefreshPanel()
    -- end)
    -- 关闭装备界面（刷新属性等信息，因为没推送卡牌更新）
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    -- eventMgr:AddListener(EventType.Role_Card_Lock, EClickLock)
    -- 喜好标签
    -- eventMgr:AddListener(EventType.Role_Tag_Update, function()
    -- 	layout:UpdateList()
    -- end)
    eventMgr:AddListener(EventType.RewardPanel_Post_Close, function()
        if (equip_ids and #equip_ids > 0) then
            print("弹出装备回收界面 todo")
        end
    end)
    -- eventMgr:AddListener(EventType.Role_Skill_Update, ESkillUp)
    -- new
    eventMgr:AddListener(EventType.Card_Update, CardUpdate)

    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    -- eventMgr:AddListener(EventType.Bag_SellQuality_Change, OnSellQualityChange);
    eventMgr:AddListener(EventType.Role_Captain_ToFirst, function()
        local roleListData = table.copy(SortMgr:GetData(1))
        roleListData["Filter"]["CfgTeamEnum"] = {8}
        SortMgr:SetData(1, roleListData)
        RefreshPanel()
    end)
    eventMgr:AddListener(EventType.MainTalent_Upgrade, RefreshPanel)
end

function OnDestroy()
    eventMgr:ClearListener()
    -- resolveSelectIDs = nil
    -- lockSelectIDs = nil
    RecordMgr:Save(RecordMode.View, recordBeginTime, "ui_id=" .. RecordViews.Role)
    -- ReleaseCSComRefs()
end

-- 刷新红点(技能完成)
function OnRedPointRefresh()
    layout:UpdateList()
end

-- 卡牌更新
function CardUpdate(_data)
    -- if(_data.type == CardUpdateType.CardLockRet) then
    -- 	curState = 0
    -- 	lockSelectIDs = {}
    -- 	RefreshPanel()
    -- 	return
    -- end
    local cid = _data.cid
    if (cid) then
        -- for i, v in ipairs(curDatas) do
        -- 	if(v:GetID() == cid) then
        -- 		layout:UpdateOne(i)
        -- 		break
        -- 	end
        -- end	
        -- 重现排序
        -- RefreshPanel() --会打乱顺序导致左右滑显示错误
        layout:UpdateList()
    end
    if(_data and _data.type == CardUpdateType.MainTalentUpgradeRet) then
        SetTX()
    end
end

function OnOpen()
    -- if(openSetting and openSetting == 2) then
    -- 	--分解
    -- 	curState = 2
    -- 	RefreshPanel()
    -- else
    RefreshPanel()
    -- end
    CSAPI.PlayUISound("ui_window_open_load")
end

function RefreshPanel()
    -- SetTabData()
    -- SetDatas()
    ShowList()
    -- SetBtns()
    -- SetCount()
    -- SetSellInfo()
    SetTX()
end

function SetTX()
    txArr = {}
    local datas = RoleMgr:GetDatas()
    for k, v in pairs(datas) do
        if (v:CheckPassiveUpOnlyChip()) then
            table.insert(txArr, v)
        end
    end
    CSAPI.SetGOActive(btnTX, #txArr > 0)
    if (#txArr > 0) then
        CSAPI.SetText(txtTX, #txArr .. "")
    end
end

function OnClickTX()
    CSAPI.OpenView("RoleListTX", txArr)
end

-- -- 页签数据
-- function SetTabData()
--     if (curState == 1) then
--         listType = RoleListType.Resolve
--     else
--         listType = RoleListType.Normal
--     end
--     -- 升降
--     orderType = RoleMgr:GetOrderType(listType)
--     local rota = orderType == RoleListOrderType.Up and 0 or 180
--     CSAPI.SetRectAngle(objSort, 0, 0, rota)
--     -- 排序,筛选
--     conditionData = RoleMgr:GetSortType(listType)
--     local id = conditionData.Sort[1]
--     local str = Cfgs.CfgRoleSortEnum:GetByID(id).sName or ""
--     CSAPI.SetText(txtSort, str)
-- end

-- function SetBtns()
-- lock
-- CSAPI.SetGOActive(btnLock, curState == 0)
-- CSAPI.SetGOActive(btnLockOn, curState == 2)
-- --sell
-- CSAPI.SetGOActive(btn_sell, curState ~= 2)
-- sellObj
-- if(isAnimEnd) then
-- 	CSAPI.SetGOActive(sellInAnima, curState == 1)
-- 	CSAPI.SetGOActive(sellOutAnima, curState ~= 1)
-- end
-- resolve
-- CSAPI.SetGOActive(resolveOnAnima, curState == 1)
-- CSAPI.SetGOActive(resolveOutAnima, curState ~= 1)
-- local id = curState == 1 and "3009" or "3013"
-- LanguageMgr:SetText(txt_sell1, id)
-- CSAPI.SetGOActive(btnLock, curState ~= 1)
-- CSAPI.SetGOActive(numObj, curState ~= 1)
-- CSAPI.SetGOActive(lockHight, curState == 2)
-- CSAPI.SetGOActive(btn_sell, curState ~= 2)
-- CSAPI.SetGOActive(sellObj, curState == 1)
-- if(curState ~= 2) then
-- 	SetSellStyle()
-- end
-- end
-- --设置出售样式
-- function SetSellStyle()
-- 	if curState == 0 then
-- 		CSAPI.SetImgColor(btn_sell, 235, 200, 46, 255)
-- 		CSAPI.SetText(txt_sell, StringConstant.role_3)
-- 		CSAPI.SetTextColor(txt_sell, 0, 0, 0, 255)
-- 	else
-- 		CSAPI.SetImgColor(btn_sell, 0, 0, 0, 55)
-- 		CSAPI.SetText(txt_sell, StringConstant.role_159)
-- 		CSAPI.SetTextColor(txt_sell, 255, 255, 255, 255)
-- 	end
-- end
-- --仓库容量
-- function SetCount()
-- 	--if(curState == 0) then
-- 	--CSAPI.SetText(curNum, RoleMgr:GetCurSize() .. "")
-- 	numTween.targetStr = tostring(RoleMgr:GetCurSize())
-- 	numTween:Play();
-- 	CSAPI.SetText(maxNum, "/" .. RoleMgr:GetMaxSize())
-- 	--end
-- end
-- function SetDatas()
--     -- datas = {}
--     -- local arr = RoleMgr:GetArr()
--     -- local datas = RoleSortUtil:SortByCondition(listType, arr)

--     datas = SortMgr:Sort(1, RoleMgr:GetDatas())
-- end

function ShowList()
    -- curDatas = {}
    -- if (orderType == RoleListOrderType.Up) then
    --     local len = #datas
    --     for k = len, 1, -1 do
    --         table.insert(curDatas, datas[k])
    --     end
    -- else
    --     curDatas = datas
    -- end

    curDatas = SortMgr:Sort(1, RoleMgr:GetDatas())
    CSAPI.SetGOActive(SortNone, #curDatas <= 0)

    -- 试玩，首次打开时追踪之前展示的卡牌的位置，并且打开详情
    if (openSetting and openSetting == 3 and data and not isFirstOpen) then
        isFirstOpen = true
        curIndex = 1
        for i, v in ipairs(curDatas) do
            if (v:GetID() == data:GetID()) then
                curIndex = i
                break
            end
        end
        -- animLua:AnimAgain()
        layout:IEShowList(#curDatas, FirstAnim, curIndex)
        CSAPI.OpenView("RoleInfo", data)
    else
        -- if(not isFirst) then 
        -- 	isFirst = true 
        -- 	animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal, "showlvbar")
        -- end
        -- animLua:AnimAgain()
        layout:IEShowList(#curDatas, FirstAnim, 0)
    end
end

-- 首次调用完毕回调
function FirstAnim()
    if (not isAnimEnd) then
        isAnimEnd = true
        CSAPI.SetGOActive(mask, false)
    end
end

-- 点击卡牌
function OnClickCard(_item)
    curIndex = _item.index
    curCardData = _item.cardData
    -- 分解页面
    -- if(curState == 1) then
    -- 	local isSelect = resolveSelectIDs[curCardData:GetID()] ~= nil
    -- 	if(isSelect or curResolveNum < resolveMax) then
    -- 		if(isSelect) then
    -- 			resolveSelectIDs[curCardData:GetID()] = nil
    -- 			curResolveNum = curResolveNum - 1
    -- 		else
    -- 			resolveSelectIDs[curCardData:GetID()] = 1
    -- 			curResolveNum = curResolveNum + 1
    -- 		end
    -- 		_item.SetSelectAnim(not isSelect)
    -- 		-- if(curResolveNum >= resolveMax) then
    -- 		-- 	isAuto = true
    -- 		-- end
    -- 		SetSellInfo()
    -- 	else
    -- 		--Tips.ShowTips(StringTips.role_tips4)
    -- 		LanguageMgr:ShowTips(3002)
    -- 	end
    -- elseif(curState == 2) then
    -- 	--local 
    -- 	--锁与解锁
    -- 	if(lockSelectIDs[curCardData:GetID()]) then
    -- 		lockSelectIDs[curCardData:GetID()] = nil
    -- 	else
    -- 		lockSelectIDs[curCardData:GetID()] = 1
    -- 	end
    -- 	--
    -- 	local isSelect = lockSelectIDs[curCardData:GetID()] ~= nil
    -- 	local lockState = RoleMgr:GetData(curCardData:GetID()):IsLock()
    -- 	local b = false
    -- 	if(isSelect) then
    -- 		if(lockState) then
    -- 			b = false
    -- 		else
    -- 			b = true
    -- 		end
    -- 	else
    -- 		if(lockState) then
    -- 			b = true
    -- 		else
    -- 			b = false
    -- 		end
    -- 	end
    -- 	_item.SetSelectAnim(b)
    -- else
    CSAPI.OpenView("RoleInfo", curCardData)
    -- end
end

-----------------------------
function NextCard(isNext)
    if (curIndex) then
        if (isNext) then
            if (curIndex + 1 <= #curDatas) then
                curIndex = curIndex + 1
            else
                return
            end
        else
            if (curIndex - 1 > 0) then
                curIndex = curIndex - 1
            else
                return
            end
        end
        curCardData = curDatas[curIndex]
        EventMgr.Dispatch(EventType.Role_Card_ChangeResult, curCardData)
    end
end

-- function OnClickAdd()
-- 	if(RoleMgr:GetMaxSize() < g_CardGridMaxSize) then
-- 		CSAPI.OpenView("AddGridView")
-- 	else
-- 		--Tips.ShowTips(StringConstant.role_60)
-- 		LanguageMgr:ShowTips(3000)
-- 	end
-- end
-- 其它界面关闭
function OnViewClosed(viewKey)
    if (viewKey == "RoleInfo") then
        layout:UpdateList()
    end
end

-- --批量锁定或解锁
-- function OnClickLock()
-- 	if(curState == 0) then
-- 		curState = 2
-- 		RefreshPanel()
-- 	elseif(curState == 2) then
-- 		local datas = {}
-- 		for k, v in pairs(lockSelectIDs) do
-- 			local lockState = RoleMgr:GetData(k):IsLock()
-- 			local data = {}
-- 			data.cid = k
-- 			data.lock = lockState and eLockState.No or eLockState.Yes
-- 			table.insert(datas, data)
-- 		end
-- 		if(#datas > 0) then
-- 			RoleMgr:CardLock(datas)
-- 		else
-- 			curState = 0
-- 			RefreshPanel()
-- 		end
-- 	end
-- end
-- --上锁回调
-- function EClickLock()
-- 	curState = 0
-- 	lockSelectIDs = {}
-- 	RefreshPanel()
-- end
---------------------------分解-----------------------------
-- --取消分解
-- function OnClickUnResolve()
-- 	if(curState ~= 0) then
-- 		OnClickReturn()
-- 	end
-- end
-- --核心分解
-- function OnClickResolve()
-- 	if(curState ~= 1) then
-- 		CSAPI.SetGOActive(resolveOnAnima, true)
-- 		CSAPI.SetGOActive(resolveOutAnima, false)	
-- 		CSAPI.SetGOActive(sellInAnima, true)
-- 		CSAPI.SetGOActive(sellOutAnima, false)
-- 		curState = 1
-- 		RefreshPanel()
-- 	elseif(curState == 1) then
-- 		OnClickSendSell()
-- 	end
-- end
-- --分解信息
-- function SetSellInfo()
-- 	if(curState == 1) then
-- 		local result = GetResult()
-- 		CSAPI.SetText(txt_price, result[1] .. "")
-- 		CSAPI.SetText(txt_price2, result[2] .. "")
-- 		local cur = StringUtil:SetByColor(curResolveNum, "FFC146")
-- 		CSAPI.SetText(txtSelectCount1, string.format("%s/%s", cur, resolveMax))
-- 		--CSAPI.SetGOActive(allOn, isAuto)
-- 	end
-- end
-- --自动选择
-- function OnClickAuto()
-- 	selectQualitys = selectQualitys or {}
-- 	CSAPI.OpenView("BagQualitySelect", selectQualitys)
-- end
-- --重新选择
-- function OnSellQualityChange(_selectQualitys)
-- 	resolveSelectIDs = {}
-- 	curResolveNum = 0
-- 	selectQualitys = _selectQualitys
-- 	local selectQualitysDic = {}
-- 	if(#selectQualitys > 0) then
-- 		for i, v in ipairs(selectQualitys) do
-- 			selectQualitysDic[v] = 1
-- 		end
-- 		for i, v in ipairs(curDatas) do
-- 			if(curResolveNum >= resolveMax) then
-- 				break
-- 			end
-- 			if(selectQualitysDic[v:GetQuality()] == 1 and v:GetCanAntoDelete()) then
-- 				resolveSelectIDs[v:GetID()] = 1
-- 				curResolveNum = curResolveNum + 1
-- 			end
-- 		end
-- 	end
-- 	RefreshPanel()
-- end
--[[--自动选择
function OnClickAuto()
	if(isAuto) then
		--此时已选满
		resolveSelectIDs = {}
		isAuto = false
		curResolveNum = 0
	else
		--补充选择
		local isMax = true --是否查看了所有角色
		local count = curResolveNum
		local baseCount = count
		if(orderType == RoleListOrderType.Up) then
			for i, v in ipairs(curDatas) do
				if(resolveSelectIDs[v:GetID()] == nil and count < resolveMax) then
					if(v:GetCanAntoDelete()) then
						resolveSelectIDs[v:GetID()] = 1
						count = count + 1
					end
				end
				if(count >= resolveMax) then
					if(count < #curDatas) then
						isMax = false
					end
					break
				end
			end
		else
			for i = #curDatas, 1, - 1 do
				local v = curDatas[i]
				if(resolveSelectIDs[v:GetID()] == nil and count < resolveMax) then
					if(v:GetCanAntoDelete()) then
						resolveSelectIDs[v:GetID()] = 1
						count = count + 1
					end
				end
				if(count >= resolveMax) then
					if(count < #curDatas) then
						isMax = false
					end
					break
				end
			end	
		end
		if(count <= 0 or baseCount == count) then
			--Tips.ShowTips(StringTips.role_tips6)
			LanguageMgr:ShowTips(3004)
		elseif(count >= resolveMax or isMax) then
			isAuto = true
		end
		curResolveNum = count
	end
	RefreshPanel()
end
]]
-- --存在以下情况也不能自动分解
-- function CheckCanShell(_data)
-- 	-- --星星
-- 	-- if(_data:GetQuality() > 3) then
-- 	-- 	return false
-- 	-- end
-- 	--常规
-- 	if(_data:GetLv() > 1 or
-- 	_data:GetEXP() > 0 or
-- 	_data:GetBreakLevel() > 1) then
-- 		return false
-- 	end
-- 	--技能
-- 	local skills = _data.data.skills
-- 	for i, v in pairs(skills) do
-- 		local cfg = Cfgs.skill:GetByID(v.id)
-- 		if(cfg == nil) then
-- 			LogError("找不到技能：" .. v.id)
-- 		end
-- 		if(cfg and cfg.lv > 1) then
-- 			return false
-- 		end
-- 	end
-- 	--主天赋
-- 	local ids = _data:GetSkills(SkillMainType.CardTalent)
-- 	if(#ids > 0) then
-- 		local id = ids and ids[1].id or nil
-- 		mainTalentData = id and Cfgs.skill:GetByID(id) or nil
-- 		if(mainTalentData and mainTalentData.lv > 1) then
-- 			return false
-- 		end
-- 	end
-- 	return true
-- end
-- --确认分解
-- function OnClickSendSell()	
-- 	if(curResolveNum <= 0) then
-- 		return
-- 	end
-- 	local ids = {}
-- 	for i, v in pairs(resolveSelectIDs) do
-- 		if(v == 1) then
-- 			table.insert(ids, i)
-- 		end
-- 	end
-- 	local isHeight = false
-- 	for i = 1, #ids do
-- 		local _data = RoleMgr:GetData(ids[i])
-- 		if(_data == nil) then
-- 			LogError("找不到卡牌,id：" .. ids[i])
-- 		end
-- 		if(_data and _data:GetQuality() > 3) then
-- 			isHeight = true
-- 			break
-- 		end
-- 	end
-- 	if(isHeight) then
-- 		CSAPI.OpenView("Dialog", {
-- 			content = LanguageMgr:GetTips(3001), --StringTips.role_tips2,
-- 			okCallBack = function()
-- 				resolveSelectIDs = {}
-- 				curResolveNum = 0
-- 				RoleMgr:CardDisintegrate(ids)
-- 			end
-- 		})
-- 	else
-- 		resolveSelectIDs = {}
-- 		curResolveNum = 0
-- 		RoleMgr:CardDisintegrate(ids)
-- 	end
-- end
-- --分解所获
-- function GetResult()
-- 	local tab = {0, 0}
-- 	for k, v in pairs(resolveSelectIDs) do
-- 		local _data = RoleMgr:GetData(k)
-- 		local soul = _data:GetCfg().decompose_soul
-- 		if(soul) then
-- 			for n, m in ipairs(soul) do
-- 				if(m[1] == sellRewardIDs[1]) then
-- 					tab[1] = tab[1] + m[2]
-- 				elseif(m[1] == sellRewardIDs[2]) then
-- 					tab[2] = tab[2] + m[2]
-- 				end
-- 			end
-- 		end
-- 	end
-- 	return tab
-- end
-- function OnClickReturn()
-- 	if(curState ~= 0) then
-- 		if(curState == 1) then
-- 			CSAPI.SetGOActive(resolveOnAnima, false)
-- 			CSAPI.SetGOActive(resolveOutAnima, true)
-- 			CSAPI.SetGOActive(sellInAnima, false)
-- 			CSAPI.SetGOActive(sellOutAnima, true)
-- 		end
-- 		curState = 0
-- 		--isAuto = false
-- 		resolveSelectIDs = {}
-- 		selectQualitys = {}
-- 		lockSelectIDs = {}
-- 		curResolveNum = 0
-- 		RefreshPanel()
-- 	else
-- 		view:Close()
-- 	end
-- end
-- --技能升级完成回调
-- function ESkillUp(_data)
-- 	if(_data and _data.cid) then
-- 		for i, v in ipairs(curDatas) do
-- 			if(v:GetID() == _data.cid) then
-- 				layout:UpdateOne(i)
-- 				break
-- 			end
-- 		end
-- 	end
-- end
-- -- 上下
-- function OnClickUD()
--     orderType = orderType == RoleListOrderType.Up and RoleListOrderType.Down or RoleListOrderType.Up
--     RoleMgr:SetOrderType(listType, orderType)
--     local rota = orderType == RoleListOrderType.Up and 0 or 180
--     CSAPI.SetRectAngle(objSort, 0, 0, rota)
--     ShowList()
-- end

-- -- 筛选
-- function OnClickFiltrate()
--     local mData = {}
--     -- 需要单选
--     mData.single = {
--         ["Sort"] = 1
--     } -- 1无意义
--     -- 由上到下排序
--     mData.list = {"Sort", "RoleTeam", "RoleQuality", "RolePosEnum"} -- "RoleType", 
--     -- 标题名(与list一一对应)
--     mData.titles = {}
--     -- for i = 3021, 3024 do
--     -- 	table.insert(mData.titles, LanguageMgr:GetByID(i))
--     -- end
--     table.insert(mData.titles, LanguageMgr:GetByID(3021))
--     table.insert(mData.titles, LanguageMgr:GetByID(3022))
--     -- table.insert(mData.titles, LanguageMgr:GetByID(3023))
--     table.insert(mData.titles, LanguageMgr:GetByID(3024))
--     table.insert(mData.titles, LanguageMgr:GetByID(3027))

--     -- 当前数据
--     mData.info = conditionData
--     -- 源数据
--     local _root = {}
--     _root.Sort = "CfgRoleSortEnum"
--     _root.RoleTeam = "CfgTeamEnum"
--     -- _root.RoleType = "CfgCore"
--     _root.RoleQuality = "CfgCardQuality"
--     _root.RolePosEnum = "CfgRolePosEnum"
--     mData.root = _root
--     -- 回调
--     mData.cb = SortCB

--     -- 卡牌排序类型  注意：非卡牌界面排序请注释 -------------------------------------
--     mData.listType = listType

--     CSAPI.OpenView("SortView", mData)
-- end
-- function SortCB(newInfo)
--     conditionData = newInfo
--     RoleMgr:SetSortType(listType, newInfo)
--     RefreshPanel()
-- end
