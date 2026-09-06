-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/controller/DivinekingjiclgController.lua

module("logic.extensions.divinekingjiclg.controller.DivinekingjiclgController", package.seeall)

local DivinekingjiclgController = class("DivinekingjiclgController", BaseController)

function DivinekingjiclgController:ctor()
	return
end

function DivinekingjiclgController:onInit()
	self:onReset()
end

function DivinekingjiclgController:onReset()
	return
end

function DivinekingjiclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(221)
end

function DivinekingjiclgController:isClgPass(activityId)
	local info = DivinekingjiclgModel.instance:getInfo(activityId)
	local stageCfgs = DivinekingjiclgConfig.instance:getStageCfgs(activityId)

	return info.curPassStageId >= #stageCfgs
end

function DivinekingjiclgController:onClgNotifyFightRes(msg)
	self._fightResMsg = msg

	BattleFacade.instance:registerResultHandler(self.onBattleEnd, self)
end

function DivinekingjiclgController:onBattleEnd()
	local msg = self._fightResMsg

	self._fightResMsg = nil

	if not msg.win then
		return false
	end

	UIStateManager.instance:push(ViewName.DivinekingjiclgresultView, msg)

	return true
end

function DivinekingjiclgController:onConfirmRes(msg)
	DivinekingjiclgModel.instance:onConfirmRes(msg)

	if msg.confirm then
		local stageCfgs = DivinekingjiclgConfig.instance:getStageCfgs(msg.activityId)

		if msg.stageId >= #stageCfgs then
			UIJumper.instance:removeTopState(ViewName.DivinekingjiclgstageView)
		end
	end
end

function DivinekingjiclgController:tryShowChangeSetId()
	local ci = DivinekingjiclgModel.instance:getSaveChangeSetId()

	if ci > 0 then
		MaterialController.instance:showChangeSetInTemp(ci)
		DivinekingjiclgModel.instance:saveChangeSetId(0)
	end
end

DivinekingjiclgController.instance = DivinekingjiclgController.New()

return DivinekingjiclgController
