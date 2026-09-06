-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/controller/YearScratchController.lua

module("logic.extensions.yirenpozhen.controller.YearScratchController", package.seeall)

local YearScratchController = class("YearScratchController", BaseController)

function YearScratchController:ctor()
	return
end

function YearScratchController:onInit()
	return
end

function YearScratchController:onReset()
	self._tempChangeSetId = nil
end

function YearScratchController:handlePM_YearScratchInfoRes(msg)
	YearScratchModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YearScratchRefresh)
end

function YearScratchController:handlePM_YearScratchGainPrizeRes(msg)
	YearScratchModel.instance:gainPrize(msg.cycleId)

	if msg.changeSetId and msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._tempChangeSetId = msg.changeSetId
	end

	GlobalDispatcher:dispatch(GlobalNotify.YearScratchRefresh)
end

function YearScratchController:handlePM_YearScratchGainGodGemRes(msg)
	YearScratchModel.instance:gainGodGem()
	GlobalDispatcher:dispatch(GlobalNotify.YearScratchGainPrize)
end

function YearScratchController:showSaveChangeSet()
	if self._tempChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._tempChangeSetId)
	end

	self._tempChangeSetId = nil
end

YearScratchController.instance = YearScratchController.New()

return YearScratchController
