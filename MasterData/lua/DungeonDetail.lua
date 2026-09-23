local grids = {};
local itemLists = {}
local currData = nil;
local info = nil
local elseData = nil;
local enumItems = {}
local passNum = 0
local fixedNum = 0
local randomNum = 0
local txtTitle = nil
local tab = nil

function Awake()
	table.insert(enumItems, enumItem.gameObject)
	txtTitle = ComUtil.GetCom(txt_title, "TextCustom")

	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
end

function OnViewOpened(viewKey)
	if viewKey == "ShopView" then
		CloseView()
	end
end

function OnInit()
	tab = UIUtil:AddTop2("DungeonDetials", topParent, OnClickBack, nil, {})
	CSAPI.SetGOActive(tab.btn_home, false)
end

function OnOpen()
	Show(data[1], data[2])
end

function Show(_data, _elseData)
	CSAPI.DelayCall(function()
		CSAPI.PlayUISound("ui_popup_open")
	end, 100)
	
	CSAPI.SetGOActive(gameObject, true)
	info = _data;
	elseData = _elseData;
	local title = ""
	CSAPI.SetGOActive(sv, _elseData == DungeonDetailsType.Enemy and true or false);
	CSAPI.SetGOActive(mapObj, _elseData == DungeonDetailsType.Map and true or false);
	CSAPI.SetGOActive(passObj, _elseData == DungeonDetailsType.MainLineOutPut);
	CSAPI.SetGOActive(rewardSv, false)
	if _elseData == DungeonDetailsType.MainLineOutPut then
		--title = LanguageMgr:GetByID(15005)
		title = ""
		CSAPI.SetGOActive(root, true);
		CSAPI.SetGOActive(rewardSv, true)
		LanguageMgr:SetText(txt_pass, 15019)
		LanguageMgr:SetText(txt_fixed, 15041)
		LanguageMgr:SetText(txt_random, 15042)
		LanguageMgr:SetText(txt_little, 15044)
		CreateMainLineOutPutGrids();
	elseif _elseData == DungeonDetailsType.Enemy then
		title = LanguageMgr:GetByID(15006)
		CSAPI.SetGOActive(root, true);
		CreateEnemyGrids();
	elseif _elseData == DungeonDetailsType.Map then
		title = ""
		CSAPI.SetGOActive(root, false);
		if info then
			--ResUtil.MapIcon:Load(mapObj, info, false);
			info = "UIs/Map/" .. info .. "/" .. info
			ResUtil:LoadBigImg(map, info, true)
		end
		-- elseif _elseData == DungeonDetailsType.OutPut then
		-- 	CSAPI.SetGOActive(rewardSv, true)
		-- 	title = LanguageMgr:GetByID(15005)	
		-- 	CSAPI.SetGOActive(root, true);
		-- 	CreateOutPutGrids();		
	end
	txtTitle.text = title;
	-- local pos = _elseData == DungeonDetailsType.Map and {15, 248} or {- 785, 341}
	-- CSAPI.SetAnchor(txt_title, pos[1], pos[2])
	-- if info and _elseData ~= DungeonDetailsType.Map then
	ShowContent()
	-- end
end

function OnDisable()
	if grids then
		for k, v in ipairs(grids) do
			CSAPI.RemoveGO(v.gameObject);
		end
		grids = {};
	end	
	if itemLists then
		for k, v in ipairs(itemLists) do
			CSAPI.RemoveGO(v.gameObject);
		end
		itemLists = {};
	end
end

function ShowContent()
	if currData and elseData == DungeonDetailsType.Enemy then	
		CSAPI.SetText(txt_name, currData.cfg.name);
		CSAPI.SetText(txt_desc, currData.cfg.m_Desc)
		CSAPI.SetText(txt_lv, currData.level)
		--icon
		local modelCfg = Cfgs.character:GetByID(currData.cfg.model);
		if modelCfg then
			ResUtil.RoleCard:Load(icon, modelCfg.icon, true)
			CSAPI.SetScale(icon, 2, 2, 1)
		end
		SetEnumItem()
		CSAPI.SetGOActive(enemyObj, true)
		CSAPI.SetGOActive(lineObj, true)
	else
		CSAPI.SetGOActive(enemyObj, false)
		CSAPI.SetGOActive(lineObj, false)
	end
