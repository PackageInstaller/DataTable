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
function this:InitData(_sRogueSDuplicateData, isLock)
    self.retData = _sRogueSDuplicateData
    self.isLock = isLock
    --
    if (self.oldIsLock ~= nil and self.oldIsLock and not isLock) then
        self.isUnLock = true -- 在线期间发生解锁
    end
    self.oldIsLock = isLock
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

-- 星数
function this:GetStars()
    local cur = self.retData and self.retData.stars or 0
    return cur, 3 -- todo 
end

-- 条件完成 数组
function this:GetStarData()
    return self.retData and self.retData.star_data or {0, 0, 0}
end

-- 关卡列表
function this:GetMainLines()
    local cfgs = {}
    local _cfgs = Cfgs.MainLine:GetGroup(self:GetCfg().group)
    for k, v in pairs(_cfgs) do
        if (v.dungeonGroup == self:GetID()) then
            table.insert(cfgs, v)
        end
    end
    return cfgs
end

-- 是否已通关
function this:IsPass()
    return self.retData ~= nil
end

function this:CheckIsUnLock()
    return self.isUnLock
end
function this:SetIsUnLock(b)
    self.isUnLock = b
end


return this
