local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.baojun and get_magic_num(self.npc, 61707121) < 5 then
    cast_magic(self.npc, self.npc, 61707121, 0)
  end
end

function M:on_start()
  listen_attr_change_mq(self.npc, 2, self.on_jingli_change, self)
  self.energy_each = 100
  self.current_energy = get_npc_attr(self.npc, 2)
  self.last_gezi = math.floor(self.current_energy / self.energy_each)
end

function M:on_jingli_change(npc, attr_tpe, change_value)
  self.current_energy = get_npc_attr(self.npc, 2)
  self.gezi = math.floor(self.current_energy / self.energy_each)
  if self.gezi < self.last_gezi then
    local buff_add = self.last_gezi - self.gezi
    for _ = 1, buff_add do
      if get_magic_num(self.npc, rogueMgr.baojun) < 5 then
        cast_magic(self.npc, self.npc, rogueMgr.baojun)
        local level = get_ability_level(40010) or 1
        if level > 1 then
          cast_magic(self.npc, self.npc, rogueMgr.baojun)
        end
      end
    end
  end
  self.last_gezi = self.gezi
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 2, self)
end

return M
