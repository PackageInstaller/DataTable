-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/PetTitleOverView.lua

module("logic.extensions.roleinfo.view.PetTitleOverView", package.seeall)

local PetTitleOverView = class("PetTitleOverView", TableViewComponent)

function PetTitleOverView:ctor()
	PetTitleOverView.super.ctor(self)
end

function PetTitleOverView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "listContent/list"
	}
end

function PetTitleOverView:_cellSize(view, index)
	return 158, 116
end

function PetTitleOverView:buildUI()
	PetTitleOverView.super.buildUI(self)

	self._petTitleNum = goutil.findChildComponent(self.mainGO, "petTitleNum/imgNum", "UIImgNumeralText")
	self._petTitleDescribe = goutil.findChildTextComponent(self.mainGO, "petTitleDescribe")
	self._petTitleGetRule = goutil.findChildTextComponent(self.mainGO, "ruleView/Viewport/petTitleGetRule")
	self._txtEmptyGo = goutil.findChild(self.mainGO, "listContent/txtEmpty")
	self._btnClose = self:getBtn("btnClose")
	self._btnGoto = self:getBtn("btnGoto")
end

function PetTitleOverView:bindEvents()
	PetTitleOverView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function PetTitleOverView:unbindEvents()
	PetTitleOverView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnGoto)
end

function PetTitleOverView:destroyUI()
	PetTitleOverView.super.destroyUI(self)
end

function PetTitleOverView:onEnter()
	PetTitleOverView.super.onEnter(self)

	self._petTitleDescribe.text = PetTitleConfig.instance:getClientCommonValue("PET_TITLE_DESC")
	self._petTitleGetRule.text = PetTitleConfig.instance:getClientCommonValue("GET_PET_TITLE")

	local userId = self:getFirstParam()

	self._isOtherInfo = userId ~= nil

	if userId then
		PetTitleController.instance:reqServerData(userId)
		goutil.setActive(self._btnGoto.gameObject, false)
	else
		goutil.setActive(self._btnGoto.gameObject, true)
		PetTitleController.instance:reqServerData()
		GlobalDispatcher:addListener(GlobalNotify.PetTitleModelChange, self._updateData, self)
	end

	GlobalDispatcher:addListener(GlobalNotify.PetTitleModelInit, self._updateData, self)
end

function PetTitleOverView:onExit()
	PetTitleOverView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetTitleModelInit, self._updateData, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetTitleModelChange, self._updateData, self)
end

function PetTitleOverView:_updateData()
	local array = PetTitleModel.instance:getTitleMoArray(self._isOtherInfo)
	local currentNum = #array
	local maxNum = #PetTitleConfig.instance:getPetTitleConfigs()

	self._petTitleNum:SetNum(currentNum)
	goutil.setActive(self._txtEmptyGo, currentNum == 0)
	table.sort(array, function(moA, moB)
		return StringUtil.CompareTwoNumber(moA:getGainTime(), moB:getGainTime(), true)
	end)
	self:updateListData(array)
end

function PetTitleOverView:_updateCell(view, cell, data)
	local getTime = goutil.findChildTextComponent(cell, "getTime")
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local config = PetTitleConfig.instance:getPetTitleConfig(data:getDefineId())
	local raceId = config.raceId

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, raceId)
	getTime.text = GameUtil.formatTimeStamp("%Y/%m/%d", checknumber(data:getGainTime()) / 1000)

	MaterialMgr.setCell(data:getMatType(), data:getDefineId(), icon)
end

function PetTitleOverView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")

	MaterialMgr.resetAll(icon)
end

function PetTitleOverView:_onClickClose()
	self:close()
end

function PetTitleOverView:_onClickGoto()
	UIStateManager.instance:push(ViewName.PetRankView)
end

return PetTitleOverView
