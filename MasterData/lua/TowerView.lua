local datas = {}
local resetTime = -1
local openInfo = nil
local items = {}

function Awake()
    UIUtil:AddTop2("TowerView" ,topParent, OnClickReturn);

    CSAPI.SetGOActive(clickMask,false)
    CSAPI.SetGOActive(clickAction,false)
end

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()   
    end

    if TimeUtil:GetTime() > resetTime then
        return
    end

    if (resetTime >= 0) then
        local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
        local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
        local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
        local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
        local str = StringUtil:SetByColor(day .. hour .. min, "ff7781")
        LanguageMgr:SetText(txtTime, 49032, str)
    end
end

function OnOpen()
    EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="assistData_check",time=1500,
	timeOutCallBack=function ()
        Tips.ShowTips("获取协议超时!!!")
		-- LanguageMgr:ShowTips(6016)
	end});
    FriendMgr:InitAssistData(function ()
        EventMgr.Dispatch(EventType.Net_Msg_Getted,"assistData_check");
    end)
    InitDatas()
    InitTime()
    InitPanel()
end

function InitDatas()
    datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.NewTower)
end

function InitTime()
    openInfo = DungeonMgr:GetActiveOpenInfo2(datas[1]:GetID())
    resetTime = openInfo:GetEndTime()
end

function InitPanel()
    ApplyJump()
    RefreshPanel()
end

function ApplyJump()
    if data and data.id and #datas>0 then
        for i, v in ipairs(datas) do
            if v:GetID() == data.id then
                CSAPI.OpenView("TowerListView", data, i)
                break
            end
        end
    end
end

function RefreshPanel()
    for i = 1, #datas do
        SetItem(i)
    end
    CSAPI.SetGOActive(right,#datas == 2)
    CSAPI.SetGOActive(center,#datas == 2)
    CSAPI.SetAnchor(left,#datas == 2 and -960 or -604,0)
end

function SetItem(index)
    local sectionData = datas[index]
    if sectionData then
        local txtName = index == 1 and txtName1 or txtName2
        CSAPI.SetText(txtName,sectionData:GetName())
        SetLimit(index)
        local cur,max = TowerMgr:GetCount(sectionData:GetID())
        local txtCount1 = index == 1 and txtNolCount1 or txtHardCount1
        CSAPI.SetText(txtCount1,cur < 10 and "0" .. cur or cur.."")
        local txtCount2 = index == 1 and txtNolCount2 or txtHardCount2
        CSAPI.SetText(txtCount2,max < 10 and "/0" .. max or "/" .. max)
    end
end

function SetLimit(index)
    local sectionData = datas[index]
    if index == 1 then
        CSAPI.SetText(txtNolLimit,sectionData:GetDescKey())
    else
        local tasks = {}
        local strs = StringUtil:split(sectionData:GetDescKey(),"|")
        if strs and #strs > 1 then
            local task = {}
            for i, v in ipairs(strs) do
                if i % 2 == 0 then
                    task.str = v
                    table.insert(tasks,{iconName = task.iconName,str = task.str})
                else
                    task.iconName = v
                end
            end
        end
        items = items or {}
        ItemUtil.AddItems("Tower/TowerTaskItem",items,tasks,limitGrid)
    end  
end

function OnClickNol()
    OnClickLevel(1)
end

function OnClickHard()
    OnClickLevel(2)
end

function OnClickLevel(index)
    CSAPI.SetGOActive(clickAction,false)
    CSAPI.SetGOActive(clickAction,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(clickAction,false)
        CSAPI.SetScale(node,1,1,1)        
        local sectionData = datas[index] 
        if sectionData then
            if g_TowerNewUI then
                CSAPI.OpenView("TowerListView2", {id = sectionData:GetID()}, index)
            else
                CSAPI.OpenView("TowerListView", {id = sectionData:GetID()}, index)
            end
        end
    end,this,400)
    PlayAnim(400)
end

function OnClickReturn()
    view:Close()
end

function PlayAnim(time)
    CSAPI.SetGOActive(clickMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(clickMask,false)
    end,this,time)
end