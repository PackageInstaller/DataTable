-- OPENDEBUG()

-- 冒泡排序(稳定)
function BubbleSort(arr, sortfun, key)
    local tmp = 0
    for i = 1, #arr - 1 do
        for j = 1, #arr - i do
            if sortfun(arr[j], arr[j + 1], key) then
                tmp = arr[j]
                arr[j] = arr[j + 1]
                arr[j + 1] = tmp
            end
        end
    end
end

-- 排序函数(升序)
function SortFunByKeyAsc(first, second, key)
    if first[key] > second[key] then
        return true
    end
end

-- 排序函数(降序)
function SortFunByKeyDesc(first, second, key)
    if first[key] < second[key] then
        return true
    end
end

-- bubble_sort(list, sortfun)

-- 发送客户端信息, 发送失败会重新发送
function ClientSend(proto)
    local curNet = ExerciseRMgr:GetCurNet()

    if not curNet:IsConnected() then
        -- 已经断线
        -- ASSERT(nil, "断网")
    else
        local ret = curNet:Send(proto)
        LogDebug('ClientSend ' .. (ret or 'nil'))
        return ret
    end
end
------------------------------------------------
-- 战斗场景
FightMgrBase = oo.class()

function FightMgrBase:Init(id, groupID, ty, seed, nDuplicateID)
    LogDebugEx('FightMgrBase:Init', id, groupID, ty, seed, nDuplicateID)
    self.id = id
    self.groupID = groupID
    self.type = ty
    self.stage = 0
    self.nDuplicateID = nDuplicateID -- 副本id
    self.isStart = false -- 是否开始
    self.isOver = false -- 是否战斗结束
    self.log = FightLog() -- 战斗日志
    self.bIsAuto = true

    -- 开始时间
    self.startTime = CURRENT_TIME
    self.nextTime = CURRENT_TIME

    -- 命令列表
    self.cmds = {}

    self.seed = seed --os.time() + math.rand(10000)
    self.rand = Random(self.seed)

    --
    self.arrTeam = {}
    self.arrNP = {}
    self.shield = {} -- 盾墙
    for i = 1, 2 do
        self.arrTeam[i] = Team(i, self)
        self.arrNP[i] = g_nEnterNp
        self.shield[i] = {}
    end

    -- v 4.3
    if ty == SceneType.PVPMirror or ty == SceneType.PVP or ty == SceneType.PVEFreeMatch then
    else
        self.arrNP[2] = 0
    end

    self.arrCard = {} -- 可行动的卡牌队列
    self.arrCurrDeath = {} -- 当前回合死亡的列表

    self.arrPlayer = {}
    self.arrStateID = {} -- 周目id

    self.oid = 3 -- 用于卡牌id分配
    self.currTurn = nil -- 当前操作的卡牌
    self.turnNum = 0 -- 总战斗回合
    self.nStep = 0 -- 当前周目战斗回合
    self.nStepPVE = 0 -- PVE 我方操作次数
    self.nStepOffset = 0 -- 操作数偏移(用于不消耗操作数机制)
    self:SetStepLimit(g_nFightLimit) -- 设置回合限制

    -- 事件处理
    self.oFightEventMgr = FightEventMgr(self)
    self.tmpIdx = 0
end

function FightMgrBase:SetTmpIdx(idx)
    self.tmpIdx = idx
end

function FightMgrBase:GetTmpIdx()
    return self.tmpIdx
end

function FightMgrBase:AddPlayer(uid, teamID)
    table.insert(self.arrPlayer, {uid = uid, teamID = teamID})
end

function FightMgrBase:AddCmd(cmd, data)
    local index = #self.cmds
    -- cmd = {帧数, 命令类型, 命令参数, 时间}
    local cmddatakey = 'data' .. cmd
    local cmddata = {}
    cmddata[cmddatakey] = data
    local msg = {index + 1, cmd, cmddata, CURRENT_TIME - self.startTime}

    if cmd == CMD_TYPE.Start then
        if self.isStart then
            return
        end
    end

    table.insert(self.cmds, msg)
    LogTable(msg, 'FightMgrBase:AddCmd: ')
    -- LogTrace()
    -- LogDebug("FightMgrBase:AddCmd: " .. Json.Encode(msg))

    self:Broadcast('FightProto:RecvCmd', msg)

    return #self.cmds
end

-- 接收命令
function FightMgrBase:RecvCmd(cmd)
    if self.isOver then
        return
    end

    local index = #self.cmds
    local ty = cmd[2]
    local data = cmd[3]
    LogDebugEx('=========', index, cmd[1])
    LogTable(cmd, 'FightMgrBase:RecvCmd')

    if ty == CMD_TYPE.Start then
        if self.isStart then
            return
        end
        self:OnStart(data)
        return true
    end

    if index + 1 ~= cmd[1] then
        if DEBUG then
            ASSERT(nil, STR('命令顺序错误:当前[%s] 收到[%s]', index, cmd[1]))
        end
        return
    end
    -- if index >= cmd[1] then
    -- 	ASSERT(nil, "命令顺序错误")
    -- 	return
    -- end

    if not ty or not data then
        ASSERT()
        return
    end

    if ty == CMD_TYPE.Turn then
        self:DoTurn(data)
        return
    elseif ty == CMD_TYPE.Skill then
        self:DoSkill(data)
    elseif ty == CMD_TYPE.OverLoad then
        self:OverLoad(data)
    elseif ty == CMD_TYPE.Commander then
        self:DoCommanderSkill(data)
    elseif ty == CMD_TYPE.End then
        self:DoEnd(data)
    elseif ty == CMD_TYPE.ChangeStage then
        self:ChangeStage(data.stage)
        self.needChangeStage = nil
    -- elseif ty == CMD_TYPE.Auto then
    -- 	self:AutoFight(data)
    -- elseif ty == CMD_TYPE.AddCard then
    -- elseif ty == CMD_TYPE.DelCard then
    -- elseif ty == CMD_TYPE.Start then
    -- 	self:OnStart(data)
    end

    return true
end

function FightMgrBase:ClientError(uid, err)
    LogDebugEx('FightMgrBase:ClientError()', uid, err)
    LogInfo("uid=%s, nDuplicateID=%s, groupID=%s", uid, self.nDuplicateID or "nil", self.groupID )
    LogInfo("svn = %s err = %s\n cmds = %s", g_svnVersion, err, table.Encode(self.cmds))
end

-- 加载怪物组
function FightMgrBase:LoadConfig(groupID, stage, hpinfo)
    LogDebugEx('FightMgrBase:LoadConfig', self.groupID, groupID)
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

    -- 敌方阵型
    self.arrTeam[2]:LoadConfig(self.groupID, self.stage, hpinfo)
    self.totleState = #config.stage



    -- 无限血必须只能有一个周目
    for i, card in ipairs(self.arrCard) do
        -- 无限血机制
        if card.isInvincible then
            self.isInvincible = card.isInvincible -- 是否为无限血副本
        end
    end

    if self.isInvincible then
        self.nInvStateDamage  = 0 -- 当前阶段伤害量
        self.nInvTotalDamage   = 0 -- 总害量
        -- self.nInvState        = state -- 阶段
        -- self.nInvStatehp      = statehp -- 阶段血量
        -- self.nInvOpnum        = opnum -- 操作数
        -- self.nInvStartopnum   = self.nStepPVE or 0 -- 阶段开始时的操作数
    end
end

-- 加载玩家数据
function FightMgrBase:LoadData(teamID, data, typ, tCommanderSkill)
    LogTable(data, 'FightMgrBase:LoadData')
    --LogTrace()
    --LogTable(tCommanderSkill, "tCommanderSkill")

    -- data = Halo:Calc(data)

    local team = self.arrTeam[teamID]
    ASSERT(team)
    local row = data.row or 3
    local col = data.col or 3
    team:InitMap(row, col)
    team:LoadData(data, typ, tCommanderSkill)
end

-- 打乱数组算法
function FightMgrBase:SortDisorganize(arr)
    local len = #arr
    if len < 2 then
        return
    end
    for i = 1, len - 1 do
        local index = len + 1 - i
        local r = self.rand:Rand(index) + 1
        -- print(i, r, index)
        if index ~= r then
            local t = arr[index]
            arr[index] = arr[r]
            arr[r] = t
        end
    end
end

function MathFloor(x)
    return math.floor(tonumber(tostring(x)))
end

-- 初始化数据后
function FightMgrBase:AfterLoadData(exData)
    LogTable(exData, 'FightMgrBase:AfterLoadData')
    --LogTrace()
    if exData then
        if exData.nNp then
            -- 继承np
            self.arrNP[1] = exData.nNp
        end

        if exData.damage then
            for i, v in ipairs(self.arrCard) do
                local ty = v:GetType()
                if ty == CardType.Monster or ty == CardType.Boss then
                    -- lua底层bug:注 7135*0.2=1427   math.floor(7135*0.2)=1426(前端为1427) 有问题,前后端不一致
                    -- LogDebugEx("AfterLoadData", v.name, v.hp, v.hp * exData.damage, math.floor(tonumber(tostring(v.hp * exData.damage))))
                    -- LogDebug("%d, %f", v.hp * exData.damage,v.hp * exData.damage)
                    v.hp = MathFloor(v.hp * exData.damage)
                end
            end
        end

        if exData.tExBuff then -- 我方buff
            self.tExBuff = exData.tExBuff
        end

        if exData.tMonsterBuff then -- 怪物buff
            self.tMonsterBuff = exData.tMonsterBuff
        end

        if exData.tAllBuff then -- 双方buff
            self.tAllBuff = exData.tAllBuff
        end

        if exData.tRandBuff then -- 随机buff 格式给我方三个人加buff, 敌方1个人加buff[{teamID=1,count=3,buff=[buffid1, buffid2]},{teamID=2,count=1,buff=[buffid1]}]
            self.tRandBuff = exData.tRandBuff
        end

        if exData.nEnterNp then
            for k, v in pairs(exData.nEnterNp) do
                self:AddNP(k, v)
            end
        end

        if exData.adds then
            for i, v in ipairs(self.arrCard) do
                local ty = v:GetType()
                if ty == CardType.Card then
                    for f, info in pairs(exData.adds) do
                        local oVal = v[f]
                        local nVal = oVal + info.av
                        if info.ap and info.ap > 0 then
                            nVal = math.floor(nVal * (100 + info.ap) / 100)
                        end

                        v[f] = nVal
                    end
                end
            end
        end

        if exData.bIsReserveSP then
            self.bIsReserveSP = exData.bIsReserveSP
        end

        if exData.nReserveNP then
            self.nReserveNP = exData.nReserveNP
        end

        if exData.nFocusFire then
        -- self.nFocusFire = exData.nFocusFire
        end
    end

    -- 初始化卡牌顺序
    self:PrintCardInfo('AfterLoadData 重新按速度排序 --1')
    -- BubbleSort(self.arrCard, SortFunByKeyDesc, "speed")
    self:SortDisorganize(self.arrCard)
    self:PrintCardInfo('AfterLoadData 重新按速度排序 --2')

    -- ASSERT()
end

-- 召唤
function FightMgrBase:Summon(caster, teamID, monsterID, pos, data)
    LogDebugEx('FightMgrBase:Summon', monsterID, pos[1], pos[2])
    local team = self.arrTeam[teamID]
    ASSERT(team)
    local site = self:GetPosCard(teamID, pos)
    if site and site:IsLive() then
        LogDebugEx('-------site-------')
        return
    end

    local card = team:Summon(caster, monsterID, pos, data)
    return card
end

-- 合体
function FightMgrBase:Unite(caster, target, monsterID, data)
    LogDebugEx('FightMgrBase:Unite', monsterID)
    local team = self.arrTeam[caster:GetTeamID()]
    ASSERT(team)
    ASSERT(target)
    local card = team:Unite({caster, target}, monsterID, data)
    ASSERT(card)
    card.uid = caster.uid
    card.eskills = caster.eskills
    return card
end

-- 解体
function FightMgrBase:Resolve(card)
    LogDebugEx('FightMgrBase:Resolve', monsterID, card.isLive)
    -- LogTrace()
    -- 解体的时机
    -- self:DoEventWithLog("OnResolve", card)
    local log = {api = 'OnResolve'}
    self.log:Add(log)
    self.log:StartSub('datas')
    -- self.log:Add({api="test"})
    -- SkillBase:CallSkillEx

    self:DoEvent('OnResolve', card)
    self:DealCallSkill()

    card.team:Resolve(card)
    card.skillMgr:DeleteEvent() -- 注销技能事件

    self.log:EndSub('datas')
end

function FightMgrBase:Start()
end

-- 结束
function FightMgrBase:Over(stage, winer)
    LogDebug('FightMgrBase:Over', stage, winer)
    -- self:AddCmd(CMD_TYPE.End, stage)
    for i, v in ipairs(self.arrCard) do
        -- 战斗结束, 解除合体角色
        if v:GetTeamID() == 1 and v:IsUnite() then
            v.team:Resolve(v, true)
        end
    end

    self.isOver = true
    -- self:Destroy()
    --LogTrace()
end

function FightMgrBase:Destroy()
    LogDebugEx('FightMgrBase:Destroy', self == g_FightMgrServer)
   -- LogTrace()

    if g_FightMgrServer and g_FightMgrServer.isOver then
        g_FightMgrServer = nil
    end

    -- -- 释放所有成员变量
    self.log:Destroy()
    self.rand:Destroy()

    for i = 1, 2 do
        self.arrTeam[i]:Destroy()
    end

    self.oFightEventMgr:Destroy()

    for k,v in pairs(self) do
        self[k] = nil
    end

    self.isOver = true
end

-- 切换周目
function FightMgrBase:ChangeStage(stage)
    -- 结束上一个回合
    LogDebugEx('FightMgrBase:ChangeStage')
    self:OnRoundOver()
    --LogTrace()

    stage = stage or self.stage + 1
    LogDebug('切换周目' .. stage)
    self.stage = stage

    for i = #self.arrCard, 1, -1 do
        local v = self.arrCard[i]
        if not v:IsLive() or v:GetTeamID() == 2 then
            if v.type ~= CardType.Card then
                -- 移除死亡对象
                table.remove(self.arrCard, i)
            end
        end
    end

    -- 重新加载数据
    self.arrTeam[2] = Team(2, self)
    self.arrTeam[2]:LoadConfig(self.groupID, self.stage)

    -- 重置跑条
    for i = #self.arrCard, 1, -1 do
        local v = self.arrCard[i]
        v.progress = 0
    end

    --  回合限制
    local config = MonsterGroup[self.groupID]
    ASSERT(config, '没有配置怪物组' .. self.groupID)
    -- DT(config)

    local stageconfig = config.stage[self.stage]
    ASSERT(stageconfig, '怪物组' .. self.groupID .. '周目' .. self.stage)

    if stageconfig.nStepLimit then
        -- 回合限制
        self:SetStepLimit(stageconfig.nStepLimit)
    end

    -- 清除额外回合
    self.oForceNext = nil

    if not self.nextTime then self.nextTime = 0 end

    if self.currTurn then
    end

end

function FightMgrBase:AfterChangeStage(stage)
    -- 调用新生怪物出生事件
    local list = self.arrTeam[2].arrCard

    local log2 = {api = 'BeginOnStart'}
    self.log:Add(log2)
    for i, v in ipairs(list) do
        self:OnBorn(v)
    end
    -- FightActionMgr:PushSkill(self.log:GetAndClean())
end

-- boss出现
function FightMgrBase:BossAppear(b)
    self.bIsBossAppear = b
end

function FightMgrBase:IsBossAppear()
    return self.bIsBossAppear
end

-- 预留np
function FightMgrBase:ReserveNP()
    -- self.nReserveNP = 40 -- 测试用
    if self:IsBossAppear() then
        return 0
    end
    return self.nReserveNP or 0
end

-- 保留sp
function FightMgrBase:IsReserveSP()
    -- self.bIsReserveSP = true -- 测试用
    if self.bIsReserveSP and not self:IsBossAppear() then
        return true
    end
end

-- AI集火(优先攻击对象)(屏蔽)
function FightMgrBase:AISetFocusFire(team)
    -- if self.isOver then return end
    -- if not self.nFocusFire then return end
    -- -- local teamID = self:GetTeamIDByUID(PlayerClient:GetUid())
    -- -- local team = self:GetTeam(teamID)
    -- local oFocusFire = team.oFocusFire
    -- if oFocusFire and oFocusFire:IsLive() then
    -- 	return -- 有集火对象
    -- end
    -- local oEnemyTeam = self:GetEnemyTeam(team)
    -- -- local oid = nil
    -- local ret = {}
    -- -- 没有集火对象, 根据配置选择集火对象
    -- if self.nFocusFire == 1 then -- boss
    -- 	ret = oEnemyTeam.filter:GetObjByType(CardType.Boss)
    -- 	if #ret == 0 then
    -- 		ret = oEnemyTeam.filter:GetObjByType(CardType.Monster)
    -- 	end
    -- 	-- if ret[1] then oid = ret[1].oid end
    -- elseif self.nFocusFire == 2 then -- 小兵
    -- 	ret = oEnemyTeam.filter:GetObjByType(CardType.Monster)
    -- 	-- if ret[1] then oid = ret[1].oid end
    -- elseif self.nFocusFire == 3 then -- 盾
    -- 	ret = oEnemyTeam.filter:GetObjHaveShield()
    -- else
    -- 	return
    -- end
    -- team.oFocusFire = ret[1]
    -- if team.oFocusFire and team.oFocusFire:IsLive() then
    -- 	self:Send(uid, "FightProto:FocusFire", {nFocusFireID = team.oFocusFire.oid})
    -- else
    -- 	self:Send(uid, "FightProto:FocusFire", {})
    -- end
