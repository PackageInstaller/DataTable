--背包

local layout = nil;
local layout2=nil;
local curLayout=nil;
-- local condition=nil;
local currTab=1;
local sortView=nil;
-- local orderType=1;
local materialModule={[1]=require("BagMaterial")}; --素材背包
local equipModule={[1]=require("BagEquip"),[2]=require("BagSell"),[3]=require("BagRemould"),[4]=require("BagStrength"),[5]=require("BagEquipLock")}; --装备背包
local tagItems={};
local currTag=1;
local tagList={ --二级页签配置
	{{ ---道具子页签
		id=1,
		txt1=LanguageMgr:GetByID(24037),
		txt2=LanguageMgr:GetByType(24037,4),
		icon1="btn_11_01",
		icon2="btn_11_02",
		tag=1,
		openSetting=BagOpenSetting.Material,
	},{
		id=2,
		txt1=LanguageMgr:GetByID(24038),
		txt2=LanguageMgr:GetByType(24038,4),
		icon1="img_10_01",
		icon2="img_10_02",
		tag=2,
		openSetting=BagOpenSetting.Props,
	}},
	{{ ---装备子页签
		id=1,
		txt1=LanguageMgr:GetByID(24029),
		txt2=LanguageMgr:GetByType(24029,4),
		icon1="btn_07_01",
		icon2="btn_07_02",
		openSetting=BagOpenSetting.Equipped,
	}
	-- ,{
	-- 	id=2,
	-- 	txt1=LanguageMgr:GetByID(24036),
	-- 	txt2=LanguageMgr:GetByType(24036,4),
	-- 	icon1="btn_08_01",
	-- 	icon2="btn_08_02",
	-- 	openSetting=BagOpenSetting.EquippedMaterial,
	-- }
	}
}
----------------------------------动画相关
local tagNodeDelayTime=540; --装备Tab的动画延迟时间
local sellBtnDelayTime=600;--出售按钮的动画延迟时间
local tabNodeDelayTime=340;--TabNode的动画延迟时间
local tabNodeTweens={};
local equipTabTweens={}; --装备Tab的动画脚本对象
local sellBtnTweens={};--出售按钮的动画脚本对象
local lockBtnTweens={};--加锁按钮的动画脚本对象
local numTween=nil;
-------------------------------
local curModule=nil;
local bagType=nil;
local curDatas={};
local qualitys=nil;
local tweenLua=nil;
local isFirst=true;
local sortID=9;
local lastEquipType=nil;
local tweenMaskTime=1000;
local baseItems={};
local skillItems=nil;
function Awake()	
	--初始化菜单项
	AdaptiveConfiguration.SetLuaObjUIFit("Bag",gameObject)
	layout = ComUtil.GetCom(sv, "UISV")
	layout2=ComUtil.GetCom(sv2,"UISV")
	curLayout=layout;
	layout:Init("UIs/Grid/GridItem",LayoutCallBack,true)
	AddEvent();
	local iconName = Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD).icon
	ResUtil.IconGoods:Load(money1, iconName, true)
	local iconName2 = Cfgs.ItemInfo:GetByID(10011).icon
	ResUtil.IconGoods:Load(money2, iconName2, true);
	local tweens2=ComUtil.GetComsInChildren(btn_sell,"ActionBase");
	for i=0,tweens2.Length-1 do
		table.insert(sellBtnTweens,tweens2[i]);
	end
	local tweens3=ComUtil.GetComsInChildren(btnLock,"ActionBase");
	for i=0,tweens3.Length-1 do
		table.insert(lockBtnTweens,tweens3[i]);
	end
	local tweens4=ComUtil.GetComsInChildren(tabNode,"ActionBase");
	for i=0,tweens4.Length-1 do
		table.insert(tabNodeTweens,tweens4[i]);
	end
	numTween=ComUtil.GetCom(curNum,"ActionTextRand");
	tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal);
	--layout:AddBarAnim(0.4,false);
