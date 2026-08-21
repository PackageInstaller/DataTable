local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevActionSetVar = {}

function BevActionSetVar.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionSetVar"
  n.varname = ""
  n.value = ""
  n.run = BevActionSetVar.run
  return n
end

function BevActionSetVar.new()
  return BevActionSetVar.ctor({})
end

function BevActionSetVar.run(node)
  local team = BevData.instance.currentTeam
  BevData.instance.vars[team][node.varname] = node.eval(node.value)
  return BevConst.RunState.Finished
end

return BevActionSetVar
