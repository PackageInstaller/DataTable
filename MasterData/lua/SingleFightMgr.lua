-- OPENDEBUG()
-- 单机战斗
------------------------------------------------------------------
-- 单机服务端功能
SingleFightMgrServer = oo.class(FightMgrServer)
function SingleFightMgrServer:Init(...)
    FightMgrServer.Init(self, ...)
    self.nKillMonster = 0
    self.isServerMgr = true
    self.nTotalDamage = 0


    -- mgr.nPlayerLevel = player:Get('level')
    self.uid = PlayerClient:GetID()
end

-- 广播消息
function SingleFightMgrServer:Broadcast(cmd, msg)
    -- 模拟客户端收到信息
    CallRecv(cmd, msg)
end

function SingleFightMgrServer:Send(uid, cmd, msg)
    CallRecv(cmd, msg)
end

function SingleFightMgrServer:OnDeath(card, killer)
    FightMgrBase.OnDeath(self, card, killer)

    if card:GetTeamID() == 2 then
        self.nKillMonster = self.nKillMonster + 1
    -- self.oDuplicate.oPlayer:UpdateTask(eTaskFinishType.Fight, eTaskEventType.KillMonster, self.oDuplicate)
    -- self.oDuplicate.oPlayer.oDuplicateDBMgr:UpdateStat(self.nDuplicateID, eDuplicateStarType.Monster, 1)
    end
end

function SingleFightMgrServer:LoadBossConfig(groupID, stage)
    self.groupID = self.groupID or groupID
    stage = stage or 1
    self.stage = stage

    local config = MonsterGroup[groupID]
    ASSERT(config, '没有配置怪物组' .. self.groupID)
    -- DT(config)
    local stageconfig = config.stage[stage]
    ASSERT(stageconfig, '怪物组' .. self.groupID .. '周目' .. stage)

    if config.nStepLimit then
        -- 回合限制
        self:SetStepLimit(config.nStepLimit)
    elseif stageconfig.nStepLimit then
        -- 回合限制
        self:SetStepLimit(stageconfig.nStepLimit)
    else
        self:SetStepLimit(g_nFightLimit)
    end

    for i, v in ipairs(config.stage) do
        table.insert(self.arrStateID, i)
    end

    self.totleState = #config.stage
    -- 敌方阵型
    self.oBoss = self.arrTeam[2]:LoadBossConfig(self.groupID, self.stage)
    return self.oBoss
end

