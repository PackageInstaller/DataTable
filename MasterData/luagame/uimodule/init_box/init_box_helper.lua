local helper = {}

function helper.is_have_init_item_get()
  local is_have = false
  local hero_list = SceneMgr:get_hero_list()
  for _, hero in pairs(hero_list) do
    local hero_cfg = hero.buddy_cfg
    local hero_id = hero_cfg.Id
    local hero_advance = hero:get_hero_advance()
    local advance_born_item_cfg = ShareRes.get_buddy_advance_born_item_cfg(hero_id)
    if advance_born_item_cfg then
      for _, data in pairs(advance_born_item_cfg) do
        local advance_lv = data.AdvanceLv
        if hero_advance >= advance_lv then
          is_have = true
          goto lbl_34
        end
      end
    end
  end
  ::lbl_34::
  return is_have
end

return helper
