local isSingle=false;--显示单件还是套装
local isSuitSelect=false;--是否选择套装芯片
local isHide=false;--是否隐藏已装备芯片
local coreSlot=-1;--芯片盘当前选择位置
local slotIdxs={-1,2,4,1,5,3};
local slotBtns={};
local slotEquips=nil; --用于缓存当前卡牌的各位置装备信息
local card=nil;
local selectIndex=nil;--当前选择的装备格子下标
local currEquip=nil;--当前选择的装备数据
local eventMgr=nil
local layout1=nil;
-- local layout2=nil;
local layout3=nil;
-- local condition=nil;
local suitOrderType=1;--降序1/升序2
local suitScreenIdx=nil;--当前套装筛选下标，取suitScreenList下对应的值
local suitScreenList={};
local orderType=1;
local lEquip=nil;
local rEquip=nil;
local selectSuitID=nil;--当前选择的套装ID
local data=nil;
local suitItems={};--套装子物体
local scroll1=nil;
local scroll3=nil;
local tweenLua=nil;
local tweenLua2=nil;
local isSwitch=false;
local sortID=12;
local sortView=nil;
local isInit=true
local fixedTime=1;
local countTime=0;
local currSuitNum=0;
local countSuitNum=0;
local loadOver=false;
function Awake()
    ResUtil:CreateUIGOAsync("EquipInfo/EquipReplaceInfo",rTObj,function(go)
        lEquip=ComUtil.GetLuaTable(go);
    end);
    ResUtil:CreateUIGOAsync("EquipInfo/EquipReplaceInfo",rBObj,function(go)
        rEquip=ComUtil.GetLuaTable(go);
    end);
    layout1=ComUtil.GetCom(sv3,"UISV");
    layout1:Init("UIs/Grid/EquipItem2",LayoutCallBack,true);
    scroll1=ComUtil.GetCom(sr3,"ScrollRect")
    -- layout2=ComUtil.GetCom(sv2,"UISV2");
    -- layout2:Init("UIs/EquipSelect/EquipSuitItem",LayoutCallBack2,true);
    layout3=ComUtil.GetCom(vsv,"UISV");
    layout3:Init("UIs/Grid/EquipItem2",LayoutCallBack3,true);
    scroll3=ComUtil.GetCom(vsr,"ScrollRect")
    tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal);
    tweenLua2=UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.Normal);
    local size=CSAPI.GetRealRTSize(sv2);
	svHeight=size[1];
    -- svMoveTween=ComUtil.GetCom(movePos,"ActionUIMoveTo");
    eventMgr = ViewEvent.New();
    local arr = CSAPI.GetScreenSize()
    bottomY=arr[1]/2*-1;
    local txts={btnDamage,btnSupport};
    for k, v in ipairs(Cfgs.CfgSuitType:GetAll()) do
        table.insert(suitScreenList,{id=v.id,cfg=v});
        if k<=#txts then
            CSAPI.SetText(txts[k],LanguageMgr:GetByID(v.sName));
        end
    end
end

function OnEnable()
	eventMgr:AddListener(EventType.EquipCore_Slot_Change, OnSlotChange);
    eventMgr:AddListener(EventType.Equip_Select_Change, OnSelectChange);
    eventMgr:AddListener(EventType.Equip_Change,OnEquipChange);
    eventMgr:AddListener(EventType.Equip_UpOne_Ret,OnUpOneRet);
    eventMgr:AddListener(EventType.Equip_Ups_Ret,OnUpsRet);
    eventMgr:AddListener(EventType.Equip_Suit_Click,OnClickSuitItem);
    eventMgr:AddListener(EventType.Equip_Down_Ret,OnEquipDown);
    eventMgr:AddListener(EventType.Equip_Click_BG,OnCancelSuitSelect)
    eventMgr:AddListener(EventType.Equip_Click_SuitUps,OnSuitUps)
    eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet);
end

function OnDisable()
    Clean();
    CSAPI.SetGOActive(rightObj,false);
    CSAPI.SetGOActive(repalceMask,false);
    eventMgr:ClearListener();
    -- EquipMgr:SetScreenData(EquipViewKey.Replace,condition);
