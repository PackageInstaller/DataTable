-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/controller/ResourceDoubleActivitySystem.lua

ResourceDoubleActivityEvn = {
	kMapStage = "MAP",
	kExpStage = "EXP",
	kElite = "ELITE",
	kCrystalStage = "CRYSTAL",
	kGoldStage = "GOLD",
	kNormal = "NORMAL"
}
ResourceDoubleActivitySystem = class("ResourceDoubleActivitySystem", legs.Actor)

function ResourceDoubleActivitySystem:initialize(activitySystem)
	super.initialize(self)

	self._activitySystem = activitySystem
end

function ResourceDoubleActivitySystem:userInject(injector)
	return
end

function ResourceDoubleActivitySystem:dispose()
	super.dispose(self)
end

function ResourceDoubleActivitySystem:getResourceDoubleActivitys()
	return self._activitySystem:getActivitysByType("RESOURCEDOUBLE")
end

function ResourceDoubleActivitySystem:getDoubleResConfigByEvn(gameEvns)
	gameEvns = gameEvns or {}

	local activitys = self:getResourceDoubleActivitys()

	if #activitys > 0 then
		for i = 1, #activitys do
			local activity = activitys[i]

			if self._activitySystem:isActivityOpen(activity:getId()) then
				local gameEvnEffect = activity:getGameEvnEffect()

				for evn, effectConfig in pairs(gameEvnEffect) do
					for j = 1, #gameEvns do
						if evn == gameEvns[j] then
							return effectConfig
						end
					end
				end
			end
		end
	end

	return nil
end
