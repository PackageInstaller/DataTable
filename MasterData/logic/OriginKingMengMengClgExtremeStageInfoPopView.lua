-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeStageInfoPopView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeStageInfoPopView", package.seeall)

local OriginKingMengMengClgExtremeStageInfoPopView = class("OriginKingMengMengClgExtremeStageInfoPopView", ViewComponent)

function OriginKingMengMengClgExtremeStageInfoPopView:buildUI()
	OriginKingMengMengClgExtremeStageInfoPopView.super.buildUI(self)

	self._txtTitle = self:getTxt("txtTitle")
	self._txtPet = self:getTxt("petBar/txt")
	self._txtBuff = self:getTxt("buffBar/txt")
	self._txtScore = self:getTxt("scoreBar/txt")
	self._tagEmpty = self:getGo("petCol/tagEmpty")
	self._btnReset = self:getGo("btnReset")
	self._customInput = UICustomInput.Get(self.mainGO)

	local scrView = self:getGo("petCol/scrView")
	local scrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
end

function OriginKingMengMengClgExtremeStageInfoPopView:bindEvents()
	OriginKingMengMengClgExtremeStageInfoPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
	self._customInput:AddListener(function(self, hover)
		if not hover then
			self:close()
		end
	end, self)
end

function OriginKingMengMengClgExtremeStageInfoPopView:unbindEvents()
	OriginKingMengMengClgExtremeStageInfoPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReset)
	self._customInput:RemoveListener()
end

function OriginKingMengMengClgExtremeStageInfoPopView:onEnter()
	OriginKingMengMengClgExtremeStageInfoPopView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._waitResetToBattle = false
	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._stageData = OriginKingMengMengClgConfig.instance:getStageData(self._activityId, self._stageId)
	self._creepsMasterData = OriginKingMengMengClgConfig.instance:getCreepsMasterData(self._stageData.extremeClgCreepsMasterId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgResetRes, self._onHandleResetRes, self)
	self:_onUpdate()
end

function OriginKingMengMengClgExtremeStageInfoPopView:onExit()
	OriginKingMengMengClgExtremeStageInfoPopView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginKingMengMengClgExtremeStageInfoPopView:_onUpdate()
	self._txtTitle.text = self._creepsMasterData.name
	self._txtPet.text = string.format("推荐精灵：%s", self._stageData.name)
	self._txtBuff.text = string.format("共鸣行为：%s", self._stageData.targetDesc)

	local curStageValue = self._subMo:getStageValue(self._stageId)

	self._txtScore.text = string.format("本关获得共鸣度：<color=#81FF81FF>%s</color>", curStageValue)

	local raceIdList = self:_getStageLockedRaceIdList()

	self._petScrollerList:reloadData(raceIdList)
	GameUtil.SetActive(self._tagEmpty, #raceIdList <= 0)
end

function OriginKingMengMengClgExtremeStageInfoPopView:_getStageLockedRaceIdList()
	local raceIdList = {}
	local raceIdMap = self._subMo:getStageLockRaceIdMap(self._stageId)

	for raceId, isLocked in pairs(raceIdMap) do
		if isLocked then
			table.insert(raceIdList, checknumber(raceId))
		end
	end

	table.sort(raceIdList)

	return raceIdList
end

function OriginKingMengMengClgExtremeStageInfoPopView:_updatePetCell(view, cell, raceId, tag)
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

function OriginKingMengMengClgExtremeStageInfoPopView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function OriginKingMengMengClgExtremeStageInfoPopView:_onClickBtnReset()
	if self._waitResetToBattle or not self._subMo:isExtremeStagePassed(self._stageId) then
		return
	end

	local tipsContent = "是否确认重置本关关卡？"

	local function okFunc()
		self._waitResetToBattle = true

		OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgResetReq(self._activityId, self._stageId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginKingMengMengClgExtremeStageInfoPopView:_onHandleResetRes(msg)
	if not self._waitResetToBattle or msg.activityId ~= self._activityId then
		return
	end

	local stageInfo = msg.stageInfo

	if stageInfo.stageId ~= self._stageId then
		return
	end

	self._waitResetToBattle = false

	self:close()
	OriginKingMengMengClgController.instance:enterBattleExtreme(self._activityId, self._stageId)
end

return OriginKingMengMengClgExtremeStageInfoPopView
