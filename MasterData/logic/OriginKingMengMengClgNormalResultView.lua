-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgNormalResultView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgNormalResultView", package.seeall)

local OriginKingMengMengClgNormalResultView = class("OriginKingMengMengClgNormalResultView", ViewComponent)

function OriginKingMengMengClgNormalResultView:buildUI()
	OriginKingMengMengClgNormalResultView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtPet = self:getTxt("petBar/txt")
	self._tagReach = self:getGo("petBar/tagReach")
	self._tagEmpty = self:getGo("petCol/tagEmpty")
	self._btnSure = self:getGo("btnSure")

	local scrView = self:getGo("petCol/scrView")
	local scrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginKingMengMengClgNormalResultView:bindEvents()
	OriginKingMengMengClgNormalResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginKingMengMengClgNormalResultView:unbindEvents()
	OriginKingMengMengClgNormalResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginKingMengMengClgNormalResultView:onEnter()
	OriginKingMengMengClgNormalResultView.super.onEnter(self)

	local params = self:getOpenParam()
	local msg = params[1]
	local fmtMo = params[2]

	self._activityId = msg.activityId
	self._stageId = msg.stageId or -1
	self._isWin = checkbool(msg.isWin)
	self._fmtMo = fmtMo

	if not self._fmtMo then
		printError("OriginKingMengMengClgNormalResultView 缺少 fmtMo")
		self:close()

		return
	end

	self:_onUpdate()
end

function OriginKingMengMengClgNormalResultView:onExit()
	OriginKingMengMengClgNormalResultView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginKingMengMengClgNormalResultView:_onUpdate()
	self._txtTitle.text = self._isWin and "挑战成功" or "挑战失败"
	self._txtPet.text = self._stageId == -1 and "击败所有敌人且保证援助精灵存活" or "击败所有敌人"

	GameUtil.setUIImageSpriteIdx(self._tagReach, self._isWin and 0 or 1)

	local petMoList = self:_getFormationPetMoList()

	self._petScrollerList:reloadData(petMoList)
	GameUtil.SetActive(self._tagEmpty, #petMoList <= 0)
end

function OriginKingMengMengClgNormalResultView:_getFormationPetMoList()
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

function OriginKingMengMengClgNormalResultView:_updatePetCell(view, cell, petMo, tag)
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

function OriginKingMengMengClgNormalResultView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginKingMengMengClgNormalResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginKingMengMengClgNormalResultView
