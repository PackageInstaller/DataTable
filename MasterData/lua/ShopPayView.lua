--支付窗口
local eventMgr=nil;
local configs={}
local curKey="defaultSingle"
local leftItem=nil;
local rightItem=nil;
local commodityType=nil;
local comm=nil;
local addBuffs=nil;
local selectItem=nil;--选择面板
local isShowSelect=false;--是否显示选择面板
local selectGridIdx=0;--当前可选择的物品下标
local selectIdx=0;--当前列表选中的下标
local isOpening=false;
function Awake()
    InitConfigs();
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKResult);
	eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
    eventMgr:AddListener(EventType.Shop_Pay_OnSubmit,OnClickPay)
    eventMgr:AddListener(EventType.Shop_Dorm_OnSubmit,OnDormSubmit)
    eventMgr:AddListener(EventType.Shop_Pay_ShowSwitchList,OnShowSwitchList)
    eventMgr:AddListener(EventType.Shop_Pay_SwitchListSubmit,OnHideSwitchList)
    eventMgr:AddListener(EventType.Shop_Buy_NoMoneyJump,Close)
end

function OnDestroy()
    eventMgr:ClearListener();
end

--data:{id=,commodity=commodity,spType:（在无CommodityData时用于判定逻辑的类型）payFunc=特殊的购买方式回调} 
--spType:1:家具商店 2：家具主题 3: 拼图活动,只在没有commodity数据时传入！
function OnOpen()
    if data==nil then
        do return end
    end
    PlayEnter()
    InitData()
    SetKey();
    Refresh();
end

function PlayEnter()
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.SetAnchor(node,0,-500)
    CSAPI.ApplyAction(node, "View_Open_Fade");
    UIUtil:DoLocalMove(node, {0,0,0},function()
        isOpening=false;
    end)
end

function PlayOut(func)
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.ApplyAction(node, "View_Close_Fade2");
    UIUtil:DoLocalMove(node, {0,-500,0},func)
end

function InitData()
    if data.spType==1 or data.spType==2 then
        commodityType=1;
        data.commodityType=commodityType;
        if data.spType==2 then
            data.cfg=Cfgs.CfgFurnitureTheme:GetByID(data.id)
        else
            data.cfg=Cfgs.CfgFurniture:GetByID(data.id);
        end
    elseif data.spType==3 then
        commodityType=1;
        data.commodityType=commodityType;
        comm=data.commodity
    elseif data.commodity then
        comm=data.commodity
        commodityType=ShopMgr:GetCommodityTypeByData(comm);
        data.commodityType=commodityType;
        if comm:GetType()==CommodityItemType.THEME then
            local good=comm:GetCommodityList()[1];
            data.cfg=Cfgs.CfgFurnitureTheme:GetByID(good.data:GetDyVal1());
        elseif comm:GetType()==CommodityItemType.FORNITURE then
            local good=comm:GetCommodityList()[1];
            data.cfg=Cfgs.CfgFurniture:GetByID(good.data:GetDyVal1())
        end
    end
end

function SetKey()
    --根据商品类型判定当前key
    if data.spType==1 or data.spType==2 then --宿舍
        curKey="dorm";
        if data.cfg and data.cfg.price_2==nil then
            curKey="dormSingle";
        end
    elseif data.spType==3 then --拼图
        curKey="defaultSingle"
        local costs=comm:GetCosts();
        if costs and #costs>1 then
            curKey="defaultMult";
        end
    elseif comm then
        curKey="defaultSingle"
        if comm:GetType()==CommodityItemType.FORNITURE or comm:GetType() == CommodityItemType.THEME then
            curKey="dorm";
        elseif comm:GetType() == CommodityItemType.SingleSelection or comm:GetType() == CommodityItemType.DoubleSelection then --自选商品
            curKey=comm:HasOtherPrice(ShopPriceKey.jCosts1) and "lovePlusMult" or "lovePlusSingle";
        elseif comm:HasOtherPrice(ShopPriceKey.jCosts1) then--多选
            curKey="defaultMult";
        end
    end
end

