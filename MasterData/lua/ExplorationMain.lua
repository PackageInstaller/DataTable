--勘探主界面
local layout=nil;
local data=nil;
local slider=nil;
local curBaseList=nil;
local curPlusList=nil;
local eventMgr=nil;
local currClickLv=1;
local currState=nil;
local lvList=nil;
local lvBtns={};
-- local dropList=nil;
local isEvent=false;
local totalLv=80;
local lastLv=-1;
local sliderTween=nil;
local fillTween=nil;
local tGrid=nil;
local dGrid=nil;
local nGrid=nil;
local currNormalReward=nil;
local currPlusReward=nil;
local progress=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
local roleItem=nil;
function Awake()
    UIUtil:AddTop2("ExplorationMain",gameObject, OnClickReturn,OnClickHome,{})
    layout=ComUtil.GetCom(hsv,"UISV");
    layout:Init("UIs/Exploration/ExplorationItem",LayoutCallBack,true)
    -- layout:AddToCenterFunc(OnSRChange);
    layout:AddOnValueChangeFunc(OnValueChange);
    slider=ComUtil.GetCom(expBar,"Slider")
    progress=ComUtil.GetCom(progressBar,"Slider")
    -- dropList=ComUtil.GetCom(dropObj,"Dropdown");
    sliderTween=ComUtil.GetCom(expBar,"ActionSliderBar")
    fillTween=ComUtil.GetCom(fillImg,"ActionFadeCurve");
    roleItem = RoleTool.AddRole(roleNode, nil, nil, false)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Exploration_Init_Data,Refresh)
    eventMgr:AddListener(EventType.Exploration_Update_Data,Refresh)
    eventMgr:AddListener(EventType.Exploration_Reveice_Ret,OnReveice)
    eventMgr:AddListener(EventType.Exploration_Upgrade_Ret,Refresh)
    eventMgr:AddListener(EventType.Exploration_Open_Ret,Refresh)
    -- eventMgr:AddListener(EventType.Exploration_Click_Lv,OnLvChange)
    eventMgr:AddListener(EventType.Exploration_Exp_TweenBegin,OnExpTweenBegin)
    eventMgr:AddListener(EventType.Exploration_Exp_TweenUp,OnExpTweenUp)
    -- CSAPI.AddDropdownCallBack(dropObj, OnDropValChange);
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnDestroy()
    -- CSAPI.RemoveDropdownCallBack(dropObj, OnDropValChange);
    eventMgr:ClearListener();
end

-- function CreateLvList()
--     lvList={{lv=1,state=data:GetCurrLv()>=1 and 1 or 0,isSelect=currClickLv==1}};
--     for i=5,totalLv,5 do
--         table.insert(lvList,{lv=i,state=data:GetCurrLv()>=i and 1 or 0,isSelect=currClickLv==i});
--     end
--     ItemUtil.AddItems("Exploration/ExplorationLvBtn",lvBtns, lvList, lvRoot, nil, 1);
-- end

function OnOpen()
    Refresh(true);
end

function OnReveice(proto)
    --刷新列表
    curBaseList=data:GetBaseRewardCfgs(data:GetMaxLv(),true);
    curPlusList=data:GetExRewardCfgs(data:GetMaxLv(),true);
    isTween=true;
    layout:UpdateList();
    SetSPReward();
    --包含特殊奖励且未开启付费档时，弹出购买界面
    local hasSP=false;
    if proto and proto.get_infos then
        local infiniteLv=0;
        if data:HasInfiniteLv() then
            infiniteLv=data:GetInfiniteLv();
        end
        local cfg=Cfgs.CfgExplorationExp:GetByID(data:GetLevelID());
        for k,v in pairs(proto.get_infos) do
            if v.rid then
                for _,val in pairs(v.gets) do
                    local idx=val;
                    if val>=infiniteLv and infiniteLv>0 then
                        idx=infiniteLv;
                    end
                    if cfg and cfg.item[idx].isSpecial then
                        hasSP=true
                        break;
                    end
                end
            end
        end
    end
    if hasSP and data:GetState()<ExplorationState.Ex then
        OnClickBuy();
    end
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Exploration);
    local isTaskRed=false;
    local hasReward=false;
    if redInfo then
        if redInfo.taskTypes then
            for k,v in ipairs(redInfo.taskTypes) do
                if v==true then
                    isTaskRed=true;
                    break;
                end
            end
        end
        if redInfo.hasReward then
            hasReward=redInfo.hasReward;
            layout:UpdateList();
        end
        if redInfo.hasInfiniteReward then
            hasReward=true;
            local fixedLv=data:GetFixedSPLv(currClickLv);
            if fixedLv==data:GetInfiniteLv() then
                SetSPReward();
            end
        end
    end
    CSAPI.SetGOActive(btn_receive,hasReward);
    CSAPI.SetGOActive(taskRedPoint,isTaskRed)
    if isTaskRed then
        UIUtil:SetRedPoint(taskRedPoint,true);
    end
