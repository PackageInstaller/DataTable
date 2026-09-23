--远征 (不耗电的所以不会停止)
local MatrixExpeditionInfo = require "MatrixExpeditionInfo"
local curIndex = 1

function OnInit()
	UIUtil:AddTop2("MatrixExpedition", gameObject, function() view:Close() end, nil, {})
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Matrix_Building_Update, function()
		RefreshPanel()
		SetTabRed()
	end)
end

function OnDestroy()
	eventMgr:ClearListener()
end

function OnOpen()
	RefreshPanel()
end


function RefreshPanel()
	SetDatas()
	SetTab()
	if(isFirst == nil) then
		isFirst = true
		tab.selIndex = curIndex or 0
	else
		SetItems()
	end
end

function SetTab()
	if(not tabItems) then
		tabItems = {}
		local tabDatas = {}
		for i = 1, 3 do
			local cfg = Cfgs.CfgExpeditionTask:GetByID(i)
			table.insert(tabDatas, cfg)
		end
		ItemUtil.AddItems("Matrix/MatrixExpeditionTab", tabItems, tabDatas, tabGrid, TabItemClick, 1, curIndex, SetTabRed)
		ItemAnims()
	end
end
function TabItemClick(_index)
	if(curIndex == _index) then
		return
	end
	tabItems[curIndex].Select(false)
	curIndex = _index
	tabItems[curIndex].Select(true)
	SetItems()
	for i, v in ipairs(listItems) do
		v.SetUnSelect()
	end
end
--tab
function SetTabRed()
	for k = 1, 3 do
		local b = false
		for i, v in pairs(giftDatas) do
			if((k == v.cfgId) or(k == 1 and v.cfgId == 4)) then --类型4属于类型1的子类型
				if(v.endTime == nil and(v.num == nil or v.num <= TimeUtil:GetTime())) then
					b = true
					break
				end
			end
		end
		tabItems[k].SetRed(b)
	end
end
function ItemAnims()
	if(isFirst) then
		return
	end
	isFirst = 1
	for i, v in ipairs(tabItems) do
		local delay =(i - 1) * 20
		UIUtil:SetObjFade(v.clickNode, 0, 1, nil, 300, delay)
		local y1 = - i * 20
		UIUtil:SetPObjMove(v.clickNode, 0, 0, y1, 0, 0, 0, nil, 200, delay)
	end
end


--混合数据
function SetDatas()
	giftDatas = {}	
	local hadCount = 0
	local _data = data:GetData()
	--已开始的
	local gifts = _data and _data.gifts or {}
	for i, v in pairs(gifts) do
		for k, m in pairs(v) do
			local key = i .. "_" .. k
			giftDatas[key] = m
			giftDatas[key].cfgId = i
			hadCount = hadCount + 1
		end
	end
	local max = data:GetCfg().teamCntLimit
	CSAPI.SetText(txtCount, string.format("%s/%s", max - hadCount, max))
	--未开始的
	local giftsEx = _data and _data.giftsEx or {}
	for i, v in pairs(giftsEx) do
		for k, m in pairs(v) do
			local key = i .. "_" .. k
			--筛选掉已开始的任务
			if(not giftDatas[key]) then
				giftDatas[key] = {id = m.id, endTime = v.num or 0}
				giftDatas[key].cfgId = i
			end	
		end
	end
end

function SetItems()
	datas = {}
	for i, v in pairs(giftDatas) do
		if((curIndex == v.cfgId) or(curIndex == 1 and v.cfgId == 4)) then --类型4属于类型1的子类型
			local subId, subIndex = GCalHelp:SplitEdnTaskId(v.id)
			local cfgs = Cfgs.CfgExpeditionTaskSub:GetByID(subId)
			local cfg = cfgs.tasks[subIndex]
			local _data = MatrixExpeditionInfo.New()
			_data:SetData(cfg, v, data:GetId(), i)
			table.insert(datas, _data)
		end
	end
	
	if(#datas > 1) then
		table.sort(datas, function(a, b)
			return a:GetSortIndex() < b:GetSortIndex()
		end)
	end
	listItems = listItems or {}
	ItemUtil.AddItems("Matrix/MatrixExpeditionItem", listItems, datas, Content, ItemClickCB, 1, data)
end

function ItemClickCB(_item)
	for i, v in ipairs(listItems) do
		if(v.data:GetSortIndex() ~= _item.data:GetSortIndex()) then
			v.SetUnSelect()
		end
	end
end
