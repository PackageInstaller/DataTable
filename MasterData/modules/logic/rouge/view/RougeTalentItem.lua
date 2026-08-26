-- chunkname: @modules/logic/rouge/view/RougeTalentItem.lua

module("modules.logic.rouge.view.RougeTalentItem", package.seeall)

local RougeTalentItem = class("RougeTalentItem", ListScrollCellExtend)

function RougeTalentItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentItem:addEvents()
	return
end

function RougeTalentItem:removeEvents()
	return
end

function RougeTalentItem:_editableInitView()
	self._canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._txtDescr = gohelper.findChildText(self.viewGO, "txt_Descr")
	self._icon = gohelper.findChildImage(self.viewGO, "txt_Descr/go_Icon")
	self._iconlight = gohelper.findChild(self.viewGO, "txt_Descr/go_Icon/#light")
	self._boardImg = gohelper.findChildImage(self.viewGO, "go_Light")

	gohelper.setActive(self._boardImg, false)

	self._goSelected = self:_findChild("go_Selected", false)
	self._goConfirm = self:_findChild("go_Selected/image_Tick", true)
	self._goLineLight = self:_findChild("go_LineLight", false)
	self._goLineLight1 = self:_findChild("go_LineLight1", false)
	self._goLineLight2 = self:_findChild("go_LineLight2", false)
	self._goStar = self:_findChild("go_Star", false)
	self._goClick = self:_findChild("click", false)
	self.click = gohelper.getClickWithDefaultAudio(self._goClick)

	self.click:AddClickListener(self.onClick, self)

	self.clickConfirm = gohelper.getClickWithDefaultAudio(self._goSelected)

	self.clickConfirm:AddClickListener(self.onClickConfirm, self)

	self._goSelectedAnimator = self._goSelected:GetComponent(typeof(UnityEngine.Animator))
end

function RougeTalentItem:setState()
	if self._isSelected then
		local isSelected = self._talentState == RougeEnum.TalentState.CanActivated

		gohelper.setActive(self._goStar, false)
		gohelper.setActive(self._goSelected, isSelected)
		gohelper.setActive(self._goClick, false)
		gohelper.setActive(self._boardImg, false)
		gohelper.setActive(self._goLineLight, false)
		gohelper.setActive(self._goLineLight1, false)
		gohelper.setActive(self._goLineLight2, false)

		if isSelected then
			self._goSelectedAnimator:Play("open", 0, 0)
		end

		if self._talentState == RougeEnum.TalentState.Disabled then
			local color = GameUtil.parseColor("#D3CCBF")

			color.a = 0.2
			self._txtDescr.color = color

			UISpriteSetMgr.instance:setRougeSprite(self._icon, "rouge_talent_point_01")
			gohelper.setActive(self._txtDescr, true)

			return
		end

		if self._talentState == RougeEnum.TalentState.CannotActivated then
			local color = GameUtil.parseColor("#D3CCBF")

			color.a = 0.2
			self._txtDescr.color = color

			UISpriteSetMgr.instance:setRougeSprite(self._icon, "rouge_talent_point_01")
			gohelper.setActive(self._txtDescr, true)
			gohelper.setActive(self._boardImg, true)

			local imgColor = self._boardImg.color

			imgColor.a = 0.4
			self._boardImg.color = imgColor

			return
		end

		if self._talentState == RougeEnum.TalentState.CanActivated then
			local color = GameUtil.parseColor("#C5BEA1")

			color.a = 1
			self._txtDescr.color = color

			UISpriteSetMgr.instance:setRougeSprite(self._icon, "rouge_talent_point_02")
			gohelper.setActive(self._goStar, true)
			gohelper.setActive(self._goClick, true)
			gohelper.setActive(self._txtDescr, true)
			gohelper.setActive(self._boardImg, not isSelected)

			local imgColor = self._boardImg.color

			imgColor.a = 1
			self._boardImg.color = imgColor

			return
		end

		if self._talentState == RougeEnum.TalentState.Activated then
			gohelper.setActive(self._boardImg, false)

			local color = GameUtil.parseColor("#D3CCBF")

			color.a = 1
			self._txtDescr.color = color

			gohelper.setActive(self._txtDescr, true)
			gohelper.setActive(self._goStar, false)
			UISpriteSetMgr.instance:setRougeSprite(self._icon, self._isSpecial and "rouge_talent_point_04" or "rouge_talent_point_03")
			gohelper.setActive(self._goLineLight, true)
			gohelper.setActive(self._goLineLight1, true)
			gohelper.setActive(self._goLineLight2, true)

			if self._initState ~= self._talentState then
				gohelper.setActive(self._iconlight, true)
			end

			if self._isSelected then
				gohelper.setActive(self._goSelected, true)

				self._isSelected = false

				self._goSelectedAnimator:Play("close", 0, 0)
			end

			return
		end

		if self._talentState == RougeEnum.TalentState.SiblingActivated then
			gohelper.setActive(self._boardImg, false)
			gohelper.setActive(self._txtDescr, true)
			gohelper.setActive(self._goStar, false)

			self._txtDescr.text = ""

			UISpriteSetMgr.instance:setRougeSprite(self._icon, "rouge_talent_point_00")

			return
		end
	end
