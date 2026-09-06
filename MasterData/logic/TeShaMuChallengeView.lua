-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/TeShaMuChallengeView.lua

module("logic.extensions.teshamu.view.TeShaMuChallengeView", package.seeall)

local TeShaMuChallengeView = class("TeShaMuChallengeView", ViewComponent)

function TeShaMuChallengeView:ctor()
	TeShaMuChallengeView.super.ctor(self)
end

function TeShaMuChallengeView:unbindEvents()
	TeShaMuChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnActive)
end

function TeShaMuChallengeView:bindEvents()
	TeShaMuChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnActive, self._onClickActive, self)

	for stageId, stage in ipairs(self._stages) do
		GameUtil.addClickHandler(stage.btn, GameUtil.handler(self._onClickStage, self, stageId))
	end

	for blockId, block in ipairs(self._blocks) do
		GameUtil.addClickHandler(block.btn, GameUtil.handler(self._onClickBlock, self, blockId))
	end
end

function TeShaMuChallengeView:buildUI()
	TeShaMuChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._btnActive = self:getBtn("btnActive")
	self._txtActve = self:getTxt("btnActive/txt")
	self._bg = self:getGo("bg")
	self._stages = {}

	for i = 1, 3 do
		local stageCell = {}

		stageCell.btn = self:getBtn("stage/btnStage_" .. i)
		stageCell.lock = self:getGo("stage/btnStage_" .. i .. "/lock")
		stageCell.select = self:getGo("stage/btnStage_" .. i .. "/select")
		stageCell.pass = self:getGo("stage/btnStage_" .. i .. "/pass")

		table.insert(self._stages, stageCell)
	end

	self._blocks = {}
	self._blockCount = 6

	for i = 1, self._blockCount do
		local block = {}

		block.btn = self:getBtn("map/block_" .. i)
		block.level = self:getGo("map/block_" .. i .. "/level")
		block.levelChange = block.level:GetComponent(ComponentType.UIImageSpriteChange)
		block.lock = self:getGo("map/block_" .. i .. "/lock")
		block.petOccupied = self:getGo("map/block_" .. i .. "/petOccupied")
		block.petGroup = self:getGo("map/block_" .. i .. "/petOccupied/petGroup")

		GameUtil.SetActive(block.petOccupied, false)
		table.insert(self._blocks, block)
	end

	self._petCell = self:getGo("map/petCell")
	self._icon = self:getGo("score/icon")
	self._txtCount = self:getTxt("score/txtCount")
end

function TeShaMuChallengeView:onExit()
	TeShaMuChallengeView.super.onExit(self)

	for _, petCell in ipairs(self._petCells) do
		for _, go in ipairs(petCell) do
			local icon = goutil.findChild(go, "icon")

			MaterialMgr.clearIcon(icon)
			goutil.destroy(go, true)
		end
	end

	uGuiUtil.clearImage(self._bg)
	MaterialMgr.clearIcon(self._icon)
end

function TeShaMuChallengeView:onEnter()
	TeShaMuChallengeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	TeShaMuChallengeModel.instance:setActId(self._activityId)
	self.addGEvent(self, GlobalNotify.TeshamuGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.TeshamuResetRes, self._sendGetInfoReq, self)

	self._stageCfg = TeShaMuChallengeConfig.instance:getStageCfg(self._activityId)
	self._curSelectStageId = 1
	self._mapPlanId = TeShaMuChallengeModel.instance:getMapPlanId()
	self._isActive = false
	self._petCells = {}

	self:_sendGetInfoReq()
	self:_showGold()
end

function TeShaMuChallengeView:_showGold()
	local challengeCfg = TeShaMuChallengeConfig.instance:getChallengeCfg(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(challengeCfg.coin)

	MaterialMgr.setIcon(self._icon, matType, matId)

	self._txtCount.text = "x" .. MaterialMgr.getMatCount(challengeCfg.coin)
end

function TeShaMuChallengeView:_sendGetInfoReq()
	TeShaMuChallengeController.instance:sendPM_TeshamuGetInfoReq(self._activityId)
end

function TeShaMuChallengeView:_refresh()
	self._curSelectStageId = TeShaMuChallengeController.instance:getStageId()

	self:_updateData()
	self:_refreshLevels()
	self:_refreshBlock()
end

function TeShaMuChallengeView:_updateData()
	TeShaMuChallengeModel.instance:setStageId(self._curSelectStageId)
	TeShaMuChallengeController.instance:setStageInfo(self._curSelectStageId)
	TeShaMuChallengeModel.instance:setMapPlanId(self._stageCfg[self._curSelectStageId].mapPlanId)
end

function TeShaMuChallengeView:_refreshLevels()
	for stageId, stage in ipairs(self._stages) do
		local isUnLock = TeShaMuChallengeController.instance:stageIsUnLock(stageId)
		local isPass = TeShaMuChallengeController.instance:isStagePass(stageId)

		GameUtil.SetActive(stage.select, stageId == self._curSelectStageId)
		GameUtil.SetActive(stage.lock, not isUnLock)
		GameUtil.SetActive(stage.pass, isPass)
	end
end

function TeShaMuChallengeView:_refreshBlock()
	local cfg = TeShaMuChallengeConfig.instance:getStageCfgById(self._activityId, self._curSelectStageId)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("teshamu", cfg.bgName))

	self._mapPlanId = TeShaMuChallengeModel.instance:getMapPlanId()

	local mapCfg = TeShaMuChallengeConfig.instance:getMapPlanCfg(self._mapPlanId)

	for blockId, block in ipairs(self._blocks) do
		self:_refreshBanPetInfo(blockId)

		local isUnLock = TeShaMuChallengeController.instance:blockIsNeighbours(blockId)
		local blockCfg = TeShaMuChallengeConfig.instance:getMapPlanCfgById(self._mapPlanId, blockId)

		block.levelChange:SetState(blockCfg.level - 1)
		GameUtil.SetActive(block.lock, not isUnLock)
	end
