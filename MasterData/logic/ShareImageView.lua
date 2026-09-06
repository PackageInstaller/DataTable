-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/ShareImageView.lua

module("logic.extensions.share.view.ShareImageView", package.seeall)

local ShareImageView = class("ShareImageView", ViewComponent)

function ShareImageView:ctor()
	ShareImageView.super.ctor(self)
end

function ShareImageView:buildUI()
	ShareImageView.super.buildUI(self)

	self._bg = goutil.findChildComponent(self.mainGO, "bg", "UIImageColorChange")
	self._closeBtn = self:getBtn("closeBtn")
	self._shareBtnBg = self:getGo("shareBtnBg")
	self._platformBtn = {
		root = self:getGo("platformBtn")
	}

	for i = 1, 5 do
		self._platformBtn[i] = self:getBtn("platformBtn/btn_" .. i)
	end

	self._shareReward = self:getGo("shareReward")
	self._shareRewardCount = goutil.findChildTextComponent(self._shareReward, "txtDesc/count")
	self._user = self:getGo("user")
	self._userLv = goutil.findChildTextComponent(self._user, "lv")
	self._userId = goutil.findChildTextComponent(self._user, "id")
	self._userServer = goutil.findChildTextComponent(self._user, "server")
	self._userCode = self:getGo("user/code")
	self._userHead = self:getGo("user/head")
	self._screenshot = self:getGo("screenshot"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._btnShare = self:getBtn("btnShare")
	self._rewardImgGo = self:getGo("shareReward/txtDesc/img")
end

function ShareImageView:bindEvents()
	ShareImageView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i, value in ipairs(self._platformBtn) do
		value:AddClickListener(function()
			self:_shareBtn(i)
		end)
	end

	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
end

function ShareImageView:unbindEvents()
	ShareImageView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnShare)

	for i, value in ipairs(self._platformBtn) do
		value:RemoveClickListener()
	end
end

function ShareImageView:destroyUI()
	ShareImageView.super.destroyUI(self)
end

function ShareImageView:onEnter()
	ShareImageView.super.onEnter(self)

	local btplatformId = BootstrapUtil.getPlatformId()
	local flag = (btplatformId == 2 or btplatformId == 10) and BootstrapUtil.getGamePackageName() ~= "com.baitian.jldld.aqcssy.bt"

	goutil.setActive(self._userCode, flag)
	goutil.setActive(self._platformBtn[1].gameObject, flag)
	SDKManager.registerShareListener(function(statusCode, statusDesc)
		self:_shareHander(statusCode, statusDesc)
	end)

	self._initTexture = self._screenshot.texture

	ShareController.instance:checkOnlyShowQZone(self._platformBtn)

	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	goutil.setActive(self._btnShare.gameObject, bagPetMo)
end

