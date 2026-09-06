-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/view/WisdomCourageClgSupportView.lua

module("logic.extensions.wisdomcourageclg.view.WisdomCourageClgSupportView", package.seeall)

local WisdomCourageClgSupportView = class("WisdomCourageClgSupportView", ViewComponent)

function WisdomCourageClgSupportView:ctor()
	WisdomCourageClgSupportView.super.ctor(self)

	self._recyclePrizeGoList = {}
	self._prizeItemList = {}
end

function WisdomCourageClgSupportView:buildUI()
	WisdomCourageClgSupportView.super.buildUI(self)

	self._btnEnter = self:getGo("btnEnter")
	self._btnRank = self:getGo("btnRank")
	self._btnReset = self:getGo("btnReset")
	self._bg = self:getGo("bg")
	self._btnBoss = self:getGo("btnBoss")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtTips = self:getTxt("tips/txt")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._txtStage = self:getTxt("rewardCol/txtStage")
	self.cell = self:getGo("rewardCol/scrCell")
	self.tableview = self:getGo("rewardCol/scrView")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:setCenterMode(true)

	local pathPrefix = "progress/prizeview/viewport/"

	self._prizeSlider = self:getSlider(pathPrefix .. "content/progBar")
	self._prizeContentRectTrans = self:getGo(pathPrefix .. "content"):GetComponent(goutil.Type_RectTransform)
	self._recycleGo = self._prizeContentRectTrans.gameObject
	self._prizecell = self:getGo("progress/prizecell")
	self._prizeview = self:getGo("progress/prizeview")
	self._prizeViewRect = self._prizeview:GetComponent(ComponentType.ScrollRect)

	goutil.setActive(self._prizecell, false)

	self._prizeSliderRectTrans = self._prizeSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._prizeSliderRectTrans, 0, 0)

	self._prizeSliderStartOffset = y
	self._prizeSliderEndOffset = 50
	self._prizeWidthSpace = 150
end

function WisdomCourageClgSupportView:bindEvents()
	WisdomCourageClgSupportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function WisdomCourageClgSupportView:unbindEvents()
	WisdomCourageClgSupportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReset)
end

function WisdomCourageClgSupportView:onEnter()
	WisdomCourageClgSupportView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = WisdomCourageClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = WisdomCourageClgController.instance:getActivityType()
	self._clgMo = WisdomCourageClgController.instance:getWisdomCourageClgMo(self._activityId)
	self._actData = WisdomCourageClgConfig.instance:getActData(self._activityId)
	self._stageId = 0

	self.addGEvent(self, GlobalNotify.HandlePM_WisdomCourageClgSupportInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WisdomCourageClgSupportResetRes, self._onUpdate, self)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_initReward()
	self:_loadBgEffect()
	WisdomCourageClgController.instance:sendPM_WisdomCourageClgSupportInfoReq(self._activityId)
end

function WisdomCourageClgSupportView:onExit()
	WisdomCourageClgSupportView.super.onExit(self)
	self.scrollList:dispose()
	self:_clearReward()
	self:_clearBgEffect()
end

