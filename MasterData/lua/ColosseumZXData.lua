local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_index, _cfgs)
    self.index = _index
    self.cfgs = _cfgs
end

function this:GetSelectType()
    return 1
end

function this:GetDungeonData(pos)
    local cfg = self.cfgs[pos]
    if (cfg) then
        return DungeonMgr:GetDungeonData(cfg.id)
    end
    return nil
end

function this:GetStar(pos)
    local _data = self:GetDungeonData(pos)
    if (_data) then
        return _data:GetStar()
    end
    return 0
end

function this:GetStars()
    local star1 = self:GetStar(1)
    local star2 = self:GetStar(2)
    local star3 = self:GetStar(3)
    return {star1, star2, star3, (star1 + star2 + star3)}
end

-- 是否显示item
function this:NeedShow(pos)
    if (self.index == 1) then
        return true
    end
    if (self:IsPass(pos)) then
        return true
    end
    local perIDs = self.cfgs[pos].preChapterID
    if (perIDs) then
        local perData = DungeonMgr:GetDungeonData(perIDs[1])
        if (perData and perData:IsPass()) then
            return true
        end
    end
    return false
end

function this:NeedShows()
    if (self.index == 1) then
        return true
    end
    for pos = 1, 3 do
        if (self:NeedShow(pos)) then
            return true
        end
    end
    return false
end

function this:IsPass(pos)
    local _data = self:GetDungeonData(pos)
    if (_data and _data:IsPass()) then
        return true
    end
    return false
end
function this:IsPasss()
    return {self:IsPass(1), self:IsPass(2), self:IsPass(3)}
end

-- 前置是否已通关
function this:PerIsPass(pos)
    local perIDs = self.cfgs[pos].preChapterID
    if (perIDs) then
        local perData = DungeonMgr:GetDungeonData(perIDs[1])
        if (perData and perData:IsPass()) then
            return true
        end
    end
    return false
end

----------------------------------公共-----------------------------------------
-- 3个子项   表，透明度,已解锁
function this:GetChildDatas()
    local childDatas = {}
    for k, v in ipairs(self.cfgs) do
        local alpha = 0.5 -- 第一回合,已通关，上一回合已通关 时为1
        if (self.index == 1 or self:IsPass(k) or self:PerIsPass(k)) then
            alpha = 1
        end
        local isOpen = alpha == 1
        table.insert(childDatas, {v, alpha, isOpen})
    end
    return childDatas
end

-- 上中下三根线的高亮（前置关卡已通）
function this:GetLineDatas()
    local isLine2, lineDatas = true, {1, 0, 0, 0, 1, 0, 0, 0, 1}
    -- if (self.index > 1) then
    --     lineDatas[1] = self:IsPass(1) and 1 or 0
    --     lineDatas[4] = self:IsPass(2) and 1 or 0
    --     lineDatas[7] = self:IsPass(2) and 1 or 0
    -- end
    return isLine2, lineDatas
end

return this
