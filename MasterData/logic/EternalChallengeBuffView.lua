-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengeBuffView.lua

module("logic.extensions.eternalchallenge.view.shop.EternalChallengeBuffView", package.seeall)

local EternalChallengeBuffView = class("EternalChallengeBuffView", ViewComponent)

function EternalChallengeBuffView:ctor()
	EternalChallengeBuffView.super.ctor(self)
end

function EternalChallengeBuffView:buildUI()
	EternalChallengeBuffView.super.buildUI(self)

	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")

	local buffScrollerview = goutil.findChild(self.mainGO, "buffCol/buffScrollerview")
	local buffScrollercell = goutil.findChild(self.mainGO, "buffCol/buffScrollercell")

	self._buffScrollList = ScrollerList.create(buffScrollerview, buffScrollercell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function EternalChallengeBuffView:bindEvents()
	EternalChallengeBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function EternalChallengeBuffView:unbindEvents()
	EternalChallengeBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function EternalChallengeBuffView:onEnter()
	EternalChallengeBuffView.super.onEnter(self)

	self._activityId = EternalChallengeController.instance:getActivityId()
	self._activityType = EternalChallengeController.instance:getActivityType()

	local isInTime = EternalChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._buffInfoId = 0

	self.addGEvent(self, GlobalNotify.EternalChallengeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.EternalChallengeUpgradeBuffRes, self._onUpdate, self)
	self:_onSetUI()
	EternalChallengeController.instance:sendPM_EternalChallengeInfoReq(self._activityId)
end

function EternalChallengeBuffView:onExit()
	EternalChallengeBuffView.super.onExit(self)
	self:_onClearBuffCol()
end

function EternalChallengeBuffView:_onSetUI()
	local matStrList = {}
	local dataLists = EternalChallengeConfig.instance:getEcBuffDataLists(self._activityId)

	for buffId, dataList in ipairs(dataLists) do
		for _, data in ipairs(dataList) do
			if not string.nilorempty(data.cost) then
				table.insert(matStrList, data.cost)
			end
		end
	end

	matStrList = MaterialMgr.mergeMatStrList(matStrList)

	local list = {}

	for _, matStr in ipairs(matStrList) do
		if not string.nilorempty(matStr) then
			local tab = {
				showAdd = false,
				id = matStr
			}

			table.insert(list, tab)
		end
	end

	if #list > 0 then
		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end
end

function EternalChallengeBuffView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function EternalChallengeBuffView:_onUpdateData()
	self:_onUpdateBuffColData()
end

function EternalChallengeBuffView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateBuffColUI()
end

function EternalChallengeBuffView:_onUpdatePlaneUI()
	GameUtil.SetGray(self._btnSure, self._buffInfoId <= 0)
end

function EternalChallengeBuffView:_onUpdateBuffColData()
	local infoList = {}
	local dataLists = EternalChallengeConfig.instance:getEcBuffDataLists(self._activityId)

	for buffId, dataList in ipairs(dataLists) do
		local info = {}

		info.buffId = buffId
		info.curLevel = EternalChallengeController.instance:getCurBuffLevel(buffId)
		info.nextLevel = EternalChallengeController.instance:getNextBuffLevel(self._activityId, buffId)
		info.isFull = EternalChallengeController.instance:isFullBuffLevel(self._activityId, buffId)
		infoList[buffId] = info
	end

	local tempA = 0
	local tempB = 0

	table.sort(infoList, function(a, b)
		tempA = a.isFull and 1 or 0
		tempB = b.isFull and 1 or 0

		if tempA == tempB then
			return a.buffId < b.buffId
		end

		return tempA > tempB
	end)

	self._buffInfoList = infoList
	self._buffInfoPool = {}

	for _, info in ipairs(infoList) do
		self._buffInfoPool[info.buffId] = info
	end

	self._buffInfoId = Mathf.Clamp(self._buffInfoId, 0, #self._buffInfoList)
end

function EternalChallengeBuffView:_onUpdateBuffColUI()
	self._buffScrollList:reloadData(self._buffInfoList)

	if self._buffInfoId > 0 then
		local index = 1

		for idx, info in ipairs(self._buffInfoList) do
			if self._buffInfoId == info.buffId then
				index = idx

				break
			end
		end

		self._buffScrollList:MoveCellInView(index - 1, true)
	end
end

function EternalChallengeBuffView:_onClearBuffCol()
	self._buffScrollList:dispose()
end

function EternalChallengeBuffView:_updateBuffCell(view, cell, info, tag)
	local buffId = info.buffId
	local curLevel = info.curLevel
	local nextLevel = info.nextLevel
	local isFull = info.isFull
	local curBuffData = EternalChallengeConfig.instance:getEcBuffData(self._activityId, buffId, curLevel)
	local nextBuffData = EternalChallengeConfig.instance:getEcBuffData(self._activityId, buffId, nextLevel)
	local costMatType, costMatId, costMatNum = 0, 0, 0

	if not string.nilorempty(nextBuffData.cost) then
		costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextBuffData.cost)
	end

	local isNeedCost = costMatNum ~= 0
	local mainGo = cell.gameObject
	local imgBuff = goutil.findChild(mainGo, "imgBuff")
	local iconCost = goutil.findChild(mainGo, "iconCost")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local content = goutil.findChild(mainGo, "content")
	local txtCurDesc_content = goutil.findChildTextComponent(mainGo, "content/txtCurDesc")
	local txtNextDesc_content = goutil.findChildTextComponent(mainGo, "content/txtNextDesc")
	local maxContent = goutil.findChild(mainGo, "maxContent")
	local txtCurDesc_maxContent = goutil.findChildTextComponent(mainGo, "maxContent/txtCurDesc")

	txtLevel.text = string.format("%s级", curLevel)
	txtName.text = curBuffData.name
	txtNum.text = string.format("*%s", costMatNum)
	txtCurDesc_content.text = string.format("当前效果：%s", curBuffData.buffDesc)
	txtNextDesc_content.text = string.format("下级效果：%s", nextBuffData.buffDesc)
	txtCurDesc_maxContent.text = string.format("当前效果：%s", curBuffData.buffDesc)

	if isNeedCost then
		MaterialMgr.setIcon(iconCost, costMatType, costMatId, nil, nil)
	else
		MaterialMgr.resetAll(iconCost)
	end

	local path = curBuffData.iconPath
	local bgGo = imgBuff

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		uGuiUtil.clearImage(bgGo)
	end

	GameUtil.SetActive(content, not isFull)
	GameUtil.SetActive(maxContent, isFull)
	GameUtil.SetActive(txtNum.gameObject, not isFull or not isNeedCost)
	GameUtil.SetActive(iconCost, not isFull or not isNeedCost)
	GameUtil.SetActive(imgSelect, self._buffInfoId == buffId)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickBuff, self, buffId))
