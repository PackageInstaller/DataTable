local weightCfg = Util.create_class()
local nilTable = Const.NIL_TABLE

function weightCfg.new(base, cfg, searchCfg)
  cfg = cfg or nilTable
  local param
  local ret = setmetatable({}, base)
  param = cfg.dist or nilTable
  ret.dist = {
    enable = nil,
    weight = param[1],
    ratio = param[2],
    idealDis = param[3]
  }
  param = cfg.angle or nilTable
  ret.angle = {
    enable = nil,
    weight = param[1],
    ratio = param[2]
  }
  param = cfg.density or nilTable
  ret.density = {
    enable = nil,
    weight = param[1],
    ratio = param[2],
    maxAngle = param[3],
    halfAngle = param[3] and param[3] / 2,
    maxDis = param[4]
  }
  param = cfg.viscous or nilTable
  ret.viscous = {
    enable = nil,
    weight = param[1]
  }
  param = cfg.hp or nilTable
  ret.hp = {
    enable = nil,
    weight = param[1]
  }
  param = cfg.dedup or nilTable
  ret.dedup = {
    enable = nil,
    weight = param[1],
    timeRatio = param[2],
    idxRatio = param[3]
  }
  param = cfg.occlus or nilTable
  ret.occlus = {
    enable = nil,
    cullWeight = param[1]
  }
  ret:update()
  do return ret end
  
  function ret.custom(role, npc)
    return 0
  end
end

function weightCfg.update(cfg)
  local param = cfg.dist
  param.enable = param.weight and param.ratio and param.idealDis and (0 ~= param.weight or 0 ~= param.ratio)
  param = cfg.angle
  param.enable = param.weight and param.ratio and (0 ~= param.weight or 0 ~= param.weight)
  param = cfg.density
  param.enable = param.weight and param.ratio and param.maxAngle and param.maxDis and (0 ~= param.weight or 0 ~= param.ratio)
  param.halfAngle = param.maxAngle and param.maxAngle / 2
  param = cfg.viscous
  param.enable = param.weight and 0 ~= param.weight
  param = cfg.hp
  param.enable = param.weight and 0 ~= param.weight
  param = cfg.dedup
  param.enable = param.weight and 0 ~= param.weight and (param.timeRatio or param.idxRatio) and param.weight * param.timeRatio <= 0 and param.weight * param.idxRatio <= 0
  param = cfg.occlus
  param.enable = param.cullWeight and 0 ~= param.cullWeight
end

weightCfg.EMPTY = weightCfg:new()

function weightCfg.create(base, tbl)
  tbl = UtilTable.fill_table(base.EMPTY, tbl)
  setmetatable(tbl, base)
  tbl:update()
  return tbl
end

return weightCfg
