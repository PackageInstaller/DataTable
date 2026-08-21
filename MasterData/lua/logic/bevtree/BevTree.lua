local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevTree = {}

function BevTree.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevTree"
  n.run = BevTree.run
  return n
end

function BevTree.new()
  return BevTree.ctor({})
end

function BevTree.run(node)
  if node.children ~= nil and #node.children >= 1 then
    local root = node.children[1]
    if root ~= nil then
      return root:run()
    end
  end
  return BevConst.RunState.Finished
end

return BevTree
