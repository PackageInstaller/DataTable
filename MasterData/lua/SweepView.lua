local cfgDungeon = nil
local sweepData =nil
local layout = nil
local rewardDatas = nil
local sweepImg = nil
local teamView = nil
local sectionData = nil
--time
local isShowTime = 0
local resetTime = -1

local slider = nil
local isMat = false
local isHot= false
local isHas =false --体力和材料都消耗
local matCost = nil
local maxSweepNum = 0
local currSweepNum = 0
local SweepNum = 0

local isHotEnough = false
local isMatEnough = false
-- buff
local isHasBuff = nil
-- double
local hasMulti = false
local multiNum = 0
local isMultiReward = false
local isLimitDouble = false
local limitTime = 0
local limitTimer = 0
local multiLimitNum = 0
local isUnLimit = false
--vip限时多倍
local vipEndTime = 0
local vipTime = 0
local vipTimer = 0
--net
local isStarLoading = nil
local loadingTime = 30
--taofa
local isTaoFaMat = false
local taoFaInfo = nil

function Awake()
    slider = ComUtil.GetCom(leftSlider, "Slider")

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Sweep/SweepRewardItem", LayoutCallBack, true)

    sweepImg = ComUtil.GetCom(btnSweep,"Image")

    CSAPI.SetGOActive(loadObj, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = rewardDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnEnable()
    eventMgr = ViewEvent:New()
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, OnDailyDataUpdate)
    eventMgr:AddListener(EventType.Sweep_Show_Panel, OnSweepPanelShow);
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed);
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened);
    eventMgr:AddListener(EventType.Player_HotChange, OnHotChange);
    eventMgr:AddListener(EventType.Sweep_Close_Panel, OnSweepPanelClose);
    eventMgr:AddListener(EventType.Bag_Update, OnItemChange)
    eventMgr:AddListener(EventType.Dungeon_Double_Update, OnDailyDataUpdate)


    CSAPI.AddSliderCallBack(leftSlider, SliderCB)
end

function OnDisable()
    eventMgr:ClearListener()

    CSAPI.RemoveSliderCallBack(leftSlider, SliderCB)
end

function OnDailyDataUpdate()
    InitDouble()
    OnSweepPanelShow()
end

function OnHotChange()
    if not isStarLoading then
        OnSweepPanelShow()
    end
end

function OnItemChange()
    if not isStarLoading then
        OnSweepPanelShow()
    end
end

function OnSweepPanelShow()
    sweepData = SweepMgr:GetData(cfgDungeon.id)
    RefreshSweepPanel()
end

function OnSweepPanelClose()
    view:Close()
end

function OnViewClosed(ViewKey)
    if ViewKey == "TeamView" or ViewKey == "Bag" then
        CSAPI.SetGOActive(backMask, true)
        CSAPI.SetGOActive(node, true)
    end
end

function OnViewOpened(ViewKey)
    if ViewKey == "TeamView" or ViewKey == "Bag" then
        CSAPI.SetGOActive(backMask, false)
        CSAPI.SetGOActive(node, false)
    elseif ViewKey == "ShopView" or ViewKey == "MatrixCompound" then
        view:Close()
    elseif ViewKey == "LoadDialog" then
        if isStarLoading then
            isStarLoading = false
            CSAPI.SetGOActive(loadObj, false)
        end
    end
end

function SliderCB(value)
    SweepNum = math.modf(value)
    RefreshValue(SweepNum)
    RefreshCost(SweepNum)
    RefreshMaterial(SweepNum)
    -- RefreshBtnState()
end

