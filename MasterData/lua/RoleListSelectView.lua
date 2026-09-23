-- 角色列表 
local listType = RoleListType.Cool
local curCoolCid = nil
local curSelectDatas = {} -- 当前选择的冷却列表

local isAnimEnd = false -- 入场动画是否已展示完毕
-- local waitTime = 1      --等待1秒后开始右侧动画
local cur, max = 0, 0
local isAuto = false

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("RoleListSelectView",gameObject)
    layout = ComUtil.GetCom(sv, "UIInfinite")

    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/RoleLittleCard/RoleLittleCard", LayoutCallBack, true)
    animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)

    -- numTween = ComUtil.GetCom(curNum, "ActionTextRand")

    -- local iconName = Cfgs.ItemInfo:GetByID(CoolMgr:GetCoolID()).icon
    -- ResUtil.IconGoods:Load(money1, iconName, true)

    CSAPI.SetGOActive(resolveOnAnima, false)
    CSAPI.SetGOActive(sellInAnima, false)
    CSAPI.SetGOActive(btn_cool, false)
    CSAPI.SetGOActive(btn_select, false)
    CSAPI.SetGOActive(mask, false)

    -- 排序
    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Init(17, RefreshPanel)
    end)
end

local elseData = {}
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        local cid = _data:GetID()
        if (openSetting == RoleListType.TalentUp) then
            elseData.key = "TalentSelect"
            elseData.isSelect = false
            for i, v in ipairs(curSelectDatas) do
                if (v == cid) then
                    elseData.isSelect = true
                    break
                end
            end
        elseif (openSetting == RoleListType.Cool) then
            elseData.key = "Coll"
            elseData.ShowHot = true
            elseData.isSelect = false
            for i, v in ipairs(curSelectDatas) do
                if (v == cid) then
                    elseData.isSelect = true
                    break
                end
            end
        elseif (openSetting == RoleListType.Support) then
            elseData.key = "Support"
            local isSelect = false
            local isEqual = false
            if (curSelectDatas[_data:GetCfg().role_tag] ~= nil) then
                if (curSelectDatas[_data:GetCfg().role_tag] == _data:GetID()) then
                    isSelect = true
                else
                    isEqual = true
                end
            end
            elseData.isSelect = isSelect
            elseData.isEqual = isEqual
            elseData.isBlack = not isSelect and cur == 3
        elseif (openSetting == RoleListType.Expedition) then
            elseData.key = "Expedition"
            elseData.isSelect = curSelectDatas[_data:GetID()] and true or false
            elseData.isEqual = false
            if (not elseData.isSelect) then
                for i, v in pairs(curSelectDatas) do
                    if (v:GetCfgID() == _data:GetCfgID()) then
                        elseData.isEqual = true
                        break
                    end
                end
            end
        end

        elseData.checkRed = false
        elseData.isAnimEnd = isAnimEnd
        elseData.sortId = 17

        lua.SetClickCB(OnClickCard) -- 不使用事件的原因是如果RoleListView也打开时，会冲突
        lua.SetIndex(index)
        lua.Refresh(_data, elseData)
    end
end

function OnInit()
    UIUtil:AddTop2("RoleListSelectView", top, function()
        view:Close()
    end, nil, {})

    InitEvent()
end

function InitEvent()
    eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.Role_Card_GridAdd, SetCount)	
    -- 更新热值
    eventMgr:AddListener(EventType.CardCool_Update, function()
        layout:UpdateList()
    end)
end
function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end

function OnOpen()
    -- SetTabData()
    SetDatas()
    -- SetCount()

    RefreshPanel()
end

function RefreshPanel()
    -- SetDatas()
    ShowList()
    SetSelectCount()
    SetCoolMatcount()
    SetAuto()
    SetNeedCollMat()
end

-- -- 页签
-- function SetTabData()
--     -- 升降
--     orderType = RoleMgr:GetOrderType(openSetting)
--     local rota = orderType == RoleListOrderType.Up and 180 or 0
--     CSAPI.SetRectAngle(objSort, 0, 0, rota)
--     -- 排序,筛选
--     conditionData = RoleMgr:GetSortType(openSetting)
--     local id = conditionData.Sort[1]
--     local str = Cfgs.CfgRoleSortEnum:GetByID(id).sName or ""
--     CSAPI.SetText(txtSort, str)
-- end