end
function AddEvent()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_Change, OnEquipChange);
	eventMgr:AddListener(EventType.Equip_Update,OnEquipChange)
	eventMgr:AddListener(EventType.Equip_GridNum_Refresh,RefreshNumObj)
	eventMgr:AddListener(EventType.Bag_Update, OnBagChange);
	eventMgr:AddListener(EventType.Bag_SellQuality_Change, OnSellQualityChange);
	eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnEquipSetLockRet);
	eventMgr:AddListener(EventType.Equip_Sell_Ret, OnEquipSellRet);
	eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
	eventMgr:AddListener(EventType.Equip_Remould_Select,Close)
	eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
end

function OnDestroy()
	if bagType==MaterialBagType.Normal or bagType==EquipBagType.Normal then
		BagMgr:SetSelTabIndex(currTab)
	end
	BagMgr:SetSelChildTabIndex(currTag);
	eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function OnInit()
	UIUtil:AddTop2("Bag",gameObject, OnClickReturn)
	SetRedInfo();
end

function SetRedInfo()
	local redInfo=RedPointMgr:GetData(RedPointType.Bag);
	local isRed=redInfo~=nil;
	UIUtil:SetRedPoint(btnEquip,isRed,110,20);
	UIUtil:SetRedPoint(btn_sell,isRed,110,32);
end

function OnViewClosed(key)
	if key=="EquipFullInfo" and bagType==EquipBagType.Remould then
		SetCurModule();
	end
end

function SetSortObj()
	--判断筛选ID
	local tempID=0;
	local anchor={-288,-10}
	if GetBagBaseType()==BagType.Material then
		if currTab==BagOpenSetting.Props then
			anchor={-515,-10}
			tempID=21;
		else
			tempID=9;
		end
	elseif GetBagBaseType()==BagType.Equipped then
		if bagType==EquipBagType.Sell then
			tempID=11;
		elseif currTab==BagOpenSetting.EquippedMaterial then
			tempID=16
		else
			tempID=10;
		end
	end
	local isChange=tempID~=sortID;
	sortID=tempID;
	if sortView==nil and isLoadSortView~=true then
		isLoadSortView=true
		ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
			CSAPI.SetScale(go,1,1,1);
			sortView=ComUtil.GetLuaTable(go);
			sortView.Init(sortID,function()
				curModule.Refresh();
			end);
			CSAPI.SetAnchor(go,anchor[1],anchor[2]);
		end);
	elseif sortView~=nil and isChange then
		sortView.Init(sortID,function()
			curModule.Refresh();
		end);
		CSAPI.SetAnchor(sortView.gameObject,anchor[1],anchor[2]);
	end
end

function OnOpen()
	--筛选数据
	CSAPI.PlayUISound("ui_window_open_load");
	if openSetting then
		currTag=1
	else
		currTag=BagMgr:GetSelChildTabIndex() or 1;
	end
	openSetting = openSetting == nil and BagMgr:GetSelTabIndex() or openSetting;
	currTab=openSetting;
	if data then
		bagType=data.bagType;
	else
		bagType=GetBagBaseType()==BagType.Material and MaterialBagType.Normal or EquipBagType.Normal;
	end
	local isDelay=false;
	if GetBagBaseType()==BagType.Equipped and bagType~=EquipBagType.Strength then
		isDelay=true;
	end
	SetTweenDelay(isDelay);--设置动画延迟
	SetCurModule(true);
	SetTabStyle();
	if GetBagBaseType()==BagType.Equipped then
		SetTweenDelay(false) --还原动画延迟时间
	end
end

--根据currTab字段判断当前是什么基础背包类型 1：素材背包 2：装备背包
function GetBagBaseType()
	if currTab==BagOpenSetting.Material or currTab==BagOpenSetting.Props then
		return BagType.Material
	elseif currTab==BagOpenSetting.Equipped or currTab==BagOpenSetting.EquippedMaterial then
		return BagType.Equipped
	end
end

