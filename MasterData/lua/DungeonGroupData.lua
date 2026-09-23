local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:Init(cfg, isHard)
    self.cfg = cfg
    self.isHard = false
end

-- 设置困难
function this:SetHard(b)
    self.isHard = b
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetEnName()
    return self.cfg and self.cfg.enName or ""
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetPos()
    if self.cfg then
        local x = self.cfg.x or 0
        local y = self.cfg.y or 0
        return {
            x = x,
            y = y
        }
    end
    return {0, 0}
end

-- 按钮离中心点相对位置
function this:GetRelativePos()
    return self.cfg and self.cfg.relativePos
end

-- 线段转折点
function this:GetTurnPos()
    return self.cfg and self.cfg.turnPos
end

-- 返回包含副本关卡 isHard:困难模式
function this:GetDungeonGroups()
    if self.cfg then
        return self.isHard and self.cfg.hDungeonGroups or self.cfg.dungeonGroups
    end
    return nil
end

-- 返回关卡id组
function this:GetDungeonCfgIDs(level)
    level = level or 1
    if level == 1 then
        return self.cfg and self.cfg.dungeonGroups
    elseif level == 2 then
        return self.cfg and self.cfg.hDungeonGroups
    end
end

function this:GetDungeonCfgs(level)
    local ids = nil
    if level then
        ids = self:GetDungeonCfgIDs(level)
    else
        ids = self:GetDungeonGroups()
    end
    
    local cfgs = {}
    if ids and #ids > 0 then
        for i, v in ipairs(ids) do
            local cfg = Cfgs.MainLine:GetByID(v)
            if cfg then
                table.insert(cfgs, cfg)
            end
        end
    end
    -- if #cfgs > 0 then
    --     table.sort(cfgs, function(a, b)
    --         return a.id < b.id
    --     end)
    -- end
    return cfgs
end

-- 从关卡表获取关卡数据
function this:GetMainLines()
    local cfgs = {}
    local _cfgs = Cfgs.MainLine:GetGroup(self:GetGroup())
    for k, v in pairs(_cfgs) do
        if (v.dungeonGroup == self:GetID()) then
            table.insert(cfgs, v)
        end
    end
    return cfgs
end

function this:GetFirstDungeonCfg()
    local cfgs = self:GetDungeonCfgs()
    return cfgs and cfgs[1]
end

-- 获取星数
function this:GetStar()
    local groups = self:GetDungeonGroups()
    local cur, max = 0, 0
    if groups and #groups > 0 then
        for k, v in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(v)
            if dungeonData and not dungeonData:IsStory() then
                cur = cur + dungeonData:GetStar()
            end
            local cfgDungeon = Cfgs.MainLine:GetByID(v)
            if cfgDungeon and not cfgDungeon.sub_type then -- 关卡总星数
                max = max + 3
            end
        end
    end

    return cur, max
end

-- 获取通关数
function this:GetPassCount()
    local groups = self:GetDungeonGroups()
    local cur, max = 0, 0
    if groups and #groups > 0 then
        for k, v in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(v)
            if dungeonData and dungeonData:IsPass() then
                cur = cur + 1
            end
        end
        max = #groups
    end

    return cur, max
end

--包含指定关卡id
function this:HasDungeonId(id,level)
    level = level or 1
    local ids =self:GetDungeonCfgIDs(level)
    if ids and #ids > 0 then
        for i, v in ipairs(ids) do
            if id == v  then
                return true
            end
        end
    end
    return false
end

-- 返回当前是否开启
function this:IsOpen(level)
    local ids = nil
    if level then
        ids = self:GetDungeonCfgIDs(level)
    else
        ids = self:GetDungeonGroups()
    end
    if ids and ids[1] then
        return DungeonMgr:IsDungeonOpen(ids[1])
    end
    return false
end

-- 返回当前是否通关
function this:IsPass()
    local groups = self:GetDungeonGroups()
    if groups and #groups > 0 and DungeonMgr:IsDungeonOpen(groups[1]) then
        local count = 0
        for _, id in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(id)
            if dungeonData and dungeonData:IsPass() then
                count = count + 1
            end
        end
        if count == #groups then
            return true
        end
    end
    return false
