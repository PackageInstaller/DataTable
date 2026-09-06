-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationCheckInView.lua

module("logic.extensions.operationsignin.view.OperationCheckInView", package.seeall)

local OperationCheckInView = class("OperationCheckInView", ViewComponent)

function OperationCheckInView:ctor()
	OperationCheckInView.super.ctor(self)
end

function OperationCheckInView:buildUI()
	OperationCheckInView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._tablecell = self:getGo("signIn/tablecell")
	self._item = self:getGo("signIn/tablecell/itemObj")
	self._tableview = self:getGo("signIn/tableview")
	self._tableviewViewport = self:getGo("signIn/tableview/Viewport")
	self._getPrizeBtn = self:getGo("signIn/tablecell/getPrizeBtn")
	self._clipRect = self._tableviewViewport:GetComponent(goutil.Type_RectTransform)
	self._taskScrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._petShowImage1 = goutil.findChildImageComponent(self.mainGO, "versionPetShow/Image")
	self._petShowImage2 = goutil.findChildImageComponent(self.mainGO, "versionPetShow/Image2")
	self._fadeInterval = 3
	self._fadeSequence = DG.Tweening.DOTween.Sequence()
	self._petShowList = {}
	self._petShowIndex = 1
	self._petIndexImageList = goutil.findChild(self.mainGO, "petIndexImageList")
	self._children = GameUtil.getChildren(self._petIndexImageList)
end

function OperationCheckInView:bindEvents()
	OperationCheckInView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClikBtnTip, self)
end

function OperationCheckInView:unbindEvents()
	OperationCheckInView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OperationCheckInView:onEnter()
	OperationCheckInView.super.onEnter(self)

	self._activityId = 49003
	self._activityType = 49
	self._versionShowPetActivityId = 49003
	self._scrollOffset = 1

	self.addGEvent(self, GlobalNotify.OperationSignIn, self._onSetUI, self)
	OperationSignInModel.instance:setActivityId(self._activityId)
	OperationSignInController.instance:getInfo()
	self:_onSetUI()
end

function OperationCheckInView:onExit()
	OperationCheckInView.super.onExit(self)
	self:_removeAllEffect()
	self._taskScrollList:dispose()
	uGuiUtil.clearImage(self._petShowImage1)
	uGuiUtil.clearImage(self._petShowImage2)
	self._petShowImage1:DOKill(true)
	self._petShowImage2:DOKill(true)
	self._fadeSequence:Kill()
end

