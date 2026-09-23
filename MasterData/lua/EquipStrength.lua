--装备强化面板
local stuffList=StuffArray.New();
local stuffItems=nil;
local layout=nil;
local curDatas=nil;
-- local isEquip=true;
local orderType=1;
local baseItems={};
local expStr="<size=72>%s</size><color=#929296>/%s</color>"--经验值格式
local lvStrFormat="%s";
local recordTime=0;
local preEquip=nil;--预览升级后的装备
local aphlaCanvas=nil;
local canClick=true;
local sortID=14;
local normalPos={-40,320};
local maxPos={-40,205};
local tweenLua=nil;
local sBarTween=nil;
local cBarTween=nil;
local beforeLv=0;
local disNewTween=true;
local sBar=nil
local cBar=nil
local selEquip=nil
local eventMgr=nil;
local sdr=nil
local clipExpGoods=nil;
local useClipExpNum=0;
local addCount=1000;
local clipGrid=nil;
local totalExp=0;
local sortView=nil;
local lastLockIdx=nil;

function Awake()
	aphlaCanvas=ComUtil.GetCom(btn_strength,"CanvasGroup");
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Grid/EquipItem",LayoutCallBack,true,0.8);
	tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal);
	cBarTween=ComUtil.GetCom(slider2,"ActionSliderBar");
	sBarTween=ComUtil.GetCom(slider1,"ActionSliderBar");
	sdr=ComUtil.GetCom(Slider,"Slider");
    CSAPI.AddSliderCallBack(Slider,OnSliderChange);
    local iconName = Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD).icon.."_1";
	ResUtil.IconGoods:Load(mIcon,iconName);
	CSAPI.SetRTSize(mIcon,40,40);
	sBar=ComUtil.GetCom(slider1,"Slider");
	cBar=ComUtil.GetCom(slider2,"Slider");
	recordTime=CSAPI.GetRealTime();
    CreateGrids();
	ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
		CSAPI.SetScale(go,1,1,1);
		sortView=ComUtil.GetLuaTable(go);
		sortView.Init(sortID,RefreshList);
		CSAPI.SetAnchor(go,45,-10);
	end);
end

function GetMoneys()
    return {{ITEM_ID.GOLD}}
end

function Refresh()
	--检查是否存在需要提示素材芯片转换
	if EquipMgr:CheckHasConvert()==true then
		--发送转换协议
		EquipProto:EquipMaterialConvertWindow();
	end
	if data and data.equip then
		selEquip=data.equip
	end
	if selEquip and EquipMgr:GetEquip(selEquip:GetID())==nil then
		selEquip=nil;
	end
	SetUseClipExpNum(0);
    RefreshPanel(selEquip)
end

function InitExpNode()
	clipExpGoods=BagMgr:GetFakeData(ITEMS_ID.EQUIP_EXP);
	if clipGrid==nil then
		ResUtil:CreateUIGOAsync("Grid/GridItem",expItem,function(go)
			clipGrid=ComUtil.GetLuaTable(go);
			clipGrid.Refresh(clipExpGoods);
		end);
	else
		clipGrid.Refresh(clipExpGoods);
	end
	CSAPI.SetText(txtExpName,clipExpGoods:GetName());
end

function OnEnable()
	sortView.Init(sortID,RefreshList);
	if eventMgr==nil then
		eventMgr = ViewEvent.New();
		eventMgr:AddListener(EventType.Equip_Upgrade_Ret,OnUpgradeRet);
		eventMgr:AddListener(EventType.Bag_Update,OnBagUpdate);
		eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet);
	end
end

function OnDisable()
	if eventMgr then
		eventMgr:ClearListener();
		eventMgr=nil;
	end
	RecordMgr:Save(RecordMode.View,recordTime,"ui_id=" .. RecordViews.Equip);
	lastLockIdx=nil;	
end

function OnBagUpdate()
	RefreshPanel(selEquip);
end

