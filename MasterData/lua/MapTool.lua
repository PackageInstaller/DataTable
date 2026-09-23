MapTool = {}

function MapTool.new()
    return {size = 0, history_size = 0, datas = {}}
end

function MapTool.insert(map, key, val)
    local old = MapTool.find(map, key)
    if not old and val then
        map.size = map.size + 1
        if map.size > map.history_size then
            map.history_size = map.size
        end
    end

    map.datas[key] = val
    return old
end

function MapTool.find(map, key)
    local val = map.datas[key]
    return val
end

function MapTool.remove(map, key)
    local old = MapTool.find(map, key)
    if old then
        map.datas[key] = nil
        map.size = map.size - 1
        -- assert(map.size >= 0)
    end

    return old
end

-- 跳过查询直接删除，需要在查询，或者循环里面调用
function MapTool.raw_remove(map, key)
    map.datas[key] = nil
    map.size = map.size - 1
    -- assert(map.size >= 0)
end

function MapTool.forEach(map, fun)
    -- LogTrace()
    for key, val in pairs(map.datas) do
        local ret = fun(key, val)
        if ret ~= nil and ret == false then
            break
        end
    end
end

function MapTool.size(map)
    return map.size
end

function MapTool.historySize(map)
    return map.history_size
end

function MapTool.releaseMem(map)
    map.datas[{}] = nil
end

function MapTool.setEmpty(map)
    map.size = 0
    map.datas = {}
end

function MapTool.next(map, key)
    return _G.next(map.datas, key)
end

function MapTool.checkInitFrom(data)
    if not data.size then
        local retData = MapTool.new()
        for k, v in pairs(data) do
            MapTool.insert(retData, k, v)
        end

        return retData
    end

    return data
end

return MapTool
