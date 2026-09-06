-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethMainView.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethMainView", package.seeall)

local ReviveElizabethMainView = class("ReviveElizabethMainView", ViewComponent)

function ReviveElizabethMainView:ctor()
	ReviveElizabethMainView.super.ctor(self)
end

function ReviveElizabethMainView:unbindEvents()
	ReviveElizabethMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStory)
	GameUtil.rmClickHandler(self._btnPlantFlower)
	GameUtil.rmClickHandler(self._btnInputSoul)
	GameUtil.rmClickHandler(self._btnWorld)
	GameUtil.rmClickHandler(self._worldMask)
end

function ReviveElizabethMainView:bindEvents()
	ReviveElizabethMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickBtnStory, self)
	GameUtil.addClickHandler(self._btnPlantFlower, self._onClickbtnPlantFlower, self)
	GameUtil.addClickHandler(self._btnInputSoul, self._onClickbtnInputSoul, self)
	GameUtil.addClickHandler(self._btnWorld, self._onClickBtnWorld, self)
	GameUtil.addClickHandler(self._worldMask, self._onClickBtnWorld, self)
end

function ReviveElizabethMainView:buildUI()
	ReviveElizabethMainView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._txtTime = self:getGo("time/txt"):GetComponent(typeof(UnityEngine.UI.Text))
	self._danMuGroup = self:getGo("danMuGroup")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStory = self:getGo("leftTop/btnStory")
	self._btnPlantFlower = self:getGo("btnPlantFlower")
	self._btnInputSoul = self:getGo("btnInputSoul")
	self._btnPlantFlowerRp = goutil.findChild(self._btnPlantFlower, "redpoint")
	self._btnInputSoulRp = goutil.findChild(self._btnInputSoul, "redpoint")
	self._userProgText = self:getGo("tableview/progress/prog"):GetComponent(typeof(UnityEngine.UI.Text))
	self._userProgBar = self:getGo("tableview/viewport/content/slider"):GetComponent("Slider")
	self._userCell = self:getGo("tableview/tablecell")
	self._userTableview = self:getGo("tableview")
	self._userRectTrans = self._userTableview:GetComponent(typeof(UnityEngine.RectTransform))
	self._btnWorld = self:getGo("worldRectTrans/root/btn")
	self._btnWorldRp = self:getGo("worldRectTrans/root/btn/redpoint")
	self._arrowWorld = self:getGo("worldRectTrans/root/btn/arrow")
	self._worldRoot = self:getGo("worldRectTrans/root")
	self._worldMask = self:getGo("worldMask")
	self._worldContent = self:getGo("worldRectTrans/root/content")
	self._worldProgText = self:getGo("worldRectTrans/root/content/progress/prog"):GetComponent(typeof(UnityEngine.UI.Text))
	self._worldProgBar = self:getGo("worldRectTrans/root/content/tableview/viewport/content/progBar"):GetComponent("Slider")
	self._worldCell = self:getGo("worldRectTrans/root/content/tableview/cell")
	self._worldTableview = self:getGo("worldRectTrans/root/content/tableview")
	self._worldRectTrans = self:getGo("worldRectTrans"):GetComponent(typeof(UnityEngine.RectTransform))
	self._userSl = ScrollerList.create(self._userTableview, self._userCell, GameUtil.handler(self._updateUserSlCell, self), GameUtil.handler(self._clearUserSlCell, self))

	self._userSl:regReloadFinish(GameUtil.handler(self._reloadUserSlFinish, self))

	self._worldSl = ScrollerList.create(self._worldTableview, self._worldCell, GameUtil.handler(self._updateWorldSlCell, self), GameUtil.handler(self._clearWorldSlCell, self))

	self._worldSl:regReloadFinish(GameUtil.handler(self._reloadWorldSlFinish, self))
end

function ReviveElizabethMainView:onExit()
	ReviveElizabethMainView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)

	if self._userEffectMap then
		for _, effect in pairs(self._userEffectMap) do
			self:_unloadEffect(effect)
		end

		self._userEffectMap = nil
	end

	if self._worldEffectMap then
		for _, effect in pairs(self._worldEffectMap) do
			self:_unloadEffect(effect)
		end

		self._worldEffectMap = nil
	end

	if self._userBtnMap then
		for _, btn in pairs(self._userBtnMap) do
			GameUtil.rmClickHandler(btn)
		end
	end

	if self._worldBtnMap then
		for _, btn in pairs(self._worldBtnMap) do
			GameUtil.rmClickHandler(btn)
		end
	end

	self:_clearDanMu()
	self._userSl:dispose()
	self._worldSl:dispose()
	self:_unregRedPoint()

	self._isShowWorld = false

	self:_closeWorldSl(self._offestX, self._offestY)
