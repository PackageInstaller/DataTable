-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageProgressPopMediator.lua

StageProgressPopMediator = class("StageProgressPopMediator", DmPopupViewMediator, _M)

StageProgressPopMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	["main.touchPanel"] = {
		ignoreClickAudio = true,
		func = "onClickClose"
	}
}

function StageProgressPopMediator:initialize()
	super.initialize(self)
end

function StageProgressPopMediator:dispose()
	super.dispose(self)
end

function StageProgressPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._rewardPanel = self._main:getChildByName("rewardPanel")
end

function StageProgressPopMediator:enterWithData(data)
	self._data = data
	self._parentMediator = data.mediator

	local sectionStateTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StagePresentOrder", "content")

	self._stageInfo = sectionStateTab[self._data.tag]

	local playerStageProgressReward = self._stageSystem:getStagePresents()

	self._rewardProgress = playerStageProgressReward[self._stageInfo.stageName]

	if self._rewardProgress == nil then
		return
	end

	local heroModelId = self._stageInfo.Model
	local heroImg = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = heroModelId
	})
	local heroPanel = self._main:getChildByName("heroPanel")

	heroPanel:removeAllChildren()
	heroImg:addTo(heroPanel)
	heroImg:setPosition(cc.p(210, 195))

	local text1 = self._main:getChildByName("text1")
	local text2 = self._main:getChildByName("text2")

	text1:enableShadow(cc.c4b(0, 0, 0, 102), cc.size(2.7, -6), 6)
	text2:enableShadow(cc.c4b(0, 0, 0, 102), cc.size(2.7, -6), 6)
	text1:enableOutline(cc.c4b(59, 52, 97, 178.5), 1)
	text2:enableOutline(cc.c4b(59, 52, 97, 178.5), 1)
	text1:setString(Strings:get(self._stageInfo.TitleDesc1))
	text2:setString(Strings:get(self._stageInfo.TitleDesc2))

	local word1 = self._main:getChildByName("word1")
	local word2 = self._main:getChildByName("word2")

	word1:enableOutline(cc.c4b(255, 195, 145, 51), 1)
	word2:enableOutline(cc.c4b(255, 195, 145, 51), 1)
	word1:setString(Strings:get(self._stageInfo.HeroInfo1))
	word2:setString(Strings:get(self._stageInfo.HeroInfo2))
	self:setRewardPanel()
end

function StageProgressPopMediator:parsePointId(pointId)
	local mapId = self._stageSystem:getMapIndexByPointId(pointId)
	local pointId = self._stageSystem:getPointIndexById(pointId)

	return tostring(mapId .. "-" .. pointId)
end

