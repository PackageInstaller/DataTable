
--
-- <代码文件解释说明>
--

---@class UIFormationChooseFightSoulPropertyModel : UIBaseModel
local UIFormationChooseFightSoulPropertyModel = BaseClass("UIFormationChooseFightSoulPropertyModel",UIBaseModel)
local base = UIBaseModel
local this = UIFormationChooseFightSoulPropertyModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.characterId = data.characterId
    self.fightSoulId = data.fightSoulId
    self:OnRefresh()
end

function this:OnRefresh()

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