end

function TeShaMuChallengeView:_refreshBanPetInfo(blockId)
	local info = TeShaMuChallengeController.instance:banPetInfo(blockId)

	if not self._petCells[blockId] then
		local blockPetCell = {}
		local count = #blockPetCell

		if count > info.banPetCount then
			for index = info.banPetCount + 1, count do
				GameUtil.SetActive(blockPetCell[index], false)
			end
		end

		local petGos = {}

		for i = 1, info.banPetCount do
			local petGo = blockPetCell[i] or goutil.cloneAndSetParent(self._petCell, self._blocks[blockId].petGroup.transform, "banPet_" .. i)

			petGos[i] = petGo

			GameUtil.SetActive(petGo, true)

			local icon = goutil.findChild(petGo, "icon")

			MaterialMgr.clearIcon(icon)

			local banPetId = checknumber(info.banPetIds[i])

			if banPetId > 0 then
				local petMo = BagPetsController.instance:getPet(banPetId)

				if petMo then
					local raceId = BagPetsController.instance:getPet(banPetId).raceId

					MaterialMgr.setIcon(icon, MatType.Pet, (checknumber(petMo.curFaceId) > 0 or nil) and petMo.curFaceId)
				end
			end
		end

		self._petCells[blockId] = petGos

		self:_mapLevelActive(blockId, #info.banPetIds <= 0)
	end
end

function TeShaMuChallengeView:_mapLevelActive(blockId, active)
	GameUtil.SetActive(self._blocks[blockId].petOccupied, not active)
	GameUtil.SetActive(self._blocks[blockId].level, active)
end

function TeShaMuChallengeView:_onClickTip()
	TipsFacade.instance:openRulesView("teshumuchallenge_rule")
end

function TeShaMuChallengeView:_onClickReset()
	local isCanReset = TeShaMuChallengeController.instance:isCanReset(self._curSelectStageId)

	if not isCanReset then
		return
	end

	local tips = lang("teshamuchallenge_reset_tip")

	local function sureChange()
		TeShaMuChallengeController.instance:sendPM_TeshamuResetReq(self._activityId, self._curSelectStageId)
	end

	TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function TeShaMuChallengeView:_onClickActive()
	self._isActive = not self._isActive

	if self._isActive then
		for i = 1, self._blockCount do
			self:_mapLevelActive(i, true)
		end
	else
		for i = 1, self._blockCount do
			local info = TeShaMuChallengeController.instance:banPetInfo(i)

			self:_mapLevelActive(i, table.nums(info.banPetIds) <= 0)
		end
	end
end

function TeShaMuChallengeView:_onClickStage(stageId)
	local stageCfg = TeShaMuChallengeConfig.instance:getStageCfgById(self._activityId, stageId)
	local openDays = stageCfg.openDays + 1
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.TeshamuChallenge, self._activityId)
	local openTime = GameUtil.getTimestampOnStartAndEnd(startTime, openDays, 0)
	local leftTime = openTime - ServerTime.now()

	if leftTime >= 0 then
		FloatWordMgr.instance:show(string.format("当前关卡未开启，请%s天后再进行挑战", math.ceil(leftTime / 86400)))

		return
	end

	GameUtil.SetActive(self._stages[self._curSelectStageId].select, false)

	self._curSelectStageId = stageId

	GameUtil.SetActive(self._stages[self._curSelectStageId].select, true)
	self:_updateData()
	self:_refreshBlock()
end

function TeShaMuChallengeView:_onClickBlock(blockId)
	local isPass = TeShaMuChallengeController.instance:isStagePass(self._curSelectStageId)
	local isUnLock = TeShaMuChallengeController.instance:blockIsNeighbours(blockId)

	if isPass then
		FloatWordMgr.instance:show("已通关,请选择其他关卡挑战~")

		return
	end

	if not isUnLock then
		FloatWordMgr.instance:show("必须选择相邻地块进行挑战哦~")

		return
	end

	local isUnLock = TeShaMuChallengeController.instance:stageIsUnLock(self._curSelectStageId)

	if not isUnLock then
		FloatWordMgr.instance:show("此关未解锁,请选择其他关卡挑战~")

		return
	end

	TeShaMuChallengeController.instance:openChallengeForm(self._activityId, self._curSelectStageId, blockId)
end

function TeShaMuChallengeView:_onClickClose()
	TeShaMuChallengeModel.instance:setStageId(nil)
	self:close()
end

return TeShaMuChallengeView
