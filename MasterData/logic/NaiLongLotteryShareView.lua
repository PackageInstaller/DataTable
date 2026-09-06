-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryShareView.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryShareView", package.seeall)

local NaiLongLotteryShareView = class("NaiLongLotteryShareView", ViewComponent)

function NaiLongLotteryShareView:buildUI()
	NaiLongLotteryShareView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose_hide")
	self._iconPrize = self:getGo("prize_hide/icon")
	self._txtNumPrize = self:getTxt("prize_hide/txtNum")
	self._platformBtn = {}
	self._btnsGo = self:getGo("shareCol_hide/btnsGo")

	for idx = 1, self._btnsGo.transform.childCount do
		self._platformBtn[idx] = goutil.findChild(self._btnsGo, "btn_" .. idx)
	end

	self._hideGos = {}

	local queue = {
		self.mainGO
	}

	while #queue > 0 do
		local current = table.remove(queue, 1)

		if string.find(current.name, "_hide") then
			table.insert(self._hideGos, current)
		else
			for i = 0, current.transform.childCount - 1 do
				local child = current.transform:GetChild(i).gameObject

				table.insert(queue, child)
			end
		end
	end
end

function NaiLongLotteryShareView:bindEvents()
	NaiLongLotteryShareView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for idx, btn in ipairs(self._platformBtn) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._shareBtn, self, idx))
	end
end

function NaiLongLotteryShareView:unbindEvents()
	NaiLongLotteryShareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for _, btn in pairs(self._platformBtn) do
		GameUtil.rmClickHandler(btn)
	end
end

function NaiLongLotteryShareView:onEnter()
	NaiLongLotteryShareView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = NaiLongLotteryController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = NaiLongLotteryConfig.instance:getActData(self._activityId)
	self._naiLongLotteryMo = NaiLongLotteryController.instance:getNaiLongLotteryMo(self._activityId)
	self._savePath = string.format("%s/annualBoxShareTex_%s.png", UnityEngine.Application.persistentDataPath, self._activityId)
	self._isHasSaveTexture = false
	self._changeSetId = nil

	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryShareRes, self._handlePM_ShareLotteryShareRes, self)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actData.sharePrize)

	MaterialMgr.setIcon(self._iconPrize, matType, matId, nil, nil)

	self._txtNumPrize.text = string.format("X%s", self._naiLongLotteryMo:getSharePrizeNum())

	local btplatformId = BootstrapUtil.getPlatformId()
	local flag = (btplatformId == 2 or btplatformId == 10) and BootstrapUtil.getGamePackageName() ~= "com.baitian.jldld.aqcssy.bt"

	if self._platformBtn[1] then
		GameUtil.SetActive(self._platformBtn[1], flag)
	end

	SDKManager.registerShareListener(function(code, desc)
		self:_shareHander(code, desc)
	end)
	ShareController.instance:checkOnlyShowQZone(self._platformBtn)
end

function NaiLongLotteryShareView:onExit()
	NaiLongLotteryShareView.super.onExit(self)
	goutil.destroy(self._tempTex2d)

	self._tempTex2d = nil
end

function NaiLongLotteryShareView:_handlePM_ShareLotteryShareRes(msg)
	self._changeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self._changeSetId)

	if Framework.OSDef.isEditor then
		self:_showChangeSetId()
	end
end

function NaiLongLotteryShareView:_shareHander(statusCode, statusDesc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if statusCode == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		if btplatformId == 2 or btplatformId == 10 then
			TipsFacade.instance:openTipWindow("分享", "分享成功", function()
				self:_showChangeSetId()
			end)
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_FAIL then
		if SDKManager.isShowShareFailDesc() == true then
			TipsFacade.instance:openTipWindow("分享失败", statusDesc, function()
				self:_showChangeSetId()
			end)
		else
			self:_showChangeSetId()
		end
	elseif statusCode == SDKManager.SHARE_STATUS_CODE_CANCEL then
		if btplatformId == 2 or btplatformId == 10 then
			TipsFacade.instance:openTipWindow("分享", statusDesc, function()
				self:_showChangeSetId()
			end)
		end
	else
		self:_showChangeSetId()
	end
end

function NaiLongLotteryShareView:_showChangeSetId()
	if self._changeSetId then
		MaterialController.instance:showChangeSetInTemp(self._changeSetId)

		self._changeSetId = nil
	end
end

function NaiLongLotteryShareView:_shareBtn(index)
	if self._naiLongLotteryMo:getTodayShareTimes() < self._naiLongLotteryMo:getMaxDailyShareTimes() then
		NaiLongLotteryController.instance:sendPM_ShareLotteryShareReq(self._activityId)
	end

	self:_doTextureSave(function()
		SDKManager.share(SDKManager.SHARE_PICTURE, "标题", "内容", self._savePath, "http://aqsy.100bt.com", index - 1)
	end)
end

function NaiLongLotteryShareView:_doTextureSave(callBack)
	if self._isHasSaveTexture then
		GameUtil.callBack(callBack)
	else
		goutil.setActive(UIEffectManager.instance._objectParent, false)

		for _, v in ipairs(self._hideGos) do
			GameUtil.SetActive(v, false)
		end

		Framework.SnapshotTaker.Instance:TakeSnapshot(function(tex2d)
			if tex2d == nil then
				return
			end

			self._tempTex2d = tex2d

			local outTexture = UnityEngine.Texture2D.New(tex2d.width, tex2d.height)

			Framework.TextureUtil.DrawTexture(tex2d, outTexture, 0, 0)
			Framework.TextureUtil.SaveTextureToPath(outTexture, self._savePath)
			goutil.setActive(UIEffectManager.instance._objectParent, true)

			for _, v in ipairs(self._hideGos) do
				GameUtil.SetActive(v, true)
			end

			GameUtil.callBack(callBack)

			self._isHasSaveTexture = true
		end)
	end
end

return NaiLongLotteryShareView
