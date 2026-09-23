-- 背包管理
local this = MgrRegister("BagMgr")

-- 设置数据
function this:SetData(bagData)
    if (bagData~=nil) then
        if bagData.ix==1 then
            self.datas=nil;
            self.arr=nil;
        end
        if bagData.item then
            for index, data in ipairs(bagData.item) do
                self:UpdateGoodsData(data);
            end
        end
        if bagData.is_finish then
            self:CheckBagRedInfo();
            EventMgr.Dispatch(EventType.Bag_Update)
            RoleMgr.OnBagUpdate(true)
        end
    end
end
-- 更新数据
function this:UpdateData(newData)
    self.arr = nil;

    if (newData and newData.data) then
        for _, data in ipairs(newData.data) do
            self:UpdateGoodsData(data, true);
        end
        self:CheckBagRedInfo();
        EventMgr.Dispatch(EventType.Bag_Update)
    end
    RoleMgr.OnBagUpdate(false)
end

-- 更新物品数据
function this:UpdateGoodsData(data, setNew)
    self.datas = self.datas or {}
    if (self:UpdateCoin(data) == false) then
        if data then
            -- if data.id==10036 then
            --     data.get_infos={
            --         {3,TimeUtil:GetTime()+120,100351},
            --         {5,TimeUtil:GetTime()+(3600*24*7),100354},
            --         {3,TimeUtil:GetTime()+(3600*22),100351},
            --     }
            -- end
            if data.get_infos and #data.get_infos>=1 then --带限时道具的物品
                --分类统计限时物品数量            
                local tempList={};
                local fixedNum=data.num;
                local index=1;
                for k,v in ipairs(data.get_infos) do
                    local id=v[3];
                    local num=v[1];
                    tempList[id]=tempList[id] or {};
                    tempList[id].id=id;
                    if tempList[id].num then
                        tempList[id].num=tempList[id].num+num;
                    else
                        tempList[id].num=num;
                    end
                    tempList[id].get_infos=tempList[id].get_infos or {};
                    v.index=index;
                    table.insert(tempList[id].get_infos,v);
                    if tempList[id].num>0 then
                        index=index+1;
                    end
                    fixedNum=fixedNum-num;
                end
                --限时道具
                for k,v in pairs(tempList) do
                    local tempData=table.copy(data);
                    tempData.num=v.num;
                    tempData.id=v.id;
                    tempData.get_infos=v.get_infos;
                    self:UpdateDataBase(tempData,setNew)
                end
                --固定道具
                if fixedNum>0 then
                    local tempData=table.copy(data);
                    tempData.get_infos=nil;
                    tempData.num=fixedNum;
                    self:UpdateDataBase(tempData,setNew)
                end
            else
               self:UpdateDataBase(data,setNew);
            end
        end
    end
end

function this:UpdateDataBase(data,setNew)
    if data==nil then
        LogError("传入的物品数据不得为空！")
        return;
    end
    local goodsData = self:GetData(data.id);
    if (goodsData) then
        if (data.num and data.num <= 0) then
            -- 移除     
            goodsData:GetData().num = data.num --头像相关会继续调用数量进行判断   
            self:RemoveGoods(data.id);
        else
            -- 更新
            for k, v in pairs(data) do
                goodsData:GetData()[k] = v; -- mo 
            end
        end
    else
        -- 新增物品
        goodsData = GoodsData(data);
        self.datas[data.id] = goodsData;
        if (setNew) then
            self:SetNewState(data.id, true);
        end
    end
    --限时物品与红点
    if(goodsData:GetItemType()==ITEM_TYPE.ICON_FRAME) then 
        HeadFrameMgr:UpdateGoodsData(goodsData,setNew)
    elseif(goodsData:GetItemType()==ITEM_TYPE.ICON) then 
        HeadIconMgr:UpdateGoodsData(goodsData,setNew)
    elseif(goodsData:GetItemType()==ITEM_TYPE.ICON_TITLE) then 
        HeadTitleMgr:UpdateGoodsData(goodsData,setNew)
    elseif(goodsData:GetItemType()==ITEM_TYPE.ICON_EMOTE) then 
        HeadFaceMgr:UpdateGoodsData(goodsData,setNew)
    elseif(goodsData:GetItemType()==ITEM_TYPE.ASMR) then 
        ASMRMgr:UpdateGoodsData(goodsData,setNew)
    elseif(goodsData:GetItemType()==ITEM_TYPE.MAIN_THEME_UI) then 
        MenuThemeMgr:UpdateGoodsData(goodsData,setNew)
    end
