local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local skill_id = 617079101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost
local fubao1 = 617079111
local fubao2 = 617079112
local fubao3 = 617079113
local fubao4 = 617079114
local fubao5 = 617079115
local fubao6 = 617079116
local touzhi1 = 617079117
local baojun = 61707122
local kuangnu = 61707311
local dot_missile = 61707910102

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function M:on_input(input_id)
  if 60 == input_id then
    local function cast_fubao_skills(npc, hero, fubaos)
      for _, fubao in ipairs(fubaos) do
        cast_magic(npc, hero, fubao)
      end
    end
    
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      local fubaos = {
        fubao1,
        fubao2,
        fubao3,
        fubao4,
        fubao5
      }
      local hero = get_come_on_hero()
      self.hero = hero
      cast_skill(self.npc, self.npc, skill_id, nil, nil)
      remove_missile_by_id(dot_missile)
      cast_missile3(hero, hero, nil, nil, dot_missile)
      local role = hero:get_behavior()
      
      local function add_buff()
        cast_fubao_skills(self.npc, hero, fubaos)
      end
      
      role:doAfter(add_buff, 0.3)
      CommonRole.indicator_slowdown_off(self)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:get_level()
  local skill_data = {
    [1] = {
      id = 617079101,
      fubaos = {
        617079111,
        617079112,
        617079113,
        617079114,
        617079115
      }
    },
    [2] = {
      id = 617079102,
      fubaos = {
        617079121,
        617079122,
        617079123,
        617079124,
        617079125
      }
    },
    [3] = {
      id = 617079103,
      fubaos = {
        617079131,
        617079132,
        617079133,
        617079134,
        617079135
      }
    }
  }
  local level = get_god_skill_level()
  if level >= 1 and level <= 3 then
    local data = skill_data[level]
    skill_id = data.id
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(level)
    fubao1, fubao2, fubao3, fubao4, fubao5 = table.unpack(data.fubaos)
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type)
  local hero = get_come_on_hero()
  if 617079118 == magic_id or 617079128 == magic_id or 617079138 == magic_id then
    cast_magic(self.npc, hero, baojun)
  end
  if target == hero and (check_magic(hero, fubao1) or check_magic(hero, 617079121) or check_magic(hero, 617079131)) then
    cast_magic(self.npc, hero, kuangnu)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == 61707910102 then
    cast_magic(owner, owner, 617079144)
  end
end

return M
