-- OPENDEBUG()
-- 计算卡牌的属性
GCardCalculator = {
    m_useProperty = {
        id = true,
        name = true,
        -- cardName = true,
        model = true,
        attack = true,
        maxhp = true,
        defense = true,
        speed = true,
        crit_rate = true,
        crit = true,
        hit = true,
        resist = true,
        hot = true,
        np = true,
        sp = true,
        sp_race = true,
        sp_race2 = true,
        bedamage = true,
        damage = true,
        becure = true,
        cure = true,
        damagePhysics = true,
        damageLight = true,
        fight_cost = true,
        career = true,
        quality = true,
        nStep = true,
        nJump = true,
        nMoveType = true
    }
}

-------------------------------------------------------------------------------------------------------------------
--
local LvlCalArgs = {
    cal1 = {'attack', 'maxhp', 'defense'}
    , cal2 = {'speed', 'crit_rate', 'crit', 'hit', 'resist', 'hot', 'np', 'sp', 'sp_race', 'sp_race2', 'damagePhysics'}
    -- , cal3 = {'hot', 'np', 'sp', 'sp_race', 'sp_race2'} -- v 5.6 专武
}

-- v 5.6 专武
local LvlCalPairArgs = {
    cal1 = {{'attack_fixed', 'attack'}, {'maxhp_fixed', 'maxhp'}, {'defense_fixed', 'defense'}} -- 固定值
}

