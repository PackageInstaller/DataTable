-- chunkname: @modules/logic/season/controller/Activity104Controller.lua

module("modules.logic.season.controller.Activity104Controller", package.seeall)

local Activity104Controller = class("Activity104Controller", BaseController)

function Activity104Controller:onInit()
	return
end

function Activity104Controller:onInitFinish()
	return
end

function Activity104Controller:openSeasonMainView(param)
	local actId = Activity104Model.instance:getCurSeasonId()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return
	end

	local function func()
		local storyIds = SeasonConfig.instance:getStoryIds(actId)

		if storyIds[1] ~= 0 and not StoryModel.instance:isStoryFinished(storyIds[1]) then
			StoryController.instance:playStories(storyIds, nil, self.onStoryBack, self, param)

			return
		end

		SeasonViewHelper.openView(actId, Activity104Enum.ViewName.MainView, param)
	end

	if Activity104Model.instance:tryGetActivityInfo(actId, func) then
		func()
	end
end

function Activity104Controller:onStoryBack(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	Activity104Rpc.instance:sendMarkActivity104StoryRequest(actId)
	Activity104Controller.instance:openSeasonMainView(param)
end

function Activity104Controller:openSeasonMarketView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.MarketView, param)
end

function Activity104Controller:openSeasonSpecialMarketView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.SpecialMarketView, param)
end

function Activity104Controller:openSeasonTaskView()
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.TaskView)
end

function Activity104Controller:openSeasonCardBook()
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.EquipBookView)
end

function Activity104Controller:openSeasonEquipView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.EquipView, param)
end

function Activity104Controller:openSeasonEquipHeroView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.EquipHeroView, param)
end

function Activity104Controller:openSeasonFightRuleTipView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.FightRuleTipView, param)
end

function Activity104Controller:openSeasonRetailView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.RetailView, param)
end

function Activity104Controller:openSeasonRetailLevelInfoView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.RetailLevelInfoView, param)
end

function Activity104Controller:openSeasonHeroGroupFightView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.HeroGroupFightView, param)
end

function Activity104Controller:openSeasonSettlementView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.SettlementView, param)
end

function Activity104Controller:openSeasonFightSuccView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.FightSuccView, param)
end

function Activity104Controller:openSeasonEquipSelectChoiceView(param, forceOpen)
	if not forceOpen then
		local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)

		if not isOpen then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.GuideView) then
			return
		end
	end

	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.EquipSelfChoiceView, param)
end

function Activity104Controller:checkShowEquipSelfChoiceView(forceOpen)
	if not forceOpen then
		local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)

		if not isOpen then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.GuideView) then
			return
		end
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local optionalItems = Activity104Model.instance:getOptionalAct104Equips(actId)

	if #optionalItems > 0 then
		local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.EquipSelfChoiceView)

		for i = 1, #optionalItems do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, viewName, {
				actId = actId,
				costItemUid = optionalItems[i].uid
			})
		end
	end
end

function Activity104Controller:openSeasonCelebrityCardTipView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.CelebrityCardTipView, param)
end

function Activity104Controller:openSeasonAdditionRuleTipView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.AdditionRuleTipView, param)
end

function Activity104Controller:openSeasonCelebrityCardGetlView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.CelebrityCardGetlView, param)
end

function Activity104Controller:openSeasonFightFailView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.FightFailView, param)
end

function Activity104Controller:openSeasonSumView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.SumView, param)
end

function Activity104Controller:openSeasonStoreView()
	local actId = Activity104Model.instance:getCurSeasonId()
	local viewName = SeasonViewHelper.getViewName(actId, Activity104Enum.ViewName.StoreView)
	local storeActId = Activity104Enum.SeasonStore[actId]

	self:enterVersionActivityView(viewName, storeActId, function()
		Activity107Rpc.instance:sendGet107GoodsInfoRequest(storeActId, function()
			ViewMgr.instance:openView(viewName, {
				actId = storeActId
			})
		end)
	end)
end

function Activity104Controller:openSeasonStoryView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.StoryView, param)
end

function Activity104Controller:openSeasonStoryPagePopView(param)
	local actId = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(actId, Activity104Enum.ViewName.StoryPagePopView, param)
end

function Activity104Controller:closeSeasonView(viewName, isImmediate, closeManually)
	local actId = Activity104Model.instance:getCurSeasonId()
	local realViewName = SeasonViewHelper.getViewName(actId, viewName)

	ViewMgr.instance:closeView(realViewName, isImmediate, closeManually)
end

function Activity104Controller:enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

Activity104Controller.instance = Activity104Controller.New()

return Activity104Controller
