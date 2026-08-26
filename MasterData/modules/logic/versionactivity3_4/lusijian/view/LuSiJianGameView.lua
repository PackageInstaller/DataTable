-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianGameView.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianGameView", package.seeall)

local LuSiJianGameView = class("LuSiJianGameView", BaseView)

function LuSiJianGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goViewRoot = gohelper.findChild(self.viewGO, "PrefabRoot")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Tips/txt_Tips")
	self._goFinishTitle = gohelper.findChild(self.viewGO, "#go_FinishTitle")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LuSiJianGameView:addEvents()
	self.addEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.GameFinished, self._onGameFinish, self)
	self.addEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.CloseGameView, self._onCloseBtn, self)
	self.addEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.CompleteLine, self._updateTips, self)
end

function LuSiJianGameView:removeEvents()
	self.removeEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.GameFinished, self._onGameFinish, self)
	self.removeEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.CloseGameView, self._onCloseBtn, self)
	self.removeEventCb(self, LuSiJianGameController.instance, LuSiJianEvent.CompleteLine, self._updateTips, self)
end

function LuSiJianGameView:_onCloseBtn()
	LuSiJianController.instance:_onGameFinished(VersionActivity3_4Enum.ActivityId.LuSiJian, self._episodeId)
	self:closeThis()
end

function LuSiJianGameView:_editableInitView()
	gohelper.setActive(self._goTips, true)
	gohelper.setActive(self._goFinishTitle, false)
	self:_initGame()
end

function LuSiJianGameView:_initGame()
	self._gameConfig = LuSiJianGameModel.instance:getCurGameConfig()

	local prefabPath = self:getPrefabUrl()
	local prefabGo = prefabPath and self:getResInst(prefabPath, self._goViewRoot, "mainview")

	self._mainComp = MonoHelper.addNoUpdateLuaComOnceToGo(prefabGo, LuSiJianMainGameComp)

	self._mainComp:onInitView(prefabGo, self)
end

function LuSiJianGameView:getPrefabUrl()
	local path = "ui/viewres/versionactivity_3_4/v3a4_lusijian/%s.prefab"

	if self._gameConfig and self._gameConfig.source then
		return string.format(path, self._gameConfig.source)
	end
end

function LuSiJianGameView:onUpdateParam()
	return
end

function LuSiJianGameView:onOpen()
	self._episodeId = LuSiJianModel.instance:getCurEpisode()

	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "LuSiJianGameView", true)
end

function LuSiJianGameView:onClose()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "LuSiJianGameView", false)
end

function LuSiJianGameView:_onGameFinish()
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._goFinishTitle, true)
end

function LuSiJianGameView:_updateTips()
	self._txtTips.text = luaLang("p_v3a4_lusijian_gameview_txt_Tips2")
end

function LuSiJianGameView:onDestroyView()
	return
end

return LuSiJianGameView