-- 结束
function SingleFightMgrServer:Over(stage, winer)
    LogDebugEx('SingleFightMgrServer:Over', self.type, self.nDuplicateID, winer)
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})

    PVEFightMgrServer.Over(self, stage, winer)
    local data = {}
    local deathcount = 0
    local grade = {0, 0, 0} -- 评级
    local nMinHpPercent = 1
    local cardCnt = self.arrTeam[1].nCardCount

    if winer == 1 then
        grade[1] = 1
        for i, v in ipairs(self.arrCard) do
            -- 合体, 召唤
            --print("card", v.oid, v.name, v.hp, v.fuid, v.cuid ,v.npcid)
            if v:GetTeamID() == 1 and v:IsCard() then
                if v.fuid then
                    data[0] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
                elseif v.npcid then
                    data[v.npcid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
                else
                    data[v.cuid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
                end

                if nMinHpPercent > v.hp / v.maxhp then
                    nMinHpPercent = v.hp / v.maxhp
                end

                if math.floor(v.hp) <= 0 then
                    deathcount = deathcount + 1
                    nMinHpPercent = 0
                end
            end
        end

        if deathcount == 0 then
            grade[2] = 1
        end

        if self:GetCurrStep() <= g_FightGradeStep then
            grade[3] = 1
        end
    else
        nMinHpPercent = 0
    end

    -- 发送给服务器记录
    local sendData = {
        winer = winer,
        data = data,
        myOID = self.myOID,
        monsterOID = self.monsterOID,
        nGrade = grade,
        exdata = {
            turnNum = self.nStepPVE or self.nStep,
            deathCnt = deathcount,
            cardCnt = cardCnt,
            nMinHpPercent = math.floor(nMinHpPercent * 100)
        }
    }
    LogTable(sendData, 'sendData = ')

    local nKillMonster = self.nKillMonster
    if nKillMonster > 0 then
        sendData.nKillMonster = self.nKillMonster
    end

    if self.tSetSkillAI then
        -- 切换过的技能
        local tSetSkillAI = {}
        for k, v in pairs(self.tSetSkillAI) do
            table.insert(tSetSkillAI, v)
        end
        sendData.tSetSkillAI = tSetSkillAI
    end

    LogTable(sendData, 'FightProtocol:OnFightOver')
    -- ASSERT()
    local proto = {'FightProtocol:OnFightOver', sendData}
    local curNet = ExerciseRMgr:GetCurNet()
    if not curNet then
        ASSERT()
    end
    curNet:Send(proto)
    -- self.oDuplicate:OnFightOver()
end

function SingleFightMgrServer:Destroy()
    LogDebug('SingleFightMgrServer:Destroy')
    g_FightMgrServer = nil
    -- g_FightMgr = nil
end

function SingleFightMgrServer:OnStart(data)
    if self.isStart then
        return
    end
    self:AddCmd(CMD_TYPE.Start, {})
    FightMgrBase.OnStart(self, data)
end

-- 设置使用技能AI策略
-- function SingleFightMgrServer:SetSkillAI(uid, data)
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	self.tSetSkillAI = self.tSetSkillAI or {}

-- 	local old = self.tSetSkillAI[data.id]
-- 	if old then
-- 		-- 已有记录, 就是要还原到原来的样子, 所以不存
-- 		self.tSetSkillAI[data.id] = nil
-- 	else

-- 		local card = self:GetCardByOID(data.id)

-- 		self.tSetSkillAI[data.id] =
-- 			{
-- 				cuid  = card.cuid,
-- 				fuid  = card.fuid,
-- 				npcid = card.npcid,
-- 				myOID = self.myOID,
-- 				isUseCommon = data.isUseCommon
-- 			}
-- 	end

-- 	if table.empty(self.tSetSkillAI) then
-- 		self.tSetSkillAI = nil
-- 	end
-- end

-- 加载怪物组(我方阵型)
function SingleFightMgrServer:MakeFightDataFromGroup(groupID, cid, model, modelA, useSkills)
    -- ["data"]:
    -- {
    --     ["data"]:
    --     {
    --         [1]:
    --         {
    --             ["cid"]:70130,
    --             ["uid"]:1,
    --             ["col"]:1,
    --             ["row"]:1
    --             ["data"]:
    --             {
    --                 ["skills"]:
    --                 {
    --                     [1]:4701301,
    --                     [2]:701300101,
    --                     [3]:701300201,
    --                     [4]:701300301
    --                 },
    --                 ["cuid"]:12,
    --                 ["attack"]:155,
    --                 ["col"]:1,
    --                 ["crit_rate"]:0.0108,
    --                 ["np"]:0,
    --                 ["resist"]:0.0,
    --                 ["crit"]:1.5,
    --                 ["id"]:70130,
    --                 ["hit"]:0.0,
    --                 ["row"]:1,
    --                 ["maxhp"]:1753,
    --                 ["hp"]:1753,
    --                 ["model"]:7013001,
    --                 ["speed"]:114,
    --                 ["defense"]:101,
    --                 ["sp_race2"]:10.0,
    --                 ["sp"]:10,
    --                 ["sp_race"]:5.0,
    --                 ["level"]:1,
    --                 ["name"]:"赫拉",
    --                 ["break_level"]:1,
    --                 ["intensify_level"]:1
    --             },
    --         },
    --     }
    -- },

    local data = {}
    local config = MonsterGroup[groupID]
    ASSERT(config)
    -- DT(config, "Team:LoadConfig")
    local stageconfig = config.stage[1]
    ASSERT(stageconfig)

    local formation = MonsterFormation[stageconfig.formation]
    ASSERT(formation)

    for i, pos in ipairs(formation.coordinate) do
        local monsterID = stageconfig.monsters[i]
        if monsterID and monsterID ~= 0 then
            -- self:AddCard(pos[1], pos[2], monsterID)
            local carddata = {cid = monsterID, uid = PlayerClient:GetID(), row = pos[1], col = pos[2]}
            carddata.data = {}
            local monsterconfig = MonsterData[monsterID]
            ASSERT(monsterconfig)

            for k, v in pairs(AttrTable) do
                carddata.data[v] = monsterconfig[v]
            end
            carddata.data.hp = monsterconfig.maxhp
            carddata.data.skills = monsterconfig.skills
            carddata.data.cuid = -i
            carddata.data.row = pos[1]
            carddata.data.col = pos[2]
            carddata.data.np = monsterconfig.np
            carddata.data.id = monsterID
            carddata.data.model = monsterconfig.model
            carddata.data.name = monsterconfig.name
            carddata.data.break_level = 1
            carddata.data.intensify_level = 1

            -- -- 传生活buff的值进来
            -- local damage = nil
            -- local bedamage = nil
            -- if damage and bedamage then
            --     FightHelp:AddLiveBuff(carddata.data, damage, bedamage)
            -- end
			

            -- ai 格式
            -- local ai =     
                -- {
                --     [ 1 ]n = 
                --     {
                --         [ "skillStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 4 ]f
                --         }
                --         [ "aiStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 13 ]f
                --         }
                --         [ "skillID" ]s = [ 700900105 ]f
                --     }
                --     [ 2 ]n = 
                --     {
                --         [ "skillStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 13 ]f
                --             [ 2 ]n = [ 2 ]f
                --             [ 3 ]n = [ 3 ]f
                --             [ 4 ]n = [ 0 ]f
                --         }
                --         [ "aiStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 8 ]f
                --         }
                --         [ "skillID" ]s = [ 700900205 ]f
                --     }
                --     [ "bOverLoad" ]s = [ 'false' ]boolean
                --     [ 3 ]n = 
                --     {
                --         [ "skillStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 2 ]f
                --         }
                --         [ "aiStrategy" ]s = 
                --         {
                --             [ 1 ]n = [ 6 ]f
                --         }
                --         [ "skillID" ]s = [ 700900305 ]f
                --     }
                -- }

            -- carddata.data.aiSetting = ai
            -- carddata.data.nStrategyIndex = index
            
            -- LogError(useSkills)
			-- LogError(carddata.data.skills)

			-- 单独替换机神技能
            for _, uSkillId in ipairs(useSkills or {}) do
                local sCfg = Cfgs.skill:GetByID(uSkillId)
                if sCfg.main_type == SkillMainType.CardSpecial then
                    for ix, oSkillId in ipairs(carddata.data.skills) do
                        local osCfg = Cfgs.skill:GetByID(oSkillId)
                        if osCfg.main_type == SkillMainType.CardSpecial then
                            carddata.data.skills[ix] = uSkillId
                            break
                        end
                    end
                end
            end

            -- 修改试玩模型
            if monsterID == cid and model then
                carddata.data.model = model
            end

            if monsterID == cid and modelA then
                carddata.data.modelA = modelA
            end

            table.insert(data, carddata)
        end
    end

    return {data = data}
end

------------------------------------------------------------------
-- 单机客户端功能
SingleFightMgrClient = oo.class(FightMgrClient)
function SingleFightMgrClient:Init(...)
    FightMgrClient.Init(self, ...)
    self.name = 'SingleFightMgrClient'
    self.uid = PlayerClient:GetID()
end

SingleFightMgrClient.LoadBossConfig = SingleFightMgrServer.LoadBossConfig

function SingleFightMgrClient:SendCmd(cmd, data)
    if not g_FightMgrServer then
        return
    end
    LogTable(data, 'cmd' .. cmd)
    local index = #self.cmds + 1
    local cmddata = {}
    cmddata['data' .. cmd] = data
    local proto = {'FightProtocol:RecvCmd', {index, cmd, cmddata}}
    DebugLog('发送命令：', 'ff9977')
    LogTable(proto, 'SendCmd')

    local d = {index, cmd, data}
    d.uid = self.uid
    data.uid = self.uid
    LogTable(d, 'FightMgrServer RecvCmd=')

    -- [[调试代码
    if CMD_TYPE.Skill == cmd then  -- 出现发送命令服务器没有对象,可能是客户端重复发??
        -- 25/3/18 客户端断线恢复
        if not g_FightMgrServer.currTurn then
            if not self.currTurn then
                ASSERT(nil, Json.Encode(data))
            end
            ASSERT(nil, Json.Encode(data))
            return
        end
    end
    -- 调试代码]]

    ret = g_FightMgrServer:RecvCmd(d)
end

function SingleFightMgrClient:AfterLoadData(exData)
    FightMgrClient.AfterLoadData(self,exData)
    if exData.bossMaxHp then
        for i, v in ipairs(self.arrCard) do
            local ty = v:GetType()
            if ty == CardType.Boss then
                v.hp = exData.bossMaxHp
                v.maxhp = exData.bossMaxHp
            end
        end
    end
end

function SingleFightMgrClient:SendAuto()
    if not g_FightMgrServer then
        return
    end
    if not self.currTurn or self.currTurn.uid ~= self.uid then
        return
    end

    -- local proto = {"FightProtocol:AutoFight", {id = self.currTurn.oid}}
    g_FightMgrServer:AutoFight(self.uid, {id = self.currTurn.oid})
end

function SingleFightMgrClient:SetFocusFire(id)
    if not g_FightMgrServer then
        return
    end
    -- local proto = {"FightProtocol:SetFocusFire", {nFocusFireID = id}}
    g_FightMgrServer:SetFocusFire(self.uid, {nFocusFireID = id})
end

-- function SingleFightMgrClient:SetSkillAI(id, isUseCommon)
-- 	if not g_FightMgrServer then return end
-- 	-- local proto = {"FightProtocol:SetSkillAI", {id = id, isUseCommon = isUseCommon}}
-- 	g_FightMgrServer:SetSkillAI(self.uid, {id = id, isUseCommon = isUseCommon})
-- end

function SingleFightMgrClient:Quit()
    if not g_FightMgrServer then
        return
    end
    local proto = {'FightProtocol:Quit', {}}
    g_FightMgrServer:Quit(self.uid)
end

function SingleFightMgrClient:ForceQuit()
    if not g_FightMgrServer then
        return
    end
    g_FightMgrServer:Over(self.stage, 2)
end

-- 结束
function SingleFightMgrClient:Over(stage, winer)
    LogDebug('SingleFightMgrClient:Over', stage, winer)

    if g_FightMgrServer then 
        LogDebugEx("g_FightMgrServer.isOver", g_FightMgrServer.isOver)
        if g_FightMgrServer.isOver then -- 已经结束
        else
            LogTrace()
            return -- 服务器未结束, 客户端不要结束
        end
    end

    -- self:AddCmd(CMD_TYPE.End, stage)
    for i, v in ipairs(self.arrCard) do
        -- 战斗结束, 解除合体角色
        if v:GetTeamID() == 1 and v:IsUnite() then
            v.team:Resolve(v, true)
        end
    end

    self.isOver = true
    self:Destroy()
    LogTrace()
end


------------------------------------------------------------------
-- 创建一个副本单机战斗
function CreateDuplicateSingleFight(proto)
    LogTable(proto, 'CreateDuplicateSingleFight')
    local groupID, nDuplicateID, tData, exData = proto.groupID, proto.nDuplicateID, proto.data, proto.exData

    CURRENT_TIME = TimeUtil:GetTime()

    local fid = UID(10)
    local seed = math.random(os.time())
    local mgr = SingleFightMgrServer(fid, groupID, SceneType.SinglePVE, seed, nDuplicateID)
    -- mgr.nPlayerLevel = player:Get('level')
    mgr.uid = PlayerClient:GetID()
    g_FightMgrServer = mgr

    mgr.myOID = proto.myOID
    mgr.monsterOID = proto.monsterOID

    LogTable(tData, 'CreateDuplicateSingleFight tData')
    mgr:AddPlayer(PlayerClient:GetID(), 1)
    mgr:LoadConfig(groupID, 1)
    mgr:LoadData(1, tData.data, nil, tData.tCommanderSkill)
    mgr:AfterLoadData(exData)
    if table.empty(exData) then
        exData = nil
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            stype = SceneType.SinglePVE,
            groupID = groupID,
            teamID = 1,
            data = tData,
            exData = exData,
            nTeamIndex = proto.nTeamIndex
        }
    )