function Update()
    if isStarLoading then
        if loadingTime > 0 then
            loadingTime = loadingTime - Time.deltaTime
        else
            CSAPI.SetGOActive(loadObj, false)
            loadingTime = 30
            isStarLoading = false
        end
    end

    if isLimitDouble and limitTime > 0 and limitTimer <= Time.time then
        limitTimer = Time.time + 1
        limitTime = DungeonUtil.GetDropAddTime(cfgDungeon.group)
        if limitTime > 60 then
            local tab = TimeUtil:GetTimeTab(limitTime)
            LanguageMgr:SetText(txtLimitTime,15129,tab[1],tab[2],tab[3]) 
        else
            LanguageMgr:SetText(txtLimitTime,15129,0,0,1) 
        end
        if limitTime <= 0 then
            InitDouble()
            EventMgr.Dispatch(EventType.Section_Daily_Double_Update)
        end
    end

    if vipTime > 0 and vipTimer < Time.time then
        vipTimer = Time.time + 1
        vipTime = vipEndTime - TimeUtil:GetTime()
        if vipTime <= 0 then
            ShowDoublePanel()
        end
    end

    if not isShowTime and resetTime < 0 then
        return
    end

    local time = resetTime - TimeUtil:GetTime()
    if time < 0 then --过期重置
        resetTime = -1
        CSAPI.SetText(txtTime,"--:--:--")
        PlayerProto:DuplicateModUpData(cfgDungeon.id)
        return
    end

    local timeStr = TimeUtil:GetTimeStr7(time)
    CSAPI.SetText(txtTime, timeStr)
end

function OnOpen()
    if not data and data.id then
        LogError("没有传入关卡ID!!!")
        return
    end
    cfgDungeon = Cfgs.MainLine:GetByID(data.id)
    if not cfgDungeon then
        LogError("id对应的关卡表数据不存在！！！" .. data.id)
        return
    end
    sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)

    if openSetting then
        taoFaInfo = openSetting.taoFaInfo
    end

    InitPanel()
end

function InitPanel()
    sweepData = SweepMgr:GetData(cfgDungeon.id)
    SetBuffs()
    InitRewards()
    InitDouble()
    InitTeamPanel()
    InitCost()
    RefreshSweepPanel()
end

function InitTeamPanel()
    local go = ResUtil:CreateUIGO("Sweep/SweepTeamView",teamNode.transform)
    -- ResUtil:CreateUIGOAsync("Sweep/SweepTeamView", teamNode, function(go)
    local lua = ComUtil.GetLuaTable(go)
    lua.Refresh(data)
    teamView = lua
    -- end)
end

--奖励设置，概率掉落加上概率标签
function InitRewards()
    local _datas = {}
    if cfgDungeon then
        local specialRewards = RewardUtil.GetSpecialReward(cfgDungeon.group)
        if specialRewards then -- 小概率掉落
            for k, v in ipairs(specialRewards) do
                local _data = {
                    id = v[1],
                    type = GetItemType(),
                    num = BagMgr:GetCount(v[1]),
                    goodsData = GetGoodData(v[1]),
                    tag = ITEM_TAG.TimeLimit
                }
                table.insert(_datas, _data)
            end
        end
        if cfgDungeon.littleReward then -- 小概率掉落
            for k, v in ipairs(cfgDungeon.littleReward) do
                local _data = {
                    id = v,
                    type = GetItemType(v),
                    num = BagMgr:GetCount(v),
                    goodsData = GetGoodData(v),
                    tag = ITEM_TAG.LittleChance
                }
                table.insert(_datas, _data)
            end
        end
        if cfgDungeon.randomReward then -- 概率掉落
            for k, v in ipairs(cfgDungeon.randomReward) do
                local _data = {
                    id = v,
                    type = GetItemType(v),
                    num = BagMgr:GetCount(v),
                    goodsData = GetGoodData(v),
                    tag = ITEM_TAG.Chance
                }
                table.insert(_datas, _data)
            end
        end
        if cfgDungeon.fixedReward then -- 固定掉落
            for k, v in ipairs(cfgDungeon.fixedReward) do
                local _data = {
                    id = v,
                    type = GetItemType(v),
                    num = BagMgr:GetCount(v),
                    goodsData = GetGoodData(v),
                }
                table.insert(_datas, _data)
            end
        end
    end
    SetRewards(_datas)
end

function GetGoodData(_id)
    local goodsData = GoodsData();
    goodsData:Init({
        id = _id,
        num = BagMgr:GetCount(_id)
    })
    return goodsData
end

function GetItemType(_id)
    local type = RandRewardType.ITEM
    if _id then
        local cfg = Cfgs.ItemInfo:GetByID(_id)
        if cfg and cfg.type then
            if cfg.type == ITEM_TYPE.EQUIP or cfg.type == ITEM_TYPE.EQUIP_MATERIAL then
                type = RandRewardType.EQUIP
            end
        end
    end
    return type
