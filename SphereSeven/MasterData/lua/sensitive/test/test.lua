-- lua require 路径
package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."../src/?.lua;".. package.path

local LibTableFormat = require "table_format"
local LibStringSearch = require "string_search"
local LibSpellingSearch = require "spelling_search"

--------------------------------------------------------------------

-- 字符串过滤
local l_FindClass = LibStringSearch:new({"张三", "李四", "zlf"})

local sMainStr = "张三hhhhzlf李四zzzz"

local tbResults = l_FindClass:find_all(sMainStr)
print("3333333333333333333 ", LibTableFormat(tbResults))
local sMainStr = l_FindClass:replace(tbResults, sMainStr)
print("3333333333333333333 ", sMainStr)
--------------------------------------------------------------------

-- 字符串转拼音
-- LibSpellingSearch:init()
-- local tbR = LibSpellingSearch:get_pin_yin('阿里山', 0)
-- print(tbR)

-- tbR = LibSpellingSearch:get_first_pin_yin('阿里山', 0)
-- print(tbR)

-- tbR = LibSpellingSearch:get_all_pin_yin("传", 0)
-- print(LibTableFormat(tbR))

-- tbR = LibSpellingSearch:get_pin_yin_in_list_for_name("欧阳一一", 0)
-- print(LibTableFormat(tbR))
-- 
-- tbR = LibSpellingSearch:get_pin_yin_in_list_for_name("单一一", 0)
-- print(LibTableFormat(tbR))

-- tbR = LibSpellingSearch:get_pin_yin("单一一sss", 0)
-- print(tbR)

--------------------------------------------------------------------

--[[
-- 性能测试
local LibBan = require "test.ban"
local LibProfiler = require "test.profiler"

local newProfiler = LibProfiler()

newProfiler:start()
local tbRepetition = {}
local tbBan = {}
for _, sStr in ipairs(LibBan) do
    for sV in string.gmatch(sStr,"([^".. ',' .."]+)") do
        if not tbRepetition[sV] then
            tbRepetition[sV] = true
            table.insert(tbBan, sV)
        end
    end
end
tbRepetition = nil

local nMemStart = collectgarbage("count")
local l_FindClass = LibStringSearch:new(tbBan)
collectgarbage("collect")
local nMemEnd = collectgarbage("count")
newProfiler:stop()

local tbLines, nTime = newProfiler:report()

local newProfiler = LibProfiler()

local sStr = "fasjflasj手动阀见识%s"
local tbSearch = {}
local count = 0
for _, n in pairs(tbBan) do
    table.insert(tbSearch, string.format(sStr, n))
    count = count + 1
end
print(" 构建trie树消耗时间 ", nTime)
-- print(LibTableFormat(tbLines))
print(" 构建trie树消耗的内存 ", (nMemEnd - nMemStart)/1024, "M")
print(" 匹配主串的数量 ", count)



newProfiler:start()

for _, sS in ipairs(tbSearch) do
    local tbResults = l_FindClass:find_all(sS)
    l_FindClass:replace(tbResults, sS)
end

newProfiler:stop()
local tbLines, nTime = newProfiler:report()
print(" 敏感词过滤消耗的时间: ", nTime)
-- print(LibTableFormat(tbLines))
]]