end

function ReviveElizabethMainView:onEnter()
	ReviveElizabethMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ReviveElizabethGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.ItemGetViewDoClosed, self._onItemGetViewClosed, self)
	self:_initWorldSlOffest()
	self:_initActivityId()
	self:_initActivityTime()
	self:_getConfigs(self._activityId)
	self:_regRedPoint()

	self._userBtnMap = {}
	self._userEffectMap = {}
	self._worldEffectMap = {}
	self._worldBtnMap = {}
	self._lastBgName = self._userProgCfg[1].img

	ReviveElizabethController.instance:setSpriteToImage(self._bg, ReviveElizabethController.BgFloderUrl, self._lastBgName)

	self._isShowWorld = false

	self:_closeWorldSl(self._offestX, self._offestY)

	local isSkipShowDanMu = false
	local params = self:getOpenParam()

	if params then
		local openViewName = params[1]

		UIStateManager.instance:popByName(openViewName)
	end

	local key = "ReviveElizabethMainView" .. self._activityId

	local function firstTimeCallback()
		local storyId = self._config.storyId

		if storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		isSkipShowDanMu = true
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)

	if not isSkipShowDanMu then
		self:_initDanMus()
	end

	ReviveElizabethAgent.instance:sendPM_ReviveElizabethGetInfoReq(self._activityId)
end

function ReviveElizabethMainView:_initActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ReviveElizabeth)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end
end

function ReviveElizabethMainView:_initActivityTime()
	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.ReviveElizabeth, self._activityId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function ReviveElizabethMainView:_regRedPoint()
	RedPointController.instance:regRedPoint(self._btnPlantFlowerRp, "c35")
	RedPointController.instance:regRedPoint(self._btnPlantFlowerRp, self._config.seedRedPointId)
	self:_refreshRedPoint()
end

function ReviveElizabethMainView:_unregRedPoint()
	RedPointController.instance:unregRedPoint(self._btnPlantFlowerRp)
	RedPointController.instance:unregRedPoint(self._btnInputSoulRp)
end

function ReviveElizabethMainView:_refreshRedPoint()
	local showWorldRp = checkbool(ReviveElizabethModel.instance:getWorldPrizeState(self._activityId))
	local showSoulRp = checkbool(ReviveElizabethModel.instance:getFlowerSoulState(self._activityId))

	goutil.setActive(self._btnWorldRp, showWorldRp)
	goutil.setActive(self._btnInputSoulRp, showSoulRp)
end

