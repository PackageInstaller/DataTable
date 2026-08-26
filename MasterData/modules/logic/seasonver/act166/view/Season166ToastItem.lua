-- chunkname: @modules/logic/seasonver/act166/view/Season166ToastItem.lua

module("modules.logic.seasonver.act166.view.Season166ToastItem", package.seeall)

local Season166ToastItem = class("Season166ToastItem", UserDataDispose)

function Season166ToastItem:init(toastItem, toastParams)
	self:__onInit()

	self._toastItem = toastItem
	self._toastParams = toastParams
	self._rootGO = self._toastItem:getToastRootByType(ToastItem.ToastType.Season166)

	self:_onUpdate()
end

Season166ToastItem.ToastGOName = "Season166ToastItem"

function Season166ToastItem:_onUpdate()
	self.viewGO = gohelper.findChild(self._rootGO, Season166ToastItem.ToastGOName)

	if not self.viewGO then
		local toastPrefab = Season166Controller.instance:tryGetToastAsset(self._onToastLoadedCallBack, self)

		if toastPrefab then
			self.viewGO = gohelper.clone(toastPrefab, self._rootGO, Season166ToastItem.ToastGOName)
		end
	end

	if self.viewGO then
		self:initComponents()
		self:refreshUI()
	end
end

function Season166ToastItem:_onToastLoadedCallBack(loader)
	self:_onUpdate()
end

function Season166ToastItem:initComponents()
	if self.viewGO then
		self._txtToast = gohelper.findChildText(self.viewGO, "#go_tips/txt_tips")
		self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_tips/icon")
	end
end

function Season166ToastItem:refreshUI()
	self._txtToast.text = tostring(self._toastParams.toastTip)

	if not self._toastParams.icon then
		UISpriteSetMgr.instance:setSeason166Sprite(self._imageIcon, string.format("season166_result_tipsicon%s", self._toastParams.icon))
		self._toastItem:setToastType(ToastItem.ToastType.Season166)
	end
end

function Season166ToastItem:dispose()
	if self._toastLoader then
		self._toastLoader:dispose()

		self._toastLoader = nil
	end

	if self._simageAssessIcon then
		self._simageAssessIcon:UnLoadImage()
	end

	self._toastItem = nil
	self._toastParams = nil

	self:__onDispose()
end

return Season166ToastItem
