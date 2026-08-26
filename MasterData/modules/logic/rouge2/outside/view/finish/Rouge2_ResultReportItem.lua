-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultReportItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultReportItem", package.seeall)

local Rouge2_ResultReportItem = class("Rouge2_ResultReportItem", ListScrollCellExtend)

function Rouge2_ResultReportItem:onInitView()
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._godifficulty = gohelper.findChild(self.viewGO, "#go_difficulty")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "#go_difficulty/#txt_difficulty")
	self._gofaction = gohelper.findChild(self.viewGO, "#go_faction")
	self._gosuccessbg = gohelper.findChild(self.viewGO, "#go_faction/image_NameBG/#go_successbg")
	self._gofailbg = gohelper.findChild(self.viewGO, "#go_faction/image_NameBG/#go_failbg")
	self._txtTypeName = gohelper.findChildText(self.viewGO, "#go_faction/image_NameBG/#txt_TypeName")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_faction/base/#go_baseitem")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_faction/base/#go_baseitem/#image_Icon")
	self._txtValue = gohelper.findChildText(self.viewGO, "#go_faction/base/#go_baseitem/#txt_Value")
	self._goherogroup = gohelper.findChild(self.viewGO, "#go_herogroup")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item4")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_collection")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_collection/has/#image_collection")
	self._godec = gohelper.findChild(self.viewGO, "#go_dec")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_dec/#txt_dec")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultReportItem:addEvents()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function Rouge2_ResultReportItem:removeEvents()
	self._btndetails:RemoveClickListener()
end

function Rouge2_ResultReportItem:_btndetailsOnClick()
	local params = {
		reviewInfo = self.reviewInfo
	}

	Rouge2_OutsideController.instance:openRougeResultFinalView(params)
end

function Rouge2_ResultReportItem:_editableInitView()
	self._difficultyBgList = self:getUserDataTb_()

	local parentGo = gohelper.findChild(self.viewGO, "#go_difficulty/bg").transform
	local childCount = parentGo.childCount

	for i = 1, childCount do
		local childGo = parentGo:GetChild(i - 1).gameObject

		table.insert(self._difficultyBgList, childGo)
	end

	self._goDragEmpty = gohelper.findChild(self._gocollection, "empty")
	self._goDragHas = gohelper.findChild(self._gocollection, "has")
	self._heroItemParentGoList = self:getUserDataTb_()

	local heroItemParent = self._goherogroup.transform
	local heroChildCount = heroItemParent.childCount

	for i = 1, heroChildCount do
		local childGo = heroItemParent:GetChild(i - 1).gameObject

		table.insert(self._heroItemParentGoList, childGo)
	end

	self._heroItemList = {}
	self._goAttributeContent = gohelper.findChild(self.viewGO, "#go_faction/base")
	self._goFailBg2 = gohelper.findChild(self.viewGO, "bg/simage_fail")
	self._goSuccessBg2 = gohelper.findChild(self.viewGO, "bg/simage_success")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_ResultReportItem:_editableAddEvents()
	return
end

function Rouge2_ResultReportItem:_editableRemoveEvents()
	return
end

function Rouge2_ResultReportItem:onUpdateMO(mo)
	self.mo = mo
	self.reviewInfo = mo.info

	self:refreshUI()
end

function Rouge2_ResultReportItem:refreshUI()
	self:refreshBaseInfo()
	self:refreshAttributeInfo()
	self:refreshHeroInfo()
	self:refreshDragInfo()
end

function Rouge2_ResultReportItem:getAnimator()
	return self._animator
end

Rouge2_ResultReportItem.MaxShowHeroCount = 4

function Rouge2_ResultReportItem:refreshHeroInfo()
	local heroInfoList = self.reviewInfo:getHeroIdList()

	for i = 1, Rouge2_ResultReportItem.MaxShowHeroCount do
		local info = heroInfoList[i]
		local item = self:_getHeroItem(i)

		self:setHeroInfo(item, info)
		gohelper.setActive(item.go, true)
	end
end

function Rouge2_ResultReportItem:_getHeroItem(index)
	local item

	if not self._heroItemList[index] then
		item = self:_createHeroItem(index)

		table.insert(self._heroItemList, item)
	else
		item = self._heroItemList[index]
	end

	return item
end

