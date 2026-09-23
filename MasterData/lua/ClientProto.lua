ClientProto =
{
    PayQueryAction=nil;
}

-- 签到记录
function ClientProto:GetSignInfo(_id, _index)
    local proto = {"ClientProto:GetSignInfo", {
        id = _id,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

function ClientProto:GetSignInfoRet(proto)
    SignInMgr:GetSignInfoRet(proto)
end

-- 签到
function ClientProto:AddSign(_id,_index)
    local proto = {"ClientProto:AddSign", {
        id = _id,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

function ClientProto:AddSignRet(proto)
    SignInMgr:AddSignRet(proto)
end

-- 兑换码
function ClientProto:UseExchangeCode(_code)
    local proto = {"ClientProto:UseExchangeCode", {
        code = _code
    }}
    NetMgr.net:Send(proto)
end

function ClientProto:UseExchangeCodeRet(proto)
    if (proto.is_ok) then
        -- local dialogData = {}
        -- dialogData.content = StringTips.Activity_tips3
        -- CSAPI.OpenView("Dialog", dialogdata)
        Tips.ShowTips(StringTips.Activity_tips3)
    end
end

-- --刷新活动跳转(有活动更新时，服务器主动推送)
-- function ClientProto:FlushActiveSkip()
-- 	ActivityMgr:Init()
-- end
-- 活动公告更新
function ClientProto:BackstageChagne(proto)
    ActivityMgr:InitData(proto.type)
end

-- 获取关卡奖励领取信息
function ClientProto:DupSumStarRewardInfo(starRewardIDs)
    -- self.dupSumStarRewardInfoFunc = func;
    local ids = starRewardIDs or {}
    local proto = {"ClientProto:DupSumStarRewardInfo", ids}
    NetMgr.net:Send(proto)
end

-- 获取关卡奖励领取信息返回
function ClientProto:DupSumStarRewardInfoRet(proto)
    DungeonBoxMgr:SetDatas(proto)
    -- if self.dupSumStarRewardInfoFunc then
    -- 	self.dupSumStarRewardInfoFunc(proto);
    -- end
end

-- 领取关卡宝箱
function ClientProto:GetDupSumStarReward(datas)
    -- self.dupSumStarRewardFunc = func;
    local proto = {"ClientProto:GetDupSumStarReward", {
        infos = datas
    }}
    NetMgr.net:Send(proto)
end

-- --领取关卡宝箱返回
-- function ClientProto:GetDupSumStarRewardRet(proto)
-- 	if self.dupSumStarRewardFunc then
-- 		self.dupSumStarRewardFunc(proto);
-- 	end
-- end
-- 设置副本使用物品
function ClientProto:SetDupUseItem(dungeonId, index, isUse, func)
    self.dupUseItemFunc = func;
    local proto = nil;
    if index then
        proto = {"ClientProto:SetDupUseItem", {
            id = dungeonId,
            index = index,
            is_open = isUse
        }}
    else
        proto = {"ClientProto:SetDupUseItem", {
            id = dungeonId,
            is_open = isUse
        }}
    end
    NetMgr.net:Send(proto)
end

-- 设置副本物品返回
function ClientProto:SetDupUseItemRet(proto)
    if self.dupUseItemFunc then
        self.dupUseItemFunc(proto);
    end
end

-- 全局弹奖励
function ClientProto:RewardNotice(proto)
    if (proto and proto.rewards and #proto.rewards > 0) then
        if (self._rewards == nil) then
            self._rewards = proto.rewards
        else
            for i, v in pairs(proto.rewards) do
                table.insert(self._rewards, v)
            end
        end
        if (proto.is_finish) then
            local rewards = {}
            rewards = self._rewards
            UIUtil:OpenReward({rewards})
            self._rewards = nil
        end
    end
end

-- 实名验证（防沉迷）
function ClientProto:SetAntiAdiction(name, number,pi)
    if name and number then
        NetMgr.net:Send({"ClientProto:SetAntiAdiction", {
            name = name,
            number = number,
            pi=pi,
        }})
    end
end

-- 实名验证返回
function ClientProto:SetAntiAdictionRet(proto)
    EventMgr.Dispatch(EventType.Authentication_Result, proto);
end

-- 实名验证更新
function ClientProto:AnitiAdictionUpdate(proto)
    EventMgr.Dispatch(EventType.Authentication_Update, proto);
end

-- 客户端初始化完成
function ClientProto:InitFinish(isReconnect,immediately)
    self.isReconnect = isReconnect;
    if(immediately)then
        self:SendInitFinish();
    else
        FuncUtil:Call(self.SendInitFinish, self, 3000);
    end
end

function ClientProto:InitFinishRet(proto)
    self.finishRet = true;
    self.isReconnect = nil;

    --服务器压力大，延迟到这里请求
    DormMgr:RequestDormProtoServerData();--先不请求试试看
    -- EquipProto:GetEquips();--装备改动到进入主界面开始获取
    CollaborationMgr:InitData();--初始化回归绑定活动
    ActivityMgr:CheckRedPointData() --用于活动
    RegressionMgr:CheckRedPointData() -- 回归活动
    EquipProto:EquipRefreshGetLastData();--获取最后一次洗炼的数据
    RiddleMgr:InitData();--初始化猜谜活动
    RichManMgr:InitData();--初始化大富翁活动
    EventMgr.Dispatch(EventType.InitFinishRet)
end
---中途打断清理数据
function ClientProto:ClearLoginData()
    self.finishRet = false;
end
-- 未收到InitFinishRet前每隔几秒发一次直到成功为止
function ClientProto:SendInitFinish()
    if self.finishRet then
        LogWarning("结束发送");
        EventMgr.Dispatch(EventType.Client_Init_Finish);
        self.finishRet = false;
    else
        LogWarning("正在疯狂发送协议");
        NetMgr.net:Send({"ClientProto:InitFinish", {
            is_reconnect = self.isReconnect
        }})
        FuncUtil:Call(self.SendInitFinish, self, 3000);
    end
end

-- 换线
function ClientProto:ChangeLine(proto)
    if (GuideMgr:IsGuiding()) then -- 新手引导中、网络中断会导致卡住
        return;
    end
    -- 如果在主界面则直接切线不用延迟
    local scene = SceneMgr:GetCurrScene()
    if (scene.type and scene.type ~= 2 and not FightClient:IsFightting()) then
        ReloginAccount()
        ExerciseMgr.delay = nil;
--    else
--        if (not proto.delay) then
--            ReloginAccount()
--        end
--        ExerciseMgr.delay = proto.delay -- 是否延迟切线
    else
        PlayerClient:SetChangeLine(true);
    end
end

function ClientProto:DelayChangeLine()
    if (ExerciseMgr.delay) then
        ReloginAccount()
    end
    ExerciseMgr.delay = nil
end

-- 下线
function ClientProto:Offline(callBack)
    NetMgr.net:Send({"ClientProto:Offline"})
end

function ClientProto:OfflineRet()
end

-- 兑换
function ClientProto:ExchangeItem(_exchanges, cb,_card_pool_id,_type)
    self.ExchangeItemCB = cb
    NetMgr.net:Send({"ClientProto:ExchangeItem", {
        exchanges = _exchanges,
        card_pool_id = _card_pool_id,
        ty=_type,
    }})
end
function ClientProto:ExchangeItemRet(proto)
    if (self.ExchangeItemCB) then
        self.ExchangeItemCB(proto)
    end
    self.ExchangeItemCB = nil
end

function ClientProto:GetMemberRewardInfo()
    NetMgr.net:Send({"ClientProto:GetMemberRewardInfo"})
end

function ClientProto:GetMemberRewardInfoRet(proto)
    if proto then
        ShopMgr:UpdateMonthCard(proto);
        EventMgr.Dispatch(EventType.Shop_MemberCard_Ret, proto.infos)
    end
end

-- {id,type,nBegTime,nEndTime} -type:1.战场
function ClientProto:ActiveOpen(proto)
    -- Log("ClientProto:ActiveOpen")
    -- Log(proto);
    if proto then
        DungeonMgr:AddActivityOpenInfo(proto)
        if not proto.isFromLogin then --不是登录时更新
            ActivityMgr:RefreshOpenState()
            EventMgr.Dispatch(EventType.CfgActiveEntry_Change)
        end
    end
end

--服务器修改表字段
function ClientProto:DySetCfgNotice(proto)
    GCalHelp:DyModifyCfgs(proto.infos)
    for k, v in pairs(proto.infos) do
        if(v.name=="global_setting" and (v.row_id=="g_ZilongWebBtnOpen" or v.row_id=="g_ZilongWebBtnClose" or v.row_id=="g_ZilongWebBtnLv")) then
            EventMgr.Dispatch(EventType.Menu_WebView_Enabled) --主界面的问卷调查
        end
        if (v.name == "CfgActiveEntry") then
            EventMgr.Dispatch(EventType.CfgActiveEntry_Change) --活动表动态更改
        end
    end
end


---1055 后台通知
function ClientProto:PlrNotice(proto)
    if proto["notice"]["type"] then
        if proto["notice"]["type"]=="points" then
            ---proto["notice"]["value"]
            ---  Log("解析成功")
            AdvDeductionvoucher.QueryPoints(function()
                CSAPI.DispatchEvent(EventType.Shop_View_Refresh)
            end)
        end
    end


end

---查询回调
--ClientProto.PayQueryAction=nil;
---1056 支付查询（发起生成订单之前发送）
function ClientProto:QueryPrePay(ShopproductId,amountVave,action)
    self.PayQueryAction=nil;
    if ShopproductId and amountVave then
        self.PayQueryAction=action;
        local proto = {"ClientProto:QueryPrePay", { productId = tonumber(ShopproductId),amount=tonumber(amountVave), }}
        NetMgr.net:Send(proto)
    else
        LogError("ClientProto:PayQuery --ShopproductId:"..tostring(ShopproductId))
    end
end
---1057 支付查询（返回后才发起创建订单，失败返回提示）
function ClientProto:QueryPrePayRet(proto)
    if proto then
        if self.PayQueryAction~=nil then self.PayQueryAction(proto); self.PayQueryAction=nil end
    else
        LogError("ClientProto:PayQueryRet",table.tostring(proto,true))
    end
end