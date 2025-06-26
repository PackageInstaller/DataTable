-- chunkname: @IQIGame\\Module\\GMOrder2\\GMOrder2Module.lua

GMOrder2Module = {}

function GMOrder2Module.Init()
	GMOrder2Module.fatherNodeList = {}

	for i, v in pairs(CfgGmToolTable) do
		if v.ParentNode == 0 then
			table.insert(GMOrder2Module.fatherNodeList, v)
		end
	end

	GMOrder2Module._TapSort(GMOrder2Module.fatherNodeList)
end

function GMOrder2Module.ShutDown()
	return
end

function GMOrder2Module.GetFatherNode()
	if GMOrder2Module.fatherNodeList then
		return GMOrder2Module.fatherNodeList
	end
end

function GMOrder2Module.GetChildNodeWithID(ID)
	local childList = {}

	for i, v in pairs(CfgGmToolTable) do
		if v.ParentNode == ID then
			table.insert(childList, v)
		end
	end

	GMOrder2Module._TapSort(childList)

	return childList
end

function GMOrder2Module.GetTask(types)
	local tempList = {}

	for k, v in pairs(CfgTaskTable) do
		if TaskSystemModule.MatchTask(v, types[1], table.subArray(types, 2, #types)) then
			table.insert(tempList, v)
		end
	end

	table.sort(tempList, function(a, b)
		return a.Id < b.Id
	end)

	return tempList
end

function GMOrder2Module.GetGlobalBuff(types)
	local tempList = {}

	for k, v in pairs(CfgGlobalBuffTable) do
		table.insert(tempList, v)
	end

	table.sort(tempList, function(a, b)
		return a.Id < b.Id
	end)

	return tempList
end

function GMOrder2Module.GetStage(type)
	local cfg = {}

	if type == GMConditionType.PlotDupStage or type == GMConditionType.BranchLineStage then
		cfg = CfgWorldMapItemTable
	elseif type == GMConditionType.DailyDupStage then
		cfg = CfgDailyDupStageTable
	elseif type == GMConditionType.EquipDupStage then
		cfg = CfgEquipDupStageTable
	elseif type == GMConditionType.BossStage then
		cfg = CfgBossStageTable
	elseif type == GMConditionType.TowerStage then
		cfg = CfgTowerStageTable
	elseif type == GMConditionType.SummerStage then
		cfg = CfgWorldMapItemTable
	end

	local stageList = {}

	for i, v in pairs(cfg) do
		if type == GMConditionType.PlotDupStage then
			if v.Type == Constant.MapStageType.MainLine then
				table.insert(stageList, v)
			end
		elseif type == GMConditionType.BranchLineStage then
			if v.Type == Constant.MapStageType.BranchLine then
				table.insert(stageList, v)
			end
		elseif type == GMConditionType.SummerStage then
			if v.Type == Constant.MapStageType.Summer then
				table.insert(stageList, v)
			end
		else
			table.insert(stageList, v)
		end
	end

	table.sort(stageList, function(a, b)
		return a.Id < b.Id
	end)

	return stageList
end

function GMOrder2Module.GetItemWithType(ConditionArr)
	local set = GMOrder2Module._ArrToHash(ConditionArr)
	local ItemList = {}

	for i, v in pairs(CfgItemTable) do
		if v.ItemTypes == set[v.ItemTypes] then
			table.insert(ItemList, v)
		end
	end

	table.sort(ItemList, function(a, b)
		return a.Id < b.Id
	end)

	return ItemList
end

function GMOrder2Module.SendCMD(content)
	local CChatPOD = {}

	CChatPOD.channel = 3
	CChatPOD.type = 1
	CChatPOD.target = ""
	CChatPOD.content = content

	net_centerChat.sendChat(CChatPOD)
	log("发送GM命令：" .. CChatPOD.content)
	NoticeModule.ShowNotice(14008)
end

function GMOrder2Module._ArrToHash(Arr)
	local set = {}

	for i, v in pairs(Arr) do
		set[tonumber(v)] = tonumber(v)
	end

	return set
end

function GMOrder2Module._TapSort(tb)
	table.sort(tb, function(a, b)
		return a.NodeIndex > b.NodeIndex
	end)
end

function GMOrder2Module.ExecuteMethod(nodeType)
	local result = false

	if nodeType == 1001 then
		result = true
	end

	return result
end
