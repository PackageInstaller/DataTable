--商城协议
ShopProto={
    buyCallBack=nil,
    exchangeCallBack=nil;
    SkinRebateRewardCallBack = nil,
};
--返回购买记录信息
function ShopProto:GetShopInfos()
    local proto = {"ShopProto:GetShopInfos", {}}
	NetMgr.net:Send(proto);
    -- UIUtil:AddNetWeakHandle();
end

--获取购买记录返回
function ShopProto:GetShopInfosAdd(proto)
    -- ShopMgr:OnCommodityInfoRet(proto);
    -- EventMgr.Dispatch(EventType.Shop_RecordInfos_Refresh);
end

--购买物品
function ShopProto:Buy(cfgId,time,sum,useCost,voucherList,useJCost,callBack,grid1,grid2)
    self.buyCallBack=callBack;
    useCost=useCost==nil and "price_1" or useCost;
    local proto = {"ShopProto:Buy", {id=cfgId,buy_time=time,buy_sum=sum,useCost=useCost,vouchers=voucherList,useJCost=useJCost,grid1 = grid1,grid2 = grid2}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end
--购买物品 --新手首冲礼包
function ShopProto:Buy2(cfgId,callBack)
    self.buyCallBack2=callBack;
    local proto = {"ShopProto:Buy", {id=cfgId,buy_sum=1}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end

--购买回调
function ShopProto:BuyRet(proto)
    ShopMgr:UpdateData(proto.id,proto.info,true);
    ShopMgr:UpdateMonthDays(proto.m_cnt);
    EventMgr.Dispatch(EventType.Shop_Buy_Ret,proto)
    if proto and proto.gets and proto.id then
       local comm=ShopMgr:GetFixedCommodity(proto.id);
       if comm and comm:GetType()==CommodityItemType.Skin then
            EventMgr.Dispatch(EventType.Card_Skin_Get)
       end
    end
    if self.buyCallBack then
        self.buyCallBack(proto);
        self.buyCallBack=nil
    end
    if(self.buyCallBack2) then 
        UIUtil:OpenReward({proto.gets})
        self.buyCallBack2 = nil 
    end 
end

--兑换物品
function ShopProto:Exchange(cfgId,index,id,num,callBack)
    self.exchangeCallBack=callBack;
    local proto = {"ShopProto:Exchange", {cfgid=cfgId,index=index,id=id,num=num}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end

--兑换回调
function ShopProto:ExchangeRet(proto)
    ShopMgr:UpdateExchangeData(proto);
    EventMgr.Dispatch(EventType.Shop_Exchange_Ret,proto)
    if self.exchangeCallBack then
        self.exchangeCallBack(proto);
        self.exchangeCallBack=nil;
    end
end

--获取兑换商店数据
function ShopProto:GetExchangeInfo(cfgId,isRefresh)
    isRefresh=isRefresh==true;
    local proto={"ShopProto:GetExchangeInfo",{cfgid=cfgId,is_flush=isRefresh}};
    NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();  
end

--返回商店数据
function ShopProto:GetExchangeInfoRet(proto)
    ShopMgr:SetExchangeData(proto);
    if proto and proto.is_flush then --手动刷新 记录数数
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("store_refresh", {store_type=tostring(proto.cfgid)})
        end
    end
    EventMgr.Dispatch(EventType.Shop_RandComm_Refresh)
end

function ShopProto:GetShopResetTime()
    local proto={"ShopProto:GetShopResetTime",{}};
    NetMgr.net:Send(proto);
end

function ShopProto:GetShopResetTimeRet(proto)
    ShopMgr:SetShopResetTime(proto);
    EventMgr.Dispatch(EventType.Shop_ResetTime_Ret);
end

--获取商店页的开启时间
function ShopProto:GetShopOpenTime(isRelink)
    local proto={"ShopProto:GetShopOpenTime",{}};
    self.isRelink=isRelink;
    NetMgr.net:Send(proto);
end

function ShopProto:GetShopOpenTimeRet(proto)
    ShopMgr:InitShopOpenTime(proto);
    if self.isRelink~=true then
        EventMgr.Dispatch(EventType.Shop_OpenTime_Ret);
    end
    self.isRelink=nil;
end

--获取商店售卖的商品列表，id不发等获取所有商品内容
function ShopProto:GetShopCommodity(shopId,groupId)
    -- if shopId==nil then
    --     LogError("商店ID不得为空！");
    -- end
    local proto={"ShopProto:GetShopCommodity",{shop_id=shopId,group_id=groupId}};
    NetMgr.net:Send(proto);
end

function ShopProto:GetShopCommodityRet(proto)
    ShopMgr:OnCommodityInfoRet(proto);
    if  proto and proto.is_finish then
        EventMgr.Dispatch(EventType.Shop_RecordInfos_Refresh);
    end
end

--领取皮肤返利奖励
function ShopProto:GetSkinRebateReward(shopId,callBack)
    self.SkinRebateRewardCallBack = callBack
    local proto={"ShopProto:GetSkinRebateReward",{id=shopId}};
    NetMgr.net:Send(proto);
end

function ShopProto:GetSkinRebateRewardRet(proto)
    if self.SkinRebateRewardCallBack then
        self.SkinRebateRewardCallBack(proto)
        self.SkinRebateRewardCallBack = nil
    end
end

--获取皮肤返利信息
function ShopProto:GetSkinRebateRecord(skinId)
    local proto={"ShopProto:GetSkinRebateRecord",{skinId=skinId}};
    NetMgr.net:Send(proto);
end

--获取皮肤返利领取记录返回
function ShopProto:GetSkinRebateRecordRet(proto)
    OperationActivityMgr:SetSkinRebateGetRecords(proto)
end

--获取皮肤返利可领取记录
function ShopProto:GetSkinRebateCanTakeReward(skinId)
    local proto={"ShopProto:GetSkinRebateCanTakeReward",{skinId=skinId}};
    NetMgr.net:Send(proto);
end

--获取皮肤返利可领取记录返回
function ShopProto:GetSkinRebateCanTakeRewardRet(proto)
    OperationActivityMgr:SetSkinRebateFinishRecords(proto)
end