end

function SetRewards(_rewardInfos)
    rewardDatas = _rewardInfos or {}
    layout:IEShowList(#rewardDatas)
end

-- 设置双倍
function InitDouble()
    local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
    hasMulti = DungeonUtil.HasMultiDesc(sectionData:GetID());
    CSAPI.SetText(txtLimitTime,"")
    CSAPI.SetGOActive(txt_double, hasMulti)
    if hasMulti then
        multiLimitNum,_,isUnLimit,isLimitDouble = DungeonUtil.GetDropAdd(sectionData:GetID())
        if isLimitDouble then
            local limit = isUnLimit and "∞" or multiLimitNum..""
            limitTime = DungeonUtil.GetDropAddTime(sectionData:GetID())
            LanguageMgr:SetText(txt_double, 15130, limit)
            CSAPI.SetText(txtDouble, "")
        else
            local max = 0
            multiNum,max,vipEndTime = DungeonUtil.GetMultiNum(sectionData:GetID())
            vipTime = vipEndTime and vipEndTime - TimeUtil:GetTime() or 0
            CSAPI.SetText(txtDouble, multiNum .. "/" .. max)
            LanguageMgr:SetText(txt_double,42003)
        end
    end
end

function InitCost()
    isMat = GetMatCost() ~= nil
    isHot = GetHotCost() ~= 0
    isHas = isMat and isHot
    CSAPI.SetGOActive(hasObj,isHas)
    CSAPI.SetGOActive(onlyObj,not isHas)

    local cfgMat = nil
    if isMat then
        local matReward = GetMatCost()
        matCost = {id = matReward[1], num = matReward[2], type = matReward[3]}
        cfgMat= Cfgs.ItemInfo:GetByID(matCost.id)
    end
    local cfgHot = Cfgs.ItemInfo:GetByID(ITEM_ID.Hot)

    if isHas then
        ResUtil.IconGoods:Load(hasIcon1, ITEM_ID.Hot .. "_1")
        ResUtil.IconGoods:Load(hasIcon2, matCost.id .. "_1")
        CSAPI.SetText(txt_cost, cfgHot and cfgHot.name or "")
        ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .."_3")
    elseif isHot then
        ResUtil.IconGoods:Load(onlyIcon1, ITEM_ID.Hot .."_1")
        ResUtil.IconGoods:Load(onlyIcon2, ITEM_ID.Hot .."_1")
        CSAPI.SetText(txt_cost, cfgHot and cfgHot.name or "")
        ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .."_3")
    elseif matCost then        
        ResUtil.IconGoods:Load(onlyIcon1, matCost.id .. "_1")
        ResUtil.IconGoods:Load(onlyIcon2, matCost.id .. "_1")
        CSAPI.SetText(txt_cost, cfgMat and cfgMat.name or "")
        ResUtil.IconGoods:Load(costImg, cfgMat.id .. "_3")
    end

    isTaoFaMat = cfgDungeon.type == eDuplicateType.TaoFa
end

--界面
function RefreshSweepPanel()
    SetTime()

    --count
    if cfgDungeon.modUpCnt >= 0 then
        currSweepNum = sweepData:GetCount()
        LanguageMgr:SetText(txtCount,42009,currSweepNum,cfgDungeon.modUpCnt)
    else
        currSweepNum = 1000
        LanguageMgr:SetText(txtCount,42008)
    end

    currSweepNum = currSweepNum > g_SweepOnceMaxCount and g_SweepOnceMaxCount or currSweepNum
    
    --slider
    slider.maxValue = currSweepNum
    slider.minValue = currSweepNum > 0 and 1 or 0

    SliderCB(slider.value)
end

--重置时间
function SetTime()
    isShowTime = true
    if cfgDungeon.modUpCnt < 0 or sweepData:GetCount() == cfgDungeon.modUpCnt then
        isShowTime = false
    end
    CSAPI.SetGOActive(txtTime, isShowTime)
    if isShowTime then
        resetTime = sweepData:GetResetTime()
        if TimeUtil:GetTime() > resetTime then --判断是否过期
            resetTime = -1
            CSAPI.SetText(txtTime,"--:--:--")
            PlayerProto:DuplicateModUpData(cfgDungeon.id)
        end
    end
end

