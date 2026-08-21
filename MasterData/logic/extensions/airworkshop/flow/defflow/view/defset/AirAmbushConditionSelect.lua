-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirAmbushConditionSelect.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirAmbushConditionSelect", package.seeall)

local M = class("AirAmbushConditionSelect")

M.ScrollType = {
	Text = 1,
	Hero = 2
}

function M:ctor(go)
	self.mainGO = go

	self:buildUI()
end

function M:buildUI()
	self._txtSave = goutil.findChildTextComponent(self.mainGO, "btn_middle/normal/Text1")
	self._btnSave = Astral.ButtonAdapter.GetFrom(self.mainGO, "btn_middle")
	self._btnReset = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnRefresh")
	self._rightHeroEmptyGo = goutil.findChild(self.mainGO, "stateHeroNull")
	self._leftScrollRectGo = goutil.findChild(self.mainGO, "leftScrollView")
	self._leftLoopGridView = LoopGridViewHelper.New(self._leftScrollRectGo)

	self._leftLoopGridView:InitGridView(0, self._updateLeftCell, self)

	self._rightTxtScrollRectGo = goutil.findChild(self.mainGO, "txtScrollView")
	self._rightTxtLoopGridView = LoopGridViewHelper.New(self._rightTxtScrollRectGo)

	self._rightTxtLoopGridView:InitGridView(0, self._updateRightTxtCell, self)

	self._rightHeroScrollRectGo = goutil.findChild(self.mainGO, "headScrollView")
	self._rightHeroLoopGridView = LoopGridViewHelper.New(self._rightHeroScrollRectGo)

	self._rightHeroLoopGridView:InitGridView(0, self._updateRightHeroCell, self)

	self._condition = false
	self._txtSave.text = "保存"

	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setSelectCondition(condition, params)
	self._originalCondition = condition
	self._originalParams = params
	self._leftContentList = {}
	self._rightContentList = {}
	self._conditionCOList = {}

	self:_initLeftScroll()

	self._leftIndex = self:_getLeftIndexByParams(condition)

	self:_initRightScroll()

	self._rightIndex = self:_getRightIndexByParams(params)

	self:_refreshLeftScroll()
	self:_refreshRightScroll()
	self:_updateFullStr()
end

function M:setHeroMO(unitMO)
	self._heroMO = unitMO
end

function M:_getLeftIndexByParams(condition)
	for i, co in ipairs(self._conditionCOList) do
		if condition == co.id then
			return i
		end
	end

	return 1
end

function M:_getRightIndexByParams(params)
	for i, v in ipairs(self._rightContentList) do
		if self._rightScrollType == M.ScrollType.Hero then
			if v:getId() == params then
				return i
			end
		elseif v == params then
			return i
		end
	end

	return -1
end

function M:_initLeftScroll()
	local conditionCOList = AirWorkShopConfig.instance:getAllAmbushConditionCO()

	for k, co in pairs(conditionCOList) do
		table.insert(self._conditionCOList, co)
		table.insert(self._leftContentList, string.format(co.descStr, "<sprite name=\"fhdt01\"><sprite name=\"fhdt02\">"))
	end
end

function M:_initRightScroll()
	local co = self._conditionCOList[self._leftIndex]

	table.clear(self._rightContentList)

	if co.type == GameEnum.AirStudioAmbushConditionEnum.MineDead then
		self._rightScrollType = M.ScrollType.Hero

		local model = AirWorkShopDefMgr.instance:getModel()
		local mapMO = model:getModiedMapMO()
		local airHeroMOList = mapMO:getHeroMOList()

		for i, mo in ipairs(airHeroMOList) do
			local characterCode = mo:getId()
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(characterCode)

			if heroMO and heroMO:getId() ~= self._heroMO:getId() then
				table.insert(self._rightContentList, heroMO)
			end
		end

		local ambushMOList = mapMO:getAmbushMOList()

		for i, mo in ipairs(ambushMOList) do
			local characterCode = mo:getId()
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(characterCode)

			if heroMO and heroMO:getId() ~= self._heroMO:getId() then
				table.insert(self._rightContentList, heroMO)
			end
		end
	else
		self._rightScrollType = M.ScrollType.Text

		for i, v in ipairs(co.limit) do
			table.insert(self._rightContentList, v)
		end
	end
end