-- 计算卡牌等级的属性
-- cfgid ：配置id
-- level : 等级
-- intensify_level：强化等级
-- break_level : 突破等级
-- cl: 核心等级
-- weapon_lv: 专武等级 -- v 5.6 专武
-- isClient:客户端用， 基础属性会直接返回整数，不返回小数
function GCardCalculator:CalLvlPropertys(cfgid, level, intensify_level, break_level, isMonster, cl, weapon_lv, isClient)
    -- LogTrace("CalLvlPropertys()")
    LogDebug("CalLvlPropertys() cfgid:%s, level:%s, intensify_level:%s, break_level:%s, isMonster:%s, cl:%s, weapon_lv:%s,", cfgid, level, intensify_level, break_level, isMonster, cl, weapon_lv)

    weapon_lv = weapon_lv or 0 -- v 5.6 专武

    -- intensify_level：这个在那时没用了
    intensify_level = intensify_level or 1

    if not cfgid or not level or not intensify_level or not break_level then
        LogWarning(
            string.format('not cfgid:%s or not level:%s or not intensify_level:%s or not break_level:%s',
            cfgid,
            level,
            intensify_level,
            break_level)
        )
        return nil
    end

    cl = cl or 1

    -- LogDebug("CalLvlPropertys(%s, %s, %s, %s)", cfgid, level, intensify_level, break_level)
    -- 基本属性
    local cfg = nil
    if isMonster then
        local monsterCfg = MonsterData[cfgid]
        cfg = monsterCfg
        if monsterCfg.numerical then
            local monsterNumberCfg = MonsterNumerical[monsterCfg.numerical * 1000 + level]
            if monsterNumberCfg then
                cfg = monsterNumberCfg
            end
        end
    else
        cfg = CardData[cfgid]
    end

    if not cfg then
        LogWarning('CardData not find config: %d, isMonster:%s.', cfgid, isMonster)
        return nil
    end

    local ret = {}

    -- 拷贝基本属性
    -- table.copy(cfg, ret)
    for k, v in pairs(cfg) do
        if self.m_useProperty[k] then
            ret[k] = v
        end
    end

    ret.card_exp_add = 0
    ret.plr_exp_add = 0
    ret.gold_add = 0

    if not isMonster then
        local lvAdd = CardLevel[level] -- 等级添加
        local breakAdd = CardBreak[break_level] -- 突破添加
        local intensifyAdd = CardIntensify[intensify_level] --强化添加
        local weaponAdd = {} -- v 5.6 专武添加

        -- v 5.6 专武添加
        if weapon_lv then
            local weaponCfg = CfgCardWeapon[cfgid]
            if weaponCfg then
                local weaponLvCfg = weaponCfg.infos[weapon_lv + 1]
                if weaponLvCfg then
                    for _, infoArr in ipairs(weaponLvCfg.use_types or {}) do
                        local fieldIx = infoArr[1]
                        local fieldVal = infoArr[2]

                        local enumCfg = CfgCardPropertyEnum[fieldIx]
                        if enumCfg then
                            weaponAdd[enumCfg.sFieldName] = fieldVal
                        end
                    end
                    ret.weaponFightSkills = weaponLvCfg.skills or {}
                else
                    LogError("CalLvlPropertys() cfgid:%s not weaponCfg cfg by lv:%s",cfgid , weapon_lv + 1)
                end
            else
                ret.weaponFightSkills = {}
            end
            
        end

        -- LogTable(weaponAdd, "CalLvlPropertys() weaponAdd:")

        if not lvAdd then
            local maxLv = #CardLevel
            if level > maxLv then
                lvAdd = CardLevel[maxLv]
            end
        end

        if not breakAdd then
            local maxLv = #CardBreak
            if level > maxLv then
                breakAdd = CardBreak[maxLv]
            end
        end

        if not intensifyAdd then
            local maxLv = #CardIntensify
            if level > maxLv then
                intensifyAdd = CardIntensify[maxLv]
            end
        end

        -- LogTable(ret, "ret:")
        -- LogTable(lvAdd, "lvAdd:")
        -- LogTable(breakAdd, "breakAdd:")
        for _, v in pairs(LvlCalArgs.cal1) do
            -- LogDebug("cal1(%s, %s, %s, %s)", v, ret[v], lvAdd[v], breakAdd[v])
            GCalHelp:Multi(ret, v, lvAdd[v])
            GCalHelp:Multi(ret, v, breakAdd[v])
            GCalHelp:Multi(ret, v, weaponAdd[v])
        end

        for _, v in pairs(LvlCalArgs.cal2) do
            -- LogDebug("cal1(%s, %s, %s, %s)", v, ret[v], lvAdd[v], breakAdd[v])
            GCalHelp:Add(ret, v, lvAdd[v])
            GCalHelp:Add(ret, v, breakAdd[v])
            GCalHelp:Add(ret, v, intensifyAdd[v])
            GCalHelp:Add(ret, v, weaponAdd[v])
        end

        -- 合并到 LvlCalArgs.cal2 去一起加
        -- for _, v in pairs(LvlCalArgs.cal3) do
        --     -- LogDebug("cal2(%s, %s, %s)", v, ret[v], intensifyAdd[v])
        --     GCalHelp:Add(ret, v, intensifyAdd[v])
        -- end

        -- v 5.6 专武
        for _, arr in pairs(LvlCalPairArgs.cal1) do
            local f1 =arr[1]
            local f2 =arr[2]
            GCalHelp:Add(ret, f2, weaponAdd[f1])
        end

        -- 设置需要的数据
        -- 最高等级
        ret.max_level = GCardCalculator:CalCardMaxLv(cfg, break_level, cl)

    end

    -- LogTable(
    --     {cfgid = cfgid, level = level, intensify_level = intensify_level, break_level = break_level},
    --     "CalLvlPropertys params:"
    -- )
    -- 属性最大值，检测
    for _, propertyCfg in pairs(CfgCardPropertyEnum) do
        if propertyCfg.nUpperLimit and ret[propertyCfg.sFieldName] > propertyCfg.nUpperLimit then
            ret[propertyCfg.sFieldName] = propertyCfg.nUpperLimit
        end
    end

    if isClient then
        for _, v in pairs(LvlCalArgs.cal1) do
            ret[v] = math.floor(ret[v])
        end
    end


    -- LogTable(ret, "CalLvlPropertys() ret:" .. cfgid)
    -- if not table.empty(ret.weaponFightSkills) then
    --     LogDebug("CalLvlPropertys() cfgid:%s, weapon_lv:%s", cfgid, weapon_lv)
    --     LogTable(ret.weaponFightSkills, "CalLvlPropertys() ret.weaponFightSkills")
    -- end
    return ret
