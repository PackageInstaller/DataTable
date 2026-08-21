-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsEchoComp.lua

module("logic.extensions.tooltips.component.ToolTipsEchoComp", package.seeall)

local M = class("ToolTipsEchoComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._imgQuality = nil
	self._typeName = nil
	self._txtCareerFlag = nil
	self._txtCareer = nil
end

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._btnClose = self:getBtnByPath("clickClose")
	self._scroll = goutil.findChildComponent(self.mainGO, "node/scroll", UIComponentType.ScrollRect)
	self._txtEquipName = self:getTextByPath("node/top/txtName")
	self._typeName = self:getTextByPath("node/top/txtTab")
	self._goLock = self:getGoByPath("node/top/lock")
	self._lock = self:getGoByPath("node/top/lock/Lock")
	self._btnLock = self:getBtnByPath("node/top/lock/btnLock")
	self._unlock = self:getGoByPath("node/top/lock/UnLock")
	self._imgQuality = self:getImageByPath("node/scroll/view/content/content1/imgQuality")
	self._imgEchoIcon = self:getImageByPath("node/scroll/view/content/content1/icon")
	self._txtCareerFlag = self:getUIComponentByPath("node/scroll/view/content/content1/objCareer/objLogo/txtLogo", UIComponentType.TextMeshProUGUI)
	self._txtCareer = self:getUIComponentByPath("node/scroll/view/content/content1/objCareer/txtCareer", UIComponentType.TextMeshProUGUI)
	self._txtDesc = goutil.findChildComponent(self.mainGO, "node/scroll/view/content/descLayout/txtDetailDescript", UIComponentType.TextMeshProUGUI)
	self._btnDesc = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "node/scroll/view/content/descLayout/txtDetailDescript/click"))

	local attributeParent = self:getGoByPath("node/scroll/view/content/breakAttributeLayout")
	local showCardGo = self:getGoByPath("showPoint/echo_show_card")

	self._showCardView = Astral.LuaComponentContainer.Add(showCardGo, EchoItemShowCardView)

	self._showCardView:showGyros()

	local attrList = Astral.GameObjectUtil.GetChildren(attributeParent)

	self._attrViewList = {}

	for index = 0, attrList.Length - 1 do
		local view = Astral.SimpleLuaComponentContainer.Add(attrList[index], EchoItemBreakAttrViewNew)

		view:setIndex(index + 2)
		table.insert(self._attrViewList, view)
	end

	local breakPointGo = self:getGoByPath("node/scroll/view/content/content1/break_point")

	self._breakPointView = Astral.LuaComponentContainer.Add(breakPointGo, EchoItemBreakPointView)
	self._goHead = self:getGoByPath("node/top/head")

	goutil.setActive(self._goHead, false)

	self._baseAttrLst = {}

	table.insert(self._baseAttrLst, {
		root = self:getGoByPath("node/scroll/view/content/content1/attribute_1"),
		txtName = self:getTextByPath("node/scroll/view/content/content1/attribute_1/txtAttribute"),
		txtAttr = self:getTextByPath("node/scroll/view/content/content1/attribute_1/txtNum")
	})
	table.insert(self._baseAttrLst, {
		root = self:getGoByPath("node/scroll/view/content/content1/attribute_2"),
		txtName = self:getTextByPath("node/scroll/view/content/content1/attribute_2/txtAttribute"),
		txtAttr = self:getTextByPath("node/scroll/view/content/content1/attribute_2/txtNum")
	})
	table.insert(self._baseAttrLst, {
		root = self:getGoByPath("node/scroll/view/content/content1/attribute_3"),
		txtName = self:getTextByPath("node/scroll/view/content/content1/attribute_3/txtAttribute"),
		txtAttr = self:getTextByPath("node/scroll/view/content/content1/attribute_3/txtNum")
	})
	table.insert(self._baseAttrLst, {
		root = self:getGoByPath("node/scroll/view/content/content1/attribute_4"),
		txtName = self:getTextByPath("node/scroll/view/content/content1/attribute_4/txtAttribute"),
		txtAttr = self:getTextByPath("node/scroll/view/content/content1/attribute_4/txtNum")
	})
end

