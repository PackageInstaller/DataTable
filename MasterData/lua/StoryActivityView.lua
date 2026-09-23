local sectionData = nil
local time, timer = 0, 0
local layout1,layout2=nil,nil
local curDatas1,curDatas2=nil,nil
local curProgress = 0
local isFull = false
local alData = nil
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

    local path1,path2 = GetItemPath()
    layout1 = ComUtil.GetCom(vsv, "UIInfinite")
    layout1:Init("UIs/" .. path1, LayoutCallBack1, true)
    layout2 = ComUtil.GetCom(hsv, "UIInfinite")
    layout2:Init("UIs/" .. path2, LayoutCallBack2, true)
end

function GetItemPath()
    local path1,paht2 = "StoryActivity/StoryActivityItem","StoryActivity/StoryActivityItem2"
    return path1,paht2
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
        lua.Refresh(_data,{type = eTaskType.StoryCollectionAct})
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2(gameObject.name, topObj, OnClickReturn);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = alData:GetEndTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 190101, timeTab[1], timeTab[2], timeTab[3])
        if time <= 0 then
            OnClickReturn()
        end
    end
end

function OnOpen()
    local isOpen,id = ActivityMgr:IsOpenByType(ActivityListType.StoryActive)
    alData = ActivityMgr:GetALData(id)
    if isOpen and alData then
        sectionData = DungeonMgr:GetSectionData(alData:GetInfoContent("id"))
        SetTime()
        RefreshPanel()
        SetRed()
    end
end

function SetTime()
    if alData then
        time = alData:GetEndTime() - TimeUtil:GetTime()
    end
end

function RefreshPanel()
    SetBottom()
    SetProgress()
    SetRight()
end


function SetRight()
    curDatas1 = MissionMgr:GetActivityDatas(eTaskType.StoryCollectionAct,sectionData:GetID())
    layout1:IEShowList(#curDatas1)
end

function SetBottom()
    curDatas2 = {}
    local cfgs = Cfgs.CfgStoryCollectionActTaskReward:GetGroup(sectionData:GetID())
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
    local cellX,spaceX = 168,35
    local maxLen = #curDatas2 * (cellX + spaceX)
    CSAPI.SetRTSize(lineBg,maxLen,4)
    local cur,max = MissionMgr:GetAnniversaryInfo(eTaskType.StoryCollectionAct),curDatas2[#curDatas2].star   
    CSAPI.SetText(txtProgress ,cur .. "")
    local len,last = 0,0
    for i, v in ipairs(curDatas2) do
        if v.star <= cur then
            len = len + (cellX + spaceX)
            last = v.star
        else
            len = len + (cellX + spaceX) * ((cur - last) / (v.star - last))
            break
        end
    end
    CSAPI.SetRTSize(line,len,4)
    isFull = cur >= max
end

function OnFirstShow()
    if isFirst then
        return
    end
    isFirst = true
    CSAPI.SetParent(lineBg,itemParent)
    CSAPI.SetParent(line,itemParent)
    line.transform:SetAsFirstSibling()
    lineBg.transform:SetAsFirstSibling()
end

function SetRed()
    UIUtil:SetRedPoint(redParent,MissionMgr:CheckRed({eTaskType.StoryCollection}))
end

function OnClickJump()
    -- CSAPI.OpenView("StoryCollection")
    JumpMgr:Jump(530002)
end

function OnClickReturn()
    view:Close()
end
