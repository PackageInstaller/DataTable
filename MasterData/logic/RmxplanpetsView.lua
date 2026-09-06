-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanpetsView.lua

module("logic.extensions.richmanxplan.view.RmxplanpetsView", package.seeall)

local RmxplanpetsView = class("RmxplanpetsView", ViewComponent)

function RmxplanpetsView:ctor()
	RmxplanpetsView.super.ctor(self)
end

function RmxplanpetsView:unbindEvents()
	RmxplanpetsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnFliterType:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._Cell3:RemoveClickListener()
	self._Cell2:RemoveClickListener()
	self._Cell1:RemoveClickListener()
	self._Cell0:RemoveClickListener()
end

function RmxplanpetsView:bindEvents()
	RmxplanpetsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._btnFliterType:AddClickListener(self._onClickbtnFliterType, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._Cell3:AddClickListener(self._onClickCell3, self)
	self._Cell2:AddClickListener(self._onClickCell2, self)
	self._Cell1:AddClickListener(self._onClickCell1, self)
	self._Cell0:AddClickListener(self._onClickCell0, self)
end

function RmxplanpetsView:buildUI()
	RmxplanpetsView.super.buildUI(self)

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

function RmxplanpetsView:onExit()
	RmxplanpetsView.super.onExit(self)
	self._scrollerList:dispose()
end

function RmxplanpetsView:onEnter()
	RmxplanpetsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkPetStarLevelUpRes, self._update, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._filterType = RichmanxplanController.FilterType.All

	self._inputComp:SetText("")
	self:_update()
	self:_setTxtBtnFilterType()
	goutil.setActive(self._sortpanelGo, false)
end

function RmxplanpetsView:_onClickbtnClose()
	self:close()
end

function RmxplanpetsView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function RmxplanpetsView:_onClickbtnFliterType()
	goutil.setActive(self._sortpanelGo, true)
end

function RmxplanpetsView:_inputValueChanged(text)
	local text = self._inputComp:GetText()

	if self._searchStr == text then
		return
	end

	self._searchStr = text

	self:_update()
end

function RmxplanpetsView:_update()
	self:_updateData()
	self:_updateUI()
end

function RmxplanpetsView:_updateData()
	local petDatas = RichmanxplanModel.instance:getPetDatas()
	local hasRaceId = {}
	local tableDatas = {}

	for i, v in ipairs(petDatas) do
		local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, v.raceId)

		table.insert(tableDatas, {
			isPet = true,
			petData = v,
			petCfg = petCfg
		})

		hasRaceId[v.raceId] = true
	end

	local petCfgs = RichmanxplanConfig.instance:getPetCfgs(self._activityId)

	for i, v in ipairs(petCfgs) do
		if not hasRaceId[v.raceId] then
			table.insert(tableDatas, {
				isCfg = true,
				petCfg = v
			})
		end
	end

	local tableFliterSearchDatas = {}

	if not string.nilorempty(self._searchStr) then
		for i, v in ipairs(tableDatas) do
			if string.find(v.petCfg.name, self._searchStr) then
				table.insert(tableFliterSearchDatas, v)
			end
		end
	else
		tableFliterSearchDatas = tableDatas
	end

	local tableFliterStarLevel = {}

	if self._filterType == RichmanxplanController.FilterType.All then
		tableFliterStarLevel = tableFliterSearchDatas
	else
		for i, v in ipairs(tableFliterSearchDatas) do
			if v.isCfg or v.petData.starLevel == self._filterType then
				table.insert(tableFliterStarLevel, v)
			end
		end
	end

	self._viewDatas = tableFliterStarLevel
end

function RmxplanpetsView:_updateUI()
	self._scrollerList:reloadData(self._viewDatas)
end

function RmxplanpetsView:_updateCell(view, cell, data, tag)
	local goIcon = goutil.findChild(cell.gameObject, "item/icon")
	local bgChange = goutil.findChild(cell.gameObject, "item/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local txtBuffDesc = goutil.findChildTextComponent(cell.gameObject, "txts/txtBuffDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txts/txtName")
	local txtWorkType = goutil.findChildTextComponent(cell.gameObject, "txts/txtWorkType")
	local btnUpgrade = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUpgrade")
	local goStar = goutil.findChild(cell.gameObject, "item/star")
	local goStars = goutil.findChild(cell.gameObject, "item/stars")
	local petCfg = data.petCfg
	local petIsUnlock = data.isPet
	local petData = petIsUnlock and data.petData

	if petData then
		if not petData.starLevel then
			local starLevel = 1
			local nextLvCfg = RichmanxplanConfig.instance:getPetStarLevelCfg(self._activityId, starLevel + 1)

			GameUtil.SetGray(btnUpgrade.gameObject, not petIsUnlock)
			goutil.setActive(goLock, not petIsUnlock)

			txtBuffDesc.text = petCfg.effectDesc
			txtName.text = petCfg.name
			txtWorkType.text = petCfg.workType

			MaterialMgr.setIcon(goIcon, MatType.Pet, petCfg.linkRaceId)
			bgChange:SetState((petIsUnlock or nil) and (petData.starLevel - 1 or 0))
			goutil.setActive(goStar, false)
			self:_updateStars(goStars, goStar, starLevel)
			goutil.setActive(btnUpgrade.gameObject, nextLvCfg)
			btnUpgrade:AddClickListener(function()
				if not petIsUnlock then
					FloatWordMgr.instance:show("精灵未解锁")

					return
				end

				UIStateManager.instance:push(ViewName.RmxplanpetupgradeView, self._activityId, petData.petId)
			end)
		end
	end
end

function RmxplanpetsView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "item/icon")

	MaterialMgr.resetAll(goIcon)
end

function RmxplanpetsView:_updateStars(goStars, goStar, starLevel)
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

function RmxplanpetsView:_setTxtBtnFilterType()
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

function RmxplanpetsView:_onClickCell3()
	self:_onCliclFilterType(RichmanxplanController.FilterType.Three)
end

function RmxplanpetsView:_onClickCell2()
	self:_onCliclFilterType(RichmanxplanController.FilterType.Two)
end

function RmxplanpetsView:_onClickCell1()
	self:_onCliclFilterType(RichmanxplanController.FilterType.One)
end

function RmxplanpetsView:_onClickCell0()
	self:_onCliclFilterType(RichmanxplanController.FilterType.All)
end

function RmxplanpetsView:_onCliclFilterType(fType)
	goutil.setActive(self._sortpanelGo, false)

	self._filterType = fType

	self:_setTxtBtnFilterType()
	self:_update()
end

return RmxplanpetsView