end

-- 更新货币类
function this:UpdateCoin(data)
    -- 角色存储经验
    if (data.id == ITEM_ID.CARD_STORE_EXP) then
        RoleMgr:UpdateStoreExp(data.num)
        return true
    elseif (data.id == g_ArmyCoinId) then
        PlayerClient:UpdateCoin(data.id, data.num)
        return true
    elseif (data.id == g_AbilityCoinId) then      
        PlayerClient:UpdateCoin(data.id, data.num)
		PlayerAbilityMgr:CheckRedPointData()
        return true
    else
        for i, v in pairs(ITEM_ID) do
            if (data.id == v) then
                PlayerClient:UpdateCoin(data.id, data.num)
                return true
            end
        end
    end
    return false
end

-- 是否新物品
function this:IsNew(id)
    return self.news and self.news[id] or false;
end
function this:SetNewState(id, state)
    self.news = self.news or {};
    self.news[id] = state;
end

-- 移除物品
function this:RemoveGoods(id)
    if (self.datas) then
        self.datas[id] = nil;
    end
end

-- 获取数据
function this:GetData(_id)
    if (_id == nil) then
        LogError("获取物品失败！！id无效" .. tostring(_id));
    end
    local _b, _num = self:IsCoin(_id)
    if (_b) then
        local data = {
            id = _id,
            num = _num
        }
        local goodsData = GoodsData(data)
        return goodsData
    elseif (self.datas) then
        return self.datas[_id];
    end
    return nil;
end

--检查是否显示背包红点
function this:CheckBagRedInfo()
	local tagValue=nil;
    self.lessLimitTime=nil;
    if self.datas then
        local currTime=TimeUtil:GetTime();
        local isRecord=false;
        local limitTime=nil;
        local limitID=nil;
        for k, v in pairs(self.datas) do
            if v:GetCfgTag()==2 then --5是消耗品,将需要显示红点的tag值加入数组
                if isRecord~=true then
                    tagValue=tagValue or {};
                    table.insert(tagValue,v:GetCfgTag());
                    isRecord=true;
                end    
            end
            if (v:IsExipiryType() or v:GetExpiry()) and (not v:IsHide()) then--限时物品记录最近的一个快要到期的时间
                limitTime=v:GetExpiry();
                if v:GetData().get_infos and #v:GetData().get_infos>1 then
                    for _, val in ipairs(v:GetData().get_infos) do
                        local tempData=table.copy(v:GetData());
						tempData.num=val[1];
						tempData.id=val[3];
						tempData.get_infos={val};
						local tempGoods=GoodsData(tempData);
                        if limitTime==nil or  (limitTime and limitTime>tempGoods:GetExpiry()) then
                            limitTime=tempGoods:GetExpiry();
                        end
                    end
                end
                if self.lessLimitTime ~= nil then
                    if limitTime > currTime and limitTime < self.lessLimitTime then
                        self.lessLimitTime = limitTime
                    end
                elseif limitTime > currTime then
                    self.lessLimitTime = limitTime
                end
                if limitTime>currTime then
                    tagValue=tagValue or {};
                    tagValue.limitTags=tagValue.limitTags or {};
                    tagValue.limitTags[v:GetCfgTag()]=true;
                end
            end
        end
    end
	local data=tagValue~=nil and {tagList=tagValue} or nil
    RedPointMgr:UpdateData(RedPointType.MaterialBag,data);
end

--返回最接近当前时间的物品时间
function this:GetLessLimitTime()
    return self.lessLimitTime or nil;
end

--是否显示limitIcon
function this:IsShowLimit()
    local lessTime=self:GetLessLimitTime();
    if lessTime then
        local curTime=TimeUtil.GetTime();
        if lessTime>curTime and lessTime-curTime<=172800 then --小于48小时都显示
            return true;
        end
    end
    return false;
end

--记录24小时内限时物品的提示是否有过
function this:RecordDayLimitTips()
    self.dayLimitTime=TimeUtil:GetTime();
    self.hasDayLimitTips=true;
    FileUtil.SaveToFile("DayLimitRecord.txt",{dayLimitTime=self.dayLimitTime});
end

