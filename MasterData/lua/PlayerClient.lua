local this = {
    oldLv = 1, -- 缓存等级
    oldExp = 0 -- 缓存经验
};

function this:SetInfo(proto)
    self.data = proto
    self.info = proto.infos;
    self.can_modify_name = proto.can_modify_name;
    -- self:SetPanelId(proto.panel_id)
    -- self:SetIconId(proto.icon_id)
    self.add_exp = proto.add_exp or 0
    self.add_cost = 0; -- cost值上限buff
    self.add_gold = 0; -- 金币上限buff
    self.icon_frame = proto.icon_frame --头像框id
end

function this:UpdateInfo(proto)
    -- 玩家获得经验
    if (proto.add_exp and proto.add_exp > 0) then
        self.oldLv = self:GetLv()
        self.oldExp = self:GetExp()
        self.add_exp = proto.add_exp
    end
    if (self.info) then
        for i, v in pairs(proto.infos) do
            self.info[i] = v
        end
    end
    if (proto.t_hot) then
        self.data.t_hot = proto.t_hot
        EventMgr.Dispatch(EventType.Player_HotChange) -- 推送体能刷新
    end
    if(self.oldLv~=nil and self.oldLv~=self:GetLv())then 
        MenuMgr:UpdateDatas() --刷新关卡解锁状态
    end
    EventMgr.Dispatch(EventType.Player_Update)
end

function this:GetID()
    local uid = 0
    if LoginProto and LoginProto.vosQueryAccount then
        uid = LoginProto.vosQueryAccount.uid
    end
    return uid;
end

-- 设置名称
function this:SetName(_name)
    self.info.name = _name;
end

function this:GetUid()
    return self.info and self.info.uid or nil
end
function this:Clearuid()
    if self.info and self.info.uid then
        self.info.uid=nil;
    end
end
-- 名称
function this:GetName()
    return self.info and self.info.name or nil
end
-- 等级
function this:GetLv()
    return self.info and self.info.level or 1
end
-- 经验
function this:GetExp()
    return self.info and self.info.exp or 0
end

-- 世间boss tp值
function this:GetTP(newTP)
    if (newTP) then
        self.info.tp = newTP
    end
    return self.info and self.info.tp or 0
end
-- 世界boss tp值不足时的开始计算时间
function this:GetTPBeginTime(newTime)
    if (newTime) then
        self.info.tpBeginTime = newTime
    end
    return self.info and self.info.tpBeginTime or 0
end

-- 角色添加经验
function this:GetAddExp(value)
    if (value ~= nil) then
        self.add_exp = value
    end
    return self.add_exp or 0
end

-- 创建时间
function this:GetCreateTime()
    return self.info and self.info.create_time or 0;
end

-- 返回下一级需要的经验
function this:GetNextExp()
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(PlayerClient:GetLv());
    if cfg then
        return cfg.nNextExp;
    end
    return 0;
end

-- 返回Cost值
function this:GetCost()
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(PlayerClient:GetLv());
    local addCost = self.add_cost or 0;
    if cfg then
        return math.floor(cfg.nCostVal + addCost);
    end
    return math.floor(g_TeamMaxCost + addCost);
end

-- 返回最大等级
function this:GetMaxLv()
    return g_PlayerLvMax;
end

function this:SetModifyName(canDo)
    canDo = canDo == nil and false or true;
    self.can_modify_name = canDo;
end

-- 是否需要改名（第一次登录时的改名判定）
function this:GetModifyName()
    return self.can_modify_name == nil and 1 or self.can_modify_name;
end

-- 签名
function this:GetSign()
    return self.info and self.info.sign or ""
end

function this:SetSex(ix)
    if self.data then
        self.data.sel_card_ix = ix;
    else
        self.data = {};
        self.data.sel_card_ix = ix;
    end
end

-- 性别
function this:GetSex()
    return self.data and self.data.sel_card_ix or 1;
end

-- 修改签名
function this:SetSign(_sign)
    if (self.info) then
        self.info.sign = _sign
    end
end

-- -- 看板角色
-- function this:GetCRoleId()
--     return self.role_id
-- end
-- function this:SetCRoleId(_role_id)
--     self.role_id = _role_id
-- end

-- 头像id(头像表id或模型表id)
function this:GetIconId()
    return self.data.icon_id
end
--选择男女主后会返回一次
function this:SetIconId(_icon_id)
    self.data.icon_id = _icon_id
