local timer = 0
local targetTime = 0
local curDatas = nil
local layout = nil
local info = nil
local isBuy = true
local commData = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RegressionActivity4/RegressionFundItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New();
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if gameObject.activeSelf == false then
            return
        end
        if not _data then
            RefreshPanel()
            return
        end

        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end);
    eventMgr:AddListener(EventType.Regression_Fund_Buy, RefreshPanel)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickCB)
        lua.SetShopClickCB(OnShopCallBuy)
        lua.Refresh(_data, {
            isBuy = isBuy
        })
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    if targetTime > 0 and Time.time > timer then
        timer = Time.time + 1
        local tab = TimeUtil:GetDiffHMS(targetTime, TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime, 22031, tab.day, tab.hour, tab.minute, tab.second)
    end
end

function Refresh(_info)
    info = _info
    if info then
        targetTime = RegressionMgr:GetActivityEndTime(info.type)
        RefreshPanel()
    end
end

-- 刷新下方数据
function RefreshPanel()
    SetDatas()
    SetShop()
    SetSort()

    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end

function SetDatas()
    local datas = MissionMgr:GetActivityDatas(eTaskType.Regression, info.activityId) or {}
    curDatas = {}
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if v:GetFundId() ~= nil then
                table.insert(curDatas, v)
            end
        end
    end
end

function SetSort()
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            local fund1 = MissionMgr:GetData2(a:GetFundId())
            local fund2 = MissionMgr:GetData2(b:GetFundId())
            if isBuy then
                if (fund1:GetSortIndex() == fund2:GetSortIndex()) then
                    return fund1:GetCfgID() < fund2:GetCfgID()
                else
                    return fund1:GetSortIndex() > fund2:GetSortIndex()
                end
            else
                if (a:GetSortIndex() == b:GetSortIndex()) then
                    return a:GetCfgID() < b:GetCfgID()
                else
                    return a:GetSortIndex() > b:GetSortIndex()
                end
            end
        end)
    end
end

function SetShop()
    local shopId = (info.infos and info.infos[1]) and info.infos[1].shopId or 0
    isBuy = RegressionMgr:IsBuyFund()
    CSAPI.SetGOActive(btnShop, not isBuy)
    CSAPI.SetGOActive(txtBuy, isBuy)

    commData = ShopMgr:GetFixedCommodity(shopId)
    if commData then
        local price = commData:GetRealPrice()
        CSAPI.SetText(txtPrice, (price and price[1]) and price[1].num .. "" or "0")

        local rewards = commData:GetCommodityList()
        local num = 300
        CSAPI.SetText(txtMoney, num .. "")

        commData:GetData().close_time = targetTime
    end
end

function OnClickShop()
    OnShopCallBuy()
end

function OnClickCB()
    local datas = MissionMgr:GetActivityDatas(eTaskType.Regression, info.activityId) or {}
    local ids = {}
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if v:IsFinish() and not v:IsGet() then
                if v:GetFundId() then
                    table.insert(ids, v:GetID())
                else
                    if isBuy then
                        table.insert(ids, v:GetID())
                    end
                end
            end
        end
    end
    TaskProto:GetReward(nil, ids)
end

function OnShopCallBuy()
    if commData then
        ShopCommFunc.OpenPayView2(commData:GetID(), true)
    end
end
