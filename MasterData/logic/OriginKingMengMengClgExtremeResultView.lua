-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeResultView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeResultView", package.seeall)

local OriginKingMengMengClgExtremeResultView = class("OriginKingMengMengClgExtremeResultView", ViewComponent)

function OriginKingMengMengClgExtremeResultView:buildUI()
	OriginKingMengMengClgExtremeResultView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtPet = self:getTxt("petBar/txt")
	self._txtBuff = self:getTxt("buffBar/txt")
	self._txtScore = self:getTxt("scoreBar/txt")
	self._tagEmpty = self:getGo("petCol/tagEmpty")
	self._btnSure = self:getGo("btnSure")

	local scrView = self:getGo("petCol/scrView")
	local scrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginKingMengMengClgExtremeResultView:bindEvents()
	OriginKingMengMengClgExtremeResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginKingMengMengClgExtremeResultView:unbindEvents()
	OriginKingMengMengClgExtremeResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginKingMengMengClgExtremeResultView:onEnter()
	OriginKingMengMengClgExtremeResultView.super.onEnter(self)

	local params = self:getOpenParam()
	local msg = params[1]
	local fmtMo = params[2]

	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._isWin = checkbool(msg.isWin)
	self._stageValue = msg.value
	self._fmtMo = fmtMo

	if not self._fmtMo then
		printError("OriginKingMengMengClgExtremeResultView 缺少 fmtMo")
		self:close()

		return
	end

	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._stageData = OriginKingMengMengClgConfig.instance:getStageData(self._activityId, self._stageId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgConfirmRes, self._handlePM_OriginKingMengMengClgConfirmRes, self)
	self:_onUpdate()
end

function OriginKingMengMengClgExtremeResultView:onExit()
	OriginKingMengMengClgExtremeResultView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginKingMengMengClgExtremeResultView:_handlePM_OriginKingMengMengClgConfirmRes(status, msg)
	self:close()
	BattleController.instance:endBattle()
end

function OriginKingMengMengClgExtremeResultView:_onUpdate()
	self._txtTitle.text = self._isWin and "挑战成功" or "挑战失败"
	self._txtPet.text = string.format("推荐精灵：%s", self._stageData.name)
	self._txtBuff.text = string.format("共鸣行为：%s", self._stageData.targetDesc)
	self._txtScore.text = string.format("本关获得共鸣度：<color=#81FF81FF>%s</color>", self._stageValue)

	local petMoList = self:_getFormationPetMoList()

	self._petScrollerList:reloadData(petMoList)
	GameUtil.SetActive(self._tagEmpty, #petMoList <= 0)
end

function OriginKingMengMengClgExtremeResultView:_getFormationPetMoList()
	local petMoList = {}
	local formationMo = self._fmtMo:getCurFormation()

	for _, petId in ipairs(formationMo:GetPositions()) do
		petId = checknumber(petId)

		if petId > 0 then
			table.insert(petMoList, self._fmtMo:getPetMoById(petId))
		end
	end

	return petMoList
end

function OriginKingMengMengClgExtremeResultView:_updatePetCell(view, cell, petMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local skinId = petMo.curFaceId

	if skinId <= 0 then
		skinId = petMo:getDefineId()
	end

	local proxy = MaterialMgr.setCell(MatType.Pet, skinId, item)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo, true)
		end)
	end
end

function OriginKingMengMengClgExtremeResultView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginKingMengMengClgExtremeResultView:_onClickBtnSure()
	OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgConfirmReq(self._activityId, self._stageId, self._isWin)
end

return OriginKingMengMengClgExtremeResultView