end

-- 返回当前最新状态 isHard:困难模式
function this:IsCurrNew()
    return self:IsOpen() and not self:IsPass()
end

-- 困难
function this:IsHard()
    return self.isHard
end

function this:IsOpenTime()
    if self.cfg then
        if self.cfg.begTime then
            local sTime = TimeUtil:GetTimeStampBySplit(self.cfg.begTime)
            if sTime > TimeUtil:GetTime() then
                return false
            end
        end
        if self.cfg.endTime then
            local eTime = TimeUtil:GetTimeStampBySplit(self.cfg.endTime)
            if eTime <= TimeUtil:GetTime() then
                return false
            end
        end
    end
    return true
end

-----------------------------------------------plot-----------------------------------------------
function this:GetTargetJson()
    return self.cfg and self.cfg.target
end

function this:GetTargetContent(str,index)
    index = index or 1
    str = str or ""
    local infos = self:GetTargetJson()
    if infos and infos[index] then
        return infos[index][str]
    end
    return nil
end

function this:GetIcon()
    return self.cfg and self.cfg.icon or ""
end

function this:GetType()
    return self.cfg and self.cfg.type or 1
end

-----------------------------------------------TaoFa-----------------------------------------------
function this:GetBGPath()
    local name = self.cfg and self.cfg.bg or ""
    if name ~= "" then
        return "UIs/DungeonActivity/TaoFa/" .. name .. "/bg"
    end
    return nil
end

function this:GetVideoName()
    return self.cfg and self.cfg.video
end

function this:GetEffectName()
    return self.cfg and self.cfg.effect
end

function this:GetImgPath()
    local name = self.cfg and self.cfg.img or ""
    if name ~= "" then
        return "UIs/DungeonActivity/TaoFa/" .. name .. "/img"
    end
    return nil
end

function this:GetShowType()
    return self.cfg and self.cfg.showType or 1
end

function this:GetIcon()
    return self.cfg and self.cfg.icon
end

-----------------------------------------------积分-----------------------------------------------
function this:IsEx()
    return self.cfg and self.cfg.isEx
end

-- 基础分数
function this:GetPoints()
    return self.cfg and self.cfg.points
end

-- 词条组
function this:GetBuffs()
    local datas = {}
    if self.cfg and self.cfg.buffgroup and #self.cfg.buffgroup > 0 then
        local cfgs = nil
        for i, id in ipairs(self.cfg.buffgroup) do
            cfgs = Cfgs.CfgBuffBattle:GetGroup(id)
            if cfgs then
                for k, cfg in pairs(cfgs) do
                    table.insert(datas, cfg)
                end
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a.id < b.id
        end)
    end
    return datas
end

-----------------------------------------------TowerDeep-----------------------------------------------
function this:IsDiff()
    return self.cfg and self.cfg.difficulty ~= nil
end
-----------------------------------------------build-----------------------------------------------
--已建造
function this:IsBuild()
    local cfg = self:GetDungeonBuildCfg()
    local dungeonData = DungeonMgr:GetDungeonData(cfg and cfg.id or 0)
    return dungeonData and dungeonData:IsPass()
end

--存在建造的关卡
function this:GetDungeonBuildCfg()
    local cfgs = self:GetDungeonCfgs(1)
    if #cfgs > 0 then
        for i, v in ipairs(cfgs) do
            if v.type == eDuplicateType.Building then
                return v
            end
        end
    end
end

--建造图标
function this:GetBuildIcon()
    local cfg = self:GetDungeonBuildCfg()
    local dungeonData = DungeonMgr:GetDungeonData(cfg and cfg.id or 0)
    if cfg and cfg.UnlockBuildingID and dungeonData and dungeonData:IsPass() then
        local cfgBuilding = nil
        for i, v in ipairs(dungeonData:GetNGrade()) do
            if v == 2 then
                cfgBuilding = Cfgs.Building:GetByID(cfg.UnlockBuildingID[i])
                break
            end
        end
        if cfgBuilding then
            return cfgBuilding.MapIcon
        end
    end
end

return this;
