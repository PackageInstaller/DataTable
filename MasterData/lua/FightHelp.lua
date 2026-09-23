function LogEnterFight(oPlayer, fid, sceneType, nDuplicateID, groupID, data)
    -- LogTable(data)
    --LogDebugEx("LogEnterFight", fid, sceneType, nDuplicateID, groupID)
    local logdata = {}
    for tid, v in ipairs(data.data) do
        local item = {v.cid, v.data.cuid}
        item.fuid = v.fuid
        item.npcid = v.npcid
        item.skills = v.data.skills
        table.insert(logdata, item)
    end
    -- LogTable(logdata, "logdata")

    -- 操作日志
    -- StatsMgr:AddLogRecord(oPlayer, LogItem.EnterFight, fid, sceneType, nDuplicateID, groupID, table.Encode(logdata))
    SSSDK:Event(
        oPlayer,
        'EnterFight',
        {
            fid = fid,
            duplicate_id = nDuplicateID,
            sceneType = sceneType,
            groupID = groupID,
            team_data = logdata,
        }
    )
end

-------------------------------------
FightHelp = {}

function FightHelp:Init()
    self.mapPlayerMgr = {}
    -- 玩家对应的战斗管理器
    self.lstMgr = {}
    -- 所有正在进行中的战斗
    self.cache = {}
    -- 缓存正在战斗但玩家已经退出游戏
    self.listPvp = {}
    -- 进行中的pvp战斗
    GameApp:Timeout(1, self:OnTimer())
end

function FightHelp:AddFightMgr(uids, mgr)
    for i, uid in ipairs(uids) do
        if FightHelp:GetFightMgrEx(uid) then 
            FightHelp:Destroy(uid)
            -- ASSERT(nil, "查bug用, 该玩家有战斗未销毁")
        end

        FightHelp.mapPlayerMgr[uid] = mgr
    end

    FightHelp.lstMgr[mgr.id] = mgr
end

function FightHelp:GetFightMgr(uid)
    return FightHelp.mapPlayerMgr[uid]
end

-- 获取战斗管理器(包括缓存)
function FightHelp:GetFightMgrEx(uid)
    return FightHelp.cache[uid] or FightHelp.mapPlayerMgr[uid]
end

--------------------------------------------------------------
-- nDuplicateID 100以内为预留活动战斗
function FightHelp:StartPveFight(player, nDuplicateID, groupID, data, exData, seed2)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data)
    -- ASSERT()
    local fid = UID(10)
    local seed = seed2 or (os.time() + math.random(10000))
    --LogDebugEx("FightHelp:StartPveFight",  seed, seed2)
    local mgr = CreateFightMgr(fid, groupID, SceneType.PVEBuild, seed, nDuplicateID)
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    data.data = Halo:Calc(data.data)

    exData = exData or {}
    exData.nEnterNp = {data.nEnterNp, 0}

    mgr:LoadConfig(groupID, 1)
    -- LogTrace("FightHelp:StartPveFight1")
    if exData.nSkillGroup then
        data.tCommanderSkill = player:GetCommanderSkill(exData.nSkillGroup)
    --data.tCommanderSkill = tCommanderSkill
    -- LogTable(tCommanderSkill, "FightHelp:StartPveFight1")
    end
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)

    mgr:AfterLoadData(exData)
    -- mgr.cbOver = function(self, winer, isForceOver)
    -- end
    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = SceneType.PVEBuild,
            groupID = groupID,
            teamID = 1,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- -- LogTable(info)
    -- local logdata = {}
    -- for tid,info in ipairs(data.data) do
    -- 	local item = {v.cid, v.data.cuid}
    -- 	item.fuid  = v.fuid
    -- 	item.npcid = v.npcid
    -- 	table.insert(logdata , item)
    -- end
    -- 操作日志
    LogEnterFight(player, fid, SceneType.PVEBuild, nDuplicateID, groupID, data)
    -- StatsMgr:AddLogRecord(
    --     player,
    --     LogItem.EnterFight,
    --     fid,
    --     SceneType.PVEBuild,
    --     nDuplicateID,
    --     groupID,
    --     table.Encode(logdata)
    -- )
    return mgr
end

function FightHelp:FightByData(player, oData)
        -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data)
    -- ASSERT()
    local fid = UID(10)
    local seed = oData.seed--os.time() + math.random(10000)
    --print("------------", nDuplicateID)
    local mgr = RestoreFightMgrServer(fid, oData.groupID, SceneType.PVEBuild, seed, PveDupId.Build)     --CreateFightMgr(fid, oData.groupID, SceneType.PVEBuild, seed, PveDupId.Build)
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    mgr:LoadConfig(oData.groupID, 1)

    mgr:LoadData(1, oData.data.data, nil, oData.data.tCommanderSkill)

    mgr:AfterLoadData(oData.exData)
    -- mgr.cbOver = function(self, winer, isForceOver)
    -- end
    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = SceneType.PVEBuild,
            groupID = oData.groupID,
            teamID = 1,
            data = oData.data,
            exData = oData.exData,
            level = player:Get('level')
        }
    )
    -- -- LogTable(info)
    -- local logdata = {}
    -- for tid,info in ipairs(data.data) do
    -- 	local item = {v.cid, v.data.cuid}
    -- 	item.fuid  = v.fuid
    -- 	item.npcid = v.npcid
    -- 	table.insert(logdata , item)
    -- end
    -- 操作日志
    LogEnterFight(player, fid, SceneType.PVEBuild, PveDupId.Build, oData.groupID, oData.data)
    -- StatsMgr:AddLogRecord(
    --     player,
    --     LogItem.EnterFight,
    --     fid,
    --     SceneType.PVEBuild,
    --     nDuplicateID,
    --     groupID,
    --     table.Encode(logdata)
    -- )
    return mgr
end

