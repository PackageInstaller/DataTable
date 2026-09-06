-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooanimalView.lua

module("logic.extensions.zoo.view.ZooanimalView", package.seeall)

local ZooanimalView = class("ZooanimalView", ViewComponent)

function ZooanimalView:buildUI()
	ZooanimalView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnPair = self:getBtn("btnPair")
	self._btnPairTimesTxt = self:getTxt("btnPair/times")
	self._left = self:getGo("Left")
	self._txtLv = self:getTxt("Left/txtLv")
	self._sldExp = self:getSlider("Left/exp")
	self._txtExpBg = self:getGo("Left/exp/bg")
	self._txtExp = self:getTxt("Left/exp/bg/txtexp")
	self._btnFeed = self:getBtn("feed/btnFeed")
	self._surplusage = self:getTxt("feed/surplusage")
	self._btnFollow = self:getBtn("btnFollow")
	self._followIcon = self._btnFollow.gameObject:GetComponent("UIChangeGroup")
	self._btnFollowText = goutil.findChildTextComponent(self._btnFollow.gameObject, "Text")
	self._btnRename = self:getBtn("Name/renameBtn")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "Name/txtName")
	self._animalImage = self:getGo("pig/rawImage")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("drag"))
	self._btnPlayBubble = self:getBtn("drag")
	self._bubblePos = self:getGo("bubblePos")
	self._prevBtn = self:getBtn("prevBtn")
	self._nextBtn = self:getBtn("nextBtn")
	self._maskGo = self:getGo("mask")

	goutil.setActive(self._maskGo, false)
end

