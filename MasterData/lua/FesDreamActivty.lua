local top = nil;
local eventMgr = nil;
local pool = nil;
local timerMgr = nil;
local timer = nil;
local roleItem = nil;
local comm=nil;
local items={};
local buyClicker;
local drawClicker;
local isOver=false;
local playState=0;--播放阶段
local enterTween=nil;
local drawTween=nil;
local isPlaying=false;
local rewardDic={};--剩余配置奖励
local lessQuality=5; --当前最低的奖励品质
local spCfg=nil;
local qualityKey={
    [3]="_B",
    [4]="_P",
    [5]="_H",
}
local rewardInfo=nil;--要弹出的奖励信息
local rewardQuality=nil;--弹出的奖励品质
local animator=nil;
local defaultAnimatName="prizeWheel";
local nextAnimatName="danse_01";
local stopPoint={
    {-230,-130},{-230,-400},{0,-540},{230,-400},{230,-140},{0,16}
}
local curSoundName=nil
function Awake()
    top = UIUtil:AddTop2("FesDreamActivity", topNode, OnClickClose);
    -- top = UIUtil:AddTop2("FesDreamActivty", gameObject, OnClickClose);
    roleItem = RoleTool.AddRole(roleNode, nil, nil, false)
    buyClicker=ComUtil.GetCom(btnBuy,"Image");
    drawClicker=ComUtil.GetCom(btnDraw,"Image");
    animator=ComUtil.GetComInChildren(runEff,"Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.ItemPool_Draw_Ret, OnDrawRet);
    eventMgr:AddListener(EventType.Bag_Update, OnBagUpdate);
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed);
    timerMgr = UITimerMgr.New();
    CSAPI.SetSwapleftandright(pnIcon1,1)
end

function OnDestroy()
    eventMgr:ClearListener();
    if timerMgr then
        timerMgr:Clear();
    end
    EventMgr.Dispatch(EventType.Replay_BGM);
    ReleaseCSComRefs();
end

function PlayBGM(disChangeBGM)
    --播放BGM
    if disChangeBGM~=true then
       local bgmName=CSAPI.PlayBGM("FesDream_Music_01")
    end
end

function OnViewClosed(viewKey)
    if viewKey=="ShopView" then
        FuncUtil:Call(PlayBGM,nil,150)
    end
end

function OnOpen()
    pool = ItemPoolActivityMgr:GetPoolInfo(openSetting);
    PlayBGM();
    Refresh();
end

