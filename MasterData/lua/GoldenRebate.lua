local eventMgr=nil;
local items={};
local timer=nil;
local timerMgr=nil;
local curData=nil;
local data=nil;
local itemDatas={};
local curIdx=nil;
local taskDatas={};
local taskItems={};
local layout=nil;
local isDayOn=false;
local isOpening=false;
local animator=nil;

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/GoldenRebate/GoldenRebateItem",LayoutCallBack,true);
    animator = ComUtil.GetComInChildren(node, "Animator");
    timerMgr=UITimerMgr.New();
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List,OnMissionRefresh);
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnRefresh)
    eventMgr:AddListener(EventType.Update_Everyday,OnRefresh)
    CSAPI.SetSwapleftandright(mIcon,1)
end

function OnDestroy()
    eventMgr:ClearListener();
    if timerMgr then
        timerMgr:Clear();
    end
    animator=nil;
    ReleaseCSComRefs();
end

function OnOpen()
    --获取活动数据
    isDayOn =not GoldenRebateMgr:GetIsDailyShow();
    data=GoldenRebateMgr:GetData(openSetting);
    PlayEnter();
    Refresh();
end

function PlayEnter()
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.SetAnchor(node,0,-500)
    CSAPI.ApplyAction(node, "View_Open_Fade");
    UIUtil:DoLocalMove(node, {0,0,0},function()
        isOpening=false;
        if animator~=nil then
            animator:Play("Entry", -1, 0);
        end
    end)
end

function PlayOut(func)
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.ApplyAction(node, "View_Close_Fade2");
    UIUtil:DoLocalMove(node, {0,-500,0},func)
end

function OnRefresh()
    data=GoldenRebateMgr:GetData(openSetting);
    Refresh();
end

function OnMissionRefresh(eventData)
    data=GoldenRebateMgr:GetData(openSetting);
    if not eventData then
        Refresh();
        return
    end

    local rewards = eventData[2]
    Refresh()
    if (#rewards > 0 and eventData[1]==eTaskType.GoldenRebate) then
        UIUtil:OpenReward({rewards})
    end
end

function Refresh()
    SetDailyTips()
    if data==nil then
        do return end
    end
    if timer ~= nil then
        timerMgr:RemoveTimer(timer);
        timer = nil;
    end
    SetTime();
    timer = timerMgr:AddTimer(1, SetTime, true);
    local infos=data:GetInfos();
    itemDatas={};
    for k, v in ipairs(infos) do
        if curIdx==nil then
            curIdx=v.index;
        end
        local isRed=false
        if v.missionGroup and MissionMgr:CheckRed2(eTaskType.GoldenRebate, v.missionGroup) then
            isRed=true
        end
        table.insert(itemDatas,{index=v.index,level=v.level,missionGroup=v.missionGroup,shopId=v.shopId,name=v.name,id=data:GetID(),isRed=isRed})
    end
    local curData=itemDatas[curIdx];
    RefreshTabs()
    if curData then
        --生成任务子物体
        taskDatas=MissionMgr:GetActivityDatas(eTaskType.GoldenRebate,curData.missionGroup);
        layout:IEShowList(#taskDatas)
    end
    -- CSAPI.SetText(txtDesc1,LanguageMgr:GetByID(330008,data:GetPayDays()));
    CSAPI.SetText(txtDesc2,LanguageMgr:GetByID(330009,data:GetChargeMoney()));
    --初始化左边的商品信息
    local comm=ShopMgr:GetFixedCommodity(curData.shopId);
    if comm then
        ResUtil.VCommodity:Load(icon,comm:GetPackageIcon(),true);
        local realPrice=comm:GetRealPrice();
        CSAPI.SetText(txtPrice,tostring(comm:UIShowdisplayPrice(realPrice[1].num)));
        local buyNum=comm:GetBuySum();--本日购买数量
        local totalNum=comm:GetSumBuyLimit()--限制购买数量
        CSAPI.SetText(txtDesc3,LanguageMgr:GetByID(330003,buyNum,totalNum));
        CSAPI.SetGOActive(btnBuy,not comm:IsOver());
        CSAPI.SetGOActive(txtOver,comm:IsOver());
        CSAPI.SetText(mIcon,comm:GetCurrencySymbols())
    else
        CSAPI.SetGOActive(btnBuy,false);
        CSAPI.SetGOActive(txtOver,true);
    end
end

function RefreshTabs()
     ItemUtil.AddItems("GoldenRebate/GoldenRebateTab",items,itemDatas,tabNode,OnClickTab,1,{curIdx=curIdx});
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index);
    if lua then
        local _data = taskDatas[index];
        lua.Refresh(_data)
    end
end

function OnClickTab(_d)
    if _d and _d.index~=curIdx then
        curIdx=_d.index;
        Refresh()
    end
end

function SetTime()
    if data and data:GetEndTime()~=0 then
        local overTime = data:GetEndTime()
        local count = TimeUtil:GetDiffHMS(overTime, TimeUtil:GetTime());
        if count.day > 0 or count.hour > 0 or count.minute > 0 or count.minute > 0 then
            local minute = count.minute < 10 and "0" .. count.minute or count.minute;
            if count.day == 0 and count.hour == 0 and count.minute==0 then
                minute = "01"
            end
            CSAPI.SetText(txtTime, LanguageMgr:GetByID(330002, count.day, count.hour,count.minute));
        elseif overTime<=TimeUtil:GetTime() then
            HandlerOver();
        end
    end
end

function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end, nil, 100);
end

function Update()
    if timerMgr ~= nil then
        timerMgr:Update(Time.deltaTime);
    end
end

function OnClickBuy()
     local curData=itemDatas[curIdx];
     if curData then
        local comm=ShopMgr:GetFixedCommodity(curData.shopId);
        if comm then
            ShopCommFunc.OpenPayView(comm)
        end
     end
end

function OnClickClose()
    GoldenRebateMgr:SetIsDailyShow(isDayOn);
    PlayOut(function()
        view:Close()
    end);
end

function ReleaseCSComRefs()
    gameObject=nil;
    transform=nil;
    this=nil;  
    bg=nil;
    timerMgr = nil;
end

function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID("GoldenRebate")
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isDayOn)
	CSAPI.SetGOActive(hideImg2, isDayOn)
end

function OnClickHide()
	isDayOn = not isDayOn
	SetDailyTips()
end