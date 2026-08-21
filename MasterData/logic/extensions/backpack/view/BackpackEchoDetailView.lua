-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackEchoDetailView.lua

module("logic.extensions.backpack.view.BackpackEchoDetailView", package.seeall)

local M = class("BackpackEchoDetailView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnDetail = self._registry:getBtn("12&btn_left_-1571983320")
	self._btnBreak = self._registry:getBtn("11&btn_right_1251431307")
	self._btnLock = self._registry:getBtn("backpack_echo_detail_tips_-1630841986")
	self._txtEquipName = self._registry:getText("backpack_echo_detail_tips_1433362629")
	self._lock = self._registry:getGo("backpack_echo_detail_tips_-987318307")
	self._unlock = self._registry:getGo("backpack_echo_detail_tips_-698198172")
	self._imgEchoIcon = self._registry:getImage("backpack_echo_detail_tips_1246298523")

	local breakPointGo = self._registry:getGo("10&break_point_-2114175626")

	self._breakPointView = Astral.LuaComponentContainer.Add(breakPointGo, EchoItemBreakPointView)
	self._txtCareerFlag = self._registry:getUIComponent("backpack_echo_detail_tips_copy_618988265", UIComponentType.TextMeshProUGUI)
	self._txtCareer = self._registry:getUIComponent("backpack_echo_detail_tips_copy_-2127839420", UIComponentType.TMPText)
	self._descRootTrs = self._registry:getUIComponent("backpack_echo_detail_tips_copy_1005611255", UIComponentType.RectTransform)
	self._btnDesc = self._registry:getBtn("backpack_echo_detail_tips_copy_-2120052093")
	self._headGo = goutil.findChild(self._mainGo, "node/top/lay/head")
	self._imgHead = goutil.findChildImageComponent(self._headGo, "headIcon")
	self._lockRootGo = self._registry:getGo("backpack_echo_detail_tips_-618678760")

	local attributeParent = self._registry:getGo("backpack_echo_detail_tips_662408012")
	local attrList = Astral.GameObjectUtil.GetChildren(attributeParent)

	self._attrViewList = {}

	for index = 1, attrList.Length - 1 do
		local view = Astral.SimpleLuaComponentContainer.Add(attrList[index], EchoItemBreakAttrViewNew)

		view:setIndex(index + 1)
		table.insert(self._attrViewList, view)
	end

	self._baseAttrLst = {}

	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("backpack_echo_detail_tips_1534868093"),
		txtName = self._registry:getText("backpack_echo_detail_tips_-1707425181"),
		txtAttr = self._registry:getText("backpack_echo_detail_tips_336918445")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("backpack_echo_detail_tips_-1502117455"),
		txtName = self._registry:getText("backpack_echo_detail_tips_-968273364"),
		txtAttr = self._registry:getText("backpack_echo_detail_tips_-1053306192")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("backpack_echo_detail_tips_copy_317831168"),
		txtName = self._registry:getText("backpack_echo_detail_tips_copy_181222982"),
		txtAttr = self._registry:getText("backpack_echo_detail_tips_copy_1744803438")
	})
	table.insert(self._baseAttrLst, {
		root = self._registry:getGo("backpack_echo_detail_tips_copy_147630844"),
		txtName = self._registry:getText("backpack_echo_detail_tips_copy_-1058762246"),
		txtAttr = self._registry:getText("backpack_echo_detail_tips_copy_2018217557")
	})
end

function M:_bindEvents()
	self._btnBreak:AddClickListener(self._onClickBreak, self)
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._btnDesc:AddClickListener(self._onClickDesc, self)
end

function M:_unbindEvents()
	self._btnBreak:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnDesc:RemoveClickListener()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self.refreshView, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
	self:_bindEvents()
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self.refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
	self:_unbindEvents()
end

