local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevSequence = {}

function BevSequence.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevSequence"
  n.currentRunning = 0
  n.run = BevSequence.run
  n.reset = BevSequence.reset
  return n
end

function BevSequence.new()
  return BevSequence.ctor({})
end

function BevSequence.reset(node)
  node.currentRunning = 0
  BevNode.reset(node)
end

function BevSequence.run(node)
  if #node.children == 0 then
    return BevConst.RunState.Finished
  end
  if node.currentRunning == 0 and #node.children > 0 then
    node.currentRunning = 1
  end
  local currentindex = node.currentRunning
  for i = currentindex, #node.children do
    node.currentRunning = i
    local childnode = node.children[i]
    local ret = childnode.run(childnode)
    if ret == BevConst.RunState.Finished then
      if node.currentRunning == #node.children then
        node.currentRunning = 0
        return BevConst.RunState.Finished
      end
    elseif ret == BevConst.RunState.Running then
      return BevConst.RunState.Running
    elseif ret == BevConst.RunState.Failed then
      node.currentRunning = 0
      return BevConst.RunState.Failed
    end
  end
  return 0
end

return BevSequence