function Refresh()
    --创建子物体
    local config=configs[curKey];
    if config then
        if leftItem then
            leftItem.Refresh(data);
        else
            ResUtil:CreateUIGOAsync(config.left,leftNode,function(go)
                leftItem=ComUtil.GetLuaTable(go)
                leftItem.Refresh(data);
            end);
        end
        if rightItem then
            rightItem.Refresh(data);
            CSAPI.SetGOActive(rightItem.gameObject,not isShowSelect)
        elseif not isShowSelect then
            ResUtil:CreateUIGOAsync(config.right,rightNode,function(go)
                rightItem=ComUtil.GetLuaTable(go)
                rightItem.Refresh(data);
            end);
        end
        if selectItem then
            CSAPI.SetGOActive(selectItem.gameObject,isShowSelect)
            if isShowSelect then
                selectItem.Refresh(data,{selectGridIdx,selectIdx});
            end
        elseif isShowSelect then
            ResUtil:CreateUIGOAsync("ShopComm/ShopPaySelectItemR",rightNode,function(go)
                selectItem=ComUtil.GetLuaTable(go)
                selectItem.Refresh(data,{selectGridIdx,selectIdx});
            end);
        end
    end
end

function OnShowSwitchList(eventData)
    if eventData then
        isShowSelect=eventData.isShowList
        selectGridIdx=eventData.selGridIdx;
        selectIdx=eventData.selIdx or 0;
    else
        isShowSelect=false;
    end
    Refresh();
end

function OnHideSwitchList(eventData)
    isShowSelect=false
    selectGridIdx=0;
    if eventData then
        selectIdx=eventData.selIdx or 0;
    end
    Refresh();
end

--SDK支付结果
function OnSDKResult(_d)
	if _d~=nil and _d.Code==200 and data.commodity~=nil then
		--判定是否能再次购买
		if commodityType==1 then
			data.commodity=ShopMgr:GetFixedCommodity(comm:GetID());
			local num=data.commodity:GetNum();
			if num<=0 and num~=-1 then
				Close();
			else
				Refresh();
			end
		else
			Close();
		end
	end
end

function OnQROver()
	--判定是否能再次购买 带spType时不再做判定
	if commodityType==1 and data.commodity~=nil then
		data.commodity=ShopMgr:GetFixedCommodity(comm:GetID());
		local num=data.commodity:GetNum();
		if num<=0 and num~=-1 then
			Close();
		else
			Refresh();
		end
	else
		Close();
	end
end


function Close()
    if isOpening then
        do
            return
        end
    end
    PlayOut(function()
        if not IsNil(gameObject) and not IsNil(view) then
            isOpening=false;
            view:Close(); 
        end
    end);
end


function OnClickClose()
    Close();
end

function OnClickAnyWay()
    Close();
end

function OnClickPay(eventData)
    if eventData==nil then
        do return end
    end
    if data.payFunc~=nil then
        data.payFunc(eventData);
    else
        ShopCommFunc.HandlePayLogic(eventData.comm,eventData.num,eventData.voucherList,OnSuccess,eventData.shopPriceKey);
    end
end

function OnDormSubmit(eventData)
    if eventData==nil then
        do return end
    end
    if data.payFunc~=nil then
        data.payFunc(eventData);
    else
        if eventData.spType==2 then
            local str = eventData.shopPriceKey == ShopPriceKey.jCosts and "price_1" or "price_2"
            DormProto:BuyTheme(eventData.id,str);
        else
            local infos = {{
                    ["id"] = eventData.id,
                    num = eventData.num
            }}
            DormProto:BuyFurniture(infos, eventData.shopPriceKey == ShopPriceKey.jCosts and "price_1" or "price_2")
        end
        Close()
    end
end

--购买成功
function OnSuccess(proto)
	if proto then
		if data.callback then
			data.callback(proto);
		end
		if openSetting~=2 then --openSetting为2的时候，需要自己调用奖励面板	
			addBuffs=proto.add_bufs;
			if next(proto.gets) then
				UIUtil:OpenReward( {proto.gets})
			else
				ShowBuffTips();
			end
		end
	end
    Close();
end

function ShowBuffTips()
	if addBuffs and next(addBuffs) then
		for k,v in ipairs(addBuffs) do
			local itemCfg=Cfgs.ItemInfo:GetByID(v.id);
			if itemCfg then
				Tips.ShowTips(itemCfg.describe);
			end
		end
	end
end

function InitConfigs()
    configs={
        defaultSingle={
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPaySingleItemR"
        },
        defaultMult={ --多价格
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPayMultItemR"
        },
        dorm={  --家具
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPayMultItemR"
        },
        dormSingle={  --单价格家具
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPaySingleItemR"
        },
        lovePlusSingle={ --爱相随1
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPaySingleItemR"
        },
        lovePlusMult={ --爱相随2
            left="ShopComm/ShopPaySingleItemL",right="ShopComm/ShopPayMultItemR"
        },
    }
end