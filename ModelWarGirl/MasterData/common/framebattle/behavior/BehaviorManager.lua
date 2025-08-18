-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Behavior\\BehaviorManager.lua

local Behavior = require("Common/FrameBattle/Behavior/Behavior")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "BehaviorManager"
local BehaviorManager = GLDeclare(strClassName, Class(strClassName))

function BehaviorManager:ctor()
	assert(BehaviorManager._instance == nil, "[ERROR] The BehaviorManager instance is created already!")

	self.mBehaviors = {}
	self.orderBehaviors = {}
end

function BehaviorManager:destroy()
	self.mBehaviors = nil
end

function BehaviorManager:addBehavior(entityID, bh)
	if self.mBehaviors[entityID] then
		return false
	end

	self.mBehaviors[entityID] = bh

	table.insert(self.orderBehaviors, entityID)

	return true
end

function BehaviorManager:delBehavior(entityID)
	if self.mBehaviors[entityID] then
		self.mBehaviors[entityID] = nil

		for index, eid in ipairs(self.orderBehaviors) do
			if eid == entityID then
				table.remove(self.orderBehaviors, index)

				break
			end
		end

		return true
	else
		return false
	end
end

function BehaviorManager:tick()
	for index, id in ipairs(self.orderBehaviors) do
		local bh = self.mBehaviors[id]

		bh:tick()
	end

	for index, id in ipairs(self.orderBehaviors) do
		local bh = self.mBehaviors[id]

		bh:handleEventList()
	end
end

return BehaviorManager
