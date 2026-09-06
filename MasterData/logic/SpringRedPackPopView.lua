-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackPopView.lua

module("logic.extensions.springredpack.view.SpringRedPackPopView", package.seeall)

local SpringRedPackPopView = class("SpringRedPackPopView", ViewComponent)

function SpringRedPackPopView:ctor()
	SpringRedPackPopView.super.ctor(self)
end

function SpringRedPackPopView:buildUI()
	SpringRedPackPopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._coverOn = self:getGo("coverOn")
	self._item = self:getGo("coverOn/item")
	self._txtDesc = self:getTxt("coverOn/txtDesc")
	self._txtItem = self:getTxt("coverOn/txtItem")
	self._coverOff = self:getGo("coverOff")
	self._petIcon = self:getGo("coverOff/pet/petIcon")
	self._itemOff = self:getGo("coverOff/item")
	self._txtTitle = self:getTxt("coverOff/txtTitle")
	self._txtDesc = self:getTxt("coverOff/txtDesc")
	self._btnCoverOff = self:getBtn("coverOff")

	local image = self._itemOff:GetComponent(goutil.Type_UIImage)

	self._image = image
	self._material = UnityEngine.Material.New(image.material)

	self._material:SetFloat("_ScaleFactor", 1.2)

	self._effectGo = self:getGo("effect")
end

function SpringRedPackPopView:destroyUI()
	self._material = nil
end

function SpringRedPackPopView:bindEvents()
	SpringRedPackPopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCoverOff:AddClickListener(self._onClickCoverOff, self)
end

function SpringRedPackPopView:unbindEvents()
	SpringRedPackPopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnCoverOff:RemoveClickListener()
end

function SpringRedPackPopView:onEnter()
	SpringRedPackPopView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FailGainSpringRedPackRes, self._onFailGainSpringRedPackRes, self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._roundId = param[2]
	self._simlateOtherResults = param[3]
	self._index = param[4]
	self._isClose = false
	self._isClickedCoverOff = false

	self:_setOffContent(self._activityId, self._roundId)
	goutil.setActive(self._coverOff, true)
	goutil.setActive(self._coverOn, false)
end

function SpringRedPackPopView:onExit()
	SpringRedPackPopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FailGainSpringRedPackRes, self._onFailGainSpringRedPackRes, self)
	self:_clearItem()
	self:_stopEffect()
	uGuiUtil.clearImage(self._coverOn)
	uGuiUtil.clearImage(self._coverOff)
end

function SpringRedPackPopView:_onClickClose()
	if self._isClose or not SpringRedPackController.instance:isInActivityTime() then
		self:close()
	end
end

function SpringRedPackPopView:_onClickCoverOff()
	if not self._isClickedCoverOff then
		self._isClickedCoverOff = true

		SpringRedPackAgent.instance:sendPM_GainSpringRedPackReq(self._activityId, self._roundId, self._simlateOtherResults, self._index)
	end
end

function SpringRedPackPopView:_onGainSpringRedPackRes(roundId, index, redPackPrizeId, otherPrizeIds)
	self:_playEffect()
	self:_setOnContent(redPackPrizeId)
	TweenUtil.DoDelay(0.1, function()
		goutil.setActive(self._coverOff, false)
		goutil.setActive(self._coverOn, true)

		self._isClose = true
	end)
end

function SpringRedPackPopView:_onFailGainSpringRedPackRes()
	self:close()
end

function SpringRedPackPopView:_setOnContent(redPackPrizeId)
	local cfg = SpringRedPackConfig.instance:getPrizeCfg(redPackPrizeId)

	if cfg then
		MaterialMgr.setCellByCfg(cfg.prize, self._item)

		self._txtDesc.text = cfg.prizeDescribe

		local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)
		local name = MaterialMgr.getMaterialsName(matType, id)

		self._txtItem.text = string.format("%s*%d", name, matNum)
	end
end

function SpringRedPackPopView:_setOffContent(activityId, roundId)
	local cfgActivity = SpringRedPackConfig.instance:getActivityCfg(self._activityId)

	if cfgActivity then
		local redPackId = 0

		if roundId > 0 then
			local cfgRound = SpringRedPackConfig.instance:getRoundCfg(activityId, roundId)

			if cfgRound then
				redPackId = cfgRound.redPackId
			end
		else
			redPackId = cfgActivity.dailyRedPackId
		end

		local cfgRedPack = SpringRedPackConfig.instance:getRedPackCfg(redPackId)

		if cfgRedPack then
			self._txtDesc.text = cfgRedPack.redPackDesc

			local matType, id, matNum = MaterialMgr.getMatParams(cfgRedPack.prize)

			MaterialMgr.setIcon(self._itemOff, matType, id)
		end

		local redPackSkinCfg = SpringRedPackConfig.instance:getRedPackSkinByRedId(redPackId)
		local coverOnBgPath = GameUrl.getBigbgFolderUrl("springredpack", redPackSkinCfg.bigOnPath)
		local coverOffBgPath = GameUrl.getBigbgFolderUrl("springredpack", redPackSkinCfg.bigOffPath)

		uGuiUtil.setSpriteToImage(self._coverOn, uGuiUtil.SpriteType.BigBg, coverOnBgPath)
		uGuiUtil.setSpriteToImage(self._coverOff, uGuiUtil.SpriteType.BigBg, coverOffBgPath)

		self._txtTitle.text = cfgActivity.showName

		MaterialMgr.setIcon(self._petIcon, MatType.HeadIcon, cfgActivity.headIconId)

		self._image.material = self._material
	end
end

function SpringRedPackPopView:_clearItem()
	MaterialMgr.resetAll(self._item)
	MaterialMgr.clearIcon(self._itemOff)
	MaterialMgr.clearIcon(self._petIcon)
end

function SpringRedPackPopView:_playEffect()
	self._uiEffectBack = UIEffectManager.instance:playEffect(self, SpringRedPackPopViewPresentor.EffectPathBack, self._effectGo.transform, 0, 0, false, false)

	self._uiEffectBack:setParent(self._effectGo.transform)
	self._uiEffectBack:setScale(1)
	self._uiEffectBack:setSortingOrder(230)

	self._uiEffectFront = UIEffectManager.instance:playEffect(self, SpringRedPackPopViewPresentor.EffectPathFront, self._effectGo.transform, 0, 0, false, false)

	self._uiEffectFront:setParent(self._effectGo.transform)
	self._uiEffectFront:setScale(1)
	self._uiEffectFront:setLocalPos(-45, 8, 0)
end

function SpringRedPackPopView:_stopEffect()
	if self._uiEffectBack then
		UIEffectManager.instance:stopEffect(self._uiEffectBack)

		self._uiEffectBack = nil
	end

	if self._uiEffectFront then
		UIEffectManager.instance:stopEffect(self._uiEffectFront)

		self._uiEffectFront = nil
	end
end

return SpringRedPackPopView
