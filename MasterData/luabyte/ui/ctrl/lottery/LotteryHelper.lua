LotteryHelper = {}
local tInsert = table.insert

local function CheckLottery( lottoCfg , lottoData,times )
    -- body
    if not LotteryHelper.CheckLotteryOpen(lottoCfg,lottoData ) then 
        return false 
    end

    local needitems = LotteryHelper.CheckLotteryCost(lottoCfg.id,times == 1)
    if not needitems then
        return false
    end

    -- if not GameHelper.CheckOneOfItems( lottoCfg.costItem , #lottoCfg.costItem ) then
    --     GameHelper.TipsById(4132)
    --     return false 
    -- end
    return true 
end

local function CheckLotteryOpen( lottoCfg , lottoData )
    if not GameUtil.CheckInTime(lottoCfg.startTime , lottoCfg.lastTime) then
        GameHelper.TipsById(4133)
        return false 
    end
    if lottoCfg.lotteryTimes > 0 and lottoData~=nil and lottoData.TotalTimes >= lottoCfg.lotteryTimes then
        local str = ConfigHelper.GetLocalString(4133)
        GameHelper.Tips(string.format(str,lottoData.TotalTimes,lottoCfg.times))--( "次数用完("..lottoData.Total.."/" .. lottoCfg.times .. ")")
        return false 
    end
    return true 
end

--检测卡池是否在show阶段  卡池共  show前   show--Star   star--lasttime   lasttime之后 四个阶段  
--第一阶段可以完全不出现  第二阶段可以预览视频  第三阶段可以抽卡 第四阶段同第一阶段
local function CheckLotteryShow(lottoCfg)
    if not GameUtil.CheckInTime(lottoCfg.showTime , lottoCfg.startTime) then
        return false 
    end
    return true 
end


local function GetCostItem(lottoCfg,once)
    -- body
    local costId 
    local costNum 
    local isEnough = false 
    -- for i = 1, #lottoCfg.costItem / 2  do 
    --     costId = lottoCfg.costItem[i*2-1]
    --     costNum = lottoCfg.costItem[i*2]
    --     if GameHelper.CheckItem(costId,costNum) then 
    --         isEnough = true
    --         return costId,costNum,isEnough
    --     end
    -- end
    local items = LotteryHelper.CheckLotteryCost(lottoCfg.id,once)
    if items then
        isEnough = true
        costId = items[1].Id
        costNum = math.modf(items[1].Cnt)
    else
        isEnough  = false
        if once then
            costId = lottoCfg.singleItem[1]
            costNum = lottoCfg.singleItem[2]
        else
            costId = lottoCfg.tenItem[1]
            costNum = lottoCfg.tenItem[2]
        end

    end

    return costId,costNum,isEnough
end

--展示抽卡消耗，跟常规算法比 过滤掉system表内244的道具id以后的东西，并用244补全
local function GetCostItemByShow(lottoCfg,once)
    -- body
    local costId 
    local costNum 
    local isEnough = false 
    local lastshowItemId = ConfigHelper.GetSystemParam(244)
    local costItems = LotteryHelper.GetCostItems(lottoCfg.id,once) --各个道具权重表
    local calshowTable = {}
    local targetWeight
    if once then
        targetWeight = lottoCfg.cost
    else
        targetWeight = lottoCfg.cost*10
    end

    --构建一个有序的道具idlist
    local costItemKetList = {}
    if once then
        for i = 1, #lottoCfg.singleItem do
            if i % 2 ~= 0 then
                tInsert(costItemKetList,lottoCfg.singleItem[i])
            end
        end
    else
        for i = 1, #lottoCfg.tenItem do
            if i % 2 ~= 0 then
                tInsert(costItemKetList,lottoCfg.tenItem[i])
            end
        end
    end

    --筛选可以展示的道具
    local canshow = true
    local lastShowItemIdInPool = 0 --在池子里可以显示的最底层的道具
    for i = 1, #costItemKetList do
        calshowTable[costItemKetList[i]] = canshow
        if canshow then
            lastShowItemIdInPool = costItemKetList[i]
        end
        if costItemKetList[i] == lastshowItemId then
            canshow = false
        end
    end


    local items = LotteryHelper.CheckLotteryCost(lottoCfg.id,once)
    if items and #items > 0 then
        isEnough = true
        if calshowTable[items[#items].Id] then
            costId = items[#items].Id
            for i = 1, #costItems do
                if costItems[i].id == costId then
                    costNum = math.ceil(targetWeight / costItems[i].weight)
                end
            end
            --costNum = math.ceil(targetWeight / costItems[costId])
        else
            costId = lastShowItemIdInPool
            for i = 1, #costItems do
                if costItems[i].id == lastshowItemId then
                    costNum = math.ceil(targetWeight / costItems[i].weight)
                end
            end
        end

    else
        isEnough  = false
        costId = lastShowItemIdInPool --改为向下显示
        for i = 1, #costItems do
            if costItems[i].id == lastShowItemIdInPool then
                costNum = math.ceil(targetWeight / costItems[i].weight)
            end
        end
    end

    return costId,costNum,isEnough
end

--检测是否含有system表内配置的特殊道具
local function CheckSpecialCost(lottoid,once,checkItemIds)
        local lottoCfg = ConfigHelper.GetCfg("luckDraw",lottoid)
        local lastshowItemId = ConfigHelper.GetSystemParam(244)
        local calshowTable = {}
    
        --构建一个有序的道具idlist
        local costItemKetList = {}
        if once then
            for i = 1, #lottoCfg.singleItem do
                if i % 2 ~= 0 then
                    tInsert(costItemKetList,lottoCfg.singleItem[i])
                end
            end
        else
            for i = 1, #lottoCfg.tenItem do
                if i % 2 ~= 0 then
                    tInsert(costItemKetList,lottoCfg.tenItem[i])
                end
            end
        end
    
        --筛选可以展示的道具
        local canshow = true
        for i = 1, #costItemKetList do
            calshowTable[costItemKetList[i]] = canshow
            if costItemKetList[i] == lastshowItemId then
                canshow = false
            end
        end

        for i = 1, #checkItemIds do
            if not calshowTable[checkItemIds[i]] then
                return true
            end
        end
    
        return false
end

-- key = showtype , value = { cfg , ... } value.Length = 2 
local function GetLotterys( type,cardType )
    -- body
    local rtnDic = {}
    local cfgs = ConfigHelper.GetCfgsByLua("luckDraw" , {type=type,cardType=cardType} )
    for index, cfg in ipairs(cfgs) do
        -- body
        if rtnDic[cfg.showType] == nil then 
            rtnDic[cfg.showType] = {}
        end
        tInsert(rtnDic[cfg.showType],cfg)
    end    
    return rtnDic
end


--计算抽卡的消耗，luckdrawid =》 luckdraw表 ， once =》是否单抽 十连为false
local function CheckLotteryCost(luckDrawId,once)
    local ItemWeight = LotteryHelper.GetCostItems(luckDrawId,once)
    local needItems = {}
    local needTarget = 0 --总权重
    local targetWeight = 0 --目标权重
    local lottoCfg =  ConfigHelper.GetCfg("luckDraw",luckDrawId)
 
    if once then
        needTarget = lottoCfg.cost
    else 
        needTarget = lottoCfg.cost *10
    end

    local starIndex = 1 --从第几个道具开始算
    for i = 1, #ItemWeight do
        local temIndex = 0
        targetWeight = needTarget--每次筛选重置权重
        for i = 1, #ItemWeight do
        --for key, value in pairs(ItemWeight) do
            temIndex = temIndex + 1
            if temIndex >= starIndex  then -- 从第几个道具开始取
                if ItemWeight[i].weight <= targetWeight then --单道具不超过所需权重 才考虑取
                    -- body
                    local needNumber = Mathf.Floor(targetWeight / ItemWeight[i].weight)
                    local hasNumber = ItemDataMgr:GetInstance():GetItemNumById(ItemWeight[i].id)
                    if hasNumber ~= nil and hasNumber > 0 then --我是有这个道具
    
                        local useNumber = 0 --用多少个
                        if hasNumber >= needNumber then
                            useNumber = needNumber
                        else
                            useNumber = hasNumber
                        end
    
                        local item = {}
                        item.Id = ItemWeight[i].id
                        item.Cnt = useNumber
                        tInsert(needItems,item)
                        targetWeight = targetWeight - (ItemWeight[i].weight * useNumber)
                    end
                    if targetWeight == 0 then
                        return needItems
                    end
                end

            end
        --end
        end
        starIndex=starIndex+1
        needItems = {}
    end
    return needItems
end

--计算抽卡的消耗，luckdrawid =》 luckdraw表 ， once =》是否单抽 十连为false 无限钻石 当我有无限精密星斯的时候计算
local function CheckLotteryCostByInfiniteDiamond(luckDrawId,once)
    local ItemWeight = LotteryHelper.GetCostItems(luckDrawId,once)
    local needItems = {}
    local needTarget = 0 --总权重
    local targetWeight = 0 --目标权重
    local lottoCfg =  ConfigHelper.GetCfg("luckDraw",luckDrawId)
 
    if once then
        needTarget = lottoCfg.cost
    else 
        needTarget = lottoCfg.cost *10
    end

    local starIndex = 1 --从第几个道具开始算
    for i = 1, #ItemWeight do
        local temIndex = 0
        targetWeight = needTarget--每次筛选重置权重
        for i = 1, #ItemWeight do
        --for key, value in pairs(ItemWeight) do
            temIndex = temIndex + 1
            if temIndex >= starIndex  then -- 从第几个道具开始取
                if ItemWeight[i].weight <= targetWeight then --单道具不超过所需权重 才考虑取
                    -- body
                    local needNumber = Mathf.Floor(targetWeight / ItemWeight[i].weight)
                    local hasNumber = ItemDataMgr:GetInstance():GetItemNumById(ItemWeight[i].id)
                    if ItemWeight[i].id == 6 then --无限钻石
                        hasNumber = 10000000
                    end
                    if hasNumber ~= nil and hasNumber > 0 then --我是有这个道具
    
                        local useNumber = 0 --用多少个
                        if hasNumber >= needNumber then
                            useNumber = needNumber
                        else
                            useNumber = hasNumber
                        end
    
                        local item = {}
                        item.Id = ItemWeight[i].id
                        item.Cnt = useNumber
                        tInsert(needItems,item)
                        targetWeight = targetWeight - (ItemWeight[i].weight * useNumber)
                    end
                    if targetWeight == 0 then
                        return needItems
                    end
                end

            end
        --end
        end
        starIndex=starIndex+1
        needItems = {}
    end
    return needItems
end


--根据抽卡和是否单抽获得需要计算权重的道具表
local function GetCostItems(luckDrawId,once)
    local cfg = ConfigHelper.GetCfg("luckDraw",luckDrawId)
    local costList = {}
    if once then
        costList = cfg.singleItem
    else 
        costList = cfg.tenItem
    end
    local costItems = {}
    local temitemId
    local temitemWeight
    for i = 1, #costList do
        if i%2 ~= 0 then --Id
            temitemId = costList[i]
        else
            temitemWeight = costList[i]
            local view = {}
            view.id = temitemId
            view.weight =temitemWeight
            tInsert(costItems,view)
            --costItems[temitemId] = temitemWeight
        end
    end
    return costItems
end

--获得当前开启的限时卡池的视频地址 用于主界面播放视频
local function GetActivePoolView()
    local lottodatas = ConfigHelper.GetCfgsByLua("luckDraw")
    if lottodatas == nil then
        return nil
    end

    for _, value in pairs(lottodatas) do
        if value.showTime > 0 and value.startTime >0 and value.lastTime>0 then --限时卡池
            if GameUtil.CheckInTime(value.showTime , value.lastTime) then --在开放期
                if  value.mainUiVideo ~= nil and value.mainUiVideo ~= "" then
                    return value.mainUiVideo
                end
            end
        end

    end

    return nil
end


LotteryHelper.GetCostItem = GetCostItem
LotteryHelper.CheckLottery = CheckLottery
LotteryHelper.CheckLotteryOpen = CheckLotteryOpen
LotteryHelper.GetLotterys = GetLotterys
LotteryHelper.CheckLotteryCost =CheckLotteryCost
LotteryHelper.CheckLotteryCostByInfiniteDiamond =CheckLotteryCostByInfiniteDiamond
LotteryHelper.GetCostItems = GetCostItems
LotteryHelper.GetCostItemByShow = GetCostItemByShow
LotteryHelper.CheckSpecialCost = CheckSpecialCost
LotteryHelper.GetActivePoolView = GetActivePoolView
LotteryHelper.CheckLotteryShow = CheckLotteryShow



