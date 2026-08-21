-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/facade/RetrieveFacade.lua

module("logic.extensions.retrieve.facade.RetrieveFacade", package.seeall)

local M = class("RetrieveFacade")

function M:registerView(view)
	local views = view._viewPresentor._views

	self._isRegistered = true
	self._mainView = views[1]
	self._prayView = views[2]
end

function M:unregisterView()
	if not self:_checkView() then
		return false
	end

	self._isRegistered = false
	self._mainView = false
	self._prayView = false
end

function M:_checkView()
	if not self._isRegistered then
		printWarn("StoryMainView:need to register view first!")

		return false
	end

	return true
end

function M:registerShowRoleView(view)
	self._showRoleView = view
end

function M:unregisterShowRoleView()
	self._showRoleView = false
end

function M:tryForceLottery(showItems)
	local len = #showItems
	local needForceLottery = false

	if len == 1 then
		local itemData = showItems[len]

		if CommEnum.CurrencyCodeEnum.JsjjCode == itemData:getItemId() then
			needForceLottery = true
		end
	end

	if not needForceLottery then
		return
	end

	if self._mainView then
		self._mainView:forceConfirmBuy()
	end

	if ViewMgr.instance:isOpen(ViewName.RetrieveTenCardShowViewViewPresentor) then
		ViewMgr.instance:close(ViewName.RetrieveTenCardShowViewViewPresentor, false, WindowType.WindowCloseReasonType.QuickCloseType)
	end

	RetrieveController.instance:tryForceLottery()
end

function M:clearLotteryFlag()
	if self._mainView then
		self._mainView:clearLotteryOneFlag()
	end
end

function M:showGetRole(heroId, conversion, showType, index, isNew)
	local data = {
		heroId = heroId,
		conversion = conversion,
		showType = showType or RetrieveEnum.ShowRoleType.Other,
		index = index,
		isNew = isNew
	}

	if ViewMgr.instance:isOpen(ViewName.RetrieveRoleShowViewViewPresentor) then
		RetrieveDispatcher:dispatchEvent(RetrieveEventType.Show_Hero_Info, data)
	else
		ViewMgr.instance:open(ViewName.RetrieveRoleShowViewViewPresentor, data)
	end

	GlobalDispatcher:dispatchEvent(EventType.GET_ROLE_VIEW_OPEN)
end

function M:showRoleEnterAnim()
	if self._showRoleView then
		self._showRoleView:showEnterAnim()
	end
end

function M:showPrayView(heroId, lotteryData, callBack, callbackHandle)
	if not self:_checkView() then
		return false
	end

	self._prayView:showPrayHeroInfo(heroId, lotteryData, callBack, callbackHandle)
end

function M:setPrayState(active)
	if not self:_checkView() then
		return false
	end

	self._prayView:setPrayState(active)
end

M.instance = M.New()

return M