--设置动画延迟 (首次开启在装备页时需要延迟播放动画)
function SetTweenDelay(isDelay)
	-- for k,v in ipairs(equipTabTweens) do
	-- 	local val=v.delay>=tagNodeDelayTime and v.delay-tagNodeDelayTime or v.delay
	-- 	v.delay=isDelay and v.delay+tagNodeDelayTime or val;
	-- end
	for k,v in ipairs(sellBtnTweens) do
		local val=v.delay>=tagNodeDelayTime and v.delay-tagNodeDelayTime or v.delay
		v.delay=isDelay and v.delay+sellBtnDelayTime or val;
	end
	for k,v in ipairs(lockBtnTweens) do
		local val=v.delay>=tagNodeDelayTime and v.delay-tagNodeDelayTime or v.delay
		v.delay=isDelay and v.delay+sellBtnDelayTime or val;
	end
	for k,v in ipairs(tabNodeTweens) do
		local val=v.delay>=tabNodeDelayTime and v.delay-tabNodeDelayTime or v.delay
		local val2=v.delay>=tabNodeDelayTime and v.delay or v.delay+tabNodeDelayTime
		v.delay=isDelay and val2 or val;
	end
end

function SetCurModule(_isFirst)
	curModule=GetCurModule()
	curModule.SetData(this,data);
	SetViewLayout();
	SetSortObj();
	if tagNode.activeSelf then
		local isEnter=true;
		if bagType==EquipBagType.Sell or bagType==EquipBagType.Lock then
			isEnter=false;
		end
		local tagData=tagList[GetBagBaseType()];
		InitTagState(tagData,_isFirst,isEnter);
	end
	-- 检查是否存在需要提示素材芯片转换
	if EquipMgr:CheckHasConvert() == true and GetBagBaseType()==BagType.Equipped then
		-- 发送转换协议
		EquipProto:EquipMaterialConvertWindow();
	end
	curModule.Refresh();
end

