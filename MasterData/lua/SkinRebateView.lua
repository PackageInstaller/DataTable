local curDatas = nil
local isShow = false
local alData = nil
local curSkinId = 0
local timer = 0
local isRefresh = false
local getRecords = nil
local finishRecords = nil
local comm = nil
local info = nil
local size, fit1, fit2
-- 购买前
local time1 = 0
local layout = nil
local layoutTween = nil

-- 购买后
local time2 = 0
local eTime = 0
local layout2 = nil
local layoutTween2 = nil
local refreshTime = 0

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/OperationActivity1/SkinRebateItem", LayoutCallBack, true)
    layoutTween = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2, {"RTL"});

    layout2 = ComUtil.GetCom(hsv2, "UIInfinite")
    layout2:Init("UIs/OperationActivity1/SkinRebateItem", LayoutCallBack2, true)
    layoutTween2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.MoveByType2, {"RTL"});

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SkinRebate_Refresh, OnPanelRefresh)
    eventMgr:AddListener(EventType.Shop_SkinRebate_Get_Record, OnTryRefresh)
    eventMgr:AddListener(EventType.Shop_SkinRebate_Finish_Record, OnTryRefresh)

    size = CSAPI.GetMainCanvasSize()
    fit1 = CSAPI.UIFitoffsetTop() and -CSAPI.UIFitoffsetTop() or 0
    fit2 = CSAPI.UIFoffsetBottom() and -CSAPI.UIFoffsetBottom() or 0
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(OnItemClickCB)
        lua.SetScale(1)
        lua.Refresh(_data, {
            isShow = isShow,
            skinId = curSkinId
        })
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(OnItemClickCB)
        lua.SetScale(1.1)
        lua.Refresh(_data, {
            isShow = isShow,
            skinId = curSkinId
        })
    end
end

function OnItemClickCB(item)
    local _data = item.data
    if not item.isFinish then
        if _data and _data:GetNowTimeCanBuy() then -- 皮肤购买界面不打开商店
            if _data:IsOver() then -- 售罄
                LanguageMgr:ShowTips(15125);
            else
                if _data:GetType() == CommodityItemType.Skin then
                    ShopCommFunc.OpenBuyConfrim(4, nil, _data:GetID())
                elseif _data:GetType() == CommodityItemType.Package then
                    ShopCommFunc.OpenBuyConfrim(3, nil, _data:GetID())
                end
            end
        else
            LanguageMgr:ShowTips(15007);
        end
    else
        ShopProto:GetSkinRebateReward(_data:GetID(), OnRewardOpen)
    end
end

-- 展示奖励，刷新在另外的协议里 ShopProto:GetSkinRebateCanTakeRewardRet
function OnRewardOpen(proto)
    if proto and proto.jGets then
        UIUtil:OpenReward({proto.jGets})
    end
end

function OnPanelRefresh()
    info = OperationActivityMgr:GetSkinRebateInfo(curSkinId)
    eTime = info and info.time or 0
    isShow = eTime > TimeUtil:GetTime()
    OnTryRefresh()
end

function OnTryRefresh()
    if isRefresh then
        return
    end
    isRefresh = true
    FuncUtil:Call(function()
        RefreshPanel()
        isRefresh = false
    end, this, 200)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("SkinRebate", topParent, OnClickBack);
end

function Update()
    if timer < Time.time and alData then
        timer = Time.time + 1
        UpdateTime1()
        if isShow then
            UpdateTime2()
        end
    end
end

function OnOpen()
    if data == nil then
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
        if not isOpen then
            FuncUtil:Call(OnClickBack,this,50)
            -- OnClickBack()
        else
            data = id
        end
    end
    alData = ActivityMgr:GetALData(data)
    if alData then
        InitPanel()
    else
        LanguageMgr:ShowTips(38004)
    end
end

function InitPanel()
    curSkinId = alData:GetInfo() and alData:GetInfo().skinId or 0
    local shopId = alData:GetInfo() and alData:GetInfo().shopId or 0
    comm = ShopMgr:GetFixedCommodity(shopId)
    info = OperationActivityMgr:GetSkinRebateInfo(curSkinId)
    eTime = info and info.time or 0
    isShow = eTime > TimeUtil:GetTime()
    SetBGScale()
    RefreshPanel()
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    local child = bg.transform:GetChild(0)
    if child then
        CSAPI.SetScale(child.gameObject, offset, offset, offset)
    end
