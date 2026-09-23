FightProto = {};
g_FightMgr = nil
------------------发送协议----------------------------
-- 主线战斗
function FightProto:StartMainLineFight(protoData)
    local data = {{
        id = 1001,
        row = 1,
        col = 1
    }, {
        id = 1002,
        row = 1,
        col = 3
    }, {
        id = 2001,
        row = 2,
        col = 2
    }, {
        id = 2002,
        row = 3,
        col = 1
    }, {
        id = 3001,
        row = 1,
        col = 2
    }}
    protoData.data = data;
    local proto = {"FightProtocol:StartMainLineFight", protoData};
    -- local proto = {"FightProtocol:StartMainLineFight",{nDuplicateID = 1001, groupID = 101011, data = data}};
    NetMgr.net:Send(proto);
end

function FightProto:StartPvpFight(proto)

    local data = {{
        id = 1001,
        row = 1,
        col = 1
    }, {
        id = 1002,
        row = 1,
        col = 3
    }, {
        id = 2001,
        row = 2,
        col = 2
    }, {
        id = 2002,
        row = 3,
        col = 1
    }, {
        id = 3001,
        row = 1,
        col = 2
    }}
    local proto = {"FightProtocol:PvpMatch", {
        data = data
    }};
    NetMgr.net:Send(proto);
end

function FightProto:SendCmd(cmd, data)
    if not g_FightMgr then
        LogDebugEx("FightProto:SendCmd", g_FightMgr)
        ASSERT(g_FightMgr)
        return
    end
    g_FightMgr:SendCmd(cmd, data)
end

function FightProto:RestoreFight()
    g_FightMgr:RestoreFight();
end

function FightProto:SendAuto()
    if not g_FightMgr then
        return
    end
    g_FightMgr:SendAuto()
end

---------------------接收协议----------------------------------------------
-- 收到战斗命令
function FightProto:RecvCmd(proto)
    Log("RecvCmd：==================")
    Log(proto);
    FightRecordMgr:PushProto(proto); -- 记录收到的战斗命令
    local index = proto[1] -- 指令索引
    local cmd = proto[2] -- 指令类型
    local data = proto[3] -- 指令内容
    local deltaTime = proto[4] -- 时间差(从战斗开始到指令执行时间差)
    local gridDatas = {3, 3, 3, 3};

    data = data["data" .. cmd]
    ASSERT(data)
    proto[3] = data
    if cmd == CMD_TYPE.InitData then
        if data.stype == SceneType.PVE or data.stype == SceneType.PVEBuild or data.stype == SceneType.Rogue or
            data.stype == SceneType.RogueS or data.stype == SceneType.RogueT or data.stype == SceneType.BuffBattle or
            data.stype == SceneType.RogueMap or data.stype == SceneType.MultTeam or data.stype == SceneType.RogueMapSup or
            data.stype == SceneType.TowerDeep or data.stype == SceneType.ChainFront or data.stype == SceneType.PeriodicBoss or data.stype == SceneType.CrossBoss then
            if not g_bRestartFight then
                FightActionMgr:Start()
            end
            -- pve 战斗
            local config = MonsterGroup[data.groupID]
            ASSERT(config)
            ASSERT(data.level)
            data.exData = data.exData or {}

            g_FightMgr = CreateFightMgr(data.fid, data.groupID, data.stype, data.seed)
            g_FightMgr.nPlayerLevel = data.level
            g_FightMgr.uid = PlayerClient:GetID()

            if data.exData.dupId then
                g_FightMgr.nDuplicateID = data.exData.dupId
            end
            g_FightMgr:LoadConfig(data.groupID, data.exData.stage or 1, data.exData.hpinfo)
            g_FightMgr:LoadData(data.teamID, data.data.data, nil, data.data.tCommanderSkill)

            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)

            local fightActionData = {
                scene = config.scene,
                gridDatas = gridDatas,
                myTeamID = data.teamID,
                totleState = g_FightMgr.totleState,
                bgm = g_FightMgr:GetBgm()
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});

            local fightActionData1 = g_FightMgr:GetInitData()
            FightActionMgr:PushSkill(fightActionData1);
            DungeonMgr:SetFightTeamId(data.nTeamIndex);
            if data.nTeamIndex ~= nil and TeamMgr:GetFightTeamData(data.nTeamIndex) == nil then -- 重连时没有战斗队伍缓存
                TeamMgr:ResetFightTeam(data);
            end
            -- EventMgr.Dispatch(EventType.Fight_Action_Push, fightAction);  
        elseif data.stype == SceneType.PVPMirror then
            if not g_bRestartFight then
                FightActionMgr:Start()
            end
            -- pvp 镜像
            g_FightMgr = CreateFightMgr(data.fid, nil, data.stype, data.seed)

            g_FightMgr:LoadData(1, data.tPvpData[1].data)
            g_FightMgr:LoadData(2, data.tPvpData[2].data, CardType.Mirror)
            data.exData = data.exData or {}
            g_FightMgr:SetStepLimit(g_sPVPMirrorStepLimit)
            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)
            g_FightMgr.uid = PlayerClient:GetID()

            local fightActionData = {
                scene = g_nPVPMirrorSceneID,
                gridDatas = gridDatas,
                myTeamID = 1,
                bgm = g_sPVPMirrorBgm,
                emotes = data.exData.emotes
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});

            local fightActionData1 = g_FightMgr:GetInitData();
            FightActionMgr:PushSkill(fightActionData1);
        elseif IsPvpSceneType(data.stype) then
            -- pvp 战斗
            g_FightMgr = CreateFightMgr(data.fid, nil, data.stype, data.seed)

            local myTeamID = 0
            for i, v in ipairs(data.tPvpData) do
                LogTable(v, "tPvpData =" .. i)

                g_FightMgr:LoadData(i, v.data)
                LogDebugEx("myTeamID", PlayerClient:GetUid(), v.uid or " nil")
                if v.uid == PlayerClient:GetUid() then
                    myTeamID = i
                end
            end

            ASSERT(myTeamID ~= 0)

            g_FightMgr:SetStepLimit(g_sPVPStepLimit)
            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)

            if not g_bRestartFight then
                FightActionMgr:Start()
            end

            local fightActionData = {
                scene = g_nPVPSceneID,
                gridDatas = gridDatas,
                myTeamID = myTeamID,
                bgm = g_sPVPBgm
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});

            local fightActionData1 = g_FightMgr:GetInitData();
            FightActionMgr:PushSkill(fightActionData1);
        elseif data.stype == SceneType.SinglePVE then
            if not g_bRestartFight then
                FightActionMgr:Start()
            end
            -- pve 战斗
            local config = MonsterGroup[data.groupID]
            ASSERT(config)

            g_FightMgr = SingleFightMgrClient(data.fid, data.groupID, SceneType.PVE, data.seed)
            g_FightMgr.uid = PlayerClient:GetID()
            if data.exData.bossId then
                g_FightMgr.nTPCastRate = 1
                local oboss = g_FightMgr:LoadBossConfig(data.groupID, 1)
                oboss.maxhp = data.exData.bossMaxHp
                oboss.hp = data.exData.bossMaxHp
                oboss:UpdateHp(data.exData.bossMaxHp)
                GCalHelp:GetGlobalBossAddSkill(oboss,data.exData.bossId)     
            else
                g_FightMgr:LoadConfig(data.groupID, 1,data.exData.hpinfo)
            end
            g_FightMgr:LoadData(data.teamID, data.data.data, nil, data.data.tCommanderSkill)

            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)

            local fightActionData = {
                scene = config.scene,
                gridDatas = gridDatas,
                myTeamID = data.teamID,
                totleState = g_FightMgr.totleState,
                bgm = g_FightMgr:GetBgm()
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});
            if data.nTeamIndex then
                DungeonMgr:SetFightTeamId(data.nTeamIndex);
            end
            local fightActionData1 = g_FightMgr:GetInitData()
            FightActionMgr:PushSkill(fightActionData1);
        elseif data.stype == SceneType.BOSS or data.stype == SceneType.GlobalBoss then
            if not g_bRestartFight then
                FightActionMgr:Start()
            end
            -- pve 战斗
            local config = MonsterGroup[data.groupID]
            ASSERT(config)
            ASSERT(data.level)

            g_FightMgr = CreateFightMgr(data.fid, data.groupID, data.stype, data.seed)
            g_FightMgr.nPlayerLevel = data.level
            data.exData = data.exData or {}
            g_FightMgr.bossUUID = data.exData.bossUUID
            g_FightMgr.nBossLevel = data.exData.nBossLevel
            g_FightMgr.nCastTP = data.exData.nCastTP
            g_FightMgr.nTPCastRate = g_TPCastRate[g_FightMgr.nCastTP] or 1
            g_FightMgr.uid = PlayerClient:GetID()
            local oboss = g_FightMgr:LoadBossConfig(data.groupID, 1)
            if data.exData.bossHp then
                oboss.maxhp = data.exData.bossMaxHp
                oboss.hp = data.exData.bossHp
                oboss:UpdateHp(data.exData.bossHp)
                if data.exData.bossId then                   
                    GCalHelp:GetGlobalBossAddSkill(oboss,data.exData.bossId)     
                end
            end
            -- oboss.hp = data.exData.bossHp or oboss.hp
            g_FightMgr:LoadData(data.teamID, data.data.data, nil, data.data.tCommanderSkill)

            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)

            local fightActionData = {
                scene = config.scene,
                gridDatas = gridDatas,
                myTeamID = data.teamID,
                totleState = g_FightMgr.totleState,
                bgm = g_FightMgr:GetBgm()
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});

            local fightActionData1 = g_FightMgr:GetInitData()
            FightActionMgr:PushSkill(fightActionData1);
            DungeonMgr:SetFightTeamId(data.nTeamIndex);
            if data.nTeamIndex ~= nil and TeamMgr:GetFightTeamData(data.nTeamIndex) == nil then -- 重连时没有战斗队伍缓存	
                TeamMgr:ResetFightTeam(data);
            end
        elseif data.stype == SceneType.GuildBOSS then
            if not g_bRestartFight then
                FightActionMgr:Start()
            end
            -- pve 战斗
            local config = MonsterGroup[data.groupID]
            ASSERT(config)
            ASSERT(data.level)

            g_FightMgr = CreateFightMgr(data.fid, data.groupID, data.stype, data.seed)
            g_FightMgr.nPlayerLevel = data.level
            data.exData = data.exData or {}
            g_FightMgr.bossUUID = data.exData.bossUUID
            g_FightMgr.nBossLevel = data.exData.nBossLevel
            g_FightMgr.nCastTP = data.exData.nCastTP
            g_FightMgr.nTPCastRate = g_TPCastRate[g_FightMgr.nCastTP] or 1

            local oboss = g_FightMgr:LoadBossConfig(data.groupID, 1)
            if data.exData.bossHp then
                oboss.maxhp = data.exData.bossMaxHp
                oboss.hp = data.exData.bossHp
                oboss:UpdateHp(data.exData.bossHp)
            end
            -- oboss.hp = data.exData.bossHp or oboss.hp
            g_FightMgr:LoadData(data.teamID, data.data.data, nil, data.data.tCommanderSkill)

            g_FightMgr:AfterLoadData(data.exData)
            g_FightMgr:AddCmd(CMD_TYPE.InitData, data)

            local fightActionData = {
                scene = config.scene,
                gridDatas = gridDatas,
                myTeamID = data.teamID,
                totleState = g_FightMgr.totleState,
                bgm = g_FightMgr:GetBgm()
            };
            g_FightMgr.tClientInitData = fightActionData
            fightActionData.api = "InitData";
            FightActionMgr:PushSkill({fightActionData});
            local fightActionData1 = g_FightMgr:GetInitData()
            FightActionMgr:PushSkill(fightActionData1);
            DungeonMgr:SetFightTeamId(data.nTeamIndex);
            if data.nTeamIndex ~= nil and TeamMgr:GetFightTeamData(data.nTeamIndex) == nil then -- 重连时没有战斗队伍缓存	
                TeamMgr:ResetFightTeam(data);
            end
        else
            ASSERT()
        end

    else
        -- Log( "cmd ~= CMD_TYPE.InitData")
        if (g_FightMgr) then
            g_FightMgr:RecvCmd(proto)
        end
    end
