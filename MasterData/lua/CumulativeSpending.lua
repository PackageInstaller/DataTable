--小额付费主界面
local eventMgr=nil;
local tabItems={};
local tab=nil;
local list=nil;
local curIdx=1;
local curDatas={};
local skinInfoItem=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
local isDayOn=false;
local pageItems={};
local layout=nil;
local layout2=nil;
local spRewards={};
local curPageIdx=0;

function Awake()
    eventMgr = ViewEvent.New();
    layout=ComUtil.GetCom(hpage,"UISlideshow")
    layout2=ComUtil.GetCom(hpage2,"UISlideshow")
    layout:Init("UIs/CumulativeSpending/CumulativeSPCommodity", LayoutCallBack, true)
    layout2:Init("UIs/CumulativeSpending/CumulativePage", LayoutCallBack2, true)
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    layout2:AddOnValueChangeFunc(OnValueChange)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    isDayOn =not CumulativeSpendingMgr:GetIsDailyShow();
    list=CumulativeSpendingMgr:GetOpenInfos();
    InitTab()
    -- Refresh();
end

function InitTab()
    for k, v in ipairs(list) do
        if #tabItems<k then
            ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeSpendingTab",tabs,function(go)
                if not IsNil(tab) then
                    tab:AddItem(go,k);
                    if k==1 then
                        tab.selIndex=1;
                    end
                end
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(v);
                table.insert(tabItems,lua);
            end);
        else
            tabItems[k].Refresh(v);
             if k==1 then
                tab.selIndex=1;
            end
            CSAPI.SetGOActive(tabItems[k].gameObject,true);
        end
    end
    if #tabItems>#list then
        for i=#list, #tabItems do
            CSAPI.SetGOActive(tabItems[i].gameObject,false);
        end
    end
end

function Refresh()
    --设置提醒按钮状态
    local et= list[curIdx]:GetEndTimeStamp()
    endTime=et-TimeUtil:GetTime();
    RefreshDownTime();
    RefreshPageInfo();
    SetDailyTips();
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    -- local skinInfo=ShopCommFunc.GetSkinInfo(spRewards[index]);
    lua.Refresh(spRewards[index]);
    -- local modelCfg = skinInfo:GetModelCfg();
    -- -- 判断是否已经拥有时装
    -- local rInfo = RoleSkinMgr:GetRoleSkinInfo(modelCfg.role_id, modelCfg.id)
    -- if rInfo and rInfo:CheckCanUse() then
    --     CSAPI.SetText(txtTips, LanguageMgr:GetByID(170004));
    -- else
    --     CSAPI.SetText(txtTips, LanguageMgr:GetByID(170002));
    -- end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    lua.SetIndex(index);
    lua.Refresh(curDatas[index],{totalCount=#curDatas,activityData=list[curIdx]})
end

function RefreshPageInfo()
    if list~=nil and #list<curIdx then
        LogError("长度溢出："..tostring(#list).."\t"..tostring(curIdx));
        do return end
    end
    --找到所有商品
    local comms=list[curIdx]:GetCommodityList();
    --分组
    local index=0;
    curDatas={};
    for i, v in ipairs(comms) do
        if i%8==1 then
            index=index+1;
            table.insert(curDatas,{});
        end
        if i%8==0 then
            local isBuy=(v:IsOver() and v:HasData()) and true or false;
            if isBuy then
                curPageIdx=curPageIdx+1;
            end
        end
        table.insert(curDatas[index],v);     
    end
    curPageIdx=curPageIdx>=index and index-1 or curPageIdx;
    layout2:IEShowList(#curDatas,nil,curPageIdx);
    spRewards=list[curIdx]:GetOverRewards();
    layout:IEShowList(#spRewards);
    CSAPI.SetGOActive(points,(#spRewards>1));
    CSAPI.SetGOActive(points2,(#curDatas>1));
end

--检测活动是否过期
function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            RefreshDownTime();
            upTime=0;
        end
    end
end

function RefreshDownTime()
    local t=list[curIdx]:GetEndTimeStamp();
    local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
    if count.day>=0 and (count.hour>0 or count.minute>0 or count.second>=0) then
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(170001),count.day or 0,count.hour>9 and count.hour or "0"..count.hour,count.minute>9 and count.minute or "0"..count.minute));
    -- elseif count.day==0 and (count.hour>0 or count.minute>0 or count.second>60) then
    else
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(170001),0,"00","00"));
    end
    if endTime<=0 then--回到主界面并提示
        list=CumulativeSpendingMgr:GetOpenInfos();
        if list==nil or (list and #list==0) then
            HandlerOver();
        else
            InitTab();
        end
    end
end

function OnBuyRet()
    --检查一次红点
    CumulativeSpendingMgr:CheckRedInfo();
    RefreshPageInfo();
end

function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end

function OnClickClose()
    CumulativeSpendingMgr:SetIsDailyShow(isDayOn);
    if not IsNil(view) then
        view:Close();
    end
end

function OnTabChanged(_index)
    curIdx=_index;
    curPageIdx=0;
    spRewards={};
    Refresh();
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isDayOn)
	CSAPI.SetGOActive(hideImg2, isDayOn)
end

function OnClickHide()
	isDayOn = not isDayOn
	SetDailyTips()
end

function OnClickArrow(index)
    curPageIdx=index;
    layout2:MoveToCenter(index)
end

function OnClickArrow1()
    if (curPageIdx >= 1) then
        OnClickArrow(curPageIdx-1)
    end
end

function OnClickArrow2()
    if (curPageIdx < #curDatas) then
        OnClickArrow(curPageIdx+1)
    end
end

function OnValueChange()
    curPageIdx = layout2:GetCurIndex()
end