end

--返回头像框初始化需要结构体
function this:GetHeadFrameInfo()
    return {
        uid=self:GetUid(),
        name=self:GetName(),
        lv=self:GetLv(),
        icon_id=self:GetIconId(),
        icon_frame=self:GetHeadFrame();
        sel_card_ix=self:GetSex();
    }
end

-- 看板id（）
function this:GetPanelId()
    return self.data.panel_id
end
function this:SetPanelId(_panel_id)
    self.data.panel_id = _panel_id
end

--头像框id
function this:GetHeadFrame()
    return self.icon_frame or 1
end
function this:SetHeadFrame(icon_frame)
    self.icon_frame = icon_frame or 1
end

-- -- 看板是角色(不在头像表，那就是角色头像)
-- function this:KBIsRole()
--     local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(self.data.panel_id)
--     return cfg==nil 
-- end

-- 队长模型表id
function this:GetModelId()
    return self.data.sel_card_ix == 1 and 7101001 or 7102001
end

-- 队长方框头像
function this:GetIconName()
    local cfg = Cfgs.character:GetByID(self:GetModelId())
    return cfg and cfg.icon
end

function this:SetLifeBuff(buffs)
    self.buffs = {};
    if buffs then
        for k, v in pairs(buffs) do
            local cfg = Cfgs.CfgLifeBuffer:GetByID(v.id);
            if cfg then
                if cfg.nType == 21 then
                    self.add_cost = v.val;
                elseif cfg.nType == 25 then
                    self:SetMaxGold(v.val)
                end
                self.buffs[v.id] = v;
            end
        end
    end
end

function this:UpdateLifeBuff(buffs)
    if buffs then
        self.buffs = self.buffs or {};
        for k, v in pairs(buffs) do
            local cfg = Cfgs.CfgLifeBuffer:GetByID(v.id);
            if cfg then
                self.buffs[v.id] = v;
                if cfg.nType == 21 then
                    self.add_cost = v.val;
                elseif cfg.nType == 25 then
                    self:SetMaxGold(v.val)
                end
            end
        end
    end
end

function this:RemoveLifeBuff(ids)
    if ids and self.buffs then
        for k, v in ipairs(ids) do
            self.buffs[v] = nil;
            -- local cfg=Cfgs.CfgLifeBuffer:GetByID(v.id);
            local cfg = Cfgs.CfgLifeBuffer:GetByID(v);
            if cfg then
                if cfg.nType == 21 then
                    self.add_cost = 0;
                elseif cfg.nType == 25 then
                    self:SetMaxGold(0)
                end
            end
        end
    end
end

function this:SetMaxGold(num)
    self.add_gold = num
    -- 金币存储上限可能改变
    EventMgr.Dispatch(EventType.Bag_Update)
end

-- 返回生活BUFF
function this:GetLifeBuff()
    local arr = nil;
    if self.buffs then
        arr = {};
        for k, v in pairs(self.buffs) do
            table.insert(arr, v);
        end
        table.sort(arr, function(a, b)
            return a.id < b.id;
        end);
    end
    return arr;
end

-- 当前金币上限
function this:GetGoldMax()
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(self:GetLv())
    if (cfg) then
        return math.floor(cfg.nGoldStorageLimit + self.add_gold) or 0
    else
        return 0
    end
end

-- 获取金币
function this:GetGold()
    return self.info and self.info.gold or 0
end

-- 获取钻石
function this:GetDiamond()
    return self.info and self.info.diamond or 0
end
---获取充值获得的钻石 数量
function this:GetFreeDiamond()
     return self.info and self.info.diamond_pay or 0
end
-- ==============================--
-- desc:更新货币
-- time:2019-09-17 10:47:21
-- @id:
-- @num:
-- @return 
-- ==============================--
function this:UpdateCoin(id, num)
    if (id == ITEM_ID.GOLD) then
        self.info.gold = num <= 0 and 0 or num
        EventMgr.Dispatch(EventType.Update_Coin) -- 更新了货币 
    elseif (id == ITEM_ID.DIAMOND) then
        -- self.info.diamond = num <= 0 and 0 or num
        self.info.diamond = num or 0;
        if CSAPI.IsADV() or CSAPI.IsDomestic() then ShiryuSDK.OnRoleInfoUpdate(); end
    elseif (id == g_ArmyCoinId) then
        self.info.army_coin = num <= 0 and 0 or num
    elseif (id == g_AbilityCoinId) then
        self.data = self.data or {}
        self.data.ability_num = num <= 0 and 0 or num
    elseif (id == ITEM_ID.BIND_DIAMOND) then
        self.data.BIND_DIAMOND = num <= 0 and 0 or num
    elseif (id == ITEM_ID.POWER_CEILING) then
        self.data.POWER_CEILING = num <= 0 and 0 or num
    elseif (id == ITEM_ID.DIAMOND_PAY) then
        self.info.diamond_pay = num or 0;
    end
