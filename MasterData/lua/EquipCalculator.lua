-- OPENDEBUG()
-- 计算卡牌的属性
GEquipCalculator = {}

-------------------------------------------------------------------------------------------------------------------
-- 根据类型和等级返回装备的技能id
function GEquipCalculator:GetEquipSkillId(nType, nLevel)
    return nType * 100 + nLevel
end

-------------------------------------------------------------------------------------------------------------------
-- 计算装备的属性
-- 返回一个装备的计算属性
-- 参数：
-- -- --equips : array|obj （装备数组）
-- -- -- obj ={
-- -- -- -- cfgid: 装备的配置id
-- -- -- -- level: 装备等级
-- -- -- -- skills: 装备技能id数组
-- -- -- }
-- 返回
-- local ret = {
--     baseVal = {}, -- 基础属性点
--     propertySkills = {}, -- 添加属性的技能
--     fightSkills = {} -- 战斗使用的技能
--     passivBufIds = {} -- 被动BufferId
--     upSkills = {} -- 激活的所有技能（暂时统计用）
-- }
-- 例如：
--  CalEquipPropertys ret:
--      {
--          [ "skillVal" ]s =
--          {
--              [ 103 ]n = [ 5 ]f
--              [ 101 ]n = [ 16 ]f
--              [ 217 ]n = [ 3 ]f
--          }
--          [ "propertySkills" ]s =
--          {
--              [ 1 ]n = [ 10102 ]f
--          }
--          [ "fightSkills" ]s =
--          {
--
--          }
--          [ "baseVal" ]s =
--          {
--              [ "attack" ]s = [ 0.21 ]f
--          }
--      }
-- 基础属性
local cfgBasequipPropertys = {
    {
        type = "nBase1",
        value = "fBaseVal1",
        add = "fBaseAdd1"
    },
    {
        type = "nBase2",
        value = "fBaseVal2",
        add = "fBaseAdd2"
    }
}



function GEquipCalculator:IsEquipSkillLock(equip,idx,skillId)
    local baseId, lv = GCalHelp:GetEquipBaseIdAndLv(skillId)
    local cfg = CfgEquip[equip.cfgid]
    if cfg then
        local limitLv = cfg.randSkillsCondition and cfg.randSkillsCondition[idx] or 0
        if equip.level >= limitLv then
            return false
        end
    end
    return true
end



