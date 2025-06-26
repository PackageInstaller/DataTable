-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/redpoint/treenode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TreeNode = class("TreeNode")
TreeNode.Ctor = function(self)
  -- function num : 0_0
  self._id = nil
  self._childs = {}
  self._parents = {}
end

return TreeNode

