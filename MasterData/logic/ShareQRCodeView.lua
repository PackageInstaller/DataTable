-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shareqrcode/ShareQRCodeView.lua

module("logic.extensions.shareqrcode.ShareQRCodeView", package.seeall)

local ShareQRCodeView = class("ShareQRCodeView", ViewComponent)

function ShareQRCodeView:ctor()
	ShareQRCodeView.super.ctor(self)

	self._platformBtn = nil
end

function ShareQRCodeView:bindEvents()
	ShareQRCodeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, btn in ipairs(self._platformBtn or {}) do
		if btn then
			btn:AddClickListener(function()
				self:_shareBtn(i)
			end)
		end
	end
end

function ShareQRCodeView:unbindEvents()
	ShareQRCodeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for _, btn in pairs(self._platformBtn or {}) do
		if btn then
			btn:RemoveClickListener()
		end
	end
end

function ShareQRCodeView:onExit()
	ShareQRCodeView.super.onExit(self)
	SDKManager.unregisterShareListener()
	goutil.destroy(self._tempTex2d)

	self._tempTex2d = nil

	uGuiUtil.clearImage(self._shareIma)
end

function ShareQRCodeView:destroyUI()
	ShareQRCodeView.super.destroyUI(self)
end

function ShareQRCodeView:buildUI()
	ShareQRCodeView.super.buildUI(self)

	self._bgImaGo = self:getGo("bgImaGo")
	self._closeBtn = self:getBtn("closeBtn")
	self._shareBtnsGo = self:getGo("shareBtnsGo")
	self._platformBtn = {}

	for i = 1, 5 do
		self._platformBtn[i] = self:getBtn("shareBtnsGo/btnsGo/btn_" .. i)
	end

	self._userInfoGo = self:getGo("userInfoGo")
	self._codeImaGo = goutil.findChild(self._userInfoGo, "codeIma")
	self._headGo = goutil.findChild(self._userInfoGo, "headGo")
	self._levelTxt = goutil.findChildTextComponent(self._userInfoGo, "levelTxt")
	self._userIdTxt = goutil.findChildTextComponent(self._userInfoGo, "userIdTxt")
	self._severTxt = goutil.findChildTextComponent(self._userInfoGo, "severTxt")
	self._shareIma = self:getGo("shareIma")
	self._levelTxt.text = ""
	self._userIdTxt.text = ""
	self._severTxt.text = ""

	GameUtil.SetActive(self._bgImaGo, false)
end

function ShareQRCodeView:onEnter()
	ShareQRCodeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._bgImageName = params[1]
	self._qrContent = params[2]

	self:_setBgImage()

	local btplatformId = BootstrapUtil.getPlatformId()
	local flag = (btplatformId == 2 or btplatformId == 10) and BootstrapUtil.getGamePackageName() ~= "com.baitian.jldld.aqcssy.bt"

	goutil.setActive(self._codeImaGo, flag)

	if self._platformBtn[1] then
		GameUtil.SetActive(self._platformBtn[1], flag)
	end

	SDKManager.registerShareListener(function(code, desc)
		self:_shareHander(code, desc)
	end)
	ShareController.instance:checkOnlyShowQZone(self._platformBtn)
end

function ShareQRCodeView:onEnterFinished()
	ShareQRCodeView.super.onEnterFinished(self)

	if not string.nilorempty(self._qrContent) then
		local url = self._qrContent
		local base64 = QRCodeMgr.generateQRCode(300, 300, url, 0, nil, nil, "GameAssets/" .. GameUrl.getCharacterIconUrl("icon_10004_newlanlanlu"))

		if base64 and base64 ~= "" then
			GameUtil.SetActive(self._codeImaGo, true)

			self._codeImaGo:GetComponent("RawImage").texture = CSGameUtil.ConvertBase64ToTexture(base64, 300, 300)
		else
			GameUtil.SetActive(self._codeImaGo, false)
		end
	else
		GameUtil.SetActive(self._codeImaGo, true)
	end

	HeadItemController.instance:setMyHeadCell(self._headGo, GameUtil.handler(self._onHeadCallback, self))
end

function ShareQRCodeView:_onHeadCallback()
	goutil.setActive(UIEffectManager.instance._objectParent, false)
	GameUtil.SetActive(self._closeBtn, false)
	GameUtil.SetActive(self._shareBtnsGo, false)
	GameUtil.SetActive(self._bgImaGo, true)
	Framework.SnapshotTaker.Instance:TakeSnapshot(self._onGetTexture2D, self)
end

function ShareQRCodeView:_onGetTexture2D(tex2d)
	if tex2d == nil then
		return
	end

	self._tempTex2d = tex2d

	local _outTexture = UnityEngine.Texture2D.New(self._tempTex2d.width, self._tempTex2d.height)

	Framework.TextureUtil.DrawTexture(self._tempTex2d, _outTexture, 0, 0)

	self._savePath = AnnualBoxController.instance:saveShareTexture(_outTexture)

	goutil.setActive(UIEffectManager.instance._objectParent, true)
	GameUtil.SetActive(self._closeBtn, true)
	GameUtil.SetActive(self._shareBtnsGo, true)
end

function ShareQRCodeView:_shareBtn(index)
	if string.nilorempty(self._savePath) then
		printError("sr---分享QR Code，分享图片出错！ ShareQRCodeView:_shareBtn()")
		self:close()

		return
	end

	SDKManager.share(SDKManager.SHARE_PICTURE, "标题", "内容", self._savePath, "http://aqsy.100bt.com", index - 1)
end

function ShareQRCodeView:_shareHander(statusCode, statusDesc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if statusCode == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		if btplatformId == 2 or btplatformId == 10 then
			TipsFacade.instance:openTipWindow("分享", "分享成功")
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_FAIL then
		if SDKManager.isShowShareFailDesc() == true then
			TipsFacade.instance:openTipWindow("分享失败", statusDesc)
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_CANCEL and (btplatformId == 2 or btplatformId == 10) then
		TipsFacade.instance:openTipWindow("分享", statusDesc)
	end
end

function ShareQRCodeView:_setBgImage()
	uGuiUtil.setSpriteToImage(self._shareIma, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/shareqrcode/%s.png", self._bgImageName))
end

return ShareQRCodeView
