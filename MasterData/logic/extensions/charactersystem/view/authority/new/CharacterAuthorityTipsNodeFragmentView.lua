-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityTipsNodeFragmentView.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityTipsNodeFragmentView", package.seeall)

local M = class("CharacterAuthorityTipsNodeFragmentView", StaticFragmentView)

function M:buildUI()
	local registry = self._registry
	local mainGO = registry:getMainGO()

	self._txtTitle = registry:findUIElement("authority_main_panel_copy_-2038736721", UIComponentType.Text)
	self._goTxtContentRoot = registry:findUIElement("authority_main_panel_copy_-1919662785", UIComponentType.RectTransform)
	self._scroll = registry:findUIElement("authority_main_panel_copy_-1906291943", UIComponentType.ScrollRect)
	self._skillTipsBindGo = registry:findUIElement("authority_main_panel_copy_-98115819")
	self._skillContent = registry:findUIElement("authority_main_panel_copy_918099080")
	self._txtSkillName = registry:findUIElement("authority_main_panel_copy_1375968491", UIComponentType.Text)
	self._goSkillUpgradeMark = registry:findUIElement("authority_main_panel_copy_1948569729")
	self._imgSkillIcon = registry:findUIElement("authority_main_panel_copy_-303016640", UIComponentType.Image)
	self._btnSkill = UIComponentType.ButtonAdapter(registry:findUIElement("authority_main_panel_copy_-1867269345"))
	self._goSkillNodeLvIndexRoot = registry:findUIElement("authority_main_panel_copy_-1394923131")
	self._imgSkillNodeLv = registry:findUIElement("authority_main_panel_copy_343332669", UIComponentType.Image)
	self._txtSkillNodeIndex = registry:findUIElement("authority_main_panel_copy_707709679", UIComponentType.Text)
	self._txtSkillDesc = registry:findUIElement("authority_main_panel_copy_-1365301819", UIComponentType.TextMeshProUGUI)
	self._btnSkillDesc = UIComponentType.ButtonAdapter(registry:findUIElement("authority_main_panel_copy_265289476"))
	self._goChange = goutil.findChild(mainGO, "tipsPanel/panel1/scroll/mask/content/objChange")
	self._btnChange = UIComponentType.ButtonAdapter(goutil.findChild(self._goChange, "btnClick"))
	self._cellCosts = {}
	self._goToBeUnlock = registry:findUIElement("authority_main_panel_copy_926591468")

	for i = 0, self._goToBeUnlock.transform.childCount - 1 do
		table.insert(self._cellCosts, self:_buildCostItemCell(self._goToBeUnlock.transform:GetChild(i).gameObject))
	end

	self._btnUnlock = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "tipsPanel/panel1/btnUnlock"))
	self._goUnlockPriceRoot = goutil.findChild(mainGO, "tipsPanel/panel1/com_price_mul").gameObject
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(goutil.findChild(self._goUnlockPriceRoot, "com_price").gameObject)
	self._goCanUnlockRedPoint = goutil.findChild(self._btnUnlock.gameObject, "goRedPoint").gameObject
	self._txtUnlockDesc = registry:findUIElement("authority_main_panel_copy_-1348281456", UIComponentType.Text)

	local btn_skill_bonusGo = goutil.findChild(mainGO, "tipsPanel/panel1/com_price_mul/btn_skill_bonus")

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, false)
	goutil.setActive(self._btnSkillDown.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type7))
end

function M:destroyUI()
	for _, cell in pairs(self._cellCosts) do
		cell.btnClick:RemoveClickListener()
	end

	if self._videoMgr then
		self._videoMgr:DestroyMovie()
	end

	self._cellCosts = nil
	self._txtTitle = nil
	self._goTxtContentRoot = nil
	self._skillContent = nil
	self._txtSkillName = nil
	self._imgSkillIcon = nil
	self._btnSkill = nil
	self._imgSkillNodeLv = nil
	self._txtSkillNodeIndex = nil
	self._txtSkillDesc = nil
	self._btnChange = nil
	self._goToBeUnlock = nil
	self._btnUnlock = nil
	self._txtUnlockPrice = nil
	self._txtUnlockDesc = nil
	self._heroData = nil
	self._maxPowerLevel = nil
	self._maxNodeId = nil
	self._costCell = nil
end