function RefreshPanel(_data)
    if _data then
		if gridItem==nil then
            _,gridItem=ResUtil:CreateEquipItem(gridNode.transform);
        end
		gridItem.Refresh(_data,{isClick=false});
		gridItem.SetCount();
		gridItem.SetLockActive(false);
        CSAPI.SetText(txt_name,_data:GetName());
		totalExp=_data:GetEquipMaxLvExp();
		RefreshContent(_data);
    else
        SetNullObj(2);
	end
	InitExpNode();
    RefreshList();
end

--显示提示信息 1为不显示，2为显示提示玩家选择装备,3为显示已达等级上限
function SetNullObj(type)
    local type=type or 1
    local isMax=false;
    if type==1 then
        isMax=false;
        CSAPI.SetAnchor(topObj,-39.7,320);
        CSAPI.SetGOActive(rLayout,true);
    elseif type==2 then
        isMax=true
        CSAPI.SetText(txtMax,LanguageMgr:GetByID(75004));
        CSAPI.SetAnchor(topObj,-39.7,320);
        CSAPI.SetAnchor(maxObj,-43.94,54.9);
        CSAPI.SetGOActive(rLayout,false);
    elseif type==3 then
        isMax=true
        CSAPI.SetText(txtMax,LanguageMgr:GetByID(4011));
        CSAPI.SetAnchor(topObj,-39.7,205);
        CSAPI.SetAnchor(maxObj,-43.94,-106.36);
        CSAPI.SetGOActive(rLayout,true);
    end
    CSAPI.SetGOActive(stuffRoot,not isMax);
    CSAPI.SetGOActive(maxObj,isMax);
end