end

-- ==============================--
-- desc:获取货币数量
-- time:2019-09-17 10:52:11
-- @id:
-- @return 
-- ==============================--
function this:GetCoin(id)
    if (id == ITEM_ID.GOLD) then
        return self.info.gold or 0
    elseif (id == ITEM_ID.DIAMOND) then
        return self.info.diamond or 0
    elseif (id == g_ArmyCoinId) then
        return self.info.army_coin or 0
    elseif (id == g_AbilityCoinId) then
        return self.data.ability_num or 0
    elseif (id == 10003) then -- 经验池经验
        return RoleMgr:GetStoreExp() or 0
    elseif (id == 10035) then -- 经验池经验
        return self:Hot() or 0
    elseif (id == ITEM_ID.BIND_DIAMOND) then
        return self.data.BIND_DIAMOND or 0
    elseif (id == ITEM_ID.POWER_CEILING) then
        return self.data.POWER_CEILING or 0
    elseif (id == 10999) then
        return AdvDeductionvoucher.SDKvoucherNum or 0
    elseif (id == ITEM_ID.DIAMOND_PAY) then
        return self.info.diamond_pay or 0
    end
    return 0
end

-- 背景
-- function this:GetBG()
--     -- local _data = FileUtil.LoadByPath("bgNew.txt")
--     -- local id = 1
--     -- if (_data and _data.id) then
--     --     id = _data.id
--     -- end
--     -- return id
--     return self.data.background_id or 1
-- end

-- function this:SetBG(_id)
--     -- FileUtil.SaveToFile("bgNew.txt", {
--     --     id = _id
--     -- })
--     self.data.background_id = _id 
-- end

function this:GetNewPlayerFightStateKey()
    return "new_player_fight_state";
end

-- 进入游戏
function this:EnterGame()
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        ShiryuSDK.OnLoginServer();
    end
    -- 测试用
    if (_G.enter_last_dirll_fight) then
        FuncUtil:Call(function()
            CreateDirllFight(PlayerPrefs.GetInt("key_for_dirll_fight_1"), PlayerPrefs.GetInt("key_for_dirll_fight_2"));
        end, nil, 1000);
        return;
    end

    if (self:IsPassNewPlayerFight()) then
        -- LogError("进入主界面");
        self:EnterMajor();
        return;
    end

    self.canEnter = 1;
    self:DoEnter();
end
-- 新手特殊战斗场数
function this:GetNewPlayerFightCount()
    return 2;
end
function this:IsPassNewPlayerFight()
    local playerLv = self:GetLv();
    if (playerLv and playerLv > 1) then
        return true;
    end

    local state = PlayerPrefs.GetInt(self:GetNewPlayerFightStateKey() .. "_" .. self:GetID());
    -- LogError(self:GetNewPlayerFightStateKey() .. "_" .. self:GetID() .. ":"  .. tostring(state));
    return state and state > self:GetNewPlayerFightCount();
end
function this:OpenSummon()
    return self.openSummon;
end
function this:SetOpenSummon()
    self.openSummon = 1;
end

function this:SwitchEnter()
    self.switchState = 1;
    self:DoEnter();
end

-- 根据玩家数据选择进入
function this:DoEnter()
    if (not self.switchState or not self.canEnter) then
        return;
    end

    PlayerProto:GetClientData(self:GetNewPlayerFightStateKey()); -- 尝试进入新手战斗  
end

-- 播放op
function this:PlayOP(callBack, caller)
    return false;

    -- 暂不播放开场白
    --    local state = PlayerPrefs.GetInt(self:GetPlayOPKey());
    --    if (state and state > 0) then
    --        return false;
    --    else
    --        UIUtil:RemoveLoginMovie(); -- 移除登录视频
    --        CSAPI.OpenView("VideoPlayer", {
    --            videoName = "op",
    --            callBack = callBack,
    --            caller = caller
    --        });
    --        PlayerPrefs.SetInt(self:GetPlayOPKey(), 1)
    --    end

    --    return true;