function M:bindEvents()
	self._btnSkill:AddClickListener(self._onClickNodeSkill, self)
	self._btnChange:AddClickListener(self._onClickNodeSkillGuideShow, self)
	self._btnUnlock:AddClickListener(self._onClickNodeUnlock, self)
	self._btnSkillDesc:AddClickListener(self._onClickSkillDesc, self)
	self._btnSkillDown:AddClickListener(self._onOpenSkillSmallTips, self)
end

function M:unbindEvents()
	self._btnSkill:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnSkillDesc:RemoveClickListener()
	self._btnSkillDown:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	self:setScrollToOrgPos()
	self._costCell:updateData(CommEnum.CurrencyCodeEnum.LzbCode)
end

function M:onExit()
	self._isEnter = false

	removetimer(self._setScrollOrg, self)
end

function M:setHeroData(heroData, maxPowerLv)
	self._heroData = heroData
	self._maxPowerLevel = maxPowerLv
	self._maxNodeId = maxPowerLv * 5
end

function M:refreshCostCount()
	if not self._isEnter then
		return
	end

	for _, costCell in pairs(self._cellCosts or {}) do
		if costCell and costCell.go and not goutil.isNil(costCell.go) then
			costCell.updateCount()
		end
	end
end

function M:setScrollToOrgPos()
	self._scroll.verticalNormalizedPosition = 0
end

