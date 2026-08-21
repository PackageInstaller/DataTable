local DormActionMgr = BaseClass("DormActionMgr", Singleton)
local M = DormActionMgr

function M:CreateDormAction(heroId)
    self.dormAction = nil
    
    for k, v in pairs(DormActionConfig) do
        if v.id == heroId and v.dormaction then
            local cls = require(v.dormaction)
            self.dormAction = cls.New(heroId)
        end
    end
end

function M:GetCurrentDormAction()
    if self.dormAction then
        return self.dormAction
    end
end

function M:Dispose()
    if self.dormAction and self.dormAction.Dispose then
        self.dormAction:Dispose()
    end
    
    self.dormAction = nil
end

function M:Cleanup()
    if self.dormAction and self.dormAction.Dispose then
        self.dormAction:Dispose()
    end
    
    self.dormAction = nil
end

return DormActionMgr
