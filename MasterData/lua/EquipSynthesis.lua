--装备合成
local eventMgr=nil;
local layout=nil;
local disNewTween=true;
local stuffList={};
local stuffItems={};
local overItem=nil;
local overEquip=nil;
local fixedNum=3;
local isFixed=false;
local fixedSlot=nil;
local orderType=1;
local curDatas=nil;
local sortID=14;
local fixedSuit=nil;
local quality=nil;
local priceInfos=nil;
local animaTime=1300;
local cAnimator=nil
local filterQuality={};
local sortView=nil;
local lastLockIdx=nil;

function Awake()
    cAnimator=ComUtil.GetCom(root,"Animator");
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Grid/EquipItem",LayoutCallBack,true,0.8);
	tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal);
    ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
		CSAPI.SetScale(go,1,1,1);
		sortView=ComUtil.GetLuaTable(go);
		sortView.Init(sortID,RefreshList);
		CSAPI.SetAnchor(go,45,-10);
	end);
    CSAPI.SetGOActive(effect,false)
    EventMgr.Dispatch(EventType.Equip_StrengthTween_State,true)
    InitFilter()
end

--根据定价表剔除品质
function InitFilter()
    for k, v in pairs(Cfgs.CfgEquipMultCost:GetAll()) do
        filterQuality[v.id]=1;
    end
end

function OnEnable()
    sortView.Init(sortID,RefreshList);
	if eventMgr==nil then
        eventMgr = ViewEvent.New();
        eventMgr:AddListener(EventType.Equip_Combine_SelSlot,OnSelSlot);
        eventMgr:AddListener(EventType.Equip_Remove_CombineM,OnRemoveCombine);
        eventMgr:AddListener(EventType.Bag_Update,RefreshPrice);
        eventMgr:AddListener(EventType.Equip_Combine_Ret,OnCombineRet);
        eventMgr:AddListener(EventType.Equip_SetLock_Ret,OnLockRet)
	end
end

function OnDisable()
	if eventMgr then
		eventMgr:ClearListener();
		eventMgr=nil;
	end
    lastLockIdx=nil;
end

function Refresh()
    CSAPI.SetGOActive(offObj,isFixed~=true);
    CSAPI.SetGOActive(onObj,isFixed);
    if stuffList==nil or StuffNum()<fixedNum then
        CSAPI.SetGOActive(txt2,true);
        CSAPI.SetGOActive(priceNode,false);
    else
        CSAPI.SetGOActive(txt2,false);
        CSAPI.SetGOActive(priceNode,true);
    end
    RefreshList();
    RefreshGrids();
    RefreshPrice();
end