function M:refreshView()
	if not self._echoItemData then
		return
	end

	local echoItemData = self._echoItemData
	local echoId = self._echoItemData:getId()

	self._txtEquipName.text = echoItemData:getName()

	self._lock:SetActive(echoItemData:getIsLock())
	self._unlock:SetActive(not echoItemData:getIsLock())
	IconLoader.setSprite(self._imgEchoIcon, IconType.EchoItemIcon, echoItemData:getIcon())

	local career = echoItemData:getCareer()
	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local descStr = skillEnhanceMO and skillEnhanceMO:getDescription() or ""
	local campIcon = CommEnum.Career2TmpResName[career] or ""
	local lines = string.split(descStr, "\n")

	self._txtCareerFlag.text = string.format("<size=24>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])

	goutil.setActive(self._txtCareerFlag.gameObject.transform.parent.gameObject, campIcon ~= "")
	goutil.setActive(self._descRootTrs.gameObject, descStr ~= "")

	if #lines > 0 then
		while self._descRootTrs.childCount - 1 < #lines do
			local textGo = goutil.cloneAndSetParent(self._descRootTrs:GetChild(1).gameObject, self._descRootTrs)

			textGo.transform:SetSiblingIndex(1)
		end

		for i = 1, self._descRootTrs.childCount - 1 do
			local go = self._descRootTrs:GetChild(i).gameObject
			local txtDesc = go:GetComponent(UIComponentType.TMPText)

			txtDesc.text = lines[i]

			goutil.setActive(go, i <= #lines)
		end
	end

	local echoMaxLv = echoItemData:getMaxLevel()

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoItemData:getLevel()
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			echoItemId = echoItemData:getId(),
			level = echoItemData:getLevel(),
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoId, showLevel, colorAttr, colorSkill, descSplit),
			itemData = echoItemData,
			showLevel = showLevel
		}

		attrView:setData(data, echoMaxLv)
	end

	local heroId = echoItemData:getHeroId()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroId > 0 and heroMO then
		self._headGo:SetActive(true)

		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(self._imgHead, IconType.RoleHeadIcon, modelCO.headIconName)
	else
		self._headGo:SetActive(false)
	end

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	self._breakPointView:setEchoItemLevel(echoItemData:getLevel(), echoItemData:getMaxLevel())

	local attLst = echoItemData:getAttr()
	local attCount = #attLst

	for index, comps in ipairs(self._baseAttrLst) do
		local data = attLst[index]
		local show = data ~= nil

		if show then
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			comps.txtName.text = cfg and cfg.name or ""

			local offsetNumStr = data.num

			if data.num < 1 then
				offsetNumStr = string.format("+%s", data.num * 100) .. "%"
			end

			comps.txtAttr.text = offsetNumStr
		end

		goutil.setActive(comps.root, show)
	end
end

function M:setEchoItemData(echoItemData)
	self._echoItemData = echoItemData

	self:refreshView()

	if echoItemData:getRedPointIsNew() then
		local itemid = echoItemData:getUuid()
		local type = GameEnum.ItemTypeEnum.EchoItemType

		BackpackAgent.instance:sendremoveRedPointRequest(type, {
			itemid
		})
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	return
end

function M:_onClickFit()
	local uuid = self._echoItemData:getUuid()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return
	end

	local function confirmCallback()
		local heroId = heroData:getId()

		EchoItemAgent.instance:sendWearEchoItemRequest(uuid, heroId)
	end

	if self._echoItemData:getHeroId() > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._echoItemData:getHeroId())
		local str = string.format(lang("tip_has_equip"), heroMO:getName())
		local dialog = Dialog.showMessage(lang("tip_sure_equip_echo"), str)

		dialog:setConfirmListener(confirmCallback, self)
	else
		confirmCallback()
	end
end

function M:_onClickDisboard()
	local uuid = self._echoItemData:getUuid()

	EchoItemAgent.instance:sendWearEchoItemRequest(uuid, 0)
end

function M:_onClickBreak()
	EchoItemMainController.instance:setSelectedEchoItem(self._echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Break
	}

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_canxiangtupo, nil, nil, nil)
	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickLock()
	local uuid = self._echoItemData:getUuid()
	local isLock = self._echoItemData:getIsLock()

	if not isLock then
		EchoItemAgent.instance:sendLockEchoItemRequest(uuid, true)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_unlock_echo"))

		dialog:setConfirmListener(function()
			EchoItemAgent.instance:sendLockEchoItemRequest(uuid, false)
		end, self)
	end
end

function M:_onClickDetail()
	EchoItemMainController.instance:setSelectedEchoItem(self._echoItemData)

	local params = {
		index = EchoItemMainViewNew.SubViewType.Detail
	}

	ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
end

function M:_onClickDesc()
	local echoItemData = self._echoItemData
	local echoItemId = echoItemData and echoItemData:getId() or 0

	if echoItemId == 0 then
		return
	end

	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local bindGo = self._btnDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:_getNeedShowDisboardBtn()
	return self._echoItemData:getHeroId() > 0
end

function M:setNeedShowDetailBtn(isNeed)
	self._needShowDetailBtn = isNeed

	if isNeed then
		self._btnDetail.gameObject:SetActive(true)
		self._btnBreak.gameObject:SetActive(true)
	end
end

function M:setLockRootVisible(visible)
	self._lockRootGo:SetActive(visible)
	self._headGo:SetActive(visible)
end

return M