end

function OnDestroy()
    ReleaseCSComRefs();
end

function Clean()
    selectIndex=nil;
    selectSuitID=nil
    currEquip=nil
end

--data:{card=card,slot=slot} slot=-1:代表套装
function SetData(_d)
    data=_d
    coreSlot=data.slot or -1;
    if data~=nil then
        card=data.card;
        slotEquips={}; --记录当前卡牌穿戴的装备信息
        for k,v in ipairs(card:GetEquips()) do
            local slot=v:GetSlot();
            slotEquips[slot]=v;
        end
    end
    Refresh();
end

function Refresh(isRef) --刷新面板
    ItemUtil.AddItems("EquipSelect/EquipSelectTab",slotBtns,slotIdxs,tabs,OnClickTabs,nil,coreSlot);
    -- condition = EquipMgr:GetScreenData(EquipViewKey.Replace);
    -- condition.Slot[1]=coreSlot;
    -- SetTabData();
    if coreSlot~=-1 then
        isSingle=true;
    else
        isSingle=false;
    end
    SetViewLayout()
    if not isRef then
        RefreshRepalceInfo();
    else
        CSAPI.SetGOActive(rightObj,false);
        CSAPI.SetGOActive(repalceMask,false);
    end
    RefreshList();
end

--刷新左边物体的状态
function RefreshRepalceInfo()
    local isShow=currEquip~=nil
    CSAPI.SetGOActive(rightObj,isShow);
    CSAPI.SetGOActive(repalceMask,isShow);
    if isShow and lEquip and rEquip then
        local isEqual=false;
        if slotEquips[coreSlot]~=nil then
            isEqual=slotEquips[coreSlot]:GetID()==currEquip:GetID();
            CSAPI.SetGOActive(rBObj,not isEqual);
            CSAPI.SetGOActive(arrow,not isEqual);
            if not isEqual then
                rEquip.SetData({equip=slotEquips[coreSlot],cardId=card~=nil and card:GetID() or nil});
            end
        else
            CSAPI.SetGOActive(rBObj,false);
            CSAPI.SetGOActive(arrow,false);
        end
        lEquip.SetData({equip=currEquip,equip2=isEqual==true and nil or slotEquips[coreSlot],cardId=card~=nil and card:GetID() or nil},true);
    end
end

function Update()
    if scroll1.velocity.y>=10 or scroll3.velocity.y>=10 then
        if repalceMask.activeSelf then
            OnClickRepalceMask()
        end
    end
    countTime=countTime+Time.deltaTime;
    if countTime>=fixedTime and curDatas2~=nil and not isSingle and loadOver then
        countSuitNum=0;
        local currTime=TimeUtil:GetTime();
        local screenType = suitScreenIdx == nil and nil or suitScreenList[suitScreenIdx]
        for _,cfg in pairs(Cfgs.CfgSuit:GetAll()) do --计算可以显示的套装数量
			local canAdd=true;
			if cfg.limitTime then
				local lTime=TimeUtil:GetTimeStampBySplit(cfg.limitTime)
				canAdd=currTime>=lTime;
			end
			if cfg.show==1 and canAdd and (screenType==nil or (screenType~=nil and cfg.SuitType==screenType.id)) then
                countSuitNum=countSuitNum+1;
            end
        end
        if countSuitNum~=#curDatas2 then--刷新界面
            RefreshList();
        end
    end
end

function OnClickRepalceMask()
    CSAPI.SetGOActive(rightObj,false);
    CSAPI.SetGOActive(repalceMask,false);
    selectIndex=nil;
    currEquip=nil;
    RefreshList();
end

function OnLockRet()
    RefreshList();
end