end

function this:GetPlayOPKey()
    return "video_op_" .. self:GetID();
end

function this:EnterDefaultFight()
    FightClient:SetPlaySpeed(1);
    FightClient:SetAutoFight(false);
    FightClient:SetNextFightExitState(false);
    DungeonMgr:ApplyEnterByDefault(1001);
end

function this:EnterMajor()
    --   关闭战斗场景镜头
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if (xluaCamera) then
        xluaCamera.SetEnable(false);
    end
    -- 进入主城
    EventMgr.Dispatch(EventType.Scene_Load, "MajorCity");
end

function this:HasNextNewPlayerFight()
    local index = self.newPlayerFightIndex or 0;
    index = index + 1;

    -- LogError("newPlayerFightIndex" .. tostring(self.newPlayerFightIndex));
    if (index > self:GetNewPlayerFightCount()) then
        return false;
    end

    return true;
end

function this:ApplyNextNewPlayerFight()
    local index = self.newPlayerFightIndex or 0;
    index = index + 1;

    if (index > self:GetNewPlayerFightCount()) then
        return false;
    end

    self:NewPlayerFight(index);
    return true;
end

function this:GetNewPlayerFightIDs(index)
    index = index or self.newPlayerFightIndex;
    local fightGroupIDs = g_new_player_fight_group_ids;
    if (index == 1) then
        fightGroupIDs = g_new_player_fight_group_ids1;
        --    elseif(index == 2)then
        --        fightGroupIDs = g_new_player_fight_group_ids2;
    end

    return fightGroupIDs;
end

function this:NewPlayerFight(newPlayerFightIndex)
    newPlayerFightIndex = newPlayerFightIndex or 2;
    newPlayerFightIndex = math.max(2, newPlayerFightIndex);
    self.newPlayerFightIndex = newPlayerFightIndex;
    FightClient.NewPlayerDrasu=true;
    -- LogError("新手战斗" .. newPlayerFightIndex);
    -- 新手强制战斗
    local fightGroupIDs = self:GetNewPlayerFightIDs(newPlayerFightIndex);

    if (fightGroupIDs and #fightGroupIDs >= 2) then

        FightClient:SetNewPlayerFight(true);
        FightClient:SetPlaySpeed(1);
        local newPlayerFightGroupId = PlayerClient:GetSex() ~= 1 and fightGroupIDs[1] or fightGroupIDs[3];
        -- LogError(PlayerClient:GetSex() .. "__" .. tostring(newPlayerFightGroupId));
        CreateSimulateFight(newPlayerFightGroupId, fightGroupIDs[2], function(stage, winer)
            FightClient:SetPlaySpeed(1);
            FightClient:SetAutoFight(false);
            -- LogError("新手战斗结束");		
            local nextNewPlayerFightIndex = (PlayerClient.newPlayerFightIndex or 1) + 1;
            PlayerClient:SetNewPlayerFightStateKey(nextNewPlayerFightIndex);
            if (not PlayerClient:HasNextNewPlayerFight()) then -- 巅峰战斗最后一场新手战斗
                EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "new_player_fight_pass");

            end
            FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, {
                custom_result = 1,
                new_player_fight = 1,
                bIsWin = 1,
                content = ""
            }));
        end);
    else
        LogError("进入新手战斗失败！全局表g_new_player_fight_group_ids设置错误");
        LogError(fightGroupIDs);
    end

end

function this:SetNewPlayerFightStateKey(index)
    PlayerProto:SetClientData(self:GetNewPlayerFightStateKey(), index);
    self:SetLocalNewPlayerFightState(index);
end
function this:SetLocalNewPlayerFightState(index)
    -- LogError("设置：" ..  self:GetNewPlayerFightStateKey() .. "_" .. self:GetID() .. ":" .. index);
    PlayerPrefs.SetInt(self:GetNewPlayerFightStateKey() .. "_" .. self:GetID(), index);
end

-- 设置切线
function this:SetChangeLine(state)
    self.changeLine = state;
end
function this:NeedChangeLine()
    return self.changeLine;
end
function this:ApplyChangeLine()
    if (not self:NeedChangeLine()) then
        return;
    end

    ReloginAccount();
