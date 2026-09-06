-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxldifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxldifficultyView", package.seeall)

local ZxldifficultyView = class("ZxldifficultyView", ViewComponent)

function ZxldifficultyView:ctor()
	ZxldifficultyView.super.ctor(self)
end

function ZxldifficultyView:unbindEvents()
	ZxldifficultyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._btnGet:RemoveClickListener()

	for i = 1, 3 do
		self._btns[i]:RemoveClickListener()
	end
end

function ZxldifficultyView:bindEvents()
	ZxldifficultyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "orderlyDragoChapter_rule")
	end, self)
	self._btnGet:AddClickListener(function()
		GotoMgr.gotoByString("func#984")
	end, self)

	for i = 1, 3 do
		self._btns[i]:AddClickListener(function()
			self:_clickChapter(i)
		end, self)
	end
end

function ZxldifficultyView:buildUI()
	ZxldifficultyView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._tipsBtn = self:getBtn("btnTip")
	self._btnGet = self:getBtn("btnGet")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._btns = {}

	for i = 1, 3 do
		self._btns[i] = self:getBtn("titals/item" .. tostring(i))
	end
end

function ZxldifficultyView:onExit()
	ZxldifficultyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self._clickChapter, self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._bg)
end

function ZxldifficultyView:onEnter()
	ZxldifficultyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self._clickChapter, self)

	self.activityType = ShikongshenglongController.instance:getActivityType()
	self.activityId = ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.ZxlChallenge)

	if self.activityId <= 0 then
		self:close()

		return
	end

	self.curChapter = ShikongshenglongModel.instance.curChapter

	self:_clickChapter(self.curChapter)
end

function ZxldifficultyView:_clickChapter(index)
	if index > ShikongshenglongModel.instance.curChapter then
		FloatWordMgr.instance:show("通关前置章节")

		return
	end

	for i = 1, 3 do
		local obj = self._btns[i].gameObject

		goutil.findChild(obj, "select"):SetActive(index == i)
	end

	self.curChapter = index

	self:_onRefreshUI()
end

function ZxldifficultyView:_onInitTital()
	for i = 1, 3 do
		local obj = self._btns[i].gameObject

		goutil.findChild(obj, "lock"):SetActive(i > ShikongshenglongModel.instance.curChapter)
		goutil.findChild(obj, "dot"):SetActive((i <= ShikongshenglongModel.instance.curChapter or false) and ShikongshenglongModel.instance:isChapterRed(self.activityId, i))
	end
end

function ZxldifficultyView:_onRefreshUI(curChapter)
	self:_onInitTital()

	self.curStageIndex = 1
	self.stagesCfgs = ShikongshenglongConfig.instance:getStages(self.activityId, self.curChapter)

	self._tableview:reloadData(self.stagesCfgs)
	self._tableview:refresh()
	self._tableview:MoveCellToCenter(self.curStageIndex)
end

function ZxldifficultyView:_updateCell(view, cell, data)
	local stageId = ShikongshenglongModel.instance.curStageId
	local isPass = stageId > data.stageId
	local isCurStage = data.stageId == stageId
	local isCurStageGo = isCurStage and not isPass

	if isCurStageGo then
		self.curStageIndex = cell.index
	end

	local imgNum = goutil.findChild(cell, "zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnChallenge"))
	local diffChange = goutil.findChildComponent(cell, "mode/img", typeof(UIImageSpriteChange))

	diffChange:SetState(data.difficulty - 1)
	imgNum:SetText(tostring(data.battlePowers))

	goutil.findChildTextComponent(cell, "btnChallenge/txt").text = isPass and "已通关" or data.chapterDifficulty
	goutil.findChildTextComponent(cell, "txtTip").text = data.passCondition

	goutil.findChild(cell, "pass"):SetActive(isPass)
	goutil.findChild(cell, "redpoint"):SetActive(isCurStageGo)
	btn:AddClickListener(function()
		local creepsMasterId = data.creepsMasterId

		if isPass then
			FloatWordMgr.instance:show("已通关")
		elseif isCurStage then
			ViewAutoShowController.instance:saveCurModalView()
			UIStateManager.instance:push(ViewName.SkslMissionView, self.activityId, creepsMasterId)
		else
			FloatWordMgr.instance:show("请通关前置关卡")
		end
	end, self)

	local prizeStr = data.prize

	if prizeStr == "" then
		return
	end

	local tabPize = string.split(prizeStr, "#")

	for i, v in ipairs(tabPize) do
		local type, id, num = MaterialMgr.getMatParams(v)
		local go = goutil.findChild(cell, "reward/icon" .. i)

		MaterialMgr.setIcon(go, type, id)

		goutil.findChildTextComponent(go, "num").text = "x" .. num
	end
end

function ZxldifficultyView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnChallenge"))
end

return ZxldifficultyView
