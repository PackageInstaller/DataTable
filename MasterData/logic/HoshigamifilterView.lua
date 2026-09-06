-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamifilterView.lua

module("logic.extensions.hoshigami.view.HoshigamifilterView", package.seeall)

local HoshigamifilterView = class("HoshigamifilterView", ViewComponent)

function HoshigamifilterView:ctor()
	HoshigamifilterView.super.ctor(self)
end

function HoshigamifilterView:buildUI()
	HoshigamifilterView.super.buildUI(self)

	self._qualitybg = self:getBtn("root/quality/bg")
	self._strengthbg = self:getBtn("root/strength/bg")
	self._powerbg = self:getBtn("root/power/bg")
	self._customInput = UICustomInput.Get(self:getGo("root"))
end

function HoshigamifilterView:bindEvents()
	HoshigamifilterView.super.bindEvents(self)
	self._qualitybg:AddClickListener(self._onClickQualitybg, self)
	self._strengthbg:AddClickListener(self._onClickStrengthbg, self)
	self._powerbg:AddClickListener(self._onClickPowerbg, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function HoshigamifilterView:unbindEvents()
	HoshigamifilterView.super.unbindEvents(self)
	self._qualitybg:RemoveClickListener()
	self._strengthbg:RemoveClickListener()
	self._powerbg:RemoveClickListener()
	self._customInput:RemoveListener()
end

function HoshigamifilterView:destroyUI()
	HoshigamifilterView.super.destroyUI(self)
end

function HoshigamifilterView:onEnter()
	HoshigamifilterView.super.onEnter(self)

	local params = self:getFirstParam()

	self._clickCallFunc = params.clickCallFunc
	self._clickCallFuncObj = params.clickCallFuncObj
end

function HoshigamifilterView:onEnterFinished()
	HoshigamifilterView.super.onEnterFinished(self)
end

function HoshigamifilterView:onExit()
	HoshigamifilterView.super.onExit(self)
end

function HoshigamifilterView:onExitFinished()
	HoshigamifilterView.super.onExitFinished(self)
end

function HoshigamifilterView:_onClickStrengthbg()
	if self._clickCallFunc then
		self._clickCallFunc(self._clickCallFuncObj, GameEnum.HoshigamiConditionFilter.Strength)
	end
end

function HoshigamifilterView:_onClickQualitybg()
	if self._clickCallFunc then
		self._clickCallFunc(self._clickCallFuncObj, GameEnum.HoshigamiConditionFilter.Quality)
	end
end

function HoshigamifilterView:_onClickPowerbg()
	if self._clickCallFunc then
		self._clickCallFunc(self._clickCallFuncObj, GameEnum.HoshigamiConditionFilter.Power)
	end
end

function HoshigamifilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return HoshigamifilterView