end

-- 注销
function this:Exit()
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        ShiryuSDK.Logout()
    else
        PlayerClient:PlayerClientExitClear()
        PlayerClient:EndGameExitBackLogin()
        --self.canEnter = nil;
        --self.switchState = nil;
        --self.openSummon = nil;
        --self.newPlayerFightIndex = nil;
        --self.sdkInfo = nil;
        --self:SetChangeLine();
        --MgrCenter:Clear()
        --LoginProto:Logout()
        --FightClient:Reset();
        --BattleMgr:SetAIMoveState(false);
        --EventMgr.Dispatch(EventType.Login_Quit, nil, true);
    end
end
---清除本脚本变量
function this:PlayerClientExitClear()
    self.canEnter = nil;
    self.switchState = nil;
    self.openSummon = nil;
    self.newPlayerFightIndex = nil;
    self.sdkInfo = nil;
    self:SetChangeLine();
end
---离开游戏返回登录需要清除的变量
function this:EndGameExitBackLogin()
    MgrCenter:Clear()
    LoginProto:Logout()
    FightClient:Reset();
    BattleMgr:SetAIMoveState(false);
    EventMgr.Dispatch(EventType.Login_Quit, nil, true);
end
---SDK退登返回 调用
function this:SDKExit()
    PlayerClient:PlayerClientExitClear()
    PlayerClient:EndGameExitBackLogin()
end
-- 播放战斗OP
function this:PlayFightOP()
    FightClient.NewPlayerDrasu=false;
    if CSAPI.IsADVRegional(3) then
        ---日服需要播放OP，其它不需要
        --LogError("开始播放剧情战斗动画");
        CSAPI.StopSound();
        CSAPI.SetSoundOff(true);
        CSAPI.DisableInput(1000);
        CSAPI.OpenView("VideoPlayer", {
            videoName = "fight",
            callBack = self.OnFightVedioComplete,
            caller = self
        });
    else
        self:OnFightVedioComplete();
    end
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_FIGHT_FINISH);
    end
end

-- 剧情战斗动画播放完成
function this:OnFightVedioComplete()
    --BuryingPointMgr:BuryingPoint("after_login", 30003);
    if CSAPI.IsADVRegional(3) then
        ---日服需要播放OP，其它不需要
        CSAPI.CloseView("VideoPlayer");
        CSAPI.SetSoundOff(false);
        -- LogError("剧情战斗动画播放完成");
    end
    local fightIds = PlayerClient:GetNewPlayerFightIDs();
    local fightId = fightIds and fightIds[1];
    local cfg = Cfgs.MonsterGroup:GetByID(fightId);

    if (cfg and cfg.storyID2) then
        PlotMgr:TryPlay(cfg.storyID2, self.OnPlotComplete, self, true);
        FuncUtil:Call(EventMgr.Dispatch, nil, 50, EventType.Plot_Close_Delay, 1000);
    else
        self:OnPlotComplete();
    end
end

function this:OnPlotComplete()
    DungeonMgr:Quit(true);
end

function this:IsLog() -- 是否统计信息
    local isLog = true;
    if self.info and self.info.notLog == 1 then
        isLog = false
    end
    return isLog;
end

--------------------------------------体能------------------------------------------
--是否已达上限
function this:IsMaxHot()
    local cur = self:Hot()
    local max1,max2 = self:MaxHot()
    return cur>=max1,cur>=max2
end

-- 自动回复
function this:AddHot()
    self.info.hot = self.info.hot + 1
end

-- 当前体能
function this:Hot(hot)
    if (hot ~= nil) then
        self.info.hot = hot
    end
    return self.info.hot or 0
end

-- 当前上限，最大上限
function this:MaxHot()
    local cfg = Cfgs.CfgPlrHot:GetByID(self:GetLv())
    return cfg.adds[3], cfg.max
end

-- 下次体能恢复时间s(0表示体能已满)
function this:THot()
    local hot = self:Hot()
    local max1, max2 = self:MaxHot()
    if (hot >= max2) then
        self.data.t_hot = 0
    else
        local cfg = Cfgs.CfgPlrHot:GetByID(self:GetLv())
        local curTime = TimeUtil:GetTime()
        while self.data.t_hot ~= 0 and self.data.t_hot < curTime do
            self:AddHot()
            if (self.info.hot >= max1) then
                self.data.t_hot = self.data.t_hot + cfg.adds1[2]
            else
                self.data.t_hot = self.data.t_hot + cfg.adds[2]
            end
            if (self.info.hot >= max2) then
                self.data.t_hot = 0
            end
        end
    end
    return self.data.t_hot