end

--
function FightProto:SyncFight(proto)
    Log("SyncFight==================")
    if not g_FightMgr then
        return
    end

    g_FightMgr:SyncFight(proto.list)
end

-- 正在匹配中
function FightProto:PvpMatch(proto)
    Log("PvpMatch:==================")
    Log(proto);

    if proto.ret then
        -- 显示倒计时
    else
        LogWarning(proto.msg or "匹配失败")
    end
end

function FightProto:PvpFightResult(proto)
    Log("PvpFightResult：==================")
    Log(proto);
    -- 显示队伍信息
end

------------------------------------
-- 副本地图相关
-- 请求
-- 请求进入副本
function FightProto:EnterDuplicate(data)
    local proto = {"FightProtocol:EnterDuplicate", data};
    NetMgr.net:Send(proto);
end

-- 离开战斗
function FightProto:LeaveFight()
    local proto = {"FightProtocol:LeaveFight", {}};
    NetMgr.net:Send(proto);
end

-- 请求
-- 请求进入战斗
function FightProto:EnterFight(data)
    -- LogError("进入战斗" .. table.tostring(data));

    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "fight",
        timeOutCallBack = function()
            local dialogdata = {
                --content = "进入战斗失败，点击重试",
                content = LanguageMgr:GetTips(8046),
                okCallBack = function()
                    FightProto:EnterFight(data);
                end,
                cancelCallBack = function()
                    PlayerClient:Exit();
                end
            }
            CSAPI.OpenView("Dialog", dialogdata);
        end
    });

    local currTime = CSAPI.GetTime() or 0;
    local lastTime = self.lastTimeSendEnterFight or 0;
    if (currTime - lastTime < 3) then
        return;
    end
    self.lastTimeSendEnterFight = currTime;

    local proto = {"FightProtocol:EnterFight", data};
    NetMgr.net:Send(proto);
end
-- 请求退出副本
function FightProto:QuitDuplicate(data)
    local proto = {"FightProtocol:QuitDuplicate", data};
    NetMgr.net:Send(proto);
end

-- 请求移动
function FightProto:MoveTo(data) -- {oid = 1, path={1001,1002,1003}}
    local proto = {"FightProtocol:MoveTo", data};
    NetMgr.net:Send(proto);
end

-- 请求破坏道具
function FightProto:DestroyProp(data)
    local proto = {"FightProtocol:DestroyProp", data};
    NetMgr.net:Send(proto);
end
-- 破坏道具结果
function FightProto:AskDestroyProp(proto)
    Log("FightProto:AskDestroyProp")
    Log(proto);
    -- BattleMgr:AskDestroyProp(proto)
    BattleMgr:PushData(proto, BattleMgr.AskDestroyProp);
end
-- 请求推动道具
function FightProto:PushBox(data)
    local proto = {"FightProtocol:PushBox", data};
    NetMgr.net:Send(proto);
end
-- 推动道具结果
function FightProto:AskPushBox(proto)
    Log("FightProto:AskPushBox")
    Log(proto);
    -- BattleMgr:AskPushBox(proto);
    BattleMgr:PushData(proto, BattleMgr.AskPushBox);
end

-- 遭遇怪物
function FightProto:Encounter(proto)
    Log("FightProto:Encounter");
    Log(proto);
    BattleMgr:PushData(proto, BattleMgr.Encounter);
