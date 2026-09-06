-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingRuleView.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingRuleView", package.seeall)

local WeakPathFindingRuleView = class("WeakPathFindingRuleView", ViewComponent)

function WeakPathFindingRuleView:buildUI()
	WeakPathFindingRuleView.super.buildUI(self)

	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._txtRuleL = self:getTxt("txtRuleL")
	self._txtRuleR = self:getTxt("txtRuleR")
	self._viewBGL = self:getGo("viewBgImaL")
	self._viewBGR = self:getGo("viewBgImaR")
	self._btnSure = self:getGo("sureBtn")
	self._keyRule = "weakpathfindingruleview"
end

function WeakPathFindingRuleView:bindEvents()
	WeakPathFindingRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function WeakPathFindingRuleView:unbindEvents()
	WeakPathFindingRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnSure)
end

function WeakPathFindingRuleView:onEnter()
	WeakPathFindingRuleView.super.onEnter(self)

	self._showId = 1
	self._ruleCfgs = WeakPathFindingConfig.instance:getRuleCfgs()

	self:_refreshView()
end

function WeakPathFindingRuleView:onExit()
	WeakPathFindingRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._viewBGL)
	uGuiUtil.clearImage(self._viewBGR)
end

function WeakPathFindingRuleView:_refreshView()
	goutil.setActive(self._btnLeft, self._showId - 2 > 0)
	goutil.setActive(self._btnRight, self._showId + 2 <= #self._ruleCfgs)

	local cfg = self._ruleCfgs[self._showId]

	self._txtRuleL.text = ""

	goutil.setActive(self._viewBGL, false)

	if cfg then
		self._txtRuleL.text = cfg.desc
		self._txtRuleR.text = cfg.desc

		if not string.nilorempty(cfg.resPath) then
			uGuiUtil.clearImage(self._viewBGL)

			local path = GameUrl.getBigbgPngUrl(cfg.resPath)

			uGuiUtil.setSpriteToImage(self._viewBGL, uGuiUtil.SpriteType.BigBg, path, function()
				goutil.setActive(self._viewBGL, true)
			end, self)
		end
	end

	cfg = self._ruleCfgs[self._showId + 1]
	self._txtRuleR.text = ""

	goutil.setActive(self._viewBGR, false)

	if cfg then
		self._txtRuleR.text = cfg.desc

		if not string.nilorempty(cfg.resPath) then
			uGuiUtil.clearImage(self._viewBGR)

			local path = GameUrl.getBigbgPngUrl(cfg.resPath)

			uGuiUtil.setSpriteToImage(self._viewBGR, uGuiUtil.SpriteType.BigBg, path, function()
				goutil.setActive(self._viewBGR, true)
			end, self)
		end
	end

	self._userData = checkint(GameUtil.getUserData(self._keyRule))

	if self._userData < self._showId then
		self._userData = self._showId

		GameUtil.saveUserData(self._keyRule, self._showId)
	end

	GameUtil.SetGray(self._btnSure, self._userData + 1 < #self._ruleCfgs)
end

function WeakPathFindingRuleView:_onClickLeft()
	self._showId = self._showId - 2

	self:_refreshView()
end

function WeakPathFindingRuleView:_onClickRight()
	self._showId = self._showId + 2

	self:_refreshView()
end

function WeakPathFindingRuleView:_onClickSure()
	if self._userData + 1 < #self._ruleCfgs then
		return
	end

	self:close()
end

return WeakPathFindingRuleView
