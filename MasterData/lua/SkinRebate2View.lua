local alData = nil
local curDatas = nil
local layout = nil
local info = nil
local comm = nil
local time, timer = 0, 0
local curIndex = 0

function Awake()
    CSAPI.SetGOActive(animMask,false)
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/OperationActivity3/SkinRebate2Item", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_OldSkinRebate_Refresh, OnPanelRefresh)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data, info and info.isBuy)
    end
end

function OnItemClickCB(item)
    OnClickBuy()
end

function OnPanelRefresh()
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("SkinRebate2", topParent, OnClickBack);
end

function Update()
    if time > 0 and timer < Time.time then
        time = alData:GetEndTime() - TimeUtil:GetTime()
        if time <= 0 then
            OnClickBack()
        end
    end
end

function OnOpen()
    local id = data and data.id
    if not id then
        _, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRabate2)
    end
    alData = ActivityMgr:GetALData(id)
    info = OperationActivityMgr:GetOldSkinRebateInfo()
    if alData then
        local shopId = alData:GetInfo() and alData:GetInfo().shopId or 0
        comm = ShopMgr:GetFixedCommodity(shopId)
        SetTime()
        SetDatas()
        InitJumpState()
        CSAPI.SetGOActive(animMask,true)
        layout:IEShowList(#curDatas,OnLoadSuccess,curIndex)
        SetRight()
    end
    if RedPointMgr:GetDayRedState(RedPointDayOnceType.SkinRebate2) and RedPointMgr:GetData(RedPointType.SkinRebate2) ~= nil then
        RedPointMgr:SetDayRedToday(RedPointDayOnceType.SkinRebate2)
        OperationActivityMgr:CheckRedOldSkinRebatePointData()
    end
end

function OnLoadSuccess()
    local lua = nil
    local index = 0
    for i, v in ipairs(curDatas) do
        lua = layout:GetItemLua(i)
        if lua then
            lua.ShowEnterAnim(index * 32)
            index = index + 1
        end
    end
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
    end,this,index * 32 + 20)
end

function SetTime()
    CSAPI.SetText(txtTime, TimeUtil:GetTimeHMS(alData:GetStartTime(), "%m/%d %H:%M") .. " - " ..
        TimeUtil:GetTimeHMS(alData:GetEndTime(), "%m/%d %H:%M"))
    time = alData:GetEndTime() - TimeUtil:GetTime()
    if time <= 0 then
        OnClickBack()
    end
end

function InitJumpState()
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if not v:HasCommodity() then
                break
            end
            curIndex = i
            if v:GetState() == 0 then
                break
            end
        end
    end
end

function RefreshPanel()
    SetLeft()
    SetRight()
end

function SetLeft()
    SetDatas()
    SetItems()
end

function SetDatas()
    curDatas = OperationActivityMgr:GetOldSkinRebateArr()
end

function SetItems()
    layout:IEShowList(#curDatas)
end

function SetRight()
    SetState()
    SetImgState()
end

function SetState()
    CSAPI.SetGOActive(lockObj, not info or not info.isBuy)
    CSAPI.SetGOActive(unLockObj, info and info.isBuy)
    CSAPI.SetText(txtNum, info and info.getRebate .. "")
end

function SetImgState()
    local num = 0
    if #curDatas > 0 then
       for i, v in ipairs(curDatas) do
            if v:HasCommodity() and v:GetStage() then
                num = v:GetStage()
            end
       end
    end
    CSAPI.LoadImg(icon,"UIs/OperationActivity3/img_13_0" .. (num + 1) .. ".png",true,nil,true)
    for i = 1, 4 do
        if this["L" .. i] and not IsNil(this["L" .. i].gameObject) then
            CSAPI.SetGOActive(this["L" .. i].gameObject,i <= num)
        end
    end
end

function OnClickBuy()
    -- LogError("recharge " .. comm:GetID())
    local key = (comm:GetCfg() and comm:GetCfg().jCosts ~= nil) and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    -- ShopCommFunc.HandlePayLogic(comm, 1, nil, OnBuySuccess, key)
    ShopCommFunc.OpenPayView(comm, OnBuySuccess, false, key)
end

function OnBuySuccess()
    RefreshPanel()
end

function OnClickBack()
    view:Close()
end
