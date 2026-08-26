-- chunkname: @modules/logic/sodache/controller/SodacheController.lua

module("modules.logic.sodache.controller.SodacheController", package.seeall)

local SodacheController = class("SodacheController", BaseController)

function SodacheController:addConstEvents()
	if isDebugBuild then
		GMController.instance:registerCallback(GMController.Event.OnRecvGMMsg, self._onRecvGMMsg, self)
	end
end

function SodacheController:_onRecvGMMsg()
	SodacheMapUtil.instance:tryStartFlow("", SodacheModel.instance:getInsideMo() and true or false)
end

function SodacheController:enterScene()
	SodacheOutsideRpc.instance:sendSodacheOutsideGetScene(self._onRecvMsg, self)
end

function SodacheController:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		if SodacheUtil.isInside() then
			SodacheInsideRpc.instance:sendSodacheInsideGetScene(self._onRecvMsg2, self)
		elseif GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
			ViewMgr.instance:openView(ViewName.SodacheMainView)
		else
			DungeonModel.instance:resetSendChapterEpisodeId()
			MainController.instance:enterMainScene(true)
			SceneHelper.instance:waitSceneDone(SceneType.Main, function()
				GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.SodacheMainView)
				ViewMgr.instance:openView(ViewName.SodacheMainView)
			end)
		end
	else
		NavigateButtonsView.homeClick()
	end
end

function SodacheController:_onRecvMsg2(cmd, resultCode, msg)
	if resultCode == 0 then
		self:realEnterInsideScene()
	else
		NavigateButtonsView.homeClick()
	end
end

function SodacheController:realEnterInsideScene()
	if ViewMgr.instance:isOpen(ViewName.SodacheMapView) then
		return
	end

	SodacheStatHelper.instance:startStat()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		ViewMgr.instance:openView(ViewName.SodacheMapView)
		ViewMgr.instance:closeView(ViewName.SodacheMainView)
	else
		DungeonModel.instance:resetSendChapterEpisodeId()
		MainController.instance:enterMainScene(true)
		SceneHelper.instance:waitSceneDone(SceneType.Main, function()
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.SodacheMapView)
			ViewMgr.instance:openView(ViewName.SodacheMapView)
			ViewMgr.instance:closeView(ViewName.SodacheMainView)
		end)
	end
end

function SodacheController:exitScene()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		ViewMgr.instance:closeView(ViewName.SodacheMainView)
		ViewMgr.instance:closeView(ViewName.SodacheMapView)
	else
		MainController.instance:enterMainScene(true)
	end
end

function SodacheController:openStoreView(actId)
	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function SodacheController:_openStoreViewAfterRpc(_, resultCode)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.SodacheStoreView)
	end
end

SodacheController.instance = SodacheController.New()

return SodacheController