--刷新列表
function RefreshList()
    --剔除当前卡牌穿戴的装备
    selectIndex=nil;
    -- condition.Equipped=isHide and {2} or {0}; --显示隐藏已装备
    SetSortObj();
    if isSingle then
        local list=EquipMgr:GetEquipArr(coreSlot,nil,false);
        local temp={};
        if list then
            for k,v in ipairs(list) do --筛选已装备
                if (isHide and v:IsEquipped()~=true) or isHide~=true then
                    table.insert(temp,v);
                end
            end
        end
        -- list=EquipMgr:DoScreen(list, condition)
        -- if list then
        --     if orderType ==1 then --正序。倒序
        --         local source = {};
        --         for i = 1, #list do
        --             table.insert(source, list[#list]);
        --             table.remove(list, #list);
        --         end
        --         curDatas=source;
        --     else
        --         curDatas = list;
        --     end
        -- end
        curDatas=SortMgr:Sort(sortID,temp);
        CSAPI.SetGOActive(nilObj,#curDatas<=0)
        CSAPI.SetGOActive(sv3,#curDatas>0);
        -- CSAPI.SetGOActive(SortNone,#curDatas>0);
        if #curDatas>0 then
            if isSwitch then
                PostTweenEvent(true);
                tweenLua:AnimAgain();
                isSwitch=false;
            elseif isInit then
                PostTweenEvent(true);
                isInit=false;
            end
            layout1:IEShowList(#curDatas,function()
                PostTweenEvent(false);
            end);
        end
    else
        CSAPI.SetGOActive(sv3,false);
        loadOver=false;
        local list = EquipMgr:GetEquipSuitData2({}, not isHide, nil);
        table.sort(list, EquipSortUtil.SuitSort);
        curDatas2 = {};
        local screenType = suitScreenIdx == nil and nil or suitScreenList[suitScreenIdx]
        if suitOrderType == 2 then -- 升序
            for i = 1, #list do
                if screenType == nil or (screenType ~= nil and list[#list].cfg.SuitType == screenType.id) then
                    table.insert(curDatas2, list[#list]);
                end
                table.remove(list, #list);
            end
        else
            for i = 1, #list, 1 do
                if screenType == nil or (screenType ~= nil and list[i].cfg.SuitType == screenType.id) then
                    table.insert(curDatas2, list[i]);
                end
            end
        end
        CSAPI.SetGOActive(nilObj,false)
        if isSuitSelect then
            RefreshSuitObj();
        else
            RefreshSuitList();
        end
    end
end

function RefreshSuitObj()
    if selectSuitID then
        local list=nil;
        for k, v in ipairs(curDatas2) do
            if v.cfg.id==selectSuitID then
                list=v;
                break;
            end            
        end
        list=list or {};
        --排序筛选
        -- local cfg=list.cfg;
        -- list=EquipMgr:DoScreen(list, condition)
        -- if list then
        --     if orderType ==1 then --正序。倒序
        --         local source = {};
        --         for i = 1, #list do
        --             table.insert(source, list[#list]);
        --             table.remove(list, #list);
        --         end
        --         curDatas3=source;
        --     else
        --         curDatas3 = list;
        --     end
        -- end
        local cfg=list.cfg;
        list.cfg=nil;
        curDatas3 = list;
        curDatas3=SortMgr:Sort(sortID,list);
        CSAPI.SetGOActive(SortNone,#curDatas3>0);
        ResUtil.EquipSkillIcon:Load(icon,cfg.icon);
        CSAPI.SetText(txt_name,cfg.name);
        CSAPI.SetText(txt_desc,cfg.dec);
        local num=#curDatas3;
        CSAPI.SetText(txt_num,tostring(num));
        if num>0 then
            if isSwitch then
                PostTweenEvent(true);
                tweenLua2:AnimAgain();
                isSwitch=false;
            elseif isInit then
                PostTweenEvent(true);
                isInit=false;
            end
            layout3:IEShowList(num,function()
                PostTweenEvent(false);
            end);
        end
    end
end

function PostTweenEvent(isTween)
    EventMgr.Dispatch(EventType.Equip_TweenMask_State,isTween)
end

function RefreshSuitList()
    --创建/刷新子物体
    ItemUtil.AddItems("EquipSelect/EquipSuitItem",suitItems,curDatas2,Content,OnClickSuitItem,1,{equippdType=2,cardId=card:GetID()},function()
        loadOver=true;
    end);
    -- layout2:IEShowList(#curDatas2);
end

function OnCancelSuitSelect()
    if isSuitSelect then
        CancelSuitSelect();
        Refresh();
    end
end

function CancelSuitSelect()
    if isSuitSelect then
        isSuitSelect=false;
        selectSuitID=nil;
        EventMgr.Dispatch(EventType.Equip_Select_Change,{equip=slotEquips[coreSlot],slot=coreSlot,isTabs=false,isSuitSelect=selectSuitID~=nil});
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
	local isSelect = false;
    local grid=layout1:GetItemLua(index);
    local equippdType=_data:GetCardId()==card:GetID() and 2 or 1;
	if _data and currEquip then
		isSelect =_data:GetID()==currEquip:GetID();
		selectIndex=isSelect==true and index or selectIndex;
    end
	grid.SetIndex(index);
	grid.Refresh(_data,{isClick = true, isSelect = isSelect,selectType=1,showNew=true,equippdType=equippdType});
	grid.SetClickCB(OnClickEquip);
end

-- function LayoutCallBack2(index)
--     local _data = curDatas2[index]
--     local item=layout2:GetItemLua(index);
--     if item then
--         item.SetIndex(index);
--         item.Refresh(_data,elseData);
--         item.SetClickCB(OnClickSuitItem);
--     end
-- end

function LayoutCallBack3(index)
    local _data = curDatas3[index]
    if _data then
        local isSelect = false;
        local grid=layout3:GetItemLua(index);
        local equippdType=_data:GetCardId()==card:GetID() and 2 or 1
        if _data and currEquip then
            isSelect =_data:GetID()==currEquip:GetID();
            selectIndex=isSelect==true and index or selectIndex;
        end
        grid.SetIndex(index);
        grid.Refresh(_data,{isClick = true, isSelect = isSelect,selectType=1,showNew=true,equippdType=equippdType});
        grid.SetClickCB(OnClickEquip);
    end
end

--当选择位置更改时
function OnSlotChange(eventData)
    coreSlot = eventData.slot;
    if eventData.hasEquip then --当前槽位有装备
        currEquip=slotEquips[eventData.slot]
    end
    CancelSuitSelect();
    -- if not isSuitSelect then
        Refresh(eventData.disReplace);
    -- else
    --     Refresh(eventData.disReplace);
    --     RefreshRepalceInfo()
    -- end
end

function OnEquipDown()
    if isSuitSelect then
        card=RoleMgr:GetData(card:GetID())
        slotEquips={};
        for k,v in ipairs(card:GetEquips()) do
            local slot=v:GetSlot();
            slotEquips[slot]=v;
        end
        if coreSlot then
            currEquip=slotEquips[slot]
        end
        RefreshRepalceInfo();
        RefreshList();
        return;
    end
    OnEquipChange();
end

--当装备变更时
function OnEquipChange(dontRefresh)
    if dontRefresh then
        return;
    end
    card=RoleMgr:GetData(card:GetID())
    slotEquips={};
    for k,v in ipairs(card:GetEquips()) do
        local slot=v:GetSlot();
        slotEquips[slot]=v;
    end
    if coreSlot then
        currEquip=slotEquips[coreSlot]
    end
    Refresh();
end

--当选择装备变更
function OnSelectChange(eventData)
    if coreSlot~=eventData.slot then
        coreSlot=eventData.slot;
        -- if isSingle then
            -- condition.Slot[1]=coreSlot;
        -- end
    end
    if currEquip==eventData.equip then
        currEquip=nil;
    elseif eventData.isTabs~=true then
        --切换装备槽选中的位置，刷新右面板的信息
        currEquip=eventData.equip;
    end
    if eventData.isTabs~=true then
        RefreshRepalceInfo();
    end
end

function OnClickEquip(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    EventMgr.Dispatch(EventType.Equip_Select_Change,{equip=tab.data,slot=tab.data:GetSlot(),isSuitSelect=isSuitSelect});
    local curLayout=isSuitSelect and layout3 or layout1;
	if selectIndex and selectIndex ~= tab.index then
		curLayout:UpdateOne(selectIndex);
        selectIndex=tab.index
        tab.SetChoosie(true);
    elseif selectIndex==tab.index then
        selectIndex=nil
        tab.SetChoosie(false);
	else
        selectIndex=tab.index
        tab.SetChoosie(true);
    end
end

function SetViewLayout()
    local type2=not isSingle;
    if isSingle then
        CSAPI.SetGOActive(btnTool,true);
    elseif isSuitSelect then
        CSAPI.SetGOActive(btnTool,true);
    else
        CSAPI.SetGOActive(btnTool,false);
    end
    if type2 and isSuitSelect~=true then
        CSAPI.SetGOActive(sv2,type2);
        CSAPI.SetGOActive(suitObj,false);
        CSAPI.SetGOActive(btnTool2,true);
        CSAPI.SetGOActive(btnHide,false)
    elseif type2 and isSuitSelect==true then
        CSAPI.SetGOActive(suitObj,true);
        CSAPI.SetGOActive(sv2,false);
        CSAPI.SetGOActive(btnTool2,false);
        CSAPI.SetGOActive(btnHide,true)
    else
        CSAPI.SetGOActive(suitObj,false);
        CSAPI.SetGOActive(sv2,false);
        CSAPI.SetGOActive(btnTool2,false);
        CSAPI.SetGOActive(btnHide,true)
    end
    SetViewTypeStyle(isHide)
end


--设置按钮样式
function SetViewTypeStyle(isOn)
    CSAPI.SetGOActive(hOffObj,not isOn);
    CSAPI.SetGOActive(hOnObj,isOn);
end

function OnClickHide()
    isHide=not isHide;
    SetViewTypeStyle(isHide)
    RefreshList();
end

function OnClickSuitObj()
    -- CancelSuitSelect();
    currEquip=nil;
    coreSlot=-1;
    OnCancelSuitSelect();
end

--点击替换
function OnClickReplace()
    if currEquip then
		local card2 = RoleMgr:GetData(card:GetID());
		local isFight = TeamMgr:GetCardIsDuplicate(card2:GetID());
		if isFight then
			Tips.ShowTips(LanguageMgr:GetTips(12003))
			return;
        end
		EquipProto:EquipUp(currEquip:GetID(), card2:GetID());
	end
end

function OnUpOneRet(eventData)
    if eventData and currEquip and currEquip:GetID()==eventData.equipId and card and card:GetID()==eventData.cardId then
        slotEquips[coreSlot]=currEquip;
        currEquip=nil;
        RefreshRepalceInfo();
        CSAPI.PlayUISound("ui_stretch")
    elseif eventData and currEquip==nil then
        slotEquips[coreSlot]=EquipMgr:GetEquip(eventData.equipId);
        currEquip=slotEquips[coreSlot]
        CSAPI.PlayUISound("ui_stretch")
    end
    EventMgr.Dispatch(EventType.Equip_Change,true);
    -- if isSuitSelect then
        RefreshList();
    --     return;
    -- end
    -- if suitSelect then
    --     suitSelect.Close();
    -- end
end

function OnUpsRet(eventData)
    Tips.ShowTips(LanguageMgr:GetByID(23058))
    EventMgr.Dispatch(EventType.Equip_Change);
end

--全套替换
function OnSuitUps()
    --查找匹配的装备id
    if curDatas3 and isSuitSelect and selectSuitID then
        local suitID=selectSuitID
        local equips=EquipMgr:GetEquipSuitBeast(suitID,false);
        if equips~=nil then
            local suitIds={};
            local equippeds={};--已经在其他卡牌上装备的装备信息
            for k,v in pairs(equips) do
                local isEquipped=v:IsEquipped();
                local isCurr=v:GetCardId()~=card:GetID();
                if (not isEquipped) or (isEquipped and isCurr) then
                    table.insert(suitIds,v:GetID());
                end
                if isEquipped and isCurr then
                    table.insert(equippeds,v);
                end
            end
            if #equippeds>1 then--显示替换Tips界面
                CSAPI.OpenView("EquipReplaceTips",{es=equippeds,ids=suitIds,cardId=card:GetID()});
            elseif #equippeds==1 then --弹出确认框
                local tempCard=RoleMgr:GetData(equippeds[1]:GetCardId());
                local dialogdata = {
                    content = LanguageMgr:GetByID(23061,tempCard:GetName()),
                    okCallBack = function()
                        EquipProto:EquipUps(card:GetID(),suitIds);
                    end
                }
                CSAPI.OpenView("Dialog", dialogdata);
            else
                if #suitIds>0 then
                    EquipProto:EquipUps(card:GetID(),suitIds);
                elseif #equips~=0 then
                    Tips.ShowTips(LanguageMgr:GetByID(23075));
                end
            end
        else
            Tips.ShowTips(LanguageMgr:GetTips(12004));
        end
    end
end

--选择一套套装时
function OnClickSuitItem(lua)
    --进入套装选择界面
    if #lua.data<=0 then
        Tips.ShowTips(LanguageMgr:GetByID(23063))
        return;
    end
    selectSuitID=lua.data.cfg.id;
    isSingle=false;
    isSuitSelect=true;
    isSwitch=true
    Refresh(true);
end

function OnClickTabs(_slot)
    if _slot~=coreSlot then
        isSwitch=true;
    end
    coreSlot=_slot;
    -- if _slot~=nil then
    --     currEquip=slotEquips[coreSlot]
    -- else
    --     currEquip=nil
    -- end    
    CSAPI.SetGOActive(rightObj,false);
    CSAPI.SetGOActive(repalceMask,false);
    if coreSlot~=-1 then
        CancelSuitSelect();
    end
    Refresh(true);
    EventMgr.Dispatch(EventType.Equip_Select_Change,{equip=slotEquips[coreSlot],slot=coreSlot,isTabs=true,isSuitSelect=selectSuitID~=nil});
end

function Close()
    CSAPI.SetGOActive(gameObject,false)
end

function OnClickNumSort()
    suitOrderType=suitOrderType==1 and 2 or 1;
    CSAPI.SetAngle(numArrow,0,0,suitOrderType==1 and -90 or 90);
    RefreshList();
end

function SetsuitScreenIdx(clickType)
    if suitScreenIdx==clickType then
        suitScreenIdx=nil;
    else
        suitScreenIdx=clickType
    end
    --设置文字颜色
    local c1,c2="ffffff","ffc146"
    CSAPI.SetTextColorByCode(btnDamage,suitScreenIdx==1 and c2 or c1);
    CSAPI.SetTextColorByCode(btnSupport,suitScreenIdx==2 and c2 or c1);
    RefreshList();
end

--筛选输出套装
function OnClickDamage()
    SetsuitScreenIdx(1);
end

--筛选辅助套装
function OnClickSupport()
    SetsuitScreenIdx(2)
end

------------------------筛选
function SetSortObj()
	--判断筛选ID
    local tempID=0;
	if isSuitSelect then
		tempID=12;
	else
        tempID=13
	end
    local isChange=tempID~=sortID
    sortID=tempID;
	if sortView==nil and isLoadSortView~=true then
		isLoadSortView=true
		ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
			CSAPI.SetScale(go,0.8,0.8,0.8);
			sortView=ComUtil.GetLuaTable(go);
			sortView.Init(sortID,RefreshList);
			CSAPI.SetAnchor(go,0,0);
		end);
	elseif sortView~=nil and isChange then
		sortView.Init(sortID,RefreshList);
	end
end

--[[
--页签数据
function SetTabData()
    --升降
    orderType = EquipMgr:GetOrderType(EquipViewKey.Replace);
    local rota = orderType == 1 and 180 or 0
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
    --     if v.group and v.show then
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
    local rota = orderType == 1 and 180 or 0
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
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
leftObj=nil;
sv=nil;
topObj=nil;
btnTool=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
btnTool2=nil;
tabs=nil;
sv2=nil;
bottomObj=nil;
offObj=nil;
onObj=nil;
txt_vt1=nil;
txt_vt2=nil;
panelNode=nil;
rightObj=nil;
rTObj=nil;
lInfoNode=nil;
upObj=nil;
rBObj=nil;
rInfoNode=nil;
tipsRoot=nil;
txt_skillTips=nil;
view=nil;
end
----#End#----