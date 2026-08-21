-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonSummarizeView.lua

module("logic.extensions.season.view.SeasonSummarizeView", package.seeall)

local M = class("SeasonSummarizeView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._rawimageBlurRT = self:getUIComponent("0&common_blur_rt_-2028819737", UIComponentType.RawImage)
	self._goContent1 = self:getGo("season_summarize_view_384171984")

	goutil.setActive(self._goContent1, false)

	self._goContent2 = self:getGo("season_summarize_view_506307430")
	self._btnOpen = self:getBtn("season_summarize_view_19846955")
	self._txtScore = self:getText("season_summarize_view_865716383")
	self._txtTaskValue = self:getText("season_summarize_view_142369004")

	local gradeGO = goutil.findChild(self._goContent2, "fcpy_grade_content")

	self._gradeComp = Astral.LuaComponentContainer.Add(gradeGO, SeasonGradeComp)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnOpen:AddClickListener(self._onClickBtnOpen, self)
end

function M:unbindEvents()
	self._btnOpen:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Season)
	SeasonModel.instance:setNew(false)
	SeasonModel.instance:clearSummarize()

	local info = self:getFirstParam() or {}

	self._exitCallBackFunc = info.callBackFunc
	self._exitCallBackHandle = info.callBackHandle

	self:refreshView()
end

function M:onExit()
	if self._exitCallBackFunc and self._exitCallBackHandle then
		self._exitCallBackFunc(self._exitCallBackHandle)
	end

	self._exitCallBackHandle = nil
	self._exitCallBackFunc = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Season)
end

function M:refreshView()
	local lv = SeasonModel.instance:getLastSeasonLv()
	local maxLv = SeasonConfig.instance:getMaxLv()
	local lastScore = SeasonModel.instance:getLastSeasonScore()
	local lastTaskPoint = SeasonModel.instance:getLastSeasonTaskPoint()
	local upgradeScore = SeasonConfig.instance:getScorePerLv()

	self._gradeComp:showLvAnim(lv)

	if lv < maxLv then
		local score = math.fmod(lastScore, upgradeScore)

		self._gradeComp:setProgress(score, upgradeScore, true)
	else
		self._gradeComp:setProgress(upgradeScore, upgradeScore, true)
	end

	self._txtScore.text = MathUtil.getCoinValue(lastScore)
	self._txtTaskValue.text = MathUtil.getCoinValue(lastTaskPoint)
end

function M:_onClickBtnOpen()
	self:close()
	SeasonFacade.instance:enterSeasonMainView()
end

return M
