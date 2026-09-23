local priceItem=nil;
local itemList={};
local itemList2={};
local numItem=nil;
local voucherItem=nil;
local voucherList=nil;
local voucherPrice=0;--折扣券抵扣价格
local data=nil;
local comm=nil; --商品数据
local curDatas=nil;
local commodityType=nil;
local isShowCard=false;
local openSetting=nil;
local addBuffs=nil;
local eventMgr=nil;
local currNum=1;
local shopPriceKey=ShopPriceKey.jCosts;
local selGridIdx=0;--只有在单双选的物品时生效，当前选中的格子下标
local curIdx1,curIdx2=0,0;--单双选当前选中的列表下标
local counts=nil;
local priceInfo=nil;
local payClicker=nil;

function Awake()
    local go= ResUtil:CreateUIGO("ShopComm/ShopPayPriceItem",priceObj.transform);
    priceItem=ComUtil.GetLuaTable(go);
    local go1= ResUtil:CreateUIGO("ShopComm/VoucherDropItem",vNode.transform);
    voucherItem=ComUtil.GetLuaTable(go1);
    local go2=ResUtil:CreateUIGO("ShopComm/ShopNumSelectItem",numObj.transform);
    numItem=ComUtil.GetLuaTable(go2);
    numItem.SetChangeFunc(OnNumChange);
    payClicker=ComUtil.GetCom(btn_pay,"Image")
    InitListener()
end

function InitListener()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Shop_PayVoucher_Change, OnVoucherChange);
    eventMgr:AddListener(EventType.Shop_Pay_ShowSwitchList,OnShowSwitchList)
    eventMgr:AddListener(EventType.Shop_Pay_SwitchListSubmit,OnHideSwitchList)
end

function OnDestroy()
    eventMgr:ClearListener();
    if comm and data.spType==nil then
        comm:SetGrid1();
        comm:SetGrid2();
    end
end

function Refresh(_data,_openSetting)
    --显示购买内容
    data=_data;
    comm=_data.commodity;
    openSetting=_openSetting
    curDatas={};
    InitContent();
end

function InitContent()
    RefreshContent();
    RefreshPriceInfo();
    RefreshVoucherItem();
end

function RefreshContent()
    local path="ShopComm/ShopPackItem";
    local curList=itemList;
    if data.spType==1 then
        SetFornitureContentList();
    elseif data.spType==2 then --主题
        path="ShopComm/ShopPackItem2";
        SetThemeContentList();
        curList=itemList2;
    elseif data.spType==3 then
        local getInfo=comm:GetGoods();
        table.insert(curDatas,{txt1=getInfo:GetName(),txt2="X"..tostring(currNum)});
    elseif comm then
        if comm:GetType()==CommodityItemType.Package or comm:GetType()==CommodityItemType.MonthCard then
            SetPackageContentList();
        elseif comm:GetType()==CommodityItemType.THEME then
            path="ShopComm/ShopPackItem2";
            SetThemeContentList();
        elseif comm:GetType()==CommodityItemType.SUIT then
            SetSuitContentList();
        elseif comm:GetType()==CommodityItemType.SingleSelection then --单选
            SetSingleSelectionList();
        elseif comm:GetType()==CommodityItemType.DoubleSelection then --双选
            SetDoubleSelectionList();
        else
            local getInfo=comm:GetCommodityList();
            table.insert(curDatas,{txt1=getInfo[1].data:GetName(),txt2="X"..tostring(getInfo[1].num*currNum)});
        end
    end
    ItemUtil.AddItems(path, itemList, curDatas, Content, nil, 1,1)
end

function SetFornitureContentList()
    curDatas={};
    table.insert(curDatas,{txt1=data.cfg.sName,txt2="X1"});
end

function SetThemeContentList()
    curDatas={};
    local cfg=data.cfg;
    if (counts == nil) then
        counts = DormMgr:GetCfgFurnitureCount(cfg.id)
    end
    for k, v in pairs(counts) do
        local buyCount = DormMgr:GetBuyCount(k)
        table.insert(curDatas, {k, v, buyCount}) -- {id,需要的数量，已购买的数量}
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            return a[1] < b[1]
        end)
    end
end

function RefreshPriceInfo()
    --初始化价格物体
    InitPrice();
    InitNumObj()
end

function OnNumChange()
    currNum=numItem.GetNum();
    RefreshVoucherPrice();
    InitNumObj();
end

function RefreshVoucherItem()
	local isShow=false;
    if voucherItem~=nil and comm and comm:GetUseVoucherTypes()~=nil and data.spType==nil then
        voucherItem.Init(comm,currNum,false,shopPriceKey);
        if voucherItem.GetOptionsLength()>0 then
            isShow=true;
        end
    end
    CSAPI.SetGOActive(vObj,isShow);
    CSAPI.SetGOActive(vNode,isShow);