function RefreshList()
    local list=EquipMgr:GetNotEquippedItem(nil,false);
    local source = {};
    if list then
        list=SortMgr:Sort(sortID,list);
        for i = 1, #list do--装备被选中后会被剔除
            local index=orderType==1 and #list or i;
            local has=false;
            for k, v in pairs(stuffList) do
                if v:GetID()==list[index]:GetID() then
                    has=true;
                    break;
                end
            end
            if has~=true and (fixedSuit==nil or fixedSuit==list[index]:GetSuitID()) and filterQuality[list[index]:GetQuality()] then
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
    layout:IEShowList(#curDatas,OnAnimaEnd);
end

function OnAnimaEnd()
    EventMgr.Dispatch(EventType.Equip_StrengthTween_State,false)
end

function GetMoneys()
    return {{10011},{10703}}
end

function OnLockRet()
    RefreshList()
end

--
function RefreshPrice()
    if quality == nil then
        do
            return
        end
    end
    priceInfos=nil;
    local index=1;
    local cfg = Cfgs.CfgEquipMultCost:GetByID(quality);
    -- 显示定价
    if cfg and cfg.mergeAddCost and isFixed then
        priceInfos=priceInfos or {}
        for k, v in ipairs(cfg.mergeAddCost) do
            local has=false;
            if priceInfos then
                for idx, val in ipairs(priceInfos) do
                    if v[1]==val[1] then
                        has=true;
                        priceInfos[idx]=priceInfos[idx][2]+v[2]
                        break;
                    end
                end
            end
            if has~=true then
                table.insert(priceInfos,v);
            end
        end
    end
    if cfg and cfg.mergeCost then
        priceInfos=priceInfos or {}
        for k, v in ipairs(cfg.mergeCost) do
            local has=false;
            if priceInfos then
                for idx, val in ipairs(priceInfos) do
                    if v[1]==val[1] then
                        has=true;
                        priceInfos[idx]=priceInfos[idx][2]+v[2]
                        break;
                    end
                end
            end
            if has~=true then
                table.insert(priceInfos,v);
            end
        end
    end
    for index=1, 3 do
        if priceInfos and priceInfos[index] then
            if index<=3 then
                local v=priceInfos[index];
                CSAPI.SetGOActive(this["p"..index],true);
                local goods=BagMgr:GetFakeData(v[1]);
                goods:GetIconLoader():Load(this["mIcon"..index],goods:GetIcon().."_1");
                CSAPI.SetText(this["txt_p"..index],tostring(v[2]));
                CSAPI.SetTextColorByCode(this["txt_p"..index],goods:GetCount()>=v[2] and "FFFFFF" or "E38089");
            else
                LogError("价格配置数量超出上限！");
                break;
            end
        else
            CSAPI.SetGOActive(this["p"..index],false);
        end     
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
    grid.Refresh(_data,{isClick = true,showNew=true,disNewTween=disNewTween})
	grid.SetClickCB(OnClickGrid);
    grid.SetHoldCB(OnHoldGrid);
end

function RefreshGrids()
    local iName=nil;
    for i=1,fixedNum do
        local info=stuffList[i];
        if info then
            iName=info:GetIcon();
        end
        if stuffItems[i]==nil then
            ResUtil:CreateUIGOAsync("Grid/EquipItem3",this["node"..i],function(go)
                local item=ComUtil.GetLuaTable(go);
                item.Refresh(info,{plus=true,isClick=true});
                table.insert(stuffItems,item);
            end);
        else
            stuffItems[i].Refresh(info,{plus=true,isClick=true});
        end
    end
    if overItem==nil then
        ResUtil:CreateUIGOAsync("Grid/EquipItem",overNode,function(go)
            overItem=ComUtil.GetLuaTable(go);
            if iName and quality and StuffNum()>=fixedNum then
                overItem.Clean();
                overItem.LoadIcon(iName);
                overItem.LoadFrame(quality);
                overItem.SetClickState(false);
                if isFixed and fixedSlot then
                    overItem.SetSlot(fixedSlot);
                    overItem.SetSlotColor(quality);
                end
            else
                overItem.Clean();
                overItem.SetClickState(false);
            end
        end);
    else
        if iName and quality and StuffNum()>=fixedNum then
            overItem.Clean();
            overItem.LoadIcon(iName);
            overItem.LoadFrame(quality);
            overItem.SetClickState(false);
            if isFixed and fixedSlot then
                overItem.SetSlot(fixedSlot);
                overItem.SetSlotColor(quality);
            end
        else
            overItem.Clean();
            overItem.SetClickState(false);
        end
    end
end

function OnClickGrid(tab)
	--设置new
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    if EquipMgr:CheckIsRefreshLast(tab.data:GetID()) or tab.data:IsLock() or tab.data:IsEquipped() then
		do return end
	end
    --第一个则记录固定的套装类型
    if stuffList and #stuffList==0 then
        fixedSuit=tab.data:GetSuitID()
        quality=tab.data:GetQuality();
    end
    if fixedSuit and tab.data:GetSuitID()==fixedSuit then
        if quality==tab.data:GetQuality() then
            StuffAdd(tab.data)
            Refresh()
        else
            Tips.ShowTips(LanguageMgr:GetByID(75019));
        end
    else
        Tips.ShowTips(LanguageMgr:GetByID(75020));
    end
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

function StuffAdd(_d)
    for i=1, fixedNum do
        if stuffList[i]==nil then
             stuffList[i]=_d
             break;
        end 
     end
end

function OnClickFixed()
    if isFixed~=true then
        --显示定向界面
        if StuffNum()>0 then
            CSAPI.OpenView("SelectSlotBox",{suitID=fixedSuit,quality=quality});
        else
            Tips.ShowTips(LanguageMgr:GetByID(75022));
        end
    else
        isFixed=not isFixed
        CSAPI.SetGOActive(offObj,isFixed~=true);
        CSAPI.SetGOActive(onObj,isFixed);
        RefreshGrids();
        RefreshPrice()
    end
end

--选择定向合成
function OnSelSlot(eventData)
    fixedSlot=eventData
    if fixedSlot~=nil then
        isFixed=true
    else
        isFixed=false
    end
    CSAPI.SetGOActive(offObj,isFixed~=true);
    CSAPI.SetGOActive(onObj,isFixed);
    RefreshGrids();
    RefreshPrice()
end

--移除合成素材
function OnRemoveCombine(eventData)
    if eventData and stuffList then--删除对应素材
        for k, v in pairs(stuffList) do
            if v:GetID()==eventData.data:GetID() then
                stuffList[k]=nil;
                break;
            end
        end
    end
    if StuffNum()==0 then
        fixedSuit=nil;
        fixedSlot=nil;
        quality=nil;
    end
    OnSelSlot();--祛除定向合成状态
    Refresh();
end

function StuffNum()
    local num=0;
    for k,v in pairs(stuffList) do
        num=num+1
    end
    return num;
end

--合成
function OnClickSynth()
    local hasFull=true;
    local goodName=nil;
    local jumpID=nil;
    if priceInfos then
        for k, v in ipairs(priceInfos) do
            local goods=BagMgr:GetFakeData(v[1]);
            if goods:GetCount()<v[2] then
                hasFull=false;
                goodName=goods:GetName();
                jumpID=goods:GetMoneyJumpID()
                break;
            end
        end
    end
    local dialogData={}
    if StuffNum()<fixedNum then
        Tips.ShowTips(LanguageMgr:GetByID(75022))
        do return end
    elseif hasFull then
        dialogData = {
            content = isFixed and LanguageMgr:GetByID(75015) or LanguageMgr:GetByID(75023),
            okCallBack = function()
                SendProto();
            end
        }
    else
        dialogData = {
            content = LanguageMgr:GetByID(75011,goodName),
            okCallBack = function()
                if jumpID then
                    JumpMgr:Jump(jumpID);
                end
            end
        }
    end
    CSAPI.OpenView("Dialog", dialogData);
end

function SendProto()
    if stuffList and StuffNum()>=fixedNum then
        local ids={}
        for k, v in ipairs(stuffList) do
            table.insert(ids,v:GetID());
        end
        local fSlot=isFixed and fixedSlot or nil
        EquipProto:EquipMerge(ids,fSlot);
        EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="EquipCombineRet",time=5000,
        timeOutCallBack=function()
            Tips.ShowTips(LanguageMgr:GetTips(50001));
        end});
    end
