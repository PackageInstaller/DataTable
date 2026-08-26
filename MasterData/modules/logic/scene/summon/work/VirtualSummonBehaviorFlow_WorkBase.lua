-- chunkname: @modules/logic/scene/summon/work/VirtualSummonBehaviorFlow_WorkBase.lua

module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_WorkBase", package.seeall)

local VirtualSummonBehaviorFlow_WorkBase = class("VirtualSummonBehaviorFlow_WorkBase", BaseWork)
local kTimeout = 3

function VirtualSummonBehaviorFlow_WorkBase:startBlock(optKey, optTimeout)
	local blockKey = optKey or self.class.__cname

	UIBlockHelper.instance:startBlock(blockKey, optTimeout or kTimeout)

	return blockKey
end

function VirtualSummonBehaviorFlow_WorkBase:endBlock(blockKey)
	UIBlockHelper.instance:startBlock(blockKey or self.class.__cname)
end

return VirtualSummonBehaviorFlow_WorkBase