end
-- ------------------------------------------------------------------
-- -- 创建一个单机纯战斗
-- function CreateSingleFight(id, groupID, nDuplicateID, tData, exData)

-- 	local fid = UID(10)
-- 	local seed = math.random(os.time())
-- 	local mgr = SingleFightMgrServer(fid, groupID, SceneType.SinglePVE, seed, nDuplicateID)
-- 	g_FightMgrServer = mgr

-- 	-- mgr.nTeamIndex = nTeamIndex
-- 	-- mgr.oDuplicate = oDuplicate

-- 	mgr:AddPlayer(PlayerClient:GetID(), 1)
-- 	mgr:LoadConfig(groupID, 1)
-- 	mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
-- 	mgr:AfterLoadData(exData)
-- 	if table.empty(exData) then
-- 		exData = nil
-- 	end

-- 	mgr:AddCmd(
-- 		CMD_TYPE.InitData,
-- 		{
-- 			seed = seed,
-- 			stype = SceneType.SinglePVE,
-- 			groupID = groupID,
-- 			teamID = 1,
-- 			data = data,
-- 			exData = exData
-- 		}
-- 	)
-- end

------------------------------------------------------------------
-- 创建一个单机模拟战斗(开场用)
function CreateSimulateFight(groupID, groupID2, cbOver, seed, cid, model, modelA, skills)
    LogDebugEx('CreateSimulateFight', groupID, groupID2, seed)
    local fid = UID(10)
    local seed = seed or 1 -- 结果必然确定
    local mgr = SingleFightMgrServer(fid, groupID2, SceneType.SinglePVE, seed, 0)
    g_FightMgrServer = mgr

    local data = mgr:MakeFightDataFromGroup(groupID, cid, model, modelA, skills)
    LogTable(data, 'MakeFightDataFromGroup')

    mgr:AddPlayer(PlayerClient:GetID(), 1)
    mgr:LoadConfig(groupID2, 1)
    mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
    mgr:AfterLoadData({})

    mgr.Over = function(self, stage, winer)
        LogDebugEx('CreateSimulateFight:Over', self.type, self.nDuplicateID, winer)
        self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
        if cbOver then
            cbOver(stage, winer)
        end
        -- g_FightMgrServer = nil
        FightMgrBase.Over(self, stage, winer)
        self:Destroy()
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            stype = SceneType.SinglePVE,
            groupID = groupID2,
            teamID = 1,
            data = data,
            exData = {}
        }
    )
    -- ASSERT()
    return mgr
