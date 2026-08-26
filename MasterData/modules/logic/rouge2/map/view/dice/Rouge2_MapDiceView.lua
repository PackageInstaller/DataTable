-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceView", package.seeall)

local Rouge2_MapDiceView = class("Rouge2_MapDiceView", BaseView)

function Rouge2_MapDiceView:onInitView()
	self._imageRateAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Rate/#image_Attribute")
	self._txtRate = gohelper.findChildText(self.viewGO, "root/#go_Info/Rate/#txt_Rate")
	self._goFixList = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#scroll_FixList/Viewport/#go_FixList")
	self._goFixItem = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#scroll_FixList/Viewport/#go_FixList/#go_FixItem")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Tips")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Target")
	self._goDice = gohelper.findChild(self.viewGO, "root/#go_Dice")
	self._goDiceItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_DiceItem")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Click")
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Jump")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._goResult = gohelper.findChild(self.viewGO, "root/#go_Result")
	self._goFailure = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Failure")
	self._goSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Succeed")
	self._goBigSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_BigSucceed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
end

function Rouge2_MapDiceView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_MapDiceView:_btnCloseOnClick()
	self.viewContainer:endAttrCheck()
end

function Rouge2_MapDiceView:_editableInitView()
	gohelper.setActive(self._goResult, false)
	gohelper.setActive(self._goFailure, false)
	gohelper.setActive(self._goSucceed, false)
	gohelper.setActive(self._goBigSucceed, false)
	gohelper.setActive(self._goDiceItem, false)
	gohelper.setActive(self._goFixItem, false)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, false)
	gohelper.setActive(self._btnClick.gameObject, true)

	self._fixItemTab = self:getUserDataTb_()

	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc, self)
end

function Rouge2_MapDiceView:onUpdateParam()
	self:refresh(self.viewParam and self.viewParam.checkResInfo)
end

function Rouge2_MapDiceView:onOpen()
	self:refresh(self.viewParam and self.viewParam.checkResInfo)
end

function Rouge2_MapDiceView:refresh(checkResInfo)
	self:refreshInfo(checkResInfo)
	self:refreshTitle()
	self:refreshFixUI()
end

function Rouge2_MapDiceView:refreshInfo(checkResInfo)
	self._checkResInfo = checkResInfo
	self._checkCo = self._checkResInfo and self._checkResInfo:getCheckConfig()
	self._checkId = self._checkResInfo and self._checkResInfo:getCheckId()
	self._checkDiceRes = self._checkResInfo and self._checkResInfo:getCheckDiceRes()
	self._checkRes = self._checkResInfo and self._checkResInfo:getCheckRes()
	self._resRate = self._checkResInfo and self._checkResInfo:getResRate() or 0
	self._fixValue = self._checkResInfo and self._checkResInfo:getFixValue() or 0
	self._itemCheckResList = self._checkResInfo and self._checkResInfo:getItemCheckResList() or {}
	self._attributeId = self._checkCo and self._checkCo.attrType
	self._attributeCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attributeId)
	self._isSucceed = self._checkRes ~= Rouge2_MapEnum.AttrCheckResult.Failure
	self._reRollTimes = self._checkResInfo and self._checkResInfo:getCheckReRollTimes()
end

function Rouge2_MapDiceView:refreshTitle()
	local targetCheckCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.Succeed)
	local targetPointRange = targetCheckCo and string.splitToNumber(targetCheckCo.checkPoint, "#")

	if targetPointRange then
		if not targetPointRange[1] then
			local targetCheckPoint = 0

			self._txtTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_target"), targetCheckPoint)

			local exCheckCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.BigSucceed)
			local exPointRange = exCheckCo and string.splitToNumber(exCheckCo.checkPoint, "#")

			if exPointRange then
				if not exPointRange[1] then
					local exCheckPoint = 0

					self._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_tips"), exCheckPoint)
				end
			end
		end
	end
end

function Rouge2_MapDiceView:refreshFixUI()
	self._txtRate.text = Rouge2_MapAttrCheckHelper.formatCheckRate(self._resRate)

	Rouge2_IconHelper.setAttributeIcon(self._attributeId, self._imageRateAttribute, Rouge2_Enum.AttrIconSuffix.Tag)

	self._fixInfoList, self._totalFixValue = self:_buildFixInfoList()

	local useFixItemMap = {}

	for index, fixInfo in ipairs(self._fixInfoList) do
		local fixItem = self:_getOrCreateFixItem(index)

		fixItem:onUpdateMO(fixInfo, index)

		useFixItemMap[fixItem] = true
	end

	for _, fixItem in pairs(self._fixItemTab) do
		if not useFixItemMap[fixItem] then
			fixItem:setVisible(false)
		end
	end
end

function Rouge2_MapDiceView:_buildFixInfoList()
	local totalFixValue = self._fixValue
	local fixInfoList = {}

	table.insert(fixInfoList, {
		fixType = Rouge2_MapEnum.DiceFixType.Attr,
		fixValue = self._fixValue,
		fixAttrId = self._attributeId
	})

	if self._itemCheckResList then
		for _, itemInfo in ipairs(self._itemCheckResList) do
			totalFixValue = totalFixValue + itemInfo[2]

			local fixInfo = {
				fixType = Rouge2_MapEnum.DiceFixType.Item,
				fixValue = itemInfo[2],
				fixAttrId = itemInfo[1]
			}

			table.insert(fixInfoList, fixInfo)
		end
	end

	table.sort(fixInfoList, self._fixInfoSortFunc)

	return fixInfoList, totalFixValue
end

function Rouge2_MapDiceView._fixInfoSortFunc(aFixInfo, bFixInfo)
	local aFixType = aFixInfo.fixType
	local bFixType = bFixInfo.fixType

	if aFixType ~= bFixType then
		return aFixType < bFixType
	end

	if not aFixInfo.fixValue then
		local aValue = 0

		if not bFixInfo.fixValue then
			local bValue = 0

			if aValue ~= bValue then
				return bValue < aValue
			end

			return aFixInfo.fixAttrId < bFixInfo.fixAttrId
		end
	end
end

function Rouge2_MapDiceView:_getOrCreateFixItem(index)
	local fixItem = self._fixItemTab[index]

	if not fixItem then
		local go = gohelper.cloneInPlace(self._goFixItem, index)

		fixItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapDiceFixItem)
		self._fixItemTab[index] = fixItem
	end

	return fixItem
end

function Rouge2_MapDiceView:getFixItemList()
	return self._fixItemTab
end

function Rouge2_MapDiceView:getTotalFixValue()
	return self._totalFixValue
end

function Rouge2_MapDiceView:_onUpdateMapInfo()
	local isAttrCheck = Rouge2_MapAttrCheckHelper.isAttrCheckInteract()

	if not isAttrCheck then
		return
	end

	local checkResInfo = Rouge2_MapAttrCheckHelper.buildCurCheckResInfoMO()

	self:refresh(checkResInfo)
end

function Rouge2_MapDiceView:getCheckResInfo()
	return self._checkResInfo
end

function Rouge2_MapDiceView:onClose()
	return
end

function Rouge2_MapDiceView:onDestroyView()
	return
end

return Rouge2_MapDiceView
