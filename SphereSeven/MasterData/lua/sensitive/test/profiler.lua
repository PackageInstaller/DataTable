--[[--Lua性能分析工具
@module Profiler
@author YuchengMo
@import import("bos.core.profiler")

Date   2018-05-08 10:35:19
Last Modified by   YuchengMo
Last Modified time 2019-06-17 11:12:13
]]


--[[

== Introduction ==

  Note that this requires clockNow(), debug.sethook(),
  and debug.getinfo() or your equivalent replacements to
  be available if this is an embedded application.

  Example usage:

    profiler = newProfiler("call")
    profiler:start()

    < call some functions that take time >

    profiler:stop()

    profiler:dump_report_to_file( "profiler.txt" )


--]]


local EMPTY_TIME                       = "0.0000"       -- Detect empty time, replace with tag below
local emptyToThis                      = "~"

local timeWidth                        = 7
local relaWidth                        = 6
local callWidth                        = 10

local divider = "";
local formatOutput                     = "";
local formatTotalTime                  = "Total time spent in profiled functions: %s\n"
local formatFunTime                    = "%04.4f"
local formatFunRelative                = "%03.1f"
local formatFunCount                   = "%"..(callWidth-1).."i"
local formatHeader                     = ""


local function charRepetition(n, character)
    local s   = {}
    character = character or " "
    for _ = 1, n do
        table.insert(s,character)
    end
    return table.concat(s)
end

local clockNow = nil;

local scale = 1;

clockNow = os.clock


local Profiler = {}

--[[---
创建一个性能分析工具对象
@string variant 性能分析模式 "call" or "time"
@function newProfiler
@return     table     性能分析对象
@usage
local newProfiler = import("bos.core.profiler").newProfiler
local profiler = newProfiler("call")
profiler:start();
-- local a = new({}); do someting
profiler:stop();
profiler:dump_report_to_file( "profile.txt" )
]]
local function newProfiler(variant)
    if Profiler.running then
        print("Profiler already running.")
        return
    end

    variant = variant or "time"

    if variant ~= "time" and variant ~= "call" then
        print("Profiler method must be 'time' or 'call'.")
        return
    end

    local newprof = {}
    for k,v in pairs(Profiler) do
        newprof[k] = v
    end
    newprof.variant = variant
    return newprof
end



--[[--
启动性能分析，核心是利用debug.sethook 对函数调用进行钩子
每次只能启动一个
@usage
    local newProfiler = import("bos.core.profiler")
    local profiler = newProfiler("call")
    profiler:start();
    -- do something
]]
function Profiler:start()
    if Profiler.running then
        return
    end
    -- Start the profiler. This begins by setting up internal profiler state
    Profiler.running = self

    self.caller_cache = {}
    self.callstack = {}

    self.start_time = clockNow();
    if self.variant == "time" then
    elseif self.variant == "call" then --因为垃圾回收会导致性能分析下降严重,所以先放缓垃圾回收
        self.setpause = collectgarbage("setpause");
        self.setstepmul = collectgarbage("setstepmul");
        collectgarbage("setpause", 300);
        collectgarbage("setstepmul", 5000);
        debug.sethook( profiler_hook_wrapper_by_call, "cr" )
    else
        error("Profiler method must be 'time' or 'call'.")
    end
end



--[[--
    停止性能分析，如果没启动则没有任何效果
    @usage
        local newProfiler = import("bos.core.profiler")
        local profiler = newProfiler("call")
        profiler:start();
        -- do something
        profiler:stop();
]]

function Profiler:stop()
    if Profiler.running ~= self then
        return
    end
    self.end_time = clockNow();
    -- Stop the profiler.
    debug.sethook( nil )
    if self.variant == "call" then
        collectgarbage("setpause", self.setpause); --还原之前的垃圾回收设置
        collectgarbage("setstepmul", self.setstepmul);
    end
    collectgarbage("collect"); --进行垃圾回收
    collectgarbage("collect");
    Profiler.running = nil
end


--[[
    钩子函数入口
]]
function profiler_hook_wrapper_by_call(action)
    if Profiler.running == nil then
        debug.sethook( nil )
        return
    end
    Profiler.running:analysis_call_info(action)
end