end

-- 训练(试玩)  可选参数[cid, model, modelA] 需要修改模型的角色id/模型/同调,机神,形态切换的模型id
function CreateDirllFight(groupID, groupID2, cbOver, cid, model, modelA, skills)
	g_FightMgrServer = nil
	g_FightMgr = nil
    -- LogDebugEx("CreateDirllFight",groupID, groupID2, os.time())
    return CreateSimulateFight(groupID, groupID2, cbOver, os.time(), cid, model, modelA, skills)
end

function SingleFightMgrServer:DamageStat(caster, nDamage)
    if caster:GetTeamID() ~= 1 then
        return 
    end
    self.nTotalDamage = self.nTotalDamage + nDamage
end


function SingleFightMgrServer:AfterLoadData(exData)
    --LogTrace()
    FightMgrServer.AfterLoadData(self,exData)
    if exData.bossMaxHp then
        for i, v in ipairs(self.arrCard) do
            local ty = v:GetType()
            if ty == CardType.Boss then
                v.hp = exData.bossMaxHp
                v.maxhp = exData.bossMaxHp
            end
        end
    end
end

-- 创建一个单机模拟战斗
function CreateSimulateFightByData(data, groupID2, cbOver, seed, tCommanderSkill, exData)
    LogDebugEx('CreateSimulateFight', groupID, groupID2, seed,exData)
    -- ASSERT()
    local fid = UID(10)
    local seed = seed or 1 -- 结果必然确定
    local mgr = SingleFightMgrServer(fid, groupID2, SceneType.SinglePVE, seed, 0)
    g_FightMgrServer = mgr
    mgr.uid = PlayerClient:GetID()

    -- local data = mgr:MakeFightDataFromGroup(groupID, cid, model)
    -- LogTable(data, "MakeFightDataFromGroup")
    -- LogTable(data.data, "------------111")
    data.data = Halo:Calc(data.data)
    -- LogTable(data.data, "------------22222")
    data.tCommanderSkill = tCommanderSkill
    for _, v in pairs(data.data) do
        v.maxhp = v.data.maxhp
        if v.data.hp_percent then
            v.data.hp = math.floor(v.data.maxhp * v.data.hp_percent)
        end
    end
    LogTable(data.data, 'data.data')
    RemoveExcludeSkill(data.data)
    LogTable(tCommanderSkill, 'data.tCommanderSkill')
    local cbData = {}
    mgr:AddPlayer(PlayerClient:GetID(), 1)


    local hpData = exData.hpData
    if hpData and hpData.data then
        exData.stage = hpData.stage
        local hpIfs = {}
        for i, hp in pairs(hpData.data) do
            hpIfs[i] = { hp = hp }
        end
        exData.hpinfo = hpIfs
    end
    local bossId = exData.bossId
    if bossId then
        mgr.nTPCastRate = 1
        local oboss = mgr:LoadBossConfig(groupID2, 1)
        -- boss技能添加
        GCalHelp:GetGlobalBossAddSkill(oboss,bossId)
        -- 添加词条
        local bossCfg = cfgGlobalBoss[bossId]
        if bossCfg and bossCfg.buffId then
            GCalHelp:GetGlobalBossExdata(bossCfg.buffId, exData, data.data)
        end
    else
        mgr:LoadConfig(groupID2, 1, exData.hpinfo)
    end
    mgr:LoadData(1, data.data, nil, tCommanderSkill)
    mgr:AfterLoadData(exData)
    mgr.isSingleFight = true
    mgr.Over = function(self, stage, winer)
        LogDebugEx('CreateSimulateFight:Over', self.type, self.nDuplicateID, winer,self.nTotalDamage)
        self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
        if cbOver then
            if exData.isMultTeam then
                cbData = PackMultTeamFightCbData(self,exData,winer)
            end 
            cbOver(stage, winer,self.nTotalDamage,cbData)
        end
        -- g_FightMgrServer = nil
        FightMgrBase.Over(self, stage, winer)
        self:Destroy()
    end

    mgr:AddCmd(
        CMD_TYPE.InitData,
        {
            seed = seed,
            stype = SceneType.SinglePVE,
            groupID = groupID2,
            teamID = 1,
            data = data,
            exData = exData or {}
        }
    )
    -- ASSERT()
    return mgr