--返回24小时内是否已经弹过提示
function this:IsDayLimitTipsDone()
    if self.hasDayLimitTips==true then
        return self.hasDayLimitTips;
    else
        self.hasDayLimitTips=false;
    end
    if self.dataLimitTime==nil or self.dataLimitTime==0 then
        local info=FileUtil.LoadByPath("DayLimitRecord.txt");
        if info and info.dayLimitTime~=nil then
            self.dataLimitTime=info.dayLimitTime;
        else
            self.dataLimitTime=0;
        end
    end
    local curTime=TimeUtil:GetTimeHMS(TimeUtil:GetTime());
    local dTime=TimeUtil:GetTimeHMS(self.dataLimitTime);
    if curTime and dTime then
        if curTime.year==dTime.year and curTime.yday==dTime.yday then
            self.dataLimitTime=TimeUtil:GetTime();
            self.hasDayLimitTips=true;
        end
    end
    return self.hasDayLimitTips;
end

-- ==============================--
-- desc:是否是货币类型，数量
-- time:2019-09-17 10:54:01
-- @id:
-- @return 
-- ==============================--
function this:IsCoin(id)
    for i, v in pairs(ITEM_ID) do
        if (v == id) then
            return true, PlayerClient:GetCoin(id)
        end
    end
    if id == g_AbilityCoinId or id == g_ArmyCoinId then
        return true, PlayerClient:GetCoin(id);
    end
    return false, 0
end

-- 通过类型获取数据
function this:GetDataByType(type,propType)
    local newArr = {}
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetType() == type) then
                if (propType==nil) or (propType and v:GetDyVal1()==propType) then
                    table.insert(newArr, v)
                end
            end
        end
    end
    return newArr
end

-- 通过类型获取数据 字典
function this:GetDataByTypeDic(type)
    local newDic = {}
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetType() == type) then
                newDic[v:GetID()] = v
            end
        end
    end
    return newDic
end

-- 获取数据,字典型
function this:GetDatas()
    return self.datas;
end
-- 获取数据，数组型
function this:GetArr()
    if (self.arr == nil) then
        if (self.datas) then
            self.arr = {};
            for _, data in pairs(self.datas) do
                if (data) then
                    table.insert(self.arr, data);
                end
            end
        end
    end

    return self.arr;
end

-- 数量
function this:Count()
    return self.arr and #self.arr or 0;
end

-- 设置选中的标签索引
function this:SetSelTabIndex(index)
    self.tabIndex = index;
end
-- 获取选中的标签索引
function this:GetSelTabIndex()
    return self.tabIndex or 1;
end

-- 设置选中的子标签索引
function this:SetSelChildTabIndex(index)
    self.childTabIndex = index;
end

-- 返回选中的子标签索引
function this:GetSelChildTabIndex()
    return self.childTabIndex or 1;
end

function this:SetEquipSelectCond(cond)
    self.selectEquipCond = cond;
end

function this:GetEquipSelectCond()
    return self.selectEquipCond or nil;
end

-- 设置一个假数据
function this:GetFakeData(cfgId, _num)
    _num = _num==nil and self:GetCount(cfgId) or _num
    return GoodsData({id = cfgId, num = _num});
end

-- -- 设置一个假数据
-- function this:GetFakeData(cfgId, _num)
--     local _data = self:GetData(cfgId)
--     _num = _num or 0
--     if (_data) then
--         return _data
--     else
--         local data = {
--             id = cfgId,
--             num = _num
--         }
--         local goodsData = GoodsData(data)
--         return goodsData
--     end
-- end
-- 获取物品数量
function this:GetCount(id)
    if (id == nil) then
        LogError("获取物品失败！！id无效");
        return 0
    end
    local _b, _num = self.IsCoin(id)
    local item=GoodsData({id = id, num = 0});
    if (_b) then
        return _num
    elseif item and item:GetType()==ITEM_TYPE.SKIN then --皮肤
        local skinID=item:GetDyVal2();
        if skinID then
            local curModelCfg=Cfgs.character:GetByID(skinID)
            if curModelCfg==nil then
                LogError("未找到ID:"..tostring(skinID).."相关的皮肤信息！")
                return 0
            end
            local rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
            if rSkinInfo and rSkinInfo:GetCanUse() then
                return 1;
            else
                return 0;
            end
        else
            return 0;
        end
    else
        return BagMgr:GetData(id) and BagMgr:GetData(id):GetCount() or 0
    end
end

--根据物品素材ID获取素材礼包信息
function this:GetPackagesByCfgID(cfgId)
    local list=nil;
    if cfgId and self.datas then
        for _,v in pairs(self.datas) do
            if (v:GetType()==ITEM_TYPE.GIFT_BAG or v:GetType()==ITEM_TYPE.SEL_BOX) and v:GetDyVal1()~=nil then
                local hasCfg,count=self:GetPackagesRewardCfgs(v:GetDyVal1(),cfgId);
                if hasCfg then
                    list=list or {};
                    table.insert(list,{goods=v,count=count})
                end
            end
        end
    end
    return list
