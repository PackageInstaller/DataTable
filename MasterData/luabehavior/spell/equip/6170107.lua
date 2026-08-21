local M = Util.create_class()
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local ability = 20007
local level = 1

function M:_init(npc)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, npc, 60700001101, self.on_timestop_catch_missile, self)
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, self.npc, 60700001101, self)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_timestop_catch_missile(owner, target_missile_cfg, target_missile, missile_cfg, missile, target_missile_owner)
  if missile_cfg.Id == 60700001101 and 2 == target_missile_cfg.MissileTypeTag then
    rebound_missile(target_missile, get_come_on_hero(), target_missile_owner, nil, nil, 10, false, true, true)
    if level > 1 then
      cast_magic(get_come_on_hero(), target_missile_owner, 61701071, 0)
    end
  end
end

return M