end

function RemoveExcludeSkill(fData)
    local m_excludeSkills = {}
    for _,fightData in ipairs(fData) do
        local cardData = fightData.data
        m_excludeSkills[cardData.id] = cardData.excludeSkills
    end
    -- 根据卡牌id分类
    local cardDatas = {}

    -- 按照互斥id分类
    local excludeIdMap = {}

    -- 遍历卡牌数据，取出所有卡牌的互斥技能信息
    for _, fightData in ipairs(fData or {}) do
        local cardData = fightData.data
        local cid = cardData.id
        if cid then
            cardDatas[cid] = cardData

            local rInfo = m_excludeSkills[cid]
            if rInfo then
                -- 如果这个卡牌存在互斥技能
                for _, cfg in ipairs(rInfo) do
                    -- 加入
                    local arr = GCalHelp:GetTb(excludeIdMap, cfg.nExcludeId)
                    table.insert(arr, {cid = cid, id = cfg.nSkillId})
                end
            end
        end
    end
    local CfgSkills = _G['skill']
    for excludeId, infos in pairs(excludeIdMap) do
        local len = #infos
        -- 如果互斥数组大于1，那么表示存在互斥
        if len > 1 then
            -- 根据技能等级，从大到小排序
            table.sort(
                infos,
                function(rhs, lhs)
                    local rCfg = CfgSkills[rhs.id]
                    local lCfg = CfgSkills[lhs.id]
                    return rCfg.lv > lCfg.lv
                end
            )
            -- 倒序删除，保留等级最大的那个，其余的删掉
            for i = len, 2, -1 do
                local info = infos[i]
                local cardData = cardDatas[info.cid]
                local sLen = #cardData.skills
                for si = sLen, 1, -1 do
                    if cardData.skills[si] == info.id then
                        table.remove(cardData.skills, si)
                    end
                end
            end
        end
    end
