function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/AccuCharge/AccuChargeItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.AccuCharge_Get, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDisable()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, ItemClickCB)
    end
end

function ItemClickCB(item)
    -- anim 
    CSAPI.SetGOActive(mask, true)
    local pos = AdaptiveScreen.transform:InverseTransformPoint(item.btnFinish.transform.position)
    CSAPI.SetAnchor(animFinish, pos.x, pos.y, 0)
    CSAPI.SetGOActive(animFinish, false)
    CSAPI.SetGOActive(animFinish, true)
    FuncUtil:Call(function()
        PlayerProto:TakeColletReward(item.data:GetID(), GetRewardRet)
        CSAPI.SetGOActive(animFinish, false)
        CSAPI.SetGOActive(mask, false)
    end, nil, 801)
end

function GetRewardRet(id)
    local cfg = Cfgs.CfgRechargeCount:GetByID(id)
    if (cfg and cfg.jAwardId) then
        UIUtil:OpenReward({UIUtil.ChangeRewards(cfg.jAwardId)})
    end
end

function Refresh(_data, _elseData)
    CSAPI.SetGOActive(animFinish, false)
    cfgActiveList = _elseData.cfg
    -- time
    SetTime()
    curDatas = AccuChargeMgr:GetDatas() or {}
    RefreshPanel()
end

function SetTime()
    local startTime = cfgActiveList.sTime and TimeUtil:GetTimeStampBySplit(cfgActiveList.sTime) or nil
    local endTime = cfgActiveList.eTime and TimeUtil:GetTimeStampBySplit(cfgActiveList.eTime) or nil
    local str1, str2, str3, str4 = "00", "00", "00", "00"
    local str21, str22, str23, str24 = "00", "00", "00", "00"
    if (startTime) then
        local data1 = TimeUtil:GetTimeHMS(startTime)
        str1 = data1.month
        str2 = data1.day
        str3 = data1.hour<10 and "0"..data1.hour or data1.hour
        str4 = data1.min<10 and "0"..data1.min or data1.min 
    end
    if (endTime) then
        local data1 = TimeUtil:GetTimeHMS(endTime)
        str21 = data1.month
        str22 = data1.day
        str23 = data1.hour<10 and "0"..data1.hour or data1.hour
        str24 = data1.min<10 and "0"..data1.min or data1.min
    end
    CSAPI.SetText(txtTime, string.format("%s/%s %s:%s--%s/%s %s:%s", str1, str2, str3, str4,str21, str22, str23, str24))
end

function RefreshPanel()
    SortDatas()
    CSAPI.SetGOActive(mask, true)
    tlua:AnimAgain()
    layout:IEShowList(#curDatas, AnimEnd)
end

function SortDatas()
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:GetSortType() == b:GetSortType()) then
                return a:GetCfg().id < b:GetCfg().id
            else
                return a:GetSortType() > b:GetSortType()
            end
        end)
    end
end

----------------------------------额外动画的实现-------------------------------------------
function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel") then
        layout:IEShowList(0)
    end
end

function OnViewClosed(viewKey)
    if (viewKey == "RewardPanel") then
        SortDatas()
        CSAPI.SetGOActive(mask, true)
        tlua:AnimAgain()
        layout:IEShowList(#curDatas, AnimEnd)
    end
end

-- 动画完成解除锁屏
function AnimEnd()
    CSAPI.SetGOActive(mask, false)
end