function FightHelp:StartFightBySceneType(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, sceneType)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data, "StartMainLineFight data =")
    -- LogTable(exData, "exData")
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, sceneType, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({ player.id }, mgr)

    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end
    local dupCfg = MainLine[nDuplicateID]

    if dupCfg and (dupCfg.type == eDuplicateType.AbattoirRand or dupCfg.type == eDuplicateType.AbattoirSelect) then
        exData = exData or {}
        exData.dupId = nDuplicateID
    end
    mgr:AddCmd(
            CMD_TYPE.InitData,
            {
                seed = seed,
                fid = fid,
                stype = sceneType,
                groupID = groupID,
                teamID = 1,
                nTeamIndex = nTeamIndex,
                data = data,
                exData = exData,
                level = player:Get('level')
            }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, sceneType, nDuplicateID, groupID, data)
    return mgr
end

-- 开始主线战斗
function FightHelp:StartMainLineFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData)
    return self:StartFightBySceneType(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, SceneType.PVE)
end

---- 开始连锁战线战斗
function FightHelp:StartChainFrontFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, sceneTy,buffId)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data, "StartMainLineFight data =")
    -- LogTable(exData, "exData")
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, sceneTy, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)
    exData = exData or {}
    exData.dupId = nDuplicateID
    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    local buffs = {}
    if buffId and buffId > 0 then
         -- 添加我们buff词条
        table.insert(buffs,{type = 1,id = buffId}) 
    end
    -- 添加敌方buff词条
    local dupCfg = MainLine[nDuplicateID]
    for _,bId in ipairs(dupCfg and dupCfg.entry or {}) do
        table.insert(buffs,{type = 2,id = bId})
    end
    GCalHelp:GetChainFrontExdata(buffs, exData, data.data)  
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = sceneTy,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, sceneTy, nDuplicateID, groupID, data)
    return mgr
end
---- 开始新爬塔战斗
function FightHelp:StartTowerDeepFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, sceneTy)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data, "StartMainLineFight data =")
    -- LogTable(exData, "exData")
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, sceneTy, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)
    exData = exData or {}
    exData.dupId = nDuplicateID
    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    -- if table.empty(exData) then
    --     exData = nil
    -- end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = sceneTy,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, sceneTy, nDuplicateID, groupID, data)
    return mgr
end

---- 开始乱序演习战斗
function FightHelp:StartRogueFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, sceneTy)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data, "StartMainLineFight data =")
    -- LogTable(exData, "exData")
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, sceneTy, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = sceneTy,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, sceneTy, nDuplicateID, groupID, data)
    return mgr
end

---- 开始多队玩法战斗
function FightHelp:StartMultTeamFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData, sceneTy)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- LogTable(data, "StartMainLineFight data =")
    -- LogTable(exData, "exData")
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, sceneTy, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate
    mgr.nPlayerLevel = player:Get('level')
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)
    data.data = Halo:Calc(data.data)

    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = sceneTy,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, sceneTy, nDuplicateID, groupID, data)
    return mgr
end


---- 开始小地图探索战斗
function FightHelp:StartRogueMapFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, SceneType.RogueMap, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex
    mgr.oDuplicate = oDuplicate

    local dLevel = GCalHelp:GetRogueMapDangerLevel(oDuplicate.nExp)
    mgr.nPlayerLevel = dLevel
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = SceneType.RogueMap,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = dLevel
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, SceneType.RogueMap, nDuplicateID, groupID, data)
    return mgr
end


---- 开始小地图探索支援战斗
function FightHelp:StartRogueMapSupportFight(player, nDuplicateID, groupID, data, oDuplicate, nTeamIndex, exData)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    -- ASSERT()
    local fid = UID(10)
    local seed = os.time() + math.random(1000000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, SceneType.RogueMapSup, seed, nDuplicateID)
    mgr.nTeamIndex = nTeamIndex

    mgr.nPlayerLevel = exData.plrDLevel
    mgr.uid = player.id

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    LogTable(exData, "exData")
    mgr:LoadConfig(groupID, exData.stage or 1, exData.hpinfo)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = SceneType.RogueMapSup,
            groupID = groupID,
            teamID = 1,
            nTeamIndex = nTeamIndex,
            data = data,
            exData = exData,
            level = exData.plrDLevel
        }
    )
    -- DT(mgr.cmds)
    -- 操作日志
    LogEnterFight(player, fid, SceneType.RogueMapSup, nDuplicateID, groupID, data)
    return mgr
end

--------------------------------------------------------------
function FightHelp:StartPvpFight(data, fightIndex, buffIds)
    local fid = UUID(10)
    local seed = os.time() + math.random(10000)

    local mgr = CreateFightMgr(fid, groupID, SceneType.PVP, seed)
    local uids = {}
    local exData = {
        tAllBuff = {}
    }

    if buffIds then
        table.copy(buffIds, exData.tAllBuff)
    end

    -- LogTable(data,"StartPvpFight111111111111111111111")
    for i, v in ipairs(data) do
        v.data = Halo:Calc(v.data)
    end

    --LogTable(data,"StartPvpFight222222222222222222222")
    for i, v in ipairs(data) do
        LogTable(v, "StartPvpFight() i:" .. i)

        if not v.robotId then
            local conn = ArmyFighDataMgr:GetPlrConn(v.uid)
            conn:send({'FightProto:PvpFightResult', {data = data}})
        end

        mgr:AddPlayer(v.uid, i)
        table.insert(uids, v.uid)
        mgr:LoadData(i, v.data)

        if v.nEnterNp and v.nEnterNp > 0 then
            exData.nEnterNp = exData.nEnterNp or {0, 0}
            exData.nEnterNp[i] = v.nEnterNp
        end

        -- 统计日志
        -- LogEnterFight(GetPlayer(v.uid), fid, SceneType.PVP, 0, 0, v)
    end
    self:AddFightMgr(uids, mgr)

    -- 设置战斗完成回调
    mgr.cbOver = function(self, winer, isForceOver)
        ArmyFighDataMgr:OnFinish(fightIndex, winer, isForceOver)
    end
    mgr:SetStepLimit(g_sPVPStepLimit)

    mgr:AfterLoadData(exData or {})
    -- LogTable({seed = seed, stype = SceneType.PVP, data = data}, "SceneType.PVP")
    mgr:AddCmd(CMD_TYPE.InitData, {seed = seed, fid = fid, stype = SceneType.PVP, tPvpData = data, exData = exData})