end

function RefreshVoucherPrice()
    if voucherList and comm then
        local isOk,tips,res=GLogicCheck:IsCanUseVoucher(comm:GetCfg(),voucherList,TimeUtil:GetTime(),currNum,PlayerClient:GetLv());
        if isOk and res then
            voucherPrice=res[1][2];
        else
            voucherPrice=0;
        end
    else
        voucherPrice=0;
    end
end

function OnVoucherChange(ls)
    voucherList=ls;
    RefreshVoucherPrice();
    RefreshPriceInfo();
end

function InitPrice()
    priceInfo=nil;
    local alpha=1;
    local clicker=true;
    local sdkPInfo=nil;--SDK下需要显示的价格信息
    if data.spType==1 then
        local pInfo=shopPriceKey==ShopPriceKey.jCosts and data.cfg.price_1 or data.cfg.price_2
        if pInfo then
            priceInfo={id=pInfo[1][1],num=pInfo[1][2]}
        end
    elseif data.spType==2 or (comm and comm.GetType~=nil and comm:GetType()==CommodityItemType.THEME) then
        local need = 0
        local id=nil
        for k, v in ipairs(curDatas) do
            local num = v[2] > v[3] and (v[2] - v[3]) or 0
            if (num > 0) then
                local _cfg = Cfgs.CfgFurniture:GetByID(v[1])
                if (not _cfg.special) then
                    local _prices = _cfg.price_1
                    local _price = _prices and _prices[1] or nil
                    if (_price) then
                        id=_price[1]
                        need = need + _price[2] * num
                    end
                end
            end
        end
        --设置支付按钮状态
        local hasCount=true;
        if id~=nil then
            hasCount=BagMgr:GetCount(id)>=need
        end
        alpha=hasCount and 1 or 0.5;
        clicker=hasCount;
        priceInfo={id=id,num=need,needNum=need}
        if comm and comm.GetType~=nil and comm:GetType()==CommodityItemType.THEME then
            sdkPInfo={symbols=comm:GetCurrencySymbols(),price=comm:GetSDKdisplayPrice()}
        end
    elseif data.spType==3 then
        local costs=comm:GetCosts();
        local pInfo=nil;
        if costs and #costs>1 then
            priceInfo=shopPriceKey==ShopPriceKey.jCosts and costs[1] or costs[2]
        end
    elseif comm then
        priceInfo=comm:GetRealPrice();
        sdkPInfo={symbols=comm:GetCurrencySymbols(),price=comm:GetSDKdisplayPrice()}
        priceInfo=priceInfo and priceInfo[1] or nil;
    end
    CSAPI.SetGOAlpha(btn_pay,alpha);
    priceItem.Refresh(priceInfo,nil,nil,nil,sdkPInfo)
    payClicker.raycastTarget=clicker;
end

function InitNumObj()
    local maxNum=0;
    local limitNum=0;
    local priceInfo=nil;
    local sdkPInfo=nil;
    if data.spType==1 then
        local pInfo=shopPriceKey==ShopPriceKey.jCosts and data.cfg.price_1 or data.cfg.price_2
        if pInfo then
            priceInfo={id=pInfo[1][1],num=pInfo[1][2]}
        end
        local cur = DormMgr:GetBuyCount(data.cfg.id);
        maxNum = data.cfg.buyNumLimit
        limitNum=maxNum;
        if limitNum==nil or limitNum==-1 then
            limitNum=maxNum-cur;
        end
    elseif data.spType==2 or (comm and comm.GetType~=nil and comm:GetType()==CommodityItemType.THEME and data.spType==nil) then
        maxNum=1;
        limitNum=1;
        local pInfo=shopPriceKey==ShopPriceKey.jCosts and data.cfg.price_1[1] or data.cfg.price_2[1]
        priceInfo={id=pInfo[1],num=pInfo[2]}
        if comm then
            sdkPInfo={symbols=comm:GetCurrencySymbols(),price=comm:GetSDKdisplayPrice()}
        end
    elseif data.spType==3 then
        maxNum=comm:GetNum();
        limitNum=comm:GetNum();
        local costs=comm:GetCosts();
        local pInfo=nil;
        if costs and #costs>1 then
            priceInfo=shopPriceKey==ShopPriceKey.jCosts and costs[1] or costs[2]
        end
    elseif comm then
        priceInfo=comm:GetRealPrice();
        priceInfo=priceInfo and priceInfo[1] or nil;
        local itemMax =comm:GetNum() == - 1 and 99 or comm:GetNum(); --当前剩余数量
        local onceMax=comm:GetOnecBuyLimit() == - 1 and 99 or comm:GetOnecBuyLimit(); --单次购买上限
        limitNum=onceMax>itemMax and itemMax or onceMax;
        sdkPInfo={symbols=comm:GetCurrencySymbols(),price=comm:GetSDKdisplayPrice()}
        if priceInfo and priceInfo.id~=-1 then --非SDK支付
            local count=BagMgr:GetCount(priceInfo.id);
            local canBuyNum=math.floor(count/priceInfo.num); --实际可以购买的数量
            if itemMax>=onceMax then
                maxNum=onceMax>canBuyNum and canBuyNum or onceMax;
            else
                maxNum=itemMax>canBuyNum and canBuyNum or itemMax;
            end
            maxNum=maxNum==0 and 0 or maxNum;
        else --SDK支付 SDK只能单次购买
            if comm:GetSDKdisplayPrice()~=nil then --SDK价格
                priceInfo.num=comm:GetSDKdisplayPrice();
            end
            limitNum=1;
            currNum=1;
            maxNum=1;
        end
    end
    if currNum==0 and maxNum>0 then
        currNum=1;
    end
    CSAPI.SetGOActive(numObj,limitNum>1)
    numItem.Refresh(currNum,maxNum,limitNum,priceInfo,voucherPrice,sdkPInfo);
