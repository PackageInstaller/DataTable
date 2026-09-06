-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeEnterPopView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeEnterPopView", package.seeall)

local OriginKingMengMengClgExtremeEnterPopView = class("OriginKingMengMengClgExtremeEnterPopView", ViewComponent)

function OriginKingMengMengClgExtremeEnterPopView:buildUI()
	OriginKingMengMengClgExtremeEnterPopView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtPet = self:getTxt("petBar/txt")
	self._txtBuff = self:getTxt("buffBar/txt")
	self._txtScore = self:getTxt("scoreBar/txt")
	self._tagEmpty = self:getGo("petCol/tagEmpty")
	self._btnSure = self:getGo("btnSure")
	self._customInput = UICustomInput.Get(self.mainGO)

	local scrView = self:getGo("petCol/scrView")
	local scrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginKingMengMengClgExtremeEnterPopView:bindEvents()
	OriginKingMengMengClgExtremeEnterPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function OriginKingMengMengClgExtremeEnterPopView:unbindEvents()
	OriginKingMengMengClgExtremeEnterPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	self._customInput:RemoveListener()
end

function OriginKingMengMengClgExtremeEnterPopView:onEnter()
	OriginKingMengMengClgExtremeEnterPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._stageData = OriginKingMengMengClgConfig.instance:getStageData(self._activityId, self._stageId)
	self._creepsMasterData = OriginKingMengMengClgConfig.instance:getCreepsMasterData(self._stageData.extremeClgCreepsMasterId)

	self:_onUpdate()
end

function OriginKingMengMengClgExtremeEnterPopView:onExit()
	OriginKingMengMengClgExtremeEnterPopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginKingMengMengClgExtremeEnterPopView:_onUpdate()
	self._txtTitle.text = self._creepsMasterData.name
	self._txtPet.text = string.format("推荐精灵：%s", self._stageData.name)
	self._txtBuff.text = string.format("共鸣行为：%s", self._stageData.targetDesc)

	local curStageValue = self._subMo:getStageValue(self._stageId)

	self._txtScore.text = string.format("本关获得共鸣度：<color=#81FF81FF>%s</color>", curStageValue)

	local raceIdList = OriginKingMengMengClgController.instance:getStageRecommendRaceIdList(self._activityId, self._stageId)

	self._petScrollerList:reloadData(raceIdList)
	GameUtil.SetActive(self._tagEmpty, #raceIdList <= 0)
end

function OriginKingMengMengClgExtremeEnterPopView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, item)

	if proxy then
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, 0)

		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(tmpMo, true)
		end)
	end
end

function OriginKingMengMengClgExtremeEnterPopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginKingMengMengClgExtremeEnterPopView:_onClickBtnSure()
	self:close()
	OriginKingMengMengClgController.instance:enterBattleExtreme(self._activityId, self._stageId)
end

return OriginKingMengMengClgExtremeEnterPopView