end

function RougeTalentItem:setSpecial(value)
	self._isSpecial = value
end

function RougeTalentItem:setInfo(talentView, index, info, SiblingComp, prevGroupComp)
	self._talentView = talentView
	self._index = index
	self._sliblingComp = SiblingComp
	self._prevGroupComp = prevGroupComp

	self:updateInfo(info)

	self._talentId = info.id
	self._talentConfig = lua_rouge_style_talent.configDict[self._talentId]
	self._txtDescr.text = self._talentConfig and self._talentConfig.desc
end

function RougeTalentItem:updateInfo(info)
	self._talentMo = info
end

function RougeTalentItem:isRootPlayCloseAnim()
	return self._oldTalentState == RougeEnum.TalentState.CanActivated and self._talentState == RougeEnum.TalentState.Activated
end

function RougeTalentItem:isRootPlayOpenAnim()
	return self._oldTalentState == RougeEnum.TalentState.CannotActivated and self._talentState == RougeEnum.TalentState.CanActivated
end

function RougeTalentItem:updateState(isCostEnough)
	self._oldTalentState = self._talentState

	self:_checkState(isCostEnough)

	self._initState = self._initState or self._talentState

	self:setState()
end

function RougeTalentItem:_checkState(isCostEnough)
	if self._talentMo.isActive == 1 then
		self._talentState = RougeEnum.TalentState.Activated

		return
	end

	if self._sliblingComp._talentMo.isActive == 1 then
		self._talentState = RougeEnum.TalentState.SiblingActivated

		return
	end

	if self:_parentGroupIsActive() and isCostEnough then
		self._talentState = RougeEnum.TalentState.CanActivated

		return
	end

	if isCostEnough then
		self._talentState = RougeEnum.TalentState.CannotActivated

		return
	end

	self._talentState = RougeEnum.TalentState.Disabled
end

function RougeTalentItem:canActivated()
	return self._talentState == RougeEnum.TalentState.CanActivated
end

function RougeTalentItem:needCostTalentPoint()
	return self._talentState == RougeEnum.TalentState.CanActivated or self._talentState == RougeEnum.TalentState.CannotActivated
end

function RougeTalentItem:_parentGroupIsActive()
	if not self._prevGroupComp then
		return true
	end

	for i, v in ipairs(self._prevGroupComp) do
		if v._talentMo.isActive == 1 then
			return true
		end
	end

	return false
end

function RougeTalentItem:onClick()
	if self._isSelected then
		return
	end

	self._talentView:setTalentCompSelected(self)
end

function RougeTalentItem:setSelected(value)
	self._isSelected = value

	self:setState()
end

function RougeTalentItem:onClickConfirm()
	if self._talentState == RougeEnum.TalentState.Activated then
		return
	end

	self._goSelectedAnimator:Play("close", 0, 0)
	self._talentView:activeTalent(self)
end

function RougeTalentItem:_findChild(path, visible)
	local go = gohelper.findChild(self.viewGO, path)

	gohelper.setActive(go, visible)

	return go
end

function RougeTalentItem:_editableAddEvents()
	return
end

function RougeTalentItem:_editableRemoveEvents()
	return
end

function RougeTalentItem:onUpdateMO(mo)
	return
end

function RougeTalentItem:onDestroyView()
	self.click:RemoveClickListener()
	self.clickConfirm:RemoveClickListener()
end

return RougeTalentItem
