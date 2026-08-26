-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonSkillIconItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonSkillIconItem", package.seeall)

local Rouge2_CommonSkillIconItem = class("Rouge2_CommonSkillIconItem", LuaCompBase)

function Rouge2_CommonSkillIconItem.Get(go, uiType)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonSkillIconItem, uiType)
end

function Rouge2_CommonSkillIconItem:ctor(uiType)
	self._uiType = uiType
end

function Rouge2_CommonSkillIconItem:init(go)
	self.go = go
	self._isInitDone = false
	self._isEmpty = true
	self._isShowTeamTips = true
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(Rouge2_Enum.ResPath.CommonSkillIconItem, self._onLoadDone, self)

	self._teamTipsParam = {
		[Rouge2_Enum.TeamRecommendParam.IsShowSystemName] = true,
		[Rouge2_Enum.TeamRecommendParam.IsShowSystemIcon] = true
	}
end

function Rouge2_CommonSkillIconItem:_onLoadDone(loader)
	self:initIconItem(loader:getInstGO())
	self:addIconEventListeners()

	self._isInitDone = true

	self:tryRefreshUI()
end

function Rouge2_CommonSkillIconItem:removeEventListeners()
	if self._isInitDone then
		self:removeIconEventListeners()
	end
end

function Rouge2_CommonSkillIconItem:onDestroy()
	if self._isInitDone then
		self:onDestroyIcon()
	end
end

function Rouge2_CommonSkillIconItem:initIconItem(goIcon)
	self._goIcon = goIcon
	self._goInfo = gohelper.findChild(self._goIcon, "#go_Info")
	self._simageIcon = gohelper.findChildSingleImage(self._goIcon, "#go_Info/#simage_Icon")
	self._txtName = gohelper.findChildText(self._goIcon, "#go_Info/NameBg/#txt_Name")
	self._imageRare = gohelper.findChildImage(self._goIcon, "#go_Info/#image_Rare")
	self._goTeamTips = gohelper.findChild(self._goIcon, "#go_Info/#go_TeamTips")
	self._goEmpty = gohelper.findChild(self._goIcon, "#go_Empty")
	self._tranTeamTips = self._goTeamTips.transform
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.MultiItemSystemTag)

	self:initUITypeTab()
	self:initRareEffectTab()
end

function Rouge2_CommonSkillIconItem:addIconEventListeners()
	return
end

function Rouge2_CommonSkillIconItem:removeIconEventListeners()
	return
end

function Rouge2_CommonSkillIconItem:onUpdateMO(dataType, dataId)
	self._isEmpty = not dataType or not dataId

	if self._isEmpty then
		self:tryRefreshUI()

		return
	end

	self._dataType = dataType
	self._dataId = dataId
	self._skillCo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillId = self._skillCo and self._skillCo.id

	self:tryRefreshUI()
end

function Rouge2_CommonSkillIconItem:tryRefreshUI()
	if not self._isInitDone then
		return
	end

	gohelper.setActive(self._goEmpty, self._isEmpty)
	gohelper.setActive(self._goInfo, not self._isEmpty)

	if self._isEmpty then
		return
	end

	self:refreshUI()
end

function Rouge2_CommonSkillIconItem:refreshUI()
	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._skillId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	gohelper.setActive(self._goTeamTips, self._isShowTeamTips)
	Rouge2_IconHelper.setItemIconAndRare(self._skillId, self._simageIcon, self._imageRare, Rouge2_Enum.ItemRareIconType.CircleIcon)
	self:refreshUIType()
	self:refreshRareEffect()
end

function Rouge2_CommonSkillIconItem:initUITypeTab()
	self._uiTypeTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self._goIcon, "#go_Info/Name")
	local tranParent = goParent.transform
	local typeNum = tranParent.childCount

	for i = 1, typeNum do
		local goType = tranParent:GetChild(i - 1).gameObject
		local type = tonumber(goType.name)
		local typeTab = self:getUserDataTb_()

		typeTab.go = goType
		typeTab.txtName = gohelper.findChildText(goType, "#txt_Name")
		typeTab.goTeamTipsPos = gohelper.findChild(goType, "#go_TeamTipsPos")

		local tipsPosX, tipsPosY = recthelper.getAnchor(typeTab.goTeamTipsPos.transform)

		typeTab.teamTipsPos = Vector2(tipsPosX, tipsPosY)
		self._uiTypeTab[type] = typeTab

		gohelper.setActive(goType, false)
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_CommonSkillIconItem:initRareEffectTab()
	self._rareEffectTab = self:getUserDataTb_()

	local goParent = gohelper.findChild(self._goIcon, "#go_Info/#go_Rare")
	local tranParent = goParent.transform
	local effectNum = tranParent.childCount

	for i = 1, effectNum do
		local goeffect = tranParent:GetChild(i - 1).gameObject
		local rare = tonumber(goeffect.name)

		self._rareEffectTab[rare] = goeffect

		gohelper.setActive(goeffect, false)
	end

	gohelper.setActive(goParent, true)
end

function Rouge2_CommonSkillIconItem:refreshUIType()
	for type, uiTab in pairs(self._uiTypeTab) do
		local show = type == self._uiType

		gohelper.setActive(uiTab.go, show)

		if show then
			if self._skillCo then
				uiTab.txtName.text = self._skillCo.name or ""
			end

			local teamTipsPos = uiTab.teamTipsPos

			recthelper.setAnchor(self._tranTeamTips, teamTipsPos.x or 0, teamTipsPos.y or 0)
		end
	end
end

function Rouge2_CommonSkillIconItem:refreshRareEffect()
	if self._skillCo then
		for rare, goEffect in pairs(self._rareEffectTab) do
			gohelper.setActive(goEffect, rare == self._skillCo)
		end
	end
end

function Rouge2_CommonSkillIconItem:showTeamTips(visible)
	self._isShowTeamTips = visible

	self:tryRefreshUI()
end

function Rouge2_CommonSkillIconItem:updateUIType(type)
	if self._uiType == type then
		return
	end

	self._uiType = type

	self:tryRefreshUI()
end

function Rouge2_CommonSkillIconItem:updateSystemParam(key, value)
	if self._teamTipsParam then
		if self._teamTipsParam == value then
			return
		end

		self._teamTipsParam[key] = value

		self:tryRefreshUI()
	end
end

function Rouge2_CommonSkillIconItem:onDestroyIcon()
	self._simageIcon:UnLoadImage()
end

return Rouge2_CommonSkillIconItem
