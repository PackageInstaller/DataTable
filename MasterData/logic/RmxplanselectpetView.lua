-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanselectpetView.lua

module("logic.extensions.richmanxplan.view.RmxplanselectpetView", package.seeall)

local RmxplanselectpetView = class("RmxplanselectpetView", ViewComponent)

function RmxplanselectpetView:ctor()
	RmxplanselectpetView.super.ctor(self)
end

function RmxplanselectpetView:unbindEvents()
	RmxplanselectpetView.super.unbindEvents(self)
	self._btnPutIn:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnFliterType:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._Cell3:RemoveClickListener()
	self._Cell2:RemoveClickListener()
	self._Cell1:RemoveClickListener()
	self._Cell0:RemoveClickListener()
end

function RmxplanselectpetView:bindEvents()
	RmxplanselectpetView.super.bindEvents(self)
	self._btnPutIn:AddClickListener(self._onClickbtnPutIn, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._btnFliterType:AddClickListener(self._onClickbtnFliterType, self)
	self._btnFilter:AddClickListener(self._onClickbtnFilter, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._Cell3:AddClickListener(self._onClickCell3, self)
	self._Cell2:AddClickListener(self._onClickCell2, self)
	self._Cell1:AddClickListener(self._onClickCell1, self)
	self._Cell0:AddClickListener(self._onClickCell0, self)
end

function RmxplanselectpetView:buildUI()
	RmxplanselectpetView.super.buildUI(self)

	self._btnPutIn = self:getBtn("btnPutIn")
	self._btnClose = self:getBtn("btnClose")
	self._btnClear = self:getBtn("InputC_Search/btnClear")
	self._btnFliterType = self:getBtn("btnFliterType")
	self._btnFilter = self:getBtn("btnFilter")
	self._inputComp = self:getInput("InputC_Search")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._sortpanelGo = self:getGo("sortpanel")
	self._Cell3 = self:getBtn("sortpanel/content/Cell3")
	self._Cell2 = self:getBtn("sortpanel/content/Cell2")
	self._Cell1 = self:getBtn("sortpanel/content/Cell1")
	self._Cell0 = self:getBtn("sortpanel/content/Cell0")
	self._txtBtnFilterType = self:getTxt("btnFliterType/Text")
end

function RmxplanselectpetView:onExit()
	RmxplanselectpetView.super.onExit(self)
	self._scrollerList:dispose()
end

function RmxplanselectpetView:onEnter()
	RmxplanselectpetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._posId = checknumber(params[2])
	self._currPetId = checknumber(params[3])
	self._selectPetId = self._currPetId
	self._filterType = RichmanxplanController.FilterType.All

	self._inputComp:SetText("")

	self._exclusiveRaceId = {}

	local workCfg = RichmanxplanConfig.instance:getWorkCfg(self._activityId, self._posId)

	for i, v in ipairs(workCfg.exclusiveRaceId) do
		self._exclusiveRaceId[v] = v
	end

	self:_update()
	self:_setTxtBtnFilterType()
	goutil.setActive(self._sortpanelGo, false)
end

function RmxplanselectpetView:_onClickbtnPutIn()
	if self._selectPetId > 0 then
		if self._currPetId == self._selectPetId then
			FloatWordMgr.instance:show("精灵没有变化")
			self:close()

			return
		end

		RichManXPlanAgent.instance:sendPM_RichManXPlanWorkSetPetReq(self._activityId, self._selectPetId, self._posId)
		self:close()
	else
		FloatWordMgr.instance:show("请选择放入的精灵")
	end
end

function RmxplanselectpetView:_onClickbtnClose()
	self:close()
end

function RmxplanselectpetView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function RmxplanselectpetView:_onClickbtnFliterType()
	goutil.setActive(self._sortpanelGo, true)
end

function RmxplanselectpetView:_onClickbtnFilter()
	return
end

function RmxplanselectpetView:_inputValueChanged(text)
	local text = self._inputComp:GetText()

	if self._searchStr == text then
		return
	end

	self._searchStr = text

	self:_update()
end

function RmxplanselectpetView:_update()
	self:_updateData()
	self:_updateUI()
end

function RmxplanselectpetView:_updateData()
	self._fullPetDatas = RichmanxplanModel.instance:getPetDatas()

	local petDatas = {}

	if string.nilorempty(self._searchStr) then
		petDatas = self._fullPetDatas
	else
		for i, petData in ipairs(self._fullPetDatas) do
			local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, petData.raceId)

			if string.find(petCfg.name, self._searchStr) then
				table.insert(petDatas, petData)
			end
		end
	end

	local tableFliterStarLevel = {}

	if self._filterType == RichmanxplanController.FilterType.All then
		tableFliterStarLevel = petDatas
	else
		for i, petData in ipairs(petDatas) do
			if petData.starLevel == self._filterType then
				table.insert(tableFliterStarLevel, petData)
			end
		end
	end

	table.sort(petDatas, function(a, b)
		return (self._exclusiveRaceId[a.raceId] and 1 or 0) > (self._exclusiveRaceId[b.raceId] and 1 or 0)
	end)

	self._petDatas = tableFliterStarLevel
end

function RmxplanselectpetView:_updateUI()
	self._scrollerList:reloadData(self._petDatas)
end

function RmxplanselectpetView:_updateCell(view, cell, petData, tag)
	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")
	local goSelect = goutil.findChild(cell.gameObject, "btnSelect/img")
	local goIcon = goutil.findChild(cell.gameObject, "item/icon")
	local bgChange = goutil.findChild(cell.gameObject, "item/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goRecommend = goutil.findChild(cell.gameObject, "recommend")
	local txtBuffDesc = goutil.findChildTextComponent(cell.gameObject, "txts/txtBuffDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txts/txtName")
	local txtWorkType = goutil.findChildTextComponent(cell.gameObject, "txts/txtWorkType")
	local goStar = goutil.findChild(cell.gameObject, "item/star")
	local goStars = goutil.findChild(cell.gameObject, "item/stars")
	local isRecommend = self._exclusiveRaceId[petData.raceId]
	local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, petData.raceId)

	MaterialMgr.setIcon(goIcon, MatType.Pet, petCfg.linkRaceId)
	bgChange:SetState(petData.starLevel - 1)
	goutil.setActive(goLock, false)
	goutil.setActive(goRecommend, isRecommend)
	goutil.setActive(btnSelect.gameObject, self._posId > 0)
	goutil.setActive(goSelect, self._selectPetId == petData.petId)

	txtBuffDesc.text = petCfg.effectDesc
	txtName.text = petCfg.name
	txtWorkType.text = petCfg.workType

	goutil.setActive(goStar, false)
	self:_updateStars(goStars, goStar, petData.starLevel)
	btnSelect:AddClickListener(function()
		self._selectPetId = self._selectPetId == petData.petId and 0 or petData.petId

		self:_updateUI()
	end)
end

function RmxplanselectpetView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "item/icon")

	MaterialMgr.resetAll(goIcon)