end

-- args:
-- breakLv: 突破（跃升）等级
-- coreLv：核心等级
-- rets:
-- -- 最高等级
function GCardCalculator:CalCardMaxLv(cardCfg, breakLv, coreLv)
    local max_level = 1

    local bCfgLimit = CfgCardBreakLimitLv[breakLv]
    if bCfgLimit then
        max_level = bCfgLimit.limitLv
    else
        -- [[ v 5.0 begin

        -- 先屏蔽突破
        -- local clCfgs = CfgCardCoreLv[cardCfg.quality]
        -- if clCfgs then
        --     local clCfg = clCfgs.infos[coreLv]
        --     if clCfg then
        --         max_level = clCfg.limitLv
        --     end
        -- else
        --     LogWarning('CfgCardCoreLv not find by quality:%s', cardCfg.quality)
        -- end

        bCfgLimit = CfgCardBreakLimitLv[#CfgCardBreakLimitLv]
        max_level = bCfgLimit.MaxLv
        
        -- ]] v 5.0 end
    end

    return max_level
end

-- 根据 卡牌配置表-基础表 的突破模板id， 计算获得当前使用的突破id
function GCardCalculator:CalUseBreakId(base_id, break_level)
    return base_id + break_level - 1
end

-------------------------------------------------------------------------------------------------------------------
--
local PropertyAddCalArgs = {
    cal1 = {'attack', 'maxhp', 'defense'},
    cal2 = {'speed', 'crit_rate', 'crit', 'hit', 'resist', 'hot', 'np', 'sp', 'sp_race', 'sp_race2'},
    cal3 = {'bedamage', 'damage', 'becure', 'cure', 'damagePhysics', 'damageLight'},
    cal4 = {'attack_fixed', 'maxhp_fixed', 'defense_fixed'}
}

function TakePropertyAdd(ret, sumP1, sumP2, sumP3)
    -- cal1
    for _, pn in ipairs(PropertyAddCalArgs.cal1) do
        local val = GCalHelp:CheckGetVal(sumP1, 0, pn) + GCalHelp:CheckGetVal(sumP2, 0, pn)+ GCalHelp:CheckGetVal(sumP3, 0, pn)
        if val ~= 0 then
            -- LogDebug("cal %s val %s, %s", pn, ret[pn], (1 + val))
            GCalHelp:Multi(ret, pn, (1 + val))
        end
    end

    -- cal2
    for _, pn in ipairs(PropertyAddCalArgs.cal2) do
        local val = GCalHelp:CheckGetVal(sumP1, 0, pn) + GCalHelp:CheckGetVal(sumP2, 0, pn) + GCalHelp:CheckGetVal(sumP3, 0, pn)
        if val ~= 0 then
            -- LogDebug("cal %s val %s, %s", pn, ret[pn], (val))
            GCalHelp:Add(ret, pn, val)
        end
    end

    -- cal3
    for _, pn in ipairs(PropertyAddCalArgs.cal3) do
        local val = GCalHelp:CheckGetVal(ret, 0, pn) + GCalHelp:CheckGetVal(sumP1, 0, pn) + GCalHelp:CheckGetVal(sumP2, 0, pn) + GCalHelp:CheckGetVal(sumP3, 0, pn)
        if val ~= 0 then
            -- LogDebug("cal %s val %s, %s", pn, ret[pn], (1 + val))

            -- begin 2026-05-08
            -- 因为基础 cal3 这些属性都是添加百分之几，也包含了基础属性
            -- GCalHelp:Add(ret, pn, 1 + val)
            -- 替换为
            ret[pn] = 1 + val
            -- end
        end
    end

    -- cal4
    for idx, pn in ipairs(PropertyAddCalArgs.cal4) do
        local val = GCalHelp:CheckGetVal(sumP1, 0, pn) + GCalHelp:CheckGetVal(sumP2, 0, pn) + GCalHelp:CheckGetVal(sumP3, 0, pn)
        if val ~= 0 then
            -- LogDebug("cal %s val %s, %s", pn,  PropertyAddCalArgs.cal1[idx], (val))
            GCalHelp:Add(ret, PropertyAddCalArgs.cal1[idx], val)
        end
    end
end

local SumCalArgs = {
    cal1 = {'card_exp_add', 'plr_exp_add', 'gold_add'},
    cal2 = {'attack', 'maxhp', 'defense', 'speed', 'hot', 'np', 'sp'}
}

-- 计算卡牌等级基础属性和装备的属性和
-- cardCalResult ： CalLvlPropertys() 返回的结果
-- equipsCalResult ： CalEquipPropertys() 返回的结果
-- skillMap: 返回的卡牌技能，的结构 skillMap = { [skill_id1] = {}, [skill_id2] = {} }, 暂时只需要用到键值key技能id
function GCardCalculator:CalSumPropery(cardCalResult, equipsCalResult, skillMap, useSubTalents, haloInfo)
    -- LogTrace("GCardCalculator:CalSumPropery()")
    local ret = {}
    table.copy(cardCalResult, ret)
    -- LogTable(cardCalResult, "CalSumPropery cardCalResult")
    -- LogTable(useSubTalents, "CalSumPropery useSubTalents")
    -- LogTable(equipsCalResult, "GCardCalculator:CalSumPropery( equipsCalResult ):")
    local equipsProperty = nil
    if equipsCalResult then
        -- lifeBuf
        equipsProperty = equipsCalResult.baseVal
        for _, pn in ipairs(SumCalArgs.cal1) do
            local val = equipsProperty[pn]
            if val then
                GCalHelp:Add(ret, pn, val)
            end
        end
    else
        equipsCalResult = GEquipCalculator:CalEquipPropertys(nil)
        equipsProperty = equipsCalResult.baseVal
    end

    ret.skills = {}
    ret.eskills = equipsCalResult.eskills -- 装备技能列表

     -- v 4.1 CalPerformance() 函数修改
    local skillSumLevels = {}
    if skillMap then
        for id, v in pairs(skillMap) do
            local skillId = id
            local skillCfg = skill[skillId]
            if skillCfg and skillCfg.lv and skillCfg.main_type then
                table.insert(ret.skills, skillId)
                GCalHelp:Add(skillSumLevels, skillCfg.main_type, skillCfg.lv)

                if skillCfg.main_type == SkillMainType.CardTalent then
                    local qualityCfg = CfgMainTalentSkillUpgrade[ret.quality]
                    -- LogInfo("quality:%s, lv:%s", ret.quality, skillCfg.lv)
                    if qualityCfg then
                        local upCfg = qualityCfg.infos[skillCfg.lv]
                        if upCfg and upCfg.nAddSp then
                            GCalHelp:Add(ret, 'sp', upCfg.nAddSp)
                        -- LogInfo("===========================================================")
                        -- LogInfo("After add %s sp is %s", upCfg.nAddSp, ret.sp)
                        -- LogInfo("===========================================================")
                        end
                    end
                end
            end
        end
    end

    -- 加入装备技能
    for _, equipSkillId in ipairs(equipsCalResult.fightSkills or {}) do
        local cfg = CfgEquipSkill[equipSkillId]
        if cfg then
            local skillId = cfg.nGetSkillId
            local skillCfg = skill[skillId]
            if skillCfg and skillCfg.lv and skillCfg.main_type then
                table.insert(ret.skills, skillId)
                GCalHelp:Add(skillSumLevels, skillCfg.main_type, skillCfg.lv)
            end
        end
    end

    -- 加入专武技能 -- v 5.6 专武
    -- if not table.empty(cardCalResult.weaponFightSkills) then
    --     LogTable(cardCalResult.weaponFightSkills, "cardCalResult() cardCalResult.weaponFightSkills")
    -- end
    for _, skillId in ipairs(cardCalResult.weaponFightSkills or {}) do
        local skillCfg = skill[skillId]
        if skillCfg and skillCfg.lv and skillCfg.main_type then
            table.insert(ret.skills, skillId)
            GCalHelp:Add(skillSumLevels, skillCfg.main_type, skillCfg.lv)
        end        
    end

    -- 副本天赋技能
    local subTablentProperty = {}
    -- LogTable(useSubTalents, "useSubTalents:")
    for _, tId in pairs(useSubTalents or {}) do
        if tId > 0 then
            local stCfg = CfgSubTalentSkill[tId]
            if stCfg then
                if stCfg.nFightSkillId then
                    local skillCfg = skill[stCfg.nFightSkillId]
                    if skillCfg and skillCfg.lv and skillCfg.main_type then
                        table.insert(ret.skills, stCfg.nFightSkillId)
                        GCalHelp:Add(skillSumLevels, skillCfg.main_type, skillCfg.lv)
                    else
                        LogWarning('not find sub talent id nFightSkillId (%d) in skill cfg', stCfg.nFightSkillId)
                    end
                end

                -- 属性添加
                -- LogTable(stCfg.jPropertys, "stCfg.jPropertys:")
                if stCfg.jPropertys then
                    for _, proInfo in ipairs(stCfg.jPropertys) do
                        local proType, proValue = proInfo[1], proInfo[2]

                        -- 获取技能添加的属性点
                        local propertyName = CfgCardPropertyEnum[proType].sFieldName
                        -- LogDebug("Add %s, %f", propertyName, proValue)
                        GCalHelp:Add(subTablentProperty, propertyName, proValue)
                    end
                end
            else
                LogWarning('not find sub talent (id:%d) in CfgSubTalentSkill', tId)
            end
        end
    end


    -- 2026.2.27 v5.3新增，光环特效属性加成，只加在角色自己身上
    local haloEffectProperty = {}
    if haloInfo and next(haloInfo) then
        local cfgH = cfgHalo[haloInfo.cfgid]
        if cfgH then
            local haloLv = haloInfo.level or 1
            local hLvCfg = cfgH.infos[haloLv]
            if hLvCfg then
                local hEffCfg = cfgHaloEffect[hLvCfg.haloEffect]
                if hEffCfg then
                    haloEffectProperty = hEffCfg
                end
            end
        end
    end

    -- 拷贝一下到装备里面一起计算
    TakePropertyAdd(ret, equipsProperty, subTablentProperty, haloEffectProperty)

    ret.performance = GCardCalculator:CalPerformance(ret, skillSumLevels)

    -- 转化为整型
    for _, key in ipairs(SumCalArgs.cal2) do
        local val = ret[key]
        if val then
            ret[key] = math.floor(val)
        end
    end

    -- 从小到大排序
    table.sort(
        ret.skills,
        function(a, b)
            return a < b
        end
    )
    ret.passivBufIds = equipsCalResult.passivBufIds

    -- LogDebug("-------------------------------------------------------------")
    -- LogTrace("CalSumPropery ret:")
    -- LogTable(ret, "CalSumPropery ret:")

    -- LogDebug("ret.crit_rate:%s", ret.crit_rate)
    return ret
end

-- v 4.1 CalPerformance() 函数修改
-- skillSumLevels : { [skills.main_type] = 总等级 }
function GCardCalculator:CalPerformance(ret, skillSumLevels)
    skillSumLevels = skillSumLevels or {}

    -- print(string.format("GCardCalculator:CalPerformance skillSumLevel:%s", skillSumLevel))
    -- LogTable(ret, "GCardCalculator:CalPerformance")

    -- skillSumLevel1-5对应技能表类型的1-5，这个是最新的公式哈
    -- SkillMainType.CardNormal = 1 -- 卡牌一般技能
    -- SkillMainType.CardTalent = 2 -- 卡牌主天赋技能
    -- SkillMainType.CardSpecial = 3 -- 卡牌特殊技能
    -- SkillMainType.CardSubTalent = 4 -- 卡牌副天赋技能
    -- SkillMainType.Equip = 5 -- 装备技能

    if g_CalCardPerfArr then
        -- 攻击 耐久 防御 机动 暴伤 暴击 效果命中 效果抵抗 主动技能，特性，特殊技能，跃升天赋，装备技技能

        local arr = g_CalCardPerfArr
        local A, B, C, D, E, F, G, H, I, J, K, L, M, N = arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8], arr[9], arr[10], arr[11], arr[12], arr[13], arr[14] or 0
        
        local ssl1 = skillSumLevels[SkillMainType.CardNormal] or 3
        local ssl2 = skillSumLevels[SkillMainType.CardTalent] or 0
        local ssl3 = skillSumLevels[SkillMainType.CardSpecial] or 0
        local ssl4 = skillSumLevels[SkillMainType.CardSubTalent] or 0
        local ssl5 = skillSumLevels[SkillMainType.Equip] or 0
        local ssl6 = skillSumLevels[SkillMainType.Weapon] or 0

        local performance = ret.attack * A + ret.maxhp * B + ret.defense * C + (ret.speed - 100) * D 
                                + (ret.crit - 1.5) * E + ret.crit_rate * F + ret. hit * G  + ret.resist * H 
                                + (ssl1 - 3) * I + ssl2 * J + ssl3 * K + ssl4 * L + ssl5 * M + ssl6 * N
        return math.floor(performance)
    else
        local skillSumLevel = 0
        for _, sLv in pairs(skillSumLevels) do
            skillSumLevel = skillSumLevel + sLv
        end

        -- （攻击+生命*0.24+防御*6）/2+（速度-100）*8.6+（暴击伤害-1.5）*540+（暴击+效果命中+效果抵抗）*859+（技能等级-3）*24
        local performance =
            (ret.attack + ret.maxhp * 0.2 + ret.defense * 5) / 2 + (ret.speed - 100) * 8.6 + (ret.crit - 1.5) * 540 +
            (ret.crit_rate + ret.hit + ret.resist) * 859 +
            (skillSumLevel - 3) * 24

        -- LogDebug("skillSumLevel: %d, performance: %f", skillSumLevel, performance)
        return math.floor(performance)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- 计算冷却需要的时间
