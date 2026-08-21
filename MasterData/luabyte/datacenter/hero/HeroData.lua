local M = BaseClass("HeroData", require("DataCenter.Hero.BaseHeroData"))

local CRoleAttr = CS.GameBase.CRoleAttr
local JHeroCore = CS.GameBase.JHeroCore
local JHeroBreak = CS.GameBase.JHeroBreak
local EAttributeType = CS.GameBase.EAttributeType
local tInsert = table.insert

function M:__init()
    self.m_have = false -- 是否拥有
    self.m_heroName = "" -- 英雄名字
    self.m_heroCfg = nil -- 英雄配置
    self.m_heroInfo = nil -- 英雄信息
    self.m_awakeLevel = -1 -- 觉醒等级
    self.m_genesStars = nil
    self.m_genesStarLevels = nil
    self.m_skinCfg = nil -- 英雄皮肤
    self.m_heroAllSkins = nil -- 英雄所有的皮肤
end

function M:SetHave(value)
    -- body
    self.m_have = value
end

function M:SetHeroInfo(info)
    -- body
    self:UpdateData(info)
end

function M:SetLevel(level)
    -- body
    self.m_heroInfo.Level = level
end

function M:SetBreakLevel(breakLevel)
    -- body
    self.m_heroInfo.Grade = breakLevel
end

function M:SetStarLevel(starLevel)
    -- body
    self.m_heroInfo.Star = starLevel
end

function M:SetCoreLevel(coreLevel)
    -- body
    self.m_heroInfo.CoreLevel = coreLevel
end

function M:SetSkillLevel(level)
    -- body
    self.m_heroInfo.SkillLevel = level
end

function M:IsHave()
    -- body
    return self.m_have
end

function M:GetHeroCfg()
    -- body
    return self.m_heroCfg
end

function M:GetHeroId()
    if not self.m_heroCfg then return 0 end
    return self.m_heroCfg.id
end

function M:GetLevel()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Level
end

-- 星级
function M:GetStarLevel()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Star
end

-- 突破等级
function M:GetBreakLevel()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Grade
end

-- 时装
function M:GetFashion()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Fashion
end

-- 武器
function M:GetWeaponId()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Weapon
end

-- 饱食度
function M:GetRemaintEater()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Eater
end

-- 故事进度
function M:GetStory()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.Story
end

-- 核心等级
function M:GetCoreLevel()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.CoreLevel
end

-- 技能等级
function M:GetSkillLevel()
    if not self.m_heroInfo then return 0 end
    return self.m_heroInfo.SkillLevel
end

function M:GetRoleStudioHeroData()
    local heroId = self:GetHeroId()
    return IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
end

-- 获得觉醒等级
function M:GetAwakeLevel()
    if self.m_awakeLevel < 0 then
        local heroId = self:GetHeroId()
        local breakLv = self:GetBreakLevel()
        local breakCfg = JHeroBreak.GetBreakByHeroLevel(heroId, breakLv)
        if breakCfg then
            self.m_awakeLevel = breakCfg.awaken
        else
            self.m_awakeLevel = 0
        end
    end

    return self.m_awakeLevel
end

function M:GetHeroBreak()
    local heroId = self:GetHeroId()
    local breakLv = self:GetBreakLevel()
    return JHeroBreak.GetBreak(heroId, breakLv)
end

function M:GetHeroCore()
    local heroId = self:GetHeroId()
    local coreLv = self:GetCoreLevel()
    return JHeroCore.GetHeroCore(heroId, coreLv)
end

--所有词条
function M:GetAllKeywords()
    local heroCondition = {}
    local heroId = self:GetHeroId()
    local breakLv = self:GetBreakLevel()
    local heroBreakCfg = JHeroBreak.GetBreak(heroId, breakLv)
    if not IsNull(heroBreakCfg.mapCondition) then
        for i = 0, heroBreakCfg.mapCondition.Length - 1 do
            tInsert(heroCondition, heroBreakCfg.mapCondition[i])
        end
    end

    local coreLv = self:GetCoreLevel()
    local heroCoreCfg = JHeroCore.GetHeroCore(heroId, coreLv)
    if not IsNull(heroCoreCfg.mapCondition) then
        for i = 0, heroCoreCfg.mapCondition.Length - 1 do
            tInsert(heroCondition, heroCoreCfg.mapCondition[i])
        end
    end
    return heroCondition
end

function M:GetOrder()
    if not self.m_heroCfg then return 0 end
    return self.m_heroCfg.order
end

function M:IsShowGirl()
    if not self.m_heroCfg then return 0 end
    return self.m_heroCfg.ifMain
end