end

function SetPackageContentList()
    curDatas={};
    for k, v in ipairs(comm:GetCommodityList()) do
        if v.data:GetType() == ITEM_TYPE.PROP and v.data:GetDyVal1() == PROP_TYPE.MemberReward then -- 月卡
            if v.data:GetDy2Times() and TimeUtil:GetTime() >= v.data:GetDy2Times() then
                for key, val in ipairs(v.data:GetDy2Tb()) do
                    local itemData = GridUtil.RandRewardConvertToGridObjectData({
                        id = val[1],
                        num = val[2],
                        type = val[3]
                    });
                    table.insert(curDatas, {
                        goods = itemData,
                        txt1 =itemData:GetName(),
                        txt2 = LanguageMgr:GetByID(24021)
                    });
                end
            else
                for key, val in ipairs(v.data:GetCfg().dy_tb) do
                    local itemData = GridUtil.RandRewardConvertToGridObjectData({
                        id = val[1],
                        num = val[2],
                        type = val[3]
                    });
                    table.insert(curDatas, {
                        goods = itemData,
                        txt1 =itemData:GetName(),
                        txt2 = LanguageMgr:GetByID(24021)
                    });
                end
            end
        elseif comm:GetType() == CommodityItemType.SUIT then
			local itemData=GridUtil.RandRewardConvertToGridObjectData({id=v.cid,num = v.num,type=v.type});
			if BagMgr:GetCount(v.cid) > 0 then
				table.insert(curDatas,{itemData=itemData,desc=LanguageMgr:GetByID(73011)});
			else
				table.insert(curDatas,{itemData=itemData,desc=LanguageMgr:GetByID(24020)});
			end
        else
            local itemData = GridUtil.RandRewardConvertToGridObjectData({
                id = v.cid,
                num = v.num,
                type = v.type
            });
            table.insert(curDatas, {
                goods = itemData,
                txt1 =itemData:GetName(),
                txt2="X"..itemData:GetCount()
                -- txt2 = LanguageMgr:GetByID(24020)
            });
        end
    end
end

function SetSuitContentList()
    curDatas = {};
    for k, v in ipairs(comm:GetCommodityList()) do
        if comm:GetType() == CommodityItemType.SUIT then
            local itemData = GridUtil.RandRewardConvertToGridObjectData({
                id = v.cid,
                num = v.num,
                type = v.type
            });
            if BagMgr:GetCount(v.cid) > 0 then
                table.insert(curDatas, {
                    goods = itemData,
                    txt1 =itemData:GetName(),
                    txt2 = LanguageMgr:GetByID(73011)
                });
            else
                table.insert(curDatas, {
                    goods = itemData,
                    txt1 =itemData:GetName(),
                    txt2 = LanguageMgr:GetByID(24020)
                });
            end
        else
            local itemData = GridUtil.RandRewardConvertToGridObjectData({
                id = v.cid,
                num = v.num,
                type = v.type
            });
            table.insert(curDatas, {
                goods = itemData,
                txt1 =itemData:GetName(),
                txt2 = LanguageMgr:GetByID(24020)
            });
        end
    end
end

