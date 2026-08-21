local ChiefNoteConst = {}

local Type = {
    Story = 1,
    Com = 2,
}

local Subject = {
    FACTIONS = 1,   --阵营
    EVENTS = 2,     --事件
    PLACES = 3,     --地点
    ITEMS = 4,      --物品
    WORLD_VIEWS = 5 --科普
}

local TabNames = {
    473, --阵营
    474, --事件
    475, --地点
    476, --物品
    477  --科普
}

local UIState = {
    UNLOCK_SELECT = 1,
    UNLOCK_UNSELECT = 2,
    LOCK_SELECT = 3,
    LOCK_UNSELECT = 4
}

ChiefNoteConst.Type = Type
ChiefNoteConst.Subject = Subject
ChiefNoteConst.TabNames = TabNames
ChiefNoteConst.UIState = UIState

return ChiefNoteConst