function M:GetShowStar()
    if not self.m_heroCfg then return 0 end
    return self.m_heroCfg.showStar
end

function M:GetHeroName()
    -- body
    return self.m_heroName
end

function M:GetRoleCfg()
    if not self.m_heroCfg then return nil end
    return self.m_heroCfg.BaseRole
end

function M:UpdateData(heroInfo)
    if not self.m_heroInfo then self.m_heroInfo = {} end
    self.m_heroInfo.HeroId = heroInfo.HeroId
    self.m_heroInfo.ExpireTime = heroInfo.ExpireTime
    self.m_heroInfo.Fashion = heroInfo.Fashion
    self.m_heroInfo.Weapon = heroInfo.Weapon
    self.m_heroInfo.Level = heroInfo.Level
    self.m_heroInfo.Grade = heroInfo.Grade
    self.m_heroInfo.Happy = heroInfo.Happy
    self.m_heroInfo.Star = heroInfo.Star
    self.m_heroInfo.CoreLevel = heroInfo.CoreLevel
    self.m_heroInfo.SkillLevel = heroInfo.SkillLevel
    self.m_heroInfo.Story = heroInfo.Story
    self.m_heroInfo.Eater = heroInfo.Eater
    self.m_heroInfo.Garison = heroInfo.Garison
    self.m_heroInfo.Misc = heroInfo.Misc
end

function M:UpdateTrainingData(level, breakLevel)
    self.m_heroInfo.Level = level
    self.m_heroInfo.Grade = breakLevel
end

---@return integer
function M:GetAttribute(eType)
    if not self.m_heroCfg then return 0 end
    return self.m_heroCfg:GetAttribute(eType)
end

---@return integer
function M:GetAddAttribute(eType)
    -- body
    return self:GetAttribute(eType)
end

---@return integer
function M:CompareTo(other)
    if not other then
        Logger.LogError("HeroData 比较参数为空")
        return -1
    end
    local currentFee = self:GetAttribute(EAttributeType.EAT_Summon)
    local otherFee = other:GetAttribute(EAttributeType.EAT_Summon)
    if currentFee == otherFee then
        return 0
    elseif currentFee < otherFee then
        return 1
    else
        return -1
    end
end

function M:GetDevelopAttribute(eType, level, breakCfg, coreCfg)
    -- 升级
    local curAttr = CRoleAttr(self.m_heroCfg, level)
    local finalVal = curAttr[eType]
    local iType = eType:ToInt()

    -- 突破
    if breakCfg and breakCfg.Attributes then
        for i = 0, breakCfg.Attributes.Length - 1, 1 do
            if breakCfg.Attributes[i].AttributeId == iType then
                finalVal = finalVal + breakCfg.Attributes[i].AttributeVal
                break
            end
        end
    end

    -- 核心
    if coreCfg and coreCfg.attributeType then
        for i = 0, coreCfg.attributeType.Length - 1, 1 do
            if coreCfg.attributeType[i] == iType then
                finalVal = finalVal + coreCfg.attributeValue[i]
                break
            end
        end
    end
    return finalVal
end

-- 获取该英雄的皮肤配置
function M:GetSkinCfg()
    if not self.m_skinCfg then return 0 end
    return self.m_skinCfg
end

-- 获取该英雄的皮肤id
function M:GetSkinId()
    if not self.m_skinCfg then return 0 end
    return self.m_skinCfg.id
end

-- 获取该英雄所有的皮肤
function M:GetHeroAllSkins()
    if not self.m_heroAllSkins then return nil end
    return self.m_heroAllSkins
end

---@param heroGenesInfo any  RoleHeroGenes 更新基因相关信息
function M:UpdateGenes(heroGenesInfo)
    self.m_genesStars = Json.decode(heroGenesInfo.Stars)
    self.m_genesStarLevels = Json.decode(heroGenesInfo.Levels)
end

-- 更新基因星级
function M:UpdateGenesStar(slot, star)
    if slot == 0 then return end

    if not self.m_genesStars then
        self.m_genesStars = {}
    end

    if #self.m_genesStars < slot then
        for i = 1, slot, 1 do
            if not self.m_genesStars[i] then
                tInsert(self.m_genesStars, 0)
            end
        end
    end

    self.m_genesStars[slot] = star
end

-- 更新基因等级
function M:UpdateGenesLevel(slot, level)
    if slot == 0 then return end

    if not self.m_genesStarLevels then
        self.m_genesStarLevels = {}
    end

    if #self.m_genesStarLevels < slot then
        for i = 1, slot, 1 do
            if not self.m_genesStarLevels[i] then
                tInsert(self.m_genesStarLevels, 0)
            end
        end
    end

    self.m_genesStarLevels[slot] = level
end

return M
