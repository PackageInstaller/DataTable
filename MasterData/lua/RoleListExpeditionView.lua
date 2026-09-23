--远征选人  
local listType = RoleListType.Expedition

local isAnimEnd = false --入场动画是否已展示完毕
--local waitTime = 1      --等待1秒后开始右侧动画
local cur, max = 0, 0

function Awake()	
	layout = ComUtil.GetCom(sv, "UIInfinite")
	
	--layout:AddBarAnim(0.4, false)
	layout:Init("UIs/RoleLittleCard/RoleLittleCard", LayoutCallBack, true)
	animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)
	
	CSAPI.SetGOActive(mask, false)
end


local elseData = {}
function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]	
		elseData.key = "Expedition"
		elseData.isSelect = curSelectDatas[_data:GetID()] and true or false
		elseData.isEqual = false
		-- if(not elseData.isSelect) then
		-- 	for i, v in pairs(curSelectDatas) do
		-- 		if(v:GetCfgID() == _data:GetCfgID()) then
		-- 			elseData.isEqual = true --是否同角色编成中
		-- 			break
		-- 		end
		-- 	end
		-- end
		elseData.checkRed = false
		elseData.isAnimEnd = isAnimEnd
		
		lua.SetClickCB(OnClickCard)--不使用事件的原因是如果RoleListView也打开时，会冲突
		lua.SetIndex(index)
		lua.Refresh(_data, elseData)
	end
end

function OnInit()
	UIUtil:AddTop2("RoleListExpeditionView", top, function() view:Close() end, nil, {})
end


function OnOpen()
	SetTabData()
	SetDatas()
	RefreshPanel()
end

function RefreshPanel()
	ShowList()
	SetSelectCount()
	SetConditions()
end

--页签
function SetTabData()
	--升降
	orderType = RoleMgr:GetOrderType(openSetting)
	local rota = orderType == RoleListOrderType.Up and 180 or 0
	CSAPI.SetRectAngle(objSort, 0, 0, rota)
	--排序,筛选
	conditionData = RoleMgr:GetSortType(openSetting)
	local id = conditionData.Sort[1]
	local str = Cfgs.CfgRoleSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
end


---- 根据cfgId集合获取卡牌集合
function GetCardsByCfgID2(cfgIds, curId)
	local selectCards = {}
	local cards = RoleMgr:GetDatas()
	for i, v in pairs(cards) do
		if(v:GetID() ~= curId) then
			for k = 1, #cfgIds do
				if(v:GetCfgID() == cfgIds[k]) then
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
	if(uCfg and uCfg.nItemId) then
		table.insert(nItemsIds, uCfg.nItemId)
	end
	return nItemsIds, maxCount
end

