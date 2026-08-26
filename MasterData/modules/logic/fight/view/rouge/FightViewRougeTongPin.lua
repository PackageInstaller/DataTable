-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeTongPin.lua

module("modules.logic.fight.view.rouge.FightViewRougeTongPin", package.seeall)

local FightViewRougeTongPin = class("FightViewRougeTongPin", BaseViewExtended)

function FightViewRougeTongPin:onInitView()
	self._polarizationRoot = self.viewGO
	self._polarizationItem = gohelper.findChild(self.viewGO, "item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougeTongPin:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.PolarizationLevel, self._onPolarizationLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
end

function FightViewRougeTongPin:removeEvents()
	return
end

function FightViewRougeTongPin:_editableInitView()
	self.tongPingGoList = self:getUserDataTb_()

	table.insert(self.tongPingGoList, self._polarizationItem)
end

function FightViewRougeTongPin:onRefreshViewParam()
	return
end

function FightViewRougeTongPin:hideTongPinObj()
	gohelper.setActive(self._polarizationRoot, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeTongPin)
end

function FightViewRougeTongPin:showTongPinObj(count)
	gohelper.setActive(self._polarizationRoot, true)

	local itemSize = FightRightElementEnum.ElementsSizeDict[FightRightElementEnum.Elements.RougeTongPin]

	if count then
		if not (itemSize.y * count) then
			local height

			FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeTongPin, height)
		end
	end
end

function FightViewRougeTongPin:_onClothSkillRoundSequenceFinish()
	self:hideTongPinObj()
end

function FightViewRougeTongPin:_onRoundSequenceFinish()
	self:hideTongPinObj()
end

function FightViewRougeTongPin:_onPolarizationLevel()
	self:_refreshTongPin()
end

function FightViewRougeTongPin:onOpen()
	self:hideTongPinObj()
end

FightViewRougeTongPin.tempDataList = {}

function FightViewRougeTongPin:_refreshTongPin()
	self._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

	if self._polarizationDic then
		for k, v in pairs(self._polarizationDic) do
			if v.effectNum == 0 then
				self._polarizationDic[k] = nil
			end
		end
	end

	if self._polarizationDic then
		local showPolarization = tabletool.len(self._polarizationDic) > 0

		if showPolarization then
			local list = FightViewRougeTongPin.tempDataList

			tabletool.clear(list)

			for k, v in pairs(self._polarizationDic) do
				table.insert(list, v)
			end

			table.sort(list, self.sortPolarization)
			self:com_createObjList(self._onPolarizationItemShow, list, self._polarizationRoot, self._polarizationItem)
			self:showTongPinObj(#list)
		else
			self:hideTongPinObj()
		end
	end
end

function FightViewRougeTongPin.sortPolarization(item1, item2)
	return item1.configEffect < item2.configEffect
end

FightViewRougeTongPin.TempParam = {}

function FightViewRougeTongPin:_onPolarizationItemShow(obj, data, index)
	local config = lua_polarization.configDict[data.effectNum]

	config = config and lua_polarization.configDict[data.effectNum][data.configEffect]

	if not config then
		gohelper.setActive(obj, false)

		return
	end

	local nameText = gohelper.findChildText(obj, "bg/#txt_name")
	local levelText = gohelper.findChildText(obj, "bg/#txt_level")

	nameText.text = config and config.name

	local level = data.effectNum

	levelText.text = "Lv." .. level

	local click = gohelper.getClickWithDefaultAudio(gohelper.findChild(obj, "bg"))

	self:removeClickCb(click)

	local tab = FightViewRougeTongPin.TempParam

	tab.config = config
	tab.position = obj.transform.position

	self.addClickCb(self, click, self._onBtnPolarization, self, tab)

	for i = 1, 3 do
		local effectObj = gohelper.findChild(obj, "effect_lv/effect_lv" .. i)

		gohelper.setActive(effectObj, i == level)
	end

	if level > 3 then
		gohelper.setActive(gohelper.findChild(obj, "effect_lv/effect_lv3"), true)
	end
end

function FightViewRougeTongPin:_onBtnPolarization(config)
	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, config)
end

function FightViewRougeTongPin:onDestroyView()
	return
end

return FightViewRougeTongPin