end

-- pvp 镜像
function FightHelp:StartPvpMirrorFight(plr, tData, tMirror, sceneType, cbOver, buffIds)
    --LogTrace()
    LogTable({tData, tMirror}, 'FightHelp:StartPvpMirrorFight')
    ASSERT(#tMirror.data > 0, '镜像数据为空')

    local fid = UUID(10)
    local seed = os.time() + math.random(10000)

    local mgr = CreateFightMgr(fid, groupID, sceneType, seed)

    local attackerId = tData.uid
    local defenderId = tMirror.uid
    local player = plr

    mgr.uid = player.id
    mgr.cbOver = cbOver
    if IsPvpSceneType(sceneType) then
        mgr:SetStepLimit(g_sPVPStepLimit)
    else
        mgr:SetStepLimit(g_sPVPMirrorStepLimit)
    end

    -- self.listPvp[tData.uid] = tData.data
    -- player:Send("FightProto:PvpFightResult", {tData = data, tMirror = tMirror}, encod)
    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({tData.uid}, mgr)

    -- 玩家数据
    tData.data = Halo:Calc(tData.data)
    mgr:LoadData(1, tData.data)

    -- 镜像数据
    if tMirror.is_robot == BoolType.Yes then
    else
        tMirror.data = Halo:Calc(tMirror.data)
    end
    mgr:LoadData(2, tMirror.data, CardType.Mirror)
    -- 加载为镜像

    local np = player.oLifeBufMgr:GetBufAddVal('army_np_add')
    -- tMirror.nEnterNp = tMirror.nEnterNp or 0
    local exData = {
        nEnterNp = {np, tMirror.nEnterNp or 0}
        , emotes = {
            tData.icon_emotes or table.copy(g_BattleFaceSet),
            tMirror.icon_emotes or table.copy(g_BattleFaceSet),
        }
        , tAllBuff = {}
    }
    
    if buffIds then
        table.copy(buffIds, exData.tAllBuff)
    end

    mgr:AfterLoadData(exData or {})
    -- LogTable({tData, tMirror}, "FightHelp:StartPvpMirrorFight")
    -- LogTable({seed = seed, stype = SceneType.PVPMirror, tData = tData, tMirror = tMirror}, "SceneType.PVPMirror")
    mgr:AddCmd(
        CMD_TYPE.InitData,
        {seed = seed, fid = fid, stype = sceneType, tPvpData = {tData, tMirror}, exData = exData}
    )
    -- LogError("-----------")
    -- 操作日志
    LogEnterFight(player, fid, sceneType, 0, 0, tData)
end

-- pvp 镜像
function FightHelp:GetPvpDataFromPlr(plr, nTeamIndex)
    local tData = {
        uid = plr:Get('uid'),
        data = {},
        nEnterNp = plr.oLifeBufMgr:GetBufAddVal('army_np_add'),
        icon_emotes = plr:GetMix('icon_emotes') or  table.copy(g_BattleFaceSet)
    }

    local oCardMgr = plr.oCardMgr
    local oTeamMgr = plr.oTeamMgr

    local teamdata = oTeamMgr:Get(nTeamIndex)
    if teamdata and #teamdata.data > 0 then
        for i, v in ipairs(teamdata.data) do
            local card = oCardMgr:GetCard(v.cid)
            local carddata = card:GetData(SceneType.PVP, v.nStrategyIndex)
            carddata.level = card.level
            carddata.row = v.row
            carddata.col = v.col
            carddata.cuid = v.cid
            table.insert(
                tData.data,
                {
                    row = v.row,
                    col = v.col,
                    cid = card.id,
                    uid = tData.uid,
                    data = carddata
                }
            )
        end
    else
        return nil
    end

    plr.oCardMgr:RemoveExcludeSkill(tData.data)

    return tData
end



-- 将客户端发过来的卡牌信息
-- [16:21:38][DEBUG] Client Recv
--     {
--         [ 1 ]n = [ "ArmyProto:StartRealArmy" ]s
--         [ 2 ]n =
--         {
--             [ "team" ]s =
--             {
--                 [ "index" ]s = [ 23 ]f
--                 [ "data" ]s =
--                 {
--                     [ 1 ]n =
--                     {
--                         [ "index" ]s = [ 1 ]f
--                         [ "bIsNpc" ]s = [ 'false' ]boolean
--                         [ "nStrategyIndex" ]s = [ 2 ]f
--                         [ "row" ]s = [ 2 ]f
--                         [ "col" ]s = [ 1 ]f
--                         [ "card_info" ]s =
--                         {
--                             [ "name" ]s = [ "丝卡蒂" ]s
--                             [ "break_level" ]s = [ 5 ]f
--                             [ "cfgid" ]s = [ 70240 ]f
--                             [ "performance" ]s = [ 6270 ]f
--                             [ "sp_race" ]s = [ 5 ]f
--                             [ "np" ]s = [ 0 ]f
--                             [ "attack" ]s = [ 2544 ]f
--                             [ "exp" ]s = [ 7800 ]f
--                             [ "defense" ]s = [ 463 ]f
--                             [ "skin" ]s = [ 7024002 ]f
--                             [ "crit" ]s = [ 1.5 ]f
--                             [ "crit_rate" ]s = [ 0.079999998211861 ]f
--                             [ "skinIsl2d" ]s = [ 2 ]f
--                             [ "sub_talent" ]s =
--                             {
--                                 [ "had" ]s =
--                                 {
--                                     [ 1 ]n = [ 1075 ]f
--                                     [ 2 ]n = [ 329005 ]f
--                                     [ 3 ]n = [ 1045 ]f
--                                     [ 4 ]n = [ 329105 ]f
--                                 }
--                                 [ "use" ]s =
--                                 {
--                                     [ 1 ]n = [ 1075 ]f
--                                     [ 2 ]n = [ 1045 ]f
--                                     [ 3 ]n = [ 329105 ]f
--                                 }
--                             }
--                             [ "skinIsl2d_a" ]s = [ 1 ]f
--                             [ "mix_data" ]s =
--                             {
--                                 [ "cl" ]s = [ 1 ]f
--                             }
--                             [ "sp" ]s = [ 50 ]f
--                             [ "hp" ]s = [ 3 ]f
--                             [ "resist" ]s = [ 0.10000000149012 ]f
--                             [ "hit" ]s = [ 0.15000000596046 ]f
--                             [ "speed" ]s = [ 123 ]f
--                             [ "maxhp" ]s = [ 10557 ]f
--                             [ "skin_a" ]s = [ 0 ]f
--                             [ "skills" ]s =
--                             {
--                                 [ 1 ]n = [ 329105 ]f
--                                 [ 2 ]n = [ 4702405 ]f
--                                 [ 3 ]n = [ 702400105 ]f
--                                 [ 4 ]n = [ 702400205 ]f
--                                 [ 5 ]n = [ 702400305 ]f
--                                 [ 6 ]n = [ 702401305 ]f
--                             }
--                             [ "level" ]s = [ 70 ]f
--                             [ "intensify_level" ]s = [ 1 ]f
--                             [ "cid" ]s = [ 70240 ]f
--                         }
--                         [ "cid" ]s = [ 70240 ]f
--                     }
--                 }
--                 [ "nReserveNP" ]s = [ 0 ]f
--                 [ "bIsReserveSP" ]s = [ 'false' ]boolean
--                 [ "leader" ]s = [ 70240 ]f
--             }
--         }
--     }
-- 替换为如下的战斗需要使用的结构
--》 [18:00:40][DEBUG] Card:GetData():
--》     {
--》         [ "use_sub_talent" ]s = 
--》         {
--》             [ 1 ]n = [ 329205 ]f
--》             [ 2 ]n = [ 1025 ]f
--》             [ 3 ]n = [ 1015 ]f
--》         }
--》         [ "quality" ]s = [ 4 ]f
--》         [ "skills" ]s = 
--》         {
--》             [ 1 ]n = [ 329205 ]f
--》             [ 2 ]n = [ 4102105 ]f
--》             [ 3 ]n = [ 102100105 ]f
--》             [ 4 ]n = [ 102100205 ]f
--》             [ 5 ]n = [ 102100305 ]f
--》             [ 6 ]n = [ 102101305 ]f
--》         }
--》         [ "level" ]s = [ 60 ]f
--》         [ "nStep" ]s = [ 0 ]f
--》         [ "nJump" ]s = [ 0 ]f
--》         [ "real_cid" ]s = [ 10210 ]f
--》         [ "fight_cost" ]s = [ 0 ]f
--》         [ "career" ]s = [ 1 ]f
--》         [ "nMoveType" ]s = [ 2 ]f
--》         [ "hp_percent" ]s = [ 1 ]f
--》         [ "model" ]s = [ 1021002 ]f
--》         [ "np" ]s = [ 0 ]f
--》         [ "name" ]s = [ "鑼舵櫠" ]s
--》         [ "maxhp" ]s = [ 8428 ]f
--》         [ "defense" ]s = [ 423 ]f
--》         [ "speed" ]s = [ 106 ]f
--》         [ "crit" ]s = [ 1.6 ]f
--》         [ "crit_rate" ]s = [ 0.086 ]f
--》         [ "hit" ]s = [ 0.05 ]f
--》         [ "resist" ]s = [ 0 ]f
--》         [ "performance" ]s = [ 3693 ]f
--》         [ "sp_race" ]s = [ 5 ]f
--》         [ "sp_race2" ]s = [ 10 ]f
--》         [ "id" ]s = [ 10210 ]f
--》         [ "passivBufIds" ]s = 
--》         {
--》        
--》         }
--》         [ "aiSetting" ]s = 
--》         {
--》             [ 1 ]n = 
--》             {
--》                 [ "skillStrategy" ]s = 
--》                 {
--》                     [ 1 ]n = [ 1 ]f
--》                 }
--》                 [ "aiStrategy" ]s = 
--》                 {
--》                     [ 1 ]n = [ 6 ]f
--》                 }
--》                 [ "skillID" ]s = [ 102100105 ]f
--》             }
--》             [ 2 ]n = 
--》             {
--》                 [ "skillStrategy" ]s = 
--》                 {
--》                     [ 1 ]n = [ 2 ]f
--》                 }
--》                 [ "aiStrategy" ]s = [ .Card:GetData():.aiSetting.1.aiStrategy ]t
--》                 [ "skillID" ]s = [ 102100205 ]f
--》             }
--》             [ 3 ]n = 
--》             {
--》                 [ "skillStrategy" ]s = 
--》                 {
--》                     [ 1 ]n = [ 5 ]f
--》                     [ 2 ]n = [ 2 ]f
--》                     [ 3 ]n = [ 3 ]f
--》                     [ 4 ]n = [ 0 ]f
--》                 }
--》                 [ "skillID" ]s = [ 102100305 ]f
--》             }
--》             [ "bOverLoad" ]s = [ 'false' ]boolean
--》         }
--》         [ "max_level" ]s = [ 70 ]f
--》         [ "gold_add" ]s = [ 0 ]f
--》         [ "plr_exp_add" ]s = [ 0 ]f
--》         [ "card_exp_add" ]s = [ 0 ]f
--》         [ "hot" ]s = [ 100 ]f
--》         [ "attack" ]s = [ 1844 ]f
--》         [ "break_level" ]s = [ 4 ]f
--》         [ "intensify_level" ]s = [ 1 ]f
--》         [ "eskills" ]s = 
--》         {
--》             [ 1 ]n = [ 10201 ]f
--》             [ 2 ]n = [ 20302 ]f
--》             [ 3 ]n = [ 21202 ]f
--》             [ 4 ]n = [ 10302 ]f
--》             [ 5 ]n = [ 10701 ]f
--》         }
--》         [ "nStrategyIndex" ]s = [ 1 ]f
--》         [ "sp" ]s = [ 50 ]f
--》     }

function GetFightDataFromTeamData(cardData)
    local ret = {}
    local cardCfg = CardData[cardData.cfgid]

    local cpFields = {
        'quality', 'skills', 'level', 'np', 'name', 'maxhp', 'defense', 'speed', 'crit', 'crit_rate', 'hit', 'resist'
        , 'performance', 'sp_race', 'sp_race2', 'attack', 'break_level', 'intensify_level', 'sp'
    }
    for _, k in ipairs(cpFields) do
        ret[k] = cardData[k]
    end

    local cpCfgFields = { 'id', 'fight_cost', 'career', 'nMoveType', 'model' }
    for _, k in ipairs(cpCfgFields) do
        ret[k] = cardCfg[k]
    end


    ret.cfgid = cardData.cfgid
    ret.use_sub_talent = cardData.sub_talent.use
    ret.nStep = 0
    ret.nJump = 0
    ret.real_cid = cardData.cid
    ret.hp_percent = 1
    ret.eskills = cardData.equip_skills or {}
    if cardData.skin and cardData.skin > 0 then
        ret.model = cardData.skin
    end

    if cardData.skin_a and cardData.skin_a > 0 then
        ret.modelA = cardData.skin_a
    end

    return ret
end

function FightHelp:GetPvpDataFromTeam(uid, teamData, icon_emotes)
    local tData = {
        uid = uid,
        index = teamData.index,
        data = {},
        icon_emotes = icon_emotes or {1,1,1}
    }

    local excludeSkills = {}
    if teamData and #teamData.data > 0 then
        for i, v in ipairs(teamData.data) do
            local cardData = GetFightDataFromTeamData(v.pvp_card_info)
            
            GCalHelp:RegisterExcludeSkill(cardData.cfgid, cardData.eskills, excludeSkills)

            cardData.row = v.row
            cardData.col = v.col
            cardData.cuid = v.cid
            cardData.nStrategyIndex = v.nStrategyIndex
            table.insert(
                tData.data,
                {
                    row = v.row,
                    col = v.col,
                    cid = v.cid,
                    uid = tData.uid,
                    data = cardData
                }
            )
        end
    else
        return nil
    end

    GCalHelp:RemoveExcludeSkill(tData.data, excludeSkills)

    return tData
end

--------------------------------------------------------------
-- 世界BOSS
function FightHelp:StartBossFight(player, nDuplicateID, groupID, data, exData)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    local fid = UID(10)
    local seed = os.time() + math.random(10000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, SceneType.BOSS, seed, nDuplicateID)
    mgr.nPlayerLevel = player:Get('level')
    mgr.playerID = player.uid
    mgr.oPlayer = player

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    data.data = Halo:Calc(data.data)

    exData = exData or {}
    -- exData.nEnterNp = {data.nEnterNp, 0}
    mgr.nBossLevel = exData.nBossLevel
    mgr.nCastTP = exData.nCastTP
    mgr.nTPCastRate = g_TPCastRate[mgr.nCastTP]

    local oboss = mgr:LoadBossConfig(groupID, 1)
    oboss.maxhp = exData.bossMaxHp
    oboss.hp = exData.bossHp

    mgr:LoadData(1, data.data)

    mgr:AfterLoadData(exData)
    -- mgr.cbOver = function(self, winer, isForceOver)
    -- end
    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = SceneType.BOSS,
            groupID = groupID,
            teamID = 1,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- 操作日志
    LogEnterFight(player, fid, SceneType.BOSS, nDuplicateID, groupID, data)

    return mgr
end

--------------------------------------------------------------
-- 工会BOSS
function FightHelp:StartRoomBossFight(player, nDuplicateID, groupID, data, exData, nSceneType)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    local fid = UID(10)
    local seed = os.time() + math.random(10000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, nSceneType, seed, nDuplicateID)
    mgr.nPlayerLevel = player:Get('level')
    mgr.playerID = player.uid
    mgr.uid = player.id
    mgr.oPlayer = player

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    data.data = Halo:Calc(data.data)

    exData = exData or {}
    -- exData.nEnterNp = {data.nEnterNp, 0}
    mgr.nBossLevel = exData.nBossLevel
    mgr.nTPCastRate = 1

    local oboss = mgr:LoadBossConfig(groupID, 1)
    oboss.maxhp = exData.bossMaxHp
    oboss.hp = exData.bossHp

    mgr:LoadData(1, data.data)

    mgr:AfterLoadData(exData)

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = nSceneType,
            groupID = groupID,
            teamID = 1,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- 操作日志
    LogEnterFight(player, fid, nSceneType, nDuplicateID, groupID, data)

    return mgr
end

--------------------------------------------------------------
-- -- 新世界boss
function FightHelp:StartGlobalBossFight(player, nDuplicateID, groupID, data, exData, nSceneType,buffs)
    -- DT(player)
    -- 战斗管理器的id
    --ASSERT(nDuplicateID)
    local fid = UID(10)
    local seed = os.time() + math.random(10000)
    --print("------------", nDuplicateID)
    local mgr = CreateFightMgr(fid, groupID, nSceneType, seed, nDuplicateID)
    mgr.nPlayerLevel = player:Get('level')
    mgr.playerID = player.uid
    mgr.uid = player.id
    mgr.oPlayer = player

    mgr:AddPlayer(player.id, 1)
    self:AddFightMgr({player.id}, mgr)

    data.data = Halo:Calc(data.data)

    exData = exData or {}
    -- exData.nEnterNp = {data.nEnterNp, 0}
    mgr.nBossLevel = exData.nBossLevel
    mgr.nTPCastRate = 1

    local oboss = mgr:LoadBossConfig(groupID, 1)
    oboss.maxhp = exData.bossMaxHp
    oboss.hp = exData.bossHp
    -- boss技能添加
    GCalHelp:GetGlobalBossAddSkill(oboss,exData.bossId)
    -- 添加词条
    GCalHelp:GetGlobalBossExdata(buffs, exData, data.data)

    mgr:LoadData(1, data.data)

    mgr:AfterLoadData(exData)

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            fid = fid,
            stype = nSceneType,
            groupID = groupID,
            teamID = 1,
            data = data,
            exData = exData,
            level = player:Get('level')
        }
    )
    -- 操作日志
    LogEnterFight(player, fid, nSceneType, nDuplicateID, groupID, data)

    return mgr