function RefreshList()
	local list=nil
	local list2=nil;
    if selEquip then
        -- if isEquip then
		list=EquipMgr:GetNotEquippedItem(selEquip:GetID(),false);
		list2=EquipMgr:GetMaterialEquips();
	else
		list=EquipMgr:GetAllEquipArr(nil,false);
    end
	if list then
		list=SortMgr:Sort(sortID,list);
	end
	local source = {};
	if list2 then
		list2=SortMgr:Sort(sortID,list2);
		for i = 1, #list2 do
			local index=orderType==1 and #list2 or i;
			local num=stuffList:GetStuffNumByID(list2[index]:GetID())
			if list2[index]:GetCount()-num>0 then
				table.insert(source, list2[index]);
			end
			if orderType==1 then
				table.remove(list2, index);
			end
		end
	end
	if list then
		for i = 1, #list do--装备被选中后会被剔除
			local index=orderType==1 and #list or i;
			if stuffList:GetStuffByID(list[index]:GetID())==nil then
				table.insert(source, list[index]);
			end
			if orderType==1 then
				table.remove(list, index);
			end
		end
	end
	if #source>0 then
		curDatas=source;
	else
		curDatas={};
	end
	CSAPI.SetGOActive(SortNone,#curDatas<=0);
	if IsNil(layout)~=true then
		layout:IEShowList(#curDatas);
	end
end

--获取装备等级，读取等级信息
function RefreshContent(equip)
	if IsNil(sBar) or IsNil(cBar) then
		do return end
	end
	if equip:GetLv()<equip:GetMaxLv() then
		CSAPI.SetGOActive(txt_max,false);
		CSAPI.SetGOActive(txt_expVal,true);
		CSAPI.SetAnchor(topObj,normalPos[1],normalPos[2]);
        SetNullObj(1);
	else
		-- CSAPI.SetText(txt_expVal,string.format(expStr,"MAX","MAX"));
		CSAPI.SetGOActive(txt_max,true);
		CSAPI.SetGOActive(txt_expVal,false);
		CSAPI.SetAnchor(topObj,maxPos[1],maxPos[2]);
        SetNullObj(3)
		sBar.value=1;
		cBar.value=1;
	end
	local lvUpExp = 0;
	local tab = table.copy(equip);
	preEquip = EquipData(tab.data);
	local addExp=0;
	if stuffList then
		--计算当前增加的经验值和等级
		addExp=stuffList.stuffTotalExp;
		-- CSAPI.SetGOActive(txt_currLv,stuffList.stuffCount>0);
	-- else
		-- CSAPI.SetGOActive(txt_currLv,false);
	end
	preEquip:UpLevel(addExp);
	-- gridItem.SetIntensify(preEquip:GetLv().."/"..equip:GetMaxLv());
	--刷新基础属性对比
	local list={};
	for i=1,g_EquipMaxAttrNum do
		local id,add,upAdd=equip:GetBaseAddInfo(i);
		if id and add and upAdd then
			local addition=add+upAdd*equip:GetLv();
			local addition2=add+upAdd*preEquip:GetLv();
			local text="+"..EquipCommon.FormatAddtion(id,addition);
			local text2="+"..EquipCommon.FormatAddtion(id,addition2);
			if addition2>addition then
				table.insert(list,{id=id,val1=text,val3=text2,arrowType=1,val1Color="ffffff",val2Color="00ffbf"});
			else
				table.insert(list,{id=id,val1=text,val1Color="ffffff"});
			end
		end
	end
	ItemUtil.AddItems("AttributeNew2/AttributeItem10",baseItems,list,baseRoot,nil,1);
	local upLv=preEquip:GetLv()-equip:GetLv()>0 and "+"..tostring(preEquip:GetLv()-equip:GetLv()) or "";
	-- CSAPI.SetText(txt_lvVal,"<color=\"#00ffbf\">+"..preEquip:GetLv().."</color>/+"..equip:GetMaxLv()..upLv);
	CSAPI.SetGOActive(txt_addLvVal,upLv~="");
	CSAPI.SetText(txt_addLvVal,upLv);
	CSAPI.SetText(txt_lvVal,string.format(lvStrFormat,equip:GetLv()));
	CSAPI.SetGOActive(txt_addExp,addExp>0);
	CSAPI.SetText(txt_addExp,addExp>0 and "+"..tostring(addExp) or "");
	if equip:GetLv()~=equip:GetMaxLv() then
		local tempVal=0;
		if preEquip:GetLv()<=equip:GetMaxLv() then
			lvUpExp=equip:GetLvUpExp();
			local currExp=equip:GetExp()+stuffList.stuffTotalExp;
			-- cBar.value=currExp/lvUpExp;
			tempVal=upLv~="" and 1 or preEquip:GetExp()/lvUpExp;
			if not IsNil(sBar) then
				sBar.value=equip:GetExp()>0 and equip:GetExp()/lvUpExp or 0;
			end
			CSAPI.SetText(txt_expVal,string.format(expStr,equip:GetExp(),lvUpExp));
		-- else
		-- 	sBar.value=equip:GetExp()>0 and equip:GetExp()/lvUpExp or 0;
		-- 	-- cBar.value=1;
		-- 	tempVal=1;
		end
		if addExp>0 then
			PlayBarTween(cBar,cBarTween,tempVal);
		else
			if not IsNil(cBar) then
				cBar.value=tempVal;
			end
		end
	end
	--初始化素材信息
	local index=1;
	for k,v in ipairs(stuffList:GetStuffArr()) do
		if v.type==1 then
			stuffItems[index].Refresh(v);
			stuffItems[index].SetIndex(index);
			stuffItems[index].SetClickCB(OnClickRemoveStuff);
			index=index+1;
		else
			local num=v.num==nil and 1 or v.num
			for i=1,num do
				CSAPI.SetGOActive(stuffItems[index].gameObject,true)
				stuffItems[index].Refresh(v);
				stuffItems[index].SetIndex(index);
				stuffItems[index].SetClickCB(OnClickRemoveStuff);
				index=index+1;
			end
		end
	end
	for i=stuffList.stuffCount+1,EquipMgr.maxStuffNum do
		stuffItems[i].Refresh(nil,{plus=true});
	end
	SetPrice(stuffList==nil and 0 or stuffList.stuffTotalPrice)
	if equip:GetLv()==equip:GetMaxLv() then
		SetBtns(3);
	elseif (stuffList~=nil and stuffList.stuffCount>=1) then
		SetBtns(2);
	else
		SetBtns(1);
	end
end

function SetBtns(state)
	CSAPI.SetGOActive(btn_auto,state==1);
	CSAPI.SetGOActive(btn_clean,state==2);
	CSAPI.SetGOActive(btns,state~=3);
end

function SetPrice(num)
	CSAPI.SetGOActive(priceNode,num>0);
	local color="#ffffff"
	if num>PlayerClient:GetCoin(ITEM_ID.GOLD) then
		color="#ff7781"
		if not IsNil(aphlaCanvas) then
			aphlaCanvas.alpha=0.3;
		end
		canClick=false;
	else
		if not IsNil(aphlaCanvas) then
			aphlaCanvas.alpha=1;
		end
		canClick=true;
	end
	CSAPI.SetText(txt_price,string.format("<color=%s>%s</color>",color,num));
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	if _data:GetType()==EquipType.Material then
		local num=0;
		if stuffList then
			num=stuffList:GetStuffNumByID(_data:GetID());
		end
		grid.Refresh(_data,{isClick = true,showNew=true,num=num,disNewTween=disNewTween});
		grid.SetCount(_data:GetCount()-num);
		grid.SetHoldCB();
	else
		grid.Refresh(_data,{isClick = true,showNew=true,disNewTween=disNewTween});
		grid.SetHoldCB(OnHoldGrid);
	end
	grid.SetClickCB(OnClickGrid);
end

function CreateGrids()
    stuffItems={};
    for i=1,EquipMgr.maxStuffNum do
		ResUtil:CreateUIGOAsync("EquipInfo/EquipStuffGrid",stuffRoot,function(go)
			if IsNil(go) then
				return;
			end
            local item=ComUtil.GetLuaTable(go);
			item.Refresh(nil,{plus=true});
            table.insert(stuffItems,item);
        end);
	end
end

--点击强化
function OnClickStrength()
	if canClick~=true then
		return;
	end
	local array = stuffList:GetStuffArr();
	local equipIds = {};
	local goodIds = {};
	local mIds={};--用于统计哪些素材装备已经被查找过
	for k, v in ipairs(array) do
		if v.type == 0 then
			table.insert(equipIds, v.data:GetID());
		elseif v.type == 1 then
			local hasId=false;
			for _,id in ipairs(mIds) do
				if id==v.data:GetID() then
					hasId=true;
					break;
				end
			end
			if hasId==false then
				table.insert(mIds,v.data:GetID());
				table.insert(goodIds, {id = v.data:GetID(), num = stuffList:GetStuffNumByID(v.data:GetID()),type=RandRewardType.ITEM});
			end
		end
	end
	if selEquip:GetLv() == selEquip:GetMaxLv() then
		Tips.ShowTips(LanguageMgr:GetTips(12008));
		return;
	end
	if #equipIds > 0 or #goodIds > 0 then
		beforeLv=selEquip:GetLv();
		EquipProto:EquipUpgrade(selEquip:GetID(), equipIds, goodIds);
	else
		Tips.ShowTips(LanguageMgr:GetTips(12009));
	end
end

function OnUpgradeRet(critTips)
	if critTips then
		Tips.ShowTips(critTips);
	else
		Tips.ShowTips(LanguageMgr:GetTips(12010));
	end
	--显示强化成功界面
	selEquip = EquipMgr:GetEquip(selEquip:GetID());
	--清空选择的素材信息
	stuffList:CleanStuffInfo();
	CSAPI.PlayUISound("ui_hints_error");
	local testVal=selEquip:GetLv()-beforeLv>=1 and 1 or 0;
	if	selEquip:GetLv()~=selEquip:GetMaxLv() then
		testVal=testVal+selEquip:GetExp()/selEquip:GetLvUpExp();
	end
	if sBar and sBarTween and testVal then
		--播放升级动画
		PlayBarTween(sBar,sBarTween,testVal,function()
			--刷新界面
			if cBar~=nil then
				cBar.value=0;
			end
			EventMgr.Dispatch(EventType.Equip_StrengthTween_State,false)
			SetUseClipExpNum(0);
			RefreshPanel(selEquip)
		end);
	end
	EventMgr.Dispatch(EventType.Equip_Change);
end 

--一键选择
function OnClickAuto()
	if preEquip:GetLv()>=preEquip:GetMaxLv() or selEquip:GetLv()>=selEquip:GetMaxLv() then
		Tips.ShowTips(LanguageMgr:GetTips(12008));
		return;
	end
	stuffList:CleanStuffInfo();
	--获取当前强化的装备到满级的经验
	-- local totalExp=selEquip:GetEquipMaxLvExp();
	-- Log(totalExp)
	--计算需要的素材
	if clipExpGoods~=nil and clipExpGoods:GetCount()>0 then
		local num=clipExpGoods:GetCount();
		if num>=totalExp then
			useClipExpNum=totalExp;
		else
			useClipExpNum=num;
		end
		SetUseClipExpNum(useClipExpNum);
	end
	local ids=nil;
	if stuffList.stuffTotalExp<totalExp and stuffList:GetStuffIsMax()==false then
		--获取装备列表
		local list=EquipMgr:GetNotEquippedItem(selEquip:GetID(),false,false);
		list=SortMgr:Sort(sortID,list);
		--排序
		table.sort(list,EquipSortUtil.SortEquipRevers);
		for k,v in ipairs(list) do
			--取最前面的几个
			if v:GetExp()==0 and v:GetLv()==0 and v:GetQuality()<5 and EquipMgr:CheckIsRefreshLast(v:GetID())~=true then
				stuffList:AddStuffItem(v,0);
			end
			if stuffList:GetStuffIsMax() or stuffList.stuffTotalExp>=totalExp then
				break;
			end
		end
	end
	if stuffList.stuffCount>0 then --被选中的装备取消new状态
		for k,v in pairs(stuffList.stuffList) do
			ids=ids or {};
			local hasId=false;
			for _,val in ipairs(ids) do
				if val==v.data:GetID() then
					hasId=true;
					break;
				end
			end
			if hasId~=true and v.data:GetID()~=ITEMS_ID.EQUIP_EXP and v.data:IsNew() then
				stuffList.stuffList[k].data:SetNew(false);--本地设置为false
				table.insert(ids,v.data:GetID());
			end
		end
	end
	if ids~=nil and #ids>0 then
		EquipProto:SetIsNew(ids);
	end
	--刷新界面
	RefreshPanel(selEquip);
end

function MatchMartials(list,totalExp,totalCount,currCount,canStop)
	local countList=nil;--记录当前每种素材升级所需的数量
	local ctCount=currCount or 0;
	local tempExp=totalExp or 0;
	local subExp=0;
	for k,v in ipairs(list) do
		local exp=v:GetMaterialInfo().exp
		local count=math.floor(tempExp/exp);
		if count>=v:GetCount() then
			count=v:GetCount()
		end
		if ctCount+count>totalCount then
			count=totalCount-ctCount;
		end
		ctCount=ctCount+count;
		subExp=tempExp-exp*count;
		tempExp=subExp;
		if count>0 then
			countList=countList or {};
			table.insert(countList,{count=count,item=v});
		end
		if subExp<=0 or currCount>=totalCount or canStop then
			break;
		else
			local ret,sExp=MatchMartials(list,subExp,totalCount,ctCount,true);
			if ret~=nil then
				subExp=sExp;
				countList=countList or {};
				table.insert(countList,ret);
			end
		end
	end
	return countList,subExp,ctCount;
end

function OnClickClean()
	if stuffList then
		stuffList:CleanStuffInfo();
		useClipExpNum=0;
		SetUseClipExpNum(0);
		RefreshPanel(selEquip);
	end
end

function OnClickReturn()
    view:Close();
end

function OnHoldGrid(tab)
	lastLockIdx=tab.index;
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
	CSAPI.OpenView("EquipFullInfo",tab.data);
end

function OnLockRet()
	if lastLockIdx~=nil then
		layout:UpdateOne(lastLockIdx);
	end
end

function OnClickGrid(tab)
    --添加到stuffList中，并增加剔除id
	--设置new
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
	if EquipMgr:CheckIsRefreshLast(tab.data:GetID()) then
		do return end
	end
	if selEquip then
		if tab.data:IsLock() or tab.data:IsEquipped()  then
			do return end
		end
		if stuffList:GetStuffIsMax() == false and ((tab.GetAddNum()<tab.data:GetCount() and tab.data:GetType()==EquipType.Material) or tab.data:GetType()==EquipType.Normal) then
			if (preEquip~=nil and preEquip:GetLv()<preEquip:GetMaxLv()) then
				stuffList:AddStuffItem(tab.data,tab.data:GetType()==EquipType.Material and 1 or 0);
				if tab.data:GetType()==EquipType.Material then
					tab.SetChoosie(true);
					tab.SetAddNum(tab.GetAddNum()+1);
				end
				RefreshPanel(selEquip);
				-- RefreshList();
			else
				-- Tips.ShowTips(LanguageMgr:GetTips(12008));
				Tips.ShowTips(LanguageMgr:GetTips(12016))
			end
		else
			Tips.ShowTips(LanguageMgr:GetTips(12011));
		end
	else
		selEquip=tab.data;
		RefreshPanel(selEquip);
	end
end

function OnClickRemoveStuff(d)
	if d then
		stuffList:RemoveStuffItem(d.data:GetID(),-1);
		if d.type==1 and d.data:GetID()==ITEMS_ID.EQUIP_EXP then
			useClipExpNum=0;
			SetUseClipExpNum(0);
		end
	end
	RefreshPanel(selEquip)
end

function PlayBarTween(slider,tween,val,func)
	if tween and val>0 and cBarTween and sBarTween and cBar and sBar then
		--计算时间
		local currVal=slider.value;
		tween.target=slider.gameObject;
		tween.targetVal=val;
		local time=val>1 and (1-currVal)*500 or val*500;
		cBarTween.time=time;
		sBarTween.time=time;
		local isLvUp=val>=1;
		EventMgr.Dispatch(EventType.Equip_StrengthTween_State,true)
		tween:Play(function()
			if isLvUp and slider~=cBar then
				slider.value=0;
				CSAPI.SetGOActive(upImg,true);
				FuncUtil:Call(function()
					CSAPI.SetGOActive(upImg,false);
					if selEquip:GetLv()<selEquip:GetMaxLv() then
						PlayBarTween(slider,tween,(val-1),func);
					else
						slider.value=1;
						func();
					end
				end,nil,150);
			elseif func then
				func();
			else
				EventMgr.Dispatch(EventType.Equip_StrengthTween_State,false)
			end
		end);
	else
		slider.value=val;
		if func then
			func();
		end
	end
end

function OnClickAdd()
	if clipExpGoods and selEquip~=nil and (preEquip==nil or (preEquip and preEquip:GetLv()<preEquip:GetMaxLv())) then
		local tempNum=useClipExpNum+addCount;
		local tempNum2=stuffList.stuffTotalExp+addCount;
		if tempNum<=clipExpGoods:GetCount() and tempNum2>=selEquip:GetEquipMaxLvExp() then
			useClipExpNum=tempNum-(tempNum2-selEquip:GetEquipMaxLvExp());
		elseif tempNum>=clipExpGoods:GetCount() then
			useClipExpNum=clipExpGoods:GetCount();
		else
			useClipExpNum=tempNum;
		end
	end
	SetUseClipExpNum(useClipExpNum);
end

function OnClickRemove()
	if useClipExpNum>0 then
		useClipExpNum=useClipExpNum-addCount<0 and 0 or useClipExpNum-addCount;
	end
	SetUseClipExpNum(useClipExpNum);
end

function SetUseClipExpNum(val,isSlider)
	CSAPI.RemoveSliderCallBack(Slider,OnSliderChange);
	useClipExpNum=val or 0;
	if clipExpGoods and useClipExpNum>0 then
		sdr.value=useClipExpNum/clipExpGoods:GetCount();
	else
		useClipExpNum=0;
		sdr.value=0;
	end
	if useClipExpNum>0 then
		stuffList:RemoveStuffItem(ITEMS_ID.EQUIP_EXP,-1);
		stuffList:AddStuffItem(BagMgr:GetFakeData(ITEMS_ID.EQUIP_EXP,useClipExpNum),1,useClipExpNum,true);
	else
		stuffList:RemoveStuffItem(ITEMS_ID.EQUIP_EXP,-1);
	end
	CSAPI.SetText(txtVal,StringUtil:GetShortNumStr(useClipExpNum));
	CSAPI.AddSliderCallBack(Slider,OnSliderChange);
	--刷新界面
	RefreshPanel(selEquip);
end

function OnSliderChange(val)
	if clipExpGoods then
		local equipExp=stuffList and stuffList:GetExpByType(0) or 0;
		local addNum=math.floor(val*clipExpGoods:GetCount())
		if equipExp+addNum>=totalExp then
			local diffNum=(equipExp+addNum-totalExp)
			useClipExpNum=addNum-diffNum
		else
			useClipExpNum=addNum;
		end
	else
		useClipExpNum=0;
		clipExpGoods=nil;
	end
	SetUseClipExpNum(useClipExpNum,true);
end

function OnClickMicon()
	local good=BagMgr:GetFakeData(ITEM_ID.GOLD);
    CSAPI.OpenView("GoodsFullInfo",{data=good});
end

------------------------筛选
--[[
--页签数据
function SetTabData()
    --升降
    orderType = EquipMgr:GetOrderType(EquipViewKey.Strength);
    local rota = orderType == 2 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
end

function OnClickFiltrate()
    local mData = {}
	--需要单选
	mData.single = {["Sort"] = 1} --1无意义
    mData.list = {"Sort","Qualiy","skill"}
    mData.titles = {LanguageMgr:GetByID(24004),LanguageMgr:GetByID(24005),LanguageMgr:GetByID(24019)}
	--当前数据
	mData.info = condition
	--源数据
	local _root = {}
	_root.Sort="CfgEquipSortEnum";
	_root.Qualiy = "CfgEquipQualityEnum"
    _root.skill=EquipCommon.GetFilterSkillList();
    -- for k,v in pairs(Cfgs.CfgEquipSkillTypeEnum:GetAll()) do
    --     if v.group then
    --         table.insert(_root.skill,{id=v.id,sName=v.sName});
    --     end
	-- end
	-- table.sort(_root.skill,function(a,b)
	-- 	return a.id<b.id;
	-- end)
	mData.root = _root
	--回调
	mData.cb = OnSort
	CSAPI.OpenView("SortView", mData)
end

function OnClickUD()
    orderType = orderType==1 and 2 or 1;
    local rota = orderType == 2 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    RefreshList();
end

--筛选完毕
function OnSort(newInfo)
    condition=newInfo;
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
    RefreshList();
end
]]
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
leftObj=nil;
vsv=nil;
btnTool=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
btn_auto=nil;
txt_auto=nil;
txt_autoTips=nil;
rightObj=nil;
gridNode=nil;
txt_name=nil;
baseRoot=nil;
stuffRoot=nil;
btn_strength=nil;
txt_strength=nil;
txt_strengthTips=nil;
mIcon=nil;
txt_price=nil;
slider2=nil;
slider1=nil;
txt_lvVal=nil;
txt_expVal=nil;
view=nil;
cBarTween=nil;
cBar=nil
sBar=nil
sBarTween=nil;
end
----#End#----