-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luasqlthread.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
threadsafepipe = require("threadsafepipe")
require("framework.class")
require("framework.table")
require("framework.string")
require("framework.utils.log")
JSON = require("framework.json")
SqlConnection = require("logic.sql.sqlconnection")
SqlProtocalManager = ((require("logic.sql.luasqlprotocalmanager")).Create)()
update = function(p1, p2)
  -- function num : 0_0 , upvalues : _ENV
  SqlProtocalManager:Init(p2, p1)
  LogInfoFormat("luasqlthread", "update enter p1 = %s, p2 = %s", p1, p2)
  local result = nil
  while 1 do
    result = SqlProtocalManager:Update(true)
  end
  if type(result) == "string" then
    if result ~= "exit" then
      LogInfoFormat("luasqlthread", "update exit p1 = %s, p2 = %s", p1, p2)
    end
  end
end

errfunction = function(errobject)
  -- function num : 0_1 , upvalues : _ENV
  LogErrorFormat("luasqlthread", errobject)
end


