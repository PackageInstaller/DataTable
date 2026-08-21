local M = Util.create_class()

function M:_init()
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if 201046020102 == m2_cfg and (m1_cfg.Id == 10010043101 or m1_cfg.Id == 10010043201 or m1_cfg.Id == 10010043301) then
    stop_missile(201046020102)
  end
end

return M