end

function Refresh(disExpTween)
    data=ExplorationMgr:GetCurrData();
    if data==nil or data:GetData()==nil then
        -- LogError("未获取到大月卡信息！")
        -- LogError(data)
        Log("未获取到大月卡信息！关闭当前界面。")
        HandlerOver();
        do return end
    end
    if data:GetBackImg() and roleItem then
        local info=data:GetBackPos();
        CSAPI.SetAnchor(roleNode,info[1],info[2]);
        CSAPI.SetScale(roleImg,info[3],info[3],info[3]);
        roleItem.Refresh(data:GetBackImg(), LoadImgType.SkinFull, nil, false, true);
        -- ResUtil.MultiImg:Load(roleImg,data:GetBackImg(),function()
        --     local info=data:GetBackPos();
        --     CSAPI.SetAnchor(roleImg,info[1],info[2]);
        --     CSAPI.SetScale(roleImg,info[3],info[3],info[3]);
        -- end,true);
    end
    --计算当前最新的显示页面
    -- local pageIdx,cIdx=GetIdxs(data:GetCurrLv());
    -- currClickLv=cIdx;
    currClickLv=data:GetCurrLv()>=data:GetMaxLv() and data:GetMaxLv() or data:GetCurrLv();
    currState=data:GetState();
    -- SetDropIndex(pageIdx) 
    RefreshExp(disExpTween);
    --刷新高级测绘状态
    SetState();
    -- Log(data.cfg)
    local st= TimeUtil:GetTimeStampBySplit(data:GetStartTime())
    local et=TimeUtil:GetTimeStampBySplit(data:GetEndTime())
    endTime=et-TimeUtil:GetTime();
-- endTime=5;
    local sTime=os.date("%Y-%m-%d", st)
    local eTime=os.date("%Y-%m-%d", et)
    local txt=LanguageMgr:GetByID(34009,sTime,eTime);
    RefreshDownTime();
    CSAPI.SetText(txt_time,txt);
    --刷新列表
    curBaseList=data:GetBaseRewardCfgs(data:GetMaxLv(),true);
    curPlusList=data:GetExRewardCfgs(data:GetMaxLv(),true);
    -- CreateLvList();
    -- SetTitleImg(pageIdx)
    -- layout:IEShowList(#curBaseList,nil,pageIdx);
    local lv=currClickLv;
    for k, v in ipairs(curBaseList) do
        if v:GetState()==ExplorationRewardState.Available then
            lv=v:GetLv();
            currClickLv=v:GetLv();
            break;
        end
    end
    SetSPReward();
    layout:IEShowList(#curBaseList,function()
        SetProgressBar();
    end,lv);
    SetRedInfo();
end

function RefreshDownTime()
    -- local timeStr=TimeUtil:GetTimeShortStr2(endTime);
    local t=TimeUtil:GetTimeStampBySplit(data:GetEndTime());
    local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
    if count.day>0 or count.hour>0 or count.minute>0 or count.second>60 then
        CSAPI.SetText(txt_limit,string.format(LanguageMgr:GetByID(34039),count.day,count.hour,count.minute));
    else
        CSAPI.SetText(txt_limit,LanguageMgr:GetByID(1062,count.second));
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

--活动结束或者没有下一个活动
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(22003));
    end,nil,100);      
end

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

