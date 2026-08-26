-- chunkname: @modules/logic/abyss/controller/AbyssEvent.lua

module("modules.logic.abyss.controller.AbyssEvent", package.seeall)

local AbyssEvent = _M
local _get = GameUtil.getUniqueTb()

AbyssEvent.OnGetActInfo = _get()
AbyssEvent.OnUpdateStageInfo = _get()
AbyssEvent.OnResetStage = _get()
AbyssEvent.OnSelectStage = _get()
AbyssEvent.OnGetTaskReward = _get()
AbyssEvent.OnAbyssTaskUpdate = _get()
AbyssEvent.OnAbyssMainViewClose = _get()
AbyssEvent.OnAbyssLastUpdateTimeChange = _get()
AbyssEvent.OnAbyssRecommendHeroRemove = _get()

return AbyssEvent
