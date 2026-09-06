-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SksldifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SksldifficultyView", package.seeall)

local SksldifficultyView = class("SksldifficultyView", ViewComponent)

function SksldifficultyView:ctor()
	SksldifficultyView.super.ctor(self)
end

function SksldifficultyView:unbindEvents()
	SksldifficultyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
end

function SksldifficultyView:bindEvents()
	SksldifficultyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		local ruleName = ShikongshenglongConfig.instance:getCommonValue("OPEN_RULE")

		UIStateManager.instance:push(ViewName.RulesView, ruleName)
	end)
end

function SksldifficultyView:buildUI()
	SksldifficultyView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._bg = self:getGo("bg")
	self._tipsBtn = self:getBtn("btnTip")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))

	self._tableview:regGetCellSize(GameUtil.handler(self._cellSize, self))
end

function SksldifficultyView:onExit()
	SksldifficultyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)
	self._tableview:dispose()
	uGuiUtil.clearImage(self._bg)
end

function SksldifficultyView:onEnter()
	SksldifficultyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SKL_SWEEPOVER, self.onRefreshUI, self)

	self.activityId = self:_getActivityId()
	self.curChapter = self:getFirstParam()

	if self.curChapter == nil then
		self.curChapter = ShikongshenglongModel.instance.curChapter
	end

	self._cfgActivity = ShikongshenglongConfig.instance:getActivityCfg(self.activityId)
	self.stagesCfgs = ShikongshenglongConfig.instance:getStages(self.activityId, self.curChapter)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getChallengeUrl(self._viewPresentor.chapterChallengeBg[self.curChapter]))
	self:onRefreshUI()
end

function SksldifficultyView:onRefreshUI()
	self._isOpenClick = true

	self._tableview:reloadData(self.stagesCfgs)
	self._tableview:refresh()
end

function SksldifficultyView:_updateCell(index, cell, data)
	local txtBtnChallenge = goutil.findChildTextComponent(cell, "btnChallenge/txt")
	local stageId = ShikongshenglongModel.instance.curStageId
	local isPass = stageId > data.stageId
	local isCurStage = data.stageId == stageId
	local isSweep = ShikongshenglongModel.instance:isSweep(data.stageId)
	local imgNum = goutil.findChild(cell, "zdl/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
	local btn = GameUtil.asBtn(goutil.findChild(cell, "btnChallenge"))
	local group = cell:GetComponent(typeof(UIChangeGroup))
	local diffChange = goutil.findChildComponent(cell, "mode/img", typeof(UIImageSpriteChange))

	diffChange:SetState(data.difficulty - 1)
	group:SetState(self.curChapter - 1)
	imgNum:SetText(tostring(data.battlePowers))

	txtBtnChallenge.text = self._cfgActivity.supportSweep and (isSweep and "已扫荡" or isPass and "扫荡" or data.chapterDifficulty) or isPass and "已通关" or data.chapterDifficulty
	goutil.findChildTextComponent(cell, "txtTip").text = data.passCondition

	goutil.findChild(cell, "pass"):SetActive(isPass)
	goutil.findChild(cell, "redpoint"):SetActive(ShikongshenglongModel.instance:isStageRed(data.stageId))

	if isPass then
		if not data.sweepPrize then
			local prizeStr = data.prize
			local tabPize = string.split(prizeStr, "#")

			for i = 1, 2 do
				local str = tabPize[i]
				local go = goutil.findChild(cell, "reward/icon" .. i)

				if GameUtil.isEmptyString(str) then
					goutil.setActive(go, false)
				else
					goutil.setActive(go, true)

					local type, id, num = MaterialMgr.getMatParams(str)

					MaterialMgr.setIcon(go, type, id)

					goutil.findChildTextComponent(go, "num").text = "x" .. num
				end
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
					ViewAutoShowController.instance:saveCurModalView()
					UIStateManager.instance:push(ViewName.SkslMissionView, activityId, creepsMasterId)
				else
					FloatWordMgr.instance:show("请通关前置关卡")
				end
			end, self)

			local wight = self.curChapter == 3 and 245 or 176

			goutil.setWidth(cell:GetComponent(goutil.Type_RectTransform), wight)
		end
	end
end

function SksldifficultyView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "btnChallenge"))
end

function SksldifficultyView:_cellSize(view, index)
	local wight = self.curChapter == 3 and 210 or 120

	return wight, 300
end

function SksldifficultyView:_getActivityId()
	return ShikongshenglongController.instance:getActivityId(ShikongshenglongModel.SkslChallenge)
end

return SksldifficultyView
