local endTime1, endTime2 = nil, nil
local timer = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/AccuCharge/AccuChargeItemS", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function Update()
    if (timer and Time.time >= timer) then
        timer = Time.time + 1
        SetTime()
    end
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.AccuChargeS_Get, RefreshPanel)
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
        PlayerProto:TakeColletRewardByType(eCollectType.Recharge1, item.data:GetID(), GetRewardRet)
        CSAPI.SetGOActive(animFinish, false)
        CSAPI.SetGOActive(mask, false)
    end, nil, 801)
end

function GetRewardRet(id)
    local cfg = Cfgs.CfgRechargeCount2:GetByID(id)
    if (cfg and cfg.jAwardId) then
        UIUtil:OpenReward({UIUtil.ChangeRewards(cfg.jAwardId)})
    end
end

function Refresh(_data, _elseData)
    CSAPI.SetGOActive(animFinish, false)
    cfgActiveList = _elseData.cfg
    -- time
    InitTime()
    curDatas = AccuChargeMgr:GetDatas2() or {}
    RefreshPanel()
end

function InitTime()
    endTime1, endTime2 = nil, nil
    local _endTime1, _endTime2 = AccuChargeMgr:GetEndTime2()
    if (_endTime1 == nil) then
        CSAPI.SetGOActive(objTime, false)
        return
    end
    CSAPI.SetGOActive(objTime, true)
    local curTime = TimeUtil:GetTime()
    if (curTime < _endTime1) then
        endTime1 = _endTime1
        LanguageMgr:SetText(txtTime0, 22075)
    else
        LanguageMgr:SetText(txtTime0, 22076)
    end
    endTime2 = _endTime2
    timer = Time.time
    SetTime()
end

function SetTime()
    local needTime = 0
    if (endTime1) then
        if (endTime1 >= TimeUtil:GetTime()) then
            needTime = endTime1 - TimeUtil:GetTime()
        else
            endTime1 = nil
            LanguageMgr:SetText(txtTime0, 22075)
            layout:UpdateList()
        end
    elseif (endTime2) then

        if (endTime2 >= TimeUtil:GetTime()) then
            needTime = endTime2 - TimeUtil:GetTime()
        else
            endTime2 = nil
        end
    end
    needTime = needTime <= 0 and 0 or needTime
    local tab = TimeUtil:GetTimeTab(needTime)
    LanguageMgr:SetText(txtTime, 22078, math.floor(tab[1]), math.floor(tab[2]), math.floor(tab[3]), math.floor(tab[4]))
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
