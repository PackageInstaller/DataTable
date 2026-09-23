-- 玩家能力基类
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_cfg)
    self.cfg = _cfg
end

function this:GetID()
    return self.cfg and self.cfg.id or 1
end

function this:GetCfg()
    return self.cfg
end

function this:SetLock(b)
    self.isLock = b
end
-- ==============================--
-- desc:是否已解锁（服务器发过来则代表已解锁）
-- time:2019-09-17 04:16:40
-- @return 
-- ==============================--
function this:GetIsLock()
    return self.isLock
end

-- 是否能解锁
function this:CanOpen()
    if (self.isLock) then
        local lockLv = self.cfg.open_lv or 0
        if (PlayerClient:GetLv() >= lockLv) then
            local perv_id = self:GetCfg().prev_id
            if (perv_id) then
                for i, v in ipairs(perv_id) do
                    local b = PlayerAbilityMgr:CheckIsOpen(v)
                    if (b) then
                        return false
                    end
                end
            end
            return true
        else
            return false
        end
    end
    return true
end

-- ==============================--
-- desc:获取等级
-- time:2019-09-17 04:01:34
-- @return 
-- ==============================--
function this:GetLv()
    if (self.cfg.type == AbilityType.SkillGroup) then
        local data = TacticsMgr:GetDataByID(self.cfg.active_id)
        return data:GetLv()
    else
        return 0
    end
end

function this:GetDesc()
    if (self.cfg.type == AbilityType.PlrProperty) then
        local cfg = Cfgs.CfgLifeBuffer:GetByID(self.cfg.active_id)
        return cfg and cfg.sDesc or ""
    elseif (self.cfg.type == AbilityType.building_open) then
        local cfg = Cfgs.CfgBuidingBase:GetByID(self.cfg.active_id)
        return cfg and cfg.desc[1] or ""
    elseif (self.cfg.type == AbilityType.SkillGroup) then
        if self.isLock then
            -- local cfg = Cfgs.CfgPlrAbility:GetByID(self.cfg.active_id)
            return self.cfg and self.cfg.desc or ""
        end
        local cfg = Cfgs.CfgPlrSkillGroupUpgrade:GetByID(self.cfg.active_id)
        local idx = self:GetLv() or 1
        if cfg then
            return (cfg.infos and cfg.infos[idx]) and cfg.infos[idx].desc or ""
        end

    end
    return ""
end

-- 属性值
function this:GetValue()
    local value = 0
    if (self.cfg.type == AbilityType.PlrProperty) then
        local cfg = Cfgs.CfgLifeBuffer:GetByID(self.cfg.active_id)
        if (cfg.nType == 33 or cfg.nType == 34) then
            -- 增加某些物品的数量或百分比
            LogError("出错：该buffer不会出现在玩家能力")
            value = 0
        else
            value = math.floor((cfg.jVal[1] * 100)) / 100
        end
    end
    return value
end

-- 属性描述
function this:GetPercent()
    local str = 0
    if (self.cfg.type == AbilityType.PlrProperty) then
        local cfg = Cfgs.CfgLifeBuffer:GetByID(self.cfg.active_id)
        str = self.cfg.valDesc
    end
    return str
end

-- --生活buf属性
-- function this:GetPercent()
-- 	local num = 0
-- 	if(self.cfg.type == AbilityType.PlrProperty) then
-- 		local cfg = Cfgs.CfgLifeBuffer:GetByID(self.cfg.active_id)
-- 		num = self.cfg.nVal
-- 	end
-- 	return num
-- end
-- ==============================--
-- desc:等级是否达到
-- time:2019-09-24 10:22:51
-- @args:
-- @return 
-- ==============================--
function this:LvEngough()
    return PlayerClient:GetLv() >= self:GetLv()
end

-- ==============================--
-- desc：升级消耗
-- time:2019-09-26 10:48:57
-- @args:
-- @return 
-- ==============================--
function this:GetCost()
    local num = 0
    if (self.cfg.type == AbilityType.SkillGroup) then
        local data = TacticsMgr:GetDataByID(self.cfg.active_id)
        num = data and data:GetCost() or 0
    end
    return num
end

-- 技能组
function this:GetSkills()
    local skills = {}
    local isMax = true
    local curLv = 1
    local maxLv = 1
    if (self:GetCfg().type == AbilityType.SkillGroup) then
        local group = TacticsMgr:GetDataByID(self:GetCfg().active_id)
        if (group) then
            isMax, maxLv = group:IsMaxLv()
            skills = group:GetSkills()
            curLv = group:GetLv()
        end
    end
    return skills, isMax, curLv, maxLv
end

-- 合并数值
function this:SetMaxValue(_maxValue)
    self.maxValue = _maxValue
end
function this:GetMaxValue()
    return self.maxValue or 0
end

return this