--筛选数据
function SetDatas()
	cur = 0
	max = 0
	baseCurDatas = {}
	
	--data {oldExpeditionData , cb }
	curSelectDatas = {}
	for i, v in ipairs(data.oldExpeditionData) do
		curSelectDatas[v:GetID()] = v
	end
	local _datas = RoleMgr:GetArr()
	for i, v in ipairs(_datas) do
		if(not v:IsInExpedition()) then
			table.insert(baseCurDatas, v)
		end
	end
	if(#baseCurDatas > 1) then
		baseCurDatas = RoleSortUtil:SortByCondition(RoleListType.Expedition, baseCurDatas)
	end
	cur = #data.oldExpeditionData
	max = 5
end


function ShowList()
	curDatas = {}
	if(orderType == RoleListOrderType.Up) then
		local len = #baseCurDatas
		for k = len, 1, - 1 do
			table.insert(curDatas, baseCurDatas[k])
		end
	else
		curDatas = baseCurDatas
	end
	animLua:AnimAgain()
	layout:IEShowList(#curDatas, FirstAnim, 1)
end


--首次调用完毕回调
function FirstAnim()
	if(not isAnimEnd) then
		isAnimEnd = true
		--waitTime = 0
		CSAPI.SetGOActive(mask, false)	
	end
end

--条件
function SetConditions()
	local selectCardDatas = {}
	for i, v in pairs(curSelectDatas) do
		table.insert(selectCardDatas, RoleMgr:GetData(i))
	end
	
	allIsEnough = true
	local startCondition = data.startCondition
	if(startCondition ~= nil) then
		for i = 1, 3 do
			if(i <= #startCondition) then
				local str = ""
				local v = startCondition[i]
				if(v[1] == ExpeditionTeamLimit.Lv) then
					str = LanguageMgr:GetByID(10408, v[3], v[2]) --队伍至少%s人%s级
				elseif(v[1] == ExpeditionTeamLimit.Num) then
					str = LanguageMgr:GetByID(10409, v[2]) --至少上阵%s个角色
				elseif(v[1] == ExpeditionTeamLimit.Class) then
					local cfg = Cfgs.CfgTeamEnum:GetByID(v[2])
					local s = cfg and cfg.sName or "XX"
					str = LanguageMgr:GetByID(10410, v[3], s) --上阵%s个%s小队的角色
				end
				local isEnough = MatrixMgr:CheckCondition(selectCardDatas, v)
				if(not isEnough) then
					allIsEnough = false
				end
				CSAPI.SetGOActive(this["txtCondition" .. i], true)
				CSAPI.SetGOActive(this["tick" .. i], isEnough)
				CSAPI.SetText(this["txtCondition" .. i], isEnough and StringUtil:SetByColor(str, "FFFFFF") or StringUtil:SetByColor(str, "ff8790"))
			else
				CSAPI.SetGOActive(this["txtCondition" .. i], false)
			end
		end
	end
	
	--btn
	if(not btnsCG) then
		btnsCG = ComUtil.GetCom(btnS, "CanvasGroup")
	end
	btnsCG.alpha = allIsEnough and 1 or 0.3
end

--已选择是数量
function SetSelectCount()
	CSAPI.SetText(txtSelect2, string.format("%s/%s", StringUtil:SetByColor(cur, "FFC146"), max))
end


function OnClickCard(_item)
	local curCardData = _item.cardData
	local cid = curCardData:GetID()
	if(openSetting == RoleListType.Expedition) then
		--战斗中不可选
		if(TeamMgr:GetCardIsDuplicate(cid)) then
			LanguageMgr:ShowTips(1003)
			return
		end
		-- --冷却不可选
		-- if(CoolMgr:CheckIsIn(cid)) then
		-- 	LanguageMgr:ShowTips(1005)
		-- 	return
		-- end
		--队伍1队长不可选
		if(leadCid == nil) then
			local _data = TeamMgr:GetLeader(1)
			if(_data) then
				leadCid = _data:GetID()
			end
		end
		if(leadCid == cid) then
			LanguageMgr:ShowTips(1007)
			return
		end
		
		if(curSelectDatas[cid]) then
			curSelectDatas[cid] = nil
			cur = cur - 1
		else
			if(cur < 5) then
				curSelectDatas[cid] = curCardData
				cur = cur + 1
			end
		end
	end
	layout:UpdateList()
	SetConditions()
	SetSelectCount()
end



--确认选择
function OnClickSelect()
	if(openSetting == RoleListType.Expedition) then
		--移除出关卡队伍 todo
		local arr = {}	
		for i, v in pairs(curSelectDatas) do
			table.insert(arr, v)
		end
		--是否存在已编队的卡牌
		local isContain = false
		for i, v in ipairs(arr) do
			local index = TeamMgr:GetCardTeamIndex(v:GetID())
			if index ~= - 1 then	
				isContain = true
				break
			end
		end
		
		if(isContain) then
			local dialogdata = {}
			dialogdata.content = LanguageMgr:GetByID(14016)--"选择的卡牌中包含已编队的卡牌，是否离开编队？"
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


--刷新编队
function ChangeTeam(arr)
	local newDic = {}
	for i, v in ipairs(arr) do
		local index = TeamMgr:GetCardTeamIndex(v:GetID())
		if index ~= - 1 then	
			if(newDic[index]) then
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
	
	if(#newArr > 0) then
		PlayerProto:SaveTeamList(newArr)
	end
end

--上下
function OnClickUD()
	orderType = orderType == RoleListOrderType.Up and RoleListOrderType.Down or RoleListOrderType.Up
	RoleMgr:SetOrderType(openSetting, orderType)
	local rota = orderType == RoleListOrderType.Up and 180 or 0
	CSAPI.SetRectAngle(objSort, 0, 0, rota)
	ShowList()
end


--筛选
function OnClickFiltrate()
	local mData = {}
	--需要单选
	mData.single = {["Sort"] = 1} --1无意义
	--由上到下排序
	mData.list = {"Sort", "RoleTeam", "RoleQuality", "RolePosEnum"}--"RoleType", 
	--标题名(与list一一对应)
	mData.titles = {}
	-- for i = 3021, 3024 do
	-- 	table.insert(mData.titles, LanguageMgr:GetByID(i))
	-- end
	table.insert(mData.titles, LanguageMgr:GetByID(3021))
	table.insert(mData.titles, LanguageMgr:GetByID(3022))
	--table.insert(mData.titles, LanguageMgr:GetByID(3023))
	table.insert(mData.titles, LanguageMgr:GetByID(3024))
	table.insert(mData.titles, LanguageMgr:GetByID(3027))
	
	--当前数据
	mData.info = conditionData
	--源数据
	local _root = {}
	_root.Sort = "CfgRoleSortEnum"
	_root.RoleTeam = "CfgTeamEnum"
	--_root.RoleType = "CfgCore"
	_root.RoleQuality = "CfgCardQuality"
	_root.RolePosEnum = "CfgRolePosEnum"
	mData.root = _root
	--回调
	mData.cb = SortCB
	
	--卡牌排序类型  注意：非卡牌界面排序请注释 -------------------------------------
	mData.listType = listType
	
	CSAPI.OpenView("SortView", mData)
end
function SortCB(newInfo)
	conditionData = newInfo
	RoleMgr:SetSortType(listType, newInfo)
	OnOpen()
end
