local M = Util.create_class()
local CommonRole = import("common.role")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init()
  set_hud_config("chorus", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 1, 300206102)
  set_hud_config("faster", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 1, 300205601)
  set_hud_config("absorb", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 1, 300205702)
end

function M:on_self_magic_begin(target, magic_id, magic_level, magic_kind, magic_type)
  if 300206102 == magic_id then
    active_hud(get_come_on_hero(), "chorus", "qipao_gd", true, "剩余次数")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 300206105, 1, 1)
  end
  if 300205601 == magic_id then
    active_hud(get_come_on_hero(), "faster", "qipao_gd", true, "剩余时间")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 300205603, 1, 1)
  end
  if 300205702 == magic_id then
    active_hud(get_come_on_hero(), "absorb", "qipao_gd", true, "剩余时间")
    cast_magic(get_come_on_hero(), get_come_on_hero(), 300205704, 1, 1)
  end
end

function M:on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if 300206102 == magic_id and 0 == get_magic_num(get_come_on_hero(), 300206102) then
    active_hud(get_come_on_hero(), "chorus", "qipao_gd", false, "剩余次数")
  end
  if 300205601 == magic_id and 0 == get_magic_num(get_come_on_hero(), 300205601) then
    active_hud(get_come_on_hero(), "faster", "qipao_gd", false, "剩余时间")
  end
  if 300205702 == magic_id and 0 == get_magic_num(get_come_on_hero(), 300205702) then
    active_hud(get_come_on_hero(), "absorb", "qipao_gd", false, "剩余时间")
  end
end

return M
