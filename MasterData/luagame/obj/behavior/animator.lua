local animator_name = "Animator"
local M = Util.create_class()

function M:_init(char)
  self.v_char = char
  self.v_animator_transform = self.v_char.transform:Find(animator_name)
  self.v_animator = self.v_animator_transform:GetComponent(UnityEngine.Animator)
end

function M:get_animator_transform()
  return self.v_animator_transform
end

function M:play(name, layer, normalized_time)
  self.v_animator:Play(name, layer, normalized_time)
end

return M
