local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666401)
end

function M:add_ult_energy()
  if not check_magic(self.npc, 6664011) then
    cast_magic(self.npc, self.npc, 6664011, self.stone_lv)
    if not check_magic(self.npc, 6664012) and check_magic(self.npc, 6664031) then
      cast_magic(self.npc, self.npc, 6664012, self.stone_lv)
    end
  end
end

function M:on_frame_background()
  self:add_ult_energy()
end

return M
