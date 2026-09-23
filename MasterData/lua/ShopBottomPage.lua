--设置日服提示
local exChangeFunc=nil;
local refreshFunc=nil;
local timerKey=nil;
local lastTime=0;
local timeOverFunc=nil;
local os=nil;
function Awake()
    CSAPI.SetGOActive(btnExchange,false);
    CSAPI.SetGOActive(refreshObj,false);
    CSAPI.SetGOActive(ADVJP,false);
end

function OnDisable()
    if timerKey then--删除计时器
        EventMgr.Dispatch(EventType.Shop_Timer_Remove,timerKey)
    end
    timerKey=nil
    lastTime=0;
    os=nil;
    timeOverFunc=nil;
    exChangeFunc=nil;
    refreshFunc=nil;
end

function ShowADVJP(isOn)
    CSAPI.SetGOActive(ADVJP,isOn);
end

function SetTime(pageData,topTabID,func)
    if pageData==nil then
        do return end
    end
    timerKey=topTabID~=nil and pageData:GetID().."_"..topTabID or pageData:GetID();
    timeOverFunc=func;
    local lID=18011;
    lastTime=0;
    if pageData:GetCommodityType()==CommodityType.Rand then
        local exchangeCfg=Cfgs.CfgRandCommodity:GetGroup(pageData:GetID())[1];
        if exchangeCfg then
            lastTime=ShopMgr:GetExchangeRefreshTime(exchangeCfg.id);
        end
        lastTime=lastTime or 0;
    else
        local childPage=nil;
        if topTabID~=nil then
            childPage=pageData:GetChildPageData(topTabID,true);
        end
        --普通商店的倒计时
        if (pageData:GetUpdateTime()~=ShopFixedUpdateType.None) or (childPage~=nil and childPage.updateTime~=nil and childPage.updateTime~=ShopFixedUpdateType.None) then
            local updataType=pageData:GetUpdateTime()
            if childPage then
                updataType=childPage.updateTime
            end
            local lTime=ShopMgr:GetFixedUpdateTime(updataType);
            lastTime=lTime>TimeUtil:GetTime() and lTime-TimeUtil:GetTime() or 0; --计算剩余时间
        elseif childPage~=nil and childPage.nEndTime~=nil and childPage.nEndTime>0 then
            --新增固定商店二级界面存在关闭时间时显示倒计时
            local lTime=childPage.nEndTime;
            lastTime=lTime>TimeUtil:GetTime() and lTime-TimeUtil:GetTime() or 0; --计算剩余时间
            lID=18135
        end
    end
    if lastTime and lastTime>0 then
        CSAPI.SetText(txt_refreshTips2,LanguageMgr:GetByID(lID));
        SetTimeTxt(lastTime)
        CSAPI.SetGOActive(refreshObj,true)
        --注册Timer
        EventMgr.Dispatch(EventType.Shop_Timer_Add,{key=timerKey,func=SetTimeUpdate,isLoop=true})
    else
        CSAPI.SetGOActive(refreshObj,false)
    end
end

function SetTimeUpdate()
    lastTime=lastTime-1>0 and lastTime-1 or 0;
    SetTimeTxt();
end

--显示刷新时间
function SetTimeTxt()
    if lastTime==nil then
        do return end
    end
    local timeStr=""
    if lastTime>=86400 then
        local nowTime=TimeUtil:GetTime();
        local count=TimeUtil:GetDiffHMS(lastTime+nowTime,nowTime);
        timeStr=string.format(LanguageMgr:GetByID(34017),count.day,count.hour>=10 and count.hour or "0"..count.hour,count.minute>=10 and count.minute or "0"..count.minute,count.second>=10 and count.second or "0"..count.second)
    else
        timeStr=TimeUtil:GetTimeStr(lastTime);
    end
    CSAPI.SetText(txt_refreshTime,timeStr);
    if lastTime<=0 then
        if timeOverFunc~=nil then
            timeOverFunc();
        end
        EventMgr.Dispatch(EventType.Shop_Timer_Remove,timerKey)
    end
end

--显示碎片兑换
function SetRoleExchange(isOn,_os,func)
    CSAPI.SetGOActive(btnExchange,isOn);
    os=_os;
    exChangeFunc=func;
end

--显示刷新按钮
function SetRefreshBtn(isOn,func)
    CSAPI.SetGOActive(btnRefrsh,isOn);
    refreshFunc=func;
end

function OnClickRefresh()
    if refreshFunc~=nil then
        refreshFunc();
    end
end

function OnClickExchange()
    if exChangeFunc~=nil then
        exChangeFunc();
    end
end
function OnClickCoreDetails()
    CSAPI.OpenView("CoreExchangeDetails",nil,os);
end
----日服地区内嵌法律说明
function OnClickJPPayServices()
    print("ShopView_OnClickJPPayServices")
    if CSAPI.RegionalCode()==3 then
        ShiryuSDK.ShowSdkCommonUI(9);
    end
end
----日服地区内嵌法律说明
function OnClickJPBusiness()
    print("ShopView_OnClickJPBusiness")
    if CSAPI.RegionalCode()==3 then
        ShiryuSDK.ShowSdkCommonUI(10);
    end
end
function OnDestroy()
    exChangeFunc=nil;
    timeOverFunc=nil;
    refreshFunc=nil;
    btnExchange=nil;
    refreshObj=nil;
    ADVJP=nil;
    gameObject=nil;
end