end

function RmxplanselectpetView:_updateStars(goStars, goStar, starLevel)
	local childs = GameUtil.getChildren(goStars)
	local starLayout = goStars:GetComponent(ComponentType.UILayoutSingleLine)

	for i, v in ipairs(childs) do
		goutil.setActive(v, false)
	end

	for i = 1, starLevel do
		local go = childs[i]

		go = go or goutil.cloneAndSetParent(goStar, goStars.transform)

		goutil.setActive(go, true)
	end

	starLayout:Layout()
end

function RmxplanselectpetView:_setTxtBtnFilterType()
	local str = ""

	if self._filterType == RichmanxplanController.FilterType.One then
		str = "1星"
	elseif self._filterType == RichmanxplanController.FilterType.Two then
		str = "2星"
	elseif self._filterType == RichmanxplanController.FilterType.Three then
		str = "3星"
	elseif self._filterType == RichmanxplanController.FilterType.All then
		str = "全部"
	end

	self._txtBtnFilterType.text = str
end

function RmxplanselectpetView:_onClickCell3()
	self:_onCliclFilterType(RichmanxplanController.FilterType.Three)
end

function RmxplanselectpetView:_onClickCell2()
	self:_onCliclFilterType(RichmanxplanController.FilterType.Two)
end

function RmxplanselectpetView:_onClickCell1()
	self:_onCliclFilterType(RichmanxplanController.FilterType.One)
end

function RmxplanselectpetView:_onClickCell0()
	self:_onCliclFilterType(RichmanxplanController.FilterType.All)
end

function RmxplanselectpetView:_onCliclFilterType(fType)
	goutil.setActive(self._sortpanelGo, false)

	self._filterType = fType

	self:_setTxtBtnFilterType()
	self:_update()
end

return RmxplanselectpetView