function ZooanimalView:bindEvents()
	ZooanimalView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnInfo:AddClickListener(self._onClickBtnInfo, self)
	self._btnPair:AddClickListener(self._onClickBtnPair, self)
	self._btnFeed:AddClickListener(self._onClickBtnFeed, self)
	self._btnFollow:AddClickListener(self._onSwitchFollowState, self)
	self._btnPlayBubble:AddClickListener(self._onClickBtnPlayBubble, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._btnRename:AddClickListener(self._onClickBtnRename, self)
	self._prevBtn:AddClickListener(self._onClickPrev, self)
	self._nextBtn:AddClickListener(self._onClickNext, self)
end

function ZooanimalView:unbindEvents()
	ZooanimalView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnPair:RemoveClickListener()
	self._btnFeed:RemoveClickListener()
	self._btnFollow:RemoveClickListener()
	self._btnPlayBubble:RemoveClickListener()
	self._drag:RemoveDragListener()
	self._btnRename:RemoveClickListener()
end

function ZooanimalView:onEnter()
	ZooanimalView.super.onEnter(self)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	GlobalDispatcher:addListener(GlobalNotify.OnZooChangeAnimalName, self._onZooChangeAnimalName, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooRecycleAnimal, self._onRecycleAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooPetFollowStaus, self._updateFollowStatus, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooConfirmBuddyMatch, self._updateAnimalPairTimes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnFeedBuddyAnimal, self._feedBuddyAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.OnFeedAnimal, self._feedAnimal, self)
	self:_initConfigs()
	self:_updateByAnimalMo(self._animalMo)
	self:_updateActiveStatus()

	self._surplusage.text = string.format(lang("petzoo_friuts_num"), checkint(MaterialMgr.getMatCount(self._feedItemInfo)))

	settimer(1, self._updateAnimalPairTimes, self)
end

function ZooanimalView:_initConfigs()
	local openParams = self:getOpenParam()

	self._animalMo = ZoowarehouseController.instance:getCurAnimal() or openParams[1]
	self._currZoo = ZooModel.instance:getCurrZoo()
	self._friendId = not self._currZoo:isMyZoo() and self._currZoo:getZooUserId() or nil
	self._feedItemInfo = ZooConfig.instance:getFeedCostItem()

	local sp = string.split(self._feedItemInfo, ":")

	self._feedNum = tonumber(sp[3])
end

function ZooanimalView:_updateActiveStatus()
	local activeFlag = not self._friendId

	goutil.setActive(self._left, activeFlag)
	goutil.setActive(self._btnPair.gameObject, activeFlag)
	goutil.setActive(self._btnRename.gameObject, activeFlag)
	goutil.setActive(self._btnFollow.gameObject, activeFlag)
	goutil.setActive(self._prevBtn.gameObject, activeFlag)
	goutil.setActive(self._nextBtn.gameObject, activeFlag)
end

function ZooanimalView:onExit()
	ZooanimalView.super.onExit(self)
	removetimer(self._updateAnimalPairTimes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooChangeAnimalName, self._onZooChangeAnimalName, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooRecycleAnimal, self._onRecycleAnimal, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooPetFollowStaus, self._updateFollowStatus, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooConfirmBuddyMatch, self._updateAnimalPairTimes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnFeedBuddyAnimal, self._feedBuddyAnimal, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnFeedAnimal, self._feedAnimal, self)
	self:_stopFeedAnimalEff()
	self._avatar:destroy()
	self._animalShow:clear()

	self._avatar = nil
	self._animalShow = nil
end

function ZooanimalView:_onZooChangeAnimalName(animalId, status)
	if self._animalMo and status == 0 and animalId == self._animalMo.id then
		self._txtName.text = self._animalMo.name
	end
end

function ZooanimalView:_updateByAnimalMo(animalMo)
	self._animalMo = animalMo
	self._txtName.text = animalMo.name

	uGuiUtil.setGoGrayState(self._btnPair.gameObject, animalMo.restMatchTimes == 0)
	goutil.setActive(self._txtExpBg, animalMo.nextExp > 0)

	if animalMo.nextExp > 0 then
		self._sldExp:SetValue(animalMo.exp / animalMo.nextExp)

		self._txtExp.text = string.format("%d/%d", animalMo.exp, animalMo.nextExp)
	else
		self._sldExp:SetValue(1)

		self._txtExp.text = animalMo.exp
	end

	if self._friendId then
		local zooInfo = ZooModel.instance:getMyZoo()

		uGuiUtil.setGoGrayState(self._btnFeed.gameObject, zooInfo:getHasFeedBuddyAnimalTimes() >= ZooConfig.instance:getFeedBuddyAnimalMaxTimes())
	else
		self:_updateFollowStatus()
		uGuiUtil.setGoGrayState(self._btnFeed.gameObject, self._animalMo.nextExp <= 0)
		self:_updateAnimalPairTimes()
	end

	self._txtLv.text = animalMo.level

	if self._animalShow then
		local avatarMo = self._avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(animalMo)
		self._avatar:updateByMo(avatarMo)
	else
		self._animalShow, self._avatar = animalMo:showAnimalAvatar(self._animalImage, 512, 512, 0.56, 0.65)
	end
end

function ZooanimalView:_updateAnimalPairTimes()
	goutil.setActive(self._btnPairTimesTxt.gameObject, self._animalMo.restMatchTimes > 0)

	local matchCD = self._animalMo:getMatchCD()

	uGuiUtil.setGoGrayState(self._btnPair.gameObject, matchCD > 0 or self._animalMo.restMatchTimes == 0)

	if self._btnPairTimesTxt.gameObject.activeSelf then
		self._btnPairTimesTxt.text = matchCD > 0 and string.format(lang("petzoo_matchtimes_cd_time"), math.floor(matchCD)) or string.format(lang("petzoo_matchtimes_remain"), self._animalMo.restMatchTimes)
	end
end

function ZooanimalView:_feedAnimal()
	self:_stopFeedAnimalEff()

	local resPath = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_03.prefab"

	self._foodeff = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, false, false, nil, function(target, eff)
		eff:setParent(self._animalImage.transform)
		eff:setScale(1)
		eff:setVisible(true, true)
	end)
	self._isFeeding = false

	uGuiUtil.setGoGrayState(self._btnFeed.gameObject, self._animalMo.nextExp <= 0)
	goutil.setActive(self._txtExpBg, self._animalMo.nextExp > 0)

	if self._animalMo.nextExp > 0 then
		self._sldExp:SetValue(self._animalMo.exp / self._animalMo.nextExp)

		self._txtExp.text = string.format("%d/%d", self._animalMo.exp, self._animalMo.nextExp)
	else
		self._sldExp:SetValue(1)

		self._txtExp.text = self._animalMo.exp
	end

	self._surplusage.text = string.format(lang("petzoo_friuts_num"), checkint(MaterialMgr.getMatCount(self._feedItemInfo)))
	self._txtLv.text = self._animalMo.level

	self:_updateAnimalPairTimes()