-- maxHot: 最高热值
-- curHot: 当前热值
-- level: 等级
-- breakLevel: 突破等级
-- quality: 品质
-- return : 秒数
function GCardCalculator:CalCardCoolTime(maxHot, curHot, level, breakLevel, quality)
    -- LogDebug("curHot:%s, level:%s, breakLevel:%s, quality:%s", curHot, level, breakLevel, quality)
    -- 热值消耗公式：（以数值给出公式为准）
    -- 卡牌冷却秒数=热值×等级修正×品质倍率×突破次数倍率×150
    -- 例如：卡牌品质SSR、突破次数4，等级95，热值为150，则需要消耗的秒数=150×1.5×1.3×1.5×150=65812.5秒；
    -- 结果取整后65812秒=1096分钟=18小时；
    if curHot >= maxHot then
        return 0
    end

    local val = maxHot - curHot

    local levelIndex = math.floor((level + 9) / 10)
    -- level从1 开始 1~10 要算出等于1
    local levelArg = GCalHelp:GetTbValeByKey(CfgCardCoolBoxLevelArg, levelIndex, 'fArg', 1)
    local qualityArg = GCalHelp:GetTbValeByKey(CfgCardCoolBoxQualityArg, quality, 'fArg', 1)
    local breakLevelArg = GCalHelp:GetTbValeByKey(CfgCardCoolBoxBreakLevelArg, breakLevel, 'fArg', 1)

    local seconds = g_CardCoolTimeBaseVal * levelArg * qualityArg * breakLevelArg * val
    -- LogDebug(
    --     "levelArg:%s, qualityArg:%s, breakLevelArg:%s, curHot:%s, g_CardCoolTimeBaseVal:%s",
    --     levelArg,
    --     qualityArg,
    --     breakLevelArg,
    --     curHot,
    --     g_CardCoolTimeBaseVal
    -- )
    return seconds