end

function RefreshPanel()
    CSAPI.SetGOActive(obj1, not isShow)
    CSAPI.SetGOActive(obj2, isShow)
    if not isShow then
        ShowPanel1()
    else
        ShowPanel2()
    end
end

function OnClickBack()
    view:Close()
end
---------------------------------------------购买前---------------------------------------------
function ShowPanel1()
    SetDatas1()
    SetTime1()
    SetCost()
    if curDatas and #curDatas > 0 then
        layoutTween:AnimAgain();
        layout:IEShowList(#curDatas)
    end
end

function SetDatas1()
    curDatas = ShopMgr:GetCommodityBySkinID(curSkinId)
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            return a:GetSort() < b:GetSort()
        end)
    end
end

function SetTime1()
    local str = LanguageMgr:GetByID(22051)
    local str2 = TimeUtil:GetTimeStr2(alData:GetStartTime(), true) .. "-" ..
                     TimeUtil:GetTimeStr2(alData:GetEndTime(), true)
    CSAPI.SetText(txtTime1, str .. StringUtil:SetByColor(str2, "ffc146"))
    time1 = alData:GetEndTime() - TimeUtil:GetTime()
    if time1 <= 0 then
        OnClickBack()
    end
end

function SetCost()
    local price = (comm:GetRealPrice() and comm:GetRealPrice()[1]) and comm:GetRealPrice()[1].num or 0
    if price > 0 then
        if CSAPI.IsADV() then
            price = comm:GetSDKdisplayPrice()
        end
        if CSAPI.IsSwapleftandright() then
            CSAPI.SetText(txtBuy, price..comm:GetCurrencySymbols())
        else
            CSAPI.SetText(txtBuy, comm:GetCurrencySymbols()..price)
        end

    end
end

function UpdateTime1()
    time1 = alData:GetEndTime() - TimeUtil:GetTime()
    if time1 <= 0 then
        OnClickBack()
        return
    end
end

function OnClickBuy()
    local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
end

function OnBuySuccess()
    RefreshPanel()
    EventMgr.Dispatch(EventType.Activity_SkinRebate_Refresh)
end

---------------------------------------------购买后---------------------------------------------
function ShowPanel2()
    SetDatas2()
    SetTime2()
    if curDatas and #curDatas > 0 then
        layoutTween2:AnimAgain();
        layout2:IEShowList(#curDatas)
    end
end

function SetDatas2()
    curDatas = ShopMgr:GetCommodityBySkinID(curSkinId)
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            local isLaunch1 = a:GetNowTimeCanBuy()
            local isLaunch2 = b:GetNowTimeCanBuy()
            if isLaunch1 ~= isLaunch2 then
                return isLaunch1
            else
                return a:GetSort() < b:GetSort()
            end
        end)
    end
end

function SetTime2()
    time2 = eTime - TimeUtil:GetTime()
    if time2 <= 0 then
        OnClickBack()
    end
    if #curDatas > 0 then -- 获取最小刷新时间
        for i, v in ipairs(curDatas) do
            if v:GetBuyStartTime() > TimeUtil:GetTime() and (refreshTime == 0 or refreshTime > v:GetBuyStartTime()) then
                refreshTime = v:GetBuyStartTime()
            end
            if v:GetBuyEndTime() > TimeUtil:GetTime() and (refreshTime == 0 or refreshTime > v:GetBuyEndTime()) then
                refreshTime = v:GetBuyEndTime()
            end
        end
    end
end

function UpdateTime2()
    if time2 > 0 then
        time2 = eTime - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(time2)
        CSAPI.SetText(txtTime2,
            LanguageMgr:GetByID(45012) ..
                StringUtil:SetByColor(LanguageMgr:GetByID(34039, timeTab[1], timeTab[2], timeTab[3]),
                    timeTab[1] > 2 and "ffffff" or "ff7781"))
        if time2 <= 0 then
            OnClickBack()
            return
        end
    end
    if refreshTime > 0 and refreshTime - TimeUtil:GetTime() <= 0 then
        refreshTime = 0
        OnTryRefresh()
    end
end
