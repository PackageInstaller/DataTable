-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyPillarRankView.lua

module("logic.extensions.newfamily.view.war.FamilyPillarRankView", package.seeall)

local FamilyPillarRankView = class("FamilyPillarRankView", TableViewComponent)

function FamilyPillarRankView:ctor()
	FamilyPillarRankView.super.ctor(self)

	self._requestTimeInfo = nil
	self._curViewDatas = nil
	self._allPrzieCfgs = nil
end

function FamilyPillarRankView:bindEvents()
	FamilyPillarRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._familyBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.PillarRankType.Family)
	end, self)
	self._awardBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.PillarRankType.Award)
	end, self)
	self._personalBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.PillarRankType.Personal)
	end, self)
end

function FamilyPillarRankView:unbindEvents()
	FamilyPillarRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._familyBtn:RemoveClickListener()
	self._awardBtn:RemoveClickListener()
	self._personalBtn:RemoveClickListener()
end

function FamilyPillarRankView:onExit()
	FamilyPillarRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyPillarRankInfo, self._updataViewRankShow, self)

	self._requestTimeInfo = nil
	self._allPrzieCfgs = nil
end

function FamilyPillarRankView:destroyUI()
	FamilyPillarRankView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyPillarRankView:buildUI()
	FamilyPillarRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._familyBtn = self:getBtn("familyBtn")
	self._awardBtn = self:getBtn("awardBtn")
	self._personalBtn = self:getBtn("personalBtn")
	self._familyGrp = self._familyBtn.gameObject:GetComponent("UIChangeGroup")
	self._awardGrp = self._awardBtn.gameObject:GetComponent("UIChangeGroup")
	self._personalGrp = self._personalBtn.gameObject:GetComponent("UIChangeGroup")

	local titleGo = self:getGo("rightInfoGo/titleGo")

	self._lineGo1 = goutil.findChild(titleGo, "lineGo1")
	self._lineGo2 = goutil.findChild(titleGo, "lineGo2")
	self._nameTxtGo = goutil.findChild(titleGo, "nameTxt")
	self._powerTxt = goutil.findChildTextComponent(titleGo, "powerTxt")
	self._familyTxt = goutil.findChildTextComponent(titleGo, "familyTxt")
end

function FamilyPillarRankView:onEnter()
	FamilyPillarRankView.super.onEnter(self)

	self._curPlanId = math.max(checknumber(self:getFirstParam()), 1)

	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyPillarRankInfo, self._updataViewRankShow, self)

	self._requestTimeInfo = {}

	self:_onClickRankBtn(FamilyWarController.PillarRankType.Family)
end

function FamilyPillarRankView:_onClickRankBtn(srType)
	srType = srType or FamilyWarController.PillarRankType.Family

	local now = ServerTime.now()
	local isRequest = not (self._requestTimeInfo[srType] and now > self._requestTimeInfo[srType] + 60)

	if srType == FamilyWarController.PillarRankType.Family then
		if FamilyWarController.instance:csRequestFamilyBattleViewRankReq(srType, isRequest) then
			self._requestTimeInfo[srType] = now
		end

		return
	end

	if srType == FamilyWarController.PillarRankType.Personal then
		if FamilyWarController.instance:csRequestFamilyBattleViewUserRankReq(srType, isRequest) then
			self._requestTimeInfo[srType] = now
		end

		return
	end

	if self._allPrzieCfgs == nil or #self._allPrzieCfgs == 0 then
		self._allPrzieCfgs = {}

		local allCfgs = FamilyWarConfig.instance:getFamilyWarRankPrizeCfgs(self._curPlanId)

		for _, cfg in pairs(allCfgs or {}) do
			if cfg and cfg.prize_client and not string.nilorempty(cfg.prize_client) then
				table.insert(self._allPrzieCfgs, {
					rank = cfg.top,
					prizes = string.split(cfg.prize_client, "#"),
					score = cfg.seasonScore
				})
			end
		end

		if self._allPrzieCfgs and #self._allPrzieCfgs > 1 then
			table.sort(self._allPrzieCfgs, function(a, b)
				return a.rank < b.rank
			end)
		end
	end

	self:_updataViewRankShow(FamilyWarController.PillarRankType.Award, self._allPrzieCfgs)
end