end

function SetEnumItem()
	local cfgEnums = currData.cfg.enum
	if cfgEnums and #cfgEnums > 0 then
		for i, v in ipairs(enumItems) do
			CSAPI.SetGOActive(v, false)
		end
		for i = 1, #cfgEnums do
			local go = nil
			if i <= #enumItems then
				go = enumItems[i]
				CSAPI.SetGOActive(go, true)
			else
				go = CSAPI.CloneGo(enumItems[1], enumObj.transform)				
			end
			if go then
				local text = ComUtil.GetComInChildren(go, "Text")
				local str = Cfgs.CfgMonsterEnum:GetByID(cfgEnums[i])	
				text.text = str.sName
			end
		end
	end
end

function CreateEnemyGrids()
	currData = info[1];
	CreateGrids(info, "DungeonDetail/DungeonEnemyItem", Content, DungeonDetailsType.Enemy);
	-- CSAPI.SetScriptEnable(sv, "ScrollRect", #info > 16)
end

function CreateOutPutGrids()
	local fixedList = {};
	if info then
		for k, v in ipairs(info) do
			local goodsData = GoodsData();
			goodsData:InitCfg(v);
			table.insert(fixedList, goodsData);
		end
	end
	currData = fixedList[1];
	CreateGrids(fixedList, "DungeonDetail/DungeonGoodsItem", passNode);
end

function CreateGrids(list, path, parent, _elseData)
	for k, v in ipairs(list) do
		ResUtil:CreateUIGOAsync(path, parent, function(go)
			local lua = ComUtil.GetLuaTable(go);
			--CSAPI.SetScale(go,0.8,0.8,0.8);
			lua.Refresh(v, _elseData);			
			lua.SetChoosie(v == currData);
			lua.SetClickCB(OnClickGrid);
			if _elseData == DungeonDetailsType.Enemy then
				lua.PlayFade(math.floor(k / 6))
			end
			table.insert(grids, lua);
		end);
	end
end

function CreateMainLineOutPutGrids()
	local firstList = GetFirstList();
	local secondList = GetFixedList();	
	local thirdList = GetRandomList()
	local fourthList = GetRewardCfgGoods(info.littleReward, true, GetElseData(4))
	local LanguageIDs = {LanguageMgr:GetByID(15019), LanguageMgr:GetByID(15041), LanguageMgr:GetByID(15042), LanguageMgr:GetByID(15044)}
	local lists = {firstList, secondList, thirdList, fourthList}

	for i, v in ipairs(LanguageIDs) do
		if(#lists[i] > 0) then
			ResUtil:CreateUIGOAsync("DungeonDetail/DungeonDetailList", rewardNode, function(go)
				local lua = ComUtil.GetLuaTable(go)
				lua.SetTweenDelay(i)
				lua.Refresh(lists[i])
				lua.ShowLine(i < 3)
				lua.SetTitle(v)
				table.insert(itemLists, lua)
			end)
		end
	end
end

--首通和三星
function GetFirstList()
	local list = GetRewardCfgGoods(info.fisrtPassReward,false,GetElseData(1));
	local starList = GetRewardCfgGoods(info.fisrt3StarReward,false,GetElseData(2));	
	if starList and #starList > 0 then
		for i, v in ipairs(starList) do
			table.insert(list,v)
		end
	end
	return list
end

--固定掉落列表
function GetFixedList()
	local specList,isFixed= RewardUtil.GetSpecialReward(info.group)
	local list = GetRewardCfgGoods(info.fixedReward, true)
	if not info.sub_type and specList and isFixed then
		local _list = GetRewardCfgGoods(specList,false,GetElseData(5))
		for i, v in ipairs(_list) do
			table.insert(list,i,v)
		end
	end
	return list
end

--概率掉落列表
function GetRandomList()
	local specList,isFixed= RewardUtil.GetSpecialReward(info.group)
	local list = GetRewardCfgGoods(info.randomReward, true)
	if not info.sub_type and specList and not isFixed then
		local _list = GetRewardCfgGoods(specList,false,GetElseData(5))
		for i, v in ipairs(_list) do
			table.insert(list,i,v)
		end
	end
	return list
end

function GetStarNum()
	local dungeonData = DungeonMgr:GetDungeonData(info.id)
	return dungeonData and dungeonData:GetStar() or 0
end

--读取掉落表中的信息
function GetRewardCfgGoods(list, isOnlyID, elseData)
	local tab = {};
	if list then
		local reward = {}
		for k, v in ipairs(list) do
			if isOnlyID then --只有物品id
				local goodsData = GoodsData();
				goodsData:InitCfg(v);
				table.insert(tab, {data = goodsData,elseData = elseData});
			else			
				local item = nil;
				reward = {v[1],v[2],v[3]}
				if reward[3] == nil then
					reward[3] = RandRewardType.ITEM
				elseif reward[3] == RandRewardType.TEMPLATE then
					reward[1] = GridUtil.GetGoodsID(reward)
					reward[3] = RandRewardType.ITEM
				end
				if reward[3] == RandRewardType.ITEM then
					item = GoodsData({id = reward[1], num = reward[2]});
				elseif reward[3] == RandRewardType.EQUIP then
					item = EquipData();
					item:InitCfg(reward[1]);
				elseif reward[3] == RandRewardType.CARD then
					item = RoleMgr:GetFakeData(reward[1], reward[2])
					item:InitCfg(reward[1]);					
				end
				table.insert(tab, {data = item,elseData = elseData});				
			end
		end
	end
	return tab
end
-- 1:首通 2：三星 3:概率 4：小概率 5：限时
function GetElseData(i, star)
	local star = GetStarNum()
	local eData = {
		tag = ITEM_TAG.FirstPass,
		isPass = star > 0
	}
	if i == 2 then
		eData.tag = ITEM_TAG.ThreeStar
		eData.isPass = star >= 3
	elseif i == 3 then
		eData.tag = ITEM_TAG.Chance
		eData.isPass = false
	elseif i == 4 then
		eData.tag = ITEM_TAG.LittleChance
		eData.isPass = false
	elseif i == 5 then
		eData.tag = ITEM_TAG.TimeLimit
		eData.isPass = false
	end
	return eData
end

function RefreshGrids()
	for k, v in ipairs(grids) do
		v.SetChoosie(v.data == currData);
	end
end

function OnClickGrid(tab)
	currData = tab.data
	RefreshGrids();
	ShowContent();
end

function OnClickBack()
	if not fade then
		fade = ComUtil.GetCom(gameObject, "ActionFade")
	end
	fade:Play(1, 0, 200, 0, function()
		CloseView()
		view:Close()
		-- CSAPI.SetGOActive(gameObject, false)
		-- fade:Play(0, 1)
	end)
end

function OnClickAnyway()
	if elseData == DungeonDetailsType.Map then
		CloseView()
	end
end

function CloseView()
	view:Close()
end

function OnDestroy()	
	if(tab) then
		CSAPI.SetGOActive(tab.btn_home, true)
	end
	ReleaseCSComRefs();
	eventMgr:ClearListener()
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	line = nil;
	txt_title = nil;
	root = nil;
	sv = nil;
	Content = nil;
	rewardSv = nil;
	rewardNode = nil;
	passObj = nil;
	txt_pass = nil;
	passNode = nil;
	fixedObj = nil;
	txt_fixed = nil;
	fixedNode = nil;
	randomObj = nil;
	txt_random = nil;
	randomNode = nil;
	littleObj = nil;
	txt_little = nil;
	littleNode = nil;
	txt_name = nil;
	txt_desc = nil;
	lvObj = nil;
	txt_lv = nil;
	txt_lv2 = nil;
	iconObj = nil;
	icon = nil;
	enumObj = nil;
	enumItem = nil;
	mapObj = nil;
	txt_map = nil;
	view = nil;
end
----#End#----
