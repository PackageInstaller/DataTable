require "class"

---@class CoveSwinManager
local CoveSwinManager = class("CoveSwinManager")

function CoveSwinManager:ctor(...)
    self.m_coveSwinRole = {}

end


---实例化
---@return CoveSwinManager CoveSwinManager
function CoveSwinManager.instance()
	if (CoveSwinManager._instance == nil) then
		CoveSwinManager._instance = CoveSwinManager:new()
	end
	return CoveSwinManager._instance
end


function CoveSwinManager:init(coveRoleMgr,coveActionCommon)
	self.m_coveRoleMgr = coveRoleMgr
	self.m_coveActionCommon = coveActionCommon
end

function CoveSwinManager:PushToSwin(coveRole)
	local index = tablex.indexof(self.m_coveSwinRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveSwinRole,coveRole)
    end
	if coveRole.data.coveRoleType == CoveRoleType.HomeWork then
		coveRole:ShowInWorkState()
	end
	self.m_coveActionCommon:PushToWalkCommon(coveRole,function(coveRole)
		self:RemoveFromSwin(coveRole)
	end,function(coveRole)
		coveRole:ChangeSkinNormalToSwin(false)
	end)


end

function CoveSwinManager:PushToSwinChangeRoom(coveRole)
	local index = tablex.indexof(self.m_coveSwinRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveSwinRole,coveRole)
    end
	if coveRole.data.coveRoleType == CoveRoleType.HomeWork then
		coveRole:ShowInWorkState()
	end
	self.m_coveActionCommon:PushToChangeRoomCommon(coveRole,function(coveRole)
		self:RemoveFromSwin(coveRole)
	end)

end

function CoveSwinManager:RemoveFromSwin(coveRole)


	self.m_coveActionCommon:RemoveFromCommon(coveRole,function(coveRole)
			self:RemoveFromSwin(coveRole)
		end,function()
			local index = tablex.indexof(self.m_coveSwinRole,coveRole)
			if index ~= -1 then
				table.remove(self.m_coveSwinRole,index)
			end
		end)
end

function CoveSwinManager:RemoveFromList(coveRole)
	local index = tablex.indexof(self.m_coveSwinRole,coveRole)
	if index ~= -1 then
		table.remove(self.m_coveSwinRole,index)
	end
end

return CoveSwinManager
