-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookGroupItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookGroupItem", package.seeall)

local Rouge2_CareerHandBookGroupItem = class("Rouge2_CareerHandBookGroupItem", LuaCompBase)

function Rouge2_CareerHandBookGroupItem:init(go)
	self.go = go
	self._gocareeritem = gohelper.findChild(self.go, "#go_careeritem")
	self._goitem1 = gohelper.findChild(self.go, "#go_item1")
	self._goline12 = gohelper.findChild(self.go, "#go_line_1_2")
	self._goitem2 = gohelper.findChild(self.go, "#go_item2")
	self._goline23 = gohelper.findChild(self.go, "#go_line_2_3")
	self._goitem3 = gohelper.findChild(self.go, "#go_item3")
	self._goline34 = gohelper.findChild(self.go, "#go_line_3_4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookGroupItem:_editableInitView()
	self._nodeItemGoList = self:getUserDataTb_()

	table.insert(self._nodeItemGoList, self._goitem1)
	table.insert(self._nodeItemGoList, self._goitem2)
	table.insert(self._nodeItemGoList, self._goitem3)

	self._nodeLineList = self:getUserDataTb_()

	table.insert(self._nodeLineList, self._goline12)
	table.insert(self._nodeLineList, self._goline23)
	table.insert(self._nodeLineList, self._goline34)

	self._nodeLineLightItem = self:getUserDataTb_()
	self._nodeLineLightItemAnimatorList = self:getUserDataTb_()

	for _, lineItem in ipairs(self._nodeLineList) do
		local lightLineItem = gohelper.findChildImage(lineItem, "light/light", gohelper.Type_Animator)

		table.insert(self._nodeLineLightItem, lightLineItem)

		local animator = gohelper.findChildComponent(lineItem, "light", gohelper.Type_Animator)

		table.insert(self._nodeLineLightItemAnimatorList, animator)
	end

	self._nodeItemList = {}

	gohelper.setActive(self._gocareeritem, false)

	self._goLight = gohelper.findChild(self.go, "#go_line_0_1/light")
end

function Rouge2_CareerHandBookGroupItem:addEventListeners()
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnDetailItemClickClose, self.onSelectHandBookTalent, self)
end

function Rouge2_CareerHandBookGroupItem:removeEventListeners()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnDetailItemClickClose, self.onSelectHandBookTalent, self)
end

function Rouge2_CareerHandBookGroupItem:onLevelUpAnimStart(param)
	local curLevel = param.curLevel
	local talentTypeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(self._mo.careerId, curLevel)

	for i, talentId in ipairs(self._mo.talentIdList) do
		if talentTypeConfig.geniusId == talentId then
			local animator = self._nodeLineLightItemAnimatorList[i]

			animator:Play("lightin", 0, 0)

			self._curAnimTalentId = talentId

			break
		end
	end
end

function Rouge2_CareerHandBookGroupItem:onLevelUpAnimFinish(careerId)
	for i, talentId in ipairs(self._mo.talentIdList) do
		if talentId == self._curAnimTalentId then
			local animator = self._nodeLineLightItemAnimatorList[i]

			animator:Play("light", 0, 0)

			break
		end
	end

	self._curAnimTalentId = nil
end

function Rouge2_CareerHandBookGroupItem:onSelectHandBookTalent(talentId)
	for i, _ in ipairs(self._mo.talentIdList) do
		local talentItem = self._nodeItemList[i]

		talentItem:setSelect(talentId)
	end
end

function Rouge2_CareerHandBookGroupItem:setInfo(mo)
	self._mo = mo

	self:refreshUI()
end

function Rouge2_CareerHandBookGroupItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_CareerHandBookGroupItem:refreshUI()
	gohelper.setActive(self._goLight, self._mo.groupId == 1)

	local talentCount = #self._mo.talentIdList

	if talentCount > Rouge2_OutsideEnum.CareerTalentGroupNodeCount then
		logError("Talent count over the limit")
	end

	for i, talentId in ipairs(self._mo.talentIdList) do
		local talentItem

		if not self._nodeItemList[i] then
			local talentNodeGo = gohelper.clone(self._gocareeritem, self._nodeItemGoList[i], tostring(i))

			talentItem = MonoHelper.addNoUpdateLuaComOnceToGo(talentNodeGo, Rouge2_CareerHandBookTalentNodeItem)

			table.insert(self._nodeItemList, talentItem)
		else
			talentItem = self._nodeItemList[i]
		end

		talentItem:setActive(true)

		local index = self._mo.indexList[i]

		talentItem:setInfo(index, talentId)
	end

	local itemCount = #self._nodeItemList

	if talentCount < itemCount then
		for i = talentCount + 1, itemCount do
			local groupItem = self._nodeItemList[i]

			groupItem:setActive(false)
		end
	end

	local lineCount = #self._nodeLineList
	local curExp = Rouge2_TalentModel.instance:getCareerExp(self._mo.careerId)

	for i = 1, lineCount do
		local lineGo = self._nodeLineList[i]
		local curTalentId = self._mo.talentIdList[i]
		local curTalentConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(curTalentId)
		local nextTalentConfig

		if curTalentConfig then
			nextTalentConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByOrder(curTalentConfig.talent, curTalentConfig.order + 1)
		end

		local displayLine = nextTalentConfig ~= nil

		gohelper.setActive(lineGo, displayLine)

		if displayLine then
			local lightImage = self._nodeLineLightItem[i]
			local isActiveCurrent = Rouge2_TalentModel.instance:isTalentActive(curTalentId)

			gohelper.setActive(lightImage.gameObject, isActiveCurrent)

			if isActiveCurrent then
				local isActiveNextNode = Rouge2_TalentModel.instance:isTalentActive(nextTalentConfig.geniusId)
				local progress = 1

				if not isActiveNextNode then
					local needExp = nextTalentConfig.careerExp - curTalentConfig.careerExp
					local curHaveExp = curExp - curTalentConfig.careerExp

					progress = curHaveExp > 0 and Mathf.Clamp(curHaveExp / needExp, 0, 1) or 0
				end

				lightImage.fillAmount = progress
			end
		end
	end
end

function Rouge2_CareerHandBookGroupItem:onDestroy()
	self._nodeItemGoList = nil
	self._nodeLineList = nil
end

return Rouge2_CareerHandBookGroupItem
