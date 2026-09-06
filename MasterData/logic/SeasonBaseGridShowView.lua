-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBaseGridShowView.lua

module("logic.extensions.season.view.SeasonBaseGridShowView", package.seeall)

local SeasonBaseGridShowView = class("SeasonBaseGridShowView", FlyTweenBase)

function SeasonBaseGridShowView:ctor()
	SeasonBaseGridShowView.super.ctor(self)
end

function SeasonBaseGridShowView:unbindEvents()
	SeasonBaseGridShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SeasonBaseGridShowView:bindEvents()
	SeasonBaseGridShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SeasonBaseGridShowView:buildUI()
	SeasonBaseGridShowView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._txtSure = self:getTxt("btnSure/Text")
	self._txtCostGo = self:getGo("txtCost")
	self._txtCost = self:getTxt("txtCost")
end

function SeasonBaseGridShowView:onExit()
	SeasonBaseGridShowView.super.onExit(self)
end

function SeasonBaseGridShowView:onEnter()
	SeasonBaseGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtConfig = params.evtConfig

	if self._txtDesc then
		self._txtDesc.text = params.strDesc or ""
	end

	if self._txtTitle then
		self._txtTitle.text = params.strTitle or ""
	end

	if self._txtSure then
		self._txtSure.text = params.strSure or lang("confirm")
	end

	self._sureCallback = params.sureCallback

	GameUtil.SetActive(self._btnSure, not params.bHideSure)
	GameUtil.SetActive(self._txtCostGo, not params.bHideSure)

	if self._txtCost and self._evtConfig then
		self._cost = checknumber(self._evtConfig.cost)

		if SeasonBadgeModel.instance:isBadgeCollectComplete() then
			self._cost = self._cost * SeasonConfig.instance:getCommonValue("ALL_MEDAL_STRENGTH_DISCOUNT", true)
		end

		for i, v in ipairs(SeasonModel.instance:getTotalMapBuffInfo()) do
			local cfg = SeasonConfig.instance:getMapBuffCfg(self._evtConfig.seasonId, v.buffId)

			if cfg and not string.nilorempty(cfg.clazz) and cfg.clazz == "DecStrengthCost" then
				local param = checknumber(cfg.param)

				self._cost = self._cost * (1 - param)
			end
		end

		if params.teamId then
			for i, v in ipairs(SeasonModel.instance:getMapBuffInfoByTeam(params.teamId)) do
				local cfg = SeasonConfig.instance:getMapBuffCfg(self._evtConfig.seasonId, v.buffId)

				if cfg and not string.nilorempty(cfg.clazz) and cfg.clazz == "DecStrengthCost" then
					local param = checknumber(cfg.param)

					self._cost = self._cost * (1 - param)
				end
			end
		end

		GameUtil.SetActive(self._txtCost, self._cost > 0)

		self._txtCost.text = self._cost
	else
		GameUtil.SetActive(self._txtCost, false)
	end

	if params.zoomTargetName then
		local seasonId = SeasonModel.instance:getSeasonId()
		local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)
		local presentor = ViewMgr.instance:getViewPresentor((not string.nilorempty(cfg.viewname) or nil) and cfg.viewname)

		if presentor then
			local go = GameUtil.findChildEx(presentor.mainGO, params.zoomTargetName)

			if go then
				local uiFlyParam = UIFlyTweenParam.New()

				uiFlyParam.endPosition = go.transform.position
				self._animCallback = params.animCallback

				self:_setUIFlyTweenParam(uiFlyParam)
			end
		end
	end
end

function SeasonBaseGridShowView:_onClickSure()
	local params = self:getFirstParam()

	if params.zoomTargetName then
		local function closeCallback()
			self:_onRealyClose()
			GameUtil.callBack(self._animCallback)
		end

		self:_doCloseCallback(closeCallback)
	else
		self:_onRealyClose()
	end
end

function SeasonBaseGridShowView:_onRealyClose()
	self:close()
	GameUtil.callBack(self._sureCallback)
end

return SeasonBaseGridShowView
