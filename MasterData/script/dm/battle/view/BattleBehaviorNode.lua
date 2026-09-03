-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleBehaviorNode.lua

BattleMoveBehaviorNode = class("BattleMoveBehaviorNode", BaseBehaviorNode)

function BattleMoveBehaviorNode:initialize(record)
	super.initialize(self)

	self.record = record
end

function BattleMoveBehaviorNode:start()
	local ctx = self.context
	local record = self.record
	local duration = record.dur / 1000
	local targetPos

	if record.dst then
		local dst = record.dst
		local zone = dst[1]

		if ctx:isTeamFlipped() then
			zone = -zone
		end

		local battleGround = ctx:getBattleGround()

		targetPos = battleGround:relPosWithZoneAndOffset(zone, dst[2], dst[3])
	elseif record.disp then
		-- block empty
	end

	ctx:moveWithDuration(targetPos, duration, function()
		self:finish(BehaviorResult.Success)
	end)
end

BattleActionBehaviorNode = class("BattleActionBehaviorNode", BaseBehaviorNode)

function BattleActionBehaviorNode:initialize(record)
	super.initialize(self)

	self.record = record
end

function BattleActionBehaviorNode:start()
	local ctx = self.context
	local record = self.record
	local actName = record.name
	local params = string.split(actName, ":")

	if #params == 2 then
		actName = params[1]
		record.specialEvts = params[2]
	end

	local always = true

	ctx:switchState(actName, record, always, function()
		self:finish(BehaviorResult.Success)
	end)
end
