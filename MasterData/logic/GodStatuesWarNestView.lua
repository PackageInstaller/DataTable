-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarNestView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarNestView", package.seeall)

local GodStatuesWarNestView = class("GodStatuesWarNestView", ViewComponent)

function GodStatuesWarNestView:ctor()
	GodStatuesWarNestView.super.ctor(self)
end

function GodStatuesWarNestView:buildUI()
	GodStatuesWarNestView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._leftTimes = goutil.findChildTextComponent(self.mainGO, "leftTimes")

	local prizeScrView = goutil.findChild(self.mainGO, "prizeCol/prizeScrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "prizeCol/prizeScrCell")

	self._prizeScrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._tipsCol_txt = goutil.findChildTextComponent(self.mainGO, "tipsCol/txt")
	self._nest = goutil.findChild(self.mainGO, "nest")
	self._nest_icon = goutil.findChild(self.mainGO, "nest/icon")
	self._nestName_txt = goutil.findChildTextComponent(self.mainGO, "nestName/txt")
end

function GodStatuesWarNestView:bindEvents()
	GodStatuesWarNestView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function GodStatuesWarNestView:unbindEvents()
	GodStatuesWarNestView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClg)
end

function GodStatuesWarNestView:onEnter()
	GodStatuesWarNestView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._nestPlanId = checknumber(params[2])
	self._nestId = checknumber(params[3])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	if self._nestPlanId <= 0 or self._nestId <= 0 then
		printError("缺失传入参数")
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._nestData = GodStatuesWarConfig.instance:getNfbNestData(self._nestPlanId, self._nestId)
	self._prizeCfg = GodStatuesWarConfig.instance:getNfbDamagePrizeCfg(self._nestData.damageScorePlan)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function GodStatuesWarNestView:onExit()
	GodStatuesWarNestView.super.onExit(self)
	self:_onClear()
	self:_unLoadBigBg(self._nest_icon)

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarNestView:_onSetUI()
	self._nest = goutil.findChild(self.mainGO, "nest")
	self._nest_icon = goutil.findChild(self.mainGO, "nest/icon")
	self._nestName_txt = goutil.findChildTextComponent(self.mainGO, "nestName/txt")
	self._nestName_txt.text = self._nestData.name

	self:_loadBigBg(self._nest_icon, self._nestData.icon, true)
end

function GodStatuesWarNestView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= GswEnum.StepInterval_Bat then
		local text = "战斗阶段已结束"

		local function func()
			return
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
		self:close()

		return
	end

	self._curStep = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._curStepInterval = GodStatuesWarController.instance:getStepInterval(self._seasonId, self._curStep)

	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarNestView:_onUpdateData()
	return
end

function GodStatuesWarNestView:_onUpdateUI()
	local left = GodStatuesWarController.instance:getNestLeftFightTime(self._seasonId)
	local max = GodStatuesWarController.instance:getNestMaxFightTime(self._seasonId, self._curStep)

	self._leftTimes.text = left > 0 and string.format("剩余挑战次数：<color=#20b376>%s</color>/%s", left, max) or string.format("剩余挑战次数：<color=#eb4624>%s</color>/%s", left, max)

	self:_onUpdatePrizeColUI()
end

function GodStatuesWarNestView:_onClear()
	self:_onClearPrizeCol()
end

function GodStatuesWarNestView:_onUpdatePrizeColUI()
	self._prizeScrollList:reloadData(self._prizeCfg)
end

function GodStatuesWarNestView:_onClearPrizeCol()
	self._prizeScrollList:dispose()
end

function GodStatuesWarNestView:_updatePrizeCell(view, cell, data, tag)
	local curPrizeId = data.prizeId
	local nextPrizeId = Mathf.Min(curPrizeId + 1, #self._prizeCfg)
	local nextData = GodStatuesWarConfig.instance:getNfbDamagePrizeData(self._nestData.damageScorePlan, nextPrizeId)
	local mainGo = cell.gameObject
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local itemScrCell = goutil.findChild(mainGo, "itemScrCell")

	if curPrizeId == nextPrizeId then
		local damage = checknumber(data.damage)

		txtRank.text = string.format("%s以上", (damage >= 10000 or nil) and string.format("%sW", damage / 10000))
	else
		local damage = checknumber(data.damage)
		local nextDamage = checknumber(nextData.damage)

		txtRank.text = string.format("%s~%s", (damage >= 10000 or nil) and string.format("%sW", damage / 10000), (nextDamage >= 10000 or nil) and string.format("%sW", nextDamage / 10000))
	end

	if data.showPrize then
		local prizeStrArr = string.split(data.showPrize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	elseif self._itemScrollListDic[mainGo] then
		self._itemScrollListDic[mainGo]:dispose()
	end
end

function GodStatuesWarNestView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	if self._itemScrollListDic[mainGo] then
		self._itemScrollListDic[mainGo]:dispose()
	end
end

function GodStatuesWarNestView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarNestView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GodStatuesWarNestView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function GodStatuesWarNestView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function GodStatuesWarNestView:_onClickBtnClg()
	local result, tips = GodStatuesWarController.instance:getTryEnterFightNestInGswResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:close()
	GodStatuesWarController.instance:enterGodStatuesWarFightNestFmt(self._seasonId, self._nestPlanId, self._nestId)
end

return GodStatuesWarNestView