--次数
function RefreshValue(num)
    if num > currSweepNum then
        num = currSweepNum
    elseif num <= 0 then
        num = 0
    end
    CSAPI.SetText(txtNum, num .. "")
end

--体力
function RefreshCost(value)
    local currHot = PlayerClient:Hot()
    local hotCost = GetHotCost() * value
    local targetHot = currHot + hotCost
    isHotEnough = targetHot >= 0
    targetHot = StringUtil:SetByColor(targetHot .. "", targetHot >= 0 and "ffffff" or "CD333E")
    local str = StringUtil:SetByColor(hotCost .. "", math.abs(hotCost) <= PlayerClient:Hot() and "191919" or "CD333E")
    if isHas then
        CSAPI.SetText(txtHot1, currHot .. "")
        CSAPI.SetText(txtHot2, targetHot .. "")
        CSAPI.SetText(cost, str .. "")
    elseif isHot then    
        CSAPI.SetText(txtHot2, currHot .. "")
        CSAPI.SetText(txtMat2, targetHot .. "")
        CSAPI.SetText(cost, str .. "")
    end
end

--单次体力消耗
function GetHotCost()
    local costNum = DungeonUtil.GetHot(cfgDungeon)
    return costNum
end

function GetMatCost()
    local cost1 = cfgDungeon.modUpCost and cfgDungeon.modUpCost[1] or nil
    local cost2 = DungeonUtil.GetCost(cfgDungeon)
    local cost = nil
    if cost1 then
        cost= {}
        cost[1] = cost1[1]
        cost[2] = (cost2~=nil and cost1[1] == cost2[1]) and cost1[2] + cost2[2] or cost1[2]
    elseif cost2 then
        cost= {cost2[1],cost2[2]}
    end
    return cost
end

--材料
function RefreshMaterial(value)
    if not isMat then
        return
    end
    local taoFaNum = taoFaInfo and taoFaInfo.count or 0
    local currMat = isTaoFaMat and taoFaNum or BagMgr:GetCount(matCost.id)
    local matCostNum = value * matCost.num
    local tagetMat = currMat - matCostNum
    isMatEnough = tagetMat >= 0
    tagetMat = StringUtil:SetByColor(tagetMat .. "", tagetMat >= 0 and "ffffff" or "CD333E")
    local str = StringUtil:SetByColor(matCostNum .. "", math.abs(matCostNum) <= currMat and "191919" or "CD333E")
    if isHas then
        CSAPI.SetText(txtMat1, currMat .. "")
        CSAPI.SetText(txtMat2, tagetMat .. "")    
    elseif isMat then
        CSAPI.SetText(txtHot2, currMat .. "")
        CSAPI.SetText(txtMat2, tagetMat .. "")
        CSAPI.SetText(cost, "-" .. str)
    end
end

--按钮状态
function RefreshBtnState()
    -- sweepImg.raycastTarget = false
    local color = {255,255,255,76}
    if isHotEnough and (not isMat or (isMat and isMatEnough)) and SweepNum > 0 then
        color = {255,255,255,255}
        -- sweepImg.raycastTarget = true
    end
    CSAPI.SetImgColor(sweepImg.gameObject,color[1],color[2],color[3],color[4])
end

function OnClickLeft()
    slider.value = slider.value - 1
end

function OnClickRight()
    slider.value = slider.value + 1
end

function OnClickSweep()
    if isStarLoading then
        return
    end
    if currSweepNum < 1 then
        LanguageMgr:ShowTips(8015)
        return
    end

    if isMat and not isMatEnough then
        if IsShowBuyView() then
            return
        end
        local goodsData = nil
        if matCost then
            goodsData = GridFakeData(matCost)
        end
        LanguageMgr:ShowTips(8014, goodsData and goodsData:GetName() or "")
        return
    end

    if not isHotEnough then
        CSAPI.OpenView("HotPanel")
        -- LanguageMgr:ShowTips(8013)
        return
    end

    if hasMulti and multiNum > 0 and not isLimitDouble then
        local dialogData = {}
        dialogData.content = string.format(LanguageMgr:GetByID(15072), cfgDungeon.name, multiNum)
        dialogData.okText = LanguageMgr:GetByID(1100)
        dialogData.cancelText = LanguageMgr:GetByID(1101)
        dialogData.okCallBack = function()
            SaveDoubleState(cfgDungeon.group, 1)
            OnStarSweep()
        end
        dialogData.cancelCallBack = function()
            SaveDoubleState(cfgDungeon.group, 0)
            OnStarSweep()
        end
        CSAPI.OpenView("Dialog", dialogData)
    else
        OnStarSweep()
    end
