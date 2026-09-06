-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/copy/view/Sksldifficultycopy1View.lua

module("logic.extensions.copy.view.Sksldifficultycopy1View", package.seeall)

local Sksldifficultycopy1View = class("Sksldifficultycopy1View", ViewComponent)

function Sksldifficultycopy1View:ctor()
	Sksldifficultycopy1View.super.ctor(self)
end

function Sksldifficultycopy1View:unbindEvents()
	Sksldifficultycopy1View.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function Sksldifficultycopy1View:bindEvents()
	Sksldifficultycopy1View.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		local ruleName = ShikongshenglongConfig.instance:getCommonValue("OPEN_RULE_LIMIT")

		UIStateManager.instance:push(ViewName.RulesView, ruleName)
	end)
end

function Sksldifficultycopy1View:buildUI()
	Sksldifficultycopy1View.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._tipsBtn = self:getBtn("btnTip")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableview:regGetCellSize(GameUtil.handler(self._cellSize, self))
end

function Sksldifficultycopy1View:onExit()
	Sksldifficultycopy1View.super.onExit(self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._bg)
end

function Sksldifficultycopy1View:onEnter()
	Sksldifficultycopy1View.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SKL_GETINFORES, self.onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)

	self.activityId = self:_getActivityId()
	self.curChapter = self:getFirstParam()

	if self.curChapter == nil then
		self.curChapter = ShikongshenglongModel.instance.curChapter
	end

	self._cfgActivity = ShikongshenglongConfig.instance:getActivityCfg(self.activityId)
	self.stagesCfgs = ShikongshenglongConfig.instance:getStages(self.activityId, self.curChapter)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getChallengeUrl(self._viewPresentor.chapterChallengeBg[self.curChapter]))

	self._needSetToBegin = true

	self:onRefreshUI()
end

function Sksldifficultycopy1View:onGetInfoRes()
	self:onRefreshUI()
end

function Sksldifficultycopy1View:onRefreshUI()
	self._isOpenClick = true

	self._tableview:reloadData(self.stagesCfgs)

	if self._needSetToBegin then
		self._needSetToBegin = false

		local idx = 1

		for i, v in ipairs(self.stagesCfgs) do
			local isSweep = ShikongshenglongModel.instance:isSweep(v.stageId)

			if not isSweep then
				idx = i

				break
			end
		end

		self._tableview:MoveCellToBegin(idx - 1)
	end
end

function Sksldifficultycopy1View:_updateCell(index, cell, data)
	local txtBtnChallenge = goutil.findChildTextComponent(cell, "btnChallenge/txt")
	local stageId = ShikongshenglongModel.instance.curStageId
	local isPass = stageId > data.stageId
	local isCurStage = data.stageId == stageId
	local isSweep = ShikongshenglongModel.instance:isSweep(data.stageId)
	local imgNum = goutil.findChild(cell, "zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	local btn = Framework.ButtonAdapter.Get(goutil.findChild(cell, "btnChallenge"))
	local diffChange = goutil.findChildComponent(cell, "mode/img", typeof(UIImageSpriteChange))

	diffChange:SetState(data.difficulty - 1)
	imgNum:SetText(tostring(data.battlePowers))

	txtBtnChallenge.text = self._cfgActivity.supportSweep and (isSweep and "已通关" or isPass and "扫荡" or data.chapterDifficulty) or isPass and "已通关" or data.chapterDifficulty
	goutil.findChildTextComponent(cell, "txtTip").text = data.passCondition

	goutil.findChild(cell, "pass"):SetActive(isPass)
	goutil.findChild(cell, "redpoint"):SetActive(ShikongshenglongModel.instance:isStageRed(data.stageId))

	if isPass then
		if not data.sweepPrize then
			local prizeStr = data.prize
			local tabPize = string.split(prizeStr, "#")

			for i, v in ipairs(tabPize) do
				local type, id, num = MaterialMgr.getMatParams(v)
				local go = goutil.findChild(cell, "reward/icon" .. i)

				MaterialMgr.setIcon(go, type, id)

				goutil.findChildTextComponent(go, "num").text = "x" .. num
			end

			btn:AddClickListener(function()
				local activityId = self:_getActivityId()
				local creepsMasterId = data.creepsMasterId

				if isPass then
					if isSweep then
						FloatWordMgr.instance:show("今日已通关")
					elseif self._isOpenClick then
						ShikongshenglongController.instance:sendToSweep(activityId, data.stageId)

						self._isOpenClick = false
					end
				elseif isCurStage then
					UIStateManager.instance:push(ViewName.SkslMissionView, activityId, creepsMasterId)
					self:close()
				else
					FloatWordMgr.instance:show("请通关前置关卡")
				end
			end, self)

			local wight = self.curChapter == 3 and 245 or 176

			goutil.setWidth(cell:GetComponent(goutil.Type_RectTransform), wight)
		end
	end
end

function Sksldifficultycopy1View:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnChallenge"))
end

function Sksldifficultycopy1View:_cellSize(view, index)
	local wight = self.curChapter == 3 and 210 or 120

	return wight, 300
end

function Sksldifficultycopy1View:_getActivityId()
	return ShikongshenglongController.SYWDLYActivityId
end

return Sksldifficultycopy1View
