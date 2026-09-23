local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:InitCfg(cfgId)
    self.cfg = Cfgs.cfgGlobalBoss:GetByID(cfgId)
    if self.cfg and self.cfg.dupId then
        self.dungeonCfg = Cfgs.MainLine:GetByID(self.cfg.dupId)
    end
end

function this:GetCfg()
    return self.cfg
end

--副本配置表数据
function this:GetDungeonCfg()
    return self.dungeonCfg
end

--对应章节id
function this:GetSectionID()
    return self.dungeonCfg and self.dungeonCfg.group
end

function this:GetID()
    return self.cfg and self.cfg.id
end

--最大挑战次数
function this:GetMaxCount()
    return self.cfg and self.cfg.challengeTimes
end

--动效路径名
function this:GetEffectName()
    return self.cfg and self.cfg.spriteWay
end

--图标路径名
function this:GetIcon()
    return self.cfg and self.cfg.BossPreview
end

function this:GetRankType()
    return self.cfg and self.cfg.rankType
end

function this:GetBuffIds()
    
    return self.cfg and self.cfg.buffId
end

function this:GetSkills()
    return self.cfg and self.cfg.skillId
end

function this:GetRanking()
    local cfg = Cfgs.cfgGlobalBossRanking:GetByID(self.cfg and self.cfg.rankRwdGroupId)
    return cfg and cfg.infos
end

function this:GetModelId()
    return self.cfg and self.cfg.modelId
end

function this:GetRankView()
    local sectionData = DungeonMgr:GetSectionData(self:GetSectionID())
    return sectionData and sectionData:GetRankView()
end

function this:GetRankListInfo()
    if self.cfg then
        return {{id = self.cfg.rankType,title = LanguageMgr:GetByID(70005),desc1 = LanguageMgr:GetByID(70014)},{id = self.cfg.killRwdGroupId,title = LanguageMgr:GetByID(70004),rankType = self.cfg.rankType},{id = self.cfg.rankRwdGroupId,title = LanguageMgr:GetByID(70006),rankType = self.cfg.rankType},{id = self.cfg.challengeRwdGroupId,title = LanguageMgr:GetByID(70007),rankType = self.cfg.rankType}}
    end
end

return this