function M:_refreshLeftScroll()
	self._leftLoopGridView:SetListItemCount(#self._leftContentList)
	self._leftLoopGridView:RefreshAllShownItem()
end

function M:_refreshRightScroll()
	if self._rightScrollType == M.ScrollType.Hero then
		goutil.setActive(self._rightTxtScrollRectGo, false)
		goutil.setActive(self._rightHeroScrollRectGo, true)

		if #self._rightContentList == 0 then
			goutil.setActive(self._rightHeroEmptyGo, true)
		else
			goutil.setActive(self._rightHeroEmptyGo, false)
			self._rightHeroLoopGridView:SetListItemCount(#self._rightContentList)
			self._rightHeroLoopGridView:RefreshAllShownItem()
		end
	elseif self._rightScrollType == M.ScrollType.Text then
		goutil.setActive(self._rightTxtScrollRectGo, true)
		goutil.setActive(self._rightHeroScrollRectGo, false)
		goutil.setActive(self._rightHeroEmptyGo, false)
		self._rightTxtLoopGridView:SetListItemCount(#self._rightContentList)
		self._rightTxtLoopGridView:RefreshAllShownItem()
	end
end

function M:_updateLeftCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._leftLoopGridView:NewListViewItem("timeItemL")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkTextItem)
	local content = self._leftContentList[curIndex]

	itemView:setContentAndIndex(content, curIndex)
	itemView:setSeleted(curIndex == self._leftIndex)
	itemView:setClickCallBack(self._onSelectType, self)

	return item
end

function M:_updateRightTxtCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._rightTxtLoopGridView:NewListViewItem("timeItemR")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkTextItem)
	local content = self._rightContentList[curIndex]

	itemView:setContentAndIndex(content, curIndex)
	itemView:setSeleted(curIndex == self._rightIndex)
	itemView:setClickCallBack(self._onSelectRightContent, self)

	return item
end

function M:_updateRightHeroCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._rightHeroLoopGridView:NewListViewItem("hero_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirHeroItem)
	local content = self._rightContentList[curIndex]

	itemView:setHeroMO(content)
	itemView:setIdx(curIndex)
	itemView:setSeleted(curIndex == self._rightIndex)
	itemView:setClickCallBack(self._onSelectRightContent, self)

	return item
end

function M:_updateFullStr()
	if self._rightIndex <= 0 then
		self._handler:setDescStr("")

		return
	end

	local co = self._conditionCOList[self._leftIndex]
	local rightContent = self._rightContentList[self._rightIndex]
	local str = ""

	if rightContent then
		if self._rightScrollType == M.ScrollType.Hero then
			str = string.format(co.descStr, rightContent:getName())
		elseif self._rightScrollType == M.ScrollType.Text then
			str = string.format(co.descStr, rightContent)
		end
	end

	self._handler:setDescStr(str)
end

function M:_onSelectType(idx)
	if self._leftIndex == idx then
		return
	end

	self._leftIndex = idx
	self._rightIndex = -1

	self._leftLoopGridView:RefreshAllShownItem()
	self:_initRightScroll()

	if #self._rightContentList > 0 then
		self._rightIndex = 1
	end

	self:_refreshRightScroll()
	self:_updateFullStr()
end

function M:_onSelectRightContent(idx)
	self._rightIndex = idx

	if self._rightScrollType == M.ScrollType.Hero then
		self._rightHeroLoopGridView:RefreshAllShownItem()
	elseif self._rightScrollType == M.ScrollType.Text then
		self._rightTxtLoopGridView:RefreshAllShownItem()
	end

	self:_updateFullStr()
end

function M:_onClickSave()
	if self._rightIndex <= 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_condition_select"))

		return
	end

	local condition = self._conditionCOList[self._leftIndex].id
	local params

	if self._rightScrollType == M.ScrollType.Hero then
		local heroMO = self._rightContentList[self._rightIndex]

		params = heroMO:getId()
	else
		params = self._rightContentList[self._rightIndex]
	end

	self._handler:onClickSave(condition, params)
end

function M:_onClickReset()
	self:setSelectCondition(self._originalCondition, self._originalParams)
end

function M:destroyUI()
	self._btnSave:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._leftLoopGridView:ClearCells()
	self._rightHeroLoopGridView:ClearCells()
	self._rightTxtLoopGridView:ClearCells()
	goutil.destroy(self.mainGO)
end

return M