function ShareImageView:onEnterFinished()
	ShareImageView.super.onEnterFinished(self)

	local openParam = self:getOpenParam() or {}

	self._id = openParam[1]
	self._objActive = {}

	if openParam[2] and type(openParam[2]) == "table" then
		for i, value in ipairs(openParam[2]) do
			self._objActive[i] = {
				go = value,
				active = value.activeSelf
			}

			goutil.setActive(value, false)
		end
	end

	self._texture = openParam[3]
	self._needDestroyTexture = true

	if self._texture then
		self._needDestroyTexture = false
	end

	self._behaviorId = openParam[4]
	self._handler = openParam[5]
	self._handlerObj = openParam[6]

	self._bg:SetState(0)
	goutil.setActive(self._user, false)

	self._userLv.text = "LV." .. RoleModel.instance:getMyLevel()
	self._userId.text = "ID:" .. RoleModel.instance:getUserId()
	self._userServer.text = "区服:" .. RoleModel.instance:GetRole().areaName

	local shareInfo = ShareConfig.instance:getShareById(self._id) or {}

	if checknumber(shareInfo.reportBehavior) > 0 then
		self._behaviorId = checknumber(shareInfo.reportBehavior)
	end

	self._limitTimes = shareInfo.limitTimes

	local base64 = QRCodeMgr.generateQRCode(300, 300, shareInfo.url, 0, nil, nil, "GameAssets/" .. GameUrl.getCharacterIconUrl("icon_10004_newlanlanlu"))

	if base64 and base64 ~= "" then
		self._userCode:GetComponent("RawImage").texture = CSGameUtil.ConvertBase64ToTexture(base64, 300, 300)
	end

	local prizeStr = shareInfo.prize

	if string.find(shareInfo.prize, "#") then
		local list = string.split(shareInfo.prize, "#")

		for i, v in ipairs(list) do
			if string.find(v, "^" .. MatType.Cloth .. ":%d+:") then
				local list2 = string.split(v, ":")
				local clothId = checknumber(list2[2])
				local cfg = DressConfig.instance:getDressCfgById(clothId)

				if cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == RoleModel.instance:getGender() then
					prizeStr = v

					break
				end
			else
				prizeStr = v

				break
			end
		end
	end

	local sp = string.split(prizeStr, ":")

	MaterialMgr.setIcon(self._rewardImgGo, checknumber(sp[1]), checknumber(sp[2]))

	self._shareRewardCount.text = "X" .. sp[#sp]

	ShareLinkAgent.instance:sendPM_GetShareLinkDataReq(self._id, function(msg)
		self._times = msg.gainTimes

		self:_uiActive(false)
		HeadItemController:setMyHeadCell(self._userHead, GameUtil.handler(self._shot, self))
	end)
end

function ShareImageView:onExit()
	ShareImageView.super.onExit(self)

	for i, value in ipairs(self._objActive) do
		goutil.setActive(self._objActive[i].go, self._objActive[i].active)
	end

	self._screenshot.texture = self._initTexture

	if self._needDestroyTexture then
		goutil.destroy(self._texture)
	end

	SDKManager.unregisterShareListener()

	if self._handler and type(self._handler) == "function" then
		self._handler(self._handlerObj)
	end

	goutil.setActive(self._shareReward, false)
	MaterialMgr.resetAll(self._rewardImgGo)
end

function ShareImageView:onExitFinished()
	ShareImageView.super.onExitFinished(self)
end

function ShareImageView:_shot()
	goutil.setActive(UIEffectManager.instance._objectParent, false)

	if self._texture then
		self:_onGetTexture2D()
	else
		goutil.setActive(self._user, true)
		Framework.SnapshotTaker.Instance:TakeSnapshot(self._onGetTexture2D, self)
	end
end

function ShareImageView:_onGetTexture2D(texture2d)
	self._texture = self._texture or texture2d
	self._screenshot.texture = self._texture

	local _outTexture = UnityEngine.Texture2D.New(self._texture.width, self._texture.height)
	local scale = self._texture.width / self._texture.height

	GameUtil.setWidth(self._screenshot.gameObject, 576 * scale)
	GameUtil.setHeight(self._screenshot.gameObject, 576)
	Framework.TextureUtil.DrawTexture(self._texture, _outTexture, 0, 0)

	self._path = ShareController.SaveShareTexture(_outTexture)

	self:_uiActive(true)
	self._bg:SetState(1)
	goutil.setActive(self._user, false)
	goutil.setActive(UIEffectManager.instance._objectParent, true)
end

function ShareImageView:_uiActive(flag)
	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	goutil.setActive(self._screenshot.gameObject, flag)
	goutil.setActive(self._shareBtnBg, flag)
	goutil.setActive(self._platformBtn.root, flag)
	goutil.setActive(self._closeBtn.gameObject, flag)
	goutil.setActive(self._btnShare.gameObject, bagPetMo and flag)
	goutil.setActive(self._shareReward, flag and self._times < self._limitTimes)
end

function ShareImageView:_shareBtn(index)
	SurveyController.instance:reportBehavior(self._behaviorId, tostring(index))
	SDKManager.share(SDKManager.SHARE_PICTURE, "标题", "内容", self._path, "http://aqsy.100bt.com", index - 1)
end

function ShareImageView:_shareHander(statusCode, statusDesc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if (statusCode == SDKManager.SHARE_STATUS_CODE_SUCCESS or btplatformId ~= 2 and btplatformId ~= 10) and self._times < self._limitTimes then
		ShareLinkAgent.instance:sendPM_GainShareLinkPrizeReq(self._id)
	end

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

function ShareImageView:_onClickShare()
	self:close()

	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	if bagPetMo then
		UIStateManager.instance:open(ViewName.Share, GameEnum.ShareType.Pet, bagPetMo.petId)
	end
end

return ShareImageView
