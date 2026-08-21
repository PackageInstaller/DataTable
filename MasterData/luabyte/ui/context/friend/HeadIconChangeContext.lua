local HeadIconChangeContext = BaseClass("HeadIconChangeContext", BaseContext)
local M = HeadIconChangeContext

function M:Init()
end

function M:Open(callback)
    local curHeadIcon = IPlayerData.headIcon
    local configs = ConfigHelper.GetCfgsByLua("headIcon")
    local headIcons = {}
    for key, value in pairs(configs) do
        local data = {}
        data.isUsed = value.id == curHeadIcon
        data.isSelect = value.id == curHeadIcon
        data.unlock = GameHelper.CheckLockByOpenConditionId(value.openCondition)
        data.cfg = value
        table.insert(headIcons, data)
    end
    table.sort(headIcons, function(a, b)
        local aunlock = a.unlock
        local bunlock = b.unlock
        if aunlock or bunlock then
            if aunlock and not bunlock then
                return aunlock
            elseif not aunlock and bunlock then
                return aunlock
            elseif aunlock and bunlock then
                return a.cfg.order < b.cfg.order
            end
        else
            return a.cfg.order < b.cfg.order
        end
        return false
    end)
    self:_Show(curHeadIcon, headIcons, callback)
end

function M:OnClose()
    M.super.OnClose(self)
end

return HeadIconChangeContext
