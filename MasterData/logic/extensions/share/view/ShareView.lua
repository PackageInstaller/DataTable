-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareView.lua

module("logic.extensions.share.view.ShareView", package.seeall)

local ShareView = class("ShareView", ViewComponent)

function ShareView:ctor()
	ShareView.super.ctor(self)

	self._shareType = ShareEnum.One
	self._isShowQRCode = true
end

function ShareView:buildUI()
	self._goBlurBg = self:getGo("common_blur_rt_-2028819737")
	self._goContent = self:getGo("share_view_-1123199888")
	self._rawImg = self:getUIComponent("share_view_2057936528", UIComponentType.RawImage)
	self._btnClose = self:getBtn("share_view_-503069586")
	self._btnShare = self:getBtn("share_view_-802839422")
	self._btnSave = self:getBtn("share_view_879504958")
	self._btnWeiBo = self:getBtn("share_view_495628025")
	self._btnWeiXin = self:getBtn("share_view_-1675864528")
	self._btnWeiXinPengyouQuan = self:getBtn("share_view_424679451")
	self._btnQQ = self:getBtn("share_view_-1710787510")
	self._btnQQSpace = self:getBtn("share_view_-603207725")
	self._goGadgetRoot = self:getGo("share_view_1719648886")
	self._imgLogo = self:getImage("share_view_1740853252")
	self._imgQRCode = self:getImage("share_view_651195918")
	self._txtName = self:getText("share_view_-748268339")
end

function ShareView:destroyUI()
	self._goBlurBg = nil
	self._goContent = nil
	self._rawImg = nil
	self._btnClose = nil
	self._btnShare = nil
	self._btnSave = nil
	self._btnWeiBo = nil
	self._btnWeiXin = nil
	self._btnWeiXinPengyouQuan = nil
	self._btnQQ = nil
	self._btnQQSpace = nil
	self._goGadgetRoot = nil
	self._imgLogo = nil
	self._imgQRCode = nil
	self._txtName = nil
end

function ShareView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnShare:AddClickListener(self._onClicShare, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnWeiBo:AddClickListener(self._onClickWeiBo, self)
	self._btnWeiXin:AddClickListener(self._onClickWeiXin, self)
	self._btnWeiXinPengyouQuan:AddClickListener(self._onClickWeiXinPengyouQuan, self)
	self._btnQQ:AddClickListener(self._onClickQQ, self)
	self._btnQQSpace:AddClickListener(self._onClickQQSpace, self)
end

function ShareView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnWeiBo:RemoveClickListener()
	self._btnWeiXin:RemoveClickListener()
	self._btnWeiXinPengyouQuan:RemoveClickListener()
	self._btnQQ:RemoveClickListener()
	self._btnQQSpace:RemoveClickListener()
end

function ShareView:onEnter()
	self:changeViewShow(true)

	local info = self:getFirstParam()

	self._shareType = info.shareType
	self._fileName = info.fileName
	self._exitLuaHandler = info.handler
	self._exitCallBackFunc = info.exitCallBackFunc

	SDKManager.getSDKInstacne():registerShareListener(self.shareCallBack)
	self:setLeftBottomInfo()
	self:setShareTypePanel()
end

function ShareView:onEnterFinished()
	return
end

function ShareView:onExitFinished()
	SDKManager.getSDKInstacne():unregisterShareListener()

	if self._exitCallBackFunc then
		self._exitCallBackFunc(self._exitLuaHandler)
	end

	self._exitLuaHandler = nil
	self._exitCallBackFunc = nil
end

function ShareView:_onClickClose()
	self:close()
end

function ShareView:_onClicShare()
	printWarn("点击分享")
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Share)
	settimer(5, self.shareCallBack, self, false)

	local content = lang("tip_share_content_sdk")
	local title = lang("tip_share_title_sdk")
	local url = lang("tip_share_url_sdk")
	local picturePath = self._picturePath

	SDKManager.getSDKInstacne():share(SDKManager.SHARE_PICTURE, content, title, picturePath, url)
end

function ShareView:_onClickSave()
	printWarn("点击保存")
end

function ShareView:_onClickWeiBo()
	printWarn("点击微博")
	FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
end

function ShareView:_onClickWeiXin()
	printWarn("点击微信")
	FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
end

function ShareView:_onClickWeiXinPengyouQuan()
	printWarn("点击微信朋友圈")
	FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
end

function ShareView:_onClickQQ()
	printWarn("点击QQ")
	FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
end

function ShareView:_onClickQQSpace()
	printWarn("点击QQ空间")
	FloatWordMgr.instance:show(lang("tip_system_open_not_online"))
end

function ShareView:setShareTypePanel()
	self:setTypeCommonData()
end

function ShareView:setLeftBottomInfo()
	local platformId = 2
	local secondId = 140002

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		platformId = BootstrapUtil.getPlatformId()
		secondId = tonumber(SDKManager.getSDKInstacne():getDevInfo().channelId)
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		platformId = 1
		secondId = 0
	end

	local useId = 0

	self._isShowQRCode, useId = ShareModel.instance:isShareQRcode(platformId, secondId)
	self._txtName.text = PlayerModel.instance:getNickName()
end

function ShareView:setTypeCommonData()
	settimer(0.3, self.delayCapture, self, false)
end

function ShareView:delayCapture()
	local fileName = self._fileName
	local filePath = ShareModel.instance:getShareDirectoryPath()

	self._picturePath = string.format("%s%s.png", filePath, fileName)

	local snapshotTaker = ShareModel.instance:getShareSnapShotGadget()

	snapshotTaker:CheckDirectory(filePath)
	snapshotTaker:CaptureFrame(self._picturePath, self._captureCallBack, self)
end

function ShareView:_captureCallBack(tex2D, imagePath)
	self:changeViewShow(false)

	self._rawImg.texture = tex2D

	printWarn("imagePath->", imagePath)
end

function ShareView.shareCallBack(statusCode)
	print("==========ShareView.shareCallBack()========", statusCode)

	if statusCode == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		-- block empty
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_FAIL then
		-- block empty
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_CANCEL then
		-- block empty
	end

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Share)
	ViewMgr.instance:close(ViewName.Share)
end

function ShareView:changeViewShow(capture)
	goutil.setActive(self._goBlurBg, not capture)
	goutil.setActive(self._goContent, not capture)
	goutil.setActive(self._goGadgetRoot, capture)
end

return ShareView