end

function EternalChallengeBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local iconCost = goutil.findChild(mainGo, "iconCost")
	local imgBuff = goutil.findChild(mainGo, "imgBuff")

	MaterialMgr.resetAll(iconCost)
	uGuiUtil.clearImage(imgBuff)
	GameUtil.rmClickHandler(mainGo)
end

function EternalChallengeBuffView:_onClickBuff(buffId)
	self._buffInfoId = self._buffInfoId == buffId and 0 or buffId

	self:_onUpdateUI()
end

function EternalChallengeBuffView:_onClickBtnSure()
	if self._buffInfoId <= 0 then
		FloatWordMgr.instance:show("未选中Buff")

		return
	end

	local info = self._buffInfoPool[self._buffInfoId]
	local buffId = info.buffId
	local result, tips = EternalChallengeController.instance:getTryPopUpdateBuffWinResultAndTips(self._activityId, buffId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local nextLevel = info.nextLevel
	local nextBuffData = EternalChallengeConfig.instance:getEcBuffData(self._activityId, buffId, nextLevel)
	local costMatType, costMatId, costMatNum = 0, 0, 0

	if not string.nilorempty(nextBuffData.cost) then
		costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(nextBuffData.cost)
	end

	local isNeedCost = costMatNum ~= 0

	if isNeedCost then
		local matName = MaterialMgr.getMaterialsName(costMatType, costMatId)
		local content = string.format("是否确认消耗[%s * %s]\n升级%s到%s级", matName, costMatNum, nextBuffData.name, nextLevel)

		local function successCallBack(state)
			return
		end

		local toggleFunc, togTxt
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		local function otherCallBack(state)
			if state == TipsFacade.STATE_CANCEL then
				-- block empty
			elseif state == TipsFacade.STATE_OK then
				-- block empty
			elseif state == TipsFacade.STATE_FAIL then
				FloatWordMgr.instance:show(string.format("%s数量不足", matName))
			elseif state == TipsFacade.STATE_SUCCESS then
				EternalChallengeController.instance:sendPM_EternalChallengeUpgradeBuffReq(self._activityId, buffId)
			end
		end

		local autoOpenSource

		TipsFacade.instance:openPopupCostMatViewNew(costMatType, costMatId, costMatNum, content, successCallBack, toggleFunc, togTxt, alignment, otherCallBack, autoOpenSource)
	else
		EternalChallengeController.instance:sendPM_EternalChallengeUpgradeBuffReq(self._activityId, buffId)
	end
end

return EternalChallengeBuffView