end

function PackMultTeamFightCbData(fMgr,exData,winner)
    local retData = {}
    retData.id = exData.dupId
    retData.bIsWin = true
    local hpInfo = {}
    hpInfo.stage = fMgr.stage
    local data = {}
    local maxConfigIndex = 0
    for i, v in ipairs(fMgr.arrCard) do
        if v:GetTeamID() == 2 then
            if v.configIndex then
                data[v.configIndex] = v.hp
                if v.configIndex > maxConfigIndex then
                    maxConfigIndex = v.configIndex
                end
            end
        end
    end
    -- data 需要是连续数组，避免协议 array 编码读取到 nil
    for idx = 1, maxConfigIndex do
        if data[idx] == nil then
            data[idx] = 0
        end
    end
    hpInfo.data = data
    local cfgMainLine = MainLine[exData.dupId]
    local maxDupScore = cfgMainLine.points
    local score,totalHp = GCalHelp:MultTeamGetFightRetData(winner,maxDupScore,exData.score,exData.totalHp,exData.totalMaxHp,hpInfo,cfgMainLine.nGroupID)
    local dData = {}
    dData.hpData = hpInfo
    dData.dupId = exData.dupId
    local oldScore = dData.score or 0
    dData.score = score + oldScore
    dData.totalHp = totalHp
    dData.totalMaxHp = exData.totalMaxHp
    retData.dupData = {dData}
    retData.score = score
    LogDebugEx("PackMultTeamFightCbData,retData",retData)
    return retData
end

