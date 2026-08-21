local SlotFurnitureActionConfig = {
    AnxixiangSugarBowl = { heroId = 110003, templateId = 3002, dormaction = "DormAction.Anxixiang.AnxixiangSugarBowlAction" },
    AnxixiangCoffee = { heroId = 110003, templateId = 3003, dormaction = "DormAction.NormalSlotFurnitureAction" },
    AnxixiangPlayStation = { heroId = 110003, templateId = 3007, dormaction = "DormAction.Anxixiang.AnxixiangPlayStationAction" },
    AnxixiangDiary = { heroId = 110003, templateId = 3004, dormaction = "DormAction.Anxixiang.AnxixiangDiaryAction" },
    BeautyCock = { heroId = 0, templateId = 3006, dormaction = "DormAction.NormalSlotFurnitureAction" },
}
    
local function InitPhoto()
    local houseFurniture = ConfigHelper.GetCfgs("houseFurniture")
    local index=1
    for k ,v in pairs(houseFurniture)do
        if v.subType==902 then
            SlotFurnitureActionConfig["Photo"..index]={ heroId = 0, templateId = k, dormaction = "DormAction.NormalSlotFurnitureAction" }
            index = index + 1
        end
    end
end

InitPhoto()

return SlotFurnitureActionConfig
