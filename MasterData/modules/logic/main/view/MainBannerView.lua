-- chunkname: @modules/logic/main/view/MainBannerView.lua

module("modules.logic.main.view.MainBannerView", package.seeall)

local MainBannerView = class("MainBannerView", BaseView)

function MainBannerView:onInitView()
	self._clickbag = self:getUserDataTb_()
	self._iconbag = self:getUserDataTb_()
	self._bgbag = self:getUserDataTb_()
	self._banners = {}
	self._willDisapearBanner = 0

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainBannerView:addEvents()
	return
end

function MainBannerView:removeEvents()
	self:_clearAllClick()
end

function MainBannerView:_bannerOnClick(id)
	local co = MainBannerConfig.instance:getbannerCO(tonumber(id))
	local VanishingRules = string.split(co.vanishingRule, "#")

	if VanishingRules[1] == "2" then
		MainBannerModel.instance:addNotShowid(id)
		self:_refreshBanner()
	end

	if co.jumpId ~= 0 then
		GameFacade.jump(co.jumpId)
	end
end

function MainBannerView:_editableInitView()
	return
end

function MainBannerView:onUpdateParam()
	return
end

function MainBannerView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self:_refreshBanner()
end

function MainBannerView:_setBanner(time)
	local bannerco = MainBannerConfig.instance:getBannersCo()
	local banners = MainBannerConfig.instance:getNowBanner(time)

	for i = 1, 3 do
		self:_clearClick(i)

		local clickgo = gohelper.findChild(self.viewGO, "left/#go_banners/banner" .. i)

		gohelper.setActive(clickgo, false)
	end

	self._banners = {}

	for k, v in pairs(banners) do
		if v ~= nil then
			local clickgo = gohelper.findChild(self.viewGO, "left/#go_banners/banner" .. k)

			gohelper.setActive(clickgo, true)

			local click = SLFramework.UGUI.UIClickListener.Get(clickgo)
			local icon = gohelper.findChildSingleImage(clickgo, "bannericon")

			icon:LoadImage(ResUrl.getBannerIcon(bannerco[v].icon))
			table.insert(self._iconbag, icon)

			local info = {
				click,
				v
			}

			table.insert(self._clickbag, info)
			table.insert(self._banners, bannerco[v].id)
		end
	end

	for k, v in pairs(self._clickbag) do
		v[1]:AddClickListener(self._bannerOnClick, self, v[2])
	end
end

function MainBannerView:_setTimer(time)
	TaskDispatcher.cancelTask(self._refreshBanner, self)

	local disapear = MainBannerConfig.instance:getNearTime(time, self._banners)

	if disapear ~= nil then
		TaskDispatcher.runDelay(self._refreshBanner, self, disapear.time - time + 3)

		self._willDisapearBanner = disapear.id
	end
end

function MainBannerView:_disapearBanner()
	for k, v in pairs(self._banners) do
		if v == self._willDisapearBanner then
			self:_clearClick(k)

			local clickgo = gohelper.findChild(self.viewGO, "left/banners/banner" .. k)

			gohelper.setActive(clickgo, false)
		end
	end

	self:_setTimer(ServerTime.now())
end

function MainBannerView:_refreshBanner()
	local time = ServerTime.now()

	self:_setBanner(time)
	self:_setTimer(time)
end

function MainBannerView:_clearClick(index)
	if self._clickbag and self._clickbag[index] then
		self._clickbag[index][1]:RemoveClickListener()
	end
end

function MainBannerView:_clearAllClick()
	if self._clickbag then
		for _, v in pairs(self._clickbag) do
			v[1]:RemoveClickListener()
		end
	end
end

function MainBannerView:_onCloseFullView(viewName)
	if not ViewMgr.instance:hasOpenFullView() then
		self:_refreshBanner()
	end
end

function MainBannerView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function MainBannerView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshBanner, self)

	for _, v in pairs(self._iconbag) do
		v:UnLoadImage()
	end

	for _, v in pairs(self._bgbag) do
		v:UnLoadImage()
	end
end

return MainBannerView
