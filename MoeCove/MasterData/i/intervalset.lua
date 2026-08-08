
local IntervalSet = {}


function IntervalSet.DateStrStateFunc(a, b, diff)
    if diff then
        return luautil.getDateStrByDateStr(a, diff)
    else
        return luautil.getDateStrDayDiff(a, b)
    end

    -- if a == b then
    --     return 0
    -- end

    -- if a < b then
    --     return -1
    -- end

    -- if luautil.getDateStrDayDiff(a, b) == 1 then
    --     return 2
    -- end

    -- if a > b then
    --     return 1
    -- end
end

local function _defaultStateFunc(a, b, diff)
    -- if a == b then
    --     return 0
    -- end

    -- if a < b then
    --     return -1
    -- end

    -- if a - b == 1 then
    --     return 2
    -- end

    -- if a > b then
    --     return 1
    -- end
    if diff then
        return a + diff
    else
        return a - b
    end
end

local function _sortData(set, stateFunc)
    table.sort(set, function (a, b)
        local a1,a2 = a[1],a[2]
        local b1,b2 = b[1],b[2]

        local state = stateFunc(a1, b1)
        if state ~= 0 then
            return state < 0
        end

        state = stateFunc(a2, b2)
        if state ~= 0 then
            return state < 0
        end

        return false
    end)
end

function IntervalSet.doUnion(set, stateFunc)
    if not stateFunc then
        stateFunc = _defaultStateFunc
    end

    _sortData(set, stateFunc)

    local i = 1
    while i < #set do
        local a1,a2 = set[i][1],set[i][2]
        local b1,b2 = set[i+1][1],set[i+1][2]

        if stateFunc(a1, b1) == 0 then
            table.remove(set, i + 1)
            set[i][2] = stateFunc(a2, b2) > 0 and a2 or b2
        elseif stateFunc(b1, a2) == 1 then  -- 必然b1 > a2
            table.remove(set, i + 1)
            set[i][2] = stateFunc(a2, b2) > 0 and a2 or b2 -- 必定b2>a2但是用这个写法也对，以上三个if其实可以合为一个
        elseif stateFunc(a2, b1) >= 0 then  -- 必然a1 < b1
            table.remove(set, i + 1)
            set[i][2] = stateFunc(a2, b2) > 0 and a2 or b2
        else
            i = i + 1
        end
    end
end

function IntervalSet.unionWith(set, data, stateFunc)
    table.insert(set, data)
    IntervalSet.doUnion(set, stateFunc)
end

-- set与data的差集
function IntervalSet.diffWith(set, data, stateFunc)
    IntervalSet.doUnion(set, stateFunc)

    local newSet = {}
    local b1,b2 = data[1],data[2]
    local min,max = b1,b2
    for i,v in ipairs(set) do
        local a1,a2 = v[1],v[2]
        if min < a1 then
            if max < a1 then
                table.insert(newSet, {min, max})
                min = nil
                break
            else
                table.insert(newSet, {min, stateFunc(a1, nil, -1)})
                if max > a2 then
                    min = stateFunc(a2, nil, 1)
                else
                    min = nil
                    break
                end
            end
        else -- min >= a1
            if max <= a2 then
                min = nil
                break
            else
                min = stateFunc(a2, nil, 1)
            end
        end
    end

    if min then
        table.insert(newSet, {min, max})
    end

    return newSet
end

-- set集合减去与data范围的交集
function IntervalSet.subWith(set, data, stateFunc)
    IntervalSet.doUnion(set, stateFunc)

    local changed
    local newSet = {}
    local b1,b2 = data[1],data[2]
    local min,max = b1,b2
    local i = 1
    while i <= #set do
        local a1,a2 = set[i][1],set[i][2]
        if min < a1 then
            if max < a1 then
                min = nil
                break
            else
                changed = true
                if max > a2 then
                    table.remove(set, i)
                    min = stateFunc(a2, nil, 1)
                elseif max == a2 then
                    table.remove(set, i)
                    break
                else -- max < a2
                    set[i][1] = stateFunc(max, nil, 1)
                    break
                end
            end
        elseif min == a1 then
            changed = true
            if max < a2 then
                set[i][1] = stateFunc(max, nil, 1)
                break
            elseif max == a2 then
                table.remove(set, i)
                break
            else -- max > a2
                table.remove(set, i)
                min = stateFunc(a2, nil, 1)
            end
        else -- min > a1
            if max < a2 then
                set[i][2] = stateFunc(min, nil, -1)
                table.insert(set, i + 1, {stateFunc(max, nil, 1), a2})
                changed = true
                break
            elseif max == a2 then
                set[i][2] = stateFunc(min, nil, -1)
                changed = true
                break
            else -- max > a2
                if min <= a2 then
                    set[i][2] = stateFunc(min, nil, -1)
                    min = stateFunc(a2, nil, 1)
                    changed = true
                end

                i = i + 1
            end
        end
    end

    return changed
end

function IntervalSet.intersectWith(set, data, stateFunc)
    IntervalSet.doUnion(set, stateFunc)

    local newSet = {}
    local b1,b2 = data[1],data[2]
    local min,max = b1,b2
    for i,v in ipairs(set) do
        local a1,a2 = v[1],v[2]
        if min < a1 then
            if max < a1 then
                min = nil
                break
            else
                if max >= a2 then
                    table.insert(newSet, {a1, a2})
                    min = stateFunc(a2, nil, 1)
                    if max == a2 then
                        break
                    end
                else -- max < a2
                    table.insert(newSet, {a1, max})
                    min = nil
                    break
                end
            end
        else -- min >= a1
            if max <= a2 then
                table.insert(newSet, {min, max})
                min = nil
                break
            elseif min > a2 then
            else -- max > a2 and min <= a2
                table.insert(newSet, {min, a2})
                min = stateFunc(a2, nil, 1)
            end
        end
    end

    return newSet
end

-- set中是否有一对interval包含data(interval)
function IntervalSet.includeInterval(set, data, stateFunc)
    local newSet = {}
    local b1,b2 = data[1],data[2]
    for i,v in ipairs(set) do
        local a1,a2 = v[1],v[2]
        if b2 < a1 then
            return false
        elseif b2 == a1 then
            return b1 == a1
        else -- b2 > a1
            if b1 > a2 then
            elseif b1 == a2 then
                if b2 == a2 then
                    return true
                end
            else -- b1 < a2
                if b2 <= a2 then
                    return true
                end
            end
        end
    end

    return false
end

return IntervalSet

-- local Interval = class("Interval")

-- function Interval:ctor(param1, param2)
--     if istable(param1) then
--         local interval = param1
--         self.left = interval:getLeft()
--         self.right = interval:getRight()
--     else
--         self.left = left
--         self.right = right
--     end
-- end

-- function Interval:isContain(point)
--     if point <= self.right and point >= self.left then
--         return true
--     else
--         return false
--     end
-- end


-- function Interval:getLeft()
--     return left
-- end

-- function Interval:getRight()
--     return right
-- end

-- function Interval:setLeft(left)
--     self.left = left
-- end

-- function Interval:setRight(right)
--     self.right = right
-- end

-- function Interval:toString()
--     return "[" + left + " , " + right + "]"
-- end