function SetState()
    CSAPI.SetGOActive(statelock,currState~=ExplorationState.Plus)
    if  currState==ExplorationState.Normal then --基本类型
        CSAPI.SetGOActive(plusLock,true)
        CSAPI.LoadImg(stateImg,"UIs/Exploration/img_10_2.png",true,nil,true);
        CSAPI.SetGOActive(stateEff1,true);
        CSAPI.SetText(txt_stateDesc,LanguageMgr:GetByID(34021));
    else
        CSAPI.SetGOActive(plusLock,false)
        CSAPI.LoadImg(stateImg,"UIs/Exploration/img_10_3.png",true,nil,true);
        CSAPI.SetGOActive(stateEff2,true);
        if currState==ExplorationState.Ex then
            CSAPI.SetText(txt_stateDesc,LanguageMgr:GetByID(34022));
        else
            CSAPI.SetText(txt_stateDesc,LanguageMgr:GetByID(34023));
        end
    end
end

--显示特殊等级奖励
function SetSPReward()
    --根据当前拖拽的等级范围获取下一个特殊等级奖励
    local fixedLv=data:GetFixedSPLv(currClickLv);
    currNormalReward=data:GetRewardCfg(ExplorationState.Normal,fixedLv);
    currPlusReward=data:GetRewardCfg(ExplorationState.Ex,fixedLv);
    if currNormalReward then
        local rState=nil;
        if currNormalReward:IsInfinite() then --无限档位
            rState=data:GetInfiniteRewardState(ExplorationState.Normal);
            CSAPI.SetText(txt_spTips,LanguageMgr:GetByID(22094));
            CSAPI.SetGOActive(spRedObj,data:GetInfiniteRewardNum()>0);
            if data:GetInfiniteRewardNum()>99 then
                CSAPI.SetText(txt_spRed,"99+");
            else
                CSAPI.SetText(txt_spRed,tostring(data:GetInfiniteRewardNum()));
            end
        else
            rState=currNormalReward:GetState();
            CSAPI.SetGOActive(spRedObj,false);
            CSAPI.SetText(txt_spTips,string.format(LanguageMgr:GetByID(34024),fixedLv));
        end
        local isUnLock=false;
        if rState==ExplorationRewardState.Available or rState==ExplorationRewardState.UnLock  then
            isUnLock=true;
        end
        SetFixedGrid(nGrid,currNormalReward:GetRewardData()[1],rState,currNormalReward.cfg.tag~=nil,isUnLock,normalObj,OnClickNormal,function(grid)
            nGrid=grid
        end);
        CSAPI.SetGOActive(nShadow,rState==ExplorationRewardState.Lock);
    end
    if currPlusReward then
        local pReward=currPlusReward:GetRewardData();
        local rState2=currPlusReward:GetState();
        local hasEff1=false;
        local hasEff2=false;
        if currPlusReward.cfg.tag==1 or currPlusReward.cfg.tag==2 then
            hasEff1=true;
        end
        if currPlusReward.cfg.tag==2 or currPlusReward.cfg.tag==3 then
            hasEff2=true;
        end
        local isUnLock=false;
        if data:HasInfiniteLv() and data:GetState()>=ExplorationState.Ex and data:GetCurrLv()>=data:GetMaxLv() and currPlusReward:IsInfinite() then --无限档位且解锁了高级勘探
            rState2=data:GetInfiniteRewardState(ExplorationState.Ex);
        end
        if rState2==ExplorationRewardState.Available or rState2==ExplorationRewardState.UnLock  then
            isUnLock=true;
        end
        SetFixedGrid(tGrid,pReward[1],rState2,hasEff1,isUnLock,topObj,OnClickPlus,function(grid)
            tGrid=grid
        end);
        if #pReward>1 then
            CSAPI.SetGOActive(downObj,true)
            SetFixedGrid(dGrid,pReward[2],rState2,hasEff2,isUnLock,downObj,OnClickPlus,function(grid)
                dGrid=grid
            end);
        else
            CSAPI.SetGOActive(downObj,false)
        end
        local showShadow=rState2==ExplorationRewardState.Lock;
        CSAPI.SetGOActive(spShadow,showShadow);
        CSAPI.SetGOActive(tLockObj,rState2==ExplorationRewardState.Lock);
        local showLock2=#pReward>1 and rState2==ExplorationRewardState.Lock or false;
        CSAPI.SetGOActive(dLockObj,showLock2);
    end
end

