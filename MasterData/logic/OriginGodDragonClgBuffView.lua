-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgBuffView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgBuffView", package.seeall)

local OriginGodDragonClgBuffView = class("OriginGodDragonClgBuffView", ViewComponent)

function OriginGodDragonClgBuffView:buildUI()
	OriginGodDragonClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtTips = self:getTxt("txtTips")
	self._strTxtTips = self._txtTips.text

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function OriginGodDragonClgBuffView:bindEvents()
	OriginGodDragonClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginGodDragonClgBuffView:unbindEvents()
	OriginGodDragonClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginGodDragonClgBuffView:onEnter()
	OriginGodDragonClgBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local stageId = checknumber(params[2])

	if stageId > 0 then
		self._jumpStageId = stageId
	end

	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)
	self._costItemMat = self._subMo:getCostItemMat()
	self._jumpStageId = self._jumpStageId or 0
	self._selectedStageId = self._jumpStageId

	local goldInfo = {
		showAdd = false,
		id = self._costItemMat.matStr
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})

	self._txtTips.text = string.format(self._strTxtTips, self._costItemMat.matName)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonEffectBuffRes, self._onUpdate, self)
end

function OriginGodDragonClgBuffView:onExit()
	OriginGodDragonClgBuffView.super.onExit(self)
	self._buffScrollerList:dispose()
end

function OriginGodDragonClgBuffView:_onUpdate()
	local dataList = {}
	local stageDataList = OriginGodDragonClgConfig.instance:getStageDatas(self._activityId) or {}

	for _, data in ipairs(stageDataList) do
		local stageType = self._subMo:getStageType(data.stageId)

		if stageType == OriginGodDragonClgEnum.StageType.Nor then
			table.insert(dataList, data)
		end
	end

	self._buffScrollerList:reloadData(dataList)

	if self._jumpStageId > 0 then
		for index, data in ipairs(dataList) do
			if data.stageId == self._jumpStageId then
				self._buffScrollerList:MoveCellToCenter(index - 1)

				break
			end
		end

		self._jumpStageId = 0
	end
end

function OriginGodDragonClgBuffView:_updateBuffCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local stageId = data.stageId
	local costItemNum = self._subMo:getUnlockCostItemNum(stageId)
	local isEffectBuff = self._subMo:isEffectBuff(stageId)
	local isPassStage = self._subMo:isPassStage(stageId)
	local curMatNum = MaterialModel.instance:getMaterialsNumber(self._costItemMat.matType, self._costItemMat.matId)
	local isEnoughMat = costItemNum <= curMatNum
	local tagBuiled = goutil.findChild(mainGo, "tagBuiled")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local costGo = goutil.findChild(mainGo, "cost")
	local iconCost = goutil.findChild(mainGo, "cost/icon")
	local txtCost = goutil.findChildTextComponent(mainGo, "cost/txt")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")

	txtName.text = data.buffName
	txtDesc.text = data.buffDesc
	txtCost.text = string.format("x%s", costItemNum)

	GameUtil.SetActive(costGo, not isEffectBuff)
	GameUtil.SetActive(tagBuiled, isEffectBuff)
	GameUtil.SetActive(tagLock, not isPassStage)
	GameUtil.SetActive(tagSelect, stageId == self._selectedStageId)

	if isPassStage then
		GameUtil.SetActive(btnSure, not isEffectBuff)
		GameUtil.SetGray(btnSure, not isEnoughMat)
	else
		GameUtil.SetActive(btnSure, true)
		GameUtil.SetGray(btnSure, true)
	end

	MaterialMgr.setIcon(iconCost, self._costItemMat.matType, self._costItemMat.matId, nil, nil)
	GameUtil.addClickHandler(btnSure, function()
		if not isPassStage then
			FloatWordMgr.instance:show("未通关")

			return
		end

		if isEffectBuff then
			FloatWordMgr.instance:show("已激活")

			return
		end

		if not isEnoughMat then
			FloatWordMgr.instance:show(string.format("%s不足", self._costItemMat.matName))

			return
		end

		local tipsContent = string.format("是否确认消耗%s x [%s]进行激活？", costItemNum, self._costItemMat.matName)

		local function okFunc()
			OriginGodDragonClgController.instance:sendPM_OriginGodDragonEffectBuffReq(self._activityId, data.zoneId, data.stageId)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	end, self)
end

function OriginGodDragonClgBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local iconCost = goutil.findChild(mainGo, "cost/icon")

	MaterialMgr.clearIcon(iconCost)
	GameUtil.SetGray(btnSure, false)
	GameUtil.rmClickHandler(btnSure)
end

return OriginGodDragonClgBuffView
