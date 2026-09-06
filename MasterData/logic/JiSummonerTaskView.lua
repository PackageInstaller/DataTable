-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerTaskView.lua

module("logic.extensions.jisummoner.view.JiSummonerTaskView", package.seeall)

local JiSummonerTaskView = class("JiSummonerTaskView", TableViewComponent)

function JiSummonerTaskView:ctor()
	JiSummonerTaskView.super.ctor(self)

	self._curViewDatas = nil
	self._isOpenPlot = nil
end

function JiSummonerTaskView:bindEvents()
	JiSummonerTaskView.super.bindEvents(self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(JiSummonerController.instance.jiPetRaceId)
	end, self)
	self._infoBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(JiSummonerController.instance.jiPetRaceId)
	end, self)
	self._dayBtn:AddClickListener(function()
		self:_onClickTitleBtn(false)
	end, self)
	self._storyBtn:AddClickListener(function()
		self:_onClickTitleBtn(true)
	end, self)
end

function JiSummonerTaskView:unbindEvents()
	JiSummonerTaskView.super.unbindEvents(self)
	self._skillBtn:RemoveClickListener()
	self._infoBtn:RemoveClickListener()
	self._dayBtn:RemoveClickListener()
	self._storyBtn:RemoveClickListener()
end

function JiSummonerTaskView:onExit()
	JiSummonerTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataJiSummonerInfo, self._updataViewScrollRect, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
end

function JiSummonerTaskView:destroyUI()
	JiSummonerTaskView.super.destroyUI(self)
	MaterialMgr.resetAll(self._rareGo)

	self._curViewDatas = nil
end

function JiSummonerTaskView:buildUI()
	JiSummonerTaskView.super.buildUI(self)

	local petInfoGo = self:getGo("petInfoGo")

	self._sprineGo = goutil.findChild(petInfoGo, "sprineGo")
	self._rareGo = goutil.findChild(petInfoGo, "rareGo")
	self._nameTxt = goutil.findChildTextComponent(petInfoGo, "nameTxt")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(petInfoGo, "skillBtn")
	self._infoBtn = Framework.ButtonAdapter.GetFrom(petInfoGo, "infoBtn")
	self._dayBtn = self:getBtn("dayBtn")
	self._dayBtnIma = self._dayBtn.gameObject:GetComponent("UIChangeGroup")
	self._dayRedGo = goutil.findChild(self._dayBtn.gameObject, "dayRedGo")
	self._storyBtn = self:getBtn("storyBtn")
	self._storyBtnIma = self._storyBtn.gameObject:GetComponent("UIChangeGroup")
	self._storyRedGo = goutil.findChild(self._storyBtn.gameObject, "storyRedGo")
	self._emptyGo = self:getGo("emptyGo")

	GameUtil.SetActive(self._emptyGo, false)
end

function JiSummonerTaskView:onEnter()
	JiSummonerTaskView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  JiSummonerTaskView:onEnter() y运营-极召唤师    未传入参数！！")

		return
	end

	self._isOpenPlot = false

	GlobalDispatcher:addListener(GlobalNotify.UpdataJiSummonerInfo, self._updataViewScrollRect, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	self:_initShowSprine()
	self:_updataViewScrollRect()
	JiSummonerController.instance:csRequestJiActivityInfoReq(self._paramCfg.plotPrizeActyId)
end

function JiSummonerTaskView:_initShowSprine()
	local proxy = MaterialMgr.setCell(MatType.Rare, JiSummonerController.instance.jiPetRaceId, self._rareGo)

	if proxy then
		local rare = CharacterConfig.instance:getInitRare(JiSummonerController.instance.jiPetRaceId)

		proxy.binder:setRare(rare)
	end

	self._nameTxt.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, JiSummonerController.instance.jiPetRaceId)

	local x, y, scale = 0, 0, 0.7

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, JiSummonerController.instance.jiPetRaceId, self._sprineGo, scale, nil, true, x, y)
end

function JiSummonerTaskView:_updataViewScrollRect()
	self:_onClickTitleBtn(self._isOpenPlot, true)
end

function JiSummonerTaskView:_onClickTitleBtn(isPlot, isForce)
	if isPlot == self._isOpenPlot and not isForce then
		return
	end

	self._jiSummonerInfo = JiSummonerController.instance:getJiSummonerInfo()
	self._isOpenPlot = isPlot

	if self._isOpenPlot then
		self._dayBtnIma:SetState(0)
		self._storyBtnIma:SetState(1)
	else
		self._dayBtnIma:SetState(1)
		self._storyBtnIma:SetState(0)
	end

	self._curViewDatas = {}

	GameUtil.SetActive(self._storyRedGo, false)
	GameUtil.SetActive(self._dayRedGo, RedPointModel.instance:isActive(239))

	self._curViewDatas = JiSummonerController.instance:getActiveOrPlotTask(self._paramCfg.activityId, self._isOpenPlot)

	self._tableview:ReloadData()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end
