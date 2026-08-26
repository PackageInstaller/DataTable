-- chunkname: @modules/logic/versionactivity3_6/yami/controller/V3a6YaMiEvent.lua

module("modules.logic.versionactivity3_6.yami.controller.V3a6YaMiEvent", package.seeall)

local V3a6YaMiEvent = _M
local _get = GameUtil.getUniqueTb()

V3a6YaMiEvent.onInitInfo = _get()
V3a6YaMiEvent.onRefreshLevelExp = _get()
V3a6YaMiEvent.onRefreshCurrency = _get()
V3a6YaMiEvent.onUnlockHero = _get()
V3a6YaMiEvent.onUnlockSeat = _get()
V3a6YaMiEvent.onFinishLoadScene = _get()
V3a6YaMiEvent.onSelectHandbookProduct = _get()
V3a6YaMiEvent.onSelectHandbookHero = _get()
V3a6YaMiEvent.onSelectProductMaterial = _get()
V3a6YaMiEvent.onConfirmMatrials = _get()
V3a6YaMiEvent.onConfirmProductRecipe = _get()
V3a6YaMiEvent.onConfirmSelectHeros = _get()
V3a6YaMiEvent.onSelectHeroHandbook = _get()
V3a6YaMiEvent.onEnterPerform = _get()
V3a6YaMiEvent.onPausePerform = _get()
V3a6YaMiEvent.onContinuePerform = _get()
V3a6YaMiEvent.onFinishPerform = _get()
V3a6YaMiEvent.onReturnMainView = _get()
V3a6YaMiEvent.onMeetEvent = _get()
V3a6YaMiEvent.onFinishEvent = _get()
V3a6YaMiEvent.onSelectSkillHero = _get()
V3a6YaMiEvent.onTriggerSkill = _get()
V3a6YaMiEvent.onStartPerformStep = _get()
V3a6YaMiEvent.onRefreshMission = _get()
V3a6YaMiEvent.OnClickAllTaskFinish = _get()

return V3a6YaMiEvent
