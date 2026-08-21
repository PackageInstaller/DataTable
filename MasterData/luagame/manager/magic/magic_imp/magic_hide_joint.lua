local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  self.bone_name = self.cfg[1]
  self.hide_all = 1 == self.cfg[2]
  if self.hide_all then
    local owner = self.owner
    owner._hide_root_count = owner._hide_root_count and owner._hide_root_count + 1 or 1
    if owner._hide_root_count > 0 then
      owner.gameobj:SetActive(false)
    end
    return
  end
  self.owner:set_joint_active(self.bone_name, false)
end

function M:on_remove(magic_map)
  if self.hide_all then
    local owner = self.owner
    owner._hide_root_count = owner._hide_root_count - 1
    if owner._hide_root_count <= 0 then
      owner.gameobj:SetActive(true)
    end
    return
  end
  local is_bone_show = true
  for k, magic in pairs(magic_map) do
    if self.bone_name == magic.bone_name then
      is_bone_show = false
      break
    end
  end
  if is_bone_show then
    self.owner:set_joint_active(self.bone_name, true)
  end
end

return M