function SetFixedGrid(grid,rewardData,state,hasEff,isUnLock,parent,click,func)
    if grid==nil then --普通奖励格子
        ResUtil:CreateUIGOAsync("Exploration/ExplorationGrid",parent,function(go)
            grid=ComUtil.GetLuaTable(go)
            grid.Refresh(rewardData,state,hasEff,isUnLock);
            grid.SetClickCB(click)
            if func then
                func(grid)
            end
        end);
    else
        grid.Refresh(rewardData,state,hasEff,isUnLock);
        grid.SetClickCB(click)
        if func then
            func(grid)
        end
    end
end

function OnClickPlus(tab)
    if data and currPlusReward then
        local state=currPlusReward:GetState();
        if currPlusReward:IsInfinite() and data:GetInfiniteRewardNum()>0 then
            state=ExplorationRewardState.Available;
            OnClickAvailable(state,data:GetCfgID(),data:GetExRewardID(),data:GetCurrLv());
        elseif state==ExplorationRewardState.Available then
            OnClickAvailable(state,data:GetCfgID(),data:GetExRewardID(),currPlusReward:GetLv());
        else
            GridClickFunc.OpenNotGet(tab);
        end
    end
end

function OnClickNormal(tab)
    if data and currNormalReward then
        local state=currNormalReward:GetState();
        if currPlusReward:IsInfinite() and data:GetInfiniteRewardNum()>0 then
            state=ExplorationRewardState.Available;
            OnClickAvailable(state,data:GetCfgID(),data:GetBaseRewardID(),data:GetCurrLv());
        elseif state==ExplorationRewardState.Available then
            OnClickAvailable(state,data:GetCfgID(),data:GetBaseRewardID(),currNormalReward:GetLv());
        else
            GridClickFunc.OpenNotGet(tab);
        end
    end
end

--计算各个下标的值
-- function GetIdxs(targetLv)
--     local pIdx,cIdx=0,1;
--     if targetLv>1 then
--         if targetLv%5==0 then
--             pIdx=targetLv==1 and 0 or targetLv/5-1;
--             cIdx=targetLv;
--         else
--             pIdx=math.floor(targetLv/5);
--             cIdx=math.floor(targetLv/5+1)*5;
--         end
--     end
--     return pIdx,cIdx;
-- end

function SetLv(lv)
    local str="00";
    -- if lastLv==-1 then
        lastLv=lv;
    -- end
    if lv>0 and lv<10 then
        str="0"..tostring(lv)
    else
        str=tostring(lv)
    end
    CSAPI.SetText(txt_currLv,LanguageMgr:GetByID(1033)..str)
end

function RefreshExp(disTween)
    local percent=0;
    --刷新经验
    local expCfg=data:GetNextExp();
    if data:IsMaxLv() and data:HasInfiniteLv()~=true then
        CSAPI.SetText(txt_exp,LanguageMgr:GetByID(34004));
        CSAPI.SetText(txt_upExp,LanguageMgr:GetByID(34004));
        percent=1;
    else
        if expCfg then
            CSAPI.SetText(txt_exp,tostring(data:GetCurrExp()));
            CSAPI.SetText(txt_upExp,tostring(expCfg.exp));
            percent=data:GetCurrExp()==0 and 0 or data:GetCurrExp()/expCfg.exp;
        end
    end
    -- if disTween then
    --     sliderTween.expTxt=nil;
    -- else
    --     sliderTween.expTxt=txt_exp;
    -- end
    --播放动画
    if not disTween and expCfg and lastLv~=-1 and data:GetCurrLv()>lastLv then
        PlayExpTween(1+percent,expCfg.exp);
    elseif not disTween and expCfg and data:GetCurrExp()~=0 then
        PlayExpTween(percent,expCfg.exp);
    else
        SetLv(data:GetCurrLv());
        slider.value=percent;
    end
end

--经验动画
function PlayExpTween(percent,totalExp)
    sliderTween.totalExp=totalExp;
    if percent>=1 then
        if lastLv~=-1 and data:GetCurrLv()~=lastLv then
            SetLv(lastLv);
        else
            SetLv(data:GetCurrLv());
        end
        sliderTween.targetVal=1;
        sliderTween:Play(function()
            if data:IsMaxLv() and percent>0 then
                --刷新经验值
                RefreshExp(true);
            else
                EventMgr.Dispatch(EventType.Exploration_Exp_TweenUp,{percent-1,totalExp})
            end
        end);
    else
        sliderTween.targetVal=percent;
        SetLv(data:GetCurrLv());
        sliderTween:Play(function()
             --刷新经验值
             RefreshExp(true);
        end);
    end
