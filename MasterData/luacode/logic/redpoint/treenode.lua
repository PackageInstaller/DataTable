local TreeNode = class("TreeNode")

function TreeNode:Ctor()
  self._id = nil
  self._childs = {}
  self._parents = {}
end

return TreeNode