-- data 结构
-- {
--     [ "data" ]s =
--     {
--         [ 1 ]n =
--         {
--             [ "cid" ]s = [ 71010 ]f
--             [ "uid" ]s = [ 1002 ]f
--             [ "row" ]s = [ 2 ]f
--             [ "col" ]s = [ 2 ]f
--             [ "maxhp" ]s = [ 2213 ]f
--             [ "fuid" ]s = [ 1001 ]f  -- 如果是好友
--             [ "npcid" ]s = [ 1001 ]f -- 如果是npc
--             [ "data" ]s = 以下是配置表的信息
--             {
--                 [ "isLeader" ]s = [ 'true' ]boolean
--                 [ "sp_race" ]s = [ 5 ]f
--                 [ "sp_race2" ]s = [ 10 ]f
--                 [ "hp" ]s = [ 2213 ]f
--                 [ "nClass" ]s = [ 8 ]f
--                 [ "real_cid" ]s = [ 71010 ]f
--                 [ "id" ]s = [ 71010 ]f
--                 [ "hot" ]s = [ 100 ]f
--                 [ "cuid" ]s = [ 71010 ]f
--                 [ "break_level" ]s = [ 1 ]f
--                 [ "intensify_level" ]s = [ 1 ]f
--                 [ "name" ]s = [ "总队长" ]s
--                 [ "nStep" ]s = [ 0 ]f
--                 [ "nJump" ]s = [ 0 ]f
--                 [ "hp_percent" ]s = [ 1 ]f
--                 [ "performance" ]s = [ 844 ]f
--                 [ "fight_cost" ]s = [ 0 ]f
--                 [ "career" ]s = [ 2 ]f
--                 [ "nMoveType" ]s = [ 1 ]f
--                 [ "col" ]s = [ 2 ]f
--                 [ "level" ]s = [ 13 ]f
--                 [ "quality" ]s = [ 5 ]f
--                 [ "row" ]s = [ 2 ]f
--                 [ "card_exp_add" ]s = [ 0 ]f
--                 [ "plr_exp_add" ]s = [ 0 ]f
--                 [ "gold_add" ]s = [ 0 ]f
--                 [ "max_level" ]s = [ 20 ]f
--                 [ "model" ]s = [ 7101001 ]f
--                 [ "skills" ]s =
--                 {
--                     [ 1 ]n = [ 4710101 ]f
--                     [ 2 ]n = [ 710100101 ]f
--                     [ 3 ]n = [ 710100201 ]f
--                     [ 4 ]n = [ 710100301 ]f
--                     [ 5 ]n = [ 710100401 ]f
--                     [ 6 ]n = [ 710101301 ]f
--                 }
--                 [ "np" ]s = [ 0 ]f
--                 [ "attack" ]s = [ 299 ]f
--                 [ "maxhp" ]s = [ 2213 ]f
--                 [ "defense" ]s = [ 134 ]f
--                 [ "speed" ]s = [ 110 ]f
--                 [ "crit" ]s = [ 1.6 ]f
--                 [ "crit_rate" ]s = [ 0.11 ]f
--                 [ "hit" ]s = [ 0 ]f
--                 [ "resist" ]s = [ 0 ]f
--                 [ "sp" ]s = [ 30 ]f
--             }

--         }
--     }
-- }

--     [ "tCommanderSkill" ]s =
--		{
--			[ 1 ]n = [ 1020101 ]f
--			[ 2 ]n = [ 1020201 ]f
--			[ 3 ]n = [ 1020301 ]f
--		},

-- 自定义数据试玩战斗
function CreateDirllFightByData(data, groupID2, cbOver, tCommanderSkill, exData)
    -- LogDebugEx("CreateDirllFight",groupID, groupID2, os.time())
	g_FightMgrServer = nil
	g_FightMgr = nil

    exData = exData or {}
    --exData.hpinfo = {}
    --exData.hpinfo[1] = { hp = 50 }
    return CreateSimulateFightByData(data, groupID2, cbOver, os.time(), tCommanderSkill, exData)
end
-- ------------------------------------------------------------------
-- -- 创建一个世界boss战斗
-- function CreateBossFight(proto)

-- 	local groupID, nDuplicateID, tData, exData = proto.groupID, proto.nDuplicateID, proto.data, proto.exData

-- 	CURRENT_TIME=TimeUtil:GetTime()

-- 	local fid = UID(10)
-- 	local seed = math.random(os.time())
-- 	local mgr = SingleFightMgrServer(fid, groupID, SceneType.BOSS, seed, nDuplicateID)
-- 	g_FightMgrServer = mgr

-- 	-- LogTable(tData)
-- 	mgr:AddPlayer(PlayerClient:GetID(), 1)
-- 	mgr:LoadConfig(groupID, 1)
-- 	mgr:LoadData(1, tData.data, nil, tData.tCommanderSkill)
-- 	mgr:AfterLoadData(exData)
-- 	if table.empty(exData) then
-- 		exData = nil
-- 	end

-- 	mgr:AddCmd(
-- 		CMD_TYPE.InitData,
-- 		{
-- 			seed = seed,
-- 			stype = SceneType.BOSS,
-- 			groupID = groupID,
-- 			teamID = 1,
-- 			data = tData,
-- 			exData = exData
-- 		}
-- 	)
-- end
------------------------------------------------------------------
local cbFightMgrTimer = function(msg, ...)
    LogInfo('----------------------------------------')
    LogInfo('LUA ERROR: ' .. tostring(msg) .. '\n')
    LogInfo(debug.traceback())
    LogInfo('----------------------------------------')
    ASSERT()
end

function FightMgrTimer()
    --	-- LogDebug("FightMgrTimeout")
    --	FuncUtil:Call(FightMgrTimeout,nil,1000);

    CURRENT_TIME = TimeUtil:GetTime()

    if g_FightMgrServer then
        -- local ret, err = pcall(g_FightMgrServer.OnTimer, g_FightMgrServer)
        -- -- g_FightMgrServer:OnTimer()
        -- if err then
        -- 	LogError(err)
        -- 	ASSERT()
        -- end
        xpcall(g_FightMgrServer.OnTimer, cbFightMgrTimer, g_FightMgrServer)
    end
