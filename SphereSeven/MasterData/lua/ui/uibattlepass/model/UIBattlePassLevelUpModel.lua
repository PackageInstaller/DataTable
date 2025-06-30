
--
-- <代码文件解释说明>
--

---@class UIBattlePassLevelUpModel : UIBaseModel
local UIBattlePassLevelUpModel = BaseClass("UIBattlePassLevelUpModel",UIBaseModel)
local base = UIBaseModel
local this = UIBattlePassLevelUpModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.level = data.level
    self.passId = data.passId
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type PassComponent
    local passComponent = Game.Scene.Player:GetComponent("PassComponent")
    self.pass = passComponent:GetPass(self.passId)
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