end

--------------------------------------------------------------
-- -- 战场系统boss
-- function FightHelp:StartFieldBossFight(player, nDuplicateID, groupID, data, exData)
--     -- DT(player)
--     -- 战斗管理器的id
--     --ASSERT(nDuplicateID)
--     local fid = UID(10)
--     local seed = os.time() + math.random(10000)
--     --print("------------", nDuplicateID)
--     local mgr = CreateFightMgr(fid, groupID, SceneType.FieldBoss, seed, nDuplicateID)
--     mgr.nPlayerLevel = player:Get("level")
--     mgr.playerID = player.uid
--     mgr.oPlayer = player

--     mgr:AddPlayer(player.id, 1)
--     self:AddFightMgr({player.id}, mgr)

--     data.data = Halo:Calc(data.data)

--     exData = exData or {}
--     -- exData.nEnterNp = {data.nEnterNp, 0}
--     mgr.nBossLevel = exData.nBossLevel

--     local oboss = mgr:LoadBossConfig(groupID, 1)
--     oboss.maxhp = exData.bossMaxHp
--     oboss.hp = exData.bossHp

--     mgr:LoadData(1, data.data)

--     mgr:AfterLoadData(exData)
--     -- mgr.cbOver = function(self, winer, isForceOver)
--     -- end
--     mgr:AddCmd(
--         CMD_TYPE.InitData,
--         {
--             seed = seed,
--             fid = fid,
--             stype = SceneType.FieldBoss,
--             groupID = groupID,
--             teamID = 1,
--             data = data,
--             exData = exData,
--             level = player:Get("level")
--         }
--     )
--     -- 操作日志
--     LogEnterFight(player, fid, SceneType.FieldBoss, nDuplicateID, groupID, data)