function GEquipCalculator:CalEquipPropertys(equips,isJapanSvr)
    local ret = {
        baseVal = {}, -- 基础属性点
        propertySkills = {}, -- 添加属性的技能
        fightSkills = {}, -- 战斗使用的技能
        passivBufIds = {}, -- 被动BufferId
        upSkills = {}, -- 激活的所有技能（暂时统计用）
        eskills = {}-- 全部技能
    }
    
    if not equips or #equips < 1 then
        return ret
    end
    
    local equipIds = {}
    
    -- 遍历所有装备
    for _, equip in pairs(equips) do
        local cfg = CfgEquip[equip.cfgid]
        ASSERT(cfg)
        
        -- 遍历基础属性
        for _, v in pairs(cfgBasequipPropertys) do
            local effectLv = cfg.base1Condition or 0
            if not isJapanSvr or (v.type == "nBase1" and equip.level >= effectLv) then
                -- 取出配置表，配置的属性id
                local propertyIndex = cfg[v.type]
                if propertyIndex then
                    -- 根据属性id取到属性的名字
                    local propertyEnumInfo = CfgCardPropertyEnum[propertyIndex]
                    if propertyEnumInfo then
                        -- 根据名字，累计属性点
                        local propertyName = propertyEnumInfo.sFieldName
                        GCalHelp:Add(ret.baseVal, propertyName, cfg[v.value] + equip.level * cfg[v.add])
                    else
                        LogError(
                            "Unknow equip property from CfgEquip %s, type %s, propertyIndex %s",
                            equip.cfgid,
                            v.type,
                            propertyIndex
                    )
                    end
                end
            end
        end
        
        if equip.skills then
            if isJapanSvr then
                for i, skillId in ipairs(equip.skills) do
                    if not self:IsEquipSkillLock(equip,i,skillId) then
                        local baseId, lv = GCalHelp:GetEquipBaseIdAndLv(skillId)
                        GCalHelp:Add(equipIds, baseId, lv)
                    end
                end
            else
                for _, skillId in pairs(equip.skills) do
                    local baseId, lv = GCalHelp:GetEquipBaseIdAndLv(skillId)
                    GCalHelp:Add(equipIds, baseId, lv)
                end
            end
        end
    end
    
    -- LogTable(equipIds, "GEquipCalculator equipIds:")
    -- 查看技能
    for baseId, sumLv in pairs(equipIds) do
        
        local baseCfg = CfgEquipSkill[baseId]
        if baseCfg then
            if sumLv > baseCfg.maxLv then
                sumLv = baseCfg.maxLv
            end
            
            local skillId = baseId + sumLv - 1
            
            -- 保存所有装备技能
            table.insert(ret.eskills, skillId)
            -- LogDebug("skillId:%s = baseId:%s + sumLv:%s -1, maxLv:%s", skillId, baseId, sumLv, baseCfg.maxLv)
            -- 得到最大等级的技能
            local useEquipSkillCfg = CfgEquipSkill[skillId]
            
            if useEquipSkillCfg then
                if useEquipSkillCfg.nType == EquipSkillType.Property then -- 属性技能
                    ret.upSkills[useEquipSkillCfg.id] = 1
                    table.insert(ret.propertySkills, useEquipSkillCfg.id)-- propertySkills, 外边暂时没有用到，属性在下边 177 行直接加了
                elseif useEquipSkillCfg.nType == EquipSkillType.Fight then -- 战斗技能
                    if useEquipSkillCfg.nGetSkillId then
                        ret.upSkills[useEquipSkillCfg.id] = 1
                        table.insert(ret.fightSkills, useEquipSkillCfg.id)
                    end
                elseif useEquipSkillCfg.nType == EquipSkillType.LifeBuf then -- 生活buf
                    local buffId = useEquipSkillCfg.nGetSkillId
                    if buffId then
                        local buffCfg = CfgLifeBuffer[buffId]
                        if buffCfg then
                            if buffCfg.jValiTime or buffCfg.jOpenDups then
                                ret.upSkills[useEquipSkillCfg.id] = 1
                                table.insert(ret.passivBufIds, buffCfg.id)
                            else
                                if buffCfg.jVal then
                                    ret.upSkills[useEquipSkillCfg.id] = 1
                                    local propertyName = CfgCardPropertyEnum[buffCfg.nType].sFieldName
                                    GCalHelp:Add(ret.baseVal, propertyName, buffCfg.jVal[1])
                                end
                            end
                        else
                            LogWarning("buff skill id %d not find in CfgLifeBuffer", useEquipSkillCfg.nGetSkillId)
                        end
                    end
                else
                    LogError("GEquipCalculator:CalPropertys equip cfg %d nType unknow.", useEquipSkillCfg.id)
                end
                
                -- 获取技能添加的属性点
                if useEquipSkillCfg.nGetBaseType and useEquipSkillCfg.fGetBaseVal then
                    local propertyName = CfgCardPropertyEnum[useEquipSkillCfg.nGetBaseType].sFieldName
                    GCalHelp:Add(ret.baseVal, propertyName, useEquipSkillCfg.fGetBaseVal)
                end
            end
        end
    end
    -- LogTable(equips, "CalEquipPropertys equips:")
    -- LogTable(ret, "CalEquipPropertys ret:")
    return ret
end

-------------------------------------------------------------------------------------------------------------------
-- 根据 星级 和 等级获取 CfgEquipExp 的配置
function GEquipCalculator:GetEquipExpCfg(quality, level)
    local oneStartCfg = CfgEquipExp[quality]
    if not oneStartCfg then
        LogWarning("Not %d quality config from CfgEquipExp", quality)
        return nil
    end
    
    local nextLevel = level + 1
    local upgradeCfg = oneStartCfg.tInfos[nextLevel]
    if not upgradeCfg then
        LogWarning("Not %d quality %d level config from CfgEquipExp", quality, nextLevel)
        return nil
    end
    return upgradeCfg
end
