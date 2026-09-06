-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranBattleView.lua

module("logic.extensions.sunranbattle.view.SunranBattleView", package.seeall)

local SunranBattleView = class("SunranBattleView", TableViewComponent)

function SunranBattleView:ctor()
	SunranBattleView.super.ctor(self)

	self._isActivityEnd = false
	self._petItemList = nil
	self._choStageId = nil
	self._allBestScore = 0
end

function SunranBattleView:bindEvents()
	SunranBattleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		SunranBattleModel.instance.cacheStageId = nil

		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "sunranbattle")
	end, self)
	self._rewardBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.SunranReward, self._allBestScore)
	end, self)
	self._rankBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		if self._curViewDatas == nil or self._curViewDatas[self._choStageId] == nil then
			FloatWordMgr.instance:show("排行数据已结束！")

			return
		end

		SunranBattleModel.instance.cacheStageId = self._choStageId

		UIStateManager.instance:push(ViewName.SunranRank, self._curViewDatas[self._choStageId])
	end, self)
	self._nanduBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		if self._curViewDatas == nil or self._curViewDatas[self._choStageId] == nil then
			FloatWordMgr.instance:show("难度选择已结束！")

			return
		end

		UIStateManager.instance:push(ViewName.SunranBuff, self._curViewDatas[self._choStageId])
	end, self)
end

function SunranBattleView:unbindEvents()
	SunranBattleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._nanduBtn:RemoveClickListener()
end

function SunranBattleView:onExit()
	SunranBattleView.super.onExit(self)
	self._siTweenPos:Stop()

	self._siTweenPos = nil

	self._siTweenFade:Stop()

	self._siTweenFade = nil

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.MainBattleInfo, self._updataMoshiListSR, self)

	self._isActivityEnd = false
	self._choStageId = nil
	self._moveViewIndex = nil
	self._allBestScore = 0
end

function SunranBattleView:destroyUI()
	SunranBattleView.super.destroyUI(self)

	local rsgBig = self._rewardScoreImaGo:GetComponent("ImageBigBG")

	if rsgBig then
		rsgBig:ClearImage()
	end

	local tsgBig = self._totalScoreImaGo:GetComponent("ImageBigBG")

	if tsgBig then
		tsgBig:ClearImage()
	end

	local rmgBig = self._recordMaxImaGo:GetComponent("ImageBigBG")

	if rmgBig then
		rmgBig:ClearImage()
	end

	local sigBig = self._sprineImaGo:GetComponent("ImageBigBG")

	if sigBig then
		sigBig:ClearImage()
	end

	self._petItemList = nil
end

function SunranBattleView:buildUI()
	SunranBattleView.super.buildUI(self)

	self._sprineImaGo = self:getGo("sprineIma")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._viewNameTxt = goutil.findChildTextComponent(self.mainGO, "viewNameTxt")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._rewardBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "rewardBtn")
	self._rewardGo = goutil.findChild(leftInfoGo, "rewardGo")
	self._rewardScoreTxt = goutil.findChildTextComponent(self._rewardGo, "rewardScoreTxt")
	self._rewardScoreImaGo = goutil.findChild(self._rewardGo, "rewardScoreTxt/rewardScoreIma")

	local totalGo = goutil.findChild(leftInfoGo, "totalGo")

	self._totalScoreTxt = goutil.findChildTextComponent(totalGo, "totalScoreTxt")
	self._totalScoreImaGo = goutil.findChild(totalGo, "totalScoreIma")

	local rigthInfoGo = self:getGo("rigthInfoGo")

	self._timerTxt = goutil.findChildTextComponent(rigthInfoGo, "timerTxt")
	self._moshiNameTxt = goutil.findChildTextComponent(rigthInfoGo, "moshiNameTxt")
	self._recordMaxTxt = goutil.findChildTextComponent(rigthInfoGo, "recordMaxTxt")
	self._recordMaxImaGo = goutil.findChild(rigthInfoGo, "recordMaxIma")
	self._petDescTxt = goutil.findChildTextComponent(rigthInfoGo, "petDescTxt")
	self._petItemList = {
		goutil.findChild(rigthInfoGo, "petGo_1"),
		goutil.findChild(rigthInfoGo, "petGo_2"),
		goutil.findChild(rigthInfoGo, "petGo_3"),
		goutil.findChild(rigthInfoGo, "petGo_4")
	}
	self._rankBtn = Framework.ButtonAdapter.GetFrom(rigthInfoGo, "rankBtn")
	self._nanduBtn = Framework.ButtonAdapter.GetFrom(rigthInfoGo, "nanduBtn")
	self._rewardScoreTxt.text = ""
	self._totalScoreTxt.text = ""
	self._timerTxt.text = ""
	self._moshiNameTxt.text = ""
	self._recordMaxTxt.text = ""
	self._petDescTxt.text = ""

	self._rewardGo:SetActive(false)