end

-- 体能恢复上限时间s(0表示体能已满)
function this:MaxTHot()
    local hot = self:THot()
    if (hot > 0) then
        local cfg = Cfgs.CfgPlrHot:GetByID(self:GetLv())
        local cur = self:Hot()
        local adds = cur >= cfg.adds[3] and cfg.adds1 or cfg.adds
        local max1, max2 = self:MaxHot()
        local max = cur >= cfg.adds[3] and max2 or max1
        local num = math.ceil((max - cur - 1) / adds[1])
        return num * adds[2] + hot
    end
    return 0
end

-- 当天体能已购买次数（到点也会主动推送更新）,最大购买次数
function this:HotBuyCnt(hot_buy_cnt)
    local cfg = Cfgs.CfgPlrHot:GetByID(self:GetLv())
    if (hot_buy_cnt ~= nil) then
        self.data.hot_buy_cnt = hot_buy_cnt
    end
    local cur = self.data.hot_buy_cnt or 0
    return cur, cfg.dailyBuyLimitCnt
end

-- 当前体能购买花费
function this:GetHotCostCfg()
    local cnt, limit = self:HotBuyCnt()
    local plrCfg = Cfgs.CfgPlrHot:GetByID(PlayerClient:GetLv())
    local costCfg = Cfgs.CfgPlrHotBuyCosts:GetByID(plrCfg.buyCostId)
    return costCfg.infos[(cnt + 1) >= limit and limit or (cnt + 1)]
end

-- 当前登录的游戏账号
function this:GetAccount()
    return LoginProto.account;
end

-- 当前登录的SDK平台用户信息（当前只有B站有，其它渠道暂无）
function this:SetSDKUserInfo(sdkUid, nickName)
    self.sdkInfo = {
        uid = sdkUid,
        name = nickName
    }
end

function this:GetSDKUserInfo()
    return self.sdkInfo;
end

-- 角色累计充值金额
function this:PayRechargeRet(proto)
    --local _c_amount = self.c_amount
    self.c_amount = proto.c_amount or 0
    --MenuBuyMgr:ConditionCheck3(1,self.c_amount) --改到那里
    -- if (_c_amount == nil or self.c_amount ~= _c_amount) then
    --     --EventMgr.Dispatch(EventType.Pay_Amount_Change)
    --     MenuBuyMgr:ConditionCheck(2,"amountChange")
    -- end
end
function this:GetPayAmount()
    return self.c_amount or 0
end

-- 当天是否是玩家生日
function this:IsPlayerBirthDay()
    local birth = self.data.birth
    if (birth) then
        local timeInfo = TimeUtil:GetTimeHMS(TimeUtil:GetBJTime())
        if (timeInfo and timeInfo.month == birth[1] and timeInfo.day == birth[2]) then
            return true
        end
    end
    return false
end

--是否已播放生日祝福
function this:IsPlayBirthDayVoice()
    if(not self.isPlayBirthDayVoice) then 
        self.isPlayBirthDayVoice = 1
        return false  
    end 
    return true 
end

--获取生日 月,日
function this:GetBirthDay()
    local birth = self.data.birth
    if (birth) then
         return birth[1],birth[2]
    end
    return 0,0
end

--最后设置的角色看板ID
-- function this:SetLastRoleID(id)
--     self.data.role_panel_id = id 
-- end
-- function this:GetLastRoleID()
--     return self.data.role_panel_id
-- end

--称号
function this:SetIconTitle(title)
    self.data.icon_title = title
end
function this:GetIconTitle()
    return self.data.icon_title or 1
end

---首次进入 设置true   注销退出 设置false
function this:SetEnterHall( IsEnter)
    self.IsEnter=IsEnter;
end

---获取是否进入过
function this:IsEnterHall()
    if (not self.IsEnter) then
        return false;
    else
        return self.IsEnter
    end
end

--战斗表情
function this:SetEmotes(icon_emotes)
    self.data.icon_emotes = icon_emotes 
end
function this:GetEmotes()
    return self.data.icon_emotes or g_BattleFaceSet
end

return this;
