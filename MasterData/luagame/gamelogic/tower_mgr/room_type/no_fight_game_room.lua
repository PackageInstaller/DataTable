local Base = require("gamelogic.tower_mgr.room")
local Room = Util.create_child_mt(Base)
local Math = require("base.mathx")
local SceneDef = require("cs_share.scene_define")

function Room:_init(...)
  Base._init(self, ...)
end

function Room:register_event()
  Base.register_event(self)
end

function Room:release()
  Base.release(self)
end

function Room:setup()
  self:_setup()
end

function Room:_setup()
end

function Room:is_no_fight_game_room()
  return true
end

return Room