end

--FightMgrTimeout()
-- function SingleFightMgrClient:RestoreFight()
-- 	local proto = {"FightProtocol:RestoreFight", {nCmdIndex = #self.cmds}}
-- end

-- -- 接收命令
-- function SingleFightMgrClient:RecvCmd(cmd)
-- 	DebugLog("收到命令：", "ff9977")
-- 	LogDebug(cmd, "ff9977 cmd =")
-- 	local ret = FightMgrBase.RecvCmd(self, cmd)
-- 	if not ret then
-- 		LogDebugEx("FightMgrClient:RecvCmd", cmd[1])
-- 		ASSERT()
-- 		return
-- 	end

-- 	-- local ty = cmd[2]
-- 	-- local data = cmd[3]
-- 	-- self:AddCmd(ty, data)
-- 	return true
-- end

-- -- 执行角色切换
-- function FightMgrClient:DoTurn(data)
-- 	LogDebug("CMD_TYPE.Turn ---------" .. data.id)
-- 	FightActionMgr:PushSkill(self.log:GetAndClean())

-- 	self:OnRoundOver()

-- 	local card = self:GetCardByOID(data.id)
-- 	local t, card2 = self:CalcNext()
-- 	LogDebugEx(card.name .. "\t" .. card2.name)
-- 	LogDebugEx(card.oid .. "\t" .. card2.oid)

-- 	if card == card2 then
-- 		self:AddAllTime(t, card)
-- 		self.turnNum = self.turnNum + 1
-- 		self.currTurn = card
-- 		self.waitForDoSkill = card.oid

-- 		local str = "第" .. self.turnNum .. "回合\n"
-- 		self:PrintCardInfo(str)

-- 		card.tmpPrintLog = {}
-- 		table.insert(card.tmpPrintLog, "第" .. self.turnNum .. "回合")
-- 		LogTable(card.tmpPrintLog)

-- 		LogDebug("##############玩家行动#################" .. card.name)
-- 		-- 处理buffer行动前
-- 		-- local log = {api="OnRoundBegin"}
-- 		-- self.log:Add(log)
-- 		-- self.log:StartSub("datas")
-- 		self:DoEventWithLog("OnRoundBegin", card)
-- 		-- self.log:EndSub("datas")
-- 		FightActionMgr:PushSkill(self.log:GetAndClean())
-- 		if not card:IsLive() then
-- 			-- 已经死亡
-- 			LogDebugEx("card is death", card.name)
-- 			self:UpdateProgress(nil, card, false)
-- 			return
-- 		end

-- 		-- 控制类buffer处理
-- 		local isMotionless = card.bufferMgr:IsMotionless()
-- 		if isMotionless then
-- 			LogDebug("-------此处无法行动-------" .. card.name)
-- 		end

-- 		local log = {api = "OnTurn", isMotionless = isMotionless}
-- 		self.log:Add(log)
-- 		self.log:StartSub("datas")
-- 		card:OnTurn(isMotionless)
-- 		self:UpdateProgress(nil, card, false)
-- 		self.log:EndSub("datas")

-- 		-- 显示
-- 		log.id = card.oid
-- 		local ty = card:GetType()
-- 		if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Mirror then
-- 			log.skillDatas = card.skillMgr:GetClientSkillInfo()
-- 			log.canOverLoad = card.skillMgr:CanOverLoad()

-- 			-- 指挥官技能
-- 			log.tCommanderSkill = self:GetCommanderSkill(card)
-- 		end
-- 		FightActionMgr:PushSkill(self.log:GetAndClean())
-- 	else
-- 		LogError("数据不一致")
-- 		LogDebug("card ~= card2")
-- 		LogDebugEx(card.name .. "\t" .. card2.name)
-- 		ASSERT("card ~= card2")
-- 	end
-- end

-- function FightMgrBase:RecvCmd(cmd)

-- 	if ty == CMD_TYPE.Turn then
-- 		self:DoTurn(data)
-- 	elseif ty == CMD_TYPE.Skill then
-- 		self:DoSkill(data)
-- 	elseif ty == CMD_TYPE.OverLoad then
-- 		self:OverLoad(data)
-- 	elseif ty == CMD_TYPE.Commander then
-- 		self:DoCommanderSkill(data)
-- 	elseif ty == CMD_TYPE.End then
-- 		self:DoEnd(data)
-- 	elseif ty == CMD_TYPE.ChangeStage then
-- 		self:ChangeStage(data.stage)
-- 	end

-- end