end

function OnCombineRet(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"EquipCombineRet");
	if proto and proto.newEquipId==0 then
		do return end
	end
    if cAnimator then
        if proto and proto.newEquipId~=0 then
            CSAPI.SetGOActive(effect,true)
            cAnimator:Play("Synthesis_effect",-1,0);
            FuncUtil:Call(function()
                CSAPI.SetGOActive(effect,false)
                cAnimator:Play("Synthesis_idle",-1,0);
                OnCombineAnimaEnd(proto)
            end,nil,animaTime);
        end
    else
        OnCombineAnimaEnd(proto)
    end
end

function OnCombineAnimaEnd(proto)
    if proto and proto.newEquipId then
        local rewards = {};
        local eq = EquipMgr:GetEquip(proto.newEquipId);
        if eq then
            table.insert(rewards, {
                id = eq:GetCfgID(),
                type = RandRewardType.EQUIP,
                c_id = eq:GetID(),
                num = 1
            });
            UIUtil:OpenReward({rewards});
        end
        stuffList = {};
        fixedSlot = nil;
        fixedSuit = nil;
        isFixed = false;
        quality = nil;
        Refresh();
    end
end

function OnClickMIcon1()
    OnClickMIcon(1)
end

function OnClickMIcon2()
    OnClickMIcon(2)
end

function OnClickMIcon3()
    OnClickMIcon(3)
end

function OnClickMIcon(idx)
    if priceInfos and idx then
        local good=BagMgr:GetFakeData(priceInfos[idx][1]);
        CSAPI.OpenView("GoodsFullInfo",{data=good});
    end
end