-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErOptionItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErOptionItem", package.seeall)

local MoLiDeErOptionItem = class("MoLiDeErOptionItem", LuaCompBase)

function MoLiDeErOptionItem:init(go)
	self.viewGO = go
	self._goBG1 = gohelper.findChild(self.viewGO, "#go_BG1")
	self._goBG2 = gohelper.findChild(self.viewGO, "#go_BG2")
	self._goBG3 = gohelper.findChild(self.viewGO, "#go_BG3")
	self._txtName = gohelper.findChildText(self.viewGO, "#txt_Name")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#txt_Descr")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Cost/#txt_Num")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.viewGO, "")
	self._goCost = gohelper.findChild(self.viewGO, "#go_Cost")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErOptionItem:addEventListeners()
	self._btnSelect:AddClickListener(self.onItemClick, self)
end

function MoLiDeErOptionItem:removeEventListeners()
	self._btnSelect:RemoveClickListener()
end

function MoLiDeErOptionItem:_editableInitView()
	return
end

function MoLiDeErOptionItem:setData(optionInfo)
	self.optionInfo = optionInfo
	self.optionId = optionInfo.optionId
	self.optionConfig = MoLiDeErConfig.instance:getOptionConfig(optionInfo.optionId)

	self:refreshUI()
end

function MoLiDeErOptionItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErOptionItem:onItemClick()
	local optionId = self.optionId

	if optionId == MoLiDeErGameModel.instance:getSelectOptionId() then
		return
	end

	if not self._canSelect then
		local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
		local eventId = MoLiDeErGameModel.instance:getSelectEventId()
		local itemCost = MoLiDeErHelper.getOptionItemCost(optionId)

		if itemCost and itemCost[1] then
			for _, data in ipairs(itemCost) do
				local itemId = data[3]
				local num = data[2]

				if itemId and num then
					local haveItem = gameInfoMo:getEquipInfo(itemId)

					if haveItem == nil or haveItem.quantity + num < 0 then
						GameFacade.showToast(ToastEnum.Act194EquipCountNotEnough)

						return
					end
				end
			end
		end

		local cost = MoLiDeErGameModel.instance:getExecutionCostById(eventId, optionId)

		if gameInfoMo:isAllActTimesNotMatch() then
			GameFacade.showToast(ToastEnum.Act194AllTeamActTimesNotMatch)

			return
		end

		if cost + gameInfoMo.leftRoundEnergy < 0 then
			GameFacade.showToast(ToastEnum.Act194ExecutionNotEnough)

			return
		end

		GameFacade.showToast(ToastEnum.Act194NotMatchConditionTeam)

		return
	end

	MoLiDeErGameModel.instance:setSelectOptionId(optionId)
end

function MoLiDeErOptionItem:refreshUI()
	local info = self.optionInfo
	local optionConfig = self.optionConfig

	self._txtName.text = optionConfig.name

	local haveSelected = info.isEverChosen
	local optionId = self.optionId

	if info.isChosable then
		local canSelect = MoLiDeErHelper.isOptionCanChose(optionId)

		self._canSelect = canSelect

		if haveSelected then
			if not optionConfig.optionDesc then
				local descStr = optionConfig.conditionDesc
				local teamId
				local selectOptionId = MoLiDeErGameModel.instance:getSelectOptionId()

				if selectOptionId == info.optionId then
					teamId = MoLiDeErGameModel.instance:getSelectTeamId()
				end

				local valueList = {}
				local restrictionParamList = MoLiDeErHelper.getOptionRestrictionParamList(optionConfig.optionId)

				tabletool.addValues(valueList, restrictionParamList)

				local optionEffectParamsList = MoLiDeErHelper.getOptionEffectParamList(optionConfig.optionId, teamId)

				tabletool.addValues(valueList, optionEffectParamsList)

				local optionResultEffectParamsList = MoLiDeErHelper.getOptionResultEffectParamList(optionConfig.optionResultId, teamId)

				tabletool.addValues(valueList, optionResultEffectParamsList)

				self._txtDescr.text = GameUtil.getSubPlaceholderLuaLang(descStr, valueList)

				gohelper.setActive(self._goBG1, canSelect)
				gohelper.setActive(self._goBG2, false)
				gohelper.setActive(self._goBG3, not canSelect)

				local eventId = MoLiDeErGameModel.instance:getSelectEventId()
				local cost = MoLiDeErGameModel.instance:getExecutionCostById(eventId, optionId, teamId)
				local showCost = cost ~= 0

				gohelper.setActive(self._goCost, showCost)

				if showCost then
					self._txtNum.text = tostring(cost)
				end

				local selectId = MoLiDeErGameModel.instance:getSelectOptionId()

				self:setSelect(selectId)
			end
		end
	end
end

function MoLiDeErOptionItem:setSelect(selectId)
	gohelper.setActive(self._goBG2, self.optionId == selectId)
end

function MoLiDeErOptionItem:onDestroy()
	return
end

return MoLiDeErOptionItem