--     return mgr
-- end
--------------------------------------------------------------
function FightHelp:WriteMonterData(formId, monsterIds, retData, uid)
    LogDebug("WriteMonterData() formId:%s, monsterIds:%s, uid:%s", formId, monsterIds, uid)

    -- 阵法数据
    local mform = MonsterFormation[formId]
    if not mform then
        LogError("WriteMonterData() formId:%s not cfg from MonsterFormation", formId)
        ASSERT(false)
        return nil
    end

    local index = 1
    for _, mId in ipairs(monsterIds) do
        local mCfg = MonsterData[mId]
        local pos = mform.coordinate[index]
        if mCfg and pos then
            local cardData = table.copy(mCfg)

            cardData.row = pos[1]
            cardData.col = pos[2]

            table.insert(
                retData,
                {row = cardData.row, col = cardData.col, cid = cardData.id, uid = uid, data = cardData}
            )

            index = index + 1
        end
    end
end

function FightHelp:GetPvpDataFromMonsterIds(practiceRobotCfg, useUId)
    local tData = {uid = useUId, data = {}, robotId = practiceRobotCfg.id, is_robot = BoolType.Yes}

    -- 阵法数据
    self:WriteMonterData(practiceRobotCfg.nGridId, practiceRobotCfg.aTeamIds, tData.data, useUId)

    return tData
