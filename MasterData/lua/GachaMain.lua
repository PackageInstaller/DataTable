-- 扭蛋主界面
local data = nil;
local cfg = nil;
local pool = nil;
local layout = nil;
local endTime = 0;
local fixedTime = 1;
local upTime = 0;
local overTime = 0;
local curDatas = nil;
local eventMgr = nil;
local isOver = false;
local rewardPanel = nil;
local jumpId=nil;
local balls={};
local ballNode={};
local btnAnimator=nil;
local ballAnimator=nil;
local downAnimator=nil;
local energyAnimator=nil;
local maxNum=6;
--动画相关计时
local isAnimaCount=false;
local animaStep=1;
local beginTime=1.2;
local rechangeTime=1.05;--更改时间
local ballEndTime=1.45
local downTime=1.2
local countTime=0;
local btnAnimaName="btnStart";
local ballAnimaName="Gacha_ball_in";
local downAnimaName="ball_down";
local energyAnimaName="Energy_Fill";
local animaIdx=nil;--产出下标
local resultProto=nil;
local downBall=nil;
local hideSort={1,6,4,3,5,2};
local overIdx={};
local list=nil;

function Awake()
    ballAnimator=ComUtil.GetCom(ballRoot,"Animator");
    btnAnimator=ComUtil.GetCom(btnStart,"Animator");
    downAnimator=ComUtil.GetCom(downObj,"Animator");
    energyAnimator=ComUtil.GetCom(EnergyAnima,"Animator");
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/Gacha/GachaRewardGrid", LayoutCallBack, true)
    ResUtil:CreateUIGOAsync("Gacha/GachaRewardView", gameObject, function(go)
        rewardPanel = ComUtil.GetLuaTable(go);
        rewardPanel.Hide();
    end);
    local go = ResUtil:CreateUIGO("Gacha/GachaBall", ball.transform);
    downBall=ComUtil.GetLuaTable(go);
    -- ResUtil:CreateUIGOAsync("Gacha/GachaBall",ball,function(go)
    --     downBall=ComUtil.GetLuaTable(go)
    --     -- CSAPI.SetGOActive(go,false);
    -- end);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.ItemPool_Draw_Ret, OnDrawRet);
    eventMgr:AddListener(EventType.Bag_Update, OnBagUpdate);
    RedPointMgr:SetDayRedToday(RedPointDayOnceType.GachaBall);
    EventMgr.Dispatch(EventType.RedPoint_Refresh);
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_data, _elseData)
    data = _data;
    cfg = _elseData and _elseData.cfg or nil;
    local cfgId = nil
    if cfg and cfg.info then
        cfgId = cfg.info[1].cfgId
        jumpId=cfg.info[1].jumpId and cfg.info[1].jumpId or nil;
        pool = ItemPoolActivityMgr:GetPoolInfo(cfgId);
        if pool == nil then
            pool = ItemPoolInfo.New();
            pool:InitCfg(cfgId);
        end
    else
        pool = nil;
        jumpId=nil;
        cfgId=nil;
    end
    if pool == nil then
        LogError("未获取到对应活动数据：" .. tostring(cfgId));
        do
            return
        end
    end
    SetLayout()
end

function GetIsShow(i)
    if overIdx then
        for k,v in ipairs(overIdx) do
            if v==i then
                return false;
            end
        end
    end
    return true;
end

-- function SetParent()
--     if curDatas then
--         local oIdx=2;
--         local idx=1;
--         for i=1,maxNum do
--             local isShow=false;
--             local index=1;
--             if animaIdx~=nil then
--                 if curDatas[i]:GetIndex()==animaIdx then
--                     idx=1;
--                 else
--                     idx=oIdx;
--                     oIdx=oIdx+1;
--                 end
--             else
--                 idx=i;
--             end
--             if idx<=#curDatas then
--                 -- isShow=curDatas[i]:GetCurrRewardNum()>0;
--                 index=curDatas[i]:GetIndex();
--                 isShow=GetIsShow(index);
--             end
--             if idx<=#balls then
--                 balls[idx].SetAlpha(isShow and 1 or 0);
--                 if isShow then
--                     balls[idx].Refresh(curDatas[i]:GetGoodInfo(),index);
--                 end
--             else
--                 ResUtil:CreateUIGOAsync("Gacha/GachaBall", this["ball_0"..index],function(go)
--                     local lua=ComUtil.GetLuaTable(go)
--                     if isShow then
--                         lua.Refresh(curDatas[i]:GetGoodInfo(),index);
--                     end
--                     lua.SetAlpha(isShow and 1 or 0);
--                     table.insert(balls,lua);
--                 end);
--             end
--         end
--     end
-- end

