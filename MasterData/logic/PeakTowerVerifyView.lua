-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerVerifyView.lua

module("logic.extensions.peaktower.view.PeakTowerVerifyView", package.seeall)

local PeakTowerVerifyView = class("PeakTowerVerifyView", ViewComponent)

function PeakTowerVerifyView:ctor()
	PeakTowerVerifyView.super.ctor(self)
end

function PeakTowerVerifyView:unbindEvents()
	PeakTowerVerifyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PeakTowerVerifyView:bindEvents()
	PeakTowerVerifyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	GameUtil.addClickHandler(self._btnVerify, self._onClickVerify, self)
end

function PeakTowerVerifyView:buildUI()
	PeakTowerVerifyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtPetName = self:getTxt("petName/txt")
	self._petCon = self:getGo("mask/con")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnPre = self:getGo("btnPre")
	self._btnNext = self:getGo("btnNext")
	self._btnVerify = self:getGo("btnVerify")
	self._petTableview = self:getGo("petTableview")
	self._petTablecell = self:getGo("petTableview/petTablecell")
	self._petTableList = ScrollerList.create(self._petTableview, self._petTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petTableList:setCenterMode(true)
end

function PeakTowerVerifyView:onExit()
	PeakTowerVerifyView.super.onExit(self)
end

function PeakTowerVerifyView:onEnter()
	PeakTowerVerifyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PeakTowerInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._verifyWeek = PeakTowerController.instance:getCurWeekId(self._activityId)

	local weekCfg = PeakTowerConfig.instance:getVerifyWeekCfg(self._activityId, self._verifyWeek)
	local planCfg = PeakTowerConfig.instance:getVerifyPlanCfg(weekCfg.verifyRacePlanId)

	self._raceList = {}
	self._zdlList = {}

	for raceId, v in pairs(planCfg) do
		table.insert(self._raceList, raceId)

		self._zdlList[raceId] = {}

		for zdl, cfg in pairs(v) do
			table.insert(self._zdlList[raceId], cfg)
		end

		table.sort(self._zdlList[raceId], function(a, b)
			return a.power < b.power
		end)
	end

	table.sort(self._raceList, function(a, b)
		return a < b
	end)

	self._curIndex = 1

	self:_refreshView()
end

function PeakTowerVerifyView:_refreshView()
	local showRaceId = self._raceList[self._curIndex]
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local petCo = CharacterConfig.instance:getPetCo(showRaceId)

	self._txtPetName.text = petCo.name

	local curZdl = checknumber(PeakTowerModel.instance:getVerifyZdl(self._activityId, showRaceId))

	if not self._zdlList[showRaceId] then
		self._activieZdl = 0

		for i, v in ipairs(self._zdlList[showRaceId]) do
			if curZdl >= v.power then
				self._activieZdl = v.power
			end
		end

		self._tableList:reloadData(self._zdlList[showRaceId])
		self._petTableList:reloadData(self._raceList)
	end
end

function PeakTowerVerifyView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtZdl = goutil.findChildTextComponent(go, "txtZdl")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local active = goutil.findChild(go, "active")

	GameUtil.SetActive(active, data.power == self._activieZdl)

	txtZdl.text = data.power
	txtDesc.text = data.desc
end

function PeakTowerVerifyView:_clearCell(cell)
	return
end

function PeakTowerVerifyView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local select = goutil.findChild(go, "select")
	local con = goutil.findChild(go, "petCon")
	local btn = con

	MaterialMgr.resetAll(con)
	MaterialMgr.setIcon(con, MatType.Pet, data)
	GameUtil.SetActive(select, data == self._raceList[self._curIndex])
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickPet(data)
	end)
end

function PeakTowerVerifyView:_clearPetCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "petCon")

	GameUtil.rmClickHandler(btn)
end

function PeakTowerVerifyView:_onClickPet(raceId)
	local selectIndex = self._curIndex

	for i, v in ipairs(self._raceList) do
		if raceId == v then
			selectIndex = i

			break
		end
	end

	if selectIndex ~= self._curIndex then
		self._curIndex = selectIndex

		self:_refreshView()
	end
end

function PeakTowerVerifyView:_onClickVerify()
	local bagPetId = BagModel.instance:getMaxZdlPetIdByRaceId(self._raceList[self._curIndex])

	if bagPetId and bagPetId > 0 then
		PeakTowerAgent.instance:sendPM_PeakTowerVerifyRaceReq(self._activityId, bagPetId)
	else
		FloatWordMgr.instance:show(langPara("未持有该精灵"))
	end
end

return PeakTowerVerifyView
