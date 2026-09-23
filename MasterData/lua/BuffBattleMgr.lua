BuffBattleMgr = MgrRegister("BuffBattleMgr")
local this = BuffBattleMgr

function this:Init()
    self:Clear()
end

function this:SetIDs(ids)
    if ids then
        self.ids = {}
        for k, v in pairs(ids) do
            if v~=nil then
                table.insert(self.ids,k)
            end
        end
    end
end

function this:GetIDs()
    return self.ids
end

function this:ClearIDs()
    self.ids = nil
end

function this:Clear()
    self:ClearIDs()
end

return this