function CreateBalls()
    if list then
        local idx=1;--挂载点下标
        local showNum=1;
        table.sort(list,function(a,b)
            local a1,b1=0,0;
            if animaIdx then
                a1=animaIdx==a:GetIndex() and #list+1 or 0;
                b1=animaIdx==b:GetIndex() and #list+1 or 0;
            end
            if overIdx then
                for k,v in ipairs(overIdx) do
                    if v==a:GetIndex() then
                        a1=#list-k;
                    end
                    if v==b:GetIndex() then
                        b1=#list-k;
                    end
                end
            end
            if a1==b1 then
                if a:GetCurrRewardNum() == b:GetCurrRewardNum() then
                    return a:GetIndex() < b:GetIndex();
                else
                    return a:GetCurrRewardNum() < b:GetCurrRewardNum()
                end
            else
                return a1>b1;
            end
        end)
        for i=1,maxNum do
            local isShow=false;
            local index=list[i]:GetIndex();
            idx=hideSort[i];
            -- LogError("idx:"..tostring(idx))
            if idx<=#list then
                -- isShow=list[i]:GetCurrRewardNum()>0;
                isShow=GetIsShow(index);
            end
            -- LogError(tostring(idx).."\t"..tostring(index).."\t"..tostring(isShow))
            if balls[idx]~=nil then
                balls[idx].SetAlpha(isShow and 1 or 0);
                if isShow then
                    balls[idx].Refresh(list[i]:GetGoodInfo(),index);
                end
            else
                ResUtil:CreateUIGOAsync("Gacha/GachaBall", this["ball_0"..idx],function(go)
                    local lua=ComUtil.GetLuaTable(go)
                    if isShow then
                        lua.Refresh(list[i]:GetGoodInfo(),index);
                    end
                    lua.SetAlpha(isShow and 1 or 0);
                    balls[idx]=lua;
                end);
            end
        end
    end
end

function SetLayout()
    -- 显示剩余时间和货币
    CSAPI.SetGOActive(txtTime, true);
    RefreshDownTime();
    local info = pool:GetDescInfo();
    if info and #info > 1 then
        CSAPI.SetText(txtRule, LanguageMgr:GetByID(info[2]));
    end
    SetOver();
    SetCost();
    curDatas = pool:GetInfos(pool:GetRound(),false,true);
    list = pool:GetInfos(pool:GetRound(),false,true);
    -- 初始化剩余奖励预览
    table.sort(curDatas, function(a, b)
        if a:GetCurrRewardNum() == b:GetCurrRewardNum() then
            return a:GetIndex() < b:GetIndex();
        else
            return a:GetCurrRewardNum() > b:GetCurrRewardNum()
        end
    end)
    layout:IEShowList(#curDatas);
    RefreshOverIdx();
    -- 初始球体
    CreateBalls();
end

function SetOver()
    if pool == nil then
        do
            return
        end
    end
    isOver = pool:IsOver();
    if isOver then -- 抽完了
        CSAPI.SetGOActive(priceObj, false);
        CSAPI.SetGOActive(overImg, true);
    else
        CSAPI.SetGOActive(priceObj, true);
        CSAPI.SetGOActive(overImg, false);
    end
end

function SetCost()
    CSAPI.SetGOActive(moneyItem,not isOver)
    if not isOver then
        local itemInfo = pool:GetCostGoods();
        local count = BagMgr:GetCount(itemInfo:GetID());
        itemInfo:GetIconLoader():Load(mIcon, itemInfo:GetIcon());
        CSAPI.SetText(txtMoney, "X " .. tostring(count));
        itemInfo:GetIconLoader():Load(mIcon2, itemInfo:GetIcon());
        CSAPI.SetText(txtPrice, "X" .. tostring(itemInfo:GetCount()));
    end
end

function Update()
    if endTime and endTime > 0 then
        upTime = upTime + Time.deltaTime;
        if upTime >= fixedTime then
            endTime = endTime - fixedTime;
            RefreshDownTime();
            upTime = 0;
        end
    end
    if isAnimaCount and animaIdx then
        countTime=countTime+Time.deltaTime;
        if animaStep==1 and beginTime<=countTime then
            animaStep=2;
            countTime=0;
            if ballAnimator~=nil then
                ballAnimator:Play(ballAnimaName,-1,0);
            end
        end
        if animaStep==2 and rechangeTime<=countTime then
            animaStep=3;
            countTime=0;
            SetLayout();
            table.insert(overIdx,animaIdx);
            -- SetParent();
        end
        if animaStep==3 and ballEndTime<=countTime then
            animaStep=4;
            countTime=0;
            if downBall and curDatas and animaIdx then
                local itemData=nil;
                for k,v in ipairs(curDatas) do
                    if v:GetIndex()==animaIdx then
                        itemData=v;
                        break;
                    end
                end
                downBall.Refresh(itemData:GetGoodInfo(),animaIdx);
                if downAnimator~=nil then
                    downAnimator:Play(downAnimaName,-1,0);
                end
            end
        end
        if animaStep==4 and downTime<=countTime then
            animaStep=nil;
            countTime=0;
            isAnimaCount=nil;
            animaIdx=nil;
            ShowReward(resultProto);
        end
    end
end

function RefreshDownTime()
    if pool then
        overTime = TimeUtil:GetTimeStampBySplit(pool:GetCloseTime())
        endTime = overTime - TimeUtil:GetTime();
        local count = TimeUtil:GetDiffHMS(overTime, TimeUtil.GetTime());
        if count.day > 0 or count.hour > 0 or count.minute > 0 or count.second > 60 then
            CSAPI.SetText(txtTime, string.format("%s%s", LanguageMgr:GetByID(60102),
                LanguageMgr:GetByID(34039, count.day, count.hour, count.minute)));
        else
            CSAPI.SetText(txtTime,
                string.format("%s%s", LanguageMgr:GetByID(60102), LanguageMgr:GetByID(1062, count.second)));
        end
        if endTime <= 0 then -- 回到主界面并提示
            HandlerOver();
        end
    end
end

-- 活动结束
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end, nil, 100);
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index);
    item.Refresh(_data);
