local Base = require("obj.functional_npc.challenge_npc")
local M = Util.create_child_mt(Base)

function M:on_interact()
  UIMgr:try_destory_ui("curse_ability_upgrade")
  local curse_ability_upgrade = UIMgr:get_ui("curse_ability_upgrade")
  curse_ability_upgrade:ui_show(nil, true)
end

function M:on_treasure_chest_open()
end

function M:on_treasure_chest_close()
end

return M
