-- chunkname: @modules/logic/weekwalk_2/controller/WeekWalk_2Helper.lua

module("modules.logic.weekwalk_2.controller.WeekWalk_2Helper", package.seeall)

local WeekWalk_2Helper = class("WeekWalk_2Helper")

function WeekWalk_2Helper.setCupIcon(icon, cupInfo)
	if cupInfo then
		if not cupInfo.result then
			local result = 0

			UISpriteSetMgr.instance:setWeekWalkSprite(icon, "weekwalkheart_star" .. result)
		end
	end
end

function WeekWalk_2Helper.setCupEffect(go, cupInfo)
	if not go then
		return
	end

	if cupInfo then
		if not cupInfo.result then
			local result = WeekWalk_2Enum.CupType.None

			WeekWalk_2Helper.setCupEffectByResult(go, result)
		end
	end
end

function WeekWalk_2Helper.setCupEffectByResult(go, result)
	local transform = go.transform
	local childCount = transform.childCount
	local targetName = "star0" .. result

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		gohelper.setActive(child, child.name == targetName)
	end
end

return WeekWalk_2Helper