end

-- 更新角色buff
function FightProto:UpdateCharBuff(proto)
    Log("FightProto:UpdateCharBuff")
    Log(proto);
    BattleMgr:PushData(proto, BattleMgr.UpdateCharBuff);
end

-- 返回
-- 副本地图数据
function FightProto:DuplicateData(proto)
    --	LogError("FightProto:DuplicateData")
    --	LogError( proto);
    --    _G.tttt = not _G.tttt;
    --    if(_G.tttt)then
    --        LogError("忽略");
    --        return;
    --    end

    EventMgr.Dispatch(EventType.Net_Msg_Getted, "fight");

    if (proto.bIsFresh) then
        BattleMgr:PushData(proto, BattleMgr.RefreshData);
    else
        DungeonMgr:EnterDungeon(proto);
    end
    -- BattleMgr:PushData(proto,BattleMgr.Init);
end

-- 更新角色信息
function FightProto:UpdateChar(proto)
    Log("FightProto:UpdateChar")
    -- Log(proto);
    -- DungeonMgr:EnterDungeon(proto);
    -- BattleMgr:UpdateCharacter(proto);
    BattleMgr:PushData(proto, BattleMgr.UpdateCharacter);
end

-- 使用物品
function FightProto:UseProp(proto)
    Log("FightProto:UseProp")
    BattleMgr:PushData(proto, BattleMgr.UseProp);
end

-- 移动结果
function FightProto:AskMoveTo(proto)
    Log("FightProto:AskMoveTo")
    -- Log( proto);
    BattleMgr:PushData(proto, BattleMgr.AskMoveTo);
end

-- 是否可以移动
function FightProto:IsCanMove(proto)
    Log("FightProto:IsCanMove")
    BattleMgr:PushData(proto, BattleMgr.SetMoveState);
end

