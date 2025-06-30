
--
-- <代码文件解释说明>
--

---@class UIFightSoulInfoModel : UIBaseModel
---@field fightSoul FightSoul
local UIFightSoulInfoModel = BaseClass("UIFightSoulInfoModel",UIBaseModel)
local base = UIBaseModel
local this = UIFightSoulInfoModel

function this:OnCreate()
    base.OnCreate(self)
end

---@param data {idList:number[], id:number}
function this:OnEnable(data)
    base.OnEnable(self)
    self.idList = data.idList
    self.index = 1
    for index, value in ipairs(self.idList) do
        if data.id == value then
            self.index = index
            break
        end
    end

    self:OnRefresh()
end

function this:OnRefresh()
    self:RefreshFightSoul()
end

function this:RefreshFightSoul()
    self.id = self.idList[self.index]
    self.fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.id)
end


local function OnFightSoulUpdate(self)
    local oldIndex = self.index
    self.index = 1
    table.removeall(self.idList, function(v)
        return Game.Scene.Player:GetComponent("FightSoulComponent"):Get(v) == nil
    end)

    for index, value in ipairs(self.idList) do
        if self.id == value then
            self.index = index
            break
        end
    end
    self.fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.id)
    if self.fightSoul == nil then
        if self.index[oldIndex] ~= nil then
            self.index = oldIndex
        else
            self.index = 1
        end
        self.id = self.idList[self.index]
        self.fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.id)
    end
    self:UIBroadcast(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE, OnFightSoulUpdate)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end

return this
