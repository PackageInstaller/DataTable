local M = Util.create_class()

function M:_init()
  self.PosX, self.PosY, self.PosZ = get_area_pos("tp1")
  self.EffectPos = {
    x = self.PosX,
    y = self.PosY,
    z = self.PosZ
  }
  create_scene_effect("Fx_Transmit3_idel", self.EffectPos, 0)
end

return M