end

function ZooanimalView:_feedBuddyAnimal()
	self:_stopFeedAnimalEff()

	self._isFeeding = false

	local resPath = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_03.prefab"

	self._foodeff = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, false, false, nil, function(target, eff)
		eff:setParent(self._animalImage.transform)
		eff:setScale(1)
		eff:setVisible(true, true)
	end)

	FloatWordMgr.instance:show(ZooConfig.instance:getGoodActIncMoralString())
end

function ZooanimalView:_stopFeedAnimalEff()
	if self._foodeff then
		UIEffectManager.instance:stopEffect(self._foodeff)

		self._foodeff = nil
	end
end

function ZooanimalView:_onClickBtnHelp()
	ViewMgr.instance:open(ViewName.RulesView, "mengchongyuan_animalview")
end

function ZooanimalView:_onClickBtnInfo()
	UIStateManager.instance:push(ViewName.ZooanimalinfoView, self._animalMo, self._friendId)
end

function ZooanimalView:_onClickBtnPair()
	if self._animalMo:isCanMatch() then
		UIStateManager.instance:push(ViewName.ZooinvitepairView, self._animalMo)
	elseif self._animalMo:isMatchCD() then
		FloatWordMgr.instance:show(lang("petzoo_matchtimes_cd"))
	else
		FloatWordMgr.instance:show(lang("petzoo_matchtimes_over"))
	end
end

function ZooanimalView:_onClickBtnFeed()
	if not self:_checkFeedCostEnough() then
		return
	end

	if not self._isFeeding then
		self._isFeeding = true

		if self._friendId then
			local zooInfo = ZooModel.instance:getMyZoo()
			local maxTimes = ZooConfig.instance:getFeedBuddyAnimalMaxTimes()

			if maxTimes > zooInfo:getHasFeedBuddyAnimalTimes() then
				ZooController.instance:sendPM_ZooFeedBuddyAnimalReq(self._friendId)
			else
				FloatWordMgr.instance:show(lang("petzoo_feed_times_over"))
			end
		elseif self._animalMo.nextExp > 0 then
			ZooController.instance:sendPM_ZooFeedAnimalReq(self._animalMo.id)
		else
			self._isFeeding = false

			FloatWordMgr.instance:show(lang("petzoo_feed_max_level"))
		end
	end
end

function ZooanimalView:_checkFeedCostEnough()
	if checkint(MaterialMgr.getMatCount(self._feedItemInfo)) < checkint(self._feedNum) and checkint(self._feedNum) > 0 then
		local matType, id, matNum = MaterialMgr.getMatParams(self._feedItemInfo)

		MaterialMgr.openGetSource(matType, id)

		local matName = MaterialMgr.getMaterialsName(matType, id)

		FloatWordMgr.instance:show(string.format(lang("petzoo_feed_items_noenough"), matName))

		return false
	end

	return true
end

function ZooanimalView:_onSwitchFollowState()
	local isFollow = not self._animalMo.follow

	ZooController.instance:sendPM_AnimalSetFollowStateReq(self._animalMo.id, isFollow)
end

function ZooanimalView:_updateFollowStatus()
	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = myZoo:getAnimalById(self._animalMo.id)

	if animalMo.follow then
		self._followIcon:SetState(1)

		self._btnFollowText.text = lang("petzoo_animalinfo_dontfollow")
	else
		self._followIcon:SetState(0)

		self._btnFollowText.text = lang("petzoo_animalinfo_follow")
	end
end

function ZooanimalView:_onRecycleAnimal(animalId)
	if animalId == self._animalMo.id then
		self:close()
	end
end

function ZooanimalView:_onClickBtnPlayBubble()
	return
end

function ZooanimalView:_onDrag(eventData)
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function ZooanimalView:_onClickBtnRename()
	UIStateManager.instance:push(ViewName.ZooRenameView, self._animalMo.id)
end

function ZooanimalView:_onClickPrev()
	self:_updateByAnimalMo(ZoowarehouseController.instance:getAdjoinAnimal(false))
end

function ZooanimalView:_onClickNext()
	self:_updateByAnimalMo(ZoowarehouseController.instance:getAdjoinAnimal(true))
end

function ZooanimalView:_onClickClose()
	ZoowarehouseController.instance:recordAnimalList()
	self:close()
end

return ZooanimalView