--[[分析函数调用信息
@string action 函数调用类型 call return tail return
]]
function Profiler:analysis_call_info(action)

    --获取当前的调用信息，注意该函数有一定的损耗
    local caller_info = debug.getinfo(3,"Slfn")

    if caller_info == nil then
        return
    end

    local last_caller = self.callstack[1] --必须用数组维护

    if action == "call" then ---进入函数，标记堆栈
        -- Making a call...
        local this_caller = self:get_func_info_by_cache(caller_info.func,caller_info)
        this_caller.parent = last_caller --获取到上一次的信息
        this_caller.clock_start = clockNow()
        this_caller.count = this_caller.count + 1
        table.insert(self.callstack,1,this_caller) --记录调用堆栈顺序
    else
        local last_caller = table.remove(self.callstack, 1) --移除顶部堆栈，有可能连续触发return a进——>b进——>b出——>a出
        --[[
            local b = function()
            end
            local a = function()
                b()
            end
            a(); a进——>b进——>b出——>a出
        ]]
        local this_caller = self.caller_cache[caller_info.func]
        
        if action == "tail return" then --尾调用 当前栈级别中不存在调用者 使用callstack中的记录
            if last_caller then
                this_caller = self.caller_cache[last_caller.func]
            end
        end
        
        if  this_caller == nil  then
            return
        end

        this_caller.this_time = clockNow() - this_caller.clock_start --计算此次函数调用时长

        this_caller.time  = this_caller.time + this_caller.this_time --累加时长

        -- 更新父类信息
        if this_caller.parent then
            this_caller.parent.children[this_caller.func]        = (this_caller.parent.children[this_caller.func] or 0) + 1
            this_caller.parent.children_time[this_caller.func]   = (this_caller.parent.children_time[this_caller.func] or 0 ) + this_caller.this_time

            if this_caller.name == nil then --如果没有函数名称 无名函数
                this_caller.parent.unknow_child_time = this_caller.parent.unknow_child_time + this_caller.this_time
            else
                this_caller.parent.name_child_time = this_caller.parent.name_child_time + this_caller.this_time --统计有名函数调用时间
            end
        end
    end
end


--[[
    获取缓存里的函数信息
    @tparam     function    func  函数
    @tparam     table   info 函数调用信息 debug.getinfo返回的数据
    @return     table     函数信息
]]
function Profiler.get_func_info_by_cache(self,func,info)
    local ret = self.caller_cache[func]
    if ret == nil then --如果缓存没有,则创建一个入缓存
        ret = {}
        ret.func = func
        ret.count = 0 --调用次数
        ret.time = 0 --时间
        ret.unknow_child_time = 0 --没有名字的字函数调用时间
        ret.name_child_time = 0--没有名字的字函数调用时间
        ret.children = {}
        ret.children_time = {}
        if info.source and string.find(info.source, "\n") then
            info.source = "[string]"
        end
        ret.func_info = info
        self.caller_cache[func] = ret
    end
    return ret
end