end

function FightHelp:GetFreeMatchPvpRobotData(robotCfg)
    local tData = {uid = useUId, data = {}, robotId = robotCfg.id, is_robot = BoolType.Yes}

    local len = #robotCfg.aTeamIds
    tData.index = math.random(1, len)
    local monsterGroupId = robotCfg.aTeamIds[tData.index]

    -- 阵法数据
    return self:GetPveFromMonsterGroup(monsterGroupId, tData)
end


function FightHelp:GetPveFromMonsterGroup(id, retDate)
    LogDebug("GetPveFromMonsterGroup() id:%s", id)

    local tData = retDate or {uid = id, data = {}}
    local gCfg = MonsterGroup[id]
    if not gCfg then
        LogError("FightHelp:GetPveFromMonsterGroup() %s can not find cfg from MonsterGroup", id)
        ASSERT(false)
        return nil
    end

    local stage = gCfg.stage[1]

    self:WriteMonterData(stage.formation, stage.monsters, tData.data, id)

    return tData
end

-- 计算生活buffer
function FightHelp:AddLiveBuff(data, damage, bedamage)
    damage = damage or 0
    bedamage = bedamage or 0

    -- 对敌方的伤害增加的百分比
    if damage ~= 0 then
        data.damage = data.damage or 1
        data.damage = data.damage + damage
        if data.damage < 0 then
            data.damage = 0
        end
        data.damage_add = damage
    end

    -- 受到的伤害增加的百分比
    if bedamage ~= 0 then
        data.bedamage = data.bedamage or 1
        data.bedamage = data.bedamage + bedamage
        if data.bedamage < 0 then
            data.bedamage = 0
        end
        data.bedamage_add = bedamage
    end
end