-- 副本结束
function FightProto:DuplicateOver(proto)
    Log("FightProto:DuplicateOver")
    Log(proto);

    proto = GCalHelp:CheckFirstPassRewardInfo(proto)

    self.fightOverData = {}
    self.fightOverData.rewards = {}

    if proto then
        if (proto.fisrtPassReward and #proto.fisrtPassReward > 0) then -- 首次奖励
            for k, v in ipairs(proto.fisrtPassReward) do
                v.tag = ITEM_TAG.FirstPass
                table.insert(self.fightOverData.rewards, v);
            end
        end
        if (proto.specialReward and #proto.specialReward > 0) then
            for k, v in ipairs(proto.specialReward) do
                v.tag = ITEM_TAG.TimeLimit
                table.insert(self.fightOverData.rewards, v);
            end
        end
        if (proto.fisrt3StarReward and #proto.fisrt3StarReward > 0) then -- 三星奖励
            for k, v in ipairs(proto.fisrt3StarReward) do
                v.tag = ITEM_TAG.ThreeStar
                table.insert(self.fightOverData.rewards, v);
            end
        end
        if proto.reward and #proto.reward > 0 then
            for k, v in ipairs(proto.reward) do
                table.insert(self.fightOverData.rewards, v);
            end
        end
    end

    if self.lastFightOverData then -- fightover的数据
        if self.lastFightOverData.reward and #self.lastFightOverData.reward > 0 then
            for k, v in ipairs(self.lastFightOverData.reward) do
                table.insert(self.fightOverData.rewards, v);
            end
        end
        if self.lastFightOverData.passivBufReward and #self.lastFightOverData.passivBufReward > 0 then
            for k, v in ipairs(self.lastFightOverData.passivBufReward) do
                table.insert(self.fightOverData.rewards, v);
            end
        end
        if not proto.star and self.lastFightOverData.star then
            proto.star = self.lastFightOverData.star
        end
        if proto.nPlayerExp then
            self.fightOverData.nPlayerExp = proto.nPlayerExp
        end
        if self.lastFightOverData.hisMaxDamage then
            self.fightOverData.totalDamage = self.lastFightOverData.hisMaxDamage
        end
        self.lastFightOverData = nil
    end

    if (FightClient:IsFightting()) then
        DungeonMgr:SetDungeonOver(proto);
    else
        BattleMgr:PushData(proto, BattleMgr.DungeonOver);
    end

    -- EventMgr.Dispatch(EventType.Player_Battle_Over)
end

-- 获取战斗结束数据
function FightProto:GetFightOverData()
    local data = self.fightOverData
    self.fightOverData = nil
    return data
end

-- 战斗结束
function FightProto:FightOver(proto)
    Log("FightProto:FightOver")
    self.lastFightOverData = proto
    Log(proto);
    DungeonMgr:FightOver(proto);
end

-- 退出副本结果
function FightProto:AskQuitDuplicate(proto)
    Log("FightProto:AskQuitDuplicate")
    -- Log( proto);
    if proto and proto.ret then
        -- local rewards = {};
        -- if(proto.fisrtPassReward and #proto.fisrtPassReward > 0) then
        -- 	for k, v in ipairs(proto.fisrtPassReward) do
        -- 		v.tips = StringConstant.dungeon_reward_tips2;
        -- 		table.insert(rewards, v);
        -- 	end
        -- end
        -- if(proto.fisrt3StarReward and #proto.fisrt3StarReward > 0) then
        -- 	for k, v in ipairs(proto.fisrt3StarReward) do
        -- 		v.tips = StringConstant.dungeon_reward_tips3;
        -- 		table.insert(rewards, v);
        -- 	end
        -- end
        -- if #rewards >= 1 then
        -- 	MenuMgr:AddOpenFunc("Dungeon", function()
        -- 		local eventMgr = ViewEvent.New();
        -- 		eventMgr:AddListener(EventType.Loading_Complete, function()
        -- 			UIUtil:OpenReward({rewards});
        -- 			eventMgr:ClearListener();
        -- 		end)
        -- 	end);
        -- end

        -- FriendMgr:ClearAssistData();
        -- TeamMgr:ClearFightTeamData();
        DungeonMgr:ClearDragList();
    end

    if (not self.isRestoreFight) then -- 重登不会跳到副本界面
        DungeonMgr:Quit();
    else
        self.isRestoreFight = false
    end
end

-- 登录同步正在进行中的副本信息
function FightProto:CurrDuplicate(proto)
    Log("FightProto:CurrDuplicate")
    --    LogError("当前副本======临时日志");
    -- 	LogError(proto);
    DungeonMgr:SetCurrFightId(nil);
    TeamMgr:ClearFightID();
    if proto.data then
        local index = 1;
        for k, v in ipairs(proto.data) do
            if v.index == 1 then -- 副本
                -- Log( "进行中的副本ID：" .. tostring(v.nDuplicateID));
                -- 记录当前副本ID
                DungeonMgr:SetCurrFightId(v.nDuplicateID);
                DungeonMgr:SetCurrId1(v.nDuplicateID)
            end
            index = v.index;
        end
        TeamMgr:UpdateFightID(index, proto.arrUsedTeam);
    end
    local currFightId = DungeonMgr:GetCurrFightId();
    if (not currFightId) then
        DungeonMgr:SetDungeonOver(nil);
        if DungeonMgr:HasFighting() ~= true then
            -- FriendMgr:ClearAssistData(); --清空助战缓存
            -- TeamMgr:ClearFightTeamData();--清空战斗中的队伍数据
            UIUtil:AddFightTeamState(2, "FightProto:CurrDuplicate()")
        end
    end
    EventMgr.Dispatch(EventType.Main_Fight_Duplicate);
end

-- 开始恢复战斗结果
function FightProto:RestoreFightStart(proto)
    -- LogError("FightProto:RestoreFightStart")
    -- LogError(proto)
    if proto.restart then
        -- 清空游戏现场
        g_FightMgr = nil
        FightActionMgr:Reset()
        g_bRestartFight = true
    end
end

-- 恢复战斗完成结果
function FightProto:RestoreFightEnd(proto)
    Log("FightProto:RestoreFightEnd")
    if proto.err then
        -- 客户端做好相应的处理后
        -- 请求服务器清除战斗状态
        ASSERT(nil, "恢复战斗失败")
    else
        FightActionMgr:Start()
        FightClient:ApplyServerStart()
        g_FightMgr:RestoreFight()
    end

    g_bRestartFight = nil
end

-- 战斗中
function FightProto:InBattle(proto)
    Log("FightProto:InBattle")
    -- 单机如果断线重连要处理
    -- 单机发送结果前断线    
    if proto.type == 0 then -- 战斗已经结束,前端如果还在战斗场景中, 退出来
        if (FightClient:IsFightting() and not FightActionMgr:HasFightEnd()) then
            if g_FightMgrServer then
                -- 单机断线，不处理
                return;
            end

            if (FightClient:IsCanExit() and not FightClient:IsNewPlayerFight()) then
                local callBack = function()
                    PlayerClient.info = nil;
                    ToLogin();
                end
                local dialogdata = {
                    content = LanguageMgr:GetTips(19018),
                    okCallBack = callBack,
                    cancelCallBack = callBack
                }
                CSAPI.OpenView("Dialog", dialogdata);
            else
                CSAPI.OpenView("Prompt", {
                    content = LanguageMgr:GetByID(1072),
                    okCallBack = function()
                        CSAPI.Quit();
                    end
                })
            end
        end
        return;
    elseif IsPvpSceneType(proto.type) then
        --ExerciseRMgr:RecoverPvp()
        --return
    elseif proto.type == SceneType.Rogue and not FightClient:IsFightting()then 
        FightProto:QuitRogueFight(true, 1)
        return;
    end

    if g_FightMgr and not g_FightMgr.isOver then
        -- 断线重连
        g_FightMgr:SendRestoreFight()
    else
        -- 重启
        -- FightProto:ShowRestoreFightDialog(proto);
        self:SetRestoreFightProto(proto);
    end

    if (proto.type == SceneType.PVE or proto.type == SceneType.RogueS or proto.type == SceneType.TowerDeep or proto.type == SceneType.RogueMap) then
        DungeonMgr:SetCurrId(proto.nDuplicateID);
        DungeonMgr:SetCurrFightId(proto.nDuplicateID);
    end

    -- FightClient:SetRestoreFight();
end

function FightProto:SetRestoreFightProto(proto)
    -- LogError("SetRestoreFightProto" .. table.tostring(proto,true));
    if (FightClient:IsFightting()) then
        return;
    end
    self.restoreFightProto = proto;
    EventMgr.Dispatch(EventType.Fight_Restore);
end

-- 显示恢复战斗对话框
function FightProto:ShowRestoreFightDialog(isShow)
    --pvp恢复战斗 
    if(ExerciseRMgr:CheckIsReconnect())then
        ExerciseRMgr:SetIsReconnect(false)
        UIUtil:OpenDialog(LanguageMgr:GetTips(8022), function ()
            ExerciseRMgr:RecoverPvp()
        end, function ()
            FightClient:QuitFihgt()
        end)
        return
    end 
    --RogueS恢复战斗 
    local _data = RogueSMgr:GetFightingRogueSData()
    if(_data) then 
        --有引导
        local round = _data.round
        RogueSMgr:FightingRogueSData(nil)
        if (not isShow) then
            FightProto:RogueSQuit()
        else 
            UIUtil:OpenDialog(LanguageMgr:GetTips(8022), function ()
                FightProto:EnterRogueSFight(round+1)
            end, function ()
                FightProto:RogueSQuit()
            end)
        end
        -- 
        return 
    end 
    -- 
    local id = DungeonMgr:GetCurrFightId();
    if (not id) then
        id = self.restoreFightProto and self.restoreFightProto.nDuplicateID;
        if (not id) then
            return;
        end
    end
    self.restoreFightProto = nil;
    local dialogData = {
        okCallBack = function()
            self.isRestoreFight = false
            DungeonMgr:SetToCheckBattleFight()
            DungeonMgr:ApplyEnter(id)
        end,
        cancelCallBack = function()
            FightClient:QuitFihgt()
            DungeonMgr:SendToQuit();
        end,
        content = LanguageMgr:GetTips(8022),
    }
    if (not isShow) then
        dialogData.cancelCallBack()
        return;
    end
    self.isRestoreFight = true
    local cfgDungeon = Cfgs.MainLine:GetByID(id)
    if cfgDungeon then
        if cfgDungeon.dungeonGroup and cfgDungeon.type == eDuplicateType.TowerDeep then
            dialogData.okCallBack = function()
                self.isRestoreFight = false
                FightProto:EnterTowerDeepFight()
            end
        elseif cfgDungeon.type == eDuplicateType.RogueMap then
            dialogData.okCallBack = function()
                self.isRestoreFight = false
                RogueMapMgr:SetDungeonId(cfgDungeon.id)
                FightProto:RogueMapEnterFight()
            end
            dialogData.cancelCallBack = function()
                self.isRestoreFight = false
                FightProto:RogueMapFightQuit()
            end
        end
    end
    CSAPI.OpenView("DialogNoTop", dialogData);
end

-- 设置集火回复
function FightProto:FocusFire(proto)
    Log(proto)
    -- if g_FightMgr then
    -- 	g_FightMgr:OnSetFocusFire(PlayerClient:GetUid(), nFocusFireID)
    -- end
end

-- 设置使用技能AI策略
function FightProto:SendSetSkillAI(index, sDuplicateAIData)
    -- LogError(proto);
    local data = {
        index = index,
        data = sDuplicateAIData
    };
    local proto = {"FightProtocol:SetSkillAI", data};
    NetMgr.net:Send(proto);
end

-- 设置使用技能AI策略回调
function FightProto:SetSkillAI(proto)
    if proto and proto.data then
        -- 保存本地数据
        local config = TeamMgr:LoadStrategyConfig();
        for k, v in ipairs(proto.data) do
            local character = BattleCharacterMgr:GetCharacter(v.oid);
            if character then
                local index = character:GetTeamNO();
                config[string.format("team%sSP", index)] = v.bIsReserveSP
                config[string.format("team%sNP", index)] = v.nReserveNP
                config.target = v.nFocusFire;
            end
        end
        TeamMgr:SaveStrategyConfig(config);
    end
end

-- 主动退出回复
function FightProto:Quit(proto)
    -- LogError(proto);
    -- ASSERT(proto.uid)
    -- if g_FightMgr then
    -- 	g_FightMgr:Quit(proto.uid)
    -- end
end

-- 托管状态
function FightProto:TrusteeshipState(proto)
    FightClient:SetAutoFight(true);
    EventMgr.Dispatch(EventType.Fight_View_AutoFight_Changed);
end

-- 开始副本单机战斗
function FightProto:SingleFight(proto)
    CreateDuplicateSingleFight(proto)
end

-- 请求进入副本（直接进行战斗）
function FightProto:EnterFightDuplicate(data)
    local proto = {"FightProtocol:EnterFightDuplicate", data};
    NetMgr.net:Send(proto);
end

-- 进入副本失败
function FightProto:EntryDupResult(proto)
    -- 清理战斗队伍信息
    if proto and proto.isOk ~= true then
        FriendMgr:ClearAssistData();
        TeamMgr:ClearAssistTeamIndex();
        TeamMgr:ClearFightTeamData();
        UIUtil:AddFightTeamState(2, "FightProto:EntryDupResult()")
        TeamMgr:ClearFightID();
        EventMgr.Dispatch(EventType.Net_Msg_Getted,"fight");
        FuncUtil:Call(function()
            EventMgr.Dispatch(EventType.Fight_Enter_Fail)
        end,nil,1000);   
    end
end

-- ------------------------------------------------------------------------
-- -- 请求进入世界boss
-- function FightProto:EnterBossFight()
-- 	local data = {}
-- 	data.nTeamIndex = 1
-- 	data.nBossType = 1
-- 	local proto = {"FightProtocol:EnterBossFight", data};
-- 	NetMgr.net:Send(proto);	
-- end
function FightProto:GetBossActivityInfo(data)
    Log(data)
    WorldBossMgr:GetBossActivityInfoRet(data)
end

function FightProto:EnterBossRet(data)
    Log(data)
    -- 拿到boss进程的ip端口后, 需要连接到新的战斗进程上去
    g_bossUUID = data.bossUUID
    WorldBossMgr:EnterBossRet(data)
end

-- 等待结束,可以开始进入战斗
function FightProto:OnBossStart(data)
    Log(data)
    WorldBossMgr:OnBossStart(data)
    -- 请求进入boss战斗
    -- local proto = {"FightProtocol:EnterBossFight", {bossUUID = g_bossUUID, nTeamIndex = 1}};
    -- NetMgr.net:Send(proto);	
end

-- boss战斗结束
function FightProto:OnBossOver(proto)
    Log(proto)
    -- if winner == PlayerClient:GetUid() then
    -- 	proto.bIsWin = true
    -- end
    -- DungeonMgr:FightOver(proto);
    if (not g_FightMgr) then
        return
    end
    if g_FightMgr.type == SceneType.BOSS then
        FightOverTool.OnFieldBossOver(proto)
    elseif g_FightMgr.type == SceneType.GuildBOSS then
        FightOverTool.OnGuildBossOver(proto);
    elseif g_FightMgr.type == SceneType.GlobalBoss then
        FightOverTool.OnGlobalBossOver(proto);
    end
end

function FightProto:UpdateBossHp(data)
    if (not g_FightMgr) then
        return;
    end

    Log(data)

    ASSERT(data.hp)
    -- LogDebugEx("UpdateBossHp", g_FightMgr.bossUUID and g_FightMgr.bossUUID == data.bossUUID and g_FightMgr.oboss)
    if not g_FightMgr.bossUUID then
        return
    end
    if g_FightMgr.bossUUID ~= data.bossUUID then
        return
    end
    if not g_FightMgr.oBoss then
        return
    end
    g_FightMgr.oBoss:UpdateHp(data.hp)

    WorldBossMgr:UpdateBossHp(data)
end

-- boss排行榜
function FightProto:GetBossRankRet(proto)
    Log(proto)
end

-- 我的伤害
function FightProto:GetBossDamageRet(proto)
    Log(proto)
    WorldBossMgr:GetBossDamageRet(proto)
end

-- boss血量(界面调用)
function FightProto:GetBossHPRet(proto)
    WorldBossMgr:GetBossHPRet(proto)
end

-- 玩家加入世界boss
function FightProto:AddBossList(proto)
    Log(proto)
    WorldBossMgr:AddBossList(proto)

end

-- 设置自动AI技能
function FightProto:SendMapSetSkillAI(index, oid, bIsReserveSP, nReserveNP)
    local data = {
        index = index,
        oid = oid,
        bIsReserveSP = bIsReserveSP,
        nReserveNP = nReserveNP
    };
    local proto = {"FightProtocol:MapSetSkillAI", data};
    NetMgr.net:Send(proto);
end

-- 小地图AI设置回调
function FightProto:MapSetSkillAI(proto)
    EventMgr.Dispatch(EventType.AIPreset_Battle_SetRet, proto)
end

-- 战斗中修改ai预设会走这条协议返回PlayerProto:SwitchAIStrategyRes 
function FightProto:SwitchAIStrategy(index, oid, data)
    local data = {
        index = index,
        oid = oid,
        data = data
    };
    local proto = {"FightProtocol:SwitchAIStrategy", data};
    NetMgr.net:Send(proto);
end

------------------------------------------------------------------------
-- 战场boss战斗请求
function FightProto:EnterBattleFieldBossFight(data)
    local proto = {"FightProtocol:EnterBattleFieldBossFight", data};
    NetMgr.net:Send(proto);
end

------------------------------------------------------------------------

-- 请求扫荡
function FightProto:ModUpFightDuplicate(data)
    local proto = {"FightProtocol:ModUpFightDuplicate", data};
    NetMgr.net:Send(proto);
end

function FightProto:ModUpFightOver(proto)
    Log(proto)
    FightOverTool.OnSweepOver(proto, false)
end

-- 世界boss请求扫荡
function FightProto:GlobalBossMopUp()
    local proto = {"FightProtocol:GlobalBossMopUp", {}};
    NetMgr.net:Send(proto);
end

function FightProto:GlobalBossMopUpRet(proto)
    FightOverTool.OnGlobalBossSweepOver(proto, false)
end

-------------------------------乱序演习-----------------------------------------

-- 初始数据
function FightProto:GetRogueInfo()
    local proto = {"FightProtocol:GetRogueInfo"}
    NetMgr.net:Send(proto)
end
function FightProto:GetRogueInfoRet(proto)
    RogueMgr:GetRogueInfoRet(proto)
end
-- 正在进行中的乱序演习信息(后端返回)
function FightProto:FightingRogueData(proto)
    RogueMgr:FightingRogueData(proto)
    if (self.EnterRogueDuplicateCB) then
        self.EnterRogueDuplicateCB()
    end
    self.EnterRogueDuplicateCB = nil
end
-- 请求进入乱序演习（开始新肉鸽才请求）
function FightProto:EnterRogueDuplicate(_group, _list, _cb)
    self.EnterRogueDuplicateCB = _cb
    local proto = {"FightProtocol:EnterRogueDuplicate", {
        index = 2,
        group = _group,
        list = _list
    }}
    NetMgr.net:Send(proto)
end
-- 乱序演习选BUFF
function FightProto:RogueSelectBuff(_buff, _cb)
    self.RogueSelectBuffCB = _cb
    local proto = {"FightProtocol:RogueSelectBuff", {
        buff = _buff
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueSelectBuffRet(proto)
    RogueMgr:SetSelectBuffs(proto.selectBuffs)
    if (self.RogueSelectBuffCB) then
        self.RogueSelectBuffCB()
    end
    self.RogueSelectBuffCB = nil
end
-- 乱序演习翻卡牌
function FightProto:RogueSelectPos(_pos, _cb)
    self.RogueSelectPosCB = _cb
    local proto = {"FightProtocol:RogueSelectPos", {
        pos = _pos
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueSelectPosRet(proto)
    RogueMgr:SetSelectPos(proto.selectPos)
    if (self.RogueSelectPosCB) then
        self.RogueSelectPosCB()
    end
    self.RogueSelectPosCB = nil
end
-- 请求进入乱序演习战斗
function FightProto:EnterRogueFight()
    local proto = {"FightProtocol:EnterRogueFight"}
    NetMgr.net:Send(proto)
end
-- 退出乱序演习战斗
function FightProto:QuitRogueFight(_save, _quitType, _cb)
    self.QuitRogueFightCB = _cb
    local proto = {"FightProtocol:QuitRogueFight", {
        save = _save,
        quitType = _quitType
    }}
    NetMgr.net:Send(proto)
end
-- 乱序演习战斗副本结束
function FightProto:RogueOver(proto)
    if (proto.quitType == nil or proto.quitType == 0) then
        -- 正常流程成功或者失败
        FightOverTool.RogueInfoUpdate(proto)
    elseif (proto.quitType == 1) then
        -- rogue界面点放弃
    elseif (proto.quitType == 2) then
        -- 战斗界面点放弃或者保存进度退出
        FightOverTool.RogueInfoUpdate(proto)
    end
    if (self.QuitRogueFightCB) then
        self.QuitRogueFightCB()
    end
    self.QuitRogueFightCB = nil
end

-------------------------------战力派遣-----------------------------------------
function FightProto:GetRogueSInfo()
    local proto = {"FightProtocol:GetRogueSInfo"}
    NetMgr.net:Send(proto)
end
function FightProto:GetRogueSInfoRet(proto)
    RogueSMgr:GetRogueSInfoRet(proto)
end

--在结算时中断 FightingRogueSData     （非战斗中断的线)
--战斗中断     InBattle               （战斗中断的线)
function FightProto:FightingRogueSData(proto)
    if(SceneMgr:IsMajorCity()) then 
        RogueSMgr:FightingRogueSData(proto)
    end
end

--进入战斗
function FightProto:EnterRogueSDuplicate(_id,_list)
    local proto = {"FightProtocol:EnterRogueSDuplicate",{id=_id,list=_list}}
    NetMgr.net:Send(proto)
end

 --重复本轮或者下一轮
function FightProto:EnterRogueSFight(_round,_cb)
    self.EnterRogueSFightCB = _cb
    local proto = {"FightProtocol:EnterRogueSFight",{round=_round}}
    NetMgr.net:Send(proto)
end
function FightProto:EnterRogueSFightRet(proto)
    if(self.EnterRogueSFightCB) then 
        self.EnterRogueSFightCB()
    end
    self.EnterRogueSFightCB = nil
end
--结束信息
function FightProto:RogueSOver(proto)
    local isSurrender = FightClient:IsSurrender();
    FightOverTool.RogueSInfoUpdate(proto,isSurrender)
end

--放弃
function FightProto:RogueSQuit()
    local proto = {"FightProtocol:RogueSQuit"}
    NetMgr.net:Send(proto)
end
function FightProto:RogueSQuitRet(proto)

end
--战力派遣领取星数奖励
function FightProto:RogueSGain(_ty,_cb)
    self.RogueSGainCB = _cb 
    local proto = {"FightProtocol:RogueSGain",{ty= _ty}}
    NetMgr.net:Send(proto)
end
function FightProto:RogueSGainRet(proto) 
    RogueSMgr:RogueSGainRet(proto.gained)
    if(self.RogueSGainCB) then
        self.RogueSGainCB()
    end
    self.RogueSGainCB = nil
end


------------------------------------世界boss------------------------------------
--新世界boss信息返回
function FightProto:GlobalBossInfoRet(proto)
    GlobalBossMgr:SetInfo(proto)
end

--请求新世界boss数据
function FightProto:GetGlobalBossData()
    local proto = {"FightProtocol:GetGlobalBossData"}
    NetMgr.net:Send(proto)
end

--请求新世界boss数据返回
function FightProto:GetGlobalBossDataRet(proto)
    GlobalBossMgr:SetData(proto)
end

--请求进入新世界boss战斗
function FightProto:EnterGlobalBossFight(index)
    local proto = {"FightProtocol:EnterGlobalBossFight",{nTeamIndex = index}}
    NetMgr.net:Send(proto)
end

function FightProto:GetGlobalBossRank(index)
    local proto = {"FightProtocol:GetGlobalBossRank",{nPage = index}}
    NetMgr.net:Send(proto)
end

function FightProto:GetGlobalBossRankRet(proto)
    local bossData = GlobalBossMgr:GetData()
    if bossData then
        proto.rank_type = bossData:GetRankType()
    end
    RankMgr:GetRankRet(proto)
    -- GlobalBossMgr:GetRankRet(proto)
end

function FightProto:GetGlobalBossRankTeam(index,callBack)
    self.GlobalBossRankTeamCallBack = callBack
    local proto = {"FightProtocol:GetGlobalBossRankTeam",{rankIdx = index}}
    NetMgr.net:Send(proto)
end

function FightProto:GetGlobalBossRankTeamRet(proto)
    if self.GlobalBossRankTeamCallBack then
        self.GlobalBossRankTeamCallBack(proto)
        self.GlobalBossRankTeamCallBack = nil
    end
end


-------------------------------限制肉鸽爬塔-----------------------------------------

-- 初始数据
function FightProto:GetRogueTInfo()
    local proto = {"FightProtocol:GetRogueTInfo"}
    NetMgr.net:Send(proto)
end
function FightProto:GetRogueTInfoRet(proto)
    RogueTMgr:GetRogueTInfoRet(proto)
end
-- 正在进行中的限制肉鸽信息(后端返回)
function FightProto:FightingRogueTData(proto)
    RogueTMgr:FightingRogueTData(proto)
    if (self.EnterRogueTDuplicateCB) then
        self.EnterRogueTDuplicateCB()
    end
    self.EnterRogueTDuplicateCB = nil
end
-- 请求进入限制肉鸽（开始新肉鸽才请求）
function FightProto:EnterRogueTDuplicate(_id, _boss, _cb)
    self.EnterRogueTDuplicateCB = _cb
    local proto = {"FightProtocol:EnterRogueTDuplicate", {
        id = _id,
        boss = _boss,
    }}
    NetMgr.net:Send(proto)
end
-- 限制肉鸽选BUFF
function FightProto:RogueTSelectBuff(_id, _cb)
    self.RogueTSelectBuffCB = _cb
    local proto = {"FightProtocol:RogueTSelectBuff", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTSelectBuffRet(proto)
    RogueTMgr:SetSelectBuffs(proto.selectBuffs)
    if (self.RogueTSelectBuffCB) then
        self.RogueTSelectBuffCB()
    end
    self.RogueTSelectBuffCB = nil
end
--升级buff
function FightProto:RogueTBuffUp(_id,_cb)
    self.RogueTBuffUpCB = _cb
    local proto = {"FightProtocol:RogueTBuffUp", {
        id = _id
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTBuffUpRet(proto)
    RogueTMgr:RogueTBuffUpRet(proto)
    if (self.RogueTBuffUpCB) then
        self.RogueTBuffUpCB(proto.new_id)
    end
    self.RogueTBuffUpCB = nil
    EventMgr.Dispatch(EventType.RogueT_Buff_Upgrade)
end

--buff存档
function FightProto:RogueTBuffSave(_save,_idx,_cb)
    self.RogueTBuffSaveCB = _cb
    local proto = {"FightProtocol:RogueTBuffSave", {
        save = _save,
        idx = _idx,
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTBuffSaveRet(proto)
    if (self.RogueTBuffSaveCB) then
        self.RogueTBuffSaveCB()
    end
    self.RogueTBuffSaveCB = nil
end
-- 请求进入限制肉鸽战斗
function FightProto:EnterRogueTFight(_list)
    local proto = {"FightProtocol:EnterRogueTFight",{list = _list}}
    NetMgr.net:Send(proto)
end
--使用buff存档
function FightProto:RogueTUseBuff(_id,_useBuff,_cb)
    self.RogueTUseBuffCB = _cb
    local proto = {"FightProtocol:RogueTUseBuff", {
        id = _id,
        useBuff = _useBuff,
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTUseBuffRet(proto)
    RogueTMgr:RogueTUseBuffRet(proto)
    if (self.RogueTUseBuffCB) then
        self.RogueTUseBuffCB()
    end
    self.RogueTUseBuffCB = nil
end
--领取限制肉鸽爬塔奖励
function FightProto:RogueTGainReward(_ty,_cb)
    self.RogueTGainRewardCB = _cb
    local proto = {"FightProtocol:RogueTGainReward", {
        ty = _ty,
    }}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTGainRewardRet(proto)
    RogueTMgr:RogueTGainRewardRet(proto)
    if (self.RogueTGainRewardCB) then
        self.RogueTGainRewardCB()
    end
    self.RogueTGainRewardCB = nil
end

function FightProto:RogueTQuit(_cb)
    self.RogueTQuitCB = _cb
    local proto = {"FightProtocol:RogueTQuit"}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTQuitRet(_cb)
    if (self.RogueTQuitCB) then
        self.RogueTQuitCB()
    end
    self.RogueTQuitCB = nil
end
-- 限制肉鸽战斗副本结束
function FightProto:RogueTOver(proto)
    FightOverTool.RogueTInfoUpdate(proto)
end

--删除存档
function FightProto:RogueTDelBuff(_id,_idx,_cb)
    self.RogueTDelBuff = _cb
    local proto = {"FightProtocol:RogueTDelBuff",{id = _id,idx = _idx}}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTDelBuffRet(proto)
    RogueTMgr:RogueTDelBuffRet(proto)
    if( self.RogueTDelBuff)then 
        self.RogueTDelBuff()
    end 
    self.RogueTDelBuff = nil
end

--请求进入积分战斗副本(直接战斗)
function FightProto:EnterFightBuffBattleDuplicate(data)
    local proto = {"FightProtocol:EnterFightBuffBattleDuplicate",data}
    NetMgr.net:Send(proto)
end

--弹窗与红点
function FightProto:RogueTSetWindow(_ty,_value,_cb)
    self.RogueTSetWindowCB = _cb
    local proto = {"FightProtocol:RogueTSetWindow",{ty = _ty,value = _value}}
    NetMgr.net:Send(proto)
end
function FightProto:RogueTSetWindowRet(proto)
    RogueTMgr:RogueTSetWindowRet(proto)
    if( self.RogueTSetWindowCB)then 
        self.RogueTSetWindowCB()
    end 
    self.RogueTSetWindowCB = nil
end

-------------------------------秘境探索-----------------------------------------
-- 请求秘境探索玩法信息
function FightProto:GetRogueMapInfo()
    local proto = {"FightProtocol:GetRogueMapInfo", {}}
    NetMgr.net:Send(proto)
end

function FightProto:GetRogueMapInfoRet(proto)
    RogueMapMgr:SetDatas(proto)
end

-- 请求进入秘境探索玩法
function FightProto:EnterRogueMapDuplicate(data)
    local proto = {"FightProtocol:EnterRogueMapDuplicate", data}
    NetMgr.net:Send(proto)
end

-- 正在进行中的秘境副本信息
function FightProto:FightingRogueMapData(proto)
    EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_fight")

    RogueMapMgr:EnterDungeon(proto)
end

-- 秘境探索 摇骰子
function FightProto:RogueMapRoll()
    local proto = {"FightProtocol:RogueMapRoll", {}}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapRollRet(proto)
    RogueMapMgr:SetRoll(proto)
end

-- 秘境探索 移动
function FightProto:RogueMapMove(path)
    local proto = {"FightProtocol:RogueMapMove", {
        path = path
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapMoveRet(proto)
    RogueMapMgr:SetMove(proto)
end

-- 秘境探索 移动结束触发事件
function FightProto:RogueMapMoveEnd(cb)
    local proto = {"FightProtocol:RogueMapMoveEnd"}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapMoveEndRet(proto)
    RogueMapMgr:SetMoveEnd(proto)
end

-- 秘境探索 进入战斗
function FightProto:RogueMapEnterFight(id, pos, isSimulated)
    local proto = {"FightProtocol:RogueMapEnterFight", {
        id = id,
        pos = pos,
        isSimulated = isSimulated
    }}
    NetMgr.net:Send(proto)
end

-- 秘境探索 战斗结束
function FightProto:RogueMapFightOver(proto)
    FightOverTool.OnRogueMapOver(proto)
end

-- 秘境探索 放弃战斗
function FightProto:RogueMapFightQuit()
    local proto = {"FightProtocol:RogueMapFightQuit"}
    NetMgr.net:Send(proto)
end

-- 秘境探索 放弃
function FightProto:RogueMapQuit()
    local proto = {"FightProtocol:RogueMapQuit"}
    NetMgr.net:Send(proto)
end

-- 秘境探索 结束
function FightProto:RogueMapOver(proto)
    RogueMapMgr:Quit(proto)
end

-- 秘境探索 使用道具
function FightProto:RogueMapUseProp()
    local proto = {"FightProtocol:RogueMapUseProp"}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapUsePropRet(proto)
    EventMgr.Dispatch(EventType.RogueMap_Battle_Prop_Use, proto)
end

function FightProto:RogueMapNeedSupport(needSupport, callBack)
    self.rogueMapNeedSupportCallBack = callBack
    local proto = {"FightProtocol:RogueMapNeedSupport", {
        needSupport = needSupport
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapNeedSupportRet(proto)
    if self.rogueMapNeedSupportCallBack then
        self.rogueMapNeedSupportCallBack()
        self.rogueMapNeedSupportCallBack = nil
    end
end

-- 秘境探索 求援
function FightProto:RogueMapRequireHelp(ty, pos)
    local proto = {"FightProtocol:RogueMapRequireHelp", {
        ty = ty,
        pos = pos
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapRequireHelpRet(proto)
    RogueMapMgr:UpdateBattleHelpInfo(proto)
end

-- 秘境探索 求援列表
function FightProto:RogueMapSupportList(group,callBack)
    self.rogueMapSupportListCallBack = callBack
    local proto = {"FightProtocol:RogueMapSupportList", {
        group = group
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapSupportListRet(proto)
    RogueMapMgr:UpdateAssistDatas(proto)
    if self.rogueMapSupportListCallBack then
        self.rogueMapSupportListCallBack(proto)
        self.rogueMapSupportListCallBack = nil
    end
end

-- 秘境探索 求援日志
function FightProto:RogueMapSupportLog(page)
    local proto = {"FightProtocol:RogueMapSupportLog", {
        page = page
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapSupportLogRet(proto)
    RogueMapMgr:UpdateLogDatas(proto)
end

-- 秘境探索 个人求援信息
function FightProto:RogueMapOneSupport(uid, callBack)
    self.rogueMapOneSupportCallBack = callBack
    local proto = {"FightProtocol:RogueMapOneSupport", {
        uid = uid
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapOneSupportRet(proto)
    RogueMapMgr:UpdateSupportDatas(proto)
    if self.rogueMapOneSupportCallBack then
        self.rogueMapOneSupportCallBack(proto)
        self.rogueMapOneSupportCallBack = nil
    end
end

-- 秘境探索 支援申请战斗
function FightProto:RogueMapSupportApply(data)
    local proto = {"FightProtocol:RogueMapSupportApply", data}
    NetMgr.net:Send(proto)
end

-- 秘境探索 支援战斗结束
function FightProto:RogueMapSupportFightOver(proto)
    FightOverTool.OnRogueMapSupportOver(proto)
end

-- 秘境探索 求援信息更新[返回给求援者]
function FightProto:RogueMapSupportUpdate(proto)
    RogueMapMgr:UpdateAssistInfo(proto,true)
end

-- 秘境探索 支援撤销
function FightProto:RogueMapSupportCancel(index, callBack)
    self.rogueMapSupportCancelCallBack = callBack
    local proto = {"FightProtocol:RogueMapSupportCancel", {
        s_ix = index
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapSupportCancelRet(proto)
    if self.rogueMapSupportCancelCallBack then
        self.rogueMapSupportCancelCallBack(proto)
        self.rogueMapSupportCancelCallBack = nil
    end
end

-- 秘境探索 领取奖励
function FightProto:RogueMapRequireGainReward(ty, index, callBack)
    self.rogueMapRequireGainRewardCallBack = callBack
    local proto = {"FightProtocol:RogueMapRequireGainReward", {
        ty = ty,
        s_ix = index
    }}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapRequireGainRewardRet(proto)
    if self.rogueMapRequireGainRewardCallBack then
        self.rogueMapRequireGainRewardCallBack(proto)
        self.rogueMapRequireGainRewardCallBack = nil
    end
end

-- 秘境探索 次数购买返回
function FightProto:RogueMapBuyRollRet(proto)
    LanguageMgr:ShowTips(50015,proto and proto.buyCnt or 1)
    RogueMapMgr:UpdateRollNum(proto)
end

function FightProto:RogueMapPassWindow()
    local proto = {"FightProtocol:RogueMapPassWindow"}
    NetMgr.net:Send(proto)
end

-- 秘境探索 格子数据变动
function FightProto:RogueMapUpdateMap(proto)
    RogueMapMgr:ApplyUpdateMistInfo(proto)
end

-- 秘境探索 危险等级修改
function FightProto:RogueMapLevelSet(isLock,level,callBack)
    self.rogueMapLevelSetCallBack = callBack
    local proto = {"FightProtocol:RogueMapLevelSet",{lockLevel = isLock,setLevel = level}}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapLevelSetRet(proto)
    RogueMapMgr:SetChangeLevel(proto)
    if self.rogueMapLevelSetCallBack then
        self.rogueMapLevelSetCallBack(proto)
        self.rogueMapLevelSetCallBack = nil
    end
end

function FightProto:RogueMapSelectBuff(index,type,callBack)
    self.rogueMapSelectBuffCallBack = callBack
    local proto = {"FightProtocol:RogueMapSelectBuff",{idx = index,ty = type}}
    NetMgr.net:Send(proto)
end

function FightProto:RogueMapSelectBuffRet(proto)
    if self.rogueMapSelectBuffCallBack then
        self.rogueMapSelectBuffCallBack()
        self.rogueMapSelectBuffCallBack = nil
    end
    RogueMapMgr:UpdateBuffs(proto)
end

function FightProto:RogueMapFriendNeedSupport()
    RogueMapMgr:SetAssistNew(true)
    RogueMapMgr:CheckRedPointData()
end

---------------------多队玩法
function FightProto:GetMultTeamData(id,round)
    local proto={"FightProtocol:GetMultTeamData",{id=id,round=round}}
    NetMgr.net:Send(proto)
end

function FightProto:GetMultTeamDataRet(proto)
    MultTeamBattleMgr:Update(proto);
end

function FightProto:EnterMultTeamFight(id,round,dupId,list)
    local proto={"FightProtocol:EnterMultTeamFight",{id=id,round=round,dupId=dupId,list=list}}
    NetMgr.net:Send(proto)
end

function FightProto:GetSettleReward(id)
    local proto={"FightProtocol:GetSettleReward",{id=id}}
    NetMgr.net:Send(proto)
end

--结算
function FightProto:MultTeamFightOver(proto)
    MultTeamBattleMgr:UpdateCurData(proto);
    FightOverTool.OnMultTeamBattleOver(proto)
end

---------------------深塔计划
function FightProto:GetTowerDeepInfo(id)
    local proto={"FightProtocol:GetTowerDeepInfo",{id=id}}
    NetMgr.net:Send(proto)
end

function FightProto:GetTowerDeepInfoRet(proto)
    TowerMgr:SetDeepDatas(proto)
end

--进入副本
function FightProto:EnterTowerDeepDuplicate(data)
    local proto={"FightProtocol:EnterTowerDeepDuplicate",data}
    NetMgr.net:Send(proto)
end

--进入战斗
function FightProto:EnterTowerDeepFight(_round,_cb)
    self.enterTowerDeepFightCallBack = _cb
    local proto={"FightProtocol:EnterTowerDeepFight",{round = _round}}
    NetMgr.net:Send(proto)
end

function FightProto:EnterTowerDeepFightRet(proto)
    if self.enterTowerDeepFightCallBack then
        self.enterTowerDeepFightCallBack(proto)
        self.enterTowerDeepFightCallBack= nil
    end
end

function FightProto:TowerDeepFightOver(proto)
    local isSurrender = FightClient:IsSurrender();
    FightOverTool.TowerDeepInfoUpdate(proto, isSurrender)
end
---------------------连锁战线
function FightProto:GetChainFrontInfo()
    local proto = {"FightProtocol:GetChainFrontInfo"}
    NetMgr.net:Send(proto)
end

function FightProto:GetChainFrontInfoRet(proto)
    TrialsMgr:UpdateData(proto)
end

function FightProto:EnterChainFrontDuplicate(data)
    local proto = {"FightProtocol:EnterChainFrontDuplicate", data}
    NetMgr.net:Send(proto)
end

function FightProto:EnterChainFrontFight(round, cb)
    self.enterChainFrontFightCallBack = cb
    local proto = {"FightProtocol:EnterChainFrontFight", {
        round = round
    }}
    NetMgr.net:Send(proto)
end

function FightProto:EnterChainFrontFightRet(proto)
    if self.enterChainFrontFightCallBack then
        self.enterChainFrontFightCallBack(proto)
        self.enterChainFrontFightCallBack = nil
    end
end

function FightProto:ChainFrontFightOver(proto)
    local isSurrender = FightClient:IsSurrender();
    FightOverTool.Trials2InfoUpdate(proto, isSurrender)
end

--历战挑战关卡分数下发
function FightProto:TrialChallengeScoreRet(proto)
    TrialsMgr:SetTrialsFightOverInfo(proto)
end

function FightProto:UpdateChainFrontTeam(data,callBack)
    self.updateChainFrontTeamCallBack =callBack
    local proto = {"FightProtocol:UpdateChainFrontTeam", data}
    NetMgr.net:Send(proto)
end

function FightProto:UpdateChainFrontTeamRet(proto)
    if proto and proto.code and proto.code == 1 then
        TrialsMgr:UpdateFightingInfo(proto.progressInfo)
        if self.updateChainFrontTeamCallBack then
            self.updateChainFrontTeamCallBack(proto)
            self.updateChainFrontTeamCallBack = nil
        end
    end
end

function FightProto:GiveUpChainFront(groupId,callBack)
    self.giveUpChainFrontCallBack = callBack
    local proto = {"FightProtocol:GiveUpChainFront", {id = groupId}}
    NetMgr.net:Send(proto)
end

function FightProto:GiveUpChainFrontRet(proto)
    if self.giveUpChainFrontCallBack then
        self.giveUpChainFrontCallBack(proto)
        self.giveUpChainFrontCallBack = nil
    end
    if proto and proto.code and proto.code == 1 then
        TrialsMgr:UpdateFightingInfo(proto.progressInfo)
    end
end
---------------------建造
function FightProto:DuplicateBuild(type,dupId,index,callBack)
    self.duplicateBuildCallBack = callBack
    local proto = {"FightProtocol:DuplicateBuild", {
        ty = type,
        nDuplicateID = dupId,
        buildIdx = index
    }}
    NetMgr.net:Send(proto)
end

function FightProto:DuplicateBuildRet(proto)
    if self.duplicateBuildCallBack then
        self.duplicateBuildCallBack(proto)
        self.duplicateBuildCallBack = nil
    end
end
---------------------周期boss
--请求周期BOSS数据
function FightProto:GetPeriodicBossInfo(callBack)
    self.periodicBossInfoCallBack = callBack
    local proto = {"FightProtocol:GetPeriodicBossInfo"}
    NetMgr.net:Send(proto)
end
--请求周期BOSS数据返回
function FightProto:GetPeriodicBossInfoRet(proto)
    PeriodicBossMgr:UpdateDatas(proto)
    if self.periodicBossInfoCallBack then
        self.periodicBossInfoCallBack(proto)
        self.periodicBossInfoCallBack = nil
    end
end
--周期BOSS进入战斗
function FightProto:PeriodicBossEnterFight(data)
    local proto = {"FightProtocol:PeriodicBossEnterFight",data}
    NetMgr.net:Send(proto)
end
--周期BOSS战斗结束返回
function FightProto:PeriodicBossFightOver(proto)
     FightOverTool.OnPeriodicBossOver(proto)
end

