local leftInfos = nil
local top = nil
local panels = {}
local currPanel = nil
local redInfos = nil
local regresTime,regresEndTime,regresTimer = 0,0,0
curIndex1, curIndex2 = 1, 1;

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Update_Everyday, OnOpen)
    eventMgr:AddListener(EventType.HuiGui_Check, OnOpen)
end

function OnDestroy()
    eventMgr:ClearListener()
    RegressionMgr:CheckRedPointData()
end

function OnInit()
    top = UIUtil:AddTop2("RegressionList", topParent, OnClickBack, nil, {})
    CSAPI.SetGOActive(top.btn_home, false)
end

function Update()
    if regresTime > 0 and Time.time > regresTimer then
        regresTimer = Time.time + 1
        regresTime = regresEndTime - TimeUtil:GetTime()
        if regresTime <= 0 then
            OnOpen()
        end
    end
end

function OnOpen()
    leftInfos = RegressionMgr:GetArr()
    redInfos = FileUtil.LoadByPath("Regression_RedInfo.txt") or {}
    SetTime()
    SetLeft()
    CheckJumpState()
    RefreshPanel()
end

function SetTime()
    regresEndTime = 0
    if #leftInfos > 0 then
        for i, v in ipairs(leftInfos) do
            local eTime = RegressionMgr:GetActivityEndTime(v.type)
            if eTime - TimeUtil:GetTime() > 0 then
                if regresEndTime <= 0 then
                    regresEndTime = eTime
                elseif regresEndTime > eTime then
                    regresEndTime = eTime
                end
            end
        end
    end
    regresTime = regresEndTime > 0 and regresEndTime - TimeUtil:GetTime() or 0
    regresTimer = 0
    if regresTime <= 0 then
        UIUtil:ToHome()
        return
    end
end

function SetLeft()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {}
    if #leftInfos > 0 then
        for i, v in ipairs(leftInfos) do
            table.insert(leftDatas, {v.leftInfo[1].id, v.leftInfo[1].path})
        end
    end
    leftPanel.Init(this, leftDatas)
end

function CheckJumpState()
    if data and data.id then
        if #leftInfos > 0 then
            for i, v in ipairs(leftInfos) do
                if v.index == data.id then
                    curIndex1 = i
                    break
                end
            end
        end
    end
end

function RefreshPanel()
    leftPanel.Anim()
    if currPanel then
        UIUtil:SetObjFade(currPanel.gameObject,1,0,function ()
            CSAPI.SetGOActive(currPanel.gameObject,false)
            SetRight()
        end,200)
    else
        SetRight()
    end
    SetRed()
end

function SetRight()
    if leftInfos[curIndex1] then
        local ids = leftInfos[curIndex1].moneyId or {}
        top.SetMoney(ids)
        local type = leftInfos[curIndex1].type
        if not type then
            return 
         end
        local info, elseInfo = GetInfo(type)
        if panels[tostring(type)] then
            currPanel = panels[tostring(type)]
            CSAPI.SetGOActive(currPanel.gameObject,true)
            panels[tostring(type)].Refresh(info, elseInfo)
            UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
        else
            local viewPath = GetPathName(type)
            if viewPath ~= "" then
                ResUtil:CreateUIGOAsync(viewPath, rightParent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(info, elseInfo)
                    currPanel = lua
                    UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
                    panels[tostring(type)] = lua
                end)
            end
        end
        redInfos[tostring(type)] = 1
    end
    FileUtil.SaveToFile("Regression_RedInfo.txt",redInfos)
end

function GetPathName(_type)
    local str = ""
    if _type == RegressionActiveType.DropAdd then -- 多倍掉落
        str = "Activity5/DropAddView2"
    elseif _type == RegressionActiveType.Sign then -- 签到
        str = "RegressionActivity1/RegressionSignView"
    elseif _type == RegressionActiveType.ConsumeReduce then -- 消耗减少
        str = "RegressionActivity2/HotExpendView"
    elseif _type == RegressionActiveType.ItemPool then -- 道具池
        str = "ItemPool/ItemPoolActivity"
    elseif _type == RegressionActiveType.Tasks then -- 回归任务
        str = "RegressionActivity3/RegressionMission"
    elseif _type == RegressionActiveType.Fund then -- 回归基金
        str = "RegressionActivity4/RegressionFundView"
    elseif _type == RegressionActiveType.Shop then -- 回归商店
        str = "RegressionActivity5/RegressionShop"
    elseif _type == RegressionActiveType.Show then -- 玩法一览
        str = "AllGameplay/AllGameplay"
    elseif _type == RegressionActiveType.Resupply  then -- 玩法一览
        str = "RegressionActivity6/RegressionSupplyView"
    elseif _type == RegressionActiveType.AcitveRewards then
        str = "RegressionActivity7/RegressionRebateView"
    end
    return str
end

function GetInfo(_type)
    local info, elseInfo = leftInfos[curIndex1], nil
    if _type == RegressionActiveType.ItemPool then
        info, elseInfo = leftInfos[curIndex1].activityId,
            RegressionMgr:GetActivityEndTime(leftInfos[curIndex1].type)
    elseif _type == RegressionActiveType.ConsumeReduce then
        info, elseInfo = leftInfos[curIndex1].activityId,
            RegressionMgr:GetActivityEndTime(leftInfos[curIndex1].type)
    elseif _type == RegressionActiveType.Resupply  then
        info, elseInfo = leftInfos[curIndex1].activityId,
            RegressionMgr:GetActivityEndTime(leftInfos[curIndex1].type)
    elseif _type == RegressionActiveType.AcitveRewards then
        info, elseInfo = leftInfos[curIndex1].activityId,
            RegressionMgr:GetActivityEndTime(leftInfos[curIndex1].type)
    end
    return info, elseInfo
end

function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        if leftInfos[i] then
            local isRed = RegressionMgr:CheckRed(leftInfos[i].type, leftInfos[i].activityId,redInfos,leftInfos[i])
            isRed = i == curIndex1 and false or isRed
            v.SetRed(isRed)    
        end
    end
end

function OnClickBack()
    view:Close()
end