end

-- 保存副本双倍状态
function SaveDoubleState(_id, _type)
    if (_id > 0) then
        isMultiReward = _type == 1
        DungeonMgr:SetMultiReward(_type == 1)
        local _data = LoadDoubleState(_id) or {}
        _data.id = _id
        _data.type = _type
        FileUtil.SaveToFile("doubleState_" .. _id .. ".txt", _data)
    end
end

-- 读取副本双倍状态
function LoadDoubleState(_id)
    return FileUtil.LoadByPath("doubleState_" .. _id .. ".txt")
end

--开始扫荡
function OnStarSweep()
    local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
    if sectionData then
        local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if openInfo and not openInfo:IsDungeonOpen() then
            LanguageMgr:ShowTips(24003)
            return
        end
    end
    if teamView then
        local teamListItem = teamView.GetListItem()
        local teamData = teamListItem and teamListItem.GetTeamData() or nil
        local duplicateTeamData = teamListItem and teamListItem.GetDuplicateTeamData() or nil
        if teamData and cfgDungeon then 
            local data = {
                index = 1, -- 副本类型
                nDuplicateID = cfgDungeon.id, -- 副本id
                list = {duplicateTeamData}, -- 编队信息
                isMultiReward = isMultiReward,
                modUpCnt = SweepNum
            }
            DungeonMgr:SetFightTeamId(teamData.index)
            FightProto:ModUpFightDuplicate(data)

            isStarLoading = true
            FuncUtil:Call(function ()
                if gameObject and isStarLoading then
                    StarLoading()
                end
            end,nil,1500)
        end
    end
end

------------------------------------加成------------------------------------
function SetBuffs()
    isHasBuff = false
    local lifeBuffs = PlayerClient:GetLifeBuff()
    if lifeBuffs then
        for i, v in ipairs(lifeBuffs) do
            if v.id == 4 or v.id == 9 or v.id == 14 then
                isHasBuff = true
                break
            end
        end
    end

    -- 经验和金钱副本才会显示玩家能力加成
    local dungeonType = cfgDungeon.type
    if dungeonType == eDuplicateType.Exp or dungeonType == eDuplicateType.Gold then
        local abilityBuffs = PlayerAbilityMgr:GetFightOverBuff()
        if abilityBuffs and not isHasBuff then
            isHasBuff = #abilityBuffs > 0
        end
    end
    CSAPI.SetGOActive(btnBuff, isHasBuff)
end

function OnClickBuff()
    if isHasBuff then
        CSAPI.OpenView("FightOverBuff", {
            type = 2,
            id = cfgDungeon.id
        })
    end
end

function OnClickClose()
    if isStarLoading then
        return
    end
    view:Close()
end

function OnClick(go)
    if (isHas and go.name == "btnMat") or not isHot then
        if IsShowBuyView() then
            return
        end
        local reward = {}
        reward.id = matCost.id
        reward.type = matCost.type
        reward.num = BagMgr:GetCount(matCost.id)
        local goodsData = GridFakeData(reward)
        UIUtil:OpenGoodsInfo(goodsData)
        return            
    end
    CSAPI.OpenView("HotPanel")
end

------------------------------------加载------------------------------------

function StarLoading()
    CSAPI.SetGOActive(loadObj, true)
end
------------------------------------商店购买------------------------------------
function IsShowBuyView()
    local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
    if sectionData:GetBuyGets() then
        local buy = sectionData:GetBuyCount()
        local cost = sectionData:GetBuyCost()
        local gets = sectionData:GetBuyGets()
        local cur = DungeonMgr:GetArachnidCount(sectionData:GetID())
        local payFunc = function(count)
            PlayerProto:BuyArachnidCount(count, sectionData:GetID())
        end
        UIUtil:OpenPurchaseView(nil, nil, cur, buy, cost, gets, payFunc)
        return true
    end
    return false
end