function M:destroyUI()
	self._txtEquipName = nil
	self._lock = nil
	self._unlock = nil
	self._typeName = nil
	self._imgQuality = nil
	self._txtCareerFlag = nil
	self._txtCareer = nil
	self._imgEchoIcon = nil

	self._breakPointView:OnDestroy()

	self._breakPointView = nil
	self._txtDesc = nil
	self._attrViewList = nil
	self._baseAttrLst = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshLock, self)
	self._btnClose:AddClickListener(self._onClickReturn, self)
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnDesc:AddClickListener(self._onClickDesc, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshLock, self)
	self._btnClose:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnDesc:RemoveClickListener()
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickLock()
	local uuid = self._echoItemData:getUuid()
	local echoItemData = ItemModel.instance:getItemDataByUuid(uuid)
	local isLock = echoItemData:getIsLock()

	if not isLock then
		EchoItemAgent.instance:sendLockEchoItemRequest(uuid, true)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_unlock_echo"))

		dialog:setConfirmListener(function()
			EchoItemAgent.instance:sendLockEchoItemRequest(uuid, false)
		end, self)
	end
end

function M:_onClickDesc()
	if not self._echoItemData then
		return
	end

	local skillEnhanceMO = self._echoItemData:getSkillEnhanceMO()
	local bindGo = self._btnDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:_refreshLock()
	if not self._echoItemData then
		return
	end

	local uuid = self._echoItemData:getUuid()
	local echoItemData = ItemModel.instance:getItemDataByUuid(uuid)

	self._echoItemData = echoItemData

	goutil.setActive(self._btnLock.gameObject, true)
	self._lock:SetActive(echoItemData:getIsLock())
	self._unlock:SetActive(not echoItemData:getIsLock())
end

function M:onEnter()
	self:_bindEvents()

	local info = self:getFirstParam()

	self._echoItemData = info.baseData
	self._isHideLock = info.isHideLock

	local isVisible = ItemModel.instance:getItemDataByUuid(self._echoItemData:getUuid())

	goutil.setActive(self._typeName.gameObject, not isVisible)
	self:refreshView()

	self._scroll.verticalNormalizedPosition = 1
end

function M:onExit()
	self:_unbindEvents()
	self._showCardView:onExit()
end

function M:refreshView()
	if not self._echoItemData then
		printError("no data")

		return
	end

	local echoItemData = self._echoItemData
	local echoId = echoItemData:getId()
	local uuid = echoItemData:getUuid()
	local echoLv = echoItemData:getLevel()
	local echoMaxLv = echoItemData:getMaxLevel()
	local career = echoItemData:getCareer()

	self._txtEquipName.text = echoItemData:getName()

	if self._typeName.gameObject.activeSelf then
		self._typeName.text = BackpackOtherConfig.instance:getTypeNameByTS(echoItemData:getType(), echoItemData:getSubType())
	end

	printWarn(string.format("回响[%s] 等级[%s]", echoItemData:getName(), echoLv))
	self._goLock:SetActive(not self._isHideLock)
	self._lock:SetActive(echoItemData:getIsLock())
	self._unlock:SetActive(not echoItemData:getIsLock())
	goutil.setActive(self._btnLock.gameObject, true)

	local quality = echoItemData:getQuality()

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2TipsWordIcon[quality])
	IconLoader.setSprite(self._imgEchoIcon, IconType.EchoItemIcon, echoItemData:getIcon())

	if echoItemData:getCareer() > 0 then
		-- block empty
	end

	local highLightTagIds
	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local descStr = skillEnhanceMO and skillEnhanceMO:getDescriptionTagHighLight(highLightTagIds) or ""
	local campIcon = CommEnum.Career2TmpResName[career] or ""

	self._txtDesc.text = string.format("%s", descStr)
	self._txtCareerFlag.text = string.format("<size=24>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])

	goutil.setActive(self._txtCareerFlag.gameObject.transform.parent.gameObject, campIcon ~= "")

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoLv
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			echoItemId = echoId,
			level = echoLv,
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoId, showLevel, colorAttr, colorSkill, descSplit, highLightTagIds),
			itemData = echoItemData,
			showLevel = showLevel
		}

		attrView:setData(data, echoMaxLv)
	end

	self._breakPointView:setEchoItemLevel(echoLv, echoMaxLv)
	self._showCardView:onEnter()
	self._showCardView:showGyros()
	self._showCardView:refreshView(echoId)

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

	if not ItemModel.instance:getItemDataByUuid(uuid) or uuid == 0 then
		self._lock:SetActive(false)
		self._unlock:SetActive(false)
		goutil.setActive(self._btnLock.gameObject, false)
	end
end

return M
