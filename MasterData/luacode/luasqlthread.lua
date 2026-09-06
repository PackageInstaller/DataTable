threadsafepipe = require("threadsafepipe")
require("framework.class")
require("framework.table")
require("framework.string")
require("framework.utils.log")
JSON = require("framework.json")
SqlConnection = require("logic.sql.sqlconnection")
SqlProtocalManager = require("logic.sql.luasqlprotocalmanager").Create()

function update(p1, p2)
  SqlProtocalManager:Init(p2, p1)
  LogInfoFormat("luasqlthread", "update enter p1 = %s, p2 = %s", p1, p2)
  local result
  while true do
    result = SqlProtocalManager:Update(true)
    if type(result) == "string" and result == "exit" then
      break
    end
  end
  LogInfoFormat("luasqlthread", "update exit p1 = %s, p2 = %s", p1, p2)
end

function errfunction(errobject)
  LogErrorFormat("luasqlthread", errobject)
end
