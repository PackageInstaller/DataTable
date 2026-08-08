require "class"

---@class CoveWorkManager
local CoveWorkManager = class("CoveWorkManager")

function CoveWorkManager:ctor(...)
    self.m_coveWorkRole = {}

end


---实例化
---@return CoveWorkManager CoveWorkManager
function CoveWorkManager.instance()
	if (CoveWorkManager._instance == nil) then
		CoveWorkManager._instance = CoveWorkManager:new()
	end
	return CoveWorkManager._instance
end

function CoveWorkManager:init(coveRoleMgr,coveActionCommon)
	self.m_coveRoleMgr = coveRoleMgr
	self.m_coveActionCommon = coveActionCommon
end
function CoveWorkManager:PushToWork(coveRole)
	local index = tablex.indexof(self.m_coveWorkRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveWorkRole,coveRole)
    end
	coveRole:ShowInWorkState()
	self.m_coveActionCommon:PushToWalkCommon(coveRole,function(coveRole)
		self:RemoveFromWork(coveRole)
	end)
	
end


function CoveWorkManager:PushToWorkChangeRoom(coveRole)
	local index = tablex.indexof(self.m_coveWorkRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveWorkRole,coveRole)
    end

	coveRole:ShowInWorkState()
	self.m_coveActionCommon:PushToChangeRoomCommon(coveRole,function(coveRole)
		self:RemoveFromWork(coveRole)
	end)

end

function CoveWorkManager:RemoveFromWork(coveRole)


	self.m_coveActionCommon:RemoveFromCommon(coveRole,function(coveRole)
			self:RemoveFromWork(coveRole)
		end,function()
			local index = tablex.indexof(self.m_coveWorkRole,coveRole)
			if index ~= -1 then
				table.remove(self.m_coveWorkRole,index)
			end

			coveRole:HideWorkState()
		end)
end


function CoveWorkManager:RemoveFromList(coveRole)
	local index = tablex.indexof(self.m_coveWorkRole,coveRole)
	if index ~= -1 then
		table.remove(self.m_coveWorkRole,index)
	end
end

return CoveWorkManager
