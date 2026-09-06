-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesResultCopyView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesResultCopyView", package.seeall)

local TripleMacthesResultCopyView = class("TripleMacthesResultCopyView", ViewComponent)

function TripleMacthesResultCopyView:ctor()
	TripleMacthesResultCopyView.super.ctor(self)
end

function TripleMacthesResultCopyView:unbindEvents()
	TripleMacthesResultCopyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSave)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TripleMacthesResultCopyView:bindEvents()
	TripleMacthesResultCopyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSave, self._onClickSave, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function TripleMacthesResultCopyView:buildUI()
	TripleMacthesResultCopyView.super.buildUI(self)

	self._btnSave = self:getGo("btnSave")
	self._btnCancel = self:getGo("btnCancel")
	self._targetScrollerview = self:getGo("targetScrollerview")
	self._targetCell = self:getGo("targetCell")
	self._txtScore = self:getTxt("txtScore")
	self._targetTableList = ScrollerList.create(self._targetScrollerview, self._targetCell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))

	self._targetTableList:setCenterMode(true)
end

function TripleMacthesResultCopyView:onExit()
	TripleMacthesResultCopyView.super.onExit(self)
	self._targetTableList:dispose()
end

function TripleMacthesResultCopyView:onEnter()
	TripleMacthesResultCopyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._finishCallBack = params[1]
	self._txtScore.text = TripleMacthesModel.instance:getTotalScore()

	local targetList = TripleMacthesModel.instance:getTargetGroup()

	self._targetTableList:reloadData(targetList)
end

function TripleMacthesResultCopyView:_updateTargetCell(view, cell, data, tag)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")
	local txt = goutil.findChildTextComponent(go, "txtNum")
	local txtColorChange = goutil.findChildComponent(go, "txtNum", "UITextColorChange")
	local imgComplete = goutil.findChild(go, "imgComplete")
	local txtScore = goutil.findChildTextComponent(go, "txtAddScore")

	txtScore.text = langPara("+%d积分", data.score)

	uGuiUtil.clearImage(imageGo)

	if data.type == "Collect" then
		local removeCellType = TripleMacthesGameModel.instance:getRemoveCellType()
		local collectCount = 0
		local arr = string.split(data.params, "#")
		local needCount = checknumber(arr[2])
		local typesArr = string.split(arr[1], ":")
		local firstType = checknumber(typesArr[1])

		for j, typeStr in ipairs(typesArr) do
			local type = checknumber(typeStr)

			if removeCellType and removeCellType[type] then
				collectCount = collectCount + removeCellType[type]
			end
		end

		if needCount <= collectCount then
			txtColorChange:SetState(0)
			GameUtil.SetActive(imgComplete, true)
		else
			txtColorChange:SetState(1)
			GameUtil.SetActive(imgComplete, false)
		end

		txt.text = string.format("%d/%d", math.min(collectCount, needCount), needCount)

		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(firstType)
		local iconReplace = TripleMacthesGameModel.instance:getIconReplaceCfg()

		if iconReplace[firstType] then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", iconReplace[firstType].icon))
		elseif blockCfg and not string.nilorempty(blockCfg.icon) then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", blockCfg.icon))
		end
	elseif data.type == "CreateSpeical" then
		local createCellType = TripleMacthesGameModel.instance:getCreateCellType()
		local collectCount = 0
		local arr = string.split(data.params, "#")
		local needCount = checknumber(arr[2])
		local typesArr = string.split(arr[1], ":")
		local firstType = checknumber(typesArr[1])

		for j, typeStr in ipairs(typesArr) do
			local type = checknumber(typeStr)

			if createCellType and createCellType[type] then
				collectCount = collectCount + createCellType[type]
			end
		end

		if needCount <= collectCount then
			txtColorChange:SetState(0)
			GameUtil.SetActive(imgComplete, true)
		else
			txtColorChange:SetState(1)
			GameUtil.SetActive(imgComplete, false)
		end

		txt.text = string.format("%d/%d", math.min(collectCount, needCount), needCount)

		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(firstType)
		local iconReplace = TripleMacthesGameModel.instance:getIconReplaceCfg()

		if iconReplace[firstType] then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", iconReplace[firstType].icon))
		elseif blockCfg and not string.nilorempty(blockCfg.icon) then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", blockCfg.icon))
		end
	end
end

function TripleMacthesResultCopyView:_clearTargetCell(cell)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")

	uGuiUtil.clearImage(imageGo)
end

function TripleMacthesResultCopyView:_onClickSave()
	local info = {}

	info.isPass = true
	info.gameScore = TripleMacthesModel.instance:getTotalScore()

	GameUtil.callBack(self._finishCallBack, info)
	self:_PM_TripleMacthesGameEnd()
end

function TripleMacthesResultCopyView:_onClickCancel()
	local info = {}

	info.isPass = false
	info.gameScore = TripleMacthesModel.instance:getTotalScore()

	GameUtil.callBack(self._finishCallBack, info)
	self:_PM_TripleMacthesGameEnd()
end

function TripleMacthesResultCopyView:_PM_TripleMacthesGameEnd()
	self:close()
	UIStateManager.instance:popByName(ViewName.TripleMacthesGameCopyView)
end

return TripleMacthesResultCopyView
