-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaGameScene.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameScene", package.seeall)

local LanShouPaGameScene = class("LanShouPaGameScene", ChessGameScene)

function LanShouPaGameScene:_editableInitView()
	self._posuiGroundTbList = {}

	LanShouPaGameScene.super._editableInitView(self)
end

function LanShouPaGameScene:onResetGame()
	self:_resetMapId()
	self:_checkLoadMapScene()
	ChessGameModel.instance:clearRollbackNum()
	LanShouPaGameScene.super.onResetGame(self)
end

function LanShouPaGameScene:_resetMapId()
	ChessGameModel.instance:initData(ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId(), ChessGameModel.instance:getNowMapIndex())
end

function LanShouPaGameScene:_checkLoadMapScene()
	local newSceneUrl = ChessGameModel.instance:getNowMapResPath()

	if self._currentSceneResPath ~= newSceneUrl then
		UIBlockMgr.instance:startBlock(ChessGameScene.BLOCK_KEY)
		self.super.changeMap(self, newSceneUrl)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function LanShouPaGameScene:_onGamePointReturn()
	self:_checkLoadMapScene()
	LanShouPaGameScene.super.onResetGame(self)
end

function LanShouPaGameScene:loadResCompleted(loader)
	local oldSceneGo = self._sceneGo

	self._currentSceneResPath = ChessGameModel.instance:getNowMapResPath()

	LanShouPaGameScene.super.loadResCompleted(self, loader)

	if oldSceneGo then
		gohelper.destroy(oldSceneGo)
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)

	local episodeId = ChessModel.instance:getEpisodeId()

	self:_initEventCb()
end

function LanShouPaGameScene:_initEventCb()
	return
end

return LanShouPaGameScene
