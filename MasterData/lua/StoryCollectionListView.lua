local sectionData = nil
local curDatas = nil
local layout = nil
local currIndex = 0
local time,timer,refreshTime =0,0,0

function Awake()
    layout = ComUtil.GetCom(hsv,"UIInfinite")
    layout:Init("UIs/StoryCollection/StoryCollectionListItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, OnMissionListRefresh)
    eventMgr:AddListener(EventType.Dungeon_PlotPlay_Over,RefreshPanel)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    if item.IsPlot() then
        CSAPI.OpenView("StoryCollectionPlot",{id = item.GetID()})
    else
        CSAPI.OpenView("StoryCollectionDup",{id = item.GetID()})
    end
end

function OnMissionListRefresh()
    SetNum()
    SetRed()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("StoryCollectionList", topParent, OnClickBack)
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1 
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            SetTime()
            SetItems()
        end
    end
end

function OnOpen()
    if data and data.id then
        sectionData = DungeonMgr:GetSectionData(data.id)
        if sectionData then
            SetTitle()
            SetDatas()
            SetJumpState()
            RefreshPanel()
        end
    end
end

function SetTitle()
    CSAPI.SetText(txtName,sectionData:GetName())
end

function SetDatas()
    curDatas = DungeonMgr:GetDungeonGroupDatas(sectionData:GetID())
end

function SetTime()
    if #curDatas > 0 then
        local cfgDungeon = nil
        local sTime = nil
        for i, v in ipairs(curDatas) do
            cfgDungeon =v:GetFirstDungeonCfg()
            if cfgDungeon and cfgDungeon.openTime then
                sTime = TimeUtil:GetTimeStampBySplit(cfgDungeon.openTime)
                if (refreshTime == 0 or sTime < refreshTime) and TimeUtil:GetTime() < sTime  then
                    refreshTime = sTime
                end
            end
        end
        time = refreshTime - TimeUtil:GetTime()
    end
end

function SetJumpState()
    if #curDatas > 0 then
        local cfgDungeon = nil
        for i, v in ipairs(curDatas) do
            if data.itemId then
                cfgDungeon =v:GetFirstDungeonCfg()
                if cfgDungeon and cfgDungeon.id == data.itemId then
                    currIndex = i
                    if cfgDungeon.sub_type == DungeonFlagType.Story then
                        CSAPI.OpenView("StoryCollectionPlot",{id = v:GetID()})
                    else
                        CSAPI.OpenView("StoryCollectionDup",{id = v:GetID()})
                    end
                    break
                end
            elseif v:IsOpen() then
                currIndex = i
            end
        end
    end
end

function RefreshPanel()
    SetItems()
    SetNum()
    SetRed()
end

function SetItems()
    layout:IEShowList(#curDatas,nil,currIndex)
end

function SetNum()
    local cur,max = 0,#curDatas
    if #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if v:IsPass() then
                cur = cur + 1
            end
        end
    end
    CSAPI.SetText(txtNum1,cur .. "")
    CSAPI.SetText(txtNum2,"/" .. max)
end

function SetRed()
    if sectionData then
        CSAPI.SetGOActive(redParent,MissionMgr:CheckRed2(sectionData:GetTaskType(),sectionData:GetID()))
    else
        CSAPI.SetGOActive(redParent,false)
    end
end

function OnClickMission()
    if sectionData then
        CSAPI.OpenView("MissionActivity",{
            type = sectionData:GetTaskType(),
            group = sectionData:GetID()
        })
    end
end

function OnClickBack()
    view:Close()
end

