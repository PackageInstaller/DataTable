-- 列表头的 pre 是 nil, 列表尾部的 next 是nil
ListTool = {}

function ListTool.new()
    return {header = nil, tail = nil, num = 0}
end

function ListTool.element(val)
    return {pre = nil, next = nil, data = val}
end

function ListTool.size(list)
    return list.num
end

-- 添加到末尾
function ListTool.add(list, val)
    local elm = ListTool.element(val)
    
    if not list.header then
        list.header = elm
        list.tail = elm
    else
        elm.pre = list.tail
        list.tail.next = elm
        list.tail = elm
    end
    
    list.num = list.num + 1
end

-- 弹出队头
function ListTool.pop(list)
    if not list.header then
        return nil
    end
    
    local header = list.header
    list.header = header.next
    list.num = list.num - 1
    
    return header.data
end

-- 删除, elm 是 ListTool.element() 返回的元素
function ListTool.del(list, elm)
    if elm == list.header or elm == list.tail then
        if elm == list.header then
            list.header = elm.next
            if list.header then
                list.header.pre = nil
            end
        end
        
        if elm == list.tail then
            list.tail = elm.pre
            if list.tail then
                list.tail.next = nil
            end
        end
    else
        -- 非头非尾，那么就是中间的了
        -- 修改前一个元素的下一个指向
        elm.pre.next = elm.next
        
        -- 修改下一个元素的前一个元素
        elm.next.pre = elm.pre
    end
    
    list.num = list.num - 1
    
    -- print("删除：" .. elm.data)
    elm.pre = nil
    elm.next = nil
    elm.data = nil
    elm = nil
end

function ListTool.forEach(list, fun)
    local elm = list.header
    while elm do
        local tmp = elm.next
        
        local ret = fun(elm, elm.data)
        if ret ~= nil and ret == false then
            break
        end
        
        elm = tmp
    end
end

-- 清空所有元素
function ListTool.clear(list)
    ListTool.forEach(
        list,
        function(elm, data)
            ListTool.del(list, elm)
        end
)
end

function ListTool.showPrint(list, title, stopVal)
    if title then
        print("\n" .. title)
    end
    
    local tStr = {}
    ListTool.forEach(
        list,
        function(elm, data)
            table.insert(tStr, data)
            if data == stopVal then
                return false
            end
        end
    )
    print(table.concat(tStr, ", "))
end

function ListTool.test()
    local list = ListTool.new()
    
    print("ListTool.test()")
    
    --------------------------------------------------------------------------------------------------------
    for i = 1, 10, 1 do
        ListTool.add(list, i)
    end
    
    ListTool.showPrint(list, "初始情况:")
    
    ListTool.showPrint(list, "测试循环中断，输出到5:", 5)
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 1 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除头之后:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 10 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除尾之后:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 5 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除中间之后:")
    
    ListTool.clear(list)
    ListTool.showPrint(list, "清空之后:")
    
    --------------------------------------------------------------------------------------------------------
    ListTool.add(list, 1)
    ListTool.showPrint(list, "一个元素的情况:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 1 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除一个元素后:")
    
    --------------------------------------------------------------------------------------------------------
    ListTool.add(list, 1)
    ListTool.add(list, 2)
    ListTool.showPrint(list, "两元素的情况:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 1 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除第一个元素后:")
    ListTool.clear(list)
    
    --------------------------------------------------------------------------------------------------------
    ListTool.add(list, 1)
    ListTool.add(list, 2)
    ListTool.showPrint(list, "两元素的情况:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            if data == 2 then
                ListTool.del(list, elm)
                return false
            end
        end
    )
    ListTool.showPrint(list, "删除第二个元素后:")
    
    ListTool.add(list, 1)
    ListTool.add(list, 2)
    ListTool.add(list, 3)
    ListTool.add(list, 4)
    ListTool.add(list, 5)
    ListTool.add(list, 6)
    while ListTool.pop(list) do
        ListTool.showPrint(list, "测试队列,出列队头:")
    end
    
    ListTool.add(list, 1)
    ListTool.add(list, 2)
    ListTool.showPrint(list, "增加两值:")
    
    ListTool.add(list, 1)
    ListTool.add(list, 2)
    ListTool.add(list, 3)
    ListTool.add(list, 4)
    ListTool.add(list, 5)
    ListTool.add(list, 6)
    ListTool.showPrint(list, "循环删除前:")
    
    ListTool.forEach(
        list,
        function(elm, data)
            ListTool.del(list, elm)
            ListTool.showPrint(list, "循环删除时:")
        end
    )

    ListTool.showPrint(list, "循环删除后:")
    
    LogTable(list)
end
