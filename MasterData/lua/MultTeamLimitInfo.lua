local layout=nil;
local curDatas=nil;
local activityData=nil;
local fixedTime=1;
local curTime=0;
local timer=0;
function Awake()
    layout = ComUtil.GetCom(vsv,"UISV");
end

function OnOpen()
    --获取当前限制的卡牌数据
    activityData=MultTeamBattleMgr:GetCurData();
    SetTime();
    FuncUtil:Call(function()
        layout.enabled=true;
        layout:Init("UIs/RoleLittleCard/RoleLittleCard",LayoutCallBack,true,1);
        Refresh();
    end,nil,50);--延迟加载，等待Layout组件计算大小后再初始化uisv
end

function SetTime()
    --计算当前时间和第二天3点的差距
    local time=TimeUtil:GetTime();
    local time2=TimeUtil:GetActivyDiffDayZero(time);
    local time3=TimeUtil:GetTimeHMS(time2);
    time3.day=time3.day+1;
    local targetTime=os.time(time3)
    timer=targetTime-time;
    local time4=TimeUtil:GetDiffHMS(targetTime,time);
    CSAPI.SetText(txtLimit,LanguageMgr:GetByID(77022,time4.hour>9 and time4.hour or "0"..time4.hour,time4.minute>9 and time4.minute or "0"..time4.minute,time4.second>9 and time4.second or "0"..time4.second));
end

function Update()
    if timer>0 then
        curTime=curTime+Time.deltaTime;
        if curTime>=fixedTime then
            SetTime();
            curTime=0;
        end
    end
end

function Refresh()
    if activityData~=nil then
        curDatas=activityData:GetCardArrs() or {}
        layout:IEShowList(#curDatas);
    end
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	grid.Refresh(_data);
    grid.SetFormation();
	grid.SetClickCB(nil);
end

function OnClickCard(tab)
    FormationUtil.LookCard(tab.cardData:GetID());
end

function OnClickS()
    if view then
        view:Close();
    end
end