end

function SunranBattleView:onEnter()
	SunranBattleView.super.onEnter(self)
	SunranBattleConfig.instance:initStageCfgStarTime()

	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	self._choStageId = 1

	if openCfg == nil then
		self._isActivityEnd = true

		printError("sr---挑战 SunranBattleView:onEnter()   获取的开启时间为空")

		return
	end

	self._choStageId = nil
	self._moveViewIndex = nil

	local id = self:getFirstParam()

	if checknumber(id) > 0 then
		self._choStageId = id
	elseif checknumber(SunranBattleModel.instance.cacheStageId) > 0 then
		self._choStageId = SunranBattleModel.instance.cacheStageId
	end

	SunranBattleModel.instance.cacheStageId = nil

	GlobalDispatcher:addListener(GlobalNotify.MainBattleInfo, self._updataMoshiListSR, self)

	self._siTweenPos = UnityTweens.TweenPosition.Create(self._sprineImaGo, Vector3.New(1250, 0, 0), Vector3.New(-70, 0, 0), 0.3, UnityTweens.EaseType.easeInSine)
	self._siTweenPos.loopType = UnityTweens.LoopType.none
	self._siTweenFade = UnityTweens.UITweenFade.Create(self._sprineImaGo, 0, 1, 0.4, UnityTweens.EaseType.easeInQuad)
	self._siTweenFade.loopType = UnityTweens.LoopType.none
	self._isActivityEnd = false
	self._seasonId = openCfg.seasonId
	self._matIcon = openCfg.scoreIcon
	self._viewNameTxt.text = openCfg.titleName
	self._endTime = string.nilorempty(openCfg.endTime) and 0 or GameUtil.string2time(openCfg.endTime)

	self:_showActivityTimer()
	self:_updataMoshiListSR(true)
	uGuiUtil.setSpriteToImage(self._rewardScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._matIcon))
	uGuiUtil.setSpriteToImage(self._totalScoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._matIcon))
	uGuiUtil.setSpriteToImage(self._recordMaxImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._matIcon))
	SunranBattleController.instance:csGetDarkDragonInfoReq()

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_zhumianban.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SunranBattleView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timerTxt.text = "活动结束"
		self._isActivityEnd = true

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function SunranBattleView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function SunranBattleView:_updataMoshiListSR(isFirst)
	self._curViewDatas, self._allBestScore = SunranBattleModel.instance:getBattleStageList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---挑战 SunranBattleView:_updataMoshiListSR()   获取挑战关卡配置控！！")

		return
	end

	print("sr---挑战   选择哪个 self._choStageId  = ", self._choStageId)

	if checknumber(self._choStageId) <= 0 then
		self._choStageId = 1

		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i] and self._curViewDatas[i].isOpen and i > self._choStageId then
				self._choStageId = i
			end
		end
	end

	print("sr---挑战   选择哪个 self._choStageId  = ", self._choStageId, #self._curViewDatas)
	self:_showChoiseStageInfo()

	local scoreCfg = SunranBattleModel.instance:getNextScorePrizeCfg(self._seasonId, self._allBestScore)

	if scoreCfg == nil then
		self._rewardScoreTxt.text = ""

		self._rewardGo:SetActive(false)
	else
		self._rewardGo:SetActive(true)

		self._rewardScoreTxt.text = scoreCfg.score
	end

	self._totalScoreTxt.text = tostring(self._allBestScore)

	if isFirst then
		return
	end

	SunranBattleModel.instance:isOpenBattleResultView()

	local cacheBuff = SunranBattleModel.instance:getCacheStageBuffInfo()

	if cacheBuff and checknumber(cacheBuff.stageId) > 0 then
		if not self._isActivityEnd and self._curViewDatas[self._choStageId] then
			UIStateManager.instance:push(ViewName.SunranBuff, self._curViewDatas[self._choStageId])
		else
			SunranBattleModel.instance:setCacheStageBuffInfo(nil)
		end
	end
end

function SunranBattleView:_showChoiseStageInfo(index)
	if self._choStageId == checknumber(index) then
		return
	end

	print("sr---挑战   SunranBattleView:_showChoiseStageInfo()    选择关卡 = ", self._choStageId, index, #self._curViewDatas)

	self._choStageId = index or self._choStageId

	local info

	if self._curViewDatas and self._curViewDatas[self._choStageId] then
		info = self._curViewDatas[self._choStageId]
	end

	if info == nil then
		printError("sr---挑战 SunranBattleView:_showChoiseStageInfo()   选择的关卡 = " .. index)

		return
	end

	local path = string.format("ui/bigbg/sunranbattle/%s.png", info.mainElves)

	uGuiUtil.setSpriteToImage(self._sprineImaGo, uGuiUtil.SpriteType.BigBg, path)
	self._siTweenPos:Begin()
	self._siTweenFade:Begin()
	self._tableview:ReloadData()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0

			if self._choStageId > 4 and count >= self._choStageId then
				if self._tableview.isReady then
					self._moveViewIndex = nil

					self._tableview:MoveCellInView(self._choStageId - 1, false)
				else
					self._moveViewIndex = self._choStageId
				end
			end

			self._moshiNameTxt.text = string.format("%s：%s", info.stageName, info.stageDes)
			self._recordMaxTxt.text = tostring(info.bestScore)
			self._petDescTxt.text = info.addDes

			for i = 1, #self._petItemList do
				if self._petItemList[i] then
					MaterialMgr.resetAll(self._petItemList[i])
				end
			end

			if info.raceIds == nil or #info.raceIds == 0 then
				return
			end

			for i = 1, #info.raceIds do
				if info.raceIds[i] and self._petItemList[i] then
					local petLua = MaterialMgr.setCell(MatType.Pet, info.raceIds[i], self._petItemList[i])
				end
			end
		end
	end
end

function SunranBattleView:_onReloadFinish(view)
	if self._moveViewIndex then
		self._tableview:MoveCellInView(self._moveViewIndex - 1, false)

		self._onReloadFinish = nil
	end
end

function SunranBattleView:_getPath()
	return {
		cellPath = "leftInfoGo/moshiItem",
		viewPath = "leftInfoGo/moshiListSR"
	}
end

function SunranBattleView:_cellSize()
	return 250, 115
end

function SunranBattleView:_updateCell(view, cell, data)
	local itemGrp = cell:GetComponent("UIChangeGroup")
	local arrowGo = goutil.findChild(cell, "arrowGo")
	local bgIma = goutil.findChild(cell, "bgIma"):GetComponent("UIImageSpriteChange")
	local scoreImaGo = goutil.findChild(cell, "bgIma/scoreIma")
	local scoreTxt = goutil.findChildTextComponent(cell, "bgIma/scoreTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "bgIma/levelTxt")
	local lockGo = goutil.findChild(cell, "bgIma/lockGo")

	MaterialMgr.clearIcon(scoreImaGo)

	if cell.data == self._choStageId then
		itemGrp:SetState(1)
		arrowGo:SetActive(true)
		bgIma:SetState(1)
		Framework.TransformUtil.SetLocalPos(bgIma.gameObject.transform, 10, 0, 0)
		Framework.TransformUtil.SetLocalScale(bgIma.gameObject.transform, 1.05, 1.05, 1.05)
	else
		itemGrp:SetState(0)
		arrowGo:SetActive(false)
		bgIma:SetState(0)
		Framework.TransformUtil.SetLocalPos(bgIma.gameObject.transform, -2, 0, 0)
		Framework.TransformUtil.SetLocalScale(bgIma.gameObject.transform, 1, 1, 1)
	end

	scoreTxt.text = tostring(data.bestScore)
	levelTxt.text = data.stageName

	lockGo:SetActive(not data.isOpen)
	uGuiUtil.setSpriteToImage(scoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._matIcon))
	GameUtil.asBtn(cell):AddClickListener(function()
		if not data.isOpen then
			FloatWordMgr.instance:show(data.unlockTips)

			return
		end

		self:_showChoiseStageInfo(cell.data)
	end, self)
end

return SunranBattleView
