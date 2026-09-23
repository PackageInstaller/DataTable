local cfg = nil
local comm = nil
local currComm = nil
local info = nil
local layout1, layout2 = nil, nil
local curDatas = nil
local isBuy = false
local selIndex,selIndex2 = 0,0
local items1,items2 = nil,nil
local isShowRewards = false
local maxNum = 0
local isHideDailyTips = false
local time,timer = 0,0
local priceItem = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/Breakfast/BreakfastCardItem", LayoutCallBack1, true)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/Breakfast/BreakfastCardItem2", LayoutCallBack2, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.BreakfastCard_Update, RefreshPanel)

    CSAPI.SetGOActive(rewardsObj,false)

    UIUtil:AddQuestionItem("BreakfaseCard",gameObject,questParent,"QuestionItem3")
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    local lua = layout1:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
    end
    selIndex = item.index
    CSAPI.SetGOActive(rewardsObj, true)
    isShowRewards = true
    if selIndex == 1 or selIndex == #curDatas then
        layout1:MoveToIndex(selIndex)
    else
        layout1:MoveToCenter(item.index)
    end
    
    local pos = item.index == 1 and 285 or 87
    pos = item.index == #curDatas and -150 or pos
    ShowRewards(item, pos)
end

-- 1:上面,2:下面
function ShowRewards(lua, pos)
    CSAPI.SetAnchor(itemParent1, -219, pos)
    if lua then
        local rewards = lua.GetRewards()
        items1 = items1 or {}
        ItemUtil.AddItems("Breakfast/BreakfastCardReward", items1, rewards, itemParent1)
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB2)
        lua.Refresh(_data,{day = info.curDay})
        lua.SetSelect(index == selIndex2)
    end
end

function OnItemClickCB2(item)
    if selIndex2 == item.index then
        return
    end

    local lua = layout2:GetItemLua(selIndex2)
    if lua then
        lua.SetSelect(false)
    end
    selIndex2 = item.index
    item.SetSelect(true)
    ShowUnLock()
    SetBuyButton()
end

function OnDestroy()
    eventMgr:ClearListener()

    TipsMgr:SaveDailyTips("BreakfaseCard", isHideDailyTips)
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = info.eTime - TimeUtil:GetTime()
        if time <= 0 then
            view:Close()
        end
    end
end

function OnOpen()
    if data == nil then
        _,data = OperationActivityMgr:IsBCOpen()
    end
    if data then
        RefreshPanel()
    end
    isHideDailyTips = not TipsMgr:IsShowDailyTips("BreakfaseCard")
    SetDailyTips()
end

-- info:{id,sTime,eTime.curDay}
function RefreshPanel()
    cfg = Cfgs.CfgBreakfastCard:GetByID(data)
    if cfg then
        comm = ShopMgr:GetFixedCommodity(cfg.itemid)
        info = OperationActivityMgr:GetBCInfo(cfg.id)
        time = info and info.eTime or 0
        isBuy = comm:IsOver()
        CSAPI.SetGOActive(nol, not isBuy)
        CSAPI.SetGOActive(unLock, isBuy)
        SetLeft()
        SetRight()
    end
end

function SetLeft()
    if selIndex2 == 0 and isBuy then
        selIndex2 = info.curDay
    end
    SetDatas()
    SetItems()
end

function SetDatas()
    curDatas = {}
    local cfgReward = Cfgs.CfgBreakfastReward:GetByID(cfg.rewardgroup)
    if cfgReward and cfgReward.infos then
        maxNum = 0 --能获得最高粲晶
        local _comm = nil
        for i, v in ipairs(cfgReward.infos) do
            if isBuy or v.primereward then
                table.insert(curDatas, v)
            end
            _comm = ShopMgr:GetFixedCommodity(v.goodsId)
            if _comm then
                maxNum = maxNum + GetGoodsNumByComm(_comm,ITEM_ID.DIAMOND)
            end
        end
    end
end

