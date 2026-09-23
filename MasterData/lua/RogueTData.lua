-- 关卡组的数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitCfg(_dungeonGroup9)
    self.cfg = _dungeonGroup9
    self.retData = nil
end
-- 服务器数据
function this:InitData(_sRogueDuplicateData)
    self.retData = _sRogueDuplicateData
end

function this:GetID()
    return self.cfg.id
end

function this:GetCfg()
    return self.cfg
end

-- 未解锁
function this:IsLock()
    return false -- todo
end

-- 是否挑战中
function this:IsChallenge()
    return RogueMgr:CheckIsChallenge(self:GetID())
end

-- 可能遭遇的敌人（预览） 无限血关
function this:GetMonsters()
    local monsters = {}
    local cfg = Cfgs.MainLine:GetByID(self:GetInfinityID())
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfg.enemyPreview[1])
    -- local _monsters = monsterGroupCfg.monsters or {}
    for k, v in ipairs(monsterGroupCfg.stage) do
        for p, q in ipairs(v.monsters) do
            local monsterCfg = Cfgs.MonsterData:GetByID(q)
            table.insert(monsters, {
                id = q,
                -- level = mainLineCfg.previewLv,
                isBoss = monsterCfg.isboss==1
            })
        end
    end
    if(#monsters>1)then 
        table.sort(monsters,function (a,b)
            if(a.isBoss~=b.isBoss)then 
                return a.isBoss
            else 
                return a.id > b.id
            end 
        end)
    end 
    return monsters
end

-- 关卡组
function this:GetMonsters2()
    local cfgs = {}
    local _cfgs = Cfgs.MainLine:GetGroup(RogueTMgr:GetSectionID())
    for k, v in pairs(_cfgs) do
        if (v.dungeonGroup == self:GetID() and not v.isInfinity) then
            table.insert(cfgs, v)
        end
    end
    local monsters = {}
    if (cfgs) then
        -- if (#cfgs > 1) then
        --     table.sort(cfgs, function(a, b)
        --         return a.id > b.id
        --     end)
        -- end
        for k, v in pairs(cfgs) do
            for p, q in pairs(v.enemyPreview) do
                local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(q)
                local monsterCfg = Cfgs.MonsterData:GetByID(monsterGroupCfg.monster)
                table.insert(monsters, {
                    id = monsterGroupCfg.monster,
                    level = v.previewLv,
                    isBoss = monsterCfg.isboss==1
                })
            end
        end
        if(#monsters>1)then 
            table.sort(monsters,function (a,b)
                if(a.isBoss~=b.isBoss)then 
                    return a.isBoss
                else 
                    return a.id > b.id
                end 
            end)
        end 
    end
    return monsters
end

function this:SetUseBuff(idx)
    self.retData = self.retData or {}
    self.retData.useBuff = idx
end
function this:GetUseBuff()
    return self.retData and self.retData.useBuff
end

-- 当前难道总积分
function this:GetScore()
    return self.retData and self.retData.maxScore or 0
end

-- 存档buff
function this:GetBuffs()
    return self.retData and self.retData.buffs or {}
end

function this:GetBuffsDic()
    local dic = {}
    local buffs = self:GetBuffs()
    for k, v in pairs(buffs) do
        dic[v.idx] = v
    end
    return dic
end
-- 无限血关是否已开启
function this:CheckInfinityIsPass()
    return self.retData and self.retData.pass or false
end

-- 是否使用buff
function this:GetUseBuffIdx()
    return self.retData and self.retData.useBuff or false
end

-- 是否首通
function this:CheckIsFirstPass()
    return self.retData and self.retData.firstPassReward or false
end

-- 是否有无限血关
function this:IsisInfinity()
    return self:GetCfg().isisInfinity
end

-- 无限血关id
function this:GetInfinityID()
    if (not self:IsisInfinity()) then
        return nil
    end
    if (self.infinityID) then
        return self.infinityID
    end
    local cfgs = Cfgs.MainLine:GetGroup(self:GetCfg().group)
    for k, v in pairs(cfgs) do
        if (v.dungeonGroup == self:GetCfg().id and v.isInfinity) then
            self.infinityID = v.id
            break
        end
    end
    return self.infinityID
end

-- 获取可用的存档下标（达到上限时替换第一条）
function this:GetCanUseIdx()
    local cur, max = 0, self:GetCfg().archiveMax
    local indexs = {}
    local dic = self:GetBuffsDic()
    for k = 1, max do
        if (not dic[k]) then
            table.insert(indexs, k)
        end
    end
    if (#indexs > 1) then
        table.sort(indexs, function(a, b)
            return a < b
        end)
    end
    local index = indexs[1] or 1
    return #indexs <= 0, index
end

function this:RogueTDelBuffRet(idx)
    local buffs = self:GetBuffs()
    for k, v in pairs(buffs) do
        if (v.idx == idx) then
            table.remove(buffs, k)
            break
        end
    end
end

return this