function StageProgressPopMediator:setRewardPanel()
	local rewardCell = self:getView():getChildByName("reward")
	local rewardList = self._stageInfo.reward
	local gotReward = self._rewardProgress.gotRewards

	self._rewardPanel:removeAllChildren()

	local startPointId = ConfigReader:getDataByNameIdAndKey("UnlockSystem", self._stageInfo.Unlock, "Condition").STAGE

	for i = 1, #rewardList do
		local _cell = rewardCell:clone()

		_cell:addTo(self._rewardPanel)

		local iconFrame = _cell:getChildByName("rewardIcon")
		local Text1 = _cell:getChildByName("Text_1")
		local extText = _cell:getChildByName("extText")
		local rewardInfo = ConfigReader:getDataByNameIdAndKey("Reward", rewardList[i].reward, "Content")
		local rewardIcon = IconFactory:createRewardIcon(rewardInfo[1], {
			isWidget = false
		})

		rewardIcon:setScale(0.8)

		if rewardIcon.getAmountLabel then
			local label = rewardIcon:getAmountLabel()

			if label then
				label:setScale(1.8)
				label:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			end
		end

		rewardIcon:addTo(iconFrame, 1, 9521)
		rewardIcon:setPosition(cc.p(38.7, 40.5))
		IconFactory:bindTouchHander(iconFrame, IconTouchHandler:new(self), rewardInfo[1], {
			needDelay = true
		})

		local curStage = _cell:getChildByName("curStage")

		if getCurrentLanguage() ~= GameLanguageType.CN then
			curStage:setFontSize(14)
			Text1:setFontSize(13)
		end

		local a, b = self:countPointIndex(startPointId, rewardList[i].count)

		curStage:setString(a .. "-" .. b)
		curStage:enableOutline(cc.c4b(0, 0, 0, 204), 1)
		_cell:getChildByName("Text_1"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
		_cell:getChildByName("extText"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)

		local redPoint = iconFrame:getChildByName("redPoint")

		redPoint:setLocalZOrder(2)
		iconFrame:getChildByName("Image2"):setVisible(false)

		if i == #rewardList then
			_cell:setPosition(cc.p(460, 102))
			curStage:setAnchorPoint(0.5, 0.5)
			curStage:setPositionX(_cell:getContentSize().width / 2)
			_cell:getChildByName("Text_1"):setPositionX(_cell:getContentSize().width / 2 - curStage:getContentSize().width / 2 - 3)
			_cell:getChildByName("extText"):setPositionX(_cell:getContentSize().width / 2 + curStage:getContentSize().width / 2 + 3)
		else
			local persent = rewardList[i].count / rewardList[#rewardList].count

			iconFrame:setScale(0.76)
			redPoint:setScale(1.316)
			_cell:setPosition(cc.p(460 * persent, 102))
			_cell:getChildByName("extImage"):setVisible(false)
			_cell:getChildByName("extText"):setVisible(false)
			_cell:getChildByName("Text_1"):setPositionX(_cell:getContentSize().width / 2 - 2)
			curStage:setAnchorPoint(0, 0.5)
			curStage:setPositionX(_cell:getContentSize().width / 2)
		end

		_cell.kCount = rewardList[i].count

		redPoint:setVisible(self._rewardProgress.stageCount >= rewardList[i].count)

		if table.keyof(gotReward, rewardList[i].count) then
			redPoint:setVisible(false)
			iconFrame:getChildByTag(9521):setColor(cc.c3b(120, 120, 120))
			_cell:getChildByName("imgRec"):setVisible(true)
		end

		if self._rewardProgress.stageCount < rewardList[i].count then
			IconFactory:bindTouchHander(_cell, IconTouchHandler:new(self), rewardInfo[1], {
				needDelay = true
			})
		else
			local function callFunc(sender, eventType)
				self:onClickRewardCell(sender)
			end

			mapButtonHandlerClick(nil, _cell, {
				ignoreClickAudio = true,
				func = callFunc
			}, nil, true)
		end

		if redPoint:isVisible() then
			iconFrame:getChildByName("Image2"):setVisible(true)
		end

		if getCurrentLanguage() ~= GameLanguageType.CN then
			Text1:setPositionX(Text1:getPositionX() + 10)
			curStage:setPositionX(curStage:getPositionX() + 10)
			extText:setVisible(false)

			if i == #rewardList then
				Text1:setPositionX(Text1:getPositionX() + 12)
				curStage:setPositionX(curStage:getPositionX() + 12)
			end
		end
	end

	self:setLoadingBar()
end

function StageProgressPopMediator:countPointIndex(pointId, increase)
	local mapIndex = self._stageSystem:getMapIndexByPointId(pointId)
	local pointIndex = self._stageSystem:getPointIndexById(pointId)
	local mapPointCount = self._stageSystem:getMapByIndex(mapIndex):getPointCount()

	if mapPointCount >= pointIndex + increase then
		return mapIndex, pointIndex + increase
	else
		local mapTag = 0
		local pointTag = 0
		local allPointNum = increase - mapPointCount + pointIndex

		for i = mapIndex + 1, 100 do
			local _map = self._stageSystem:getMapByIndex(i)

			if allPointNum <= _map:getPointCount() then
				mapTag = i
				pointTag = allPointNum

				break
			else
				allPointNum = allPointNum - _map:getPointCount()
			end
		end

		return mapTag, pointTag
	end
end

function StageProgressPopMediator:setLoadingBar()
	local rewardList = self._stageInfo.reward
	local loadingBar = self._main:getChildByName("loadingBar")
	local curCount = math.min(self._rewardProgress.stageCount, rewardList[#rewardList].count)
	local maxCount = rewardList[#rewardList].count

	loadingBar:setPercent(curCount * 100 / maxCount)
end

function StageProgressPopMediator:onClickRewardCell(sender)
	local count = sender.kCount

	if not self._rewardProgress then
		return
	end

	if not self._rewardProgress.gotRewards then
		local gotReward = {}

		if table.keyof(gotReward, count) then
			return
		end

		local param = {}

		param.stageName = self._stageInfo.stageName
		param.count = count

		self._stageSystem:requestSectionReward(param, function(resData)
			local iconFrame = sender:getChildByName("rewardIcon")

			iconFrame:getChildByName("Image2"):setVisible(false)
			iconFrame:getChildByName("redPoint"):setVisible(false)
			iconFrame:getChildByTag(9521):setColor(cc.c3b(120, 120, 120))
			sender:getChildByName("imgRec"):setVisible(true)
			self._parentMediator:enableSectionStageBtn()

			local playerStageProgressReward = self._stageSystem:getStagePresents()

			self._rewardProgress = playerStageProgressReward[self._stageInfo.stageName]

			if resData.data then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					remainLastView = true
				}, {
					rewards = resData.data.reward
				}))
			end

			if self._rewardProgress.allGot then
				self:newProgressView()
			end
		end, true)
	end
end

function StageProgressPopMediator:newProgressView()
	local tag = self._data.tag + 1
	local sectionStateTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StagePresentOrder", "content")
	local next = sectionStateTab[tag]

	if next then
		self._data.tag = tag

		self:enterWithData(self._data)
	end
end

function StageProgressPopMediator:onClickClose(sender, eventType)
	self:close()
end

function StageProgressPopMediator:onTouchMaskLayer()
	return
end