function WisdomCourageClgSupportView:_onUpdate()
	self._stageId = Mathf.Min(self._clgMo:getCurStageIdInSupport() + 1, self._clgMo:getMaxStageIdInSupport())

	local stageData = WisdomCourageClgConfig.instance:getSupportStageData(self._activityId, self._stageId)

	self:_updateReward()

	self._txtStage.text = self._stageId
	self._txtTips.text = self._clgMo:getSupportPetNum()

	local prize = stageData and stageData.prize

	if not string.nilorempty(prize) then
		local strList = string.split(prize, "#")

		self.scrollList:reloadData(strList)
	end

	local changeSetId = self._clgMo:popChangeSetIdInSupport()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function WisdomCourageClgSupportView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function WisdomCourageClgSupportView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function WisdomCourageClgSupportView:_initReward()
	self:_clearReward()

	local cfgs = WisdomCourageClgConfig.instance:getSupportStageCfg(self._activityId)
	local count = #cfgs

	self:_setWorldContentLength(count)

	local posX = 126
	local posY = self._prizeSliderStartOffset

	for i, v in ipairs(cfgs) do
		posY = posY + self._prizeWidthSpace

		local go = self:_getWorldRewardGo()

		go.name = "prizecell" .. i

		goutil.addChildToParent(go, self._prizeContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local cls = GameUtil.AddLuaOnce(go, WccSupPrizeCell)

		cls:init(v, self, self._prizeview:GetComponent(goutil.Type_RectTransform))
		table.insert(self._prizeItemList, cls)
	end

	self:_setRewardSlider()
end

function WisdomCourageClgSupportView:_updateReward()
	for i, v in ipairs(self._prizeItemList) do
		v:update()
	end

	self:_setRewardSlider()

	local lastItem = self._prizeItemList[#self._prizeItemList]
	local lastPos = GameUtil.getAnchoredPos(lastItem.mainGO:GetComponent(goutil.Type_RectTransform))

	for i, v in ipairs(self._prizeItemList) do
		local isCanGet = self._stageId

		if isCanGet then
			local pos = GameUtil.getAnchoredPos(v.mainGO:GetComponent(goutil.Type_RectTransform))

			self._prizeViewRect.verticalNormalizedPosition = pos.y / lastPos.y

			break
		end
	end
end

function WisdomCourageClgSupportView:_setWorldContentLength(rewardCount)
	local sliderLength = rewardCount * self._prizeWidthSpace
	local contentTotalLength = self._prizeSliderStartOffset + sliderLength + self._prizeSliderEndOffset

	goutil.setHeight(self._prizeContentRectTrans, contentTotalLength)
	goutil.setWidth(self._prizeSliderRectTrans, sliderLength)
end

function WisdomCourageClgSupportView:_setRewardSlider()
	local curLevel = self._clgMo:getHistoryStageIdInSupport()
	local maxLevel = self._clgMo:getMaxStageIdInSupport()

	self._prizeSlider:SetValue((maxLevel ~= 0 or nil) and (self._clgMo:isPassAllStageInSupport() and 1 or self._clgMo:isPassStageInSupport(curLevel) and curLevel / maxLevel or (curLevel - 1) / maxLevel))
end

function WisdomCourageClgSupportView:_getWorldRewardGo()
	local count = #self._recyclePrizeGoList

	if count > 0 then
		local go = table.remove(self._recyclePrizeGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._prizecell, self._recycleGo.transform, "worldcell")

		goutil.setActive(go, true)

		return go
	end
end

function WisdomCourageClgSupportView:_recyclePrizeGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recyclePrizeGoList, go)
	end
end

function WisdomCourageClgSupportView:_clearReward()
	for i, v in ipairs(self._prizeItemList) do
		self:_recyclePrizeGo(v:getGo())
		v:clear()
	end

	table.clear(self._prizeItemList)
end

function WisdomCourageClgSupportView:_loadBgEffect()
	local path = "20240531/fuyaota/fx_ui_fuyaota_fw01"

	if not string.nilorempty(path) then
		path = path .. ".prefab"
		self._bgEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

		self._bgEffect:setParent(self._bg.transform)
		self._bgEffect:setScale(1)
		self._bgEffect:setLocalPos(0, 0, 0)
	end
end

function WisdomCourageClgSupportView:_clearBgEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function WisdomCourageClgSupportView:_onClickRank()
	WisdomCourageClgController.instance:openCommonTabRank(self._activityId, ViewName.WisdomCourageClgSupportViewRankChildView)
end

function WisdomCourageClgSupportView:_onClickReset()
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not WisdomCourageClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self._clgMo:getCurStageIdInSupport() <= 0 then
		result = GameEnum.ResultCode.IsPass
		tips = "无需重置"
	end

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否重置当前所有关卡？"

	local function okFunc()
		WisdomCourageClgController.instance:sendPM_WisdomCourageClgSupportResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function WisdomCourageClgSupportView:_onClickEnter()
	local result = self:getTryStartClgResultAndTips(true, self._activityId, self._stageId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	WisdomCourageClgController.instance:enterBattleInSupport(self._activityId, self._stageId)
end

function WisdomCourageClgSupportView:getTryStartClgResultAndTips(isNeedTips, activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._clgMo

	if not WisdomCourageClgController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:isPassAllStageInSupportCur() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif mo:isPassStageInSupportCur(stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return WisdomCourageClgSupportView
