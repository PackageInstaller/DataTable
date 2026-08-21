local M = Util.create_class()

function M:_init()
  set_skill_ban_use(2, true)
  set_skill_ban_use(4, true)
  set_skill_ban_use(5, true)
  set_skill_ban_use(7, true)
  set_skill_ban_use(1, true)
end

return M
