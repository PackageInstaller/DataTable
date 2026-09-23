local time, timer = 0, 0
local openInfo = nil
local layout1,layout2=nil,nil
local curDatas1,curDatas2=nil,nil
local curProgress = 0
local slider = nil
local isFull = false

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
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

    eventMgr:AddListener(EventType.Mission_ReSet, function()
        RefreshPanel() -- 任务重置
    end)

    layout1 = ComUtil.GetCom(vsv, "UIInfinite")
    layout1:Init("UIs/MelodyDarling/MelodyDarlingMissionItem", LayoutCallBack1, true)
    layout2 = ComUtil.GetCom(hsv, "UIInfinite")
    layout2:Init("UIs/MelodyDarling/MelodyDarlingMissionItem2", LayoutCallBack2, true)

    slider = ComUtil.GetCom(sliderPrograss,"Slider")
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas1[index]
        lua.Refresh(_data,{isFull = isFull})
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas2[index]
        lua.Refresh(_data)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("MelodyDarlingMission", topObj, OnClickReturn);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = openInfo:GetEndTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 190101, timeTab[1], timeTab[2])
        if time <= 0 then
            OnClickReturn()
        end
    end
end

function OnOpen()
    if data then
        openInfo = DungeonMgr:GetActiveOpenInfo(data)
        SetTime()
        RefreshPanel()
    end
end

function SetTime()
    if openInfo then
        time = openInfo:GetEndTime() - TimeUtil:GetTime()
    end
end

function RefreshPanel()
    SetBottom()
    SetProgress()
    SetRight()
end

function SetRight()
    curDatas1 = MissionMgr:GetActivityDatas(eTaskType.SONICO)
    layout1:IEShowList(#curDatas1)
end

function SetBottom()
    curDatas2 = {}
    local cfgs = Cfgs.CfgSonicoTaskReward:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            table.insert(curDatas2,v)
        end
    end
    if #curDatas2 >0 then
        table.sort(curDatas2,function (a,b)
            return a.id < b.id
        end)
    end

    layout2:IEShowList(#curDatas2,OnFirstShow)
end

function SetProgress()
    local cur,max = MissionMgr:GetAnniversaryInfo(eTaskType.SONICO),0   
    for i, v in ipairs(curDatas2) do
        max = v.star > max and v.star or max
    end

    CSAPI.SetText(txtProgress ,cur .. "")
    local cellX,spaceX = 168,27
    local maxLen = #curDatas2 * (cellX + spaceX)
    CSAPI.SetRectSize(sliderPrograss,maxLen,8)
    slider.value = cur / max
    isFull = cur >= max
end

function OnFirstShow()
    if isFirst then
        return
    end
    isFirst = true
    CSAPI.SetParent(sliderPrograss,itemParent)
    sliderPrograss.transform:SetAsFirstSibling()
end

function OnClickReturn()
    view:Close()
end

