local commData = nil
local curDatas = {}
local isClose = true
local isEnough = false
local fade = nil
local animTime = 3833
local isJumpAnim = false
local reward = nil
local targetTime = 0
--item
local curIndex = 1
local currItem = nil
local layout = nil

function Awake()
    fade =ComUtil.GetCom(node,"ActionFade")
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    CSAPI.SetGOActive(effObj, false)
    CSAPI.SetGOActive(clickMask, false)
end

function OnViewClosed(viewKey)
    if viewKey == "ShopView" then
        RefreshPanel()
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if isClose then
        return
    end

    RefreshTime()
end

function RefreshTime()
    if targetTime <= TimeUtil:GetBJTime() then
        LanguageMgr:SetText(txtTime,45006,"0","00:00:00")
        isClose = true
        LanguageMgr:ShowTips(24003)
        return
    end

    local time = targetTime - TimeUtil:GetBJTime()
    local d = math.floor(time / 86400)
    local str = TimeUtil:GetTimeStr(time - d * 86400)
    LanguageMgr:SetText(txtTime,45006,d,str)
end

function Refresh(_data)
    SetTime()
    SetData()
    SetIndex()
    SetItems()
    ShowPanel()
end

function SetTime()
    targetTime = PlayerMgr:GetOpenTime(ActivityListType.Investment) + (g_InvestmentTimes * 86400)
    if TimeUtil:GetBJTime() >= targetTime then
        return
    end
    isClose = false
end

function SetIndex()
    if #curDatas > 0 then
        curIndex = #curDatas
        for i, v in ipairs(curDatas) do
            if not v:IsOver() then
                curIndex = i
                break
            end
        end
    end
end

function RefreshPanel()
    SetData()
    SetItems()
    ShowPanel()
end

function ShowPanel()
    commData = GetCurrData()
    if not commData then
        return
    end

    local costCount = 0
    local getCount = 0
    if commData:GetPrice() and #commData:GetPrice()>0 then
        costCount = commData:GetPrice()[1].num
    else
        LogError("获取不到价格数据!商品id:" .. commData:GetID())
        return
    end
    CSAPI.SetText(txtCount,costCount .. "")
    isEnough = BagMgr:GetCount(ITEM_ID.DIAMOND) >= costCount
    UIUtil:SetRedPoint(btnPay,isEnough,124,38,0)

    if commData:GetCommodityList() and #commData:GetCommodityList()>0 then
        getCount = commData:GetCommodityList()[1].num
    else
        LogError("获取不到奖励数据!商品id:" .. commData:GetID())
        return
    end
    LanguageMgr:SetText(txtDesc,45010,costCount,getCount)

    if commData:IsOver() then
        ShowFinishPanel()
        return 
    end   

    ResUtil.Investment:Load(icon,"img_01")

    if commData:GetBuyLimitType() == ShopBuyLimitType.FirstRecharge then
        if commData:GetPreLimitID() then
            local _itemData = ShopMgr:GetFixedCommodity(commData:GetPreLimitID())
            if _itemData and not _itemData:IsOver() then
                LanguageMgr:SetText(txtLockDesc,22088)
                CSAPI.SetGOActive(btnPay,false)
                CSAPI.SetGOActive(txtLockNum,false)    
                return
            end
        end
        local amount = PlayerClient:GetPayAmount() / 100 
        local maxAmount = commData:GetBuyLimitVal()
        if amount < maxAmount then
            local small = PlayerClient:GetPayAmount() % 100
            if small == 0 then
                amount = math.floor(amount)
            end
            CSAPI.SetText(txtLockNum,string.format("(   %s/%s   )",StringUtil:SetByColor(amount,"ffc146"),StringUtil:SetByColor(commData:GetBuyLimitVal(),"929296")))
            LanguageMgr:SetText(txtLock,22080,StringUtil:SetByColor(commData:GetBuyLimitVal(),"ffc146"))
        end
        CSAPI.SetGOActive(txtLockNum,amount < maxAmount)
        CSAPI.SetGOActive(btnPay,amount >= maxAmount)
        CSAPI.SetText(txtLockDesc,"")
    else
        CSAPI.SetGOActive(txtLockNum,false)    
        if commData:GetPreLimitID() then
            local _itemData = ShopMgr:GetFixedCommodity(commData:GetPreLimitID())
            if _itemData and not _itemData:IsOver() then
                LanguageMgr:SetText(txtLockDesc,22088)
                CSAPI.SetGOActive(btnPay,false)
            else
                CSAPI.SetGOActive(btnPay,true)
                CSAPI.SetText(txtLockDesc,"")
            end
        else
            CSAPI.SetGOActive(btnPay,true)
            CSAPI.SetText(txtLockDesc,"")
        end
    end
