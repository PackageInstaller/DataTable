-- chunkname: @modules/logic/versionactivity1_3/va3chess/controller/Va3ChessViewController.lua

module("modules.logic.versionactivity1_3.va3chess.controller.Va3ChessViewController", package.seeall)

local Va3ChessViewController = class("Va3ChessViewController", BaseController)

function Va3ChessViewController:_initResisterFunc()
	self._viewTypeFuncDict = {
		[Va3ChessEnum.ViewType.Reward] = self:_registerRewardViewFunc()
	}
end

function Va3ChessViewController:_registerRewardViewFunc()
	return {
		[Va3ChessEnum.ActivityId.Act142] = function(interactCo, param)
			ViewMgr.instance:openView(ViewName.Activity142GetCollectionView, param)
		end
	}
end

function Va3ChessViewController:_openView(viewType, actId, param1, param2, param3, param4)
	if not self._viewTypeFuncDict then
		self:_initResisterFunc()
	end

	local funcDict = self._viewTypeFuncDict[viewType]

	if funcDict[actId] then
		funcDict[actId](param1, param2, param3, param4)

		return true
	end

	return false
end

function Va3ChessViewController:openRewardView(actId, interactCo, param)
	return self:_openView(Va3ChessEnum.ViewType.Reward, actId, interactCo, param)
end

Va3ChessViewController.instance = Va3ChessViewController.New()

return Va3ChessViewController