function SetItems()
    if isBuy then
        layout2:IEShowList(#curDatas, nil, selIndex2)
    else
        layout1:IEShowList(#curDatas)
    end
end

function SetRight()
    SetTime()
    if isBuy and selIndex2 > 0 then
        ShowUnLock()
    elseif not isBuy then
        ShowNol()
    end
    SetBuyButton()
end

function SetTime()
    CSAPI.SetText(txtTime, string.format("%s~%s", TimeUtil:GetTimeStr2(info.sTime, true),
        TimeUtil:GetTimeStr2(info.eTime, true)))
end

function ShowNol()
    CSAPI.SetText(txtNum1,GetGoodsNumByComm(comm,ITEM_ID.DIAMOND) .. "")
    CSAPI.SetText(txtNum2,maxNum .. "")
    local ss = StringUtil:Split(cfg.openTime,' ')
    LanguageMgr:SetText(txtDesc,311004,ss[1])
end

function GetGoodsNumByComm(comm,id)
    local num = 0
    local rewardInfos = comm:GetCommodityList()
    if rewardInfos then
        for i, v in ipairs(rewardInfos) do
            if v.cid == id then
                num = num + v.num
            end
        end
    end
    return num
end

function ShowUnLock()
    local lua = layout2:GetItemLua(selIndex2)
    if lua then
        local _comm = lua.GetComm()
        if _comm then
            local isGet = (info.curDay >= selIndex2) and _comm:IsOver()
            local isLock = info.curDay < selIndex2
            local datas = _comm:GetCommodityList()
            items2 = items2 or {}
            ItemUtil.AddItems("Breakfast/BreakfastCardReward", items2, datas, itemParent2,nil,1,{isGet = isGet})
            CSAPI.SetGOActive(txtObj,not isGet)
            if not isGet then
                CSAPI.SetText(txtCount1, (info.curDay < selIndex2 and selIndex2 or _comm:GetNum()) .. "")
                CSAPI.SetText(txtCount2, GetGoodsNumByComm(_comm,ITEM_ID.DIAMOND)  .. "")
                CSAPI.SetText(txtDesc1,LanguageMgr:GetByID((info.curDay < selIndex2 and 311010 or 311007)))
                CSAPI.SetText(txtDesc2,LanguageMgr:GetByID((info.curDay < selIndex2 and 311011 or 311008)))
            end
            CSAPI.SetGOActive(txt_desc3,info.curDay <selIndex2)
        end
    end
    LanguageMgr:SetText(txt_buy,1007)

    local isRed = RedPointMgr:GetData(RedPointType.BreakfastCard) ~= nil
    if isRed then
        FileUtil.SaveToFile("operateActiveTimeInfos",{time = TimeUtil:GetTime()})
        RedPointMgr:UpdateData(RedPointType.BreakfastCard,nil)
    end
end

function SetBuyButton()
    if isBuy and selIndex2 > 0 then
        local lua = layout2:GetItemLua(selIndex2)
        if lua then
            currComm =lua.GetComm()
        end
    elseif not isBuy then
        currComm = comm
    end
    if currComm then
        ShopCommFunc.InitPriceItem(currComm,priceNode,priceItem,"ShopComm/ShopPriceItem7",{m1Color = "0F0F19"})
    end
    CSAPI.SetGOActive(btnBuy,(not isBuy or (isBuy and info.curDay == selIndex2 and(currComm and not currComm:IsOver()))))
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isHideDailyTips)
	CSAPI.SetGOActive(hideImg2, isHideDailyTips)
end

function OnClickBuy()
    local key = (currComm:GetCfg() and currComm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    ShopCommFunc.HandlePayLogic(currComm, 1, nil, OnBuySuccess, key)
end

function OnBuySuccess()
    OperationActivityMgr:CheckRedBCPointData()
    -- RefreshPanel()
end

function OnClickHide()
	isHideDailyTips = not isHideDailyTips
	SetDailyTips()
end

function OnClickClose()
    if isShowRewards then
        isShowRewards = false
        CSAPI.SetGOActive(rewardsObj, false)
        local lua = layout1:GetItemLua(selIndex)
        if lua then
            lua.SetSelect(false)
            selIndex = 0
        end
        return
    end
    view:Close()
end

