local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

-- sRandLevels
function this:Init(_index, _sRandLevels)
    self.index = _index
    self.data = _sRandLevels
end

function this:GetSelectType()
    return 2
end

function this:GetIDs()
    return self.data.dupIds
end

function this:GetDungeonData(pos)
    if (self:GetIDs()[pos]) then
        return DungeonMgr:GetDungeonData(self:GetIDs()[pos])
    end
    return nil
end

function this:GetStar(pos)
    if (self.data ~= nil) then
        local _data = self:GetDungeonData(pos)
        if (_data) then
            return _data:GetStar()
        end
    end
    return 0
end

function this:GetStars()
    local star1 = self:GetStar(1)
    local star2 = self:GetStar(2)
    local star3 = self:GetStar(3)
    return {star1, star2, star3, (star1 + star2 + star3)}
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

-- 当前回合是否已通关
function this:LvIsPass()
    for k = 1, 3 do
        if (self:IsPass(k)) then
            return true
        end
    end
    return false
end

function this:GetPassID()
    local ids = self:GetIDs()
    for k = 1, 3 do
        if (self:IsPass(k)) then
            return ids[k]
        end
    end
    return nil
end

-- 上一回合的位置，和连接到本回合的透明度
function this:GetPerIndex()
    local alpha = self:LvIsPass() and 1 or 0.3
    return ColosseumMgr:GetPassIndex(self.data.idx - 1), alpha
end

-- (保存的路线也算)
function this:GetPassIndex()
    local selectId = self.data.selectId
    local ids = self:GetIDs()
    for k = 1, 3 do
        if (selectId) then
            if (ids[k] == selectId) then
                return self.index == 9 and 2 or k
            end
        else
            if (self:IsPass(k)) then
                return self.index == 9 and 2 or k
            end
        end
    end
    return nil
end

----------------------------------公共-----------------------------------------
-- 子项(不一定是3个) 
function this:GetChildDatas()
    local childDatas = {}
    if (self.data == nil) then
        local len = self.index == 9 and 1 or 3
        for k = 1, len do
            table.insert(childDatas, {nil, 1, false})
        end
    else
        local ids = self:GetIDs()
        local idx = ColosseumMgr:GetRandomCurIdx2()
        local isOver = ColosseumMgr:CheckRandomIsOver()
        for k, v in ipairs(ids) do
            -- 
            local cfg = Cfgs.MainLine:GetByID(v)
            --
            local alpha = 0.5 -- 为1条件：已通关;当前回合（未结束，如果有路线则仅路线，否则全部亮）;
            if (self:IsPass(k) or
                (not isOver and self.data.idx == idx and (not self.data.selectId or v == self.data.selectId))) then
                alpha = 1
            end
            local isOpen = true -- 大于当前回合且不是线路上的
            if (self.data.idx > idx and (not self.data.selectId or v ~= self.data.selectId)) then
                isOpen = false
            end
            table.insert(childDatas, {cfg, alpha, isOpen})
        end
    end
    return childDatas
end

-- 上中下三根线的高亮（前置关卡已通） 透明度
function this:GetLineDatas()
    local isLine2, lineDatas = true, {0, 0, 0, 0, 0, 0, 0, 0, 0}
    if (self.data == nil) then
        if (self.index == 9) then
            lineDatas[5] = 1
        else
            isLine2 = false
        end
    else
        local ids = self:GetIDs()
        if (#ids == 1) then
            lineDatas[5] = 1
        else
            local perIndex = self:GetPerIndex()
            local num = (perIndex - 1) * 3
            if (self:GetPassIndex()) then
                local curIndex = self:GetPassIndex()
                lineDatas[num + curIndex] = 1
            else
                lineDatas[num + 1] = 1
                lineDatas[num + 2] = 1
                lineDatas[num + 3] = 1
            end
        end
    end
    return isLine2, lineDatas
end

return this
