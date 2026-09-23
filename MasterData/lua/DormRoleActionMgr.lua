require "DormRoleActionBase"

local this = {}

-- 申请一个行为
function this:Apply(actionType, dormRole)
    if (actionType == nil) then
        return nil
    end
    self.faClasses = self.faClasses or {}
	local targetClass = self.faClasses[actionType]
    if (not targetClass) then
        self.faClasses[actionType] = require(actionType)
		targetClass = self.faClasses[actionType]
    end
    local fa = oo.class(targetClass)
    fa:SetType(actionType)
    if (dormRole) then
        fa:SetData(dormRole)
    end
    return fa
end

return this
