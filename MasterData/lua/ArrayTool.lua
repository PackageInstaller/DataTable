--[[
    ArrayTool: 不保证顺序
]]
ArrayTool = {}

function ArrayTool.new()
    return {size = 0, history_size = 0, datas = {}}
end

function ArrayTool.push(arr, val)
    arr.size = arr.size + 1
    arr.datas[arr.size] = val
    if arr.size > arr.history_size then
        arr.history_size = arr.size
    end

    return arr.size
end

function ArrayTool.index(arr, index)
    if index < 1 or index > arr.size then
        return nil
    end

    return arr.datas[index]
end

function ArrayTool.forEach(arr, fun)
    for index, val in ipairs(arr.datas) do
        local ret = fun(index, val)
        if ret ~= nil and ret == false then
            break
        end
    end
end

function ArrayTool.size(arr)
    return arr.size
end

function ArrayTool.empty(arr)
    local is_empty = _G.next(arr.datas) == nil
    if is_empty then
        assert(arr.size < 1, ' ArrayTool.empty(arr)')
    end

    return is_empty
end

function ArrayTool.historySize(arr)
    return arr.history_size
end

function ArrayTool.releaseMem(arr, delKey)
    local val = ArrayTool.find(arr, delKey)
    if not val then
        arr.datas[delKey] = nil
    end
end

function ArrayTool.sort(arr, fun)
    table.sort(arr.datas, fun)
end

function ArrayTool.bsearch(arr, val)
    local left = 1
    local right = #arr.datas
    local sumLen = right
    if left > right then
        return false
    end

    local rv, mid = 0, 0

    local loopCnt = 0
    while left <= right do
        mid = math.ceil((left + right) / 2)
        rv = arr.datas[mid]
        -- LogDebug('mid:%s, left:%s, right:%s, rv:%s, val:%s', mid, left, right, rv, val)

        if rv == val then
            break
        elseif rv < val then
            left = mid + 1
        else
            right = mid - 1
        end

        -- LogDebug("mid:%s, left:%s, right:%s, rv:%s, val:%s", mid, left, right, rv, val)

        loopCnt = loopCnt + 1
        if loopCnt > sumLen then
            -- 防止死循环保护
            LogError(
                'table.bsearch sum len: %s, loop: %s had error! table find: %s info is: %s',
                sumLen,
                loopCnt,
                val,
                table.tostring(arr.datas)
            )
            break
        end
    end

    return val == rv, mid, rv
end

function ArrayTool.clear(arr)
    arr.size = 0
    arr.history_size = 0
    arr.datas = {}
end

-- 用最后的那个值，去覆盖index位置的数据，返回
-- moveIndex： 被移动值得下标
-- moveVal 被移动的值
function ArrayTool.remove(arr, index)
    if index < 1 or index > arr.size then
        return nil, nil
    end

    local moveVal = nil
    local moveIndex = arr.size
    if arr.size == 1 then
        assert(index == arr.size)
        arr.datas[arr.size] = nil
    else
        moveVal = arr.datas[arr.size]
        arr.datas[index] = moveVal
        arr.datas[arr.size] = nil
    end

    arr.size = arr.size - 1

    assert(arr.size >= 0)
    return moveIndex, moveVal
end

-- removeByVal，只合适，使用 sort() 排序过的, 删除后，会变得无序，需要重新 sort 一遍
-- val 要删除的值，
function ArrayTool.removeByVal(arr, val)
    local isFind, index, rval = ArrayTool.bsearch(arr, val)
    if not isFind then
        return nil
    end

    assert(rval == val)
    return ArrayTool.remove(arr, index)
end

function ArrayTool.test()
    local arr = ArrayTool.new()
    for i = 11, 20, 1 do
        ArrayTool.push(arr, i)
    end
    ArrayTool.push(arr, 1)
    ArrayTool.push(arr, 3)
    ArrayTool.push(arr, 5)

    LogTable(arr, 'After push:')

    ArrayTool.remove(arr, 13)
    ArrayTool.remove(arr, 1)

    LogTable(arr, 'After remove index: 13 and 1')

    ArrayTool.push(arr, 5)
    LogTable(arr, 'After push:')

    ArrayTool.sort(arr)
    LogTable(arr, 'After sort:')

    for i = 1, 23, 1 do
        LogDebug('find:%s, isFind:%s, index:%s, val:%s', i, ArrayTool.bsearch(arr, i))
    end

    LogDebug('check removeByVal()')
    for i = 1, 23, 1 do
        ArrayTool.removeByVal(arr, i)
        ArrayTool.sort(arr)
        LogTable(arr, 'After removeByVal:' .. i)
    end

    ArrayTool.push(arr, 3)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))

    ArrayTool.push(arr, 1)
    ArrayTool.sort(arr)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))

    ArrayTool.push(arr, 6)
    ArrayTool.sort(arr)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))

    ArrayTool.push(arr, 5)
    ArrayTool.sort(arr)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))

    ArrayTool.push(arr, 2)
    ArrayTool.sort(arr)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))

    ArrayTool.push(arr, 0)
    ArrayTool.sort(arr)
    LogDebug('find:%s after push, isFind:%s, index:%s, val:%s', 3, ArrayTool.bsearch(arr, 3))
end

return ArrayTool
