-- 每一关的数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitCfg(_dungeonGroup8, isLock)
    self.cfg = _dungeonGroup8
    self.isLock = self.cfg.perLevel ~= nil
    self.retData = nil
end
-- 服务器数据
function this:InitData(_sRogueDuplicateData, isLock)
    self.retData = _sRogueDuplicateData
    self.isLock = isLock
end
function this:GetMaxRound()
    if (self.retData) then
        return self.retData.maxRound or 0
    end
    return 0
end
function this:GetMinSteps()
    if (self.retData) then
        return self.retData.minSteps or 0
    end
    return 0
end

function this:GetID()
    return self.cfg.id
end

function this:GetCfg()
    return self.cfg
end

-- 未解锁
function this:IsLock()
    return self.isLock
end

-- 图标
function this:GetIcon(isSelect)
    if (self:IsLock()) then
        return self.cfg.icon1
    end
    return isSelect and self.cfg.icon3 or self.cfg.icon2
end

-- 最大轮次
function this:GetLimitRound()
    if (not self.limitRount) then
        self.limitRount = 0
        for k, v in ipairs(self.cfg.diffNum) do
            self.limitRount = self.limitRount + v
        end
    end
    return self.limitRount
end

-- 当前轮的最高难度
function this:GetMaxChapterLevel(curRound)
    curRound = curRound or slef:GetRNum()
    local num = 0
    for k, v in ipairs(self.cfg.diffNum) do
        num = num + v
        if (num >= curRound) then
            return k
        end
    end
    return 1
end

-- 是否挑战中
function this:IsChallenge()
    return RogueMgr:CheckIsChallenge(self:GetID())
end

-- 可能遭遇的敌人（预览）
function this:GetMonsters()
    -- local curRound = self:GetRNum()
    -- local chapterLevel = self:GetMaxChapterLevel(curRound)
    local cfgs = {}
    local _cfgs = Cfgs.MainLine:GetGroup(RogueMgr:GetSectionID())
    for k, v in pairs(_cfgs) do
        if (v.dungeonGroup == self:GetID()) then
            table.insert(cfgs, v)
        end
    end
    local monsters = {}
    if (cfgs) then
        if (#cfgs > 1) then
            table.sort(cfgs, function(a, b)
                return a.id > b.id
            end)
        end
        for k, v in pairs(cfgs) do
            -- if (chapterLevel >= v.chapterLevel and v.enemyPreview~=nil) then
            for p, q in pairs(v.enemyPreview) do
                local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(q)
                table.insert(monsters, {
                    id = monsterGroupCfg.monster,
                    level = v.previewLv,
                    isBoss = v.chapterLevel==#self.cfg.diffNum
                })
            end
            -- end
        end
    end
    return monsters
end

-- 当前已通关轮次
function this:GetNum()
    if (self:IsChallenge()) then
        return RogueMgr:GetCurData().round - 1
    else
        return self:GetMaxRound()
    end
end

-- 当前进行中轮次(右侧)
function this:GetRNum()
    if (self:IsChallenge()) then
        return RogueMgr:GetCurData().round
    else
        local _round = self:GetMaxRound() + 1
        return _round > self:GetLimitRound() and self:GetLimitRound() or _round
    end
end

-- 是否已完成
function this:IsSuccess()
    return self:GetMaxRound() >= self:GetLimitRound()
end

return this