function Rouge2_ResultReportItem:setHeroInfo(item, heroId)
	local showHero = heroId ~= nil

	gohelper.setActive(item.simagerolehead, showHero)
	gohelper.setActive(item.frame, showHero)
	gohelper.setActive(item.empty, not showHero)

	if showHero then
		local skinCfg
		local heroMO = HeroModel.instance:getByHeroId(heroId)

		if heroMO then
			skinCfg = HeroModel.instance:getCurrentSkinConfig(heroId)
		else
			local heroCfg = HeroConfig.instance:getHeroCO(heroId)
			local skinId = heroCfg and heroCfg.skinId

			skinCfg = SkinConfig.instance:getSkinCo(skinId)
		end

		local heroIcon = skinCfg and skinCfg.headIcon

		item.simagerolehead:LoadImage(ResUrl.getHeadIconSmall(heroIcon))
	end
end

function Rouge2_ResultReportItem:_createHeroItem(index)
	local url = self._view.viewContainer._viewSetting.otherRes[2]
	local parentGo = self._heroItemParentGoList[index]
	local go = self._view:getResInst(url, parentGo)
	local item = self:getUserDataTb_()

	item.go = go
	item.simagerolehead = gohelper.findChildSingleImage(go, "#go_heroitem/#image_rolehead")
	item.frame = gohelper.findChild(go, "#go_heroitem/frame")
	item.empty = gohelper.findChild(go, "#go_heroitem/empty")

	return item
end

function Rouge2_ResultReportItem:refreshDragInfo()
	local haveDrag = self.reviewInfo.drugId ~= nil and self.reviewInfo.drugId ~= 0

	gohelper.setActive(self._goDragHas, haveDrag)
	gohelper.setActive(self._goDragEmpty, not haveDrag)

	if not haveDrag then
		return
	end

	Rouge2_IconHelper.setFormulaIcon(self.reviewInfo.drugId, self._simagecollection)
end

function Rouge2_ResultReportItem:refreshAttributeInfo()
	local attributeList = self.reviewInfo.leaderAttrInfo

	gohelper.CreateObjList(self, self.onAttributeShow, attributeList, self._goAttributeContent, self._gobaseitem, Rouge2_ResultAttributeItem)
end

function Rouge2_ResultReportItem:onAttributeShow(item, data, index)
	item:setInfo(data)
end

function Rouge2_ResultReportItem:refreshBaseInfo()
	local info = self.reviewInfo
	local secondTime = math.floor(info.finishTime / TimeUtil.OneSecondMilliSecond)
	local finishTime = ServerTime.timeInLocal(secondTime)

	self._txttime.text = TimeUtil.timestampToString(finishTime)

	local difficultyConfig = Rouge2_Config.instance:getDifficultyCoById(info.difficulty)
	local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexDuration)
	local duration = tonumber(constConfig.value)
	local bgIndex = math.floor(difficultyConfig.difficulty / duration) + 1 or 1

	self._txtdifficulty.text = difficultyConfig.title

	for index, bg in ipairs(self._difficultyBgList) do
		gohelper.setActive(bg, index == bgIndex)
	end

	local desc = Rouge2_SettlementTriggerHelper.refreshEndingDesc(self.reviewInfo)
	local isSuccess = info:isSucceed()

	if isSuccess then
		if not Rouge2_OutsideEnum.EndDescColor.Success then
			local colorStr = Rouge2_OutsideEnum.EndDescColor.Fail

			self._txtdec.text = string.format("<color=%s>%s</color>", colorStr, desc)

			gohelper.setActive(self._gosuccessbg, isSuccess)
			gohelper.setActive(self._gofailbg, not isSuccess)
			gohelper.setActive(self._goSuccessBg2, isSuccess)
			gohelper.setActive(self._goFailBg2, not isSuccess)

			local isMainCareer = info.curCareer == info.mainCareer

			if isMainCareer then
				local config = Rouge2_CareerConfig.instance:getCareerConfig(info.mainCareer)

				self._txtTypeName.text = config.name
			else
				local config = Rouge2_CareerConfig.instance:getCareerConfig(info.mainCareer)

				self._txtTypeName.text = config.name
			end
		end
	end
end

function Rouge2_ResultReportItem:onSelect(isSelect)
	return
end

function Rouge2_ResultReportItem:onDestroyView()
	return
end

return Rouge2_ResultReportItem
