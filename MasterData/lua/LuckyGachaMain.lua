local top=nil;
local eventMgr=nil;
local cfg = nil;
local pool = nil;
local endTime = 0;
local fixedTime = 1;
local upTime = 0;
local overTime = 0;
local isOver=false;
local maxNum=0;
local muxClicker=nil;
local criMovie=nil;
local criMovie2=nil;

function Awake()
    top=UIUtil:AddTop2("LuckyGachaMain",gameObject,OnClickClose);
    muxClicker=ComUtil.GetCom(btnMux,"Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.ItemPool_Draw_Ret, OnDrawRet);
    eventMgr:AddListener(EventType.Bag_Update, OnBagUpdate);

    local scale = UIUtil:SetPerfectScale(Bg1) -- 适配大小
    UIUtil:SetObjScale(Bg1, scale + 0.1, scale, scale + 0.1, scale, 1, 1, nil, 500, 1)
    UIUtil:SetObjScale(Bg2, scale + 0.1, scale, scale + 0.1, scale, 1, 1, nil, 500, 1)
    UIUtil:SetObjScale(Bg3, scale + 0.2, scale+0.2, scale + 0.2, scale, 1, 1, nil, 500, 1)
    UIUtil:SetObjScale(Bg4, scale + 0.2, scale+0.2, scale + 0.2, scale, 1, 1, nil, 500, 1)
    UIUtil:SetObjScale(Bg5, scale + 0.2, scale+0.2, scale + 0.2, scale, 1, 1, nil, 500, 1)
end

function OnDestroy()
    eventMgr:ClearListener();
 end

function OnOpen()
    pool=ItemPoolActivityMgr:GetPoolInfoByType(ItemPoolType.LuckyGacha);
    if pool==nil then
        LogError("未获取到对应活动数据!");
        do return end
    end
    CSAPI.SetGOActive(Limit,pool:IsLimitImg());
    Refresh();
end

function Refresh()
    CSAPI.SetGOActive(txtTime, true);
    RefreshDownTime();
    local info = pool:GetDescInfo();
    if info and #info > 1 then
        CSAPI.SetText(txtRule, LanguageMgr:GetByID(info[2]));
    end
    maxNum=pool:GetMaxCostNum()
    if pool:GetExtractType()==ItemPoolExtractType.ControlNotInfinite or pool:GetExtractType()==ItemPoolExtractType.Control then
        local num2=pool:GetCountMax();--最终奖品保底次数
        local num3=pool:GetDrawCount()+maxNum;
        if (num3>=num2) then --连抽次数大于剩余奖品数
            CSAPI.SetGOActive(btnMux,false);
        else
            CSAPI.SetGOActive(btnMux,true);
        end
    else
        CSAPI.SetGOActive(btnMux,maxNum>1);
    end
    SetCost();
    isOver = pool:IsOver();
    CSAPI.SetImgColorByCode(boxImg,isOver and "838383" or "ffffff");
    CSAPI.SetGOActive(overObj,isOver);
    CSAPI.SetGOActive(drawObj,not isOver);
end

function SetCost()
    if not isOver then
        local itemInfo = pool:GetCostGoods();
        if itemInfo==nil then
            LogError("未获取到消耗道具信息！"..table.tostring(pool:GetCost()));
            do return end
        end
        local count = itemInfo:GetCount();
        if top then
            top.SetMoney({{itemInfo:GetID(),itemInfo:GetMoneyJumpID()}});
        end
        itemInfo:GetIconLoader():Load(aMIcon, itemInfo:GetIcon().."_2");
        -- CSAPI.SetRTSize(aIcon,60,60);
        CSAPI.SetText(txtOncePrice, "X " .. tostring(count));
        itemInfo:GetIconLoader():Load(mIcon, itemInfo:GetIcon().."_2");
        -- CSAPI.SetRTSize(mIcon,60,60);
        CSAPI.SetText(txtMuxPrice, "X" .. tostring(count*maxNum));
        CSAPI.SetText(txtMux,LanguageMgr:GetByID(67009,maxNum));
        local list=pool:GetInfos(pool:GetRound(),true,true);
        if list then
            for k,v in ipairs(list) do
                if v:GetRewardLevel()==ItemPoolGoodsGrade.S and v:IsShow() then
                    local goodInfo=v:GetGoodInfo();
                    goodInfo:GetIconLoader():Load(sIcon, goodInfo:GetIcon().."_02");
                elseif v:GetRewardLevel()==ItemPoolGoodsGrade.A and v:IsShow() then
                    local goodInfo=v:GetGoodInfo();
                    goodInfo:GetIconLoader():Load(aIcon, goodInfo:GetIcon().."_02");
                end
            end
        end
        local item=BagMgr:GetDataByCfgID(itemInfo:GetCfgID());
        local num=pool:GetMaxCostNum();
        local enable,enable2=false,false
        if item then
            enable=item:GetCount()>=count;
            enable2=item:GetCount()>=num;
        end
        UIUtil:SetRedPoint(btnOnce,enable,200,45);
        UIUtil:SetRedPoint(btnMux,enable2,200,45);
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

function OnDrawRet(proto)
    --播放动画
    OnPlayDrawTween(proto)
end

function OnPlayDrawTween(proto)
    if criMovie or criMovie2 then
        LogError("有正在播放的动画！")
        Refresh();
        do return end
    end
    local fadeTime=1600
    local stagName="luckygacha_draw"
    criMovie = ResUtil:PlayVideo(stagName,movieObj);
    CSAPI.PlayUISound("ui_"..stagName);
    FuncUtil:Call(function()
        local videoName="luckygacha_star";
        if proto and proto.drawArr and proto.drawRound and proto.info and pool then
            local list = pool:GetInfos(proto.drawRound, true);
            if list then
                local rewardInfo=nil; 
                local has1st=false;
                local idx=nil;
                for k, v in ipairs(list) do
                    for _, val in ipairs(proto.drawArr) do
                        if v:GetIndex() == val then
                            if v:IsKeyReward() then
                                has1st=true;
                            end
                            if idx==nil or v:GetQuality()>idx then --连抽按最高的算
                                idx=v:GetQuality();
                            end
                            rewardInfo=rewardInfo or {};
                            local info=v:GetGoodInfo();
                            table.insert(rewardInfo,{id=info:GetID(),type=RandRewardType.ITEM,num=info:GetCount()});
                        end
                    end
                end
                videoName=videoName..idx
                if idx then
                    CSAPI.PlayUISound("ui_"..videoName);
                    criMovie2 = ResUtil:PlayVideo(videoName,movieObj);
                    criMovie2:AddCompleteEvent(function()
                        ShowReward(rewardInfo,has1st);
                        criMovie2=nil;
                    end);
                end
            end
            if pool then
                pool = ItemPoolActivityMgr:GetPoolInfo(pool:GetID());
            end
            ActivityMgr:CheckRedPointData(ActivityListType.GachaBall);
            Refresh();
            criMovie=nil;
        end
	end,nil,fadeTime)
end

function ShowReward(rewardInfo,has1st)
    -- 根据drawArr的下标获取奖励信息并显示
    if rewardInfo then
        -- 展示奖励框
        if has1st then
            -- 打开特殊界面
            CSAPI.OpenView("LuckyGachaReward");
        else
            UIUtil:OpenReward({rewardInfo}, {
                isNoShrink = true
            });
        end
    end
end

function OnClickSSS()
    OnClickGrade(ItemPoolGoodsGrade.SSS)
end

function OnClickS()
    OnClickGrade(ItemPoolGoodsGrade.S)
end

function OnClickA()
    OnClickGrade(ItemPoolGoodsGrade.A)
end

function OnClickGrade(itemPoolGoodsGrade)
    if pool then
        local info=pool:GetCurrRoundGradeInfo(itemPoolGoodsGrade,true);  
        local itemData=info:GetGoodInfo(true);
        if itemData then
            CSAPI.OpenView("GoodsFullInfo",{data=itemData});
        else
            LogError("无法找到配置中的物品信息："..table.tostring(info))
        end
    end
end

function OnClickOnce()
    -- if true then
    --    local ret= {
    --         ["drawArr"]=
    --         {
    --             [1]=19
    --         },
    --         ["drawRound"]=1,
    --         ["info"]=
    --         {
    --             ["drawArr"]=
    --             {
    --                 [1]=19
    --             },
    --             ["startTime"]=1740733438,
    --             ["id"]=1004,
    --             ["drawTimes"]=1,
    --             ["round"]=1
    --         }
    --     }
    --     OnDrawRet(ret)
    --     do return end
    -- end
    OnDraw()
end

function OnClickMux()
    if pool then
        OnDraw(true)
    end
end

function OnDraw(isMux)
    if pool then
        if isOver then
            Tips.ShowTips(LanguageMgr:GetTips(38005));
            do
                return
            end
        end
        local num=isMux and pool:GetMaxCostNum() or 1;
        if pool:GetExtractType()==ItemPoolExtractType.ControlNotInfinite or pool:GetExtractType()==ItemPoolExtractType.Control then
            local num2=pool:GetCountMax();--最终奖品保底次数
            local num3=pool:GetDrawCount()+num;
            if (num3>num2 or (isMux and num3>num2)) then --连抽次数大于剩余奖品数
                Tips.ShowTips(LanguageMgr:GetTips(38007));
                do
                    return
                end
            end
        end
        local itemInfo = pool:GetCostGoods();
        if itemInfo then
            local count = BagMgr:GetCount(itemInfo:GetID());
            local jumpId=itemInfo:GetMoneyJumpID();
            if count < num then
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
            RegressionProto:ItemPoolDraw(pool:GetID(), num);
        end
    end
end

function OnBagUpdate()
    Refresh();
end

function OnClickClose()
    view:Close();
end

function OnClickReward()
    CSAPI.OpenView("LuckyGachaPoolInfo",pool);
end