end

-------------------------------------------------------------------------------------------------------------------
-- 一次性计算返回总属性
-- 参数
-- cfgid ：配置id
-- level : 等级
-- intensify_level：强化等级
-- break_level : 突破等级
-- equips： CalEquipPropertys() 返回的结果, 没有填 nil
-- skillMap: 返回的卡牌技能，的结构, 没有填 nil
-- 使用的副天赋, 没有填 nil
-- isMonster： 是否是怪物
-- cl:核心等级
-- weapon_lv: 专武等级 -- v 5.6 专武
function GCardCalculator:CalPropertys(
    cfgid,
    level,
    intensify_level,
    break_level,
    equips,
    skillMap,
    useSubTalents,
    isMonster,
    cl,
    haloInfo,
    weapon_lv)
    
    local lvl_cals = GCardCalculator:CalLvlPropertys(cfgid, level, intensify_level, break_level, isMonster, cl, weapon_lv)
    --local equip_cals = GEquipCalculator:CalEquipPropertys(equips)
    local sum_cals = GCardCalculator:CalSumPropery(lvl_cals, equips, skillMap, useSubTalents, haloInfo)
    if equips then
        sum_cals.excludeSkills = self:GetExcludeSkills(equips)   
    end
    return sum_cals
end

function GCardCalculator:GetExcludeSkills(cardData)
    local rInfo = {}
    for _, skillId in ipairs(cardData.fightSkills or {}) do
        local cfg = g_CalExcludeSkillIds[skillId]
        if cfg then
            table.insert(rInfo, table.copy(cfg))
        end
    end
    return rInfo
