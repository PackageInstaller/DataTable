local LineupStation = dataclass("LineupStation")
LineupStation.FRONT_ROW = 1
LineupStation.MIDDLE_ROW = 2
LineupStation.BACK_ROW = 3
LineupStation.ALTERNATE_FRONT_ROW = 4
LineupStation.ALTERNATE_MIDDLE_ROW = 5
LineupStation.ALTERNATE_BACK_ROW = 6

function LineupStation:Ctor()
end

function LineupStation:Marshal(data)
end

function LineupStation:Unmarshal(data)
end

function LineupStation:CheckVariable()
  return true
end

return LineupStation
