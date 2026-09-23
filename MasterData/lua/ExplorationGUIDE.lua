--说明
local tips={34001,34002};
local items = {}
local selectID=1;
local layout=nil;
local curDatas=nil;
local types={eTaskType.DayExplore,eTaskType.WeekExplore,eTaskType.Explore}
local eventMgr=nil;
local endTimes={0,0,0};
local fixedTime=1;
local upTime=0;
local isFirst=true;
function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Exploration/ExplorationMissionItem",LayoutCallBack,true);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_ReSet, Refresh)
    eventMgr:AddListener(EventType.Mission_List,OnMissionListRefresh)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Exploration_TaskTime_Ret, OnTaskTimeRet)
    eventMgr:AddListener(EventType.RedPoint_Refresh,Refresh)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnViewOpened()
    if (viewKey == "RewardPanel") then
       Refresh();
    end
end

function OnMissionListRefresh(eventData)
    if eventData and eventData[1]==types[selectID]  then
        UIUtil:OpenReward({eventData[2]},{isNoShrink=true});
    end
    Refresh()
end

function OnOpen()
    ExplorationProto:GetTaskResetTime() --获取重置时间
    Refresh();    
end

function Refresh()
    if selectID==1 then
        CSAPI.SetGOActive(txt_taskTime,false)
    else
        CSAPI.SetGOActive(txt_taskTime,true)
    end
    local redInfo=RedPointMgr:GetData(RedPointType.Exploration);
	ItemUtil.AddItems("Exploration/ExplorationGUIDEItem", items,{{id=1,str=LanguageMgr:GetByID(34018),isOn=selectID==1,redInfo=redInfo},{id=2,str=LanguageMgr:GetByID(34019),isOn=selectID==2,redInfo=redInfo},{id=3,str=LanguageMgr:GetByID(34020),isOn=selectID==3,redInfo=redInfo}}, tabs,OnClickTab)
    --显示任务列表
    curDatas=MissionMgr:GetExplorationTasks(types[selectID]);
    if curDatas==nil or #curDatas==0 then
        Log("未获取到任务列表数据！！")
        CSAPI.SetGOActive(noneObj,true);
        -- do return end;
    else
        CSAPI.SetGOActive(noneObj,false);
    end
    layout:IEShowList(#curDatas);
end

function OnTaskTimeRet(proto)
    if proto then
        endTimes={};
        table.insert(endTimes,proto.d_time);
        table.insert(endTimes,proto.w_time);
        table.insert(endTimes,proto.m_time);
    end
    SetTime();
end


function SetTime()
    local time=endTimes[selectID]
    local count=TimeUtil:GetDiffHMS(time,TimeUtil.GetTime());
    if count.day>0 then
        CSAPI.SetText(txt_taskTime,string.format(LanguageMgr:GetByID(34017),count.day,count.hour>=10 and count.hour or "0"..count.hour,count.minute>=10 and count.minute or "0"..count.minute,count.second>=10 and count.second or "0"..count.second));
    else
        CSAPI.SetText(txt_taskTime,string.format(LanguageMgr:GetByID(34038),count.hour>=10 and count.hour or "0"..count.hour,count.minute>=10 and count.minute or "0"..count.minute,count.second>=10 and count.second or "0"..count.second));
    end
end

function Update()
    upTime=upTime+Time.deltaTime;
    if upTime>=fixedTime then
        -- for k,v in ipairs(endTimes) do
        --     endTimes[k]=math.floor(endTimes[k]-upTime+0.5);
        -- end
        -- Log(endTimes[1])
        SetTime();
        upTime=0;
    end
end

function OnClickTab(tab)
    if tab.index~=selectID then
        selectID=tab.index;
        SetTime();
        Refresh();
    end
end

function LayoutCallBack(index)
    local data=curDatas[index];
    local item=layout:GetItemLua(index);
    item.Refresh(data,false)
end

function OnClickMask()
    view:Close();
end