function ReviveElizabethMainView:_getConfigs(ativityId)
	self._config = ReviveElizabethConfig.instance:getActivityCfg(ativityId)
	self._userProgCfg = ReviveElizabethConfig.instance:getUserProgressPrizeCfg(ativityId)
	self._worldProgCfg = ReviveElizabethConfig.instance:getWorldProgressPrizeCfg(ativityId)
	self._messageCfg = ReviveElizabethConfig.instance:getMessage()
	self._maxDanMuNum = tonumber(ReviveElizabethConfig.instance:getRandPlanValue("MAX_MSG_NUM"))

	local iconSetCfg = string.split(ReviveElizabethConfig.instance:getRandPlanValue("AVATAR_RANGE"), "#")
	local iconSetId = math.random(#iconSetCfg)

	self._iconSetPair = string.split(iconSetCfg[iconSetId], ",")

	local frameSetCfg = string.split(ReviveElizabethConfig.instance:getRandPlanValue("AVATAR_FRAME_RANGE"), "#")
	local frameSetId = math.random(#frameSetCfg)

	self._frameSetPair = string.split(frameSetCfg[frameSetId], ",")
end

function ReviveElizabethMainView:_refreshView()
	self._info = ReviveElizabethModel.instance:getInfo(self._activityId)

	if not self._info then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self:_refreshRedPoint()
	self._userSl:reloadData(self._userProgCfg)
	self._worldSl:reloadData(self._worldProgCfg)

	self._userProg = ReviveElizabethController.instance:setSliderValue(self._userProgBar, self._userProgText, self._userProgCfg, self._info.progress)
	self._userProgText.text = self._userProgText.text .. "朵"
	self._worldProg = ReviveElizabethController.instance:setSliderValue(self._worldProgBar, self._worldProgText, self._worldProgCfg, self._info.worldProgress)
	self._worldProgText.text = self._worldProgText.text .. "次"

	local bgName = self._userProgCfg[self._userProg].img

	if bgName and bgName ~= self._lastBgName then
		self._lastBgName = bgName

		ReviveElizabethController.instance:setSpriteToImage(self._bg, ReviveElizabethController.BgFloderUrl, bgName)
	end
end

function ReviveElizabethMainView:_updateUserSlCell(view, cell, data)
	self:_clearUserSlCell(cell)

	local item = goutil.findChild(cell, "cell/item")
	local effect = goutil.findChild(cell, "cell/effect")
	local got = goutil.findChild(cell, "cell/got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if not self._info.gainUserPrizeIds then
		local isGot = table.keyof(self._info.gainUserPrizeIds, data.prizeId) or false
		local canGet = not isGot and data.progress <= self._info.progress

		self._userBtnMap[cell] = self._userBtnMap[cell] or goutil.findChild(cell, "cell/btn")

		if canGet then
			self._userEffectMap[cell] = self:_loadEffect(effect, self._userRectTrans)

			GameUtil.addClickHandler(self._userBtnMap[cell], GameUtil.handler(self._onClickBtnPrize, self, 1, data.prizeId), self)
		end

		progress.text = tostring(data.progress)

		goutil.setActive(got, isGot)
		goutil.setActive(self._userBtnMap[cell], canGet)
	end
end

function ReviveElizabethMainView:_clearUserSlCell(cell)
	local got = goutil.findChild(cell, "cell/got")
	local item = goutil.findChild(cell, "cell/item")

	goutil.setActive(got, false)

	if self._userEffectMap and self._userEffectMap[cell] then
		self:_unloadEffect(self._userEffectMap[cell])
	end

	GameUtil.rmClickHandler(self._userBtnMap[cell])
	goutil.setActive(self._userBtnMap[cell], false)
	MaterialMgr.resetAll(item)
end

function ReviveElizabethMainView:_updateWorldSlCell(view, cell, data)
	self:_clearWorldSlCell(cell)

	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local got = goutil.findChild(cell, "got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if not self._info.gainWorldPrizeIds then
		local isGot = table.keyof(self._info.gainWorldPrizeIds, data.prizeId) or false
		local canGet = not isGot and data.progress <= self._info.worldProgress

		self._worldBtnMap[cell] = self._worldBtnMap[cell] or goutil.findChild(cell, "btn")

		if canGet then
			self._worldEffectMap[cell] = self:_loadEffect(effect, self._worldRectTrans)

			GameUtil.addClickHandler(self._worldBtnMap[cell], GameUtil.handler(self._onClickBtnPrize, self, 2, data.prizeId), self)
		end

		progress.text = tostring(data.progress)

		goutil.setActive(got, isGot)
		goutil.setActive(self._worldBtnMap[cell], canGet)
	end
end

function ReviveElizabethMainView:_clearWorldSlCell(cell)
	local item = goutil.findChild(cell, "item")
	local got = goutil.findChild(cell, "got")

	goutil.setActive(got, false)

	if self._worldEffectMap and self._worldEffectMap[cell] then
		self:_unloadEffect(self._worldEffectMap[cell])
	end

	GameUtil.rmClickHandler(self._worldBtnMap[cell])
	goutil.setActive(self._worldBtnMap[cell], false)
	MaterialMgr.resetAll(item)
end

function ReviveElizabethMainView:_reloadUserSlFinish()
	if self._userProg then
		self._userSl:MoveCellToCenter(self._userProg - 1)
	end
end

function ReviveElizabethMainView:_reloadWorldSlFinish()
	if self._worldProg then
		self._worldSl:MoveCellToCenter(self._worldProg - 1)
	end
end

function ReviveElizabethMainView:_loadEffect(root, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, true, false, nil, function()
		if rectTrans then
			effect:setClipping(rectTrans)
		end
	end)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function ReviveElizabethMainView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

function ReviveElizabethMainView:_initDanMus()
	local sourceGo = self:getGo("danMu")

	self._danMuList = {}

	for i = 1, self._maxDanMuNum do
		local danMu = {}

		danMu.go = goutil.cloneAndSetParent(sourceGo, self._danMuGroup.transform, "danMu" .. i)
		danMu.header = goutil.findChild(danMu.go, "headcon")
		danMu.content = goutil.findChild(danMu.go, "bubble/txt"):GetComponent(typeof(UnityEngine.UI.Text))

		table.insert(self._danMuList, danMu)
	end

	self._danMuCurIndex = 1

	self:_danMuMove()
	settimer(ReviveElizabethController.DanMuInterval, self._danMuMove, self, true)
end

function ReviveElizabethMainView:_danMuMove()
	local danMu = self._danMuList[self._danMuCurIndex]
	local iconIndex = math.random(tonumber(self._iconSetPair[1]), tonumber(self._iconSetPair[2]))
	local fameIndex = math.random(tonumber(self._frameSetPair[1]), tonumber(self._frameSetPair[2]))
	local textIndex = math.random(1, #self._messageCfg)

	if self._lastTextIndex and self._lastTextIndex == textIndex then
		textIndex = textIndex % #self._messageCfg + 1
	end

	HeadItemController.instance:setHeadCell(danMu.header, iconIndex, fameIndex)

	danMu.content.text = self._messageCfg[textIndex].words
	self._lastTextIndex = textIndex

	local go = self._danMuList[self._danMuCurIndex].go
	local posY = math.random(70, 250)
	local from = Vector3.New(0, posY, 0)
	local to = Vector3.New(-2500, posY, 0)

	UnityTweens.TweenPosition.StartTween(go, from, to, ReviveElizabethController.DanMuDuration, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

	self._danMuCurIndex = (self._danMuCurIndex + 1) % 3 + 1
end

function ReviveElizabethMainView:_clearDanMu()
	removetimer(self._danMuMove, self)

	if self._danMuList then
		for i, danMu in ipairs(self._danMuList) do
			if danMu.header then
				MaterialMgr.resetAll(danMu.header)
			end
		end
	end

	goutil.clearChildren(self._danMuGroup)
end

function ReviveElizabethMainView:_onClickBtnWorld()
	if self._isShowWorld then
		self._isShowWorld = false

		self:_closeWorldSl(self._offestX, self._offestY)
	else
		self._isShowWorld = true

		self:_openWorldSl(self._offestX, self._offestY)
	end
end

function ReviveElizabethMainView:_initWorldSlOffest()
	local uiWidth = ViewMgr.instance:getUIWidth()

	self._offestX = 0
	self._offestY = 0

	if uiWidth == 1800 then
		GameUtil.setAnchoredPos(self._worldRectTrans, -20, 0)
	end
end

function ReviveElizabethMainView:_openWorldSl(offestX, offestY)
	goutil.setActive(self._worldContent, true)
	goutil.setActive(self._worldMask, true)
	GameUtil.setAnchoredPos(self._worldRoot, -2.46 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 0)
end

function ReviveElizabethMainView:_closeWorldSl(offestX, offestY)
	goutil.setActive(self._worldContent, false)
	goutil.setActive(self._worldMask, false)
	GameUtil.setAnchoredPos(self._worldRoot, 184.2 + offestX, -267.3 + offestY)
	GameUtil.setLocalRotation(self._arrowWorld, 0, 0, 180)
end

function ReviveElizabethMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("reviveelizabethmainview_rule")
end

function ReviveElizabethMainView:_onClickBtnStory()
	UIStateManager.instance:push(ViewName.ReviveElizabethStoryView, self._activityId, self._worldProg)
end

function ReviveElizabethMainView:_onClickbtnPlantFlower()
	UIStateManager.instance:push(ViewName.ReviveElizabethGameView, self._activityId)
end

function ReviveElizabethMainView:_onClickbtnInputSoul()
	UIStateManager.instance:push(ViewName.ReviveElizabethProgressView, self._activityId)
end

function ReviveElizabethMainView:_onClickBtnPrize(prizeType, prizeId)
	ReviveElizabethAgent.instance:sendPM_ReviveElizabethGainPrizeReq(self._activityId, prizeType, prizeId)
end

function ReviveElizabethMainView:_onItemGetViewClosed()
	local info = ReviveElizabethModel.instance:getLastPrizeInfo(self._activityId)

	if info then
		if info.prizeType == 2 then
			local storyId = checknumber(self._worldProgCfg[info.prizeId].storyId)

			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
			end
		elseif info.prizeType == 1 then
			local cfg = ReviveElizabethConfig.instance:getSoulConfig(self._activityId)

			for i, v in ipairs(cfg) do
				if info.prizeId == v.prizeId then
					if self._info.hasInjectSoulPrizeIds then
						local isGot = table.keyof(self._info.hasInjectSoulPrizeIds, info.prizeId) ~= nil

						if not isGot then
							UIStateManager.instance:push(ViewName.ReviveElizabethProgressView, self._activityId)

							break
						end
					end
				end
			end
		end
	end
end

return ReviveElizabethMainView
