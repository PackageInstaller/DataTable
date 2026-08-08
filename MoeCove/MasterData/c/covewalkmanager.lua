require "class"

---@class CoveWalkManager
local CoveWalkManager = class("CoveWalkManager")

function CoveWalkManager:ctor(...)
    self.m_coveWalkRole = {}
	--LuaLogger.es("CoveWalkManager =======",self.m_coveWalkRole )
end


---实例化
---@return CoveWalkManager CoveWalkManager
function CoveWalkManager.instance()
	if (CoveWalkManager._instance == nil) then
		CoveWalkManager._instance = CoveWalkManager:new()
	end
	return CoveWalkManager._instance
end


function CoveWalkManager:init(coveRoleMgr,coveActionCommon)
	self.m_coveRoleMgr = coveRoleMgr
	self.m_coveActionCommon = coveActionCommon
end

function CoveWalkManager:PushToWalk(coveRole)
	local index = tablex.indexof(self.m_coveWalkRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveWalkRole,coveRole)
    end
	--如果当前设置是出生在场景中
	self.m_coveActionCommon:PushToWalkCommon(coveRole,function(coveRole)
		self:RemoveFromWalk(coveRole)
	end)
end


function CoveWalkManager:PushToWalkChangeRoom(coveRole)
	local index = tablex.indexof(self.m_coveWalkRole,coveRole)
    if index == -1 then
        table.insert(self.m_coveWalkRole,coveRole)
    end

	self.m_coveActionCommon:PushToChangeRoomCommon(coveRole,function(coveRole)
		self:RemoveFromWalk(coveRole)
	end)

end


function CoveWalkManager:PushToWalkLeaveCove(coveRole)
	local index = tablex.indexof(self.m_coveWalkRole,coveRole)

    if index == -1 then
        table.insert(self.m_coveWalkRole,coveRole)
    end

	self.m_coveActionCommon:PushToLeaveCoveCommon(coveRole,function(coveRole)
		self:RemoveFromWalk(coveRole)
	end)
end

function CoveWalkManager:RemoveFromWalk(coveRole)
	--如果当前角色没有移除 ，并且当前角色是散步角色  ，或者随机角色


	self.m_coveActionCommon:RemoveFromCommon(coveRole,function(coveRole)
			self:RemoveFromWalk(coveRole)
		end,function()
			local index = tablex.indexof(self.m_coveWalkRole,coveRole)
			if index ~= -1 then
				table.remove(self.m_coveWalkRole,index)
			end
		end)
end


function CoveWalkManager:RemoveFromList(coveRole)
	local index = tablex.indexof(self.m_coveWalkRole,coveRole)
	if index ~= -1 then
		table.remove(self.m_coveWalkRole,index)
	end
end

return CoveWalkManager
