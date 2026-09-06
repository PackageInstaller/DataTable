-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/view/CollectposterView.lua

module("logic.extensions.collectingskin.view.CollectposterView", package.seeall)

local CollectposterView = class("CollectposterView", ViewComponent)

function CollectposterView:ctor()
	CollectposterView.super.ctor(self)
end

function CollectposterView:unbindEvents()
	CollectposterView.super.unbindEvents(self)
end

function CollectposterView:bindEvents()
	CollectposterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
end

function CollectposterView:buildUI()
	CollectposterView.super.buildUI(self)

	self._btnJump = self:getGo("btnJump")
	self._btnGet = self:getGo("btnGet")
	self._txtProgress = self:getTxt("txtProgress")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtLeft = self:getTxt("txtLeft")
	self.posterGo = self:getGo("poster/con")
	self._posterImage = self:getGo("poster/spineImage")
	self.txtState = self:getTxt("waikuang/txtState")
	self._itemCon = self:getGo("itemCon")
	self._txtTime = self:getTxt("time/txtTime")
	self._showTips = self:getGo("showTips")
	self._txtShowTips = self:getTxt("showTips/txt")
	self._petPhotoShow = PetPhotoShow.Get(self._posterImage)
end

function CollectposterView:onExit()
	CollectposterView.super.onExit(self)
	self:_unLoadSpineBySkeletonAnimation()
	uGuiUtil.clearImage(self._itemCon)
end

function CollectposterView:onEnter()
	CollectposterView.super.onEnter(self)

	local activityId = checknumber(self:getFirstParam())

	if activityId == 0 then
		activityId = 585001
	end

	self._activityId = activityId

	self.addGEvent(self, GlobalNotify.CollectingPoseterInfo, self._refreshUI, self)
	PosterStickersGainActivityAgent.instance:sendPM_PosterStickerGainActivityGetInfoReq(activityId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_refreshUI()
end

function CollectposterView:_refreshUI()
	local info = CollectingSkinModel.instance:getPosterInfo(self._activityId) or {}
	local cfg = CollectingSkinConfig.instance:getPosterCfg(self._activityId) or {}

	if not cfg.showTips then
		local showtips = ""

		if not GameUtil.isEmptyString(showtips) then
			self._showTips:SetActive(true)

			self._txtShowTips.text = showtips
		else
			self._showTips:SetActive(false)
		end

		self._hasGain = info.hasGain

		local posterId = checknumber(cfg.posterId)

		if posterId > 0 then
			self:_loadSpineBySkeletonAnimation(posterId)
		end

		local spaceCountLimit = checknumber(cfg.spaceCountLimit)

		self._left = math.max(0, spaceCountLimit - checknumber(info.spaceGainCount))

		local hasCount = 0
		local totalCount = 0
		local posterCfg = PetSkinConfig.instance:getPosterModelCo(posterId) or {}

		for i, v in ipairs(posterCfg.skinId) do
			local isHas = PetskinController.instance:checkHasForeverSkinBySkinId(v)

			if isHas then
				hasCount = hasCount + 1
			end

			totalCount = totalCount + 1
		end

		if not string.nilorempty(posterCfg.unlockItems) then
			local items = string.split(posterCfg.unlockItems, "#")

			for i, v in ipairs(items) do
				local matType, matId, matNum = MaterialMgr.getMatParams(v)
				local isHas = matNum <= checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId))

				if isHas then
					hasCount = hasCount + 1
				end

				totalCount = totalCount + 1
			end
		end

		self._hasCount = hasCount
		self._totalCount = totalCount
		self._txtProgress.text = langPara("进度：%s/%s", hasCount, totalCount)
		self._txtDesc.text = langPara("解锁【%s】海报，即可直接领取典藏印象贴", posterCfg.name)
		self._txtLeft.text = langPara("已有%s人领取", checknumber(info.spaceGainCount))

		local isHas = PetskinController.instance:getPosterActive(posterCfg)

		self.txtState.text = isHas and lang("已解锁") or lang("未解锁")

		if not cfg.prizePosterStickers then
			local prizePosterStickers = ""
			local mattype, id, num = MaterialMgr.getMatParams(prizePosterStickers)
			local stickCfg = ImpressionStickersConfig.instance:getPosterSticker(id)
			local pathName = GameUrl.getImpressionStickersIconUrl(stickCfg.res)

			uGuiUtil.setSpriteToImage(self._itemCon, uGuiUtil.LoaderType_BigBg, pathName, function()
				self._itemCon.gameObject:GetComponent("Image"):SetNativeSize()
			end)
		end
	end
end

function CollectposterView:_onClickGet()
	if self._hasGain then
		TipsFacade.instance:openCommonTips("已经领取")
	else
		local cfg = CollectingSkinConfig.instance:getPosterCfg(self._activityId) or {}

		if self._left > 0 then
			if self._hasCount >= self._totalCount then
				PosterStickersGainActivityAgent.instance:sendPM_PosterStickerGainActivityReq(self._activityId)
			else
				TipsFacade.instance:openCommonTips("解锁海报后可以领取")
			end
		else
			TipsFacade.instance:openCommonTips("全服剩余数量不足，不可领取")
		end
	end
end

function CollectposterView:_onClickJump()
	local cfg = CollectingSkinConfig.instance:getPosterCfg(self._activityId) or {}

	UIStateManager.instance:push(ViewName.PetskinposterView, cfg.posterId)
end

function CollectposterView:_loadSpineBySkeletonAnimation(skinId)
	self._petPhotoShow:showPetPoster(skinId, true)
end

function CollectposterView:_unLoadSpineBySkeletonAnimation()
	if self._petPhotoShow then
		self._petPhotoShow:clear()
	end
end

return CollectposterView
