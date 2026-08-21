local M = Util.create_class()
local CommonRole = import("common.role")

function M:_init()
  self.skill_id = 601000001
  self.hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  self.skill_area = {
    type = 1,
    res = "Fx_skillarea_circle_1",
    sizex = 2.3
  }
  self.skill_indi_cfg = {
    type = 3,
    res = "FX_text_kong",
    sizex = 4.5,
    sizey = 4.5
  }
  set_ui_object_visible("fight", "Btn_skillTower", true)
end

function M:on_frame()
  CommonRole.indicator_input(self, 60, self.skill_id, nil, self.skill_area, self.skill_indi_cfg, nil, nil, 3)
end

function M:on_touch_up(input_id, iscancle)
  if 60 == input_id and false == iscancle then
    local hero_attr = 0
    for key, value in pairs(self.hero_list) do
      if value then
        hero_attr = hero_attr + get_npc_attr(value, 71)
      end
    end
    hero_attr = math.min(math.max(1, math.floor(hero_attr / 1000)), 10)
    cast_missile(self.npc, self.npc, nil, nil, 60100000101, hero_attr)
  end
end

return M