function FightHelp:CalcLiveBuff(plr, stype, data)
    if not stype then
        return
    end

    local np = 0
    local damage = 0
    local bedamage = 0

    local bufMgr = plr.oLifeBufMgr

    if stype == SceneType.PVE then
        -- 受到的伤害增加的百分比
        -- pve(主线/副本)
        -- np = bufMgr:GetBufAddVal("dup_np_add")
        -- 增加战斗中的初始NP值
        damage = bufMgr:GetBufAddVal('dup_damage_add_pct')
        -- 对敌方的伤害增加的百分比
        bedamage = bufMgr:GetBufAddVal('dup_bedamage_add_pct')
    elseif stype == SceneType.PVP or stype == SceneType.PVPMirror or stype == SceneType.PVEFreeMatch then -- v 4.3
        -- pvp(实时)
        -- pvp(镜像)
        -- np = bufMgr:GetBufAddVal("army_np_add")
        -- 增加战斗中的初始NP值
        damage = bufMgr:GetBufAddVal('army_damage_add_pct')
        -- 对敌方的伤害增加的百分比
        bedamage = bufMgr:GetBufAddVal('army_bedamage_add_pct')
    -- 受到的伤害增加的百分比
    -- elseif stype == SceneType.BOSS then -- pve(多人BOSS)
    end

    -- -- 增加战斗中的初始NP值
    -- if np > 0 then
    -- 	data.np = data.np or 0
    -- 	data.np = data.np + np
    -- end
    self:AddLiveBuff(data, damage, bedamage)

    -- data.buff = {} --修改开场buff
end

function FightHelp:GetDataFromMonsterCfg(plr, cid, cfgId, row, col, sceneType)
    local mCfg = MonsterData[cfgId]
    ASSERT(mCfg, '没有怪物id' .. cfgId)

    local cardData = table.copy(mCfg)
    cardData.skin = mCfg.model

    FightHelp:CalcLiveBuff(plr, sceneType, cardData)

    cardData.skillsByUpType = {}
    for _, f in ipairs({'jcSkills', 'tfSkills', 'subTfSkills'}) do
        for _, skillId in ipairs(mCfg[f] or {}) do
            local skillCfg = skill[skillId]
            if not skillCfg then
                LogInfo(">>>>>>>>>>>>>>>cfgId(%d),skillId(%d)",cfgId,skillId)
            end
            if skillCfg.upgrade_type and skillCfg.upgrade_type < CardSkillUpType.OverLoad then
                cardData.skillsByUpType[skillCfg.upgrade_type] = skillCfg.id
            end
        end
    end

    local VirtualCard = {
        m_cfg = mCfg,
        m_data = cardData,
        Get = function(self, key)
            return self.m_data[key]
        end,
        GetCal = function(self, key)
            return self.m_data[key]
        end,
        GetCfgVal = function(self, key)
            return self.m_cfg[key]
        end,
        GetDataEX = function(self, key)
            cardData.hp_percent = 1
            return cardData --{cid = cfgId, uid = plr:Get("uid"), data = cardData}
            -- {
            -- 	cid = cid,
            -- 	maxhp = cardData.maxhp,
            -- 	hp = cardData.maxhp,
            -- 	row = row,
            -- 	col = col,
            -- 	carddata = {cid = cfgId, uid = plr:Get("uid"), data = cardData}
            -- }
        end,
        GetSillsByUpType = function(self)
            return self.m_data.skillsByUpType
        end
    }

    -- carddata.type = CardType.Card
    return VirtualCard
end

--------------------------------------------------------------
-- 收到战斗指令
function FightHelp:RecvCmd(uid, data)
    local mgr = self:GetFightMgr(uid)
    --ASSERT(mgr)
    local ret
    if mgr then
        --player.id
        -- local tdata = data[3]
        local tkey = 'data' .. data[2]
        data[3] = data[3][tkey] or {}
        -- data[3] = data[3]
        data[3].uid = uid
        ret = mgr:RecvCmd(data)
    else
        -- 提示错误
        -- ASSERT()
        return
    end

    if not ret then
    -- ASSERT()
    -- 提示错误
    end
end