end

--动画播放完毕
function OnExpTweenBegin(eventData)
    if eventData then
        if eventData[3] then
            slider.value=0;            
        end
        PlayExpTween(eventData[1],eventData[2]);
    end
end

function OnExpTweenUp(eventData)
    SetLv(data:GetCurrLv());
    if eventData then
        fillTween:Play(1,0,200,100,function()
            EventMgr.Dispatch(EventType.Exploration_Exp_TweenBegin,{eventData[1],eventData[2],true})
        end);
    end
end

--领取固定奖励
function OnClickAvailable(state,cfgId,rId,lv) 
    if state==ExplorationRewardState.Available then --可领取
        ExplorationProto:GetReward(cfgId,rId,lv);
    end
end

-- function OnSRChange(index)
--     if isEvent~=true then
--         isEvent=true
--         return
--     end
--     local lv=index*5+1
--     local pageIdx,cIdx=GetIdxs(lv);
--     currClickLv=cIdx;
--     -- SetTitleImg(pageIdx)
--     -- SetDropIndex(pageIdx) 
--     CreateLvList();
-- end

-- function OnLvChange(lv)
--     if lv then
--         local pageIdx,cIdx=GetIdxs(lv);
--         currClickLv=cIdx;
--         SetDropIndex(pageIdx) 
--         isEvent=false;
--         layout:MoveToIndex(pageIdx);
--         SetTitleImg(pageIdx)
--         CreateLvList();
--     end
-- end

-- function SetDropIndex(dropIdx) 
--     CSAPI.RemoveDropdownCallBack(dropObj, OnDropValChange);
--     dropList.value=dropIdx;
--     CSAPI.AddDropdownCallBack(dropObj, OnDropValChange);
-- end

-- function SetTitleImg(pageIdx)
--     if pageIdx==1 then
--         CSAPI.SetAnchor(svTitleBg,85,-4);
--     elseif pageIdx==totalLv then
--         CSAPI.SetAnchor(svTitleBg,-120,-4);
--     else
--         CSAPI.SetAnchor(svTitleBg,0,-4);
--     end
-- end

-- function OnDropValChange(index)
--     local targetLv=index*5+1;
--     local pageIdx,cIdx=GetIdxs(targetLv);
--     currClickLv=cIdx;
--     isEvent=false;
--     layout:MoveToIndex(pageIdx);
--     SetTitleImg(pageIdx)
--     CreateLvList();
-- end

function LayoutCallBack(index)   
    local item=layout:GetItemLua(index);
    local d={base=curBaseList[index],plus=curPlusList[index]};
    item.Refresh(d);
end

function OnValueChange()    
    local indexs=layout:GetIndexs();
    if indexs and indexs.Length>0 then
        local cIndex=data:HasInfiniteLv() and indexs[indexs.Length-1] or indexs[indexs.Length-2];
        if currClickLv~=cIndex then
            currClickLv=cIndex;
            SetSPReward();
        end
        SetProgressBar();
    end
end

--设置进度条长度
function SetProgressBar()
    local x=CSAPI.GetAnchor(Content)
    -- progress.value=math.abs(data:GetCurrLv()*200-math.abs(x))/1442;
    progress.value=(data:GetCurrLv()*200+x)/1442;
end

function OnClickReturn()
    view:Close();
end

function OnClickHome()
    UIUtil:ToHome()
end

--显示经验获取提示框
function OnClickExpGet()
    CSAPI.OpenView("ExplorationGUIDE")
    -- EventMgr.Dispatch(EventType.Exploration_Exp_TweenBegin,{1.5,4000})
end

--跳转购买界面
function OnClickBuy()
    if currState~=ExplorationState.Plus then
        -- CSAPI.OpenView("ExplorationBuy")
        UIUtil:OpenExplorationBuy()
    end
end

--跳转购买等级界面
function OnClickUpLv()
    if data:IsMaxLv() and data:HasInfiniteLv()~=true then
        LanguageMgr:ShowTips(22002);
    else
        CSAPI.OpenView("ExplorationStage")
    end
end

--全部领取
function OnClickReceive()
    ExplorationProto:GetReward(data:GetCfgID(),-1,nil);
end

function OnClickPlusLock()
    OnClickBuy();
end

function OnClickState()
    OnClickBuy();
end