function M:refreshPanel(nodeLv, nodeIndexInLv, nodeId)
	self._nodeLv = nodeLv
	self._nodeIndexInLv = nodeIndexInLv
	self._nodeId = nodeId

	if not self._nodeLv or not self._nodeId then
		return
	end

	if not self._heroData then
		return
	end

	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)

	if not mo then
		printError(string.format("角色[%s]没有，亲和度%s-%s(%s),的数据", heroId, CommEnum.Num2RomeNum[self._nodeLv], self._nodeId, self._nodeId))
		goutil.setActive(self._btnUnlock.gameObject, false)
		goutil.setActive(self._goToBeUnlock, false)
		goutil.setActive(self._skillContent, false)

		self._txtTitle.text = ""

		for i = 0, self._goTxtContentRoot.childCount - 1 do
			local go = self._goTxtContentRoot:GetChild(i).gameObject

			goutil.setActive(go, false)
		end

		return
	end

	local co = mo:getConfig()
	local nextUnlockNodeId, isAllNormalUnlock = CharacterAuthorityModel.instance:getNextBeUnlockIndex(heroId)
	local isNormalNode = self._nodeId <= 20
	local isUnlock = mo:getIsUnlock()
	local toBeUnlock = isNormalNode and not isUnlock and self._nodeId == nextUnlockNodeId or not isUnlock and isAllNormalUnlock
	local hasGuidevideo = co.videoName ~= ""

	goutil.setActive(self._goChange, hasGuidevideo)

	self._txtTitle.text = co.name

	local detailTextLst = mo:getNodeDetailTextLst()

	while self._goTxtContentRoot.childCount < #detailTextLst + 1 do
		goutil.cloneAndSetParent(self._goTxtContentRoot:GetChild(1).gameObject, self._goTxtContentRoot)
	end

	for i = 1, self._goTxtContentRoot.childCount - 1 do
		local go = self._goTxtContentRoot:GetChild(i).gameObject
		local show = i <= #detailTextLst

		if show then
			local txtName = goutil.findChildTextComponent(go, "Text1")
			local txtValue = goutil.findChildTextComponent(go, "Text2")

			txtName.text = detailTextLst[i].name
			txtValue.text = detailTextLst[i].val
		end

		goutil.setActive(go, show)
	end

	goutil.setActive(self._goTxtContentRoot.gameObject, #detailTextLst > 0)

	local detailSkillLst = mo:getNodeDetailSkillLst()

	if Astral.OSDef.isEditor then
		printWarn(string.format("角色[%s] 节点[%s] 技能数量[%s](addSkill:%s, 强化技能归属id:%s)", heroId, self._nodeId, #detailSkillLst, mo:getAddSkillId(), mo:getSkillId() or "nil"), debug.traceback())
	end

	if #detailSkillLst > 0 then
		local addSkill = mo:getAddSkillId()
		local skillEnhanceSkill = mo:getSkillId()
		local skillData = detailSkillLst[1]

		self._txtSkillName.text = skillData.name
		self._txtSkillDesc.text = skillData.desc

		goutil.setActive(self._goSkillUpgradeMark, skillEnhanceSkill)
		goutil.setActive(self._goSkillNodeLvIndexRoot, skillEnhanceSkill)

		if skillEnhanceSkill then
			IconLoader.setSprite(self._imgSkillNodeLv, IconType.DynSpriteAtlas_CharacterSystem_Authority, GameUrl.getAuthorityLevelNum(self._nodeLv))

			self._txtSkillNodeIndex.text = self._nodeIndexInLv
		end

		IconLoader.setSprite(self._imgSkillIcon, IconType.SkillIcon, skillData.icon)
	end

	goutil.setActive(self._skillContent, #detailSkillLst > 0)

	local moneyCost = 0
	local lzbEnough = true
	local itemEnough = true
	local showUnlockItemCost = not isUnlock

	goutil.setActive(self._btnUnlock.gameObject, toBeUnlock)
	goutil.setActive(self._goToBeUnlock, showUnlockItemCost)

	if showUnlockItemCost then
		local itemCostLst = {}

		for _, _val in ipairs(co.cost or {}) do
			if _val.id == CommEnum.CurrencyCodeEnum.LzbCode then
				moneyCost = moneyCost + _val.num
			else
				table.insert(itemCostLst, _val)
			end
		end

		for index, costCell in ipairs(self._cellCosts) do
			if itemCostLst[index] then
				costCell.updateData(itemCostLst[index])

				if ItemModel.instance:getItemCountByItemId(itemCostLst[index].id) < itemCostLst[index].num then
					itemEnough = false
				end
			end

			goutil.setActive(costCell.go, itemCostLst[index])
		end
	end

	if toBeUnlock then
		moneyCost = math.floor(moneyCost * (1 - PlayerInfoFacade.instance:getAchievementSkillProfit(CommEnum.CharacterSkillType.Type7)))

		local goldNum = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.LzbCode)

		lzbEnough = moneyCost <= goldNum

		local costStr = lzbEnough and moneyCost or string.format("<color=#ff3e48>%s</color>", moneyCost)

		self._costCell:setCostCount(costStr)
		goutil.setActive(self._goCanUnlockRedPoint, lzbEnough and itemEnough)
	end

	goutil.setActive(self._goUnlockPriceRoot, toBeUnlock and moneyCost > 0)
	goutil.setActive(self._txtUnlockDesc.gameObject, not toBeUnlock)

	local unlockDesc

	if isUnlock then
		unlockDesc = lang("tip_authority_node_unlock")
	else
		unlockDesc = self._nodeId <= 21 and lang("tip_authority_prenode_require") or lang("tip_authority_extra_node_require")
	end

	self._txtUnlockDesc.text = unlockDesc

	if hasGuidevideo then
		if not self._videoMgr then
			local videoGo = goutil.findChild(self._goChange, "video")

			self._videoMgr = CriWareVideoMgr.Get(videoGo)
		end

		local fullVideoPath = GameUrl.getVideoUrl(co.videoName)

		self._videoMgr:PlayForSeek(fullVideoPath, 0, true, true)
		self._videoMgr:SetVolume(0, true)
	end

	removetimer(self._setScrollOrg, self)
	settimer(0, self._setScrollOrg, self, false)
end

function M:_setScrollOrg()
	local needScroll = RectTransformUtils.GetHeight(self._scroll.content) > RectTransformUtils.GetHeight(self._scroll.transform)

	self:setScrollToOrgPos()

	self._scroll.enabled = needScroll
end

function M:checkCostEnough()
	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)
	local cost = mo:getConfig().cost
	local itemEnough = true
	local lzbEnough = true

	if cost then
		for i = 1, #cost do
			local curNum = ItemModel.instance:getItemCountByItemId(cost[i].id)
			local costNum = cost[i].num

			if cost[i].id == GameEnum.CurrencyCodeEnum.LzbCode then
				costNum = math.floor(cost[i].num * (1 - PlayerInfoFacade.instance:getAchievementSkillProfit(CommEnum.CharacterSkillType.Type7)))
			end

			if curNum < costNum then
				if cost[i].id == GameEnum.CurrencyCodeEnum.LzbCode then
					lzbEnough = false
				else
					itemEnough = false
				end
			end
		end

		return itemEnough, lzbEnough
	else
		return true, true
	end
end

function M:_onClickNodeSkill()
	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)
	local skillId = mo:getAddSkillId() > 0 and mo:getAddSkillId() or mo:getSkillId()

	if not skillId or skillId <= 0 then
		return
	end

	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = heroId
	skillInfo.skillId = skillId
	skillInfo.defaultShowAll = false
	skillInfo.hangGO = self._skillTipsBindGo

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:_onClickNodeSkillUpgradeShow()
	local heroData = self._heroData
	local heroId = heroData:getId()

	printWarn(string.format("技能提升详情 nodeLv[%s] Id[%s] Index[%s]", self._nodeLv, self._nodeId, self._nodeIndexInLv))
end

function M:_onClickNodeSkillGuideShow()
	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)
	local co = mo:getConfig()

	ViewMgr.instance:open(ViewName.ImageGuide, {
		0,
		6,
		{
			co.videoName,
			"1",
			"解锁特殊异能演出"
		}
	})