end

function SetData()
    local pageData = ShopMgr:GetPageByID(1001)
    if pageData == nil then
        LogError("找不到对应商店页的商品数据！1001")
        return nil
    end
    curDatas = pageData:GetCommodityInfos2()
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Activity3/InvestmentItem",items,curDatas,itemParent,OnItemClickCB,1,curIndex)
end

function OnItemClickCB(item)
    if item.index ~= curIndex then
        if currItem then
            currItem.SetSelect(false)
            currItem =nil
        end

        curIndex = item.index
        currItem = item
        currItem.SetSelect(true)
        RefreshPanel()
    end
end

function GetCurrData()
    if curIndex then
        return curDatas[curIndex]
    end
    return nil
end

function ShowFinishPanel()
    CSAPI.SetGOActive(btnPay,false)
    CSAPI.SetGOActive(txtLockNum,false)
    LanguageMgr:SetText(txtLockDesc,22082)
    -- LanguageMgr:SetText(txtDesc, 45011)
    ResUtil.Investment:Load(icon,"img_03")
end

function OnClickPay()
    if isClose then
        LanguageMgr:ShowTips(24003)
        return
    end

    if not isEnough then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(10004)
        dialogData.okCallBack = function()
            JumpMgr:Jump(140001)
        end
        CSAPI.OpenView("Dialog", dialogData)
        return 
    end

    ShopCommFunc.HandlePayLogic(commData, 1, nil, ShowReward)
end

function ShowReward(proto)
    reward = {proto.gets}
    isJumpAnim = false
    PlayAnim(function ()
        UIUtil:OpenReward(reward)
        reward = nil
        ActivityMgr:CheckRedPointData(ActivityListType.Investment)
        SetData()
        SetIndex()
        SetItems()
        ShowPanel()
    end)
end

function PlayAnim(callBack)
    ShowState(false)
    FuncUtil:Call(function ()
        if gameObject and not isJumpAnim then
            ShowState(true)
            if callBack then
                callBack()
            end
        end
    end,nil, animTime)
end

function ShowState(isShow)
    CSAPI.SetGOActive(clickMask,not isShow)
    CSAPI.SetGOActive(icon, isShow)
    CSAPI.SetGOActive(effObj, not isShow)
    CSAPI.SetGOActive(descObj, isShow)
    CSAPI.SetGOActive(btnPay, isShow)
    CSAPI.SetGOActive(timeObj,isShow)
    CSAPI.SetGOActive(itemParent,isShow)
end

function PlayFade(isFade,cb)
	local star = isFade and 1 or 0
	local target = isFade and 0 or 1
	fade:Play(star,target,200,0,function ()
		if cb then
			cb()
		end
	end)
end

function OnClickJump()
    ShowState(true)
    isJumpAnim = true
    if reward then
        UIUtil:OpenReward(reward)
        reward = nil
        ActivityMgr:CheckRedPointData(ActivityListType.Investment)
        SetData()
        SetIndex()
        SetItems()
        ShowPanel()
    end
end

function OnClickJump2()
    JumpMgr:Jump(140001)
end