end

function FightMgrBase:AddCard(card)
    for i, v in ipairs(self.arrCard) do
        if v == card then
            -- 死亡复活的, 不可重复添加
            return
        end
    end
    table.insert(self.arrCard, card)
    card.oid = self.oid
    if DEBUG then
        card.name = card.name .. '[' .. card.oid .. ']'
    end
    self.oid = self.oid + 1
end

-- 入场事件
function FightMgrBase:OnBorn(card, isspecial)
    LogDebugEx('FightMgrBase:OnBorn', card.name)
    local log = {api = 'OnBorn'}
    self.log:Add(log)
    self.log:StartSub('datas')
    local effect = SkillEffect[72001]
    card:AddNP(card:Get('np') or 0, effect.apiSetting)

    if self.tExBuff and card:GetTeamID() == 1 then
        for i, buffID in ipairs(self.tExBuff) do
            card:AddBuff(card, buffID)
        end
    end

    if self.tMonsterBuff and card:GetTeamID() == 2 then
        for i, buffID in ipairs(self.tMonsterBuff) do
            card:AddBuff(card, buffID)
        end
    end

    if self.tAllBuff then
        for i, buffID in ipairs(self.tAllBuff) do
            card:AddBuff(card, buffID)
        end
    end

    if isspecial then
        -- 复活/召唤/合体等非正常入场
        self.oFightEventMgr:DoEvent('OnBornSpecial', card)
    else
        -- 正常入场
        self.oFightEventMgr:DoEvent('OnBorn', card)

        -- 2835 【主干】角色：虹-4被动技-4401505，首次行动被宙斯技能攻击，不会反伤
        self.bIsApply = nil
    end

    card:OnBorn()

    self.log:EndSub('datas')

    -- 2835 【主干】角色：虹-4被动技-4401505，首次行动被宙斯技能攻击，不会反伤
    -- 2835会导致3212 【主干】圣歌，触发被时，200700501触发了两次
    -- self.bIsApply = nil
end

function FightMgrBase:DelCard(card)
    for i, v in ipairs(self.arrCard) do
        if v == card then
            table.remove(self.arrCard, i)
            return
        end
    end
end

--寻找攻击对象
function FightMgrBase:Select()
end

function FightMgrBase:GetRand()
    return self.rand
end

function FightMgrBase:GetDupId()
    return self.nDuplicateID
end

-- 获取进度条
function FightMgrBase:GetProgress(showNest)
    local list = {}
    for i, v in ipairs(self.arrCard) do
        if v:IsLive() then
            local info = {
                id = v.oid,
                progress = v.progress,
                speed = v:Get('speed')
            }
            if showNest and v.oid == showNest.oid then
                info.arrow = true
            end
            table.insert(list, info)
        end
    end

    DT(list, 'before-----')

    function bubble_sort(arr, sortfun)
        local tmp = 0
        for i = 1, #arr - 1 do
            for j = 1, #arr - i do
                if sortfun(arr[j], arr[j + 1]) then
                    tmp = arr[j]
                    arr[j] = arr[j + 1]
                    arr[j + 1] = tmp
                end
            end
        end
    end

    local sortfun = function(first, second)
        -- 此处用1000减的话,  有可能出现负数, 导致顺序错误
        if (1010 - first.progress) / first.speed > (1010 - second.progress) / second.speed then
            return true
        end
    end

    bubble_sort(list, sortfun)

    if showNest then
        local info = {
            id = showNest.oid,
            progress = showNest.progress,
            speed = showNest:Get('speed')
        }
        table.insert(list, 1, info)
    end

    DT(list, 'after-----')

    return list