end

function M:_onClickNodeUnlock()
	printWarn(string.format("解锁 nodeLv[%s] Id[%s] Index[%s]", self._nodeLv, self._nodeId, self._nodeIndexInLv))

	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)

	if not mo or mo:getIsUnlock() then
		return
	end

	local itemEnough, lzbEnough = self:checkCostEnough()

	if not lzbEnough then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if not itemEnough then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local co = mo:getConfig()

	if co.type == CommEnum.AuthorityNodeType.Extra then
		CharacterAuthorityModel.instance:setUnLockNodeIndex(self._nodeId)
		HeroPowerAgent.instance:sendHeroExtNodeActRequest(heroId, co.code)
	else
		CharacterAuthorityModel.instance:setUnLockNodeIndex(self._nodeId)

		if self._nodeId <= 20 then
			CharacterAuthorityModel.instance:setRunLineEffect(true)
		end

		HeroPowerAgent.instance:sendHeroNodeActRequest(heroId, co.code)
	end
end

function M:_onClickSkillDesc()
	local heroData = self._heroData
	local heroId = heroData:getId()
	local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, self._nodeId)
	local addSkillId = mo:getAddSkillId()

	if addSkillId and addSkillId > 0 then
		local skillEnhanceMO = SkillEnhanceMO.getSharedMO(addSkillId)

		if skillEnhanceMO then
			skillEnhanceMO:rebuild()

			local bindGo = self._btnSkillDesc.gameObject
			local isPassEvent = true

			ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
		end
	end
end

function M:_buildCostItemCell(go)
	local cell = {}

	cell.go = go
	cell.imgQuality = goutil.findChildImageComponent(go, "imgQuality")
	cell.imgIcon = goutil.findChildImageComponent(go, "imgIcon")
	cell.txtCount = goutil.findChildTextComponent(go, "txtDown")
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

	function cell.updateCount()
		local countStr
		local itemId = cell.getItemId()
		local itemCount = cell.getItemCount()

		if itemId and itemId > 0 then
			local curNum = ItemModel.instance:getItemCountByItemId(itemId)

			countStr = itemCount <= curNum and string.format("%s/%d", MathUtil.getCoinValue(curNum), itemCount) or string.format("<color=#ca3535>%s</color>/%d", MathUtil.getCoinValue(curNum), itemCount)

			local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

			if itemCo then
				IconLoader.setSprite(cell.imgIcon, IconType.ItemIcon, itemCo.icon)
				IconLoader.setSprite(cell.imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[itemCo.quality])
			end
		end

		cell.txtCount.text = countStr
	end

	function cell.updateData(data)
		cell.itemId = data and data.id or 0
		cell.itemCount = data and data.num or 0

		cell.updateCount()
	end

	function cell.getItemId()
		return cell.itemId
	end

	function cell.getItemCount()
		return cell.itemCount
	end

	cell.btnClick:AddClickListener(function()
		self:_onCostItemClick(cell.go, cell.getItemId(), cell.getItemCount())
	end, self)

	return cell
end

function M:_onCostItemClick(itemGo, itemId, itemCount)
	local count = ItemModel.instance:getItemCountByItemId(itemId)
	local itemData = ItemData.New({
		count = count,
		itemId = itemId
	})
	local needCount = itemCount and itemCount - count
	local data = ToolTipsUtil.createItemTipsData(itemData, itemGo, _, needCount)

	data.isPassEvent = false

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillDown.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type7

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M