function OperationCheckInView:_onSetUI()
	self._imageData = OperationSignInConfig.instance:getVersionShowPetCfg(self._versionShowPetActivityId) or {}
	self._scrollerData = OperationSignInConfig.instance:getSignInCfgList(self._activityId) or {}

	table.sort(self._scrollerData, function(a, b)
		return a.day < b.day
	end)
	table.sort(self._imageData, function(a, b)
		return a.day < b.day
	end)

	for _, v in ipairs(self._imageData) do
		table.insert(self._petShowList, v)
	end

	self._onlineDay = OperationSignInModel.instance:getOnlineDay() or -1
	self._curUnLockImageIndex = 0
	self._curUnLockImageNum = 0

	for _, v in ipairs(self._imageData) do
		if self._onlineDay < v.num then
			break
		end

		self._curUnLockImageIndex = v.num
		self._curUnLockImageNum = self._curUnLockImageNum + 1
	end

	self._taskScrollList:reloadData(self._scrollerData)

	local daysList = OperationSignInModel.instance:getDaysList()

	for i = 1, self._onlineDay do
		if not daysList[i] then
			self._scrollOffset = i

			break
		end
	end

	self._taskScrollList:MoveCellToBegin(self._scrollOffset - 1, false)

	if self._onlineDay < self._imageData[1].num then
		GameUtil.SetActive(self._petShowImage1.gameObject, false)
		GameUtil.SetActive(self._petShowImage2.gameObject, false)
		GameUtil.SetActive(self._petIndexImageList, false)

		return
	else
		GameUtil.SetActive(self._petShowImage1.gameObject, true)
		GameUtil.SetActive(self._petShowImage2.gameObject, true)
		GameUtil.SetActive(self._petIndexImageList, true)
	end

	uGuiUtil.clearImage(self._petShowImage1.gameObject)
	uGuiUtil.clearImage(self._petShowImage2.gameObject)
	uGuiUtil.setSpriteToImage(self._petShowImage1.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/huanxinqinghuode/%s.png", self._petShowList[1].icon))
	uGuiUtil.setSpriteToImage(self._petShowImage2.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/huanxinqinghuode/%s.png", self._petShowList[2].icon))

	local fadeOutTweener1 = self._petShowImage1:DOFade(0, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		uGuiUtil.clearImage(self._petShowImage1.gameObject)

		if (self._petShowIndex + 1) % self._curUnLockImageNum > 0 then
			if not ((self._petShowIndex + 1) % self._curUnLockImageNum) then
				local curIndex = self._curUnLockImageNum

				uGuiUtil.setSpriteToImage(self._petShowImage1.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/huanxinqinghuode/%s.png", self._petShowList[curIndex].icon))
			end
		end
	end)
	local fadeInTweener2 = self._petShowImage2:DOFade(1, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear)
	local fadeInTweenerContinue2 = self._petShowImage2:DOFade(1, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		self._petShowIndex = self._petShowIndex + 1

		self:_updatePetIndexImage()
	end)
	local fadeInTweener1 = self._petShowImage1:DOFade(1, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear)
	local fadeInTweenerContinue1 = self._petShowImage1:DOFade(1, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		self._petShowIndex = self._petShowIndex + 1

		self:_updatePetIndexImage()
	end)
	local fadeOutTweener2 = self._petShowImage2:DOFade(0, self._fadeInterval):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
		uGuiUtil.clearImage(self._petShowImage2.gameObject)

		if (self._petShowIndex + 1) % self._curUnLockImageNum > 0 then
			if not ((self._petShowIndex + 1) % self._curUnLockImageNum) then
				local curIndex = self._curUnLockImageNum

				uGuiUtil.setSpriteToImage(self._petShowImage2.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/huanxinqinghuode/%s.png", self._petShowList[curIndex].icon))
			end
		end
	end)

	self._fadeSequence:Append(fadeInTweenerContinue1)
	self._fadeSequence:Append(fadeOutTweener1)
	self._fadeSequence:Join(fadeInTweener2)
	self._fadeSequence:Append(fadeInTweenerContinue2)
	self._fadeSequence:Append(fadeInTweener1)
	self._fadeSequence:Join(fadeOutTweener2)
	self._fadeSequence:SetLoops(-1)
	self:_setPetIndexImage()
end

function OperationCheckInView:_setPetIndexImage()
	local petShowNum = self._curUnLockImageNum

	if self._children then
		for i, v in ipairs(self._children) do
			if i <= petShowNum then
				GameUtil.SetActive(v, true)
			else
				GameUtil.SetActive(v, false)
			end
		end
	end
end

function OperationCheckInView:_updatePetIndexImage()
	if (self._petShowIndex - 1) % self._curUnLockImageNum > 0 then
		if not ((self._petShowIndex - 1) % self._curUnLockImageNum) then
			local preIndex = self._curUnLockImageNum

			if self._petShowIndex % self._curUnLockImageNum > 0 then
				if not (self._petShowIndex % self._curUnLockImageNum) then
					local curIndex = self._curUnLockImageNum
					local cur = self._children[curIndex]:GetComponent("Image")
					local pre = self._children[preIndex]:GetComponent("Image")

					cur.color = GameUtil.getColorByHexColor(707070)
					pre.color = Color.New(1, 1, 1, 1)
				end
			end
		end
	end
end

function OperationCheckInView:_updateTaskCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "activityTitle/txtTitle")
	local taskTitle = goutil.findChildTextComponent(cell, "activityDetail/Title/title")
	local title = goutil.findChild(cell, "activityDetail/Title")
	local taskDetail = goutil.findChildTextComponent(cell, "activityDetail/text")
	local getPrizeBtn = goutil.findChild(cell, "getPrizeBtn")
	local itemView = goutil.findChild(cell, "itemView")
	local waitUnlockText = goutil.findChild(cell, "activityDetail/waitUnLockText")
	local imgFZ = goutil.findChild(cell, "con/Image")
	local items = {}
	local daysList = OperationSignInModel.instance:getDaysList()

	txtTitle.text = "累计签到" .. data.day .. "天"

	if self._onlineDay < data.day then
		taskTitle.text = ""
		taskDetail.text = ""

		GameUtil.SetActive(waitUnlockText, true)
		GameUtil.SetActive(title, false)
		GameUtil.SetActive(imgFZ, true)
		GameUtil.SetActive(itemView, false)
	else
		GameUtil.SetActive(title, true)
		GameUtil.SetActive(waitUnlockText, false)

		taskTitle.text = data.posterTitle
		taskDetail.text = data.posterText

		GameUtil.SetActive(imgFZ, false)
		GameUtil.SetActive(itemView, true)
	end

	local itemData = string.split(data.reward, "#")

	for i = 1, #itemData do
		local item
		local type, id, itemNum = MaterialMgr.getMatParams(itemData[i])

		if itemView.transform.childCount < #itemData then
			item = goutil.cloneAndSetParent(self._item, itemView.transform, string.format("item%d", i))

			GameUtil.SetActive(item, true)
		else
			item = goutil.findChild(cell, string.format("itemView/item%d", i))
		end

		local effRoot = goutil.findChild(item, "effRoot")
		local itemCell = goutil.findChild(item, "itemCell")

		MaterialMgr.setCell(type, id, itemCell)

		local gainBg = goutil.findChild(item, "gainBg")

		GameUtil.SetActive(gainBg, daysList[data.day])
		GameUtil.SetActive(getPrizeBtn, not daysList[data.day])

		if self._onlineDay >= data.day and not daysList[data.day] then
			GameUtil.addClickHandler(getPrizeBtn, function()
				local function func(msg)
					MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
					self:_removeEffect(cell)
				end

				OperationSignInController.instance:gainPrize(data.day, func)
				OperationSignInController.instance:getInfo()
			end, self)

			if i == 1 then
				self:_removeEffect(cell)
			end

			self:_createEff("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effRoot, cell, i, true, self._clipRect)
		else
			GameUtil.SetActive(getPrizeBtn, false)
			self:_removeEffect(cell)
		end

		table.insert(items, item)
	end
end

function OperationCheckInView:_clearTaskCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function OperationCheckInView:_createEff(effPath, effParent, effKey, id, isLoop, clipRect)
	self._existEffs = self._existEffs or {}

	if not effParent then
		return
	end

	local function loadHandler(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		if clipRect then
			eff:setClipping(clipRect)
		end
	end

	local newEff = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, loadHandler)

	self._existEffs[effKey] = self._existEffs[effKey] or {}

	if id then
		self._existEffs[effKey][id] = newEff
	else
		self._existEffs[effKey][1] = newEff
	end
end

function OperationCheckInView:_removeAllEffect()
	if self._existEffs then
		for k, eff in pairs(self._existEffs) do
			self:_removeEffect(eff)
		end

		self._existEffs = nil
	end
end

function OperationCheckInView:_removeEffect(key)
	if self._existEffs then
		if self._existEffs then
			for _, eff in pairs(self._existEffs) do
				UIEffectManager.instance:stopEffect(eff)
			end

			self._existEffs[key] = nil
		end
	end
end

function OperationCheckInView:_onClikBtnTip()
	return
end

return OperationCheckInView
