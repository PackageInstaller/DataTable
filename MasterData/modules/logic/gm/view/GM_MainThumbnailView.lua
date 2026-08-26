-- chunkname: @modules/logic/gm/view/GM_MainThumbnailView.lua

module("modules.logic.gm.view.GM_MainThumbnailView", package.seeall)

local GM_MainThumbnailView = class("GM_MainThumbnailView")

function GM_MainThumbnailView.register()
	GM_MainThumbnailView.MainThumbnailRecommendView_register(MainThumbnailRecommendView)
	GM_MainThumbnailView.MainThumbnailBannerContent_register(MainThumbnailBannerContent)
end

function GM_MainThumbnailView.MainThumbnailRecommendView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(T, "_inOpenTime")
	GMMinusModel.instance:saveOriginalFunc(T, "_startAutoSwitch")
	GMMinusModel.instance:saveOriginalFunc(T, "_sort")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_MainThumbnailRecommendViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_MainThumbnailRecommendViewContainer.removeEvents(self)
	end

	function T.onOpen(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "onOpen", ...)
		SelfObj:_gm_stopBannerLoopAnimUpdate()
	end

	function T:_inOpenTime(co, ...)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			if not co then
				return true
			end

			local serverTime = ServerTime.now()
			local onlineTime = TimeUtil.stringToTimestamp(co.onlineTime)
			local offlineTime = TimeUtil.stringToTimestamp(co.offlineTime)
			local openTime = string.nilorempty(co.onlineTime) and serverTime or onlineTime
			local endTime = string.nilorempty(co.offlineTime) and serverTime or offlineTime

			if endTime < serverTime then
				return false
			end

			return co.isOffline == 0
		else
			return GMMinusModel.instance:callOriginalSelfFunc(self, "_inOpenTime", co, ...)
		end
	end

	function T:_startAutoSwitch(...)
		if not GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			return GMMinusModel.instance:callOriginalSelfFunc(self, "_startAutoSwitch", ...)
		end
	end

	function T._sort(a, b)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			local serverTime = ServerTime.now()
			local aStartTs = string.nilorempty(a.onlineTime) and serverTime or TimeUtil.stringToTimestamp(a.onlineTime)
			local bStartTs = string.nilorempty(b.onlineTime) and serverTime or TimeUtil.stringToTimestamp(b.onlineTime)

			if aStartTs ~= bStartTs then
				return bStartTs < aStartTs
			end

			return a.order < b.order
		else
			return GMMinusModel.instance:callOriginalStaticFunc(T, "_sort", a, b)
		end
	end

	function T._gm_showAllBannerUpdate(SelfObj)
		SelfObj:_clearPages()
		SelfObj:_initPages()
		SelfObj:_gm_stopBannerLoopAnimUpdate()
	end

	function T._gm_showAllTabIdUpdate(SelfObj)
		SelfObj:_clearPages()
		SelfObj:_initPages()
		SelfObj:_gm_stopBannerLoopAnimUpdate()
	end

	function T._gm_stopBannerLoopAnimUpdate(SelfObj)
		if GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			TaskDispatcher.cancelTask(SelfObj._onSwitch, SelfObj)
		else
			SelfObj:_startAutoSwitch()
		end
	end
end

function GM_MainThumbnailView.MainThumbnailBannerContent_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "loadBanner")

	function T.loadBanner(SelfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(SelfObj, "loadBanner", ...)

		local config = SelfObj._config
		local showDesc = config.des

		if GM_MainThumbnailRecommendView.s_ShowAllTabId then
			showDesc = gohelper.getRichColorText("==========> id:" .. tostring(config.id), "#00FF00") .. showDesc
		end

		SelfObj._txtdesc.text = showDesc

		gohelper.setActive(SelfObj._txtdesc.gameObject, GM_MainThumbnailRecommendView.s_ShowAllTabId)
	end
end

return GM_MainThumbnailView