end
------------------------------------------------------------------
-- 计算下一个
function FightMgrBase:CalcNext()
    local min = 10000
    local nextcard = nil
    LogDebugEx('------------------------', #self.arrCard)
    self:PrintCardInfo('CalcNext--11--')

    -- 强制下个回合轮到这个角色
    local oForceNext = self.oForceNext
    if oForceNext and oForceNext:IsLive() then
        self.oForceNext = nil
        return 0, oForceNext
    end

    for i, v in ipairs(self.arrCard) do
        if v:IsLive() then
            if v.progress > 1001 then
                return 0, v -- 单拉超过1001, 优先出手
            end
        end
    end

    local final = {} -- 已经到终点的卡牌集合

    for i, v in ipairs(self.arrCard) do
        if v:IsLive() then
            local t = v:CalcNextTime()
            if min > t then
                min = t
                nextcard = v
            end

            if t == 0 then
                table.insert(final, 1, i)
            end
        end
    end
    self:PrintCardInfo('CalcNext--22--')
    LogTable(final, 'final')

    if min == 0 and #final > 1 then
        local list = {}
        -- for i=#final,1,-1 do
        -- 	local v = final[i]
        -- 	table.insert(list, 1, self.arrCard[v]) -- 倒插
        -- 	table.remove(self.arrCard, v)
        -- end
        for i, v in ipairs(final) do
            table.insert(list, self.arrCard[v])
            table.remove(self.arrCard, v)
        end

        BubbleSort(list, SortFunByKeyAsc, 'speed')

        for i, v in ipairs(list) do
            LogDebugEx('插入', i, v.name, v:Get('speed'))
            table.insert(self.arrCard, 1, v)
        end

        self:PrintCardInfo('CalcNext-- 多个卡牌同时到达终点,重新按速度排序 --')
        return min, self.arrCard[1]
    -- ASSERT()
    end

    if min < 0 then
        min = 0 -- 有插队的卡牌, 不要算时间
    end

    return min, nextcard
end

-- 强制下个回合轮到这个角色
function FightMgrBase:SetNextCard(card)
    self.oForceNext = card
end

-- 全部拉条
function FightMgrBase:AddAllTime(t, card)
    local min = 10000
    local nextcard = nil
    local index = nil
    self:PrintCardInfo('AddAllTime--11--')
    for i, v in ipairs(self.arrCard) do
        if v:IsLive() then
            v:AddTime(t)
            if card == v then
                index = i
            end
        end
    end

    if card then
        card:NextProgress(t)
    end
    -- 把刚刚操作过的卡牌插到队列最后面
    if index then
        LogDebugEx('AddAllTime' .. index .. '  ' .. card.name)
        table.remove(self.arrCard, index)
        table.insert(self.arrCard, card)
    end

    self:PrintCardInfo('AddAllTime--22--')
end

function FightMgrBase:PrintCardInfo(bt)
    LogDebug('-----PrintCardInfo-------' .. (bt or ''))
    local str = '\ncurr np = [' .. self.arrNP[1] .. '][' .. self.arrNP[2] .. ']\n'

    for i, v in ipairs(self.arrCard) do
        -- LogTable(v, "FightMgrBase:PrintCardInfo" .. i .. ":")
        if v:IsLive() then
            str = str .. v.oid .. '\t' ..
                        v.name .. '_' .. v.teamID ..'\thp[' ..
                                        v.hp .. ']\tspeed[' .. v:Get('speed') .. ']\tprogress[' .. v.progress .. ']\n'
        end
    end

    LogDebugEx(str)

    for i,v in ipairs(self.arrTeam) do
        v:Print()
    end
end

-- 针对一方集体拉条
function FightMgrBase:AddTeamProgress(teamID, progress, max, effectID)
    -- local len = #self.arrCard
    -- for i=len,1,-1 do
    -- 	local v = self.arrCard[i]
    -- 	if v:IsLive() and v:GetTeamID() == teamID then
    -- 		v:AddProgress(progress, max, effectID)
    -- 	end
    -- end
    for i, v in ipairs(self.arrCard) do
        if v:IsLive() and v:GetTeamID() == teamID then
            v:AddProgress(progress, max, effectID)
        end
    end
end

-- 针对一方集体加血
function FightMgrBase:AddTeamHp(teamID, hp)
    local ret = {}
    for i, v in ipairs(self.arrCard) do
        if v:IsLive() and v:GetTeamID() == teamID then
            v:AddHp(hp)
            table.insert(ret, {id = v.oid, hp = v.hp, add = hp})
        end
    end
    return ret
end

function FightMgrBase:Wait(tm)
    LogDebugEx('FightMgrBase:Wait', tm, tm * 100 / fight_play_speed_faster, self.nextTime, CURRENT_TIME)
    tm = math.floor(tm * 100 / fight_play_speed_faster) + 1
    -- tm = 1
    if self.nextTime and self.nextTime > CURRENT_TIME then
        self.nextTime = self.nextTime + tm
    else
        self.nextTime = CURRENT_TIME + tm
    end
end

-- 加盾墙
function FightMgrBase:AddShieldWall(buffer)
    local teamID = buffer.card:GetTeamID()
    table.insert(self.shield[teamID], buffer)
end

-- 除盾墙
function FightMgrBase:DelShieldWall(buffer)
    local teamID = buffer.card:GetTeamID()
    for k, v in ipairs(self.shield[teamID]) do
        if v == buffer then
            table.remove(self.shield[teamID], k)
        end
    end
end

------------------------------------------------------------------
function FightMgrBase:GetShieldWall(teamID)
    return self.shield[teamID]
end

function FightMgrBase:GetPosCard(teamID, pos)
    local team = self.arrTeam[teamID]
    ASSERT(team)

    local card = team:GetCard(pos[1], pos[2])
    --team:Print()
    --ASSERT(card)
    return card
end

function FightMgrBase:GetCardByOID(id)
    for i, v in ipairs(self.arrCard) do
        LogDebugEx('GetCardByOID', v.oid, id)
        if v.oid == id then
            return v
        end
    end
end

-- 获取背景音乐
function FightMgrBase:GetBgm()
    if not self.groupID then
        return
    end

    local stage = self.stage or 1
    local config = MonsterGroup[self.groupID]
    ASSERT(config)
    local stageconfig = config.stage[stage]
    if stageconfig and stageconfig.bgm then
        return stageconfig.bgm
    end
end

-- 设置回合限制
function FightMgrBase:SetStepLimit(nStepLimit)
    self.nStep = 0
    self.nStepPVE = 0
    self.nStepLimit = nStepLimit or g_nFightLimit
    self.nStepOffset = 0
end

-- 是否pve关卡
function FightMgrBase:IsPVE()
    if self.type == SceneType.PVP or self.type == SceneType.BOSS or self.type == SceneType.GuildBOSS or self.type == SceneType.PVEFreeMatch then  --or self.type == SceneType.GlobalBoss
        return false
    end
    
    return true
end

function FightMgrBase:IsPVP()
    return false
end

----------skill-----------
function FightMgrBase:CanAttack(caster, target, skillID)
    return caster.skillMgr:CanAttack(caster, target, skillID)
end

-- 看看是否有挡刀的
function FightMgrBase:CheckProtect(caster, target, data)
    local targetID = target.oid
    --LogDebugEx("CheckProtect", targetID)
    for i, v in ipairs(self.arrCard) do
        if v:GetTeamID() ~= caster:GetTeamID() and v.oid ~= targetID then
            local p = v:IsProtect(target)
            --LogDebugEx("v ", caster:GetTeamID(), v:GetTeamID()  , v.oid , targetID, p)
            --LogDebugEx("IsProtect =  ", p)
            if p then
                data.protectId = targetID
                return {v.oid}
            end
        end
    end
end

function FightMgrBase:CheckProtectEx(caster, target, data, oSkill)
    --LogDebugEx("FightMgrBase:CheckProtectEx", oSkill.id, oSkill.isSingle)
    --LogTable(target, "before=")
    --LogTable(data, "data=")
    if oSkill.isSingle and target then
        -- 处理挡刀
        local targetID = target[1]
        if targetID then
            local card = self:GetCardByOID(targetID)
            target = self:CheckProtect(caster, card, data) or target
        end
    end
    --LogTable(target, "after=")
    return target
end

-- 攻击
function FightMgrBase:Attack(caster, target, data, pos)
    -- LogTable(target, "Attack target @=")
    local listTarget = {}
    local skillID = data.skillID
    local skillMgr = caster.skillMgr
    local oSkill = skillMgr:GetSkill(skillID)
    -- LogDebugEx("FightMgrBase:Attack", skillID)
    ASSERT(oSkill, '找不到技能' .. skillID)

    target = self:CheckProtectEx(caster, target, data, oSkill)
    -- if oSkill.isSingle and target then -- 处理挡刀
    -- 	local targetID = target[1]
    -- 	if targetID then
    -- 		local card = self:GetCardByOID(targetID)
    -- 		target = self:CheckProtect(caster, card, data) or target
    -- 	end
    -- end

    for i, oid in ipairs(target or {}) do
        local card = self:GetCardByOID(oid)
        table.insert(listTarget, card)
    end

    if not self:CanAttack(caster, listTarget, skillID) then
        LogDebug('--------not self:CanAttack')
        return false
    end

    LogDebugEx('攻击者:' .. caster.name, skillID)

    caster:OnUseSkill()
    local ret = oSkill:Apply(caster, listTarget, pos, data)
    if ret and oSkill.upgrade_type == CardSkillUpType.OverLoad then
        caster:AddBuff(caster, g_overLoadBuffer)
        caster:AddSP(-g_overLoadCost)
        if self.oDuplicate then
            self.oDuplicate:OverLoad({ caster.cuid })
        end
    end

    -- self.isRoundOver = true
    return ret
end

-- 获取敌方阵容
function FightMgrBase:GetEnemyTeam(card)
    if card:GetTeamID() == 1 then
        return self.arrTeam[2]
    else
        return self.arrTeam[1]
    end
end

-- 获取敌方阵容ID
function FightMgrBase:GetEnemyTeamID(card)
    if card:GetTeamID() == 1 then
        return 2
    else
        return 1
    end
end

function FightMgrBase:GetTeam(teamID)
    return self.arrTeam[teamID]
end

function FightMgrBase:GetTeamIDByUID(uid)
    local teamID = nil

    for i, v in ipairs(self.arrPlayer) do
        if uid == v.uid then
            return v.teamID
        end
    end

    ASSERT(teamID, '没有找到玩家teamID, uid=' .. uid)
end

-- 获取指挥官技能
function FightMgrBase:GetCommanderSkill(card)
    -- 指挥官技能
    local oTeam = self:GetTeam(card:GetTeamID())
    local oCommander = oTeam.oCommander
    -- ASSERT(oCommander)
    if oCommander then
        return oCommander.skillMgr:GetClientSkillInfo()
    end
end

-- 增加减少cost
function FightMgrBase:AddNP(teamID, num, effectID)
    -- LogTrace()
    LogDebug('AddNP teamID[%s], add[%s], np[%s] g_CostMax[%s]', teamID, num, self.arrNP[teamID], g_CostMax)
    if num == 0 then
        return
    end
    self.arrNP[teamID] = self.arrNP[teamID] + num
    if self.arrNP[teamID] > g_CostMax then
        self.arrNP[teamID] = g_CostMax
    elseif self.arrNP[teamID] < 0 then
        self.arrNP[teamID] = 0
    end

    self.log:Add(
        {
            api = 'AddNp',
            teamID = teamID,
            attr = 'np',
            np = self.arrNP[teamID],
            add = num,
            max = g_CostMax,
            effectID = effectID
        }
    )
end

-- 判断cost
function FightMgrBase:CheckNP(teamID, num)
    LogDebugEx('FightMgrBase:CheckNP', teamID, num, self.arrNP[teamID])
    if self.arrNP[teamID] >= num then
        return true
    end
    return false
end

-- 判断cost
function FightMgrBase:GetNP(teamID)
    return self.arrNP[teamID]
end

----------event-----------
function FightMgrBase:OnDeath(card, killer)
    LogDebugEx('FightMgrBase:OnDeath', self.isOver, card.name, killer.name)
    if self.isOver then
        return
    end

    --LogTrace()
    self.needCheckOver = killer

    -- for i,v in ipairs(self.arrCard) do
    -- 	LogDebugEx("----",i, v.name, v:IsLive())
    -- end

    -- 此处循环, 有对象死了, 删除对象, 导致循环少了一次
    -- for i, v in ipairs(self.arrCard) do
    for i, v in ipairs(CopyIpairs(self.arrCard)) do
        -- LogDebugEx("FightMgrBase:OnDeath", i, v.name, v:IsLive())
        if v ~= card and v:IsLive() then
            v:OnOtherDeath(card)
        end
    end

    LogDebugEx('添加到死亡列表', card.name)
    table.insert(self.arrCurrDeath, card)
end

-- 处理自己的死亡事件
function FightMgrBase:DoDeathEvent()
    LogDebugEx('FightMgrBase:DoDeathEvent()', #self.arrCurrDeath)
    if #self.arrCurrDeath == 0 then
        return
    end

    local flag = true
    for i, v in ipairs(self.arrCurrDeath) do
        LogDebugEx('v.skillMgr.arrDeathEvent', v.name, #v.skillMgr.arrDeathEvent)
        if #v.skillMgr.arrDeathEvent > 0 then
            flag = false
        end
    end
    if flag then
        return
    end

    --LogTrace()
    local log = {api = 'OnDeath'}
    self.log:Add(log)
    self.log:StartSub('datas')

    for i, v in ipairs(self.arrCurrDeath) do
        v.skillMgr:DoDeathEvent(v.currKiller, v)
    end

    self.log:EndSub('datas')

    LogDebugEx('FightMgrBase:DoDeathEvent() end')
    self.arrCurrDeath = {}
    -- LogTable(self.log:Get())
end

function FightMgrBase:CheckOver(isRoundOver)
    -- LogDebugEx("FightMgrBase:CheckOver", self.nStep , self.nStepLimit, isRoundOver or "false", self.needCheckOver and true or false)
    -- LogTrace()
    -- if self.oForceOver then
    --     self:Over(self.stage, self.oForceOver)
    --     return true
    -- end

    -- local stepLimit = self:GetStepLimit()
    -- LogDebug("FightMgrBase:CheckOver(isRoundOver:%s), stepLimit:%s, self:IsPVE():%s, self.nStepPVE:%s, self.nStep:%s", isRoundOver, self.nStepLimit, self:IsPVE(), self.nStepPVE, self.nStep)
    if self:IsPVE() then
        if self.nStepPVE > self.nStepLimit then
            self:Over(self.stage, 0)
            return true
        end
    else
        if self.nStep > self.nStepLimit then
            self:Over(self.stage, 0)
            return true
        end
    end

    if not self.needCheckOver then
        return
    end

    if self.isOver then
        return true
    end

    -- if self.isRoundOver then
    -- 	self.isRoundOver = nil
    -- 	self:OnRoundOver()
    -- 	LogTable(self.log:GetAndClean())
    -- end

    -- if isRoundOver and self.isRoundOver then
    -- 	self.isRoundOver = nil
    -- 	self:OnRoundOver()
    -- 	LogTable(self.log:GetAndClean())
    -- end

    local card = self.needCheckOver
    local over = false
    local count = {0, 0}
    -- self:PrintCardInfo("CheckOver")
    for i, v in ipairs(self.arrCard) do
        local teamID = v:GetTeamID()
        if v:IsLive() then
            count[teamID] = count[teamID] + 1
        end
    end
    -- LogTable(count)

    if count[1] == 0 or count[2] == 0 then
        -- 本来应该结束的, 但是需求最后一次死亡还要触发事件
        if isRoundOver then
            self:OnRoundOver()
            LogTable(self.log:GetAndClean(), "FightMgrBase:CheckOver() self.log:GetAndClean()")
            return self:CheckOver()
        end
    end

    self.needCheckOver = false
    LogDebugEx("count ---", count[1], count[2])

    if count[1] == 0 then
        self:Over(self.stage, 2)
        return true
    elseif count[2] == 0 then
        local stage = self.stage

        if self.arrStateID[stage + 1] then
            -- LogTrace()
            self.needChangeStage = CURRENT_TIME + 3
        else
            self:Over(self.stage, 1)
            return true
        end
    end
end

function FightMgrBase:OnRoundOver()
    if not self.currTurn then
        return
    end

    LogDebugEx('FightMgrBase:OnRoundOver()', self.nStep + 1)
    -- LogTrace()
    self.nStep = self.nStep + 1

    local flag = false

    if self:IsPVE() then
        LogDebug("FightMgrBase:OnRoundOver() self.uid:%s == self.currTurn.uid:%s, self.nStepPVE:%s, self.type:%s",  self.uid, self.currTurn.uid, self.nStepPVE, self.type)
        if self.uid == self.currTurn.uid then
            self.nStepPVE = self.nStepPVE + 1 -- PVE 我方操作次数+1
        end

        if self.nStepPVE >= self.nStepLimit then
            flag = true
        end
    else
        if self.nStep >= self.nStepLimit then
            flag = true
        end
    end

    -- 回合结束清除buff状态
    for i, v in ipairs(self.arrCard) do
        if v:IsUnite() then 
            v:OnRoundOver() --检查是否需要解体
        end
    end

    if flag then
        self:CheckOver()

        if not self.isOver then
            -- 最后一个回合还没有结果, 直接判输
            local tWiner = 0
            -- 历战挑战关（BuffBattle）按连锁规则处理：操作数上限算赢
            local isTrialBuffBattle = SceneType.BuffBattle == self.type and self.oDuplicate and self.oDuplicate.IsTrialChallengeDup and self.oDuplicate:IsTrialChallengeDup()
            if SceneType.TowerDeep == self.type or SceneType.ChainFront == self.type or isTrialBuffBattle then   -- 深塔计划特殊处理，操作数上限算赢
                tWiner = 1
                self.isStepLimitWin = true
            end
            self:Over(self.stage, tWiner)
        end
        return
    end

    -- 指挥官技能 (pvp没有指挥官技能)
    for i, team in ipairs(self.arrTeam) do
        local oCommander = team.oCommander
        if oCommander and (team:GetTeamID() == self.currTurn:GetTeamID()) then
            oCommander.skillMgr:OnTurn()
        end
    end

    -- 回合结束清除buff状态
    for i, v in ipairs(self.arrCard) do
        v.oLastBuffer = nil
    end

    -- if self.nAddTime then
    -- 	self:AddAllTime(self.nAddTime, self.currTurn)
    -- 	self.nAddTime = nil
    -- end
    local currTurn = self.currTurn
    self.currTurn = nil
    -- LogTrace()
    return currTurn
end

-- 由于回合结束触发了技能打死怪物, 导致切换切换周目, 所以回合结束之后判断一次切换回合
function FightMgrBase:AfterRoundOver()
    LogDebugEx('FightMgrBase:AfterRoundOver')
    self:CheckOver(true)
    if self.needChangeStage then
        self:ChangeStage()
        self.needChangeStage = nil
        return true
    end
end

function FightMgrBase:OnTimer(tm)
    -- LogDebugEx("FightMgrBase:OnTimer", self.id, self.isStart, self.isOver)

    -- 长时间没用的战斗结束掉
    -- 玩家在线且玩家所属的战斗是本场战斗则不处理, 其他情况清理掉

    if not self.isStart then
        return
    end

    if self.isOver then
        return
    end
    if self:CheckOver(true) then
        return
    end

    -- LogDebugEx("FightMgrBase:OnTimer 111 ", CURRENT_TIME, self.needChangeStage)
    if self.needChangeStage and self.needChangeStage - CURRENT_TIME < 0 then
        self:ChangeStage()
        -- self:AfterChangeStage()
        self.needChangeStage = nil
    elseif self.needChangeStage then
        return
    end

    -- LogDebugEx("FightMgrBase:OnTimer 22 ", CURRENT_TIME, self.nextTime)
    if self.nextTime and self.nextTime - CURRENT_TIME < 0 then
        self:OnTurnNext()
    end
end

function FightMgrBase:OnTurnNext()
    if self.isOver then return end

    LogDebugEx('FightMgrBase:OnTurnNext()')

    self:OnRoundOver() -- 由于回合结束触发了技能打死怪物, 导致切换切换周目
    if self.isOver then return end

    if DEBUG then
        LogTable(self.log:GetAndClean(), "FightMgrBase:OnTurnNext() self.log:GetAndClean()")
    end

    -- 由于回合结束触发了技能打死怪物, 导致切换切换周目, 所以回合结束之后判断一次切换回合
    if self:AfterRoundOver() then
        return true
    end
    if self.isOver then return end

    self.nextTime = nil
    local t, card = self:CalcNext()
    ASSERT(card)
    --LogTrace()
    LogDebugEx('Next  ------', card.name, card.oid)
    -- DT(card:GetData())
    self:AddAllTime(t, card)

    self:AddCmd(CMD_TYPE.Turn, {id = card.oid})

    self.turnNum = self.turnNum + 1
    self.currTurn = card
    self.waitForDoSkill = card.oid

    if self.tWaitForRestore then
        self:SendRestoreFight(self.tWaitForRestore.uid, self.tWaitForRestore.nCmdIndex)
        self.tWaitForRestore = nil
    end

    local str = '第' .. self.turnNum .. '回合;操作数'..(self.nStep+self.nStepOffset)..'\n'
    self:PrintCardInfo(str)

    LogDebug('##############玩家行动#################' .. card.name .. ' ' .. card.oid)
    self:ResetSkillSign()
    -- 处理buffer行动前
    local log = {api = 'OnRoundBegin'}
    self.log:Add(log)
    self.log:StartSub('datas')
    self.oFightEventMgr:DoEvent('OnRoundBegin', card)
    self.oFightEventMgr:DoEvent('OnAfterRoundBegin', card)
    self.log:EndSub('datas')

    if not card:IsLive() then
        -- 已经死亡
        self:Wait(3)
        LogDebugEx('card is death', card.name)
        card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
        -- self.isRoundOver = true
        return
    end

    -- 可能敌方都死光了
    if self:CheckOver() then
        return
    elseif self.needChangeStage then
        -- 需要切换周目
        LogDebugEx("self.needChangeStage", self.needChangeStage)
        -- return
    end

    -- 控制类buffer处理
    local isMotionless = card:IsMotionless()  or self.needChangeStage
    LogDebugEx('============isMotionless===============', isMotionless, type(isMotionless), card:IsMotionless(), self.needChangeStage)
    if isMotionless then
        LogDebug('-------此处无法行动-------' .. card.name)
        card.bufferMgr:OnUpdateBuffer()
        --无法行动要处理buff回合-1
        self:UpdateProgress(nil, card, false)
        self:Wait(1)
    end

    card:OnTurn(isMotionless)

    -- -- 同步数据
    -- local sendData = {}
    -- sendData.list = {}
    -- for i,v in ipairs(self.arrCard) do
    -- 	local oid = v.oid
    -- 	local datas = {oid = v.oid, id = v.id, name = v.name, hp = v.hp, progress = v.progress}
    -- 	sendData.list[oid] = datas
    -- end

    -- LogTable(sendData, "sendData = ")
    -- for i,v in ipairs(self.arrPlayer) do
    -- 	v.player:Send("FightProto:SyncFight", sendData)
    -- end

    card:AIOnTurn(isMotionless)
    card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
    LogDebugEx('OnTurnNext end--------', card.name, card.oid)
    LogTable(self.log:GetAndClean(), "FightMgrBase:OnTurnNext() self.log:GetAndClean()")
end

-- 自动战斗
function FightMgrBase:AutoFight(uid, data)
    LogDebugEx('FightMgrBase:AutoFight', uid)
    if self.isOver then
        return
    end
    if not self.currTurn then
        return
    end
    if data.id ~= self.currTurn.oid then
        return
    end
    if not self.waitForDoSkill or self.waitForDoSkill ~= self.currTurn.oid then
        return
    end

    -- 不是轮到自己就不要发
    LogDebugEx('AutoFight', uid, self.currTurn.uid)
    if uid ~= self.currTurn.uid then
        ASSERT()
        return
    end

    self.currTurn:DoAI()
    self.waitForDoSkill = nil
    -- FightProto:SendCmd(CMD_TYPE.Auto,{id = 1});
end

-- 设置集火对象
function FightMgrBase:SetFocusFire(uid, data)
    if self.isOver then
        return
    end
    LogDebugEx('FightMgrBase:SetFocusFire', uid)
    -- if not self.currTurn then
    -- 	return
    -- end

    local teamID = self:GetTeamIDByUID(uid)

    -- for i,v in ipairs(self.arrPlayer) do
    -- 	if uid == v.uid then
    -- 		teamID = v.teamID
    -- 		break
    -- 	end
    -- end

    -- ASSERT(teamID, "没有找到玩家teamID, uid="..uid)

    local team = self:GetTeam(teamID)
    if data.nFocusFireID then
        local card = self:GetCardByOID(data.nFocusFireID)
        -- if not card or not team then ASSERT(nil, "not card or not team") end
        if card and card:IsLive() then
            team.oFocusFire = card
        else
            team.oFocusFire = nil
        end
    else
        team.oFocusFire = nil
    end

    if team.oFocusFire and team.oFocusFire:IsLive() then
        self:Send(uid, 'FightProto:FocusFire', {nFocusFireID = team.oFocusFire.oid})
    else
        self:Send(uid, 'FightProto:FocusFire', {})
    end
end

-- 设置使用技能AI策略
-- function FightMgrBase:SetSkillAI(uid, data)
-- 	if self.isOver then return end
-- 	LogDebugEx("FightMgrBase:SetSkillAI", uid)

-- 	local teamID = nil

-- 	local card = self:GetCardByOID(data.id)
-- 	ASSERT(card)
-- 	if card.uid ~= uid then
-- 		ASSERT(nil, "非法用户设置ai使用技能")
-- 		return
-- 	end

-- 	card.isUseCommon = data.isUseCommon

-- 	self:Send(uid, "FightProto:SetSkillAI", data)
-- end

-- 主动退出
function FightMgrBase:Quit(uid, data)
    LogDebugEx('FightMgrBase:Quit', uid)
    -- 副本不做输赢, 可以重新开始战斗, 放弃通过撤退来操作
    if self.oDuplicate then
        if data and data.bIsQuit then
            -- 需要撤退
        else
            return
        end
    end

    local teamID = self:GetTeamIDByUID(uid)

    -- 操作日志
    -- StatsMgr:AddLogRecord(GetPlayer(uid), LogItem.QuitFight, self.id, self.nDuplicateID, self.groupID)
    if GetPlayer then
        SSSDK:Event(
            GetPlayer(uid),
            'QuitFight',
            {
                fid = self.id,
                duplicate_id = self.nDuplicateID,
                sceneType = self.type,
                groupID = self.groupID
            }
        )
    end

    self.isForceOver = true
    if teamID == 1 then
        self:Over(self.stage, 2)
    else
        self:Over(self.stage, 1)
    end
end

function FightMgrBase:ResetTempAttr()
    for i, v in ipairs(self.arrCard) do
        v:ResetTempAttr()
    end
end

function FightMgrBase:ResetTempSign()
    for i, v in ipairs(self.arrCard) do
        v:ResetTempSign()
    end
end

-- 重置技能调用标志(反击，协助、追击)
function FightMgrBase:ResetSkillSign()
    self.bCallHelp = nil
    self.bBeatAgain = nil
    self.bBeatBack = nil
    self.bCallSkill = nil
    self.bInHelp = nil -- 用于处理不要在协战中触发协战
end

function FightMgrBase:beRelogin()
    return self.relogin
end

function FightMgrBase:onPlayerLogout(player)
end

-- 执行技能
function FightMgrBase:DoSkill(data)
end

-- 执行指挥官技能
function FightMgrBase:DoCommanderSkill(data)
end

-- OverLoad
function FightMgrBase:OverLoad(data)
    -- local caster = self.currTurn
    local caster = self:GetCardByOID(data.skill[1].casterID)
    ASSERT(caster)
    if caster ~= self.currTurn then
        LogDebugEx(
            '当前发命令者:' .. caster.name .. '_' .. caster:GetTeamID(),
            '当前轮到:' .. self.currTurn.name .. '_' .. caster:GetTeamID()
        )
        ASSERT(nil, '数据不一致')
    end

    if caster:IsMotionless() then
        ASSERT(nil, '无法行动')
        return
    end

    if #data.skill ~= 3 then
        ASSERT(nil, 'OVERLOAD必须是固定行动3次')
        return
    end

    -- 检测消耗
    if caster.skillMgr:CanOverLoad(data.skill) ~= 1 then
        ASSERT(nil, '不能使用OVERLOAD')
        return
    end

    local waitTime = 0

    self.waitForDoSkill = nil

    for i, v in ipairs(data.skill) do
        if not caster:IsLive() then
            return waitTime
        end

        local target, pos
        -- 此处不一定是选中的是一个对象, 可能是一个空格子,  需要根据技能再筛选出受技能的对象
        if v.target then
            target = caster:GetSkillRange(v.skillID, v.target)
            pos = v.target.pos
        end

        -- 对象已经死亡
        if target and #target < 1 then
            LogDebugEx('对象已经死亡 重新筛选目标')
            local d = caster:AIGetTarget(v.skillID)
            target = d.targetIDs or {}
            pos = d.pos or v.target.pos
            if #target == 0 then
                LogDebug('没有目标, 跳过OverLoad')
                caster:AddBuff(caster, g_overLoadBuffer)
                return waitTime
            end
        end

        local ret = self:Attack(caster, target, v, pos or v.pos)

        local config = skill[v.skillID]
        if config then
            waitTime = waitTime + (config.action_time / 1000)
        else
            waitTime = waitTime + 4
        end
    end
    LogDebugEx('=====================OverLoad======================', g_overLoadBuffer)
    caster:AddBuff(caster, g_overLoadBuffer)

    -- LogTable(self.log:GetAndClean())
    -- ASSERT()
    return waitTime
end

function FightMgrBase:CallSkill(caster, target, skillID)
    local caster = self.currTurn
    ASSERT(caster)

    for i, v in ipairs(data.skill) do
        local target, pos
        -- 此处不一定是选中的是一个对象, 可能是一个空格子,  需要根据技能再筛选出受技能的对象
        if v.target then
            target = caster:GetSkillRange(v.skillID, v.target)
            pos = v.target.pos
        end

        -- 对象已经死亡
        if target and #target < 1 then
            LogDebugEx('对象已经死亡 重新筛选目标')
            local d = caster:AIGetTarget(v.skillID)
            target = d.targetIDs or {}
            pos = d.pos or v.target.pos
            if #target == 0 then
                LogDebug('没有目标, 跳过OverLoad')
                return waitTime
            end
        end

        local ret = self:Attack(caster, target, v, pos or v.pos)
    end
    return waitTime
end
local unpack = unpack or table.unpack
-- 处理追击反击
function FightMgrBase:DealCallSkill()
    self.nCallSkillIndex = self.nCallSkillIndex or 0
    self.nCallSkillIndex = self.nCallSkillIndex + 1

    LogDebugEx('FightMgrBase:DealCallSkill', self.nCallSkillIndex)

    -- 行动结束追击反击
    if self.lstCallSkill and #self.lstCallSkill > 0 then
        LogDebugEx('self.lstCallSkill', #self.lstCallSkill)
        for i, v in ipairs(self.lstCallSkill) do
            -- print("--------lstCallSkill------------------", i)
            -- xpcall(v.fun, XpcallCB, v.obj, unpack(v.arg))

            -- obj 为技能
            v.fun(v.obj, unpack(v.arg))
        end

        self.lstCallSkill = nil
    end

    self.nCallSkillIndex = self.nCallSkillIndex - 1
    LogDebugEx('FightMgrBase:DealCallSkill() end', self.nCallSkillIndex)
end

-- 执行角色切换
function FightMgrBase:DoTurn(data)
end

-- 战斗结束
function FightMgrBase:DoEnd(data)
end

-- 更新进度条
function FightMgrBase:UpdateProgress(data)
end

function FightMgrBase:OnStart(data)
    if self.isStart then
        return
    end
    self.isStart = true

    local log = {api = 'OnStart'}
    self.log:Add(log)
    self.log:StartSub('datas')

    local log2 = {api = 'BeginOnStart'}
    self.log:Add(log2)

    for i, v in ipairs(self.arrCard) do
        self:OnBorn(v)
    end

    if self.tRandBuff then
        for i,v in ipairs(self.tRandBuff) do
            -- local teamID = v[1]
            -- local count = v[2]
            -- local buffs = v[3]

            local cards = self:GetTeam(v.teamID):GetRandCard(v.count)
            for i,card in ipairs(cards) do
                for i, buffID in ipairs(v.buff) do
                    card:AddBuff(card, buffID)
                end
            end
        end
    end

    self.oFightEventMgr:DoEvent('OnStart')
    self.log:EndSub('datas')

    -- 切换周目事件
    self:DoEventWithLog('OnChangeStage')
end

----------------------------------------------
-- 战斗事件

-- 调用事件(封装好log格式)
function FightMgrBase:DoEventWithLog(event, ...)
    local log = {api = event}
    self.log:Add(log)
    self.log:StartSub('datas')
    self.oFightEventMgr:DoEvent(event, ...)
    self.log:EndSub('datas')
    return log
end

-- 调用事件作为子事件
function FightMgrBase:DoEventWithSub(event, ...)
    self.log:StartSub(event)
    self.oFightEventMgr:DoEvent(event, ...)
    self.log:EndSub(event)
end

-- 调用事件
function FightMgrBase:DoEvent(event, ...)
    self.oFightEventMgr:DoEvent(event, ...)
end
----------------------------------------------
-- 广播消息
function FightMgrBase:Broadcast(cmd, msg)
    ASSERT()
end

function FightMgrBase:Send(uid, cmd, msg)
    ASSERT()
end

-- 恢复战斗
function FightMgrBase:SendRestoreFight(uid, nCmdIndex)
    LogDebugEx('FightMgrBase:SendRestoreFight', uid, nCmdIndex, self.id)
    local nCurrIndex = #self.cmds
    local restart = false
    nCmdIndex = nCmdIndex or 0
    if nCmdIndex == 0 then
        self:Send(
            uid,
            'FightProto:RestoreFightStart',
            {restart = true, type = self.type, nDuplicateID = self.nDuplicateID}
        )
    else
        self:Send(
            uid,
            'FightProto:RestoreFightStart',
            {restart = false, type = self.type, nDuplicateID = self.nDuplicateID}
        )
    end
    if nCmdIndex < nCurrIndex then
        for i = nCmdIndex + 1, nCurrIndex do
            local msg = self.cmds[i]
            ASSERT(msg)
            -- LogTable(msg, "FightProto:SendRestoreFight:")
            self:Send(uid, 'FightProto:RecvCmd', msg)
        end
    elseif nCmdIndex > nCurrIndex then
        -- 错误
        self:Send(uid, 'FightProto:RestoreFightEnd', {err = true})
        return
    end

    LogTable(self.cmds, "FightMgrBase:SendRestoreFight cmds:")

    if nCmdIndex > 0 then
        -- 断线重连, 什么都不用做
        return
    end

    -- 已经是最新的(不需要更新)
    self:Send(uid, 'FightProto:RestoreFightEnd', {err = false})

    -- 同步一下集火设置
    local teamID = self:GetTeamIDByUID(uid)
    -- ASSERT(teamID, "没有找到玩家teamID, uid="..uid)

    local team = self:GetTeam(teamID)

    if team.oFocusFire and team.oFocusFire:IsLive() then
        self:Send(uid, 'FightProto:FocusFire', {nFocusFireID = team.oFocusFire.oid})
    else
        self:Send(uid, 'FightProto:FocusFire', {})
    end
end

-- 玩家断线重连
function FightMgrBase:OnPlayerLogin(uid)
    -- LogTrace("FightMgrBase:OnPlayerLogin:")
    -- if self.type ~= SceneType.Rogue then
    LogDebug("FightMgrBase:OnPlayerLogin(uid:%s), self.type:%s", uid, self.type)
    if self.type ~= SceneType.GlobalBoss then
        self:Send(uid, 'FightProto:InBattle', {type = self.type, nDuplicateID = self.nDuplicateID})
    end
    -- end
end

function FightMgrBase:CheckRelive(caster, data)
    local obj = self:GetCardByOID(data.target.reliveID)
    ASSERT(obj, '找不到复活对象')
    local pos = obj:GetPos() -- 原地复活
    data.target.pos = pos
    -- 如果原来的地方被占了, 无法复活
    local site = self:GetPosCard(caster:GetTeamID(), pos)
    if site and site:IsLive() then
        ASSERT(nil, '复活位置被占用')
        return
    end
    return pos
end

function FightMgrBase:DamageStat(caster, damage)
    --LogDebug(string.format("DamageStat name = %s damage = %s", caster.name, damage))
end

-- 无限血相关接口
-- 无限血机制设置阶段[总阶段数, 阶段, 阶段血量, 操作数]
function FightMgrBase:SetInvincible(effect, caster, target, data, totalState, state, statehp, opnum)

    if not self.isInvincible then return end

    self.nInvStateDamage  = 0 -- 当前阶段伤害量
    self.nInvTotalState   = totalState -- 总阶段
    self.nInvState        = state -- 阶段
    self.nInvStatehp      = statehp -- 阶段血量
    self.nInvOpnum        = opnum -- 操作数
    self.nInvStartopnum   = self:GetCurrStep() --self.nStepPVE or 0 -- 阶段开始时的操作数
end

-- 统计无限血伤害
function FightMgrBase:AddInvincibleDamage(num)
    if not self.isInvincible then return end

    self.nInvStateDamage  = self.nInvStateDamage + num
    self.nInvTotalDamage   = self.nInvTotalDamage + num
end

-- 增加操作数上限
function FightMgrBase:AddStep(num, isHide)
    LogDebugEx("FightMgrBase:AddStep before-----", num, isHide, self.nStepLimit, self.nStepOffset)
    -- LogTrace()
    
    -- pvp以及镜像不生效
    if IsPvpSceneTypeEx(self.type) or self:IsAbattoirFight() then return end

    -- LogDebugEx("AddStep", self.nStepOffset, self.nLimitAddStep)
    if self.nLimitAddStep and self.nLimitAddStep + self.nStepOffset <= 0 then return end


    self.nStepLimit = self.nStepLimit + num
    if not isHide then return end
    self.nStepOffset   = self.nStepOffset - num
    LogDebugEx("FightMgrBase:AddStep after-----", num, isHide, self.nStepLimit, self.nStepOffset)
end

-- 限制增加操作数
function FightMgrBase:LimitAddStep(num)
    self.nLimitAddStep = num
end

function FightMgrBase:IsAbattoirFight()
    local dupCfg = MainLine[self.nDuplicateID]
    if dupCfg and (dupCfg.type == eDuplicateType.AbattoirRand or dupCfg.type == eDuplicateType.AbattoirSelect) then
        return true
    end
    return false
end

-- 获取操作数上限
function FightMgrBase:GetStepLimit()
    return self.nStepLimit+self.nStepOffset
end

-- 当前操作数
function FightMgrBase:GetCurrStep()
    if self:IsPVE() then
        LogDebugEx("GetCurrStep PVE ", self.nStepPVE+self.nStepOffset, self.nStepPVE, self.nStepOffset)
        return self.nStepPVE+self.nStepOffset
    end

    LogDebugEx("GetCurrStep", self.nStep+self.nStepOffset, self.nStep, self.nStepOffset)
    return self.nStep+self.nStepOffset
end

-- 深塔计划实时分数
function FightMgrBase:GetTowerDeepScore()
    if self.type ~= SceneType.TowerDeep then
        return 0
    end

    local dupCfg = self.nDuplicateID and MainLine[self.nDuplicateID]
    if not dupCfg then
        return 0
    end

    local hpinfo = { stage = self.stage, leftHp = 0 }
    local aliveNum = 0

    for _, card in ipairs(self.arrCard or {}) do
        if card and card:IsLive() then
            local mcfg = card.id and MonsterData[card.id] or nil
            if card:GetTeamID() == 2 and mcfg and mcfg.isPoints then
                local hp = math.max(card.hp or 0, 0)
                local maxhp = card.maxhp or 0
                local extraAdd = 0
                if mcfg.tTransfo and #mcfg.tTransfo > 0 and not card.nTransformState and hp > 0 then
                    extraAdd = maxhp
                end
                hpinfo.leftHp = hpinfo.leftHp + hp + extraAdd
            elseif card:GetTeamID() == 1 and card:IsCard() then
                aliveNum = aliveNum + 1
            end
        end
    end

    return GCalHelp:CalcTowerDeepDupScore(0, self.nDuplicateID, aliveNum, self:GetCurrStep(), hpinfo)
end
----------------------------------------------
-- 服务端管理器
FightMgrServer = oo.class(FightMgrBase)
function FightMgrServer:Init(...)
    FightMgrBase.Init(self, ...)
end

-- 切换周目
function FightMgrServer:ChangeStage(stage)
    FightMgrBase.ChangeStage(self, stage)
    self:AfterChangeStage()

    -- 切换周目事件
    self:DoEventWithLog('OnChangeStage')

    self:AddCmd(CMD_TYPE.ChangeStage, {stage = self.stage})
end

-- 执行技能
function FightMgrServer:DoSkill(data)
    LogDebug('客户端释放技能--')
    local caster = self:GetCardByOID(data.casterID)
    if caster ~= self.currTurn then
        if not self.currTurn then
            ASSERT(nil, "DoSkill:"..table.tostring(data))
        end
        LogDebugEx(
            '当前发命令者:' .. caster.name .. '_' .. caster:GetTeamID(),
            '当前轮到:' .. self.currTurn.name .. '_' .. caster:GetTeamID()
        )
        if not self.isSaveLog and IS_SERVER then  -- 这里可能是单机战斗
            self:ClientError(self.uid or caster.uid or "", "数据不一致")
        end
        self.isSaveLog = true
        ASSERT(nil, '数据不一致')
    end
    local target
    local pos
    -- 此处不一定是选中的是一个对象, 可能是一个空格子,  需要根据技能再筛选出受技能的对象
    if data.target then
        pos = data.target.pos
        if data.target.reliveID then
            pos = self:CheckRelive(caster, data)
        else
            target = caster:GetSkillRange(data.skillID, data.target)
        end
    end
    LogTable(target, 'Attack target')
    local ret = self:Attack(caster, target, data, pos or data.pos)
    if not ret then
        return
    end

    self.waitForDoSkill = nil

    self:AddCmd(CMD_TYPE.Skill, data)
    local config = skill[data.skillID]
    local action_time = 0
    if config then
        action_time = (config.action_time / 1000)
    else
        action_time = 4
    end
    self:Wait(action_time)
    return caster
end

-- 执行指挥官技能
function FightMgrServer:DoCommanderSkill(data)
    LogDebug('执行指挥官技能--')

    if not self.currTurn then
        return
    end
    -- if not self.waitForDoSkill or self.waitForDoSkill ~= self.currTurn.oid then return end

    -- 不是轮到自己就不要发
    if data.uid ~= self.currTurn.uid then
        -- LogDebugEx(" data.uid ~= self.currTurn.uid", data.uid, self.currTurn.uid)
        ASSERT()
        return
    end
    local oTeam = self:GetTeam(self.currTurn:GetTeamID())

    local caster = oTeam.oCommander
    -- ASSERT(caster)
    if not caster then
        return
    end

    local target
    local pos
    -- 此处不一定是选中的是一个对象, 可能是一个空格子,  需要根据技能再筛选出受技能的对象
    if data.target then
        pos = data.target.pos
        if data.target.reliveID then
            pos = self:CheckRelive(caster, data)
        else
            target = caster:GetSkillRange(data.skillID, data.target)
        end
    else
        ASSERT()
    end
    LogTable(target, 'Attack target')
    local ret = self:Attack(caster, target, data, pos or data.pos)
    if not ret then
        return
    end

    data.teamID = oTeam.teamID
    self:AddCmd(CMD_TYPE.Commander, data)
    return caster
end

-- OverLoad
function FightMgrServer:OverLoad(data)
    LogDebug('客户端释放OverLoad技能--')
    LogTable(data)
    self.overLoadData = self.overLoadData or {}
    if --[[not self.overLoadData.state and]] data.state == 1 then
        --准备
        self:AddCmd(CMD_TYPE.OverLoad, data)
        self.overLoadData.state = 1
    elseif self.overLoadData.state and self.overLoadData.state == 1 and data.state == 2 then
        -- 正式放技能
        local waitTime = FightMgrBase.OverLoad(self, data)
        if not waitTime then
            return
        end
        self:AddCmd(CMD_TYPE.OverLoad, data)
        -- LogDebugEx("waitTime = ", waitTime)
        self:Wait(waitTime)
        self.overLoadData = nil
        local teamID = self.currTurn:GetTeamID()
        self.currTurn:AddSP(-g_overLoadCost)
        if self.oDuplicate then
            self.oDuplicate:OverLoad({ self.currTurn.cuid })
        end
        return waitTime
    else
        ASSERT()
    end
end

function FightMgrServer:OnRoundOver()
    local currTurn = self.currTurn

    if FightMgrBase.OnRoundOver(self) then
        -- currTurn.bufferMgr:OnUpdateBuffer()
        self:DoEventWithLog('OnRoundOver', currTurn)
        self:DoDeathEvent()
        -- self.currTurn:ResetTempAttr()
        self:PrintCardInfo('FightMgrServer:DoTurn---')
        LogDebug('##############玩家行动结束#################' .. currTurn.name)
        self.currTurn = nil
        -- LogTrace()
        self:ResetTempSign()

    -- FightMgrBase.AfterRoundOver(self)
    end
end

function FightMgrServer:Destroy()
    LogDebug('FightMgrServer:Destroy')
    FightMgrBase.Destroy(self)
end

----------------------------------------------
-- 客户端管理器
FightMgrClient = oo.class(FightMgrBase)
function FightMgrClient:Init(...)
    FightMgrBase.Init(self, ...)
    self.startTime = os.time()
    self.tDamageStat = {{}, {}} -- 伤害统计
end

function FightMgrClient:AddCard(card)
    FightMgrBase.AddCard(self, card)
    if _G.debug_model then
        card.name = card.name .. '[' .. card.oid .. ']'
    end
end

function FightMgrClient:DamageStat(caster, damage)
    LogDebug(string.format('DamageStat name = %s damage = %s', caster.name, damage))
    local teamID = caster:GetTeamID()
    --LogDebugEx(teamID, caster.oid, damage)
    self.tDamageStat[teamID][caster.oid] = self.tDamageStat[teamID][caster.oid] or 0
    self.tDamageStat[teamID][caster.oid] = self.tDamageStat[teamID][caster.oid] + damage
    --LogTable(self.tDamageStat)
end

-- g_FightMgr:GetMvp(teamID)
function FightMgrClient:GetMvp(teamID)
    local score = 0
    local oid = nil
    --LogTable(self.tDamageStat, "self.tDamageStat =")
    for k, v in pairs(self.tDamageStat[teamID]) do
        if v >= score then
            oid = k
            score = v
        end
    end

    local mvp = self:GetCardByOID(oid)
    if not mvp or not mvp:IsLive() then
        for k, v in pairs(self.arrCard) do
            if v:GetTeamID() == teamID and v:IsLive() then
                mvp = v
            end
        end
    end
    if not mvp then
        return
    end
    return mvp:GetClientData()
end

function FightMgrClient:ClientSend(proto)
    return ClientSend(proto)
end

function FightMgrClient:GetInitData()
    local fightActionData = {}

    for i, v in ipairs(self.arrCard) do
        if v:IsLive() then
            local data = v:GetShowData()
            table.insert(fightActionData, data)
        end
    end
    -- LogTable(fightAction.datas)
    --fightActionData.api = "AddCard";

    return {{api = 'AddCard', data = fightActionData}}
end

function FightMgrClient:AddCmd(cmd, data)
    -- if self.isStart then return end
    -- if cmd == CMD_TYPE.Start then
    -- 	return
    -- end

    local index = #self.cmds
    -- cmd = {帧数, 命令类型, 命令参数, 时间}
    local cmddatakey = 'data' .. cmd
    local cmddata = {}
    cmddata[cmddatakey] = data
    local msg = {index + 1, cmd, cmddata, os.time() - self.startTime}

    table.insert(self.cmds, msg)
    LogTable(msg, 'FightMgrClient:AddCmd: ')
    -- LogTrace()
    -- LogDebug("FightMgrBase:AddCmd: " .. Json.Encode(msg))

    return #self.cmds
end

function FightMgrClient:RecvCmd(cmd)
    if self.isOver then
        return
    end
    DebugLog('收到命令：', 'ff9977')
    LogDebug('ff9977 cmd =[%s]', cmd)
    local ret = FightMgrBase.RecvCmd(self, cmd)
    if not ret then
        -- LogDebugEx("FightMgrClient:RecvCmd", cmd[1])
        -- ASSERT()
        return
    end

    local ty = cmd[2]
    local data = cmd[3]
    self:AddCmd(ty, data)
    return true
end

-- 执行技能
function FightMgrClient:DoSkill(data)
    LogDebug('FightMgrClient:DoSkill')
    local caster = self:GetCardByOID(data.casterID)
    caster.isDoSkill = true
    local target, pos
    -- 此处不一定是选中的是一个对象, 可能是一个空格子或死亡对象或非战斗对象,  需要根据技能再筛选出受技能的对象
    if data.target then
        pos = data.target.pos
        if data.target.reliveID then
            pos = self:CheckRelive(caster, data)
        else
            target = caster:GetSkillRange(data.skillID, data.target)
        end
    elseif data.targetIDs then
        target = data.targetIDs
    end

    LogTable(target, 'Attack target')
    local ret = self:Attack(caster, target, data, pos or data.pos)
    if not ret then
        return
    end

    self.waitForDoSkill = nil
    FightActionMgr:PushSkill(self.log:GetAndClean())
end

-- 执行指挥官技能
function FightMgrClient:DoCommanderSkill(data)
    LogDebug('FightMgrClient:DoCommanderSkill')

    --LogTable(data)
    local oTeam = self:GetTeam(data.teamID)
    local caster = oTeam.oCommander
    if not caster then
        return
    end

    local target, pos
    -- 此处不一定是选中的是一个对象, 可能是一个空格子或死亡对象或非战斗对象,  需要根据技能再筛选出受技能的对象
    if data.target then
        pos = data.target.pos
        if data.target.reliveID then
            pos = self:CheckRelive(caster, data)
        else
            target = caster:GetSkillRange(data.skillID, data.target)
        end
    elseif data.targetIDs then
        target = data.targetIDs
    end
    LogTable(target, 'Attack target')
    local ret = self:Attack(caster, target, data, pos or data.pos)
    if not ret then
        return
    end

    FightActionMgr:PushSkill(self.log:GetAndClean())

    -- 再发一次OnTurn
    local card = self.currTurn
    local log = {api = 'OnTurn', turnNum = self:GetCurrStep(), nStepLimit = self:GetStepLimit(), isMotionless = isMotionless}

    -- if self:IsPVE() then
    --     if self.currTurn:GetTeamID() == 1 then
    --         log.turnNum = self.nStepPVE
    --     else
    --         log.turnNum = self.nStepPVE
    --     end
    -- end

    self.log:Add(log)
    self.log:StartSub('datas')
    -- card:OnTurn(isMotionless)
    self:UpdateProgress(nil, card, false)
    self.log:EndSub('datas')

    -- 显示
    log.id = card.oid
    log.skillDatas = card.skillMgr:GetClientSkillInfo()
    log.canOverLoad = card.skillMgr:CanOverLoad()
    log.tCommanderSkill = self:GetCommanderSkill(card) -- 指挥官技能

    FightActionMgr:PushSkill(self.log:GetAndClean())

    -- card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
end

-- OverLoad
function FightMgrClient:OverLoad(data)
    LogDebugEx('FightMgrClient:OverLoad', self.currTurn.oid)
    self.overLoadData = self.overLoadData or {}
    if --[[not self.overLoadData.state and]] data.state == 1 then
        self.overLoadData.state = 1
        FightActionMgr:PushSkill({{api = 'OverLoad', id = self.currTurn.oid}})
    elseif self.overLoadData.state and self.overLoadData.state == 1 and data.state == 2 then
        FightActionMgr:PushSkill({{api = 'OverLoad', id = self.currTurn.oid, flag = 1}})
        local waitTime = FightMgrBase.OverLoad(self, data)
        if not waitTime then
            ASSERT()
            return
        end
        self.overLoadData = nil
        FightActionMgr:PushSkill(self.log:GetAndClean())
        self.currTurn:AddSP(-g_overLoadCost)
        if self.oDuplicate then
            self.oDuplicate:OverLoad({ self.currTurn.cuid })
        end
        FightActionMgr:PushSkill({{api = 'OverLoad', id = self.currTurn.oid, flag = 2}})
    else
        ASSERT()
    end

    -- FightActionMgr:PushSkill(self.log:GetAndClean())
end

function FightMgrClient:SendCmd(cmd, data)
    -- if not self.isStart then return end
    if self.isOver then
        return
    end
    self.SendCount = self.SendCount or {} --- 用来保存已发送的id

    local index = #self.cmds + 1
    local cmddata = {}
    cmddata['data' .. cmd] = data
    local proto = {'FightProtocol:RecvCmd', {index, cmd, cmddata}}
    DebugLog('发送命令：', 'ff9977')
    LogTable(proto, 'SendCmd')
    --LogTrace()
    --LogDebugEx("-----------", cmd , CMD_TYPE.Start)
    if self.SendCount[index] and cmd ~= CMD_TYPE.Start then
        -- 测试说,快速多次点击出现, 出现这个可能是响应慢(网络卡或服务器卡)
        -- 协议有可能因为网络问题真没发出去, 所以还是要发送
        --LogTable(self.SendCount[index], "之前的协议")
        self:ClientSend(self.SendCount[index])
        --ASSERT(nil, "重复发送同一个协议, 前端检查一下")
        --改成警告
        LogWarning(
            string.format('重复发送同一个协议, 前端检查一下，之前的%s，现在的%s', table.tostring(self.SendCount[index]), table.tostring(proto))
        )
        return
    end

    if cmd ~= CMD_TYPE.Start then
        self.SendCount[index] = proto
    end

    -- NetMgr.netFight:Send(proto)
    -- NetMgr.net:Send(proto)
    self:ClientSend(proto)
end

function FightMgrClient:SendAuto()
    if self.isOver then
        return
    end
    if not self.currTurn or self.currTurn.uid ~= PlayerClient:GetID() then
        return
    end

    local proto = {'FightProtocol:AutoFight', {id = self.currTurn.oid}}
    self:ClientSend(proto)
    return true
end

function FightMgrClient:SetFocusFire(id)
    if self.isOver then
        return
    end
    local proto = {'FightProtocol:SetFocusFire', {nFocusFireID = id}}
    -- NetMgr.net:Send(proto)
    self:ClientSend(proto)
end

-- -- 设置集火对象
-- function FightMgrClient:OnSetFocusFire(uid, nFocusFireID)
-- 	-- if self.isOver then return end
-- 	LogDebugEx("FightMgrClient:OnSetFocusFire", uid)

-- 	local teamID = self:GetTeamIDByUID(uid)
-- 	local team = self:GetTeam(teamID)
-- 	if nFocusFireID then
-- 		local card = self:GetCardByOID(nFocusFireID)
-- 		-- if not card or not team then ASSERT(nil, "not card or not team") end
-- 		if card and card:IsLive() then
-- 			team.oFocusFire = card
-- 		else
-- 			team.oFocusFire = nil
-- 		end
-- 	else
-- 		team.oFocusFire = nil
-- 	end
-- end

-- function FightMgrClient:SetSkillAI(id, isUseCommon)
-- 	if self.isOver then return end
-- 	local proto = {"FightProtocol:SetSkillAI", {id = id, isUseCommon = isUseCommon}}
-- 	self:ClientSend(proto)
-- end

function FightMgrClient:Quit()
    if self.isOver then
        return
    end
    local proto = {'FightProtocol:Quit', {}}
    self:ClientSend(proto)
end

function FightMgrClient:SendRestoreFight()
    if self.isOver then
        return
    end
    local proto = {'FightProtocol:RestoreFight', {nCmdIndex = #self.cmds}}
    self:ClientSend(proto)
end

function FightMgrClient:CountdownBegins()
    if self.isOver then
        return
    end
    local proto = {'FightProtocol:CountdownBegins', {}}
    self:ClientSend(proto)
end

function FightMgrClient:SetTrusteeship(bTrusteeship)
    if self.isOver then
        return
    end
    -- if bTrusteeship and  bTrusteeship == true then
    local proto = {'FightProtocol:SetTrusteeship', {bTrusteeship = bTrusteeship}}
    self:ClientSend(proto)
    -- end
end

-- 执行角色切换
function FightMgrClient:DoTurn(data)
    --LogTrace()
    LogDebug('CMD_TYPE.Turn ---------' .. data.id)
    FightActionMgr:PushSkill(self.log:GetAndClean())

    self:OnRoundOver()
    if self.isOver then
        return
    end

    self:PrintCardInfo('FightMgrClient:DoTurn---')

    local card = self:GetCardByOID(data.id)
    ASSERT(card, '数据不一致')
    local t, card2 = self:CalcNext()
    ASSERT(card2, '数据不一致')

    LogDebugEx(card.name .. '\t' .. card2.name)
    LogDebugEx(card.oid .. '\t' .. card2.oid)

    if card == card2 then
        -- card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
        self:AddAllTime(t, card)
        self.turnNum = self.turnNum + 1
        self.currTurn = card
        self.waitForDoSkill = card.oid

        self:AddCmd(CMD_TYPE.Turn, {id = card.oid})

        local str = '第' .. self.turnNum .. '回合;操作数'..(self.nStep+self.nStepOffset)..'\n'
        self:PrintCardInfo(str)

        card.tmpPrintLog = {}
        table.insert(card.tmpPrintLog, '第' .. self.turnNum .. '回合')
        LogTable(card.tmpPrintLog)

        LogDebug('##############玩家行动#################' .. card.name)
        self:ResetSkillSign()
        -- 处理buffer行动前
        local log = {api = 'OnRoundBegin'}
        self.log:Add(log)
        self.log:StartSub('datas')
        self.oFightEventMgr:DoEvent('OnRoundBegin', card)
        self.oFightEventMgr:DoEvent('OnAfterRoundBegin', card)
        self.log:EndSub('datas')

        -- self:DoEventWithLog("OnRoundBegin", card)

        FightActionMgr:PushSkill(self.log:GetAndClean())
        if not card:IsLive() then
            -- 已经死亡
            LogDebugEx('card is death', card.name)
            self:UpdateProgress(nil, card, false)
            -- self.isRoundOver = true
            -- card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
            return
        end

        -- 可能敌方都死光了
        if self:CheckOver() then
            return
        elseif self.needChangeStage then
            -- 需要切换周目
            LogDebugEx("self.needChangeStage", self.needChangeStage)
            -- return
        end

        -- 控制类buffer处理
        local isMotionless = card.bufferMgr:IsMotionless() or self.needChangeStage
        LogDebugEx('============isMotionless===============', isMotionless, type(isMotionless), card:IsMotionless(), self.needChangeStage)
        if isMotionless then
            LogDebug('-------此处无法行动-------' .. card.name)
            card.bufferMgr:OnUpdateBuffer()
        --无法行动要处理buff回合-1
        end

        --LogTrace()
        --LogDebug("CMD_TYPE.Turn 2 ---------" .. self.nStep)

        local log = {
            api = 'OnTurn',
            turnNum = self:GetCurrStep(),
            nStepLimit = self:GetStepLimit(),
            isMotionless = isMotionless
        }

        -- if self:IsPVE() then
        --     if self.currTurn:GetTeamID() == 1 then
        --         log.turnNum = self.nStepPVE
        --     else
        --         log.turnNum = self.nStepPVE
        --     end
        -- end

        self.log:Add(log)
        self.log:StartSub('datas')
        card:OnTurn(isMotionless)
        self:UpdateProgress(nil, card, false)
        self.log:EndSub('datas')

        -- 显示
        log.id = card.oid
        local ty = card:GetType()
        if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Mirror and ty ~= CardType.WorldBoss then
            log.skillDatas = card.skillMgr:GetClientSkillInfo()
            log.canOverLoad = card.skillMgr:CanOverLoad()

            -- 指挥官技能
            log.tCommanderSkill = self:GetCommanderSkill(card)
        end
        FightActionMgr:PushSkill(self.log:GetAndClean())
    else
        --		LogError("数据不一致")
        --		LogDebug("card ~= card2")
        --		LogDebugEx(card.name .. "\t" .. card2.name)

        local errContent = ''
        if (card and card2) then
            errContent = string.format('数据不一致,card:%s ~= card2:%s', tostring(card.name), tostring(card2.name))
        else
            errContent = string.format('数据不一致%s%s', card and '' or ',card is nil', card2 and '' or ',card2 is nil')
        end

        local proto = {'FightProtocol:ClientError', {errContent = errContent}}
        self:ClientSend(proto)

        LogError(errContent)
        EventMgr.Dispatch(EventType.Fight_Error_Msg, errContent)
        ASSERT('card ~= card2')
    end
end

-- 战斗结束
function FightMgrClient:DoEnd(data)
    -- 销毁战斗逻辑管理器
    -- g_FightMgr = nil
    if self.isOver then
        return
    end
    self:OnRoundOver()
end

-- 切换周目
function FightMgrClient:ChangeStage(stage)
    FightMgrBase.ChangeStage(self, stage)

    FightActionMgr:PushSkill(self.log:GetAndClean())

    local list = self.arrTeam[2].arrCard
    local datas = {}


    self:PrintCardInfo("FightMgrClient:ChangeStage")

    for i, v in ipairs(list) do
        local data = v:GetShowData()
        table.insert(datas, data)
    end

    LogTable(datas, "FightMgrClient:ChangeStage"..self.stage)
    FightActionMgr:PushSkill({{api = 'ChangeStage', round = self.stage, datas = datas, bgm = self:GetBgm()}})
    Log('--切换周目'..self.stage..'-----------------------------------------------------------------', 'ffff00')

    FightActionMgr:PushSkill(self.log:GetAndClean())
    self:AfterChangeStage()
    FightActionMgr:PushSkill(self.log:GetAndClean())

    -- 切换周目事件
    self:DoEventWithLog('OnChangeStage')

    self:UpdateProgress(nil, self.currTurn)
end

-- 更新进度条
function FightMgrClient:UpdateProgress(data, showNest, isGreen)
    data = data or self:GetProgress(showNest)
    self.log:Add({api = 'UpdateProgress', datas = data})
end

function FightMgrClient:OnStart(data)
    if self.isStart then
        return
    end
    FightMgrBase.OnStart(self, data)
    -- LogDebugEx("g_bRestartFight :%s", g_bRestartFight)
    if not g_bRestartFight then
        -- 不是恢复现场就调用
        FightClient:ApplyServerStart()
    end
end

function FightMgrClient:SyncFight(data)
    local str = ''
    local err = false

    for i, v in ipairs(self.arrCard) do
        local oid = v.oid
        local syncData = data[oid]
        if syncData then
            if syncData.hp ~= v.hp or syncData.progress ~= v.progress then
                LogTable(syncData, 'syncData = ')
                LogTable({oid = v.oid, id = v.id, hp = v.hp, progress = v.progress, name = v.name}, 'client data = ')
                ASSERT()
            end
        else
            local str =
                i ..
                '\toid[' ..
                    oid ..
                        ']\t' ..
                            v.name ..
                                '\thp[' ..
                                    v.hp .. ']\tspeed[' .. v:Get('speed') .. ']\tprogress[' .. v.progress .. ']\n'
            ASSERT(nil, str)
        end
    end
end

function FightMgrClient:OnRoundOver()
    local currTurn = self.currTurn
    -- LogTrace()

    -- 处理回合开始就弄死对面切换周目 前端无法结束--------
    if currTurn and not currTurn.isDoSkill then
        -- ASSERT(nil , "客户端还没有输入")
        LogDebugEx("客户端还没有输入")
        FightActionMgr:PushSkill({api = 'skip',targetID = currTurn.oid})
    end
    for i, v in ipairs(self.arrCard) do
        v.isDoSkill = nil  -- 是否执行过技能
    end
    -- 处理结束----------------


    if FightMgrBase.OnRoundOver(self) then
        local log = {api = 'OnRoundOver'}
        self.log:Add(log)
        self.log:StartSub('datas')
        -- currTurn.bufferMgr:OnUpdateBuffer()
        self:DoEvent('OnRoundOver', currTurn)
        self.log:EndSub('datas')
        self:DoDeathEvent()
        -- currTurn:ResetTempAttr()
        FightActionMgr:PushSkill(self.log:GetAndClean())
        LogDebug('##############玩家行动结束#################' .. currTurn.name)
        self.currTurn = nil
        self:ResetTempSign()
    -- FightMgrBase.AfterRoundOver(self)
    end
end

function FightMgrClient:RestoreFight()
    LogDebugEx('FightMgrClient:RestoreFight()')
    -- ASSERT()
    -- 加入卡牌
    --local fightActionData = {scene = config.scene, gridDatas = gridDatas, myTeamID = data.teamID, totleState = g_FightMgr.totleState};
    self.tClientInitData.api = 'InitData'
    FightActionMgr:PushSkill({self.tClientInitData})

    local fightActionData = self:GetInitData() -- 需要处理(变身,合体的情况)的状态
    LogTable(fightActionData, 'fightActionData')

    FightActionMgr:PushSkill(fightActionData)

    FightClient:ApplyFightStart()
    FightClient:SetRestoreState(true) --本场战斗为恢复状态

    for i, card in ipairs(self.arrCard) do
        -- 加入buff
        local bufferMgr = card.bufferMgr
        bufferMgr:Restore()
        -- 技能
        local skillMgr = card.skillMgr
        skillMgr:Restore()
    end

    -- np
    for teamID = 1, 2 do
        self.log:Add(
            {
                api = 'AddNp',
                teamID = teamID,
                attr = 'np',
                np = self.arrNP[teamID],
                add = self.arrNP[teamID],
                max = g_CostMax,
                effectID = effectID
            }
        )
    end

    if self.isInvincible then
        local mgr = self
        self.log:Add({api="SetInvincible", --[[targetID = target.oid, ]]
            totalState = mgr.nInvTotalState, state = mgr.nInvState, statehp = mgr.nInvStatehp, opnum = mgr.nInvOpnum,
            nStateDamage = mgr.nInvStateDamage, nTotalDamage = mgr.nInvTotalDamage, startopnum = mgr.nInvStartopnum, type= mgr.isInvincible})

    end

    FightActionMgr:PushSkill(self.log:GetAndClean())

    -- 跑条+当前轮到
    -- ASSERT()
    local card = self.currTurn
    if not card then
        return
    end

    -- 控制类buffer处理
    local isMotionless = card.bufferMgr:IsMotionless()

    local log = {api = 'OnTurn', turnNum = self:GetCurrStep(), nStepLimit = self:GetStepLimit(), isMotionless = isMotionless}
    -- if self:IsPVE() then
    --     if self.currTurn:GetTeamID() == 1 then
    --         log.turnNum = self.nStepPVE
    --     else
    --         log.turnNum = self.nStepPVE
    --     end
    -- end

    self.log:Add(log)
    self.log:StartSub('datas')
    self:UpdateProgress(nil, card, false)
    self.log:EndSub('datas')

    -- 显示
    log.id = card.oid
    local ty = card:GetType()
    if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Mirror and ty ~= CardType.WorldBoss then
        log.skillDatas = card.skillMgr:GetClientSkillInfo()
        log.canOverLoad = card.skillMgr:CanOverLoad()

        -- 指挥官技能
        log.tCommanderSkill = self:GetCommanderSkill(card)
    end
    FightActionMgr:PushSkill(self.log:GetAndClean())
end




-- 还原一个角色的数据
function FightMgrClient:RestoreObjBuffer(oid)
    local card = self:GetCardByOID(oid)
    local datas = {}

    -- 加入buff
    local bufferMgr = card.bufferMgr
    for i, buffer in ipairs(bufferMgr.list) do
        local log = {
            api = 'AddBuff',
            uuid = buffer.uuid,
            round = buffer.round,
            id = buffer.creater.oid,
            targetID = buffer.owner.oid,
            bufferID = buffer.id,
            shield = buffer.shield,
            nShieldCount = buffer.nPhysicsShield,
            sneer = buffer.sneer,
            silence = buffer.silence,
            nCount = buffer.nCount
        }

        table.insert(datas, log)
    end

    -- 技能
    local skillMgr = card.skillMgr
    -- LogTable(skillMgr.tRestoreLog, "skillMgr.tRestoreLog = ")
    if skillMgr.tRestoreLog then
        for i, tlog in ipairs(skillMgr.tRestoreLog) do
            table.insert(datas, tlog)
        end
    end
    LogTable(datas, 'RestoreObjBuffer = ')

    return datas
end

local clientShowAttr = {
    'name',
    'attack',
    'maxhp',
    'defense',
    'speed',
    'crit_rate',
    'crit',
    'hit',
    'resist',
    'bedamage',
    'damage',
    'becure',
    'cure',
    'suck',
    'damagePhysics',
    'damageLight',
    'careerAdjust',
    'skills',
    'eskills',
    'tTransfoSkills',
    'career',
    'use_sub_talent'
}

function FightMgrClient:ClientPrintCardInfo(id, bt)
    local card = self:GetCardByOID(id)
    if not card then
        return
    end
    self:PrintCardInfo(bt)
    LogDebugEx('-------卡牌常规属性----------------', id)
    -- 打印属性

    local tAttr = {}
    for i, v in ipairs(clientShowAttr) do
        tAttr[v] = card:Get(v)
    end
    tAttr.energy = card:GetValue('energy') or 0
    tAttr.skills = card.skillMgr.list -- 变身之后技能会改变，以skillMgr中的数据为准
    LogTable(tAttr, '卡牌常规属性')

    -- 战斗日志
    -- card
    LogTable(card.tmpPrintLog, '战斗日志')

    local txt = CSAPI.LoadStringByFile('FightLog.txt')
    LogDebugEx(txt)
    local log = table.Decode(txt or '') or {}
    for i, v in ipairs(log) do
        LogTable(v, '战斗日志_' .. i)
    end
end

-- 客户端获取卡牌属性
function FightMgrClient:GetCharData(oid)
    local card = self:GetCardByOID(oid)
    if not card then
        return
    end

    local tAttr = {}
    tAttr.cfgid = card.id -- 卡牌配置id
    tAttr.cid = card.cuid -- 卡牌id
    tAttr.uid = card.uid -- 用户id
    tAttr.fuid = card.fuid -- 好友id
    tAttr.isNpc = card.isNpc -- 是否npc
    tAttr.nStrategyIndex = card.nStrategyIndex -- ai方案ai策略
    tAttr.isMonster = card.isMonster -- 是否从怪物表读取数据

    tAttr.nIndex = card.nIndex -- 卡牌在队伍中的排序,前端用的属性(后端无用, 在Team:LoadData赋值)

    for i, v in ipairs(clientShowAttr) do
        tAttr[v] = card:Get(v)
    end

    tAttr.skills = card.skillMgr.list -- 变身之后技能会改变，以skillMgr中的数据为准

    -- LogTable(tAttr, "卡牌常规属性")
    -- ASSERT()
    return tAttr
end

function FightMgrClient:GetDeathObj(teamID)
    local data = {}
    for i, card in ipairs(self.arrCard) do
        if not card:IsLive() and card:GetTeamID() == teamID and not card.isRemove then
            local tAttr = {}
            tAttr.oid = card.oid -- oid
            tAttr.uid = card.uid -- 用户id
            tAttr.cfgid = card.id -- 卡牌配置id
            tAttr.cid = card.cuid -- 卡牌id
            tAttr.fuid = card.fuid -- 好友id
            tAttr.grids = card.grids -- 占格
            table.insert(data, tAttr)
        end
    end
    return data
end
------------------------------------------------------------------
-- PVE
PVEFightMgrServer = oo.class(FightMgrServer)
function PVEFightMgrServer:Init(...)
    FightMgrServer.Init(self, ...)
    self.nStepPVE = 0 -- PVE 我方操作次数
end

-- 广播消息
function PVEFightMgrServer:Broadcast(cmd, msg)
    if YC_Test then
        if self.bYC then
            return
        end
    end
    self.oDuplicate.oPlayer:Send(cmd, msg)
end

function PVEFightMgrServer:Send(uid, cmd, msg)
    if YC_Test then
        if self.bYC then
            return
        end
    end
    self.oDuplicate.oPlayer:Send(cmd, msg)
end

function PVEFightMgrServer:OnStart(data)
    if self.isStart then
        return
    end
    self:AddCmd(CMD_TYPE.Start, {})
    FightMgrBase.OnStart(self, data)
end

function PVEFightMgrServer:OnDeath(card, killer)
    FightMgrBase.OnDeath(self, card, killer)

    -- nDuplicateID 100以内为预留活动战斗
    if self.nDuplicateID > 100 and card:GetTeamID() == 2 then
        self.oDuplicate.oPlayer:UpdateTask(eTaskFinishType.Fight, eTaskEventType.KillMonster, {self.oDuplicate, 1})
        self.oDuplicate:UpdateStat(self.nDuplicateID, eDuplicateStarType.Monster, 1)
    end
end

-- 结束
function PVEFightMgrServer:Over(stage, winer)
    local dupCfg = MainLine[self.nDuplicateID]
    LogDebug('PVEFightMgrServer:Over, dupCfg.type:%s', dupCfg.type)

    -- LogTrace()
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
    FightMgrBase.Over(self, stage, winer)

    LogDebugEx('PVEFightMgrServer:Over', self.type, self.nDuplicateID, winer)

    -- LogTable(self, "PVEFightMgrServer:")

    local cardIds = {}
    if self.oDuplicate then
        local data = {}
        local exData = {}
        -- local arrSp = {}
        local deathcount = 0
        local grade = {0, 0, 0} -- 评级
        local hpinfo = nil
        local nMinHpPercent = 1
        local fCard = nil
        local npcCard = nil
        local summonLiveCnt = 0
        if winer == 1 then
            grade[1] = 1
            for i, v in ipairs(self.arrCard) do
                -- LogTable(v, "PVEFightMgrServer:Over() arrCard:")
                --LogDebugEx("card11---", v.name, v.hp, v.maxhp, v:GetTeamID(), v:IsCard(), v:IsLive())
                -- 合体, 召唤
                if v:GetTeamID() == 1 and v:IsCard() then
                    --LogDebugEx("card22---", v.name, v.hp, v.maxhp)
                    if v.fuid then
                        -- arrSp[0] = v.sp
                        data[0] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
                        fCard = {}
                        fCard.data = {index = 6, col = v.col, row = v.row, cid = v.real_cid, nStrategyIndex = v.nStrategyIndex}
                        fCard.fuid = v.fuid                      
                    elseif v.npcid then
                        -- arrSp[v.npcid] = v.sp
                        data[v.npcid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
                        npcCard = {}
                        npcCard.data = {index = 6, col = v.col, row = v.row, cid = v.card_id, nStrategyIndex = v.nStrategyIndex,bIsNpc = true}
                        npcCard.npcid = v.npcid
                    else
                        -- arrSp[v.cuid] = v.sp
                        data[v.cuid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}                      
                    end

                    if nMinHpPercent > v.hp / v.maxhp then
                        nMinHpPercent = v.hp / v.maxhp
                    end
                    if math.floor(v.hp) <= 0 then
                        deathcount = deathcount + 1
                        nMinHpPercent = 0
                    end

                    table.insert(cardIds, v.id)
                elseif v:GetTeamID() == 1 and v:GetType() == CardType.Summon then
                    -- 这个是机神
                    --LogTable(v,"这个是机神")
                    if math.floor(v.hp) > 0 then
                        summonLiveCnt = summonLiveCnt + 1
                    end
                end

                -- nNp = self.arrNP[1]
            end

            if deathcount == 0 then
                grade[2] = 1
            end

            if self:GetCurrStep() <= g_FightGradeStep then
                grade[3] = 1
            end
        else
            nMinHpPercent = 0
            -- 失败了要保存怪物血量
            local data = {}
            local maxConfigIndex = 0
            for i, v in ipairs(self.arrCard) do
                -- 合体, 召唤
                if v:GetTeamID() == 2 then
                    if v.configIndex then
                        data[v.configIndex] = v.hp
                        if v.configIndex > maxConfigIndex then
                            maxConfigIndex = v.configIndex
                        end
                        if self.type == SceneType.RogueMap then
                            exData.bossMaxHp = (exData.bossMaxHp or 0) + v.maxhp
                            if v.hp > 0 then
                                exData.bossCurHp = (exData.bossCurHp or 0) + v.hp
                            end
                            LogDebugEx(string.format("SceneType.RogueMap name:%s maxhp:%s hp:%s",v.name, v.maxhp, v.hp))
                        end
                    end
                elseif v:GetTeamID() == 1 and v:IsCard() and v.fuid then
                    fCard = {}
                    fCard.data = {index = 6,col = v.col,row = v.row,cid = v.real_cid,nStrategyIndex = v.nStrategyIndex}
                    fCard.fuid = v.fuid
                elseif v:GetTeamID() == 1 and v:IsCard() and v.npcid and self.type == SceneType.ChainFront then
                    npcCard = {}
                    npcCard.data = {index = 6, col = v.col, row = v.row, cid = v.card_id, nStrategyIndex = v.nStrategyIndex,bIsNpc = true}
                    npcCard.npcid = v.npcid
                end
            end
            -- data 需要是连续数组，避免协议 array 编码读取到 nil
            for idx = 1, maxConfigIndex do
                if data[idx] == nil then
                    data[idx] = 0
                end
            end
            hpinfo = {stage = self.stage, data = data}
        end

        -- 历战挑战关（BuffBattle）按连锁规则统计怪物剩余血量
        local isTrialBuffBattle = SceneType.BuffBattle == self.type and self.oDuplicate and self.oDuplicate.IsTrialChallengeDup and self.oDuplicate:IsTrialChallengeDup()
        if self.type == SceneType.TowerDeep or self.type == SceneType.ChainFront or isTrialBuffBattle then
            for i, v in ipairs(self.arrCard) do
                if v:GetTeamID() == 2 then
                    if v.configIndex then
                        exData.validMstHpInfo = exData.validMstHpInfo or {stage = self.stage,leftHp = 0}
                        local tHp = exData.validMstHpInfo.leftHp or 0
                        local isCalc = (self.type == SceneType.TowerDeep and v.isPoints) or ((self.type == SceneType.ChainFront or isTrialBuffBattle) and v.isChainPoints)
                        if isCalc then
                            local extraAdd = 0
                            if self.type == SceneType.TowerDeep and (not v.nTransformState) and v.hp > 0 and (v.tTransfo and #v.tTransfo > 0) then
                                extraAdd = v.maxhp
                            end
                            tHp = tHp + math.max(v.hp or 0, 0) + extraAdd
                            exData.validMstHpInfo.leftHp = tHp
                        end
                    end
                end
            end
            -- exData.stepLimit = self.nStepLimit
        end

        if self.type == SceneType.ChainFront then
            local roundLevel = (dupCfg and dupCfg.roundLevel) or self.oDuplicate.nRound or 1
            self.oDuplicate.assistCardList = self.oDuplicate.assistCardList or {}
            self.oDuplicate.assistCardList[roundLevel] = table.copy(fCard or npcCard or {})
            self.oDuplicate.fCardList = nil
        end

        if self.type == SceneType.ChainFront or self.type == SceneType.BuffBattle then
            exData.isForceOver = self.isForceOver
            exData.isStepLimitWin = self.isStepLimitWin
        end

        -- LogTable(self.arrNP, "self.arrNP")
        local cardCnt = self.arrTeam[1].nCardCount
        local teamIdx = self.oDuplicate:GetTeamIndex() or 1
        self.oDuplicate.fCard = fCard
        --LogD("更新无限血排行榜:%s,%s,%s", self.nInvTotalDamage or 0, dupCfg.group, self.isInvincible)
        -- 更新无限血排行榜 无限血机制统计伤害 1钓鱼佬  2可杀死共用血条  3无限血共用血条
        if self.isInvincible and self.isInvincible ~= 2 then
            local nTotalDamage = self.nInvTotalDamage or 0
            -- for i, card in ipairs(self.arrCard) do
            --     -- 无限血机制
            --     if card.isInvincible then
            --         nTotalDamage = card.nTotalDamage
            --         break
            --     end
            -- end
            exData.invincibleDamage = nTotalDamage
            -- 更新排行榜
            local plr = self.oDuplicate.oPlayer
            local rankType
            if dupCfg.group then
                local rankSection = GobalCfg:GetRankSection()
                if rankSection and rankSection[dupCfg.group] then
                    local dungeonGroup = dupCfg.dungeonGroup or 0
                    rankType = rankSection[dupCfg.group]
                    if rankType and rankType ~= eRankId.ChainFrontRank and self.type ~= SceneType.CrossBoss and self.type ~= SceneType.PeriodicBoss then
                        RankMgrGs:AddRankData(rankType, nTotalDamage, plr, teamIdx, fCard, dungeonGroup)
                        plr:UpdateAchieve(eAchieveFinishType.Fight, eAchieveEventType.Rank, { rankType })
                        self.oDuplicate.hisMaxDamage = RankMgrGs:GetScoreByType(rankType, plr)
                    end
                end
            end
        end
        exData.summonLiveCnt = summonLiveCnt

        -- 小地图用，需要把战斗发生的位置信息传回去
        if self.fightPos then
            exData.fightPos = self.fightPos
            exData.isSimulated = self.isSimulated
        end

        -- 后续尽量不新增参数，全部丢在exData里面，需要的自己读出来
        self.oDuplicate:OnFightOver(
            winer,
            {data = data, nNp = self.arrNP[1]},
            self.myOID,
            self.monsterOID,
            grade,
            hpinfo,
            self:GetCurrStep(),
            deathcount,
            cardCnt,
            cardIds,
            nMinHpPercent * 100,
            exData
        )

        --LogDebugEx("PVEFightMgrServer:Over", deathcount, cardCnt, nMinHpPercent * 100)

        -- 操作日志
        -- StatsMgr:AddLogRecord(
        --     self.oDuplicate.oPlayer,
        --     LogItem.FighitOver,
        --     self.id,
        --     self.type,
        --     winer == 1 and true or false,
        --     self.nDuplicateID,
        --     CURRENT_TIME - self.startTime,
        --     self.groupID,
        --     self.oDuplicate.nCosthot
        -- )
        --LogTable(eDuplicateTypeName, "eDuplicateTypeName:")
        --LogTable(eDuplicateTypeChName, "eDuplicateTypeChName:")

        local ssEvnetData = {
            fid = self.id,
            duplicate_id = self.nDuplicateID,
            duplicate_name = dupCfg.name,
            sceneType = self.type,
            dup_type = dupCfg.type,
            dup_type_name = GCalHelp:GetDupTypeName(dupCfg),
            dup_group = self.groupID,
            bIsWin = (winer == 1 and true or false),
            fight_time = CURRENT_TIME - self.startTime,
            nCosthot = self.oDuplicate.nCosthot
        }

        --LogTable(ssEvnetData, "ssEvnetData:")
        SSSDK:Event(self.oDuplicate.oPlayer, 'FighitOver', ssEvnetData)
    end

    if self.cbOver then
        self:cbOver(winer, self.isForceOver)
    end 

    self:Destroy()
end

function PVEFightMgrServer:Destroy()
    LogDebug('PVEFightMgrServer:Destroy')
    FightHelp:Destroy(self.oDuplicate.oPlayer.uid)

    FightMgrServer.Destroy(self)

    LogDebug('PVEFightMgrServer:Destroy end')
end

-- 设置使用技能AI策略
-- function PVEFightMgrServer:SetSkillAI(uid, data)
-- 	--LogTable(data, "data = ")
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	local card = self:GetCardByOID(data.id)

-- 	local oDuplicate = self.oDuplicate
-- 	--ASSERT(oDuplicate)
-- 	if card.fuid or card.npcid then
-- 		-- 助战卡牌或npc
-- 		local carddata = oDuplicate:FindCardData(self.myOID, card.cuid, card.fuid)
-- 		if carddata then
-- 			carddata.data.isUseCommon = data.isUseCommon
-- 		end
-- 	else
-- 		local carddata = oDuplicate:FindCardData(self.myOID, card.cuid)
-- 		if carddata then
-- 			carddata.data.isUseCommon = data.isUseCommon
-- 		end

-- 		local oCardMgr = self.oDuplicate.oPlayer.oCardMgr
-- 		local oCard = oCardMgr:GetCard(card.cuid)
-- 		-- LogDebugEx("card.cuid = "..card.cuid)
-- 		if not oCard then ASSERT() end
-- 		oCard:SetMix("isUseCommon", data.isUseCommon)
-- 	end
-- end

function PVEFightMgrServer:OnPlayerLogin(uid, data)
    -- if not self.nMonsterGroupID then -- 非直接战斗副本
    FightMgrBase.OnPlayerLogin(self, uid, data)
    -- end
end

-- 伤害统计
function PVEFightMgrServer:DamageStat(caster, nDamage)
    local dupCfg = MainLine[self.nDuplicateID]
    if dupCfg.type == eDuplicateType.MultTeam and caster:GetTeamID() == 1 then
        local oldVal = self.nTotalDamage or 0
        self.nTotalDamage = oldVal + nDamage
    end
    --LogDebug("PVEFightMgrServer:DamageStat nDamage:" .. nDamage)
    LogDebug(string.format('DamageStat name = %s damage = %s', caster.name, nDamage))
    self.oDuplicate:UpdateDamageStat(caster, nDamage)
end

------------------------------------------------------------------
-- PVP镜像(军演)
MirrorFightMgrServer = oo.class(FightMgrServer)
function MirrorFightMgrServer:Init(...)
    FightMgrServer.Init(self, ...)
end

-- 广播消息
function MirrorFightMgrServer:Broadcast(cmd, msg)
    -- 镜像
    for i, v in ipairs(self.arrPlayer) do
        local player = GetPlayer(v.uid)
        if player then
            player:Send(cmd, msg)
        end
    end
end

function MirrorFightMgrServer:Send(uid, cmd, msg)
    local player = GetPlayer(uid)
    if player then
        player:Send(cmd, msg)
    end
end

function MirrorFightMgrServer:OnStart(data)
    if self.isStart then
        return
    end
    self:AddCmd(CMD_TYPE.Start, {})
    FightMgrBase.OnStart(self, data)
end

-- 结束
function MirrorFightMgrServer:Over(stage, winer)
    LogDebug('MirrorFightMgrServer:Over')
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
    FightMgrBase.Over(self, stage, winer)

    LogDebugEx('MirrorFightMgrServer:Over', self.type, self.nDuplicateID, winer)

    if self.cbOver then
        self:cbOver(winer, self.isForceOver)
    end

    -- for i, v in ipairs(self.arrPlayer) do
    --     -- 操作日志
    --     StatsMgr:AddLogRecord(
    --         GetPlayer(v.uid),
    --         LogItem.FighitOver,
    --         self.id,
    --         self.type,
    --         winer == v.teamID and true or false,
    --         self.nDuplicateID,
    --         CURRENT_TIME - self.startTime,
    --         self.groupID
    --     )
    -- end
    self:Destroy()
end

function MirrorFightMgrServer:Destroy()
    LogDebug('MirrorFightMgrServer:Destroy')
    LogTable(self.arrPlayer)
    for i, v in ipairs(self.arrPlayer) do
        FightHelp:Destroy(v.uid)
    end
    FightMgrServer.Destroy(self)
end

-- 设置使用技能AI策略
-- function MirrorFightMgrServer:SetSkillAI(uid, data)
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	local card = self:GetCardByOID(data.id)
-- 	LogDebugEx("card = ", card.cuid)
-- 	if card.fuid or card.npcid or card:GetType() == CardType.Summon then
-- 		-- -- 助战卡牌或npc或机神
-- 		-- local oDuplicate = self.oDuplicate
-- 		-- local carddata = oDuplicate:FindCardData(self.myOID, card.cuid, card.fuid)
-- 		-- carddata.data.isUseCommon = data.isUseCommon
-- 	else
-- 		local oPlayer = GetPlayer(uid)
-- 		if oPlayer then
-- 			local oCardMgr = oPlayer.oCardMgr
-- 			local oCard = oCardMgr:GetCard(card.cuid)
-- 			oCard:SetMix("isUseCommonPVP", data.isUseCommon)
-- 		end
-- 	end
-- end
------------------------------------------------------------------
-- PVP实时(军演)
PVPFightMgrServer = oo.class(FightMgrServer)
function PVPFightMgrServer:Init(...)
    FightMgrServer.Init(self, ...)

    -- AI托管(非断线为客户端主动发送, 断线或客户端超时没有发送命令切换为托管状态)
    -- self.playerTimeout	= {0,0} -- 操作超时次数
    self.nTrusteeship = {}
end

-- 广播消息
function PVPFightMgrServer:Broadcast(cmd, msg)
    for i, v in ipairs(self.arrPlayer) do
        local conn = ArmyFighDataMgr:GetPlrConn(v.uid)
        -- v.player:Send(cmd, msg)
        if conn then
            conn:send({cmd, msg})
        end
    end
end

function PVPFightMgrServer:Send(uid, cmd, msg)
    local conn = ArmyFighDataMgr:GetPlrConn(uid)
    if conn then
        conn:send({cmd, msg})
    else
        LogDebug("PVPFightMgrServer:Send() not find conn")
    end
end

function PVPFightMgrServer:OnStart(data)
    if self.isStart then
        return
    end
    self.lstPrepare = self.lstPrepare or {}
    self.lstPrepare[data.uid] = true

    if table.size(self.lstPrepare) >= 2 then
        self:AddCmd(CMD_TYPE.Start, {})
        FightMgrBase.OnStart(self, data)
    end
end

-- 结束
function PVPFightMgrServer:Over(stage, winer)
    LogDebug('PVPFightMgrServer:Over')
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
    FightMgrBase.Over(self, stage, winer)

    LogDebugEx('PVPFightMgrServer:Over', self.type, self.nDuplicateID, winer, self.isOver)
    --LogTrace()

    if self.cbOver then
        LogDebug('self.cbOver------------------------------------')
        self:cbOver(winer, self.isForceOver)
    else
        ASSERT()
    end
    self.isOver = true

    self:Destroy()
end

function PVPFightMgrServer:Destroy()
    LogDebug('PVPFightMgrServer:Destroy')
    for i, v in ipairs(self.arrPlayer) do
        FightHelp:Destroy(v.uid)
    end
    FightMgrServer.Destroy(self)
end

-- 倒计时
function PVPFightMgrServer:OnCardTick()
    -- LogDebug("PVPFightMgrServer:OnCardTick() self.isOver:%s, self.currTurn:%s", self.isOver, self.currTurn)
    if self.isOver then
        return
    end

    if not self.currTurn then
        return
    end

    -- LogTable(self.currTurn, "PVPFightMgrServer:OnCardTick() self.currTurn:")
    -- LogDebug("PVPFightMgrServer:OnCardTick()  self.currTurn.nTimeToDoAI:%s, CURRENT_TIME:%s, diff:%s", self.currTurn.nTimeToDoAI, CURRENT_TIME, self.currTurn.nTimeToDoAI - CURRENT_TIME)

    if self.currTurn.nTimeToDoAI then
        local teamID = self.currTurn:GetTeamID()

        -- 托管
        -- LogDebug("PVPFightMgrServer:OnCardTick() self.nTrusteeship[teamID]:%s", self.nTrusteeship[teamID])
        if self.nTrusteeship[teamID] then
            -- 超时自动战斗
            LogDebug('OnCardTick.托管[%s]', teamID)
            if self.currTurn and self.currTurn.bToDoSkill then
                self.currTurn:DoAI()
                self:AfterTurnNext(self.currTurn)
            end

            return true
        end

        if self.currTurn.nTimeToDoAI <= CURRENT_TIME then
            -- 超时自动战斗
            -- LogDebugEx("OnCardTick.超时[%s]curr=%s,nTimeToDoAI=%s", teamID, CURRENT_TIME, self.currTurn.nTimeToDoAI or 0)
            self.currTurn:DoAI()
            self:AfterTurnNext(self.currTurn)
            self.nTrusteeship[teamID] = true
            return true
        end
    end
end

function PVPFightMgrServer:OnTimer(tm)
    -- LogDebugEx("PVPFightMgrServer:OnTimer", self.isStart, self.isOver)
    if not self.isStart then
        return
    end

    if self.isOver then
        return
    end

    if self:CheckOver(true) then
        return
    end

    -- LogDebugEx("FightMgrBase:OnTimer 111 ", CURRENT_TIME, self.needChangeStage)
    if self.needChangeStage and self.needChangeStage - CURRENT_TIME < 0 then
        self:ChangeStage()
        self:AfterChangeStage()
        self.needChangeStage = nil
    elseif self.needChangeStage then
        return
    end

    if self:OnCardTick() then
        if self:CheckOver() then
            return
        end
        self:OnTurnNext()
        return
    end

    -- LogDebugEx("FightMgrBase:OnTimer 22 ", CURRENT_TIME, self.nextTime)
    if self.nextTime and self.nextTime - CURRENT_TIME < 0 then
        self:OnTurnNext()
    end
end

function PVPFightMgrServer:GetTimeToDoAI(teamID)
    -- if self.playerTimeout[teamID] > 2 then
    -- 	return 3
    -- else
    -- 	return g_fightControlTime + 20
    -- end
    return g_fightControlTime_s
end

function PVPFightMgrServer:AfterTurnNext(card)
    card.nTimeToDoAI = nil
    card.bToDoSkill = nil
end

function PVPFightMgrServer:OnTurnNext()
    self.nextTime = nil
    if self.isOver then
        return
    end

    self:OnRoundOver()
    LogTable(self.log:GetAndClean())
    if self.isOver then
        return
    end

    local t, card = self:CalcNext()
    ASSERT(card)
    LogDebugEx('Next  ------', card.name, card.oid)
    -- DT(card:GetData())
    self:AddAllTime(t, card)
    self.nAddTime = t
    self:AddCmd(CMD_TYPE.Turn, {id = card.oid})

    self.turnNum = self.turnNum + 1
    self.currTurn = card
    card.nTimeToDoAI = CURRENT_TIME + self:GetTimeToDoAI(card:GetTeamID())
    card.bToDoSkill = true
    self.waitForDoSkill = card.oid

    local str = '第' .. self.turnNum .. '回合\n'
    self:PrintCardInfo(str)

    LogDebug('##############玩家行动#################' .. card.name .. ' ' .. card.oid)
    self:ResetSkillSign()
    -- 处理buffer行动前
    local log = {api = 'OnRoundBegin'}
    self.log:Add(log)
    self.log:StartSub('datas')
    self.oFightEventMgr:DoEvent('OnRoundBegin', card)
    self.oFightEventMgr:DoEvent('OnAfterRoundBegin', card)
    self.log:EndSub('datas')

    if not card:IsLive() then
        -- 已经死亡
        self:Wait(1)
        LogDebugEx('card is death', card.name)
        -- self.isRoundOver = true
        card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
        return
    end

    -- 可能敌方都死光了
    if self:CheckOver() then
        return
    end

    -- 控制类buffer处理
    local isMotionless = card.bufferMgr:IsMotionless()
    LogDebugEx('============isMotionless===============', IsMotionless)
    if isMotionless then
        LogDebug('-------此处无法行动-------' .. card.name)
        card.bufferMgr:OnUpdateBuffer()
        --无法行动要处理buff回合-1
        self:UpdateProgress(nil, card, false)
        self:Wait(1)
    end

    card:OnTurn(isMotionless)
    local need2Next = card:AIOnTurn(isMotionless)

    if need2Next then
        self:AfterTurnNext(card)
    end
    card.bAIOnTurn = nil -- 设置了自动战斗, 就不执行ai
end

function PVPFightMgrServer:OnRoundOver()
    local currTurn = self.currTurn

    if FightMgrBase.OnRoundOver(self) then
        -- currTurn.bufferMgr:OnUpdateBuffer()
        self:DoEventWithLog('OnRoundOver', currTurn)
        self:DoDeathEvent()
        -- self.currTurn:ResetTempAttr()
        LogDebug('##############玩家行动结束#################' .. currTurn.name)
        self:AfterTurnNext(currTurn)
        self:ResetTempSign()
        self.currTurn = nil

    -- FightMgrBase.AfterRoundOver(self)
    end
end

-- 执行技能
function PVPFightMgrServer:DoSkill(data)
    --LogDebugEx("PVPFightMgrServer:DoSkill")
    --LogTrace()
    local card = FightMgrServer.DoSkill(self, data)
    if card then
        -- 手动操作取消托管
        self.nTrusteeship[card:GetTeamID()] = nil

        self:AfterTurnNext(card)
    end
end

function PVPFightMgrServer:AutoFight(uid, data)
    if self.isOver then
        return
    end
    if not self.currTurn then
        return
    end
    --LogDebugEx("PVPFightMgrServer:AutoFight", uid, data.id , self.currTurn.oid, self.waitForDoSkill , self.currTurn.oid, self.currTurn.bToDoSkill)
    if data.id ~= self.currTurn.oid then
        return
    end
    if not self.waitForDoSkill or self.waitForDoSkill ~= self.currTurn.oid then
        return
    end

    -- 不是轮到自己就不要发
    if uid ~= self.currTurn.uid then
        ASSERT()
        return
    end

    if not self.currTurn.bToDoSkill then
        return
    end

    self.currTurn:DoAI()
    self:AfterTurnNext(self.currTurn)

    -- 客户端主动操作取消托管
    self.nTrusteeship[self.currTurn:GetTeamID()] = nil

    self.waitForDoSkill = nil
end

function PVPFightMgrServer:OverLoad(data)
    LogDebugEx('PVPFightMgrServer:OverLoad')
    local waitTime = FightMgrServer.OverLoad(self, data)
    if waitTime then
        -- 释放成功
        self:AfterTurnNext(self.currTurn)
    end
end

function PVPFightMgrServer:OnPlayerLogin(uid, data)
    FightMgrBase.OnPlayerLogin(self, uid, data)
    for i, v in ipairs(self.arrPlayer) do
        if v.uid == uid then
            self.nTrusteeship[v.teamID] = nil
        end
    end
end

-- 开始倒计时
function PVPFightMgrServer:CountdownBegins(uid, data)
    LogDebugEx('FightMgrBase:CountdownBegins', uid)
    if self.isOver then
        return
    end
    if not self.currTurn then
        return
    end
    if not self.currTurn.nTimeToDoAI then
        return
    end

    local teamID = self:GetTeamIDByUID(uid)
    if self.currTurn:GetTeamID() ~= teamID then
        return
    end

    local team = self:GetTeam(teamID)
    self.currTurn.nTimeToDoAI = CURRENT_TIME + g_fightControlTime + 10
end

-- 设置托管
function PVPFightMgrServer:SetTrusteeship(uid, bTrusteeship)
    if self.isOver then
        return
    end
    LogDebugEx('FightMgrBase:SetTrusteeship', uid)

    local teamID = self:GetTeamIDByUID(uid)
    self.nTrusteeship[teamID] = bTrusteeship
end

function PVPFightMgrServer:SendRestoreFight(uid, nCmdIndex)
    FightMgrBase.SendRestoreFight(self, uid, nCmdIndex)

    if self.nTrusteeship[1] or self.nTrusteeship[2] then
        local nTrusteeship = {self.nTrusteeship[1] or false, self.nTrusteeship[2] or false}
        self:Send(uid, 'FightProto:TrusteeshipState', {nTrusteeship = nTrusteeship})
    end
end

-- -- 设置使用技能AI策略
-- function PVPFightMgrServer:SetSkillAI(uid, data)
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	local card = self:GetCardByOID(data.id)

-- 	if card.fuid or card.npcid then
-- 		-- -- 助战卡牌或npc
-- 		-- local oDuplicate = self.oDuplicate
-- 		-- local carddata = oDuplicate:FindCardData(self.myOID, card.cuid, card.fuid)
-- 		-- carddata.data.isUseCommon = data.isUseCommon
-- 	else
-- 		local oPlayer = GetPlayer(uid)
-- 		if oPlayer then
-- 			local oCardMgr = oPlayer.oCardMgr
-- 			local oCard = oCardMgr:GetCard(card.cuid)
-- 			oCard:SetMix("isUseCommonPVP", data.isUseCommon)
-- 		end
-- 	end
-- end
------------------------------------------------------------------
-- 世界boss
BossFightMgrServer = oo.class(MirrorFightMgrServer)
function BossFightMgrServer:Init(...)
    FightMgrServer.Init(self, ...)
    self.nTotalDamage = 0
end

-- 结束
function BossFightMgrServer:Over(stage, winer)
    if self.isOver then
        return
    end -- 已经结束

    LogDebug('BossFightMgrServer:Over')
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
    FightMgrBase.Over(self, stage, winer)

    LogDebugEx('BossFightMgrServer:Over', self.type, self.nDuplicateID, winer)

    if self.cbOver then
        self:cbOver(winer)
    end

    self:Destroy()
end

-- 加载Boss
function BossFightMgrServer:LoadBossConfig(groupID, stage)
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

-- 获取boss血量
function BossFightMgrServer:GetBossHP()
    local oBoss = WordBossMgrGs:GetBoss(self.bossUUID)
    if not oBoss then
        return 0
    end
    return oBoss.hp
end

-- 伤害统计
function BossFightMgrServer:DamageStat(caster, nDamage)
    if caster:GetTeamID() ~= 1 then
        return
    end
    self.nTotalDamage = self.nTotalDamage + nDamage

    local oBoss = WordBossMgrGs:GetBoss(self.bossUUID)
    if not oBoss then
        return
    end
    oBoss:Damage(self.playerID, nDamage)
end
-- -- 设置使用技能AI策略
-- function BossFightMgrServer:SetSkillAI(uid, data)
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	local card = self:GetCardByOID(data.id)

-- 	if card.fuid or card.npcid then
-- 		-- -- 助战卡牌或npc
-- 		-- local oDuplicate = self.oDuplicate
-- 		-- local carddata = oDuplicate:FindCardData(self.myOID, card.cuid, card.fuid)
-- 		-- carddata.data.isUseCommon = data.isUseCommon
-- 	else
-- 		local oPlayer = GetPlayer(uid)
-- 		if oPlayer then
-- 			local oCardMgr = oPlayer.oCardMgr
-- 			local oCard = oCardMgr:GetCard(card.cuid)
-- 			oCard:SetMix("isUseCommon", data.isUseCommon)
-- 		end
-- 	end

-- end

------------------------------------------------------------------
-- 小地图支援
MapSupportFightMgrServer = oo.class(PVEFightMgrServer)
function MapSupportFightMgrServer:Init(...)
    LogDebugEx("MapSupportFightMgrServer:Init")
    FightMgrServer.Init(self, ...)
    self.nKillMonsterNum = 0
    self.nTotalDamage = 0
end

function MapSupportFightMgrServer:Broadcast(cmd, msg)
    local player = GetPlayer(self.uid)
    if player then
        player:Send(cmd, msg)
    end
end

function MapSupportFightMgrServer:Send(uid, cmd, msg)    
    local player = GetPlayer(uid)
    if player then
        player:Send(cmd, msg)
    end
end


function MapSupportFightMgrServer:OnStart(data)
    if self.isStart then
        return
    end
    self:AddCmd(CMD_TYPE.Start, {})
    FightMgrBase.OnStart(self, data)
end

function MapSupportFightMgrServer:OnDeath(card, killer)
    FightMgrBase.OnDeath(self, card, killer)

    -- nDuplicateID 100以内为预留活动战斗
    if self.nDuplicateID > 100 and card:GetTeamID() == 2 then
        self.nKillMonsterNum = self.nKillMonsterNum + 1
    end
end

-- 结束
function MapSupportFightMgrServer:Over(stage, winer)
    if self.isOver then
        return
    end -- 已经结束

    LogDebug('MapSupportFightMgrServer:Over')
    self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
    FightMgrBase.Over(self, stage, winer)

    local exData = {
        nKillMonsterNum = self.nKillMonsterNum,
        nTotalDamage = self.nTotalDamage
    }
    if winer == 1 then
        exData.bossCurHp = 0
    else
        -- 失败了要保存怪物血量
        local data = {}
        local maxhp = {}
        local maxConfigIndex = 0
        for i, v in ipairs(self.arrCard) do
            -- 合体, 召唤
            if v.configIndex then
                if v.configIndex > maxConfigIndex then
                    maxConfigIndex = v.configIndex
                end
                data[v.configIndex] = v.hp
                if v.hp > 0 then
                    exData.bossCurHp = (exData.bossCurHp or 0) + v.hp
                end
                maxhp[v.configIndex] = v.maxhp
            end
        end


        for idx = 1, maxConfigIndex do
            if data[idx] == nil then
                data[idx] = 0
            end
            if maxhp[idx] == nil then
                maxhp[idx] = 0
            end
        end
        exData.hpInfo = {stage = self.stage, data = data, maxhp = maxhp}
    end

    LogDebugEx('MapSupportFightMgrServer:Over', self.type, self.nDuplicateID, winer)
    if self.cbOver then
        self:cbOver(winer, self.isForceOver, exData)
    end

    self:Destroy()
end

function MapSupportFightMgrServer:Destroy()
    LogDebug('MapSupportFightMgrServer:Destroy')
    FightHelp:Destroy(self.uid)

    FightMgrServer.Destroy(self)

    LogDebug('MapSupportFightMgrServer:Destroy end')
end

function MapSupportFightMgrServer:DamageStat(caster, nDamage)
    --LogDebug(string.format("DamageStat name = %s damage = %s", caster.name, damage))
    if caster:GetTeamID() ~= 1 then
        return
    end
    self.nTotalDamage = self.nTotalDamage + nDamage

    if IS_CLIENT then return end
end

------------------------------------------------------------------

if IS_CLIENT then
    FightMgrClient.LoadBossConfig = BossFightMgrServer.LoadBossConfig
    FightMgr = FightMgrClient

    function CreateFightMgr(id, groupID, ty, seed, nDuplicateID)
        LogDebugEx('CreateFightMgr', id, groupID, ty, seed, nDuplicateID)
        return FightMgr(id, groupID, ty, seed, nDuplicateID)
    end
elseif IS_SERVER then
    FightMgr = FightMgrServer
    function CreateFightMgr(id, groupID, ty, seed, nDuplicateID)
        LogDebugEx('CreateFightMgr', id, groupID, ty, seed, nDuplicateID)
        if ty == SceneType.PVE or ty == SceneType.Rogue or ty == SceneType.RogueS or ty == SceneType.RogueT or ty == SceneType.RogueMap 
            or ty == SceneType.BuffBattle or ty == SceneType.MultTeam or ty == SceneType.TowerDeep  or ty == SceneType.ChainFront or ty == SceneType.CrossBoss
            or ty == SceneType.PeriodicBoss then
            return PVEFightMgrServer(id, groupID, ty, seed, nDuplicateID)
        elseif ty == SceneType.PVPMirror or ty == SceneType.PVEBuild or ty == SceneType.PVEFreeMatch then -- v 4.3
            return MirrorFightMgrServer(id, groupID, ty, seed, nDuplicateID)
        elseif ty == SceneType.PVP then
            return PVPFightMgrServer(id, groupID, ty, seed, nDuplicateID)
        elseif ty == SceneType.BOSS or ty == SceneType.GuildBOSS or ty == SceneType.FieldBoss or ty == SceneType.GlobalBoss then
            return BossFightMgrServer(id, groupID, ty, seed, nDuplicateID)
        elseif ty == SceneType.RogueMapSup then
            -- 小地图探索支援，按普通的PVE战斗进行，战斗结束特殊处理
            LogDebugEx("create MapSupportFightMgrServer")
            return MapSupportFightMgrServer(id, groupID, ty, seed, nDuplicateID)
        end
        ASSERT()
        return FightMgr(id, groupID, ty, seed, nDuplicateID)
    end
end
------------------------------------------------------------------

-- 战斗数据恢复FightMgr
RestoreFightMgrServer = oo.class(MirrorFightMgrServer)
function RestoreFightMgrServer:Init(id, groupID, ty, seed, nDuplicateID)
    LogDebugEx('RestoreFightMgrServer:Init', id, groupID, ty, seed, nDuplicateID)
    self.id = id
    self.groupID = groupID
    self.type = ty
    self.stage = 0
    self.nDuplicateID = nDuplicateID -- 副本id
    self.isStart = false -- 是否开始
    self.isOver = false -- 是否战斗结束
    self.log = FightLog() -- 战斗日志
    self.bIsAuto = true

    -- 开始时间
    self.startTime = CURRENT_TIME
    self.nextTime = CURRENT_TIME

    -- 命令列表
    self.cmds = {}

    self.seed = seed --os.time() + math.rand(10000)
    self.rand = Random(self.seed)

    --
    self.arrTeam = {}
    self.arrNP = {}
    self.shield = {} -- 盾墙
    for i = 1, 2 do
        self.arrTeam[i] = TeamTest(i, self)
        self.arrNP[i] = g_nEnterNp
        self.shield[i] = {}
    end

    if ty == SceneType.PVPMirror or ty == SceneType.PVP then
    else
        self.arrNP[2] = 0
    end

    self.arrCard = {} -- 可行动的卡牌队列
    self.arrCurrDeath = {} -- 当前回合死亡的列表

    self.arrPlayer = {}
    self.arrStateID = {} -- 周目id

    self.oid = 3 -- 用于卡牌id分配
    self.currTurn = nil -- 当前操作的卡牌
    self.turnNum = 0 -- 总战斗回合
    self.nStep = 0 -- 当前周目战斗回合
    self.nStepPVE = 0 -- PVE 我方操作次数
    self:SetStepLimit(g_nFightLimit) -- 设置回合限制

    -- 事件处理
    self.oFightEventMgr = FightEventMgr(self)
    self.tmpIdx = 0
end


-- 加载玩家数据
function RestoreFightMgrServer:LoadData(teamID, data, typ, tCommanderSkill)
    LogTable(data, 'RestoreFightMgrServer:LoadData')
    --LogTrace()
    --LogTable(tCommanderSkill, "tCommanderSkill")

    -- data = Halo:Calc(data)

    local team = self.arrTeam[teamID]
    ASSERT(team)
    local row = data.row or 3
    local col = data.col or 3
    team:InitMap(row, col)
    team:LoadData(data, typ, tCommanderSkill)
end

-- 加载怪物组
function RestoreFightMgrServer:LoadConfig(groupID, stage, hpinfo)
    LogDebugEx('RestoreFightMgrServer:LoadConfig', self.groupID, groupID)
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

    -- 敌方阵型
    self.arrTeam[2]:LoadConfig(self.groupID, self.stage, hpinfo)
    self.totleState = #config.stage

    for i, card in ipairs(self.arrCard) do
        -- 无限血机制
        if card.isInvincible then
            self.isInvincible = true -- 是否为无限血副本
        end
    end

    if self.isInvincible then
        self.nInvStateDamage  = 0 -- 当前阶段伤害量
        self.nInvTotalDamage   = 0 -- 总害量
    end
end

-- 执行技能
function RestoreFightMgrServer:DoSkill(data)
    LogDebug('客户端释放技能--')
    local caster = self:GetCardByOID(data.casterID)
    if caster ~= self.currTurn then
        if not self.currTurn then
            ASSERT(nil, "DoSkill:"..table.tostring(data))
        end
        LogDebugEx(
            '当前发命令者:' .. caster.name .. '_' .. caster:GetTeamID(),
            '当前轮到:' .. self.currTurn.name .. '_' .. caster:GetTeamID()
        )
        if not self.isSaveLog and IS_SERVER then  -- 这里可能是单机战斗
            self:ClientError(self.uid or caster.uid or "", "数据不一致")
        end
        self.isSaveLog = true
        ASSERT(nil, '数据不一致')
    end
    local target
    local pos
    -- 此处不一定是选中的是一个对象, 可能是一个空格子,  需要根据技能再筛选出受技能的对象
    if data.target then
        pos = data.target.pos
        if data.target.reliveID then
            pos = self:CheckRelive(caster, data)
        else
            target = caster:GetSkillRange(data.skillID, data.target)
        end
    end

    -------------------------------------------------------------------------------------------
    local skillCmdData = self.skillCmdData and self.skillCmdData[#self.cmds + 1]
    if skillCmdData and skillCmdData.casterID == data.casterID and skillCmdData.skillID == data.skillID then
        if skillCmdData.targetIDs then
            target = skillCmdData.targetIDs
        end
    end
    -------------------------------------------------------------------------------------------
    LogTable(target, 'Attack target')
    local ret = self:Attack(caster, target, data, pos or data.pos)
    if not ret then
        return
    end

    self.waitForDoSkill = nil

    self:AddCmd(CMD_TYPE.Skill, data)
    local config = skill[data.skillID]
    local action_time = 0
    if config then
        action_time = (config.action_time / 1000)
    else
        action_time = 4
    end
    self:Wait(action_time)
    return caster
end
-------------------------------------------------------------------------------------------

-- 回放