end

-- 开始抽取
function OnClick()
    -- local proto={drawArr={CSAPI.RandomInt(1,6)},drawRound=1};
    -- OnDrawRet(proto);
    -- if true then
    --     do return end
    -- end

    --播放按钮旋转动画，播放完发送协议
    local itemInfo = pool:GetCostGoods();
    if itemInfo and isAnimaCount~=true then
        local count = BagMgr:GetCount(itemInfo:GetID());
        if isOver then
            Tips.ShowTips(LanguageMgr:GetTips(38005));
            do
                return
            end
        end
        if count == 0 then
            -- Tips.ShowTips(LanguageMgr:GetTips(37001));
            local dialogData={
                content = LanguageMgr:GetByID(67005),
                okCallBack = function()
                    if jumpId then
                        JumpMgr:Jump(jumpId)
                    end
                end
            }
		    CSAPI.OpenView("Dialog", dialogData);
            do
                return
            end
        end
        RegressionProto:ItemPoolDraw(pool:GetID(), 1);
    elseif isAnimaCount~=true then
        Tips.ShowTips(LanguageMgr:GetTips(38005));
    end
end

function RefreshOverIdx()
    if pool then
        overIdx={}
        local drawArr=pool:GetDrawArr();
        if drawArr then
            for k,v in pairs(drawArr) do
                table.insert(overIdx,k);
            end
        end
    end
end

-- 展示奖励
function OnDrawRet(proto)
    -- 根据drawArr的下标获取奖励信息并显示
    if proto and proto.drawArr and proto.drawRound and pool then
        resultProto=proto;
        if energyAnimator~=nil then
            energyAnimator:Play(energyAnimaName,-1,0);
        end
        if btnAnimator~=nil then
            isAnimaCount=true;
            countTime=0;
            animaStep=1;
            animaIdx=proto.drawArr[1];
            btnAnimator:Play(btnAnimaName,-1,0);
        else
            ShowReward(proto)
        end
    else
        resultProto=nil;
        ShowReward(proto);
    end
end

function ShowReward(proto)
    -- 根据drawArr的下标获取奖励信息并显示
    if proto and proto.drawArr and proto.drawRound and pool then
        --展示奖励框
        local list = pool:GetInfos(proto.drawRound, true);
        if list then
            local rewardInfo = nil;
            for k, v in ipairs(list) do
                for _, val in ipairs(proto.drawArr) do
                    if v:GetIndex() == val then
                        rewardInfo = v;
                        break
                    end
                end
                if rewardInfo then
                    break
                end
            end
            if rewardInfo and rewardPanel then
                rewardPanel.Open(rewardInfo)
            end
        end
        if pool then
            pool = ItemPoolActivityMgr:GetPoolInfo(pool:GetID());
        end
        ActivityMgr:CheckRedPointData(ActivityListType.GachaBall);
    end
    SetLayout()
end

function OnBagUpdate()
    SetOver();
    SetCost();
end

-- 跳转
function OnClickGet()
    if jumpId then
        JumpMgr:Jump(jumpId);
    end
end
