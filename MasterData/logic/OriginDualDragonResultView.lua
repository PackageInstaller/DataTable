-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonResultView.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonResultView", package.seeall)

local OriginDualDragonResultView = class("OriginDualDragonResultView", ViewComponent)
local STAGE_TYPE_KINDNESS = 1

function OriginDualDragonResultView:buildUI()
	OriginDualDragonResultView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtRuleDesc = self:getTxt("txtRuleDesc")
	self._txtDetail = self:getTxt("detail/txt")
	self._txtPetTitle = self:getTxt("petCol/txt")
	self._txtTagEmpty = self:getTxt("petCol/tagEmpty")
	self._tagReach = self:getGo("detail/tagReach")
	self._tagEmpty = self:getGo("petCol/tagEmpty")
	self._btnSure = self:getGo("btnSure")
	self._btnReChallenge = self:getGo("btnReChallenge")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._txtBtnReChallenge = self:getTxt("btnReChallenge/txt")

	local scrView = self:getGo("petCol/scrView")
	local scrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginDualDragonResultView:bindEvents()
	OriginDualDragonResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnReChallenge, self._onClickBtnReChallenge, self)
end

function OriginDualDragonResultView:unbindEvents()
	OriginDualDragonResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnReChallenge)
end

function OriginDualDragonResultView:onEnter()
	OriginDualDragonResultView.super.onEnter(self)

	self._resultMsg = OriginDualDragonModel.instance:getTempChallengeResult() or {}

	self:_refreshView()
end

function OriginDualDragonResultView:onExit()
	OriginDualDragonResultView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginDualDragonResultView:_refreshView()
	local isWin = checkbool(OriginDualDragonModel.instance:getTempChallengeResult().isWin)
	local petDataList = OriginDualDragonModel.instance:buildResultPetDataList(OriginDualDragonModel.instance:getTempChallengeResult())
	local isKindnessStage = checknumber(self._resultMsg.stageType) == STAGE_TYPE_KINDNESS
	local targetCur, targetTotal = self:_getTargetProgress()

	self._txtTitle.text = isWin and lang("挑战成功") or lang("挑战失败")
	self._txtPetTitle.text = isKindnessStage and lang("上阵精灵") or lang("精灵封印")
	self._txtTagEmpty.text = isKindnessStage and lang("暂无上阵精灵") or lang("暂无被封印精灵")
	self._txtBtnSure.text = lang("保留结果")
	self._txtBtnReChallenge.text = lang("重新挑战")
	self._txtRuleDesc.text = self:_getRuleDesc(isKindnessStage)
	self._txtDetail.text = self:_getDetailText(targetCur, targetTotal)

	GameUtil.setUIImageSpriteIdx(self._tagReach, isWin and 0 or 1)
	self._petScrollerList:reloadData(petDataList)
	GameUtil.SetActive(self._tagEmpty, #petDataList <= 0)
end

function OriginDualDragonResultView:_getRuleDesc(isKindnessStage)
	if isKindnessStage then
		return lang("本关上阵的精灵将在下一关恶之试炼中上阵")
	end

	return lang("本关上阵精灵将被封印")
end

function OriginDualDragonResultView:_getDetailText(targetCur, targetTotal)
	targetTotal = targetTotal > 0 and targetTotal or 1

	return langPara("击败所有敌人（<color=#ff4d29>%s</color>/%s）", targetCur, targetTotal)
end

function OriginDualDragonResultView:_getTargetProgress()
	local totalNum = 0
	local curNum = 0

	for _, unit in pairs(BattleModel.instance:getEnemyUnits() or {}) do
		if not unit.attrs:isFakePet() then
			totalNum = totalNum + 1

			if unit.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	return curNum, totalNum
end

function OriginDualDragonResultView:_updatePetCell(view, cell, petData, tag)
	local raceId = checknumber(petData.raceId)
	local hpRate = Mathf.Clamp(checknumber(petData.hpRate), 0, 1)
	local isDie = checkbool(petData.isDie) or hpRate <= 0
	local isKindnessStage = checknumber(self._resultMsg.stageType) == STAGE_TYPE_KINDNESS
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local hpSliderGo = goutil.findChild(mainGo, "hpSlider")
	local tagDie = goutil.findChild(mainGo, "tagDie")
	local hpSlider = Framework.SliderAdapter.GetFrom(mainGo, "hpSlider")
	local fillChangeComp = goutil.findChildComponent(mainGo, "hpSlider/FillArea/Fill", ComponentType.UIImageColorChange)
	local txtHp = goutil.findChildTextComponent(mainGo, "hpSlider/FillArea/txtHp")

	MaterialMgr.resetAll(itemGo)

	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, itemGo)

	if proxy then
		proxy.binder:setClickCallBack(nil)
		proxy.binder:setGray(isKindnessStage and isDie)
	end

	GameUtil.SetActive(tagDie, isKindnessStage and isDie)
	GameUtil.SetActive(hpSliderGo, isKindnessStage and not isDie)

	if isKindnessStage and fillChangeComp then
		local level = Mathf.Clamp(math.floor(hpRate * 10) - 1, 0, 9)

		fillChangeComp:SetState(level)
	end

	if isKindnessStage and hpSlider then
		hpSlider:SetValue(hpRate)
	end

	if isKindnessStage and txtHp then
		txtHp.text = math.floor(hpRate * 100) .. "%"
	end
end

function OriginDualDragonResultView:_clearPetCell(cell)
	local itemGo = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginDualDragonResultView:_onClickBtnSure()
	self:close()
	OriginDualDragonController.instance:confirmChallengeResult()
end

function OriginDualDragonResultView:_onClickBtnReChallenge()
	self:close()
	OriginDualDragonController.instance:reChallenge()
end

return OriginDualDragonResultView