end

--是否是包含指定物品的奖励表数据,hasCfg=true/false count=num
function this:GetPackagesRewardCfgs(tempId,cfgId)
    local hasCfg=false;
    local count=0;
    if tempId==nil or cfgId==nil then
        return hasCfg,count;
    end
    local rewardCfg = Cfgs.RewardInfo:GetByID(tempId);
    if rewardCfg ~= nil and
        (rewardCfg.type == RewardRandomType.SINGLE_SELECT or rewardCfg.type == RewardRandomType.FIXED) then
        for _, item in ipairs(rewardCfg.item) do
            if item.id == cfgId and item.type == RandRewardType.ITEM then--不做嵌套判断
                hasCfg=true;
                count=count+item.count;
            end
        end
    end
    return hasCfg,count;
end


function this:SetOrderType(order)
    self.orderType = order
end

function this:GetOrderType()
    return self.orderType == nil and 2 or self.orderType;
end

-- type:BagScreenDataType
function this:SetScreenData(condition)
    self.conditions = condition;
end

-- 返回物品列表缓存的筛选数据 type:BagScreenDataType
function this:GetScreenData()
    if self.conditions == nil then
        self.conditions = {
            Sort = {1},
            Type = {0}
        };
    end
    return self.conditions;
end

-- 通过物品表id获取数据
function this:GetDataByCfgID(cfgId)
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetCfgID() == cfgId) then
                return v;
            end
        end
    end
    return nil
end

-- 执行筛选
function this:DoScreen(dataList, condition)
    local arr = {};
    if (dataList) then
        for _, tag in ipairs(condition.Type) do
            for _, data in pairs(dataList) do
                if (data) then
                    local cfgGoods = data:GetCfg();
                    if cfgGoods and cfgGoods.hide == nil then
                        if (tag ~= 0 and cfgGoods.tag == tag) or (tag == 0 and cfgGoods.tag ~= 0) then
                            table.insert(arr, data);
                        end
                    end
                end
            end
        end
        table.sort(arr, function(a, b)
            if a:GetQuality() == b:GetQuality() then
                return a:GetID() < b:GetID();
            else
                return a:GetQuality() > b:GetQuality()
            end
        end);
    end
    return arr;
end

-- 返回卡牌素材 isCountNum:是否减去升级所需
function this:GetCardElems(isCountNum)
    local list = self:GetDataByType(ITEM_TYPE.CARD_CORE_ELEM);
    if list and isCountNum then
        local l = {};
        for k, v in ipairs(list) do
            local info = self:GetCardCore(v:GetID(), isCountNum)
            if info and v:GetCfg().dy_arr and info:GetCount() > 0 then -- v:GetCfg().dy_arr用于判断是通用星源还是角色星源
                table.insert(l, info);
            end
        end
        return l;
    else
        return list;
    end
end

function this:GetCardCore(goodsId, isCountNum)
    if goodsId == nil then
        return nil;
    end
    local v = self:GetData(goodsId);
    if v == nil then
        return nil;
    elseif isCountNum then
        local cids = v:GetCfg().dy_arr;
        if cids ~= nil then
            local n = v:GetCount();
            for _, val in ipairs(cids) do
                local cards = RoleMgr:GetCardsByCfgID(val);
                if cards and #cards >= 1 then
                    for _, card in ipairs(cards) do
                        local num = GCalHelp:GetCardNeedCoreItemCnt(card:GetCfgID(), card:GetCoreLv(),
                            card:GetData().skills);
                        if num then
                            n = n - num;
                        end
                    end
                end
            end
            if n > 0 then
                return GoodsData({
                    id = v:GetCfgID(),
                    num = n
                });
            else
                return GoodsData({
                    id = v:GetCfgID(),
                    num = 0
                });
            end
        else
            return v;
        end
    else
        return v;
    end
end

function this:Clear()
    self.datas = nil;
    self.arr = nil;
    self.news = nil;
    self.selectEquipCond = nil;
    self.tabIndex = nil;
    self.conditions = nil;
    self.lessLimitTime=nil;
    self.childTabIndex=nil;
    self.dataLimitTime=nil;
    self.hasDayLimitTips=nil;
end

return this;