function Refresh(list) --刷新列表
	if GetBagBaseType()==BagType.Material then
		-- orderType=BagMgr:GetOrderType();
		-- condition=BagMgr:GetScreenData();
		-- list=BagMgr:DoScreen(list,condition);
		local isProp=currTab~=BagOpenSetting.Material and true or false;
		local arr={};
		for k,v in ipairs(list) do
			local cfgGoods=v:GetCfg();
			if isProp and (v:GetCfgTag()==2) then--消耗道具
				table.insert(arr, v);
			elseif isProp~=true and (v:GetCfgTag()~=2) then
				table.insert(arr, v);
			end
		end
		-- if isProp then
		-- 	list=arr;
		-- else
		-- 	list=SortMgr:Sort(sortID,arr);
		-- end
		list=SortMgr:Sort(sortID,arr);
		curLayout=layout;
		CSAPI.SetGOActive(SortNone,#list<=0);
		CSAPI.SetGOActive(SortNone2,false);
	elseif GetBagBaseType()==BagType.Equipped then
		local arr={};
		list=list or {};
		local tag=currTab==BagOpenSetting.Equipped and EquipType.Normal or EquipType.Material;
		for k,v in ipairs(list) do
			local cfgGoods=v:GetCfg();
			if (v:GetType()==tag) then
				table.insert(arr, v);
			end
		end
		list=SortMgr:Sort(sortID,arr);
		curLayout=layout2;
		-- SetCount(#list, EquipMgr.maxSize);
		SetCount(EquipMgr.curSize,EquipMgr.maxSize);
		CSAPI.SetGOActive(SortNone2,#list<=0);
		CSAPI.SetGOActive(SortNone,false);
	end
	-- RefreshSortBar();
	if isFirst then
		CSAPI.SetGOActive(mask,true);
		FuncUtil:Call(function()
			CSAPI.SetGOActive(mask,false);
		end,nil,tweenMaskTime);
	end
	if list then
		curDatas = list;
		selectIndex =nil;
		SortDataBySortUD();
		-- layout:Init("UIs/Grid/GridItem",LayoutCallBack,true)
		if isFirst then
			-- CSAPI.SetGOActive(mask,true);
			-- FuncUtil:Call(function()--动画所需的延迟
			-- 	tweenLua:AnimAgain();
			-- 	if curLayout then
			-- 		curLayout:IEShowList(#curDatas,TweenCall,1)
			-- 	end
			-- end,nil,80)
			isFirst=false;
			tweenLua:AnimAgain();
			if curLayout then
				curLayout:IEShowList(#curDatas,nil,1)
			end
		else
			curLayout:IEShowList(#curDatas)
		end
	else
		curLayout:IEShowList(0)
	end
end

function TweenCall()
	CSAPI.SetGOActive(mask,false);
end

function UpdateCell(index)
	curLayout:UpdateOne(index);
end

function GetCurModule()
	if GetBagBaseType()==BagType.Material then
		return materialModule[bagType]
	elseif GetBagBaseType()==BagType.Equipped then
		return equipModule[bagType]
	end
end

--自动选择的品质变更
function OnSellQualityChange(_qualitys)
	qualitys=_qualitys;
	if curModule and curModule.AutoSelect then
		curModule.AutoSelect(qualitys);
	end
	if curModule then
		curModule.Refresh();
	end
end

--设置界面布局
function SetViewLayout()
	CSAPI.SetGOActive(sv,GetBagBaseType()==BagType.Material)
	CSAPI.SetGOActive(sv2,GetBagBaseType()==BagType.Equipped)
	if bagType==EquipBagType.Remould  then
		CSAPI.SetRtRect(sv2,55,-40,-110,60);
	else
		CSAPI.SetRtRect(sv2,55,-370,-110,60);
	end
	if bagType~=lastEquipType then
		layout2:Init("UIs/Grid/EquipItem",LayoutCallBack,true)
		lastEquipType=bagType;
	end
	if GetBagBaseType()==BagType.Material then
		SetMaterialLayout();
	elseif GetBagBaseType()==BagType.Equipped then
		SetEquipLayout();
	end
end

function SetMaterialLayout()
	if bagType==MaterialBagType.Normal then
		CSAPI.SetGOActive(btn_sell, false);
		CSAPI.SetGOActive(btnLock,false);
		CSAPI.SetGOActive(btnLockOn,false);
		CSAPI.SetGOActive(numObj, false);
		-- CSAPI.SetGOActive(tagNode,true);
		CSAPI.SetGOActive(btnCancelSellBtn,false);
		CSAPI.SetGOActive(sellTips,false);
		CSAPI.SetGOActive(btnWork,false);
	end
end

function SetEquipLayout()
	-- LogError(bagType.."\t"..currTab.."\t"..currTag)
	if bagType==EquipBagType.Normal then
		CSAPI.SetGOActive(btn_sell, currTab==BagOpenSetting.Equipped);
		CSAPI.SetGOActive(btnLock,currTab==BagOpenSetting.Equipped);
		CSAPI.SetGOActive(numObj, true);
		CSAPI.SetGOActive(tabNode, true);
		CSAPI.SetGOActive(sellObj,false);
		CSAPI.SetGOActive(btnLockOn,false);
		-- CSAPI.SetGOActive(tagNode,true);
		CSAPI.SetGOActive(btnCancelSellBtn,false);
		CSAPI.SetGOActive(sellBtnOnAnima,false);
		CSAPI.SetGOActive(sellTips,false);
		CSAPI.SetGOActive(btnWork,currTab==BagOpenSetting.Equipped);
		SetSellStyle(1);
	elseif bagType==EquipBagType.Sell then
		CSAPI.SetGOActive(btn_sell, true);
		CSAPI.SetGOActive(btnLock,false);
		CSAPI.SetGOActive(btnLockOn,false);
		CSAPI.SetGOActive(numObj, true);
		CSAPI.SetGOActive(tabNode, false);
		CSAPI.SetGOActive(sellObj,true);
		CSAPI.SetGOActive(infoNode,false);
		-- CSAPI.SetGOActive(tagNode,false);
		CSAPI.SetGOActive(btnCancelSellBtn,true);
		CSAPI.SetGOActive(sellTips,true);
		CSAPI.SetGOActive(sellBtnOnAnima,true);
		CSAPI.SetGOActive(btnWork,false);
		SetSellStyle(2);
	elseif bagType==EquipBagType.Remould then
		CSAPI.SetText(txt_sell, LanguageMgr:GetByID(24000));
		CSAPI.SetText(txt_sell2, LanguageMgr:GetByID(24001));
		CSAPI.SetGOActive(btn_sell, false);
		CSAPI.SetGOActive(btnLock,false);
		CSAPI.SetGOActive(btnLockOn,false);
		CSAPI.SetGOActive(numObj, false);
		CSAPI.SetGOActive(tabNode, false);
		CSAPI.SetGOActive(sellObj,false);
		CSAPI.SetGOActive(tagNode,false);
		CSAPI.SetGOActive(btnCancelSellBtn,false);
		CSAPI.SetGOActive(sellTips,false);
		CSAPI.SetGOActive(btnWork,false);
	elseif bagType==EquipBagType.Strength then
		CSAPI.SetText(txt_sell, LanguageMgr:GetByID(24000));
		CSAPI.SetText(txt_sell2, LanguageMgr:GetByID(24001));
		CSAPI.SetGOActive(btn_sell, true);
		CSAPI.SetGOActive(btnLock,false);
		CSAPI.SetGOActive(btnLockOn,false);
		CSAPI.SetGOActive(numObj, false);
		CSAPI.SetGOActive(tabNode, false);
		CSAPI.SetGOActive(sellObj,false);
		-- CSAPI.SetGOActive(tagNode,true);
		CSAPI.SetGOActive(btnCancelSellBtn,false);
		CSAPI.SetGOActive(sellTips,false);
		CSAPI.SetGOActive(btnWork,false);
	elseif bagType==EquipBagType.Lock then
		CSAPI.SetGOActive(btn_sell, false);
		CSAPI.SetGOActive(btnLock,false);
		CSAPI.SetGOActive(btnLockOn,true);
		CSAPI.SetGOActive(numObj, true);
		CSAPI.SetGOActive(tabNode, false);
		CSAPI.SetGOActive(sellObj,false);
		-- CSAPI.SetGOActive(tagNode,false);
		CSAPI.SetGOActive(btnCancelSellBtn,false);
		CSAPI.SetGOActive(sellTips,false);
		CSAPI.SetGOActive(btnWork,false);
	end
	-- SetCount(#curDatas, EquipMgr.maxSize);
end

function OnClickMatiral()
	if GetBagBaseType()~=BagType.Material then
		currTag=1;
		BagMgr:SetSelChildTabIndex(currTag);
		local tagData=tagList[BagType.Material][currTag];
		local openSetting=tagData.openSetting;
		ChangeLayout(openSetting,MaterialBagType.Normal)
	end
end

function OnClickEquip()
	local isOpen,lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special3")
	if(not isOpen)then 
		Tips.ShowTips(lockStr)
		return
	end
	if GetBagBaseType()~=BagType.Equipped then
		currTag=1;
		BagMgr:SetSelChildTabIndex(currTag);
		local tagData=tagList[BagType.Equipped][currTag];
		local openSetting=tagData.openSetting;
		ChangeLayout(openSetting,EquipBagType.Normal)
	end
end

--根据bagOpenSetting的值和bagType改变面板状态
function ChangeLayout(_bagOpenSetting,_bagType,_bagBaseType)
	if _bagBaseType then
		local tagData=tagList[_bagBaseType][_bagOpenSetting];
		currTab=tagData.openSetting;
	else
		currTab=_bagOpenSetting;
	end
	bagType=_bagType;
	-- Log("ChangeLayout:"..tostring(_bagOpenSetting).."\t"..tostring(_bagType).."\t"..currTab)
	SetTabStyle()
	if GetBagBaseType()==BagType.Equipped then
		-- SetChipTabState(currTab==BagOpenSetting.Equipped);
		SetTweenDelay(false);
	end
	SetCurModule();
end

--初始化二级页签样式
function InitTagState(tags,isDelay,isEnter)
	if tags then
		local count=#tags;
		local time=isDelay and tagNodeDelayTime or 0;
		for k, v in ipairs(tags) do
			if #tagItems>=k then
				CSAPI.SetGOActive(tagItems[k].gameObject,true);
				tagItems[k].SetIndex(k,count);
				tagItems[k].Refresh(v,{id=currTag,isDelay=isDelay});
				tagItems[k].SetClickCB(OnClickTag);
				tagItems[k].PlayTween(isEnter,time);
			else
				ResUtil:CreateUIGOAsync("Bag/BagTag",tagNode,function(go)
					local lua=ComUtil.GetLuaTable(go);
					lua.SetIndex(k,count);
					lua.Refresh(v,{id=currTag,isDelay=isDelay});
					lua.SetClickCB(OnClickTag);
					table.insert(tagItems,lua);
					tagItems[k].PlayTween(isEnter,time);
				end);
			end
		end
		if count<#tagItems then
			for i = count+1, #tagItems, 1 do
				CSAPI.SetGOActive(tagItems[i].gameObject,false);
			end
		end
	end
end

function OnClickTag(lua)
	if currTag==lua.data.id then
		do return end
	end
	tagItems[currTag].SetState(false);
	currTag=lua.data.id;
	lua.SetState(true);
	currTab=lua.data.openSetting;
	BagMgr:SetSelChildTabIndex(lua.data.id);
	SetViewLayout()
	SetSortObj();
	if curModule then
		curModule.Refresh();
	end
end

--设置tab的显示样式
function SetTabStyle()
	local isMatiral=GetBagBaseType()==BagType.Material;
	local color=isMatiral and {255,255,255,255} or {255,255,255,122};
	local color2=isMatiral and {255,255,255,122} or {255,255,255,255};
	CSAPI.SetGOActive(on_Matiral,isMatiral);
	CSAPI.SetGOActive(off_Matiral,not isMatiral);
	CSAPI.SetGOActive(on_Equip,not isMatiral);
	CSAPI.SetGOActive(off_Equip,isMatiral);
	local imgName1=isMatiral and "btn_02_01.png" or "btn_02_02.png";
	local imgName2=isMatiral and "btn_02_02.png" or "btn_02_01.png";
	CSAPI.LoadImg(btnMatiral,"UIs/Bag/"..imgName1,false,nil,true);
	CSAPI.LoadImg(btnEquip,"UIs/Bag/"..imgName2,false,nil,true);
	CSAPI.SetTextColor(txt_Matiral,color[1],color[2],color[3],color[4]);
	CSAPI.SetTextColor(txt_Equip,color2[1],color2[2],color2[3],color2[4]);

	--装备锁
	local isOpen,lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special3")
	CSAPI.SetGOActive(equipLock,not isOpen)
	if(not isOpen)then 
		CSAPI.SetText(txtEquipLock,lockStr)
	end 
end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local _elseData=curModule.GetElseData(_data);
	local grid=curLayout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data,_elseData);
	grid.SetClickCB(OnClickGrid);
end

function OnClickGrid(tab)
	if curModule and curModule.OnClickGrid then
		curModule.OnClickGrid(tab);
	end
end

function OnClickSell()
	isFirst=true;
	if bagType==EquipBagType.Sell then
		OnClickSendSell();
	-- elseif bagType==EquipBagType.Remould or bagType==EquipBagType.Strength then
	-- 	if curModule and curModule.OnClickChoosie then
	-- 		curModule.OnClickChoosie();
	-- 	end
	elseif bagType==EquipBagType.Normal then
		bagType=EquipBagType.Sell;
		SetCurModule();
	end
end

--对当前数据根据升降序进行排序
function SortDataBySortUD()
	if orderType == 1 then --倒序
		local source = {};
		for i = 1, #curDatas do
			table.insert(source, curDatas[#curDatas]);
			table.remove(curDatas, #curDatas);
		end
		curDatas = source;
	end
end

function SetCount(curSize, maxSize)
	curSize = curSize or 0;
	maxSize = maxSize or 0;
	if numObj.activeSelf then
		numTween.targetStr=tostring(curSize)
		numTween:Play();
	else
		CSAPI.SetText(curNum, tostring(curSize));
	end
	-- CSAPI.SetText(curNum, tostring(curSize));
	CSAPI.SetText(maxNum, "/" .. maxSize);
end

--设置出售样式
function SetSellStyle(style)
	if style==1 then
		CSAPI.SetText(txt_sell,LanguageMgr:GetByID(24008));
		CSAPI.SetText(txt_sell2,LanguageMgr:GetByID(24009));
	else
		CSAPI.SetText(txt_sell,LanguageMgr:GetByID(24010));
		CSAPI.SetText(txt_sell2,LanguageMgr:GetByID(24001));
	end
end

--设置出售结算信息
function SetSellPrice(cNum,price,price2)
	local maxNum=curDatas and #curDatas  or 0;
	-- CSAPI.SetText(txt_sellNum, tostring(cNum).." / <color='#FFD426'>"..maxNum.."</color>");
	CSAPI.SetText(txt_choosie,LanguageMgr:GetByID(24040,cNum,g_EquipChooiseNum))
	CSAPI.SetText(txt_price, tostring(price));
	CSAPI.SetText(txt_price2, tostring(price2));
end

--设置显示的装备数据
function SetSellEquipInfo(equipData)
	CSAPI.SetGOActive(infoNode,equipData~=nil)
	if equipData then --初始化信息
		if equipData:GetLv()>0 then
			CSAPI.SetText(txt_infoName,string.format("%s+%s",equipData:GetName(),equipData:GetLv()));
		else
			CSAPI.SetText(txt_infoName,equipData:GetName());
		end
		local l1={};
        for i=1,g_EquipMaxAttrNum do
            local id,add,upAdd=equipData:GetBaseAddInfo(i);
            if id and add and upAdd then
                local addition=add+upAdd*equipData:GetLv();
                local text=EquipCommon.FormatAddtion(id,addition);
                table.insert(l1,{id=id,val1="+"..text});
            end
        end
		ItemUtil.AddItems("AttributeNew2/AttributeItem11",baseItems,l1,baseRoot,nil,1);
		local list={};
		local index=0;
			for i=1,g_EquipMaxSkillNum do
				local cfg=equipData:GetSkillInfo(i);
				if cfg then
					if index<=g_EquipMaxSkillNum then
						table.insert(list,cfg);
						index=index+1;
					else
						LogError("技能数量超过上限！！");
					end
				end       
			end
		skillItems=skillItems or {};
		for i=1,g_EquipMaxSkillNum  do
			local isLock,desc=true,"";
			if list[i]~=nil and equipData then
				isLock,desc=equipData:GetSkillIsLock(list[i].id,i);
			end
			if skillItems and i <= #skillItems then
				skillItems[i].Refresh(list[i],nil,{isLock=isLock});
				skillItems[i].SetClickCB(OnClickSkillItem);
			else
				ResUtil:CreateUIGOAsync("EquipInfo/EquipSkillAttribute3",skillRoot,function(go)
					local tab=ComUtil.GetLuaTable(go);
					tab.Refresh(list[i],nil,{isLock=isLock});
					tab.SetClickCB(OnClickSkillItem);
					table.insert(skillItems,tab);
				end);
			end
		end
	end
end

function OnClickSkillItem(cfg)
    if cfg then
        CSAPI.OpenView("RoleEquipSkillInfo",cfg);
    end
end

--背包数据更新
function OnBagChange(isMoney)
	if GetBagBaseType()==BagType.Material and isMoney ~=true then
		if sv.activeSelf then
			curModule.Refresh();
		end
	end
end

function OnEquipChange()
	if GetBagBaseType()==BagType.Equipped and curModule and bagType~=EquipBagType.Sell and bagType~=EquipBagType.Strength then
		if sv2.activeSelf then
			curModule.Refresh();
		end
	end
end

function OnClickWork()
	CSAPI.OpenView("EquipStreng");
end

--点击自动选择
function OnClickAuto()
	CSAPI.OpenView("BagQualitySelect",qualitys);
end

function OnClickSendSell()
	if curModule and curModule.OnClickSendSell then
		isFirst=true;
		curModule.OnClickSendSell()
	end
end

function OnClickCancelSell()
	if curModule and bagType==EquipBagType.Sell then
		isFirst=true;
		curModule.OnClickReturn()
	end
end

function OnClickReturn()
	if curModule then
		isFirst=true;
		curModule.OnClickReturn();
	else
		Close();
	end
end

function PlaySellTween(isShow)
	CSAPI.SetGOActive(sellBtnOutAnima,not isShow);
	CSAPI.SetGOActive(sellIntAnima,isShow);
	CSAPI.SetGOActive(sellOutAnima,not isShow);
end

function Close()
	view:Close();
end

function RefreshNumObj()
	if GetBagBaseType()==BagType.Equipped then
		-- SetCount(#curDatas, EquipMgr.maxSize);
		SetCount(EquipMgr.curSize, EquipMgr.maxSize);
	end
end

--扩容
function OnClickAdd()
	local currNum = EquipMgr.maxSize + g_EquipGridAddNum;
	if EquipMgr.maxSize < g_EquipGridMaxSize then
		CSAPI.OpenView("AddGridView",nil,2);
	else
		CSAPI.OpenView("Prompt", {
			content = LanguageMgr:GetByID(24011),
		});
	end
end

function OnEquipSellRet()
	if bagType==EquipBagType.Sell then
		curModule.OnSellRet();
	end
end

--点击加锁
function OnClickLock()
	if bagType==EquipBagType.Normal then
		bagType=EquipBagType.Lock;
	end
	isFirst=true;
	SetCurModule();
end

function OnEquipSetLockRet()
	if GetBagBaseType()==BagType.Equipped then
		curModule.Refresh();
	end
end

--确认上锁
function OnClickLockOn()
	if bagType==EquipBagType.Lock then
		curModule.OnClickLock();
		bagType=EquipBagType.Normal;
	end
	isFirst=true;
	SetCurModule();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
panelNode=nil;
sv=nil;
scrollbar=nil;
scrollHandle=nil;
root=nil;
tabNode=nil;
btnMatiral=nil;
off_Matiral=nil;
on_Matiral=nil;
matiralIcon=nil;
txt_Matiral=nil;
txt_MatiralTips=nil;
btnEquip=nil;
off_Equip=nil;
on_Equip=nil;
equipIcon=nil;
txt_Equip=nil;
txt_EquipTips=nil;
tagNode=nil;
btnChip=nil;
s_nChip=nil;
s_chip=nil;
chipLine=nil;
chipIcon=nil;
btnMChip=nil;
s_mNChip=nil;
s_mChip=nil;
mChipLine=nil;
mChipIcon=nil;
eTabsOnAnima=nil;
eTabsOutAnima=nil;
btnLock=nil;
lockHight=nil;
lockIcon=nil;
txt_lock=nil;
btnLockOn=nil;
lockOnHight=nil;
lockOnIcon=nil;
txt_lockOn=nil;
sellObj=nil;
btn_all=nil;
Text=nil;
moneyItem1=nil;
money1=nil;
txt_price=nil;
moneyItem2=nil;
money2=nil;
txt_price2=nil;
sellInAnima=nil;
sellOutAnima=nil;
txt_choosie=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
numObj=nil;
txt_numTips=nil;
curNum=nil;
maxNum=nil;
btn_sell=nil;
txt_sell=nil;
txt_sell2=nil;
cancelSellBtnAnchor=nil;
btnCancelSellBtn=nil;
txt_cancelSell2=nil;
sellTips=nil;
txt_sellNum=nil;
sellBtnOnAnima=nil;
sellBtnOutAnima=nil;
view=nil;
end
----#End#----