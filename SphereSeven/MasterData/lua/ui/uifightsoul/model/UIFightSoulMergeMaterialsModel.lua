
--
-- <代码文件解释说明>
--

---@class UIFightSoulMergeMaterialsModel : UIBaseModel
---@field fightSoulList FightSoul[]
---@field fightsoul FightSoul
---@field fightSoulMap table<number, FightSoul>
local UIFightSoulMergeMaterialsModel = BaseClass("UIFightSoulMergeMaterialsModel",UIBaseModel)
local base = UIBaseModel
local this = UIFightSoulMergeMaterialsModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.cid = data.cid
    self.id = data.id
    self.chooseIds = data.chooseIds
    self.callBack = data.callBack
    self:OnRefresh()
end

function this:OnRefresh()
    self.fightSoulList = {}
    self.fightSoulMap = {}
    ---@type FightSoulComponent
    local fightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")
    self.fightsoul = fightSoulComponent:Get(self.id)
    ---@type FightSoul[]
    local fightSouls = fightSoulComponent:GetFightSoulList()
    for key, value in pairs(fightSouls) do
        if value.TemplateId == self.cid and value.Id ~= self.id then
            table.insert(self.fightSoulList, value)
            self.fightSoulMap[value.Id] = value
        end
    end
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddDataListener(DataMessageNames.xxx,func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveDataListener(DataMessageNames.xxx)
end

return this