function Refresh()
    if pool==nil then
        do return end;
    end
    if timer ~= nil then
        timerMgr:RemoveTimer(timer);
        timer = nil;
    end
    timer = timerMgr:AddTimer(1, SetTime, true);
    if pool:GetBuyCommID()~=nil then
        comm=ShopMgr:GetFixedCommodity(pool:GetBuyCommID());
    else
        comm=nil;
    end
    -- 初始化展示的图片
    local topGrade=pool:GetTopRewardLv()
    local info=pool:GetCurrRoundGradeInfo(topGrade,true);
    local good=info:GetGoodInfo();
    local modelID=good:GetDyVal2();
    local modelCfg=Cfgs.character:GetByID(modelID)
    if modelCfg then
        roleItem.Refresh(modelCfg.id, LoadImgType.Main, nil, false)
    end
    spCfg=pool:GetPoolConsume();
    if spCfg and spCfg.feature then
        --展示图片
        for i=1,4 do
            if i<=#spCfg.feature then
                ResUtil.FesPool:Load(this["dIcon"..i],spCfg.feature[i])
            end
            CSAPI.SetGOActive(this["dIcon"..i],i<=#spCfg.feature);
        end
        CSAPI.SetGOActive(dIconNode,true);
    else
        CSAPI.SetGOActive(dIconNode,false);
    end
    -- 初始化奖励信息
    ResUtil.FesIcons:Load(sRewardImg,spCfg.pic);
    local list=pool:GetInfos(pool:GetRound(),false,true);
    local curList={};
    local tempList={};
    for k, v in ipairs(list) do
        local rewardLv=v:GetRewardLevel();
        if rewardLv>topGrade then
            tempList[rewardLv]=tempList[rewardLv] or {}
            table.insert(tempList[rewardLv],v);
        end
    end
    for k, v in pairs(tempList) do
        table.insert(curList,v);
    end
    table.sort(curList,function(a,b)
        if a~=nil and b~=nil then
            return a[1]:GetRewardLevel()<b[1]:GetRewardLevel()
        end
    end)
    ItemUtil.AddItems("FesDream/FesDreamRewardItem",items,curList,rLayout);
    -- 初始化抽取货币
    SetCosts();
    SetRed()
    local isOver=false;
    if (comm~=nil and comm:IsOver()) or (info and info:IsOver()) then
        isOver=true;
    end
    CSAPI.SetGOActive(SRewardOver,isOver)
    if comm==nil then
        CSAPI.SetGOActive(priceObj,false)
        CSAPI.SetGOActive(btnBuy,false)
        do return end
    else
        CSAPI.SetGOActive(priceObj,true)
        CSAPI.SetGOActive(btnBuy,true)
    end
    -- 初始化皮肤价格
    SetCommCosts();
    if spCfg then
        isOver=#spCfg.infos<=pool:GetDrawCount();
        CSAPI.SetGrey(drawImg,isOver);
        CSAPI.SetTextColorByCode(txtDraw,isOver and "7e7e7e" or "FFF8DE");
        buyClicker.raycastTarget=not isOver;
    end
    if comm:IsOver() then
        --置灰按钮
        CSAPI.SetGrey(btnBuy,true);
        CSAPI.SetTextColorByCode(txtBuy,"7e7e7e");
        CSAPI.SetText(txtBuy,LanguageMgr:GetByID(18033));
        buyClicker.raycastTarget=false;
    else
        CSAPI.SetGrey(btnBuy,false);
        CSAPI.SetTextColorByCode(txtBuy,"FFF8DE");
        buyClicker.raycastTarget=true;
    end
end

function SetRed()
    local isRed=false;
    if pool and pool:IsOver()~=true then
        isRed=ItemPoolActivityMgr:CheckPoolHasRedPoint(openSetting);
    end
    UIUtil:SetRedPoint(btnDraw,isRed,176,30);
end

function SetCommCosts()
    if comm == nil then
        do
            return
        end
    end
    local rmbIcon = comm:GetCurrencySymbols();
    local SDKdisplayPrice = comm:GetSDKdisplayPrice();
    local costs = comm:GetRealPrice();
    local commIsOver=comm:IsOver();
    local freeID=commIsOver and 18012 or 18032;
    CSAPI.SetText(pnIcon1, rmbIcon);

    if costs == nil or (#costs == 1 and costs[1].num <= 0) or commIsOver then
        CSAPI.SetGOActive(pnIcon1, false);
        CSAPI.SetGOActive(dMNode1,false);
        CSAPI.SetText(txt_dPrice1, LanguageMgr:GetByID(freeID));
    else     
        local isRmb=costs[1].id == -1
        CSAPI.SetGOActive(pnIcon1, isRmb);
        CSAPI.SetGOActive(dMNode1,not isRmb);
        if not isRmb then
            ShopCommFunc.SetPriceIcon(dMIcon1, costs[1]);
        end
        if CSAPI.IsADV() then
            CSAPI.SetText(txt_dPrice1, tostring(SDKdisplayPrice or costs[1].num));
        else
            CSAPI.SetText(txt_dPrice1, tostring(costs[1].num));
        end
    end
end

function SetCosts()
    local costs = pool:GetCostGoods();
    costs[1]:GetIconLoader():Load(mIcon1,costs[1]:GetIcon().."_1",false);
    CSAPI.SetScale(mIcon1,1,1,1)
    CSAPI.SetText(txtM1,tostring(costs[1]:GetCount()));
    if #costs > 1 then
        costs[2]:GetIconLoader():Load(mIcon2,costs[2]:GetIcon().."_1",false);
        CSAPI.SetScale(mIcon2,1,1,1)
        CSAPI.SetText(txtM2,tostring(costs[2]:GetCount()));
    end
    CSAPI.SetGOActive(mNode2, #costs > 1);
end

function SetTime()
    if pool then
        local overTime = TimeUtil:GetTimeStampBySplit(pool:GetCloseTime())
        local count = TimeUtil:GetDiffHMS(overTime, TimeUtil.GetTime());
        if count.day > 0 or count.hour > 0 or count.minute > 0 or count.second > 60 then
            local hour = count.hour < 10 and "0" .. count.hour or count.hour;
            if count.day == 0 and count.hour == 0 then
                hour = "01"
            end
            CSAPI.SetText(txtTime, LanguageMgr:GetByID(190206, count.day, hour));
        else
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

function OnClickClose()
    view:Close();
end

-- 票券
function OnClickShop()
    --读取票券中的跳转ID
    if pool then
        local costs=pool:GetCost();
        if #costs>1 then
            local goods=GoodsData({id=costs[2][1]});
            JumpMgr:Jump(goods:GetMoneyJumpID());
        else
            local goods=GoodsData({id=costs[1][1]});
            JumpMgr:Jump(goods:GetMoneyJumpID());
        end
    end
end

-- 抽取
function OnClickDraw()
    --判定消耗是否足够
    -- if true then
    --     -- local name=num==1 and "fesdream_step2" or "fesdream_step1"
    --     -- OnPlayDrawTween("fesdream_step2");
    --     -- num=1;
    --     -- PlayTween();
    --     local proto={
    --         drawArr={3},
    --         drawRound=1,
    --     }
    --     OnDrawRet(proto)
    --     do return end
    -- end
    if pool==nil then
        do return end
    end
    if isOver or (comm and comm:IsOver()) then
        Tips.ShowTips(LanguageMgr:GetTips(38005));
        do return end
    end
    local goods=pool:GetCostGoods();
    local count=0;
    local goodsName=nil;
    for k, v in ipairs(goods) do
        local bagCount=BagMgr:GetCount(v:GetID());
        if v:GetCount()<=bagCount then
            count=k;
        elseif goodsName==nil then
            goodsName=v:GetName();
        end
    end
    if count==#goods then --抽取
        RegressionProto:ItemPoolDraw(pool:GetID(), 1);
    else
        Tips.ShowTips(LanguageMgr:GetTips(15000,goodsName))
    end
end

-- 直购
function OnClickBuy()
    --提示购买后无法抽奖
    local dialogData = {};
    dialogData.content = LanguageMgr:GetByID(190207);
    dialogData.okCallBack = function()
        if comm~=nil and comm:IsOver()~=true then
            ShopCommFunc.OpenPayView(comm);
        end
    end;
    CSAPI.OpenView("Dialog",dialogData);
end

function OnBuyRet(proto)
    Refresh();
end

function OnDrawRet(proto)
    -- 播放动画
    -- LogError(proto)
    if proto and proto.drawArr and proto.drawRound and pool then    
        local list = pool:GetInfos(proto.drawRound,false,true);
        if list then
            rewardInfo = nil;
            rewardDic = {};
            lessQuality=5;
            for k, v in ipairs(list) do
                for _, val in ipairs(proto.drawArr) do
                    if v:GetIndex() == val then
                        rewardInfo = rewardInfo or {};
                        local info = v:GetGoodInfo();
                        rewardQuality=v:GetQuality();
                        table.insert(rewardInfo, info);
                    end
                end
                rewardDic[v:GetQuality()]=rewardDic[v:GetQuality()] or 0;
                if v:GetCurrRewardNum()>=1 then
                    rewardDic[v:GetQuality()]=rewardDic[v:GetQuality()]+1;
                end
                if v:GetCurrRewardNum()>=1 and v:GetQuality()<lessQuality then
                    lessQuality=v:GetQuality()
                end
            end
        end
        if pool then
            pool = ItemPoolActivityMgr:GetPoolInfo(pool:GetID());
        end  
        PlayTween()
        ItemPoolActivityMgr:CheckPoolHasRedPoint(pool:GetID());
    end
end


function OnBagUpdate()
    SetCommCosts();
    SetCosts();
end

function OnClickSkip()
    if enterTween and playState==1 then --跳过第一段
        enterTween:Pause(true)
        CSAPI.RemoveGO(enterTween.gameObject)
        enterTween = nil
        if curSoundName~=nil then
            CSAPI.StopTargetSound("temp/temp.acb",curSoundName);
        end
        --播放第二段
        PlayTween(2);
    end
end

function PlayTween(state)
    if isPlaying~=true then
        PlayReady();
    end
    isPlaying=true;
    if state and state<=2 then   
        PlayPoolDraw();
    else
        FuncUtil:Call(PlayPoolEnter,nil,100)
        -- PlayPoolEnter();
    end
end

function PlayReady()
    Reset();
    drawTween = ResUtil:PlayVideo("fesdream_step2",movieObj2);
    drawTween:AddFrameEvent(2,function()
        drawTween:Pause(true);
    end)
    drawTween:AddFrameEvent(78,PlayOver);
    -- drawTween:AddCompleteEvent(PlayOver)
end

--播放入场动画
function PlayPoolEnter()
    playState=1;
    CSAPI.SetGOActive(movieNode,true)
    CSAPI.SetAnchor(movieObj1,0,0)
    CSAPI.SetAnchor(movieObj2,100000,100000)
    CSAPI.SetGOActive(effect1,false)
    CSAPI.SetGOActive(effect2,false)
    curSoundName="FesDream_Effect_01";
    CSAPI.PlaySound("temp/temp.acb",curSoundName);
    enterTween = ResUtil:PlayVideo("fesdream_step1",movieObj1);
    enterTween:AddFrameEvent(60,PlayEffect1);
    -- enterTween:AddCompleteEvent(PlayOver)
end

function PlayEffect1()  
    --设置各种颜色
    curSoundName="FesDream_Effect_02";
    CSAPI.PlaySound("temp/temp.acb",curSoundName);
    local drawNum=pool:GetDrawCount();
    local indexDic={};--记录各个品质的索引，用于计算延迟时间,结构[quality]={index1,index2,...}
    if spCfg  and spCfg.infos[drawNum] and spCfg.infos[drawNum].quality then
        -- LogError(tostring(drawNum).."\t"..tostring(lessQuality).."\t"..table.tostring(rewardDic).."\t"..table.tostring(spCfg.infos[drawNum].quality))
        for k, v in ipairs(spCfg.infos[drawNum].quality) do
            local q=v;
            if rewardDic and rewardDic[v]==0 then
                q=lessQuality
            end
            -- LogError(q)
            --设置各个位置的颜色显示
            for key, val in pairs(qualityKey) do
                local goKey=k..val;
                CSAPI.SetGOActive(this[goKey],key==q);
            end   
            indexDic[q]=indexDic[q] or {}
            table.insert(indexDic[q],k)
        end
    else
        for i=1,6 do
            local q=rewardQuality;
            --设置各个位置的颜色显示
            for key, val in pairs(qualityKey) do
                local goKey=i..val;
                CSAPI.SetGOActive(this[goKey],key==q);
            end   
        end
    end
    if IsNil(animator)~=true then
        animator:Play(defaultAnimatName,-1,0);
    end
    local delayTime=1875; --动态计算最终落点
    local index=1;
    if rewardQuality~=nil and indexDic[rewardQuality] then
        if #indexDic[rewardQuality]>=2 then
            local idx=math.random(#indexDic[rewardQuality])
            -- LogError("随机数："..tostring(idx))
            index=indexDic[rewardQuality][idx]
        else
            index=indexDic[rewardQuality][1];
        end
        if index~=nil then
            --计算转换后的位置
            index=index%6==0 and 1 or 6-index%6+1;
            nextAnimatName="danse_0"..index;
            delayTime=delayTime+(62.5*(index-1));
            -- LogError("停靠位置："..tostring(index).."\t"..tostring(rewardQuality).."\t"..tostring(delayTime).."\t"..tostring(nextAnimatName).."\t"..table.tostring(indexDic))
        end
    else--都没有时说明抽完了所有卡池
        index=1
        delayTime=1875;
    end
    CSAPI.SetAnchor(stopEff,stopPoint[index][1],stopPoint[index][2])
    CSAPI.SetGOActive(effect1,true)
    CSAPI.SetGOActive(runEff,true)
    CSAPI.SetGOActive(stopEff,false)
    CSAPI.SetGOActive(effect2,false)
    FuncUtil:Call(PlayEff2,nil,delayTime)
end

function PlayEff2()
    if playState>1 then
        do return end
    end
    if rewardQuality then
        CSAPI.SetGOActive(ckbk_H,rewardQuality==5);
        CSAPI.SetGOActive(ckbk_P,rewardQuality==4);
        CSAPI.SetGOActive(ckbk_B,rewardQuality==3);
    end
    CSAPI.SetGOActive(effect1,true)
    CSAPI.SetGOActive(runEff,false)
    CSAPI.SetGOActive(stopEff,true)
    CSAPI.SetGOActive(effect2,false)
    --展示得到的物品特效
    -- FuncUtil:Call(PlayEffOver,nil,100)
    PlayEffOver();
end

function PlayEffOver()
    if playState>1 then
        do return end
    end
    CSAPI.SetGOActive(runEff,true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(stopEff,false)
    end,nil,500)
    if IsNil(animator)~=true then
        animator:Play(nextAnimatName,-1,0);
    end
    curSoundName="FesDream_Effect_03";
    CSAPI.PlaySound("temp/temp.acb",curSoundName);
    if rewardQuality then
        for i=1,6 do
            for key, val in pairs(qualityKey) do
                local goKey=i..val;
                CSAPI.SetGOActive(this[goKey],key==rewardQuality);
            end   
        end
    end
    --播放渐隐效果
    FuncUtil:Call(PlayEffHide,nil,1000)
end

function PlayEffHide()
    if playState>1 then
        do return end
    end
    curSoundName="FesDream_Effect_04";
    CSAPI.PlaySound("temp/temp.acb",curSoundName);
    CSAPI.SetGOActive(stopEff,false)
    if IsNil(animator)~=true then
        animator:Play("prizeWheel_3",-1,0);
    end
    --播放渐隐效果
    FuncUtil:Call(PlayPoolDraw,nil,1000)
end

function PlayPoolDraw()
    if not IsNil(enterTween) then
        enterTween:Pause(true);
    end
    CSAPI.SetGOActive(btnSkip,false)
    CSAPI.SetGOActive(movieNode,true)
    CSAPI.SetAnchor(movieObj2,0,0)
    CSAPI.SetAnchor(movieObj1,100000,100000)
    CSAPI.SetGOActive(effect1,false)
    CSAPI.SetAnchor(effect1,100000,100000)
    CSAPI.SetGOActive(effect2,false)
    playState=2;
    if rewardQuality then
        CSAPI.SetGOActive(bk_H,rewardQuality==5);
        CSAPI.SetGOActive(bk_P,rewardQuality==4);
        CSAPI.SetGOActive(bk_B,rewardQuality==3);
    end
    drawTween:Pause(false);
end

function PlayOver()
    if not IsNil(drawTween) then
        drawTween:Pause(true);
    end
    CSAPI.SetGOActive(effect2,true)
    curSoundName="FesDream_Effect_05";
    CSAPI.PlaySound("temp/temp.acb",curSoundName);
    Refresh();
    FuncUtil:Call(function()
        CSAPI.SetGOActive(effect2,false)
        --弹奖励框
        CSAPI.OpenView("FesDreamResult",{rewardInfo,closeCallBack=function()
			Reset();
		end});
        -- UIUtil:OpenReward({rewardInfo,closeCallBack=function()
		-- 	Reset();
		-- end})
    end,nil,2000)
    playState=0;
    isPlaying=false;
end

function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID("FesDreamActivity")
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

function Reset()
    -- LogError("Reset------------>")
    if IsNil(enterTween)~=true then
        CSAPI.RemoveGO(enterTween.gameObject)
    end
    if IsNil(drawTween)~=true then
        CSAPI.RemoveGO(drawTween.gameObject)
    end
    enterTween=nil;
    drawTween=nil;
    curSoundName=nil;
    CSAPI.SetGOActive(movieNode,false)
    CSAPI.SetAnchor(movieObj1,100000,100000)
    CSAPI.SetAnchor(movieObj2,100000,100000)
    CSAPI.SetAnchor(effect1,0,0)
    CSAPI.SetGOActive(effect1,false)
    CSAPI.SetGOActive(runEff,false)
    CSAPI.SetGOActive(stopEff,false)
    CSAPI.SetGOActive(effect2,false)
    CSAPI.SetGOActive(btnSkip,true)
    isPlaying=false;
end

function ReleaseCSComRefs()
    gameObject=nil;
    transform=nil;
    this=nil;  
    bg=nil;
    enterTween=nil;
    drawTween=nil;
    isPlaying=false;
    timerMgr = nil;
end