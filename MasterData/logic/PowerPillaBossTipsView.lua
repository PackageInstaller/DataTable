-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBossTipsView.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBossTipsView", package.seeall)

local PowerPillaBossTipsView = class("PowerPillaBossTipsView", ViewComponent)

function PowerPillaBossTipsView:buildUI()
	PowerPillaBossTipsView.super.buildUI(self)

	local descScrollerview = goutil.findChild(self.mainGO, "descCol/descScrollerview")
	local descScrollercell = goutil.findChild(self.mainGO, "descCol/descScrollercell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "descCol/itemScrollercell")
	self._descScrollList = ScrollerList.create(descScrollerview, descScrollercell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
	self._customInput = UICustomInput.Get(self.mainGO)
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)
end

function PowerPillaBossTipsView:bindEvents()
	PowerPillaBossTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PowerPillaBossTipsView:unbindEvents()
	PowerPillaBossTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function PowerPillaBossTipsView:onEnter()
	PowerPillaBossTipsView.super.onEnter(self)

	self._activityId = PowerPillaModel.instance:getActivityId()

	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.MPPGetActInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.MPPGetGameInfoRes, self._onGetGameInfoRes, self)
end

function PowerPillaBossTipsView:onExit()
	PowerPillaBossTipsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetActInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetGameInfoRes, self._onGetGameInfoRes, self)
	self:_onClearDescCol()
end

function PowerPillaBossTipsView:_onSetUI()
	return
end

function PowerPillaBossTipsView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PowerPillaBossTipsView:_onUpdateData()
	return
end

function PowerPillaBossTipsView:_onUpdateUI()
	self:_onUpdateDescColUI()
end

function PowerPillaBossTipsView:_onUpdateDescColUI()
	local cfg = PowerPillaConfig.instance:getStageListOfMain(self._activityId)

	self._descScrollList:reloadData(cfg)
end

function PowerPillaBossTipsView:_onGetGameInfoRes()
	return
end

function PowerPillaBossTipsView:_onClearDescCol()
	self._descScrollList:dispose()
end

function PowerPillaBossTipsView:_updateDescCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local headcell = goutil.findChild(mainGo, "headcell")
	local icon = goutil.findChild(mainGo, "headcell/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtMaxDmg = goutil.findChildTextComponent(mainGo, "txtMaxDmg")
	local txtSumDmg = goutil.findChildTextComponent(mainGo, "txtSumDmg")
	local txtComp = goutil.findChildTextComponent(mainGo, "txtComp")
	local btnJump = goutil.findChild(mainGo, "btnJump")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local stage = data.stage
	local bossEventId = data.bossEventId
	local bossData, monsterData

	if bossEventId > 0 then
		bossData = PowerPillaConfig.instance:getBossData(bossEventId)
		monsterData = PowerPillaConfig.instance:getMonsterCfg(bossData.creepsMasterId)
	end

	if bossData then
		if string.nilorempty(bossData.headPath) then
			local creepsData = PowerPillaConfig.instance:getCreepsCfg(bossData.creepsMasterId, 1)

			if creepsData then
				local skinId = checknumber(creepsData.faceId)

				if skinId <= 0 then
					skinId = creepsData.raceId
				end

				MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
			end
		else
			GameUtil.getUIImageSpriteChange(icon):ChangeSprite(bossData.headPath)
		end
	end

	if data and itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prizePreView or "", "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end

	if bossData then
		txtName.text = bossData.bossName or ""
	end

	txtZdl.text = 0

	local curDamage = PowerPillaModel.instance:getMaxBossDamageOfStage(stage)
	local maxDamage = checknumber(data.maxDamage)

	txtMaxDmg.text = curDamage < maxDamage and string.format("%s/<color=#20b376>%s</color>", curDamage, maxDamage) or string.format("<color=#20b376>%s</color>/<color=#20b376>%s</color>", curDamage, maxDamage)
	txtSumDmg.text = PowerPillaModel.instance:getTotalBossDamageOfStage(stage)

	local finishEventNum = PowerPillaController.instance:getCurEventNumOfMainAndBranch(self._activityId, stage)
	local totalEventNum = PowerPillaController.instance:getTotalEventNum(self._activityId, stage)

	txtComp.text = finishEventNum < totalEventNum and string.format("%s/<color=#20b376>%s</color>", finishEventNum, totalEventNum) or string.format("<color=#20b376>%s</color>/<color=#20b376>%s</color>", finishEventNum, totalEventNum)

	local result, tips = PowerPillaController.instance:getJumpStageResultAndTips(self._activityId, stage)

	GameUtil.SetGray(btnJump, result ~= GameEnum.ResultCode.Success)

	local function jumpFunc()
		local result, tips = PowerPillaController.instance:getJumpStageResultAndTips(self._activityId, stage)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		GotoMgr.gotoByString(string.format("event#jumptostageaspowerpilla#%s", stage))
	end

	GameUtil.addClickHandler(btnJump, jumpFunc)
end

function PowerPillaBossTipsView:_clearDescCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "headcell/icon")
	local btnJump = goutil.findChild(mainGo, "btnJump")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(btnJump)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function PowerPillaBossTipsView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function PowerPillaBossTipsView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function PowerPillaBossTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return PowerPillaBossTipsView
