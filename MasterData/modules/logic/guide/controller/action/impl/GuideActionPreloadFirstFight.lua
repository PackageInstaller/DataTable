-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionPreloadFirstFight.lua

module("modules.logic.guide.controller.action.impl.GuideActionPreloadFirstFight", package.seeall)

local GuideActionPreloadFirstFight = class("GuideActionPreloadFirstFight", BaseGuideAction)
local Config = {
	[1001] = {
		myModelIds = {
			100102,
			100101
		},
		mySkinIds = {
			302501,
			302301
		},
		enemyModelIds = {
			100103,
			100104
		},
		enemySkinIds = {
			410401,
			410501
		},
		subSkinIds = {}
	},
	[1002] = {
		myModelIds = {
			100102,
			100101
		},
		mySkinIds = {
			302501,
			302301
		},
		enemyModelIds = {
			100105,
			100106,
			100107
		},
		enemySkinIds = {
			410401,
			411401,
			410601
		},
		subSkinIds = {}
	},
	[1003] = {
		myModelIds = {
			100109
		},
		mySkinIds = {
			302301
		},
		enemyModelIds = {
			100108
		},
		enemySkinIds = {
			302501
		},
		subSkinIds = {}
	}
}

function GuideActionPreloadFirstFight:onStart(context)
	GuideActionPreloadFirstFight.super.onStart(self, context)

	if FightPreloadController.instance:isPreloading() then
		self:onDone(true)

		return
	end

	local battleId = tonumber(self.actionParam)
	local co = Config[battleId]

	if not battleId then
		logError("no preload config, battleId = " .. battleId)
		self:onDone(true)
	end

	local myModelIds = co.myModelIds
	local mySkinIds = co.mySkinIds
	local enemyModelIds = co.enemyModelIds
	local enemySkinIds = co.enemySkinIds
	local subSkinIds = co.subSkinIds

	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, 2)
	FightPreloadController.instance:preloadReconnect(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	self:onDone(true)
end

return GuideActionPreloadFirstFight
