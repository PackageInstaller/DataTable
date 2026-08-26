-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiBtnView.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiBtnView", package.seeall)

local GMYeShuMeiBtnView = class("GMYeShuMeiBtnView", GMSubViewBase)

function GMYeShuMeiBtnView:ctor()
	self.tabName = "野树莓"
end

function GMYeShuMeiBtnView:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMYeShuMeiBtnView:getLineGroup()
	return "L" .. self.lineIndex
end

function GMYeShuMeiBtnView:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self.addButton(self, "L1", "打开野树莓编辑器", self._openGMYeShuMeiView, self)

	self._act211EpisodeId = self:addInputText("L2", nil, "关卡ID")

	self.addButton(self, "L2", "打开指定关卡", self._openGame, self)
	self.addButton(self, "L3", "打开选关界面", self._openLevelView, self)
	self.addButton(self, "L4", "完成当前关卡", self._finishCurrentGame, self)
	self:addLabel("L5", "鹭鸶剪")

	self._act211GameId = self:addInputText("L5", nil, "编辑器gameID")

	self.addButton(self, "L5", "打开指定关卡", self._openLuSiJianGame, self)

	self._act220EpisodeId = self:addInputText("L6", nil, "关卡ID")

	self.addButton(self, "L6", "打开指定关卡", self._openLuSiJianGameByEpisodeId, self)

	self.showToggle = self.addToggle(self, "L6", "显示配置点", self.onToggleValueChange, self)
	self._lorentzGameId = self:addInputText("L7", nil, "gameID")

	self.addButton(self, "L7", "打开指定关卡", self._openLorentzGame, self)
	self.addButton(self, "L8", "提示次数99", self.setMaxTipCount, self)
end

function GMYeShuMeiBtnView:_openGMYeShuMeiView()
	GMYeShuMeiModel.instance:clearData()
	YeShuMeiConfig.instance:_initYeShuMeiLevelData()
	ViewMgr.instance:openView(ViewName.GMYeShuMeiView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function GMYeShuMeiBtnView:_openGame()
	local episodeId = tonumber(self._act211EpisodeId:GetText())
	local episodeCo = YeShuMeiConfig.instance:getYeShuMeiEpisodeConfigById(VersionActivity3_1Enum.ActivityId.YeShuMei, episodeId)

	if not episodeCo then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	if episodeCo.gameId == 0 then
		GameFacade.showToastString("不是游戏关卡")

		return
	end

	YeShuMeiGameController.instance:enterGame(episodeId)
end

function GMYeShuMeiBtnView:_openLuSiJianGame()
	local gameId = tonumber(self._act211GameId:GetText())

	LuSiJianGameController.instance:enterTestGame(gameId)
end

function GMYeShuMeiBtnView:_openLuSiJianGameByEpisodeId()
	local episodeId = tonumber(self._act220EpisodeId:GetText())
	local episodeCo = LuSiJianConfig.instance:getLuSiJianEpisodeConfigById(VersionActivity3_4Enum.ActivityId.LuSiJian, episodeId)

	if not episodeCo then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	if episodeCo.gameId == 0 then
		GameFacade.showToastString("不是游戏关卡")

		return
	end

	LuSiJianGameController.instance:enterGame(episodeId)
end

function GMYeShuMeiBtnView:onToggleValueChange()
	local isOn = self.showToggle.isOn

	LuSiJianGameModel.instance:setShowPointState(isOn)
end

function GMYeShuMeiBtnView:_openLevelView()
	YeShuMeiController.instance:enterLevelView()
end

function GMYeShuMeiBtnView:_finishCurrentGame()
	local episodeId = YeShuMeiModel.instance:getCurEpisode()

	YeShuMeiController.instance:_onGameFinished(VersionActivity3_1Enum.ActivityId.YeShuMei, episodeId)
end

function GMYeShuMeiBtnView:_finishBeiLiErCurrentGame()
	local episodeId = BeiLiErModel.instance:getCurEpisode()

	BeiLiErController.instance:_onGameFinished(VersionActivity3_2Enum.ActivityId.BeiLiEr, episodeId)
end

function GMYeShuMeiBtnView:_openLorentzGame()
	local gameId = tonumber(self._lorentzGameId:GetText())

	LorentzGameController.instance:reallyEnterGame(gameId)
end

function GMYeShuMeiBtnView:setMaxTipCount()
	if ViewMgr.instance:isOpen(ViewName.LorentzGameView) then
		LorentzGameModel.instance:setMaxTipCount()
	end
end

return GMYeShuMeiBtnView
