-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingRewardView.lua

module("logic.extensions.liyangking.view.LiYangKingRewardView", package.seeall)

local LiYangKingRewardView = class("LiYangKingRewardView", ViewComponent)
local COLOR_GREEN_IDX = 0
local COLOR_RED_IDX = 1

function LiYangKingRewardView:ctor()
	LiYangKingRewardView.super.ctor(self)
end

function LiYangKingRewardView:unbindEvents()
	LiYangKingRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function LiYangKingRewardView:bindEvents()
	LiYangKingRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function LiYangKingRewardView:buildUI()
	LiYangKingRewardView.super.buildUI(self)

	self._closeBtn = self:getGo("closeBtn")
	self._clip = self:getGo("clip")
	self._tableView = self:getGo("tableView")
	self._itemCell = self:getGo("itemCell")
	self._scrollList = ScrollerList.create(self._tableView, self._itemCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LiYangKingRewardView:onExit()
	LiYangKingRewardView.super.onExit(self)
	self._scrollList:dispose()

	for k, scroll in pairs(self._scrollDic) do
		scroll:dispose()
	end
end

function LiYangKingRewardView:onEnter()
	LiYangKingRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangOneKeyGainPrizeRes, self._onGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 509001
	end

	self._levelCfgs = LiYangKingConfig.instance:getLevelCfgs(self._activityId)
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._attrMap = self._info.attributesMap
	self._scrollDic = {}

	self:_onUpdate()
end

function LiYangKingRewardView:_onUpdate()
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._kingLevel = LiYangKingController.instance:getCurKingLevel(self._activityId)

	self._scrollList:reloadData(self._levelCfgs)
	self._scrollList:dragNotifyParent()
end

function LiYangKingRewardView:_updateCell(view, cell, data)
	local get = goutil.findChild(cell, "get")
	local getColorChangeComp = goutil.findChild(cell, "get"):GetComponent(ComponentType.UIImageColorChange)
	local txtGet = goutil.findChildTextComponent(cell, "get/txt")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnGet = goutil.findChild(cell, "btnGet")
	local tableViewReward = goutil.findChild(cell, "tableViewReward")
	local tablecell = goutil.findChild(cell, "tablecell")
	local rewardArr = string.split(data.prize, "#")

	if not self._info.gainedPrizeIds then
		local gainedPrizeIds = {}
		local hasGain = table.indexof(gainedPrizeIds, data.level)
		local canGain = self._kingLevel >= data.level
		local dataList = {}

		for _, reward in ipairs(rewardArr) do
			local rewardData = {}

			rewardData.rewardStr = reward
			rewardData.canGain = canGain
			rewardData.hasGain = hasGain

			table.insert(dataList, rewardData)
		end

		if self._scrollDic[cell] then
			self._scrollDic[cell]:dispose()

			self._scrollDic[cell] = nil
		end

		txtDesc.text = string.format("等级%d", data.level)

		if not canGain then
			txtGet.text = "未达成"

			getColorChangeComp:SetState(COLOR_RED_IDX)
		end

		if hasGain then
			txtGet.text = "已领取"

			getColorChangeComp:SetState(COLOR_GREEN_IDX)
		end

		GameUtil.SetActive(get, not canGain or hasGain)
		GameUtil.SetActive(btnGet, canGain and not hasGain)

		self._scrollDic[cell] = ScrollerList.create(tableViewReward, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

		self._scrollDic[cell]:reloadData(dataList)
		self._scrollDic[cell]:dragNotifyParent()
		GameUtil.addClickHandler(btnGet, self._onClickGetPrize, self)
	end
end

function LiYangKingRewardView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	if self._scrollDic[cell] then
		self._scrollDic[cell]:dispose()
	end

	GameUtil.rmClickHandler(btnGet)
end

function LiYangKingRewardView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data.rewardStr, cell)
	self:_clearCellEffect(cell)

	if data.canGain and not data.hasGain then
		self:_playCellEffect(cell)
	end
end

function LiYangKingRewardView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
	self:_clearCellEffect(cell)
end

function LiYangKingRewardView:_playCellEffect(effGo)
	self:stopViewEffectUniGo(effGo)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self._clip.transform, true, nil, nil)
end

function LiYangKingRewardView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		self:stopViewEffectUniGo(effGo)

		self._cellEffects[effGo] = nil
	end
end

function LiYangKingRewardView:_onClickGetPrize()
	LiYangKingController.instance:sendPM_PrinceLiyangOneKeyGainPrizeReq(self._activityId)
end

function LiYangKingRewardView:_onGainPrizeRes()
	LiYangKingController.instance:sendPM_PrinceLiyangInfoReq(self._activityId)
end

return LiYangKingRewardView