end

--返回队伍的光环战力值加成
-- args:
-- orignPower: 没有加光环队伍的总战力
-- dataArr：卡牌数据数组 = {
--     [1] = {
--         data = {
--             id = 卡牌id,
--             attack= 0,
--             maxhp=0,
--             defense =0,
--             speed =0,
--             crit_rate =0,
--             crit =0,
--             hit =0,
--             damage =0,
--             resist =0,
--             haloInfo = {
--                 cfgid = 0,
--                 level = 0,
--                 curCoor = 0,
--                 equips = {
--                     sid = 0,
--                     cfgid = 0, 
--                     idx = 0,
--                     attrIdx = 0,
--                     attr = 0,
--                 }
--             }
--         },
--         col= 编队col,
--         row= 编队row,
--     }
-- }
-- rets: 光环战力加成，加成后的总战力
function GCardCalculator:GetTeamPowerAdd(orignPower, dataArr)
    local property = Halo:Calc(dataArr) --计算光环加成的具体数值

    local power = 0
    if property then
        for ix, v in ipairs(property) do --计算这一部分属性的战斗力
            if v.bInHalo then --受到光环加成的卡
                local old = GCardCalculator:CalPerformance(dataArr[ix].data) -- v 4.1 CalPerformance() 函数修改
                local new = GCardCalculator:CalPerformance(v.data)           -- v 4.1 CalPerformance() 函数修改
                local haloAddPower = (new - old)
                power = power + haloAddPower
            end
        end
    end

    power = math.floor(power)
    LogDebug("GCardCalculator:GetTeamPowerAdd() power:%s orignPower:%s, sum:%s", power, orignPower, orignPower + power)
    return power, orignPower + power
end

-- id: 自己的订单id
-- pay_type: PayType 枚举类型
-- channel: 玩家渠道
function GCardCalculator:GetPayOrderStrId(id, pay_type, channel)
    return string.format('%s_%s_%s', id, (PayTypeName[pay_type] or pay_type), (ChannelTypeName[channel] or channel))
end
