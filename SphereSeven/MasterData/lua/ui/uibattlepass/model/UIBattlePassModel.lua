
--
-- <代码文件解释说明>
--

---@class UIBattlePassModel : UIBaseModel
---@field pass Pass
local UIBattlePassModel = BaseClass("UIBattlePassModel",UIBaseModel)
local base = UIBaseModel
local this = UIBattlePassModel

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type PassComponent
    local passComponent = Game.Scene.Player:GetComponent("PassComponent")
    self.pass = passComponent:GetCurrentBattlePass()

    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    local modules = gameEventComponent:GetGameEventModule()
    self.gameEventModule = nil
    for k, module in pairs(modules) do
        if module.config.ModuleType == GameEventModuleType.GameEventModulePass
            and module.status == GameEventStatus.GameEventStatusInProgress 
            and module.config.ModuleParams[1] == self.pass.id    then
                self.gameEventModule = module
                break
        end
    end
end

---@param self UIBattlePassModel
local function ON_PASS_UPDATE_PUSH(self)
    self:UIBroadcast(UIMessageNames.ON_PASS_UPDATE_PUSH)
end

---@param self UIBattlePassModel
local function ON_TASK_UPDATE(self, type)
    self:UIBroadcast(UIMessageNames.ON_TASK_UPDATE, type)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_PASS_UPDATE_PUSH,ON_PASS_UPDATE_PUSH)
    self:AddDataListener(DataMessageNames.ON_TASK_UPDATE,ON_TASK_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_PASS_UPDATE_PUSH)
    self:RemoveDataListener(DataMessageNames.ON_TASK_UPDATE)
end

return this
