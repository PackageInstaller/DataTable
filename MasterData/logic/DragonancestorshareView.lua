-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/DragonancestorshareView.lua

module("logic.extensions.operationsummary.view.DragonancestorshareView", package.seeall)

local DragonancestorshareView = class("DragonancestorshareView", ViewComponent)

function DragonancestorshareView:ctor()
	DragonancestorshareView.super.ctor(self)

	self._platformBtn = nil
end

function DragonancestorshareView:bindEvents()
	DragonancestorshareView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, btn in ipairs(self._platformBtn or {}) do
		if btn then
			btn:AddClickListener(function()
				self:_shareBtn(i)
			end)
		end
	end
end

function DragonancestorshareView:unbindEvents()
	DragonancestorshareView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for _, btn in pairs(self._platformBtn or {}) do
		if btn then
			btn:RemoveClickListener()
		end
	end
end

function DragonancestorshareView:onExit()
	DragonancestorshareView.super.onExit(self)
	SDKManager.unregisterShareListener()
	goutil.destroy(self._tempTex2d)

	self._tempTex2d = nil

	HeadItemController.instance:resetHeadCell(self._headGo)
end

function DragonancestorshareView:buildUI()
	DragonancestorshareView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._shareBtnsGo = self:getGo("shareBtnsGo")
	self._platformBtn = {}

	for i = 1, 5 do
		self._platformBtn[i] = self:getBtn("shareBtnsGo/btnsGo/btn_" .. i)
	end

	self._userInfoGo = self:getGo("userInfoGo")
	self._headGo = goutil.findChild(self._userInfoGo, "headGo")
	self._descBgGo = self:getGo("userInfoGo/descBg")
end

function DragonancestorshareView:onEnter()
	DragonancestorshareView.super.onEnter(self)

	local btplatformId = BootstrapUtil.getPlatformId()
	local flag = SDKManager.isOfficial() and BootstrapUtil.getGamePackageName() ~= "com.baitian.jldld.aqcssy.bt"

	goutil.setActive(self._descBgGo, flag)

	if self._platformBtn[1] then
		GameUtil.SetActive(self._platformBtn[1], flag)
	end

	SDKManager.registerShareListener(function(code, desc)
		self:_shareHander(code, desc)
	end)
	ShareController.instance:checkOnlyShowQZone(self._platformBtn)
end

function DragonancestorshareView:onEnterFinished()
	DragonancestorshareView.super.onEnterFinished(self)
	HeadItemController.instance:setMyHeadCell(self._headGo)
end

function DragonancestorshareView:_onGetTexture2D(tex2d)
	if tex2d == nil then
		return
	end

	self._tempTex2d = tex2d

	local _outTexture = UnityEngine.Texture2D.New(self._tempTex2d.width, self._tempTex2d.height)

	Framework.TextureUtil.DrawTexture(self._tempTex2d, _outTexture, 0, 0)

	self._savePath = string.format("%s/dragonancestorshareview_%s.png", UnityEngine.Application.persistentDataPath, RoleModel.instance:getUserId())

	Framework.TextureUtil.SaveTextureToPath(_outTexture, self._savePath)
	goutil.setActive(UIEffectManager.instance._objectParent, true)
	GameUtil.SetActive(self._closeBtn, true)
	GameUtil.SetActive(self._shareBtnsGo, true)

	if string.nilorempty(self._savePath) then
		self:close()

		return
	end

	SDKManager.share(SDKManager.SHARE_PICTURE, "标题", "内容", self._savePath, "http://aqsy.100bt.com", self._shareIndex - 1)
end

function DragonancestorshareView:_shareBtn(index)
	self._shareIndex = index

	local url = "https://aqsy.172tt.com/act/20250725-summer/"

	SDKManager.share(SDKManager.SHARE_TEXT, url, "内容", nil, nil, self._shareIndex - 1)
end

function DragonancestorshareView:_shareHander(statusCode, statusDesc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if statusCode == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		if SDKManager.isOfficial() then
			TipsFacade.instance:openTipWindow("分享", "分享成功")
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_FAIL then
		if SDKManager.isShowShareFailDesc() == true then
			TipsFacade.instance:openTipWindow("分享失败", statusDesc)
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_CANCEL and SDKManager.isOfficial() then
		TipsFacade.instance:openTipWindow("分享", statusDesc)
	end
end

return DragonancestorshareView
