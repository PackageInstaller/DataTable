local BehaviorTree = require("utils.behavior_tree")
local M = {}
M.npc_cycle = BehaviorTree.make_ai(require("behavior_tree.npc_cycle"))
M.npc_onetime = BehaviorTree.make_ai(require("behavior_tree.npc_onetime"))
M.npc_goback = BehaviorTree.make_ai(require("behavior_tree.npc_goback"))
return M