function FamilyPillarRankView:_updataViewRankShow(srType, rankList)
	self._curRankType = srType
	self._curViewDatas = rankList

	if srType == FamilyWarController.PillarRankType.Award then
		self._familyGrp:SetState(0)
		self._awardGrp:SetState(1)
		self._personalGrp:SetState(0)
		GameUtil.SetActive(self._lineGo1, false)
		GameUtil.SetActive(self._lineGo2, false)
		GameUtil.SetActive(self._nameTxtGo, false)

		self._familyTxt.text = ""
		self._powerTxt.text = "排名奖励"

		Framework.TransformUtil.SetLocalPos(self._powerTxt.gameObject.transform, 0, 0, 0)
	elseif srType == FamilyWarController.PillarRankType.Personal then
		self._familyGrp:SetState(0)
		self._awardGrp:SetState(0)
		self._personalGrp:SetState(1)
		GameUtil.SetActive(self._lineGo1, true)
		GameUtil.SetActive(self._lineGo2, true)
		GameUtil.SetActive(self._nameTxtGo, true)

		self._familyTxt.text = "家族名"
		self._powerTxt.text = "获得能量"

		Framework.TransformUtil.SetLocalPos(self._familyTxt.gameObject.transform, -155, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._powerTxt.gameObject.transform, 325, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._lineGo1.transform, -45, 0, 0)

		if self._curViewDatas and #self._curViewDatas > 1 then
			table.sort(self._curViewDatas, function(a, b)
				return a.rank < b.rank
			end)
		end
	elseif srType == FamilyWarController.PillarRankType.Family then
		self._familyGrp:SetState(1)
		self._awardGrp:SetState(0)
		self._personalGrp:SetState(0)
		GameUtil.SetActive(self._lineGo1, true)
		GameUtil.SetActive(self._lineGo2, false)
		GameUtil.SetActive(self._nameTxtGo, false)

		self._familyTxt.text = "家族名"
		self._powerTxt.text = "能量"

		Framework.TransformUtil.SetLocalPos(self._familyTxt.gameObject.transform, -125, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._powerTxt.gameObject.transform, 236, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._lineGo1.transform, 35, 0, 0)

		if self._curViewDatas and #self._curViewDatas > 1 then
			table.sort(self._curViewDatas, function(a, b)
				return a.rank < b.rank
			end)
		end
	end

	self._tableview:ReloadData()
end

function FamilyPillarRankView:_getPath()
	return {
		cellPath = "rightInfoGo/rankCell",
		viewPath = "rightInfoGo/rankListSR"
	}
end

function FamilyPillarRankView:_cellSize()
	return 840, 108
end

function FamilyPillarRankView:_updateCell(view, cell, data)
	local rankImg = goutil.findChild(cell, "rankIma"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local lineImaGo1 = goutil.findChild(cell, "lineImaGo1")
	local lineImaGo2 = goutil.findChild(cell, "lineImaGo2")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4")
	}

	familyTxt.text = ""
	nameTxt.text = ""
	powerTxt.text = ""

	for i = 1, #goodsList do
		MaterialMgr.resetAll(goodsList[i])
	end

	if cell.data <= 3 then
		GameUtil.SetActive(rankImg, true)
		rankImg:SetState(cell.data - 1)

		rankTxt.text = ""
	else
		GameUtil.SetActive(rankImg, false)

		rankTxt.text = tostring(cell.data)
	end

	if self._curRankType == FamilyWarController.PillarRankType.Award then
		GameUtil.SetActive(lineImaGo1, false)
		GameUtil.SetActive(lineImaGo2, false)

		for i = 1, #data.prizes do
			if not string.nilorempty(data.prizes[i]) and goodsList[i] then
				MaterialMgr.setCellByCfg(data.prizes[i], goodsList[i])
			end
		end
	elseif self._curRankType == FamilyWarController.PillarRankType.Personal then
		GameUtil.SetActive(lineImaGo1, true)
		GameUtil.SetActive(lineImaGo2, true)

		familyTxt.text = data.familyName
		nameTxt.text = data.headInfo.userName
		powerTxt.text = tostring(data.energy)

		Framework.TransformUtil.SetAnchoredPos(familyTxt.gameObject.transform, -155, 0)
		Framework.TransformUtil.SetAnchoredPos(powerTxt.gameObject.transform, 325, 0)
		Framework.TransformUtil.SetAnchoredPos(lineImaGo1.transform, -45, 0)
	elseif self._curRankType == FamilyWarController.PillarRankType.Family then
		GameUtil.SetActive(lineImaGo1, true)
		GameUtil.SetActive(lineImaGo2, false)

		familyTxt.text = data.familyName
		powerTxt.text = tostring(data.totalEnergy)

		Framework.TransformUtil.SetAnchoredPos(familyTxt.gameObject.transform, -125, 0)
		Framework.TransformUtil.SetAnchoredPos(powerTxt.gameObject.transform, 236, 0)
		Framework.TransformUtil.SetAnchoredPos(lineImaGo1.transform, 35, 0)
	end
end

return FamilyPillarRankView
