-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeMap.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeMap", package.seeall)

local Rouge2_CareerAttributeMap = class("Rouge2_CareerAttributeMap", LuaCompBase)

function Rouge2_CareerAttributeMap.Get(go, usage)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CareerAttributeMap, usage)
end

function Rouge2_CareerAttributeMap:ctor(usage)
	self._usage = usage
end

function Rouge2_CareerAttributeMap:init(go)
	self.go = go
	self._simageBG = gohelper.findChildSingleImage(self.go, "#simage_BG")
	self._goCareerSelect = gohelper.findChild(self.go, "#go_CareerSelect")
	self._simageArm = gohelper.findChildSingleImage(self.go, "#go_CareerSelect/simage_Arm")

	self:setCareerSelectVisible(false)
	self:initAttrItemList()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateTeamSystem, self._onUpdateTeamSystem, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectCareerAttribute, self._onSelectAttr, self)

	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function Rouge2_CareerAttributeMap:addEventListeners()
	return
end

function Rouge2_CareerAttributeMap:removeEventListeners()
	return
end

function Rouge2_CareerAttributeMap:setCareerSelectVisible(isVisible)
	self._isCareerSelectVisible = isVisible

	gohelper.setActive(self._goCareerSelect, isVisible)
end

function Rouge2_CareerAttributeMap:setBgVisible(isVisible)
	gohelper.setActive(self._simageBG, isVisible)
end

function Rouge2_CareerAttributeMap:initAttrItemList()
	self._attributeItemTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local gocareer = gohelper.findChild(self.go, "Career" .. i)

		if gohelper.isNil(gocareer) then
			break
		end

		local attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(gocareer, Rouge2_CareerAttributeItem)

		attributeItem:setUsage(self._usage)
		attributeItem:setTipsClickCallback(self._clickAttributeItemCallback, self)

		self._attributeItemTab[i] = attributeItem
	end

	if self._attributeItemTab then
		self._allAttributeItemNum = #self._attributeItemTab or 0
	end
end

function Rouge2_CareerAttributeMap:onUpdateMO(careerId, dataType, params)
	self._careerId = careerId
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	self._dataType = dataType
	self._params = params

	self:refresh()
end

function Rouge2_CareerAttributeMap:refresh()
	self:initAttrInfoList()
	self:refreshAttrItemList()
	self._simageBG:LoadImage(ResUrl.getRouge2Icon("backpack/" .. self._careerCo.attrMapBg))

	if self._isCareerSelectVisible then
		self._simageArm:LoadImage(ResUrl.getRouge2Icon("backpack/" .. self._careerCo.heroArmIcon))
	end
end

function Rouge2_CareerAttributeMap:initAttrInfoList()
	self._attributeList = {}

	local dataFunc = self:_dataType2GetDataFunc(self._dataType)

	if dataFunc then
		self._attributeList = dataFunc(self, self._careerId, self._params)
	end
end

function Rouge2_CareerAttributeMap:_dataType2GetDataFunc(dataType)
	if not self._getDataFuncMap then
		self._getDataFuncMap = {}
		self._getDataFuncMap[Rouge2_Enum.AttributeData.Config] = self._config2GetData
		self._getDataFuncMap[Rouge2_Enum.AttributeData.Server] = self._server2GetData
		self._getDataFuncMap[Rouge2_Enum.AttributeData.Custom] = self._custom2GetData
	end

	local func = self._getDataFuncMap[dataType]

	if not func then
		logError(string.format("肉鸽属性图缺少数据获取方法 dataType = %s", dataType))
	end

	return func
end

function Rouge2_CareerAttributeMap:_config2GetData(careerId, params)
	return Rouge2_CareerConfig.instance:getCareerInitialAttributeConfigAndValue(careerId)
end

function Rouge2_CareerAttributeMap:_server2GetData(careerId, params)
	return Rouge2_Model.instance:getHeroAttrInfoList()
end

function Rouge2_CareerAttributeMap:_custom2GetData(careerId, params)
	return params
end

function Rouge2_CareerAttributeMap:refreshAttrItemList()
	for index, attribute in ipairs(self._attributeList or {}) do
		local attributeItem = self._attributeItemTab[index]

		if attributeItem then
			attributeItem:onUpdateMO(self._careerId, attribute.attrId, attribute.value)
		else
			logError(string.format("肉鸽缺少属性ui index = %s, attributeId = %s", index, attribute.id))
		end
	end

	if self._attributeList then
		if not #self._attributeList then
			local useAttributeNum = 0

			for i = useAttributeNum + 1, self._allAttributeItemNum do
				self._attributeItemTab[i]:setUse(false)
			end
		end
	end
end

function Rouge2_CareerAttributeMap:selectAttribute(index)
	if self._attributeList then
		if self._attributeList then
			self:selectAttributeById(self._attributeList.attrId)
		end
	end
end

function Rouge2_CareerAttributeMap:selectAttributeById(attributeId)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectCareerAttribute, attributeId)
end

function Rouge2_CareerAttributeMap:_onSelectAttr(attrId)
	self._selectAttrId = attrId
end

function Rouge2_CareerAttributeMap:getCurSelectAttrId()
	return self._selectAttrId
end

function Rouge2_CareerAttributeMap:setCanClickDetail(isCan)
	if self._isCanClickDetail == isCan then
		return
	end

	self._isCanClickDetail = isCan

	for _, attributeItem in pairs(self._attributeItemTab) do
		attributeItem:setCanClickDetail(isCan)
	end
end

function Rouge2_CareerAttributeMap:_clickAttributeItemCallback(tipsView, clickPosition)
	for _, attributeItem in pairs(self._attributeItemTab) do
		local isInClick = attributeItem:isUse() and attributeItem:isInClickArea(clickPosition)

		if isInClick then
			attributeItem:_btnClickOnClick()

			return
		end
	end

	tipsView:closeThis()
end

function Rouge2_CareerAttributeMap:_onUpdateAttrInfo()
	self:refresh()
end

function Rouge2_CareerAttributeMap:_onUpdateTeamSystem()
	self:refresh()
end

function Rouge2_CareerAttributeMap:playAnim(animName)
	self.animator:Play(animName, 0, 0)
end

function Rouge2_CareerAttributeMap:onDestroy()
	self._simageBG:UnLoadImage()
	self._simageArm:UnLoadImage()
end

return Rouge2_CareerAttributeMap