--格式化成表格样式
function Profiler:format_header(ordering,lines,totalTime)
    local TABL_REPORTS = {};
    local maxFileLen = 0;
    local maxFuncLen = 0;
    for i,func in ipairs(ordering) do
        local record = self.caller_cache[func]
        local reportInfo                         = {
            count  = record.count,
            timer  = record.time,
            src     = record.func_info.short_src,
            name    = record.func_info.name or "unknow",
            linedefined = record.func_info.linedefined,
            what = record.func_info.what,
            source = record.func_info.source;
        }

        reportInfo.src = self:pretty_name(func,true);

        --计算最长的名字
        if string.len(reportInfo.src) > maxFileLen and reportInfo.count > 0  then
            maxFileLen = string.len(reportInfo.src) + 1;
        end

        if string.len(reportInfo.name) > maxFuncLen and reportInfo.count > 0 then
            maxFuncLen = string.len(reportInfo.name) + 1;
        end

        table.insert(TABL_REPORTS,reportInfo);

    end

    if maxFileLen>=99 then --必须如此处理，不然会报错越界
        maxFileLen = 99;
    end

    --     if maxFuncLen>100 then
    --     maxFuncLen = 100;
    -- end


    -- print(maxFileLen,"maxFileLen")
    formatOutput                     = "| %-"..maxFileLen.."s: %-"..maxFuncLen.."s: %-"..timeWidth.."s: %-"..relaWidth.."s: %-"..callWidth.."s|\n"
    -- dump(formatOutput)
    formatHeader                     = string.format(formatOutput, "FILE", "FUNCTION", "TIME", "%", "Call count")
    divider = charRepetition(#formatHeader-1, "-").."\n"


    table.insert(lines, "\n"..divider)
    table.insert(lines, formatHeader)
    table.insert(lines, divider)

    local totalCount = 0;
    for i,reportInfo in ipairs(TABL_REPORTS) do
        if reportInfo.count > 0 and reportInfo.timer <= totalTime then
            local count             = string.format(formatFunCount, reportInfo.count)
            local timer             = string.format(formatFunTime, reportInfo.timer)
            local relTime           = string.format(formatFunRelative, (reportInfo.timer / totalTime) * 100)
            if timer == EMPTY_TIME then
                timer             = emptyToThis
                relTime           = emptyToThis
            end
            local outputLine    = string.format(formatOutput, reportInfo.src,reportInfo.name, timer, relTime, count)
            table.insert(lines, outputLine)

            totalCount = totalCount + reportInfo.count;
        end
    end
    table.insert(lines, divider)
    table.insert(lines, "\n\n")

    table.insert(lines, 2,"Total call count spent in profiled functions: " ..
        totalCount.. "\n\n")
end

--[[--
    生成报表table
    @return     table     报表
    @return     number     性能分析总时间
    @usage
        local newProfiler = import("bos.core.profiler")
        local profiler = newProfiler("call")
        profiler:start();
        -- do something
        profiler:stop();
        profiler:report();
]]
function Profiler:report()
    local lines = {};
    table.insert(lines,[[Lua Profile output created by profiler.lua. author: myc ]])
    table.insert(lines, "\n\n" )
    local total_time = self.end_time - self.start_time

    table.insert(lines, 1,"Total time spent in profiled functions: " ..
        string.format("%5.3g",total_time) .. "s\n\n")

    -- This is pretty awful.
    local terms = {}
    if self.variant == "time" then

    elseif self.variant == "call" then
        terms.capitalized = "Call"
        terms.single = "call"
        terms.pastverb = "called"
        local ordering = {}

        for func,record in pairs(self.caller_cache) do
            table.insert(ordering, func)
        end

        table.sort( ordering,
            function(a,b) return self.caller_cache[a].time > self.caller_cache[b].time end
        )

        --生成头部表格信息
        self:format_header(ordering,lines,total_time);

        for i,v in ipairs(ordering) do
            local func = ordering[i]
            local record = self.caller_cache[func]
            if record.count and record.count > 0 then --- 标记数量大于0的
                local thisfuncname = " " .. self:pretty_name(func) .. " "
                if string.len( thisfuncname ) < 42 then
                    thisfuncname =
                        string.rep( "-", (42 - string.len(thisfuncname))/2 ) .. thisfuncname
                    thisfuncname =
                        thisfuncname .. string.rep( "-", 42 - string.len(thisfuncname) )
                end

                --单个函数的总时间减去子函数的时间,获得自身的时间
                local timeinself = record.time - (record.unknow_child_time + record.name_child_time)
                if timeinself < 0 then
                    timeinself = 0;
                end

                local children =  record.unknow_child_time+record.name_child_time
                if children > record.time then
                    children = record.time
                end

                timeinself = timeinself * scale;

                table.insert(lines, string.rep( "-", 19 ) .. thisfuncname ..
                    string.rep( "-", 19 ) .. "\n" )

                table.insert(lines, terms.capitalized.." count:         " ..
                    string.format( "%4d", record.count ) .. "\n" )
                table.insert(lines, "Time spend total:       " ..
                    string.format( "%4.4f", record.time * scale) .. "s\n" )
                table.insert(lines, "Time spent in children: " ..
                    string.format("%4.4f",(children) * scale) ..
                    "s\n" )

                table.insert(lines, "Time spent in self:     " ..
                    string.format("%4.4f", timeinself) .. "s\n" )

                -- Report on each child in the form
                -- Child  <funcname> called n times and took a.bs
                local added_blank = 0
                for k,v in pairs(record.children) do
                    if added_blank == 0 then
                        table.insert(lines, "\n" ) -- extra separation line
                        added_blank = 1
                    end
                    table.insert(lines, "Child " .. self:pretty_name(k) ..
                        string.rep( " ", 41-string.len(self:pretty_name(k)) ) .. " " ..
                        terms.pastverb.." " .. string.format("%6d", v) )
                    table.insert(lines, " times. Took " ..
                        string.format("%4.5f", record.children_time[k] * scale ) .. "s\n" )

                end

                table.insert(lines, "\n" ) -- extra separation line

            end

        end
    end

    table.insert(lines, [[
END
]] )


    return lines,total_time
end

--[[--
    输出报表到文件
    @tparam     table     self    Profiler对象
    @tparam     string     outfile    文件名称
    @return   number 本次总共花费时间
    @usage
        local newProfiler = import("bos.core.profiler")
        local profiler = newProfiler("call")
        profiler:start();
        -- do something
        profiler:stop();
        profiler:dump_report_to_file("path");
]]
function Profiler.dump_report_to_file(self,outfile)
    local outfile = io.open(outfile, "w+" )
    local lines, total_time= self:report()
    for i,v in ipairs(lines) do
        outfile:write(v)
    end
    outfile:flush()
    outfile:close()
    return total_time
end


--[[
    美化名称，输出可以看懂的信息
    @tparam     function    func  函数
    @boolean    force 是否强制
]]
function Profiler:pretty_name(func,force)

    -- Only the data collected during the actual
    -- run seems to be correct.... why?
    local info = self.caller_cache[func].func_info

    local name = ""
    if info.what == "Lua" and force then
        name = "L:" .. info.short_src ..":" .. info.linedefined
        return name;
    end
    if info.what == "Lua" then
        name = "L:"
    end
    if info.what == "C" then
        name = "C:"
    end
    if info.what == "main" then
        name = " :"
    end
    if info.name == nil then
        name = name .. "<"..tostring(func) .. ">"
    else
        name = name .. info.name
    end

    if info.source then
        name = name .. "@" .. info.source
    else
        if info.what == "C" then
            name = name .. "@?"
        else
            name = name .. "@<string>"
        end
    end
    name = name .. ":"
    -- if info.what == "C" then
    --     name = name .. "unknow line"
    -- else
    --     name = name .. info.linedefined
    -- end
    name = name .. info.linedefined

    return name
end

return newProfiler