---- 根据cfgId集合获取卡牌集合
function GetCardsByCfgID2(cfgIds, curId)
    local selectCards = {}
    local cards = RoleMgr:GetDatas()
    for i, v in pairs(cards) do
        if (v:GetID() ~= curId) then
            for k = 1, #cfgIds do
                if (v:GetCfgID() == cfgIds[k]) then
                    table.insert(selectCards, v)
                end
            end
        end
    end
    return selectCards
end

function GetNeedCfgIds(cardData, id)
    local cfg = Cfgs.skill:GetByID(id)
    local tCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(cardData:GetQuality())
    local uCfg = tCfg.infos[cfg.lv]
    local maxCount = uCfg.nFullCost
    local nItemsIds = {}
    if (uCfg and uCfg.nItemId) then
        table.insert(nItemsIds, uCfg.nItemId)
    end
    return nItemsIds, maxCount
end

-- 筛选数据
function SetDatas()
    cur = 0
    max = 0
    baseCurDatas = {}
    -- if (openSetting == RoleListType.TalentUp) then
    --     -- data {cid,talentId,ids,cb}
    --     curSelectDatas = {}
    --     table.copy(data.ids, curSelectDatas)
    --     local cardData = RoleMgr:GetData(data.cid)
    --     local needCfgIds, _maxCount = GetNeedCfgIds(cardData, data.talentId)
    --     table.insert(needCfgIds, cardData:GetCfgID())
    --     local datas = GetCardsByCfgID2(needCfgIds, data.cid) or {}
    --     for i, v in ipairs(datas) do
    --         if (RoleMgr:CheckCanShell(v)) then
    --             table.insert(baseCurDatas, v)
    --         end
    --     end
    --     if (#baseCurDatas > 1) then
    --         baseCurDatas = RoleSortUtil:SortByCondition(RoleListType.TalentUp, baseCurDatas)
    --     end
    --     cur = #data.ids
    --     max = _maxCount
    -- else
    if (openSetting == RoleListType.Support) then
        -- data {cb}
        curSelectDatas = {}
        local _cur = 0
        -- local sortData = {}
        local teamData = TeamMgr:GetTeamData(eTeamType.Assistance)
        for k, v in pairs(teamData.data) do
            local c = RoleMgr:GetData(v.cid);
            curSelectDatas[c:GetCfg().role_tag] = v.cid
            -- sortData[v.cid] = c
            _cur = _cur + 1
        end
        local _datas = RoleMgr:GetArr()
        for i, v in ipairs(_datas) do
            -- if (sortData[v:GetID()] == nil) then
            table.insert(baseCurDatas, v)
            -- end
        end
        -- if (#baseCurDatas > 1) then
        --     baseCurDatas = SortMgr:Sort(17, baseCurDatas) -- RoleSortUtil:SortByCondition(RoleListType.Support, baseCurDatas)
        -- end
        -- local sortDataArr = {}
        -- for i, v in pairs(sortData) do
        --     table.insert(sortDataArr, v)
        -- end
        -- if (#sortDataArr > 1) then
        --     sortDataArr = SortMgr:Sort(17, sortDataArr) -- RoleSortUtil:SortByCondition(RoleListType.Support, sortDataArr)
        -- end

        -- for i, v in ipairs(sortDataArr) do
        --     table.insert(baseCurDatas, 1, sortDataArr[#sortDataArr - i + 1])
        -- end

        cur = _cur
        max = 3
    elseif (openSetting == RoleListType.Expedition) then
        -- data {oldExpeditionData , cb }
        curSelectDatas = {}
        for i, v in ipairs(data.oldExpeditionData) do
            curSelectDatas[v:GetID()] = v
        end
        local _datas = RoleMgr:GetArr()
        for i, v in ipairs(_datas) do
            if (not v:IsInExpedition()) then
                table.insert(baseCurDatas, v)
            end
        end
        -- if (#baseCurDatas > 1) then
        --     baseCurDatas = SortMgr:Sort(17, baseCurDatas) -- RoleSortUtil:SortByCondition(RoleListType.Expedition, baseCurDatas)
        -- end
        cur = #data.oldExpeditionData
        max = 5
    end
end

function ShowList()
    curDatas = SortMgr:Sort(17, baseCurDatas)
    -- if (orderType == RoleListOrderType.Up) then
    --     local len = #baseCurDatas
    --     for k = len, 1, -1 do
    --         table.insert(curDatas, baseCurDatas[k])
    --     end
    -- else
    --     curDatas = baseCurDatas
    -- end
    -- animLua:AnimAgain()
    layout:IEShowList(#curDatas, FirstAnim, 1)

    CSAPI.SetGOActive(SortNone, #curDatas <= 0)
end

-- 首次调用完毕回调
function FirstAnim()
    if (not isAnimEnd) then
        isAnimEnd = true
        -- waitTime = 0
        CSAPI.SetGOActive(mask, false)

        SetBtns()
    end
end

function SetBtns()
    CSAPI.SetGOActive(btn_cool, openSetting == RoleListType.Cool)
    CSAPI.SetGOActive(btn_select, openSetting ~= RoleListType.Cool)

    CSAPI.SetGOActive(sellInAnima, openSetting == RoleListType.Cool)
    CSAPI.SetGOActive(resolveOnAnima, true)
end

-- 已选择是数量
function SetSelectCount()
    local cur = StringUtil:SetByColor(cur, "FFC146")
    CSAPI.SetText(txtSelectCount1, string.format("%s/%s", cur, max))
end

-- 加速冷却
function SetAuto()
    CSAPI.SetGOActive(allOn, isAuto)
end

-- 冷却素材的数量
function SetCoolMatcount()
    -- if(openSetting == RoleListType.Cool) then
    -- 	matName = Cfgs.ItemInfo:GetByID(CoolMgr:GetCoolID()).name
    -- 	local num = BagMgr:GetCount(CoolMgr:GetCoolID())
    -- 	CSAPI.SetText(txt_price1, num .. "")	
    -- 	if(num <= 0) then
    -- 		isAuto = false
    -- 	end
    -- end
end

function SetNeedCollMat()
    if (openSetting == RoleListType.Cool) then
        matName = matName or ""
        local _cur = isAuto and cur or 0
        LanguageMgr:SetText(txt_cool3, 3020, _cur, matName)
    end
end

-- --仓库容量
-- function SetCount()
-- 	numTween.targetStr = tostring(RoleMgr:GetCurSize())
-- 	numTween:Play();
-- 	CSAPI.SetText(maxNum, "/" .. RoleMgr:GetMaxSize())
-- end

function OnClickCard(_item)
    local curCardData = _item.cardData
    local cid = curCardData:GetID()
    if (openSetting == RoleListType.TalentUp or openSetting == RoleListType.Cool) then
        local isSelect = false
        for i, v in ipairs(curSelectDatas) do
            if (v == cid) then
                table.remove(curSelectDatas, i)
                isSelect = true
                break
            end
        end
        if (not isSelect) then
            if (max == 1) then
                if (#curSelectDatas > 0) then
                    table.remove(curSelectDatas, 1)
                end
                table.insert(curSelectDatas, cid)
            else
                if (#curSelectDatas < max) then
                    table.insert(curSelectDatas, cid)
                end
            end
        end
        cur = #curSelectDatas
    elseif (openSetting == RoleListType.Support) then
        local count = 0
        local isSelect = false
        for i, v in pairs(curSelectDatas) do
            if (v == cid) then
                isSelect = true
            end
            count = count + 1
        end

        if (isSelect) then
            curSelectDatas[curCardData:GetCfg().role_tag] = nil
        else
            if (count < 3) then
                curSelectDatas[curCardData:GetCfg().role_tag] = cid
            end
        end

        local count1 = 0
        for i, v in pairs(curSelectDatas) do
            count1 = count1 + 1
        end
        cur = count1
        -- CSAPI.SetText(txtSelectCount1, string.format("%s/%s", count1, 3))
    elseif (openSetting == RoleListType.Expedition) then
        -- 战斗中不可选
        if (TeamMgr:GetCardIsDuplicate(cid)) then
            LanguageMgr:ShowTips(1003)
            return
        end
        -- --冷却不可选
        -- if(CoolMgr:CheckIsIn(cid)) then
        -- 	LanguageMgr:ShowTips(1005)
        -- 	return
        -- end
        -- 队伍1队长不可选
        if (leadCid == nil) then
            local _data = TeamMgr:GetLeader(1)
            if (_data) then
                leadCid = _data:GetID()
            end
        end
        if (leadCid == cid) then
            LanguageMgr:ShowTips(1007)
            return
        end

        if (curSelectDatas[cid]) then
            curSelectDatas[cid] = nil
            cur = cur - 1
        else
            if (cur < 5) then
                curSelectDatas[cid] = curCardData
                cur = cur + 1
            end
        end
        -- CSAPI.SetText(txtSelectCount1, string.format("%s/%s", cur, 5))
    end
    layout:UpdateList()
    SetSelectCount()
    SetNeedCollMat()
end

-- 全部取消
function OnClickUnResolve()
    cur = 0
    curSelectDatas = {}
    RefreshPanel()
end
--[[
--加速冷却
function OnClickAuto()
	if(not isAuto) then
		local count = BagMgr:GetCount(CoolMgr:GetCoolID())
		if(count <= 0) then
			LanguageMgr:ShowTips(1004)
			return
		end
	end
	isAuto = not isAuto
	CSAPI.SetGOActive(allOn, isAuto)
	SetNeedCollMat()
end

--冷却
function OnClickCool()
	if(#curSelectDatas > 0) then
		local infos = {}
		local _count = BagMgr:GetCount(CoolMgr:GetCoolID())
		if(#curSelectDatas > _count and isAuto) then
			LanguageMgr:ShowTips(1004)
			return
		end
		--冷却加速
		local cb = isAuto and function()
			for i, v in ipairs(curSelectDatas) do
				if(i <= _count) then
					local b, _id = CoolMgr:CheckIsIn(v)
					local cost = {id = CoolMgr:GetCoolID(), num = 1, type = RandRewardType.ITEM}
					table.insert(infos, {index = _id, costs = {cost}})
				else
					break
				end
			end
			CoolMgr:CardCoolSpeedUp(infos)
		end or nil
		--冷却
		local infos2 = {}
		local allEmptyPos = CoolMgr:GetEmptyPos()
		for i, v in ipairs(curSelectDatas) do
			local _data = {cid = v, index = allEmptyPos[i]}
			table.insert(infos2, _data)
		end
		CoolMgr:CardCool(infos2, cb)
		
		view:Close()
	end
end
]]
-- 确认选择
function OnClickSelect()
    if (openSetting == RoleListType.Support) then
        data.cb(curSelectDatas)
    elseif (openSetting == RoleListType.TalentUp) then
        data.cb(curSelectDatas)
    elseif (openSetting == RoleListType.Expedition) then
        -- 移除出关卡队伍 todo
        local arr = {}
        for i, v in pairs(curSelectDatas) do
            table.insert(arr, v)
        end
        -- 是否存在已编队的卡牌
        local isContain = false
        for i, v in ipairs(arr) do
            local index = TeamMgr:GetCardTeamIndex(v:GetID())
            if index ~= -1 then
                isContain = true
                break
            end
        end

        if (isContain) then
            local dialogdata = {}
            dialogdata.content = "选择的卡牌中包含已编队的卡牌，是否离开编队？"
            dialogdata.okCallBack = function()
                ChangeTeam(arr)
                data.cb(arr)
            end
            CSAPI.OpenView("Dialog", dialogdata)
        else
            data.cb(arr)
        end
    end
    view:Close()
end

-- 刷新编队
function ChangeTeam(arr)
    local newDic = {}
    for i, v in ipairs(arr) do
        local index = TeamMgr:GetCardTeamIndex(v:GetID())
        if index ~= -1 then
            if (newDic[index]) then
                newDic[index]:RemoveCard(v:GetID())
            else
                local teamData = TeamMgr:GetTeamData(index)
                teamData:RemoveCard(v:GetID())
                newDic[index] = teamData
            end
        end
    end
    local newArr = {}
    for i, v in pairs(newDic) do
        table.insert(newArr, v)
    end

    if (#newArr > 0) then
        PlayerProto:SaveTeamList(newArr)
    end
end

--[[
-- 上下
function OnClickUD()
    orderType = orderType == RoleListOrderType.Up and RoleListOrderType.Down or RoleListOrderType.Up
    RoleMgr:SetOrderType(openSetting, orderType)
    local rota = orderType == RoleListOrderType.Up and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    ShowList()
end

-- 筛选
function OnClickFiltrate()
    local mData = {}
    -- 需要单选
    mData.single = {
        ["Sort"] = 1
    } -- 1无意义
    -- 由上到下排序
    mData.list = {"Sort", "RoleTeam", "RoleQuality", "RolePosEnum"} -- "RoleType", 
    -- 标题名(与list一一对应)
    mData.titles = {}
    -- for i = 3021, 3024 do
    -- 	table.insert(mData.titles, LanguageMgr:GetByID(i))
    -- end
    table.insert(mData.titles, LanguageMgr:GetByID(3021))
    table.insert(mData.titles, LanguageMgr:GetByID(3022))
    -- table.insert(mData.titles, LanguageMgr:GetByID(3023))
    table.insert(mData.titles, LanguageMgr:GetByID(3024))
    table.insert(mData.titles, LanguageMgr:GetByID(3027))

    -- 当前数据
    mData.info = conditionData
    -- 源数据
    local _root = {}
    _root.Sort = "CfgRoleSortEnum"
    _root.RoleTeam = "CfgTeamEnum"
    -- _root.RoleType = "CfgCore"
    _root.RoleQuality = "CfgCardQuality"
    _root.RolePosEnum = "CfgRolePosEnum"
    mData.root = _root
    -- 回调
    mData.cb = SortCB

    -- 卡牌排序类型  注意：非卡牌界面排序请注释 -------------------------------------
    mData.listType = openSetting

    CSAPI.OpenView("SortView", mData)
end
function SortCB(newInfo)
    conditionData = newInfo
    RoleMgr:SetSortType(openSetting, newInfo)
    OnOpen()
end
]]
-- --筛选
-- function OnClickFiltrate()
-- 	local mData = {}
-- 	--需要单选
-- 	mData.single = {["Sort"] = 1} --1无意义
-- 	--由上到下排序
-- 	mData.list = {"Sort", "RoleTeam", "RoleQuality"}--"RoleType"
-- 	--标题名(与list一一对应)
-- 	mData.titles = {}
-- 	for i = 3021, 3024 do
-- 		table.insert(mData.titles, LanguageMgr:GetByID(i))
-- 	end
-- 	table.insert(mData.titles, LanguageMgr:GetByID(3021))
-- 	table.insert(mData.titles, LanguageMgr:GetByID(3022))
-- 	--table.insert(mData.titles, LanguageMgr:GetByID(3023))
-- 	table.insert(mData.titles, LanguageMgr:GetByID(3024))
-- 	--当前数据
-- 	mData.info = conditionData
-- 	--源数据
-- 	local _root = {}
-- 	_root.Sort = "CfgRoleSortEnum"
-- 	--_root.RoleType = "CfgCore"
-- 	_root.RoleTeam = "CfgTeamEnum"
-- 	_root.RoleQuality = "CfgCardQuality"
-- 	mData.root = _root
-- 	--回调
-- 	mData.cb = SortCB

-- 	mData.listType = openSetting

-- 	CSAPI.OpenView("SortView", mData)
-- end
-- function SortCB(newInfo)
-- 	conditionData = newInfo
-- 	RoleMgr:SetSortType(openSetting, newInfo)

-- 	OnOpen()
-- 	-- SetTabData()
-- 	-- RefreshPanel()
-- end 
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    panelNode = nil;
    sv = nil;
    scrollbar = nil;
    scrollHandle = nil;
    root = nil;
    txtFiltrate = nil;
    btnUD = nil;
    objSort = nil;
    txtSort = nil;
    numObj = nil;
    txt_numTips = nil;
    curNum = nil;
    maxNum = nil;
    resolve = nil;
    btnResolve = nil;
    txtResolve1 = nil;
    txtResolve2 = nil;
    txtSelectCount1 = nil;
    txtSelectCount2 = nil;
    txtSelectCount3 = nil;
    resolveOnAnima = nil;
    sellObj = nil;
    btn_all = nil;
    allOn = nil;
    txt_auto = nil;
    moneyItem1 = nil;
    money1 = nil;
    txt_price1 = nil;
    sellInAnima = nil;
    btn_cool = nil;
    txt_cool1 = nil;
    txt_cool2 = nil;
    txt_cool3 = nil;
    coolIcon = nil;
    btn_select = nil;
    txt_select1 = nil;
    txt_select2 = nil;
    top = nil;
    mask = nil;
    view = nil;
end
----#End#----
