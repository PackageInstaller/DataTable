-- 运营活动
OperateActiveProto = {
    SkinRebateInfoCallBack = nil,
}

function OperateActiveProto:GetOperateActive(_id)
    local proto = {"OperateActiveProto:GetOperateActive", {
        id = _id
    }}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetOperateActiveRet(proto)
    for k, v in pairs(proto.operateActiveList) do
        if (v.id == eOperateType.RechargeSign) then -- 累充签到
            ActivityMgr:SetOperateActive(v.id, v)
            MenuBuyMgr:ConditionCheck4(6, v)         --累充6
        elseif (v.id == eOperateType.PayNotice7) then -- 累充7
            MenuBuyMgr:ConditionCheck4(7, v)
        elseif (v.id == eOperateType.PayNotice8) then -- 累充8
            MenuBuyMgr:ConditionCheck4(8, v)
        elseif (v.id == eOperateType.PayNotice1) then -- 累充1
            MenuBuyMgr:ConditionCheck4(1, v)
        end
    end
    EventMgr.Dispatch(EventType.MenuBuy_RechargeCB)
end

function OperateActiveProto:GetActiveTimeList()
    local proto = {"OperateActiveProto:GetActiveTimeList", {}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetActiveTimeListRet(proto)
    ActivityMgr:UpdateDatas(proto)
end

--获取皮肤返利特权卡数据
function OperateActiveProto:GetSkinRebateInfo(skinId)
    local proto = {"OperateActiveProto:GetSkinRebateInfo", {skinId = skinId}}
    NetMgr.net:Send(proto);
end

--获取皮肤返利特权卡数据返回
function OperateActiveProto:GetSkinRebateInfoRet(proto)
    OperationActivityMgr:SetSkinRebateInfos(proto)
end

function OperateActiveProto:DragonBoatFestivalRefuel(id,type)
    local proto = {"OperateActiveProto:DragonBoatFestivalRefuel", {id = id,type = type}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetDragonBoatFestivalInfo()
    local proto = {"OperateActiveProto:GetDragonBoatFestivalInfo", {}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetDragonBoatFestivalInfoRet(proto)
    OperationActivityMgr:SetDuanWuInfos(proto)
end

function OperateActiveProto:GetMaidCoffeeData(_id,_cb)
    self.GetMaidCoffeeDataCB = _cb
    local proto = {"OperateActiveProto:GetMaidCoffeeData", {id = _id}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetMaidCoffeeDataRet(proto)
    CoffeeMgr:GetMaidCoffeeDataRet(proto)
    if(self.GetMaidCoffeeDataCB )then 
        self.GetMaidCoffeeDataCB()
    end 
    self.GetMaidCoffeeDataCB = nil 
end

function OperateActiveProto:GetMaidCoffeeReward(_id,_gameData)
    _gameData.id = _id 
    local proto = {"OperateActiveProto:GetMaidCoffeeReward", _gameData}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:GetMaidCoffeeRewardRet(proto)
    CoffeeMgr:GetMaidCoffeeDataRet(proto)
    EventMgr.Dispatch(EventType.Menu_Coffee)
end

--获取猜谜活动信息
function OperateActiveProto:GetQuestionInfo(id)
    local proto = {"OperateActiveProto:GetQuestionInfo", {id = id}}
    NetMgr.net:Send(proto);
end

--猜谜活动数据返回
function OperateActiveProto:GetQuestionInfoRet(proto)
    RiddleMgr:Update(proto);
    EventMgr.Dispatch(EventType.Riddle_Data_Ret,proto)
end

--猜谜答题
function OperateActiveProto:AnswerQuestion(id,drawnQuestions,answerIdx)
    local proto = {"OperateActiveProto:AnswerQuestion", {id = id,drawnQuestions=drawnQuestions,answerIndex=answerIdx}}
    NetMgr.net:Send(proto);
end

--猜谜答题返回
function OperateActiveProto:AnswerQuestionRet(proto)
    RiddleMgr:UpdataAnswer(proto);
    EventMgr.Dispatch(EventType.Riddle_Draw_Ret,proto)
end

--猜谜领取奖励
function OperateActiveProto:TakeQuestionReward(id,index)
    local proto = {"OperateActiveProto:TakeQuestionReward", {id = id,index=index}}
    NetMgr.net:Send(proto);
end

--猜谜领取奖励返回
function OperateActiveProto:TakeQuestionRewardRet(proto)
    RiddleMgr:UpdateRewards(proto)
    EventMgr.Dispatch(EventType.Riddle_Reward_Ret,proto)
end

--限量奖励活动 获取信息
function OperateActiveProto:GetLimitRewardInfo(id,callback)
    local proto = {"OperateActiveProto:GetLimitRewardInfo",{id = id}}
    NetMgr.net:Send(proto);
end

--限量奖励活动 获取信息返回
function OperateActiveProto:GetLimitRewardInfoRet(proto)
    EventMgr.Dispatch(EventType.Mission_Limit_Update,proto)
end

--限量奖励活动 确认领取关闭弹窗
function OperateActiveProto:LimitRewardCloseWindow(callback)
    self.limitRewardCloseWindowCallBack = callback
    local proto = {"OperateActiveProto:LimitRewardCloseWindow"}
    NetMgr.net:Send(proto);
end

--限量奖励活动 确认领取关闭弹窗返回
function OperateActiveProto:LimitRewardCloseWindowRet(proto)
    if self.limitRewardCloseWindowCallBack then
        self.limitRewardCloseWindowCallBack(proto)
        self.limitRewardCloseWindowCallBack = nil
    end
end

--限量奖励活动 显示兑换码
function OperateActiveProto:LimitRewardShowCode(id)
    local proto = {"OperateActiveProto:LimitRewardShowCode",{id = id}}
    NetMgr.net:Send(proto);
end

--限量奖励活动 显示兑换码返回
function OperateActiveProto:LimitRewardShowCodeRet(proto)
    UIUtil:OpenMissionLimitTips(proto)
end

--触发礼包
function OperateActiveProto:GetPopupPackInfo(isLogin)
    self.GetPopupPackInfoIsMy = isLogin
    local proto = {"OperateActiveProto:GetPopupPackInfo"}
    NetMgr.net:Send(proto)
end
function OperateActiveProto:GetPopupPackInfoRet(proto)
    PopupPackMgr:GetPopupPackInfoRet(proto)
    if(proto.isFinish)then 
        if(not self.GetPopupPackInfoIsMy)then 
            EventMgr.Dispatch(EventType.Menu_PopupPack)
        end 
        self.GetPopupPackInfoIsMy = nil 
    end 
end 

--记录弹出的礼包
function OperateActiveProto:UpdatePopupTime(_cfgids,_cb)
    self.UpdatePopupTimeCB = _cb
    local proto = {"OperateActiveProto:UpdatePopupTime",{cfgids = _cfgids}}
    NetMgr.net:Send(proto)
end
function OperateActiveProto:UpdatePopupTimeRet(proto)
    PopupPackMgr:UpdatePopupTimeRet(proto)
    if(self.UpdatePopupTimeCB)then 
        self.UpdatePopupTimeCB()
    end 
    self.UpdatePopupTimeCB = nil
end 

--请求万圣节游戏数据
function OperateActiveProto:GetHalloweenGameData()
    local proto = {"OperateActiveProto:GetHalloweenGameData"}
    NetMgr.net:Send(proto)
end

--请求万圣节游戏数据返回
function OperateActiveProto:GetHalloweenGameDataRet(proto)
    HalloweenMgr:SetDatas(proto)
end

--万圣节游戏请求领取奖励
function OperateActiveProto:GetHalloweenGameReward(data)
    local proto = {"OperateActiveProto:GetHalloweenGameReward",data}
    NetMgr.net:Send(proto)
end

--万圣节游戏请求领取奖励返回
function OperateActiveProto:GetHalloweenGameRewardRet(proto)
    HalloweenMgr:SetDatas(proto)
end

--圣诞活动
function OperateActiveProto:GetChristmasGiftData(_cb)
    self.GetChristmasGiftDataCB = _cb
    local _id = MerryChristmasMgr:GetID()
    local proto = {"OperateActiveProto:GetChristmasGiftData",{id = _id}}
    NetMgr.net:Send(proto)
    --self:GetChristmasGiftDataRet({id = _id,cnt=1,remainCnt=5,maxScore = 0})
end
function OperateActiveProto:GetChristmasGiftDataRet(proto)
    MerryChristmasMgr:GetChristmasGiftDataRet(proto)
    if(self.GetChristmasGiftDataCB)then 
        self.GetChristmasGiftDataCB()
    end 
    self.GetChristmasGiftDataCB = nil
end
function OperateActiveProto:GetChristmasGiftReward(_data,_cb)
    self.GetChristmasGiftRewardCB = _cb
    local proto = {"OperateActiveProto:GetChristmasGiftReward",_data}
    NetMgr.net:Send(proto)
end
function OperateActiveProto:GetChristmasGiftRewardRet(proto)
    MerryChristmasMgr:GetChristmasGiftDataRet(proto)
    if(self.GetChristmasGiftRewardCB)then 
        self.GetChristmasGiftRewardCB()
    end 
    self.GetChristmasGiftRewardCB = nil 
    EventMgr.Dispatch(EventType.Menu_Christmas)
end

--获取活动数据
function OperateActiveProto:GetRichManData()
    local proto = {"OperateActiveProto:GetRichManData"}
    NetMgr.net:Send(proto)
end

--获取活动数据返回
function OperateActiveProto:GetRichManDataRet(proto)
    RichManMgr:SetData(proto);
end

--请求投掷
function OperateActiveProto:RichManThrow(isAuto,point)
    local proto = {"OperateActiveProto:RichManThrow",{isAuto=isAuto,point=point}}
    NetMgr.net:Send(proto)
end

--投掷返回
function OperateActiveProto:RichManThrowRet(proto)
    local isFixed=proto and proto.isFixed or false;
    EventMgr.Dispatch(EventType.RichMan_Throw_Ret,isFixed)
    RichManMgr:OnThrowRet(proto);
end

--请求投掷
function OperateActiveProto:RichManStopAutoThrow()
    local proto = {"OperateActiveProto:RichManStopAutoThrow"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:RichManStopAutoThrowRet(proto)
    if proto and proto.rewards then
        EventMgr.Dispatch(EventType.RichMan_AutoThrow_Reward,proto.rewards);
    end
end

function OperateActiveProto:NoticePhysicalReward(proto)
    PhysicalRewardMgr:NoticePhysicalReward(proto)
end

function OperateActiveProto:PhysicalRewardInfo(_cb)
    self.PhysicalRewardInfoCB = _cb
    local proto = {"OperateActiveProto:PhysicalRewardInfo"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:PhysicalRewardInfoRet(proto)
    PhysicalRewardMgr:PhysicalRewardInfoRet(proto)
    if(self.PhysicalRewardInfoCB)then 
        self.PhysicalRewardInfoCB()
    end 
    self.PhysicalRewardInfoCB = nil 
end

--推送的小额付费活动返回
function OperateActiveProto:LittlePayActiveDataRet(proto)
    CumulativeSpendingMgr:Update(proto);
end

--获取皮肤折扣券活动信息
function OperateActiveProto:GetSkinDiscountInfo()
    local proto = {"OperateActiveProto:GetSkinDiscountInfo"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:GetSkinDiscountInfoRet(proto)
    SkinDealsMgr:Update(proto);
	EventMgr.Dispatch(EventType.SkinDeals_Update)
end

--获取皮肤折扣券每日奖励
function OperateActiveProto:GetSkinDiscountDaily()
    local proto = {"OperateActiveProto:GetSkinDiscountDaily"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:GetSkinDiscountDailyRet(proto)
    SkinDealsMgr:OnRevice(proto)
	EventMgr.Dispatch(EventType.SkinDeals_Update)
end

function OperateActiveProto:GetBreakfastCardData()
    local proto = {"OperateActiveProto:GetBreakfastCardData"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:BreakfastCardDataRet(proto)
    OperationActivityMgr:SetBCInfo(proto)
end

function OperateActiveProto:GoldenRebateDataRet(proto)
    GoldenRebateMgr:Update(proto)
end

--获取旧皮肤返利活动信息
function OperateActiveProto:GetOldSkinRebateInfo()
    local proto = {"OperateActiveProto:GetOldSkinRebateInfo"}
    NetMgr.net:Send(proto)
end

function OperateActiveProto:GetOldSkinRebateInfoRet(proto)
    OperationActivityMgr:SetOldSkinRebateDatas(proto)
end

function OperateActiveProto:GetOldSkinRebateReward(shopId)
    local proto = {"OperateActiveProto:GetOldSkinRebateReward",{commodityId = shopId}}
    NetMgr.net:Send(proto)
end