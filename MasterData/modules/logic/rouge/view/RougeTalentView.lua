-- chunkname: @modules/logic/rouge/view/RougeTalentView.lua

module("modules.logic.rouge.view.RougeTalentView", package.seeall)

local RougeTalentView = class("RougeTalentView", BaseView)

function RougeTalentView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTypeIcon = gohelper.findChildSingleImage(self.viewGO, "Left/Top/#simage_TypeIcon")
	self._txtType = gohelper.findChildText(self.viewGO, "Left/Top/#txt_Type")
	self._txtLv = gohelper.findChildText(self.viewGO, "Left/Top/#txt_Lv")
	self._txtNum = gohelper.findChildText(self.viewGO, "Left/Top/#txt_Num")
	self._imageslider = gohelper.findChildImage(self.viewGO, "Left/Top/Slider/#image_slider")
	self._txtDescr1 = gohelper.findChildText(self.viewGO, "Left/Skill/#scroll_des/viewport/content/#txt_Descr1")
	self._txtDescr2 = gohelper.findChildText(self.viewGO, "Left/Skill/#scroll_des/viewport/content/#txt_Descr2")
	self._godetail = gohelper.findChild(self.viewGO, "Left/Card/Layout/#go_detail")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "Left/Card/Layout/#go_detail/#image_skillicon")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "Left/Card/Layout/#go_detail/#txt_dec2")
	self._goskillitem = gohelper.findChild(self.viewGO, "Left/Card/Layout/#go_skillitem")
	self._scrollTree = gohelper.findChildScrollRect(self.viewGO, "Tree/#scroll_Tree")
	self._simageTypeIcon2 = gohelper.findChildSingleImage(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	self._goNormal = gohelper.findChild(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Normal")
	self._goSpecial = gohelper.findChild(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Special")
	self._goBranch = gohelper.findChild(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Branch")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentView:addEvents()
	return
end

function RougeTalentView:removeEvents()
	return
end

function RougeTalentView:_setBtnStatus(isSelected, normalGo, selectedGo)
	gohelper.setActive(normalGo, not isSelected)
	gohelper.setActive(selectedGo, isSelected)
end

function RougeTalentView:_editableInitView()
	self._imageTypeIcon = gohelper.findChildImage(self.viewGO, "Left/Top/#simage_TypeIcon")
	self._imageTypeIcon2 = gohelper.findChildImage(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	self._gocontent = gohelper.findChild(self.viewGO, "Tree/#scroll_Tree/Viewport/Branch")

	gohelper.setActive(self._godetail, false)

	self._skillItemList = self:getUserDataTb_()
end

function RougeTalentView:_initIcon()
	local style = self._rougeInfo.style
	local season = self._rougeInfo.season
	local styleCo = lua_rouge_style.configDict[season][style]
	local iconName = string.format("%s_light", styleCo.icon)

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageTypeIcon, iconName)
	UISpriteSetMgr.instance:setRouge2Sprite(self._imageTypeIcon2, iconName)
end

function RougeTalentView:onUpdateParam()
	return
end

function RougeTalentView:onOpen()
	self._season = RougeConfig1.instance:season()
	self._rougeInfo = RougeModel.instance:getRougeInfo()

	local styleId = RougeModel.instance:getStyle()

	self._styleConfig = RougeConfig1.instance:getStyleConfig(styleId)
	self._txtType.text = self._styleConfig.name
	self._txtLv.text = string.format("Lv.%s", self._rougeInfo.teamLevel)
	self._txtDescr1.text = self._styleConfig.passiveSkillDescs
	self._txtDescr2.text = self._styleConfig.passiveSkillDescs2

	self:_initLevel()

	self._nextLevel = math.min(self._rougeInfo.teamLevel + 1, self._maxLevelConfig.level)

	local nextLevelConfig = self._levelList[self._nextLevel]
	local exp = self._rougeInfo.teamExp

	self._txtNum.text = string.format("<color=#b67a45>%s</color>/%s", exp, nextLevelConfig.exp)
	self._imageslider.fillAmount = exp / nextLevelConfig.exp
	self._moveContent = true

	self:_initTalentList()
	self:_initSkill()
	self:_initIcon()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentInfo, self._onUpdateRougeTalentInfo, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
end

function RougeTalentView:_onTouchScreenUp()
	if self._showTips then
		self._showTips = false

		return
	end

	gohelper.setActive(self._godetail, false)
	self:_refreshAllBtnStatus()
end

function RougeTalentView:_initLevel()
	self._levelList = {}

	local list = lua_rouge_level.configDict[self._season]
	local level = 0

	for i, v in ipairs(list) do
		if level <= v.level then
			level = v.level
			self._maxLevelConfig = v
		end

		self._levelList[v.level] = v
	end
end

function RougeTalentView:_initTalentList()
	self._talentCompList = self:getUserDataTb_()
	self._groupMap = self:getUserDataTb_()

	local talentList = self._rougeInfo.talentInfo
	local costTalentPoint = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost)

	self._costTalentPoint = tonumber(costTalentPoint)

	local bigNodeString = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentBigNode)
	local bigNodeList = string.splitToNumber(bigNodeString, "#")
	local bigNodeMap = {}

	for i, v in ipairs(bigNodeList) do
		bigNodeMap[v] = true
	end

	local i = 1
	local prevGroupComp

	while i <= #talentList do
		local leftIndex = i
		local rightIndex = i + 1

		i = rightIndex + 1

		local layer = rightIndex / 2
		local leftInfo = talentList[leftIndex]
		local rightInfo = talentList[rightIndex]

		if not leftInfo or not rightInfo then
			return
		end

		local branchGo = gohelper.cloneInPlace(self._goBranch)

		gohelper.setActive(branchGo, true)

		local isSpecial = bigNodeMap[layer]

		if isSpecial then
			local go = gohelper.clone(self._goSpecial or self._goNormal, branchGo)

			gohelper.setActive(go, true)

			local animator = go:GetComponent(typeof(UnityEngine.Animator))
			local leftGo = gohelper.findChild(go, "Left")
			local rightGo = gohelper.findChild(go, "Right")
			local leftComp = MonoHelper.addNoUpdateLuaComOnceToGo(leftGo, RougeTalentItem)
			local rightComp = MonoHelper.addNoUpdateLuaComOnceToGo(rightGo, RougeTalentItem)

			table.insert(self._talentCompList, leftComp)
			table.insert(self._talentCompList, rightComp)

			self._groupMap[leftComp] = animator
			self._groupMap[rightComp] = animator

			leftComp:setSpecial(isSpecial)
			rightComp:setSpecial(isSpecial)
			leftComp:setInfo(self, leftIndex, leftInfo, rightComp, prevGroupComp)
			rightComp:setInfo(self, rightIndex, rightInfo, leftComp, prevGroupComp)

			prevGroupComp = {
				leftComp,
				rightComp
			}
		end
	end

	self:_onUpdateRougeTalentInfo()
end

function RougeTalentView:_onUpdateRougeTalentInfo()
	local talentList = self._rougeInfo.talentInfo
	local talentPoint = self._rougeInfo.talentPoint
	local leftInfo, rightInfo, leftComp, rightComp
	local index = 1

	for i, comp in ipairs(self._talentCompList) do
		local mo = talentList[i]

		if not leftComp then
			leftInfo = mo
			leftComp = comp
		else
			rightInfo = mo
			rightComp = comp
		end

		if leftComp and rightComp then
			leftComp:updateInfo(leftInfo)
			rightComp:updateInfo(rightInfo)
			leftComp:updateState(talentPoint >= self._costTalentPoint)
			rightComp:updateState(talentPoint >= self._costTalentPoint)

			if leftComp:isRootPlayCloseAnim() or rightComp:isRootPlayCloseAnim() then
				local group = self._groupMap[leftComp]

				group:Play("close", 0, 0)
			end

			if leftComp:isRootPlayOpenAnim() or rightComp:isRootPlayOpenAnim() then
				local group = self._groupMap[leftComp]

				group:Play("open", 0, 0)
			end

			if leftComp:needCostTalentPoint() or rightComp:needCostTalentPoint() then
				talentPoint = talentPoint - self._costTalentPoint
			end

			if self._moveContent and index > 4 and (leftComp:canActivated() or rightComp:canActivated()) then
				self._moveContent = false

				recthelper.setAnchorY(self._gocontent.transform, (index - 4 + 1) * 180)
			end

			leftComp = nil
			rightComp = nil
			index = index + 1
		end
	end
end

function RougeTalentView:_initSkill()
	local totalSkills = RougeDLCHelper.getAllCurrentUseStyleSkills(self._styleConfig.id)
	local rougeConfig = RougeOutsideModel.instance:config()
	local useMap = {}

	for index, skillMo in ipairs(totalSkills) do
		local skillItem = self:_getOrCreateSkillItem(index)
		local skillCo = rougeConfig:getSkillCo(skillMo.type, skillMo.skillId)
		local icon = skillCo and skillCo.icon

		if not string.nilorempty(icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagenormalicon, icon, true)
			UISpriteSetMgr.instance:setRouge2Sprite(skillItem.imagselecticon, icon .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", skillMo.type, skillMo.skillId))
		end

		self["_skillDesc" .. index] = skillCo and skillCo.desc
		self["_skillIcon" .. index] = skillCo and skillCo.icon

		gohelper.setActive(skillItem.viewGO, true)

		useMap[skillItem] = true
	end

	for _, skillItem in ipairs(self._skillItemList) do
		if not useMap[skillItem] then
			gohelper.setActive(skillItem.viewGO, false)
		end
	end
end

function RougeTalentView:_getOrCreateSkillItem(index)
	if self._skillItemList then
		local skillItem = self._skillItemList[index]

		if not self._skillItemList then
			skillItem = self:getUserDataTb_()
			self._skillItemList.viewGO = gohelper.cloneInPlace(self._goskillitem, "item_" .. index)
			self._skillItemList.gonormal = gohelper.findChild(self._skillItemList.viewGO, "go_normal")
			self._skillItemList.imagenormalicon = gohelper.findChildImage(self._skillItemList.viewGO, "go_normal/image_icon")
			self._skillItemList.goselect = gohelper.findChild(self._skillItemList.viewGO, "go_select")
			self._skillItemList.imagselecticon = gohelper.findChildImage(self._skillItemList.viewGO, "go_select/image_icon")
			self._skillItemList.btnclick = gohelper.findChildButtonWithAudio(self._skillItemList.viewGO, "btn_click")

			self._skillItemList.btnclick:AddClickListener(self._btnskillOnClick, self, index)
			table.insert(self._skillItemList, self._skillItemList)
		end

		return self._skillItemList
	end
end

function RougeTalentView:_btnskillOnClick(index)
	self._showTips = true
	self._txtdec2.text = self["_skillDesc" .. index]

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageskillicon, self["_skillIcon" .. index], true)
	gohelper.setActive(self._godetail, false)
	gohelper.setActive(self._godetail, true)
	gohelper.setAsLastSibling(self._godetail)
	self:_refreshAllBtnStatus(index)
end

function RougeTalentView:_refreshAllBtnStatus(selectBtnIndex)
	for index, skillItem in ipairs(self._skillItemList) do
		local isSelect = selectBtnIndex == index

		self:_setBtnStatus(isSelect, skillItem.gonormal, skillItem.goselect)
	end
end

function RougeTalentView:_removeAllSkillClickListener()
	if self._skillItemList then
		for _, skillItem in pairs(self._skillItemList) do
			if skillItem.btnclick then
				skillItem.btnclick:RemoveClickListener()
			end
		end
	end
end

function RougeTalentView:setTalentCompSelected(comp)
	for i, v in ipairs(self._talentCompList) do
		v:setSelected(v == comp)
	end
end

function RougeTalentView:activeTalent(comp)
	self._tmpActiveTalentId = comp and comp._talentId

	RougeRpc.instance:sendActiveTalentRequest(self._season, comp._index - 1, self.activeTalentCb, self)
end

function RougeTalentView:activeTalentCb(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RougeStatController.instance:trackUpdateTalent(self._tmpActiveTalentId)

	self._tmpActiveTalentId = nil
end

function RougeTalentView:onClose()
	self._tmpActiveTalentId = nil

	self:_removeAllSkillClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, self._onTouchScreenUp, self)
end

function RougeTalentView:onDestroyView()
	return
end

return RougeTalentView