function SetSingleSelectionList()
    curDatas = {};
    local list1 = comm:GetCommodityList2("grid1")
    local list2 = comm:GetCommodityList2("grid2")
    local itemData1 = GridUtil.RandRewardConvertToGridObjectData({
        id = list1[1].cid,
        num = list1[1].num,
        type = list1[1].type
    });
    table.insert(curDatas, {
        -- goods = itemData1,
        itemData=itemData1,
        txt1=itemData1:GetName(),
        txt2="X"..itemData1:GetCount(),
    })
    local itemData2 = nil
    if curIdx2 > 0 and list2 and list2[curIdx2] then
        itemData2 = GridUtil.RandRewardConvertToGridObjectData({
            id = list2[curIdx2].cid,
            num = list2[curIdx2].num,
            type = list2[curIdx2].type
        });
        table.insert(curDatas, {
            -- goods = itemData2,
            itemData=itemData2,
            txt1=itemData2:GetName(),
            txt2="X"..itemData2:GetCount(),
            switchFunc=OnClickSwitch
        })
    else
        table.insert(curDatas, {
            txt1=LanguageMgr:GetByID(73006),
            txt2="",
            switchFunc=OnClickSwitch
        })
    end
end

function OnClickSwitch(lua)
   --抛出刷新信息
   if lua==nil then
        do return end
   end
   EventMgr.Dispatch(EventType.Shop_Pay_ShowSwitchList,{selGridIdx=lua.index,selIdx=lua.index==1 and curIdx1 or curIdx2,isShowList=true});
end

function OnHideSwitchList(eventData)
    selGridIdx=0;
    if eventData and eventData.selIdx then
        if eventData.selGridIdx==1 then
            curIdx1=eventData.selIdx
        elseif eventData.selGridIdx==2 then
            curIdx2=eventData.selIdx
        end
    end
    InitContent();
end

function SetDoubleSelectionList()
    curDatas = {};
    local list1 = comm:GetCommodityList2("grid1")
    local list2 = comm:GetCommodityList2("grid2")
    local itemData1 = nil
    if curIdx1 > 0 and list1 and list1[curIdx1] then
        itemData1=GridUtil.RandRewardConvertToGridObjectData({
            id = list1[1].cid,
            num = list1[1].num,
            type = list1[1].type
        });
        table.insert(curDatas, {
            -- goods = itemData1,
            itemData=itemData1,
            txt1=itemData1:GetName(),
            txt2="X"..itemData1:GetCount(),
            switchFunc=OnClickSwitch
        })
    else
        table.insert(curDatas, {
            txt1=LanguageMgr:GetByID(73006),
            txt2="",
            switchFunc=OnClickSwitch
        })
    end
    local itemData2 = nil
    if curIdx2 > 0 and list2 and list2[curIdx2] then
        itemData2 = GridUtil.RandRewardConvertToGridObjectData({
            id = list2[curIdx2].cid,
            num = list2[curIdx2].num,
            type = list2[curIdx2].type,
            
        });
        table.insert(curDatas, {
            itemData=itemData2,
            txt1=itemData2:GetName(),
            txt2="X"..itemData2:GetCount(),
            switchFunc=OnClickSwitch
        })
    else
        table.insert(curDatas, {
            txt1=LanguageMgr:GetByID(73006),
            txt2="",
            switchFunc=OnClickSwitch
        })
    end
end

function OnClickPay()
    if comm and data.spType==nil then
        if comm:GetType() == CommodityItemType.SingleSelection then
            if curIdx2 <= 0 then --自选未选择
                return
            end
            comm:SetGrid2(curDatas[2].itemData:GetID())
        elseif comm:GetType() == CommodityItemType.DoubleSelection  then
            if (curIdx2 <= 0 or curIdx2 < 0) then --自选未选择
                return
            end
            comm:SetGrid2(curDatas[2].itemData:GetID())
            comm:SetGrid1(curDatas[1].itemData:GetID())
        end
    end
    if (data.spType==2 or (comm~=nil and comm.GetType~=nil and comm:GetType()==CommodityItemType.THEME)) and priceInfo and priceInfo.needNum<=0 then
        -- 特殊家具 
        LanguageMgr:ShowTips(15122)
        return
    end
    if (data.spType==1 or data.spType==2) and comm==nil then --家具或者宿舍主题
        EventMgr.Dispatch(EventType.Shop_Dorm_OnSubmit,{id=data.id,num=currNum,shopPriceKey=shopPriceKey,spType=data.spType})
    else
        EventMgr.Dispatch(EventType.Shop_Pay_OnSubmit,{comm=comm,num=currNum,voucherList=voucherList,shopPriceKey=shopPriceKey,spType=data.spType})
    end
end

function OnShowSwitchList(eventData)
    if eventData then
        selGridIdx=eventData.selGridIdx
    end
end