-- 自动战斗
function FightHelp:AutoFight(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr then
        mgr:AutoFight(uid, data)
    else
        -- 提示错误
        return
    end
end

-- 设置集火
function FightHelp:SetFocusFire(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr then
        mgr:SetFocusFire(uid, data)
    end
end

-- -- 设置使用技能AI策略
-- function FightHelp:SetSkillAI(uid, data)
-- 	local mgr = self:GetFightMgr(uid)
-- 	local ret
-- 	if mgr then
-- 		mgr:SetSkillAI(uid, data)
-- 	end
-- end
-- 设置托管
function FightHelp:SetTrusteeship(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr and mgr.SetTrusteeship then
        mgr:SetTrusteeship(uid, data.bTrusteeship)
    end
end

-- 开始倒计时
function FightHelp:CountdownBegins(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr and mgr.CountdownBegins then
        mgr:CountdownBegins(uid, data)
    else
        if not mgr then
            LogWarning("FightHelp:CountdownBegins() not find mgr uid:%s", uid)
        end
    end
end

-- 主动退出战斗
function FightHelp:Quit(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr then
        mgr:Quit(uid, data)
    else
        LogWarning("FightHelp:Quit() not find fight mgr uid:%s", uid)
    end
end

-- 恢复战斗
function FightHelp:RestoreFight(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr then
        -- 不是轮到自己的卡牌就轮到下个onturn再执行恢复
        if mgr.currTurn and uid ~= mgr.currTurn.uid then
            mgr.tWaitForRestore = {uid = uid, nCmdIndex = data.nCmdIndex}
            return
        end

        mgr:SendRestoreFight(uid, data.nCmdIndex)
    else
        -- 提示错误
        return
    end
end

-- 客户端战斗出错
function FightHelp:ClientError(uid, data)
    local mgr = self:GetFightMgr(uid)
    local ret
    if mgr then
        mgr:ClientError(uid, data)
    else
        -- 提示错误
        return
    end
end

--------------------------------------------------------------
function FightHelp:OnTimer()
    -- LogDebug("FightHelp:OnTimer()")

    local f = function()
        -- local t = GameApp:GetTickCount()
        -- LogInfo("FightHelp:OnTimer() %s; %s", t, #FightHelp.lstMgr)

        GameApp:Timeout(1, self:OnTimer())
        for k, v in pairs(FightHelp.lstMgr) do
            -- LogDebugEx("OnTimer",v.id)

            local ret, err = xpcall(v.OnTimer, XpcallCB, v)
            -- if not ret then LogError(err) end
        end
        -- LogInfo("FightHelp:OnTimer() %s", GameApp:GetTickCount()-t)

        FightHelp.count = FightHelp.count or 0
        FightHelp.count = FightHelp.count + 1
        if FightHelp.count > 100 then 
            FightHelp.count = 0
            LogInfo("FightHelp:OnTimer size(lstMgr) = %s, size(mapPlayerMgr)=%s", table.size(FightHelp.lstMgr), table.size(FightHelp.mapPlayerMgr))
        end
    end

    return f
end

-- 玩家退出
function FightHelp:OnPlayerLogout(uid)
    -- local uid = player.id
    local mgr = FightHelp.mapPlayerMgr[uid]
    if mgr then
        FightHelp.mapPlayerMgr[uid] = nil

        if mgr.type ~= SceneType.PVP then
            FightHelp.lstMgr[mgr.id] = nil
        end
        FightHelp.cache[uid] = mgr
        mgr.cacheTime = CURRENT_TIME
    end
end

function FightHelp:OnPlayerLogin(uid, ispvp, notiteConn)
    -- local uid = player.id
    local mgr = FightHelp.cache[uid]

    if mgr then
        if mgr.type == SceneType.PVP and not ispvp then
            return
        end

        FightHelp.mapPlayerMgr[uid] = mgr
        FightHelp.cache[uid] = nil
        mgr.cacheTime = nil

        if mgr.type ~= SceneType.PVP then
            FightHelp.lstMgr[mgr.id] = mgr
        end

        local oDuplicate = mgr.oDuplicate
        if oDuplicate and oDuplicate.nEndTime and oDuplicate.nEndTime <= CURRENT_TIME then
            -- LogDebug("--------------------11111")
            FightHelp:Destroy(uid)
            -- 副本过期, 战斗一并销毁
            local oPlayer = GetPlayer(uid)
            if oPlayer then
                local dupMgr = oPlayer.oDuplicateMgr
                if dupMgr and dupMgr.oFightDuplicate == oDuplicate then
                    dupMgr.oFightDuplicate.oFightMgr = nil
                    dupMgr.oFightDuplicate = nil
                    -- LogDebug("--------------------22222")
                end
            end
        end

        if notiteConn then
            self:SendInBattle(uid, notiteConn)
        end
    else
        LogTable(FightHelp.mapPlayerMgr, "FightHelp.mapPlayerMgr")
        LogTable(FightHelp.lstMgr, "FightHelp.lstMgr")
        LogTable(FightHelp.cache, "FightHelp.cache")
        LogDebug("FightHelp:OnPlayerLogin() FightHelp.cache not find uid:%s", uid)
    end

    return mgr
end

function FightHelp:SendInBattle(uid, notiteConn, isPvp)
    -- LogDebug("FightHelp:SendInBattle uid :%s", uid)
    -- LogTrace("FightHelp:SendInBattle:")
    local mgr = self:GetFightMgr(uid)
    if mgr then
        mgr:OnPlayerLogin(uid)
    else
        LogDebug("FightHelp:SendInBattle(), not find mgr! uid :%s", uid)
        notiteConn:send({'FightProto:InBattle', {type = 0, nDuplicateID = 0}})
    end
end

function FightHelp:Destroy(uid, player)
    LogDebugEx("FightHelp:Destroy", uid)
    --LogTrace()
    -- local uid = player.id
    local mgr = FightHelp.cache[uid] or FightHelp.mapPlayerMgr[uid]
    -- LogTable(mgr, "FightHelp:Destroy mgr:")
    if mgr then
        FightHelp.lstMgr[mgr.id] = nil

        -- v 4.3
        if (mgr.type == SceneType.PVPMirror or mgr.type == SceneType.PVEFreeMatch or mgr.type == SceneType.PVP) and not mgr.isOver then
            -- 紫龙打印bi日志
            xpcall(
                function ()
                    if IsOpenBiLog() then
                        local plr = player or GetPlayer(uid, false, true)
                        local win = 0
                        if plr then
                            local armyInfo = plr:GetTmp('armyInfo', {})
                            BILogMgr:LogImitatefight(
                                plr,
                                2,
                                eTeamType.PracticeAttack,
                                nil,
                                1,
                                win,
                                plr:GetMix('armyRank', 0),
                                plr:GetMix('armyRank', 0),
                                0,
                                plr:GetTmp('army_score', 0)
                            )
                        end
                    end
                end,
                XpcallCB
            )
        end
    else
        LogInfo("FightHelp:Destroy uid=%s not exist", uid)
    end

    FightHelp.mapPlayerMgr[uid] = nil
    FightHelp.cache[uid] = nil
end

-- 关闭所有镜像战斗
function FightHelp:CloseMirror()
    LogDebug('FightHelp:CloseMirror()......')

    for id, v in pairs(self.lstMgr) do
        -- v 4.3
        if v.type == SceneType.PVPMirror or v.type == SceneType.PVEFreeMatch then
            v.isForceOver = true
            v:Over(v.stage, 2)
        end
    end

    for uid, v in pairs(self.cache) do
        -- v 4.3
        if v.type == SceneType.PVPMirror or v.type == SceneType.PVEFreeMatch then
            v.isForceOver = true
            v:Over(v.stage, 2)
        end
    end
end