end

function JiSummonerTaskView:_onReloadFinish()
	if self._isOpenPlot and self._jiSummonerInfo.plotPro > 3 and self._jiSummonerInfo.plotPro <= #self._curViewDatas then
		self._tableview:MoveCellInView(self._jiSummonerInfo.plotPro, false)
	end

	if not self._isOpenPlot then
		self._tableview:MoveCellInView(0, false)
	end
end

function JiSummonerTaskView:_getPath()
	return {
		cellPath = "itemGo",
		viewPath = "itemListSR"
	}
end

function JiSummonerTaskView:_cellSize()
	return 670, 104
end

function JiSummonerTaskView:_updateCell(view, cell, data)
	local dayGo = goutil.findChild(cell, "dayGo")
	local titleTxt = goutil.findChildTextComponent(dayGo, "titleTxt")
	local descTxt = goutil.findChildTextComponent(dayGo, "descTxt")
	local goodsItems = {
		goutil.findChild(dayGo, "goodsGo_1"),
		goutil.findChild(dayGo, "goodsGo_1"),
		goutil.findChild(dayGo, "goodsGo_1")
	}
	local progressTxt = goutil.findChildTextComponent(dayGo, "progressTxt")
	local recieveBtnGo = goutil.findChild(dayGo, "recieveBtn")
	local recieveTxt = goutil.findChildTextComponent(recieveBtnGo, "recieveTxt")
	local recieveGo = goutil.findChild(dayGo, "recieveGo")
	local storyGo = goutil.findChild(cell, "storyGo")
	local chapterTxt = goutil.findChildTextComponent(storyGo, "chapterTxt")
	local goodsGo = goutil.findChild(storyGo, "goodsGo")
	local receiveGo = goutil.findChild(storyGo, "receiveGo")
	local choiseGo = goutil.findChild(storyGo, "choiseGo")
	local storyBtnGo = goutil.findChild(storyGo, "storyBtn")

	for _, go in pairs(goodsItems or {}) do
		if go then
			MaterialMgr.resetAll(go)
		end
	end

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(recieveBtnGo):RemoveClickListener()
	GameUtil.asBtn(storyBtnGo):RemoveClickListener()

	if self._isOpenPlot then
		GameUtil.SetActive(dayGo, false)
		GameUtil.SetActive(storyGo, true)

		chapterTxt.text = data.titleStr

		MaterialMgr.setCellByCfg(data.prize, goodsGo)
		GameUtil.SetActive(choiseGo, false)
		GameUtil.SetActive(receiveGo, true)

		if data.stage == 3 then
			GameUtil.SetActive(storyBtnGo, false)
			GameUtil.SetActive(choiseGo, false)
			GameUtil.SetActive(receiveGo, true)

			return
		end

		if data.stage == 1 then
			GameUtil.SetActive(receiveGo, false)
			GameUtil.SetActive(choiseGo, true)
			GameUtil.SetActive(storyBtnGo, true)
		elseif data.stage == 2 then
			GameUtil.SetActive(choiseGo, false)
			GameUtil.SetActive(receiveGo, false)
			GameUtil.SetActive(storyBtnGo, true)
		end

		GameUtil.asBtn(storyBtnGo):AddClickListener(function()
			if data.stage == 1 then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, data.plotId)

				return
			end

			FloatWordMgr.instance:show("请先完成前面剧情！")
		end, self)
	else
		GameUtil.SetActive(storyGo, false)
		GameUtil.SetActive(dayGo, true)

		titleTxt.text = data.titleStr
		descTxt.text = data.descStr

		for i = 1, #goodsItems do
			if data.prize and data.prize[i] then
				MaterialMgr.setCellByCfg(data.prize[i], goodsItems[i])
			end
		end

		if data.stage == 3 then
			progressTxt.text = ""

			GameUtil.SetActive(recieveBtnGo, false)
			GameUtil.SetActive(recieveGo, true)

			return
		end

		local isFull = data.stage == 1

		if isFull then
			progressTxt.text = data.progress .. "/" .. data.progress or self._jiSummonerInfo.activePro .. "/" .. data.progress
		end

		GameUtil.SetActive(recieveGo, false)
		GameUtil.SetActive(recieveBtnGo, true)

		recieveTxt.text = isFull and "领取" or "前往"

		GameUtil.asBtn(recieveBtnGo):AddClickListener(function()
			if isFull then
				JiSummonerController.instance:csRequestGainJiActivityActivePrizeReq(data.id)
			else
				GotoMgr.gotoByString(data.jumpTo)
			end
		end, self)
	end
end

function JiSummonerTaskView:_onEndStory()
	JiSummonerController.instance:csRequestGainJiActivityPlotPrizeReq()
end

return JiSummonerTaskView
