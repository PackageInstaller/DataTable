-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterPreinstallCellItem.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterPreinstallCellItem", package.seeall)

local M = class("CharacterPreinstallCellItem")
local PresetItemType = {
	Current = 1,
	Saves = 3,
	Recommended = 2
}

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
	self:setHandler(nil)
end

function M:buildUI()
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._btnSave = self._registry:findUIElement("6&btn_middle_-31477526", UIComponentType.ButtonAdapter)
	self._btnChange = self._registry:findUIElement("preset_item_-2038579184", UIComponentType.ButtonAdapter)
	self._btnDelete = self._registry:findUIElement("preset_item_2139569594", UIComponentType.ButtonAdapter)
	self._thinktTipsPosition = self._registry:findUIElement("preset_item_-336939033")
	self._textContent = self._registry:findUIElement("preset_item_-1483876636", UIComponentType.Text)
	self._btnMaskEcho = self._registry:findUIElement("preset_item_-211519753", UIComponentType.ButtonAdapter)
	self._inputName = self._registry:findUIElement("preset_item_-889657563", UIComponentType.InputFieldAdapter)
	self._inputDefaultName = self._registry:findUIElement("preset_item_-837353378", UIComponentType.Text)
	self._btnEdit = self._registry:findUIElement("preset_item_1918928767")
	self._curThinking = self._registry:findUIElement("thought_skill_item_-1906135219")
	self._curEcho = self._registry:findUIElement("0&rewards_detail_item_2141037416")
	self._curEquipFirst = self._registry:findUIElement("1&rewards_detail_item_2141037416")
	self._curEquipSecond = self._registry:findUIElement("2&rewards_detail_item_2141037416")
	self._curEquipThird = self._registry:findUIElement("3&rewards_detail_item_2141037416")

	local content = self._registry:findUIElement("preset_item_1102017404")

	self._contentRainBowAni = goutil.addComponentOnce(content, ComponentType.Animation)
	self._imgSelect = self._registry:findUIElement("preset_item_-989335901")
	self._imgSelectAni = goutil.addComponentOnce(self._imgSelect, ComponentType.Animation)
end

function M:destroyUI()
	self._registry:cleanRegistry()

	self._btnSave = nil
	self._btnChange = nil
	self._btnDelete = nil
	self._textContent = nil
	self._thinktTipsPosition = nil
	self._inputName = nil
	self._inputDefaultName = nil
	self._btnEdit = nil
	self._curThinking = nil
	self._curEcho = nil
	self._curEquipFirst = nil
	self._curEquipSecond = nil
	self._curEquipThird = nil
end

function M:bindEvents()
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._inputName:AddOnEndEdit(self._onEndEditInput, self)
	self._btnMaskEcho:AddClickListener(self._onClickRecomendEcho, self)
end

function M:unbindEvents()
	self._btnSave:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._inputName:RemoveOnEndEdit()
	self._btnMaskEcho:RemoveClickListener()
end

function M:onEnter()
	self:setNameEditable(true)

	if self._isCurPreinstall == PresetItemType.Current then
		self:setCurPreinstallText()
	end
end

function M:onExit()
	self._contentRainBowAni:Stop()
	self._imgSelectAni:Stop()
	self:back()
end

function M:_playSelectAnim()
	self._imgSelectAni:Play("team_item_imgselect_open")
end

function M:playRainBowAnim()
	self._contentRainBowAni:Play("preset_item_content_open")
end

function M:setSelected(isSelect)
	goutil.setActive(self._imgSelect, isSelect)

	if isSelect then
		self:_playSelectAnim()
	end
end

function M:setPreinstallType(type, onePreinstall)
	goutil.setActive(self._btnChange.gameObject, false)
	goutil.setActive(self._btnDelete.gameObject, false)
	goutil.setActive(self._btnSave.gameObject, false)

	self._isCurPreinstall = type

	if type == PresetItemType.Current then
		goutil.setActive(self._btnSave.gameObject, true)
		self:initCurAll(self:getCurHeroData())
		self:setCurPreinstallText()
	elseif onePreinstall and type == PresetItemType.Saves then
		goutil.setActive(self._btnChange.gameObject, true)
		goutil.setActive(self._btnDelete.gameObject, true)
		self:showPreinstallOne(onePreinstall)
	elseif onePreinstall and type == PresetItemType.Recommended then
		goutil.setActive(self._btnEdit.gameObject, false)
		goutil.setActive(self._textContent.gameObject, true)
		self:showRecommendedPrinstallOne(onePreinstall)
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setHeroDataByHeroID(heroID)
	self._curHeroId = heroID
end

function M:initCurHeroAllDate(hero_Data)
	local heroData = hero_Data

	self._curThinkingId = heroData:getThinkingItemData():getThinkingMoId()
	self._curThinkingSkillId = heroData:getThinkingItemData():getWearingSkillId()
	self._curEchoDate = heroData:getHeroEchoItemData():getEchoItem()
	self._curEquipFirstData = heroData:getHeroEquipData():getEquipByPart(1)
	self._curEquipSecondData = heroData:getHeroEquipData():getEquipByPart(2)
	self._curEquipThirdData = heroData:getHeroEquipData():getEquipByPart(3)
end

function M:initCurAll(hero_Data)
	local heroData = hero_Data

	self:initCurHeroAllDate(heroData)

	if self._curThinkingSkillId and self._curThinkingSkillId ~= 0 then
		local curThinkingSKillLv = heroData:getThinkingItemData():getThinkingMo():getSkillLevel(self._curThinkingSkillId)

		if curThinkingSKillLv then
			goutil.setActive(self._curThinking, true)

			local thinkingItem = Astral.SimpleLuaComponentContainer.Add(self._curThinking, ThinkingSkillItemView)

			thinkingItem:refreshView(self._curThinkingSkillId, curThinkingSKillLv, false)
			thinkingItem:setClickCallback(self._onTipsShow, self)
		end
	else
		goutil.setActive(self._curThinking, false)
	end

	if self._curEchoDate then
		goutil.setActive(self._curEcho, true)

		local curEchoitem = Astral.SimpleLuaComponentContainer.Add(self._curEcho, ItemCell)

		curEchoitem:updateData(self._curEchoDate)
		curEchoitem:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEcho, false)
	end

	if self._curEquipFirstData then
		goutil.setActive(self._curEquipFirst, true)

		local curEquipitem_1 = Astral.SimpleLuaComponentContainer.Add(self._curEquipFirst, ItemCell)

		curEquipitem_1:updateData(self._curEquipFirstData)
		curEquipitem_1:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipFirst, false)
	end

	if self._curEquipSecondData then
		goutil.setActive(self._curEquipSecond, true)

		local curEquipitem_2 = Astral.SimpleLuaComponentContainer.Add(self._curEquipSecond, ItemCell)

		curEquipitem_2:updateData(self._curEquipSecondData)
		curEquipitem_2:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipSecond, false)
	end

	if self._curEquipThirdData then
		goutil.setActive(self._curEquipThird, true)

		local curEquipitem_3 = Astral.SimpleLuaComponentContainer.Add(self._curEquipThird, ItemCell)

		curEquipitem_3:updateData(self._curEquipThirdData)
		curEquipitem_3:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipThird, false)
	end
end

function M:showPreinstallOne(onePreinstall)
	self._echoItem = nil
	self._thisPreinstallEcho = nil
	self._equipItem_1 = nil
	self._thisPreinstallEQ_1 = nil
	self._equipItem_2 = nil
	self._thisPreinstallEQ_2 = nil
	self._equipItem_3 = nil
	self._thisPreinstallEQ_3 = nil

	local skillLv

	self._thisPreinstallSkill = nil
	self._thisPreinstallThink = nil
	self._thisPreinstallId = onePreinstall.id
	self._thisPreinstallName = onePreinstall.name

	self._inputName:SetText(self._thisPreinstallName)

	if onePreinstall.echo and onePreinstall.echo ~= 0 then
		self._thisPreinstallEcho = onePreinstall.echo
		self._echoItem = ItemModel.instance:getItemDataByUuid(onePreinstall.echo)
	end

	if onePreinstall.equip1 and onePreinstall.equip1 ~= 0 then
		self._thisPreinstallEQ_1 = onePreinstall.equip1
		self._equipItem_1 = ItemModel.instance:getItemDataByUuid(onePreinstall.equip1)
	end

	if onePreinstall.equip2 and onePreinstall.equip2 ~= 0 then
		self._thisPreinstallEQ_2 = onePreinstall.equip2
		self._equipItem_2 = ItemModel.instance:getItemDataByUuid(onePreinstall.equip2)
	end

	if onePreinstall.equip3 and onePreinstall.equip3 ~= 0 then
		self._thisPreinstallEQ_3 = onePreinstall.equip3
		self._equipItem_3 = ItemModel.instance:getItemDataByUuid(onePreinstall.equip3)
	end

	if onePreinstall.skill and onePreinstall.skill ~= 0 then
		self._thisPreinstallSkill = onePreinstall.skill
		self._thisPreinstallThink = onePreinstall.thinking
		skillLv = ThinkingModel.instance:getThinkingSkillLevel(self._thisPreinstallSkill)
	end

	if self._echoItem then
		goutil.setActive(self._curEcho, true)

		local oneEchoitem = Astral.SimpleLuaComponentContainer.Add(self._curEcho, ItemCell)

		oneEchoitem:updateData(self._echoItem)
		oneEchoitem:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEcho, false)
	end

	if self._equipItem_1 then
		goutil.setActive(self._curEquipFirst, true)

		local curEquipitem_1 = Astral.SimpleLuaComponentContainer.Add(self._curEquipFirst, ItemCell)

		curEquipitem_1:updateData(self._equipItem_1)
		curEquipitem_1:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipFirst, false)
	end

	if self._equipItem_2 then
		goutil.setActive(self._curEquipSecond, true)

		local curEquipitem_2 = Astral.SimpleLuaComponentContainer.Add(self._curEquipSecond, ItemCell)

		curEquipitem_2:updateData(self._equipItem_2)
		curEquipitem_2:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipSecond, false)
	end

	if self._equipItem_3 then
		goutil.setActive(self._curEquipThird, true)

		local curEquipitem_3 = Astral.SimpleLuaComponentContainer.Add(self._curEquipThird, ItemCell)

		curEquipitem_3:updateData(self._equipItem_3)
		curEquipitem_3:setShowSelectedEffect(false)
	else
		goutil.setActive(self._curEquipThird, false)
	end

	if skillLv then
		goutil.setActive(self._curThinking, true)

		local thinkingItem = Astral.SimpleLuaComponentContainer.Add(self._curThinking, ThinkingSkillItemView)

		thinkingItem:refreshView(self._thisPreinstallSkill, skillLv, false)
		thinkingItem:setClickCallback(self._onTipsShow, self)
	else
		goutil.setActive(self._curThinking, false)
	end
end

function M:showRecommendedPrinstallOne(onePreinstall)
	self:setNameEditable(false)
	goutil.setActive(self._curThinking, false)
	goutil.setActive(self._curEcho, true)

	local echoItemId = onePreinstall.echoId
	local echoMaxLevel = EchoItemConfig.instance:getMaxLevel(echoItemId)
	local echoItemData = ItemUtil.createItemData({
		itemId = echoItemId
	})

	echoItemData:setLevel(echoMaxLevel)

	local oneEchoitem = Astral.SimpleLuaComponentContainer.Add(self._curEcho, ItemCell)

	oneEchoitem:updateData(echoItemData)
	oneEchoitem:setShowSelectedEffect(false)
	goutil.setActive(self._btnMaskEcho.gameObject, true)

	self._recommendedEcho = ToolTipsUtil.createItemTipsData(ItemUtil.createItemData({
		itemId = echoItemId
	}), nil, false)

	self._recommendedEcho.baseData:setLevel(self._recommendedEcho.baseData:getMaxLevel())
	goutil.setActive(self._curEquipFirst, true)

	local equipItem_1 = {
		code = onePreinstall.equipmentFirst,
		itemData = ItemUtil.createItemData({
			itemId = onePreinstall.equipmentFirst
		}),
		rewardStatus = CommEnum.RewardEnum.CanNotGot,
		fackRecommendD6 = onePreinstall.equipmentFirstDescription
	}

	equipItem_1.itemData:setCount(0)

	local curEquipitem_1 = Astral.SimpleLuaComponentContainer.Add(self._curEquipFirst, CharacterRecomendEquipCell)

	curEquipitem_1:updateData(equipItem_1)
	goutil.setActive(self._curEquipSecond, true)

	local equipItem_2 = {
		code = onePreinstall.equipmentSecond,
		itemData = ItemUtil.createItemData({
			itemId = onePreinstall.equipmentSecond
		}),
		rewardStatus = CommEnum.RewardEnum.CanNotGot,
		fackRecommendD6 = onePreinstall.equipmentSecondDescription
	}

	equipItem_2.itemData:setCount(0)

	local curEquipitem_2 = Astral.SimpleLuaComponentContainer.Add(self._curEquipSecond, CharacterRecomendEquipCell)

	curEquipitem_2:updateData(equipItem_2)
	goutil.setActive(self._curEquipThird, true)

	local equipItem_3 = {
		code = onePreinstall.equipmentThird,
		itemData = ItemUtil.createItemData({
			itemId = onePreinstall.equipmentThird
		}),
		rewardStatus = CommEnum.RewardEnum.CanNotGot,
		fackRecommendD6 = onePreinstall.equipmentThirdDescription
	}

	equipItem_3.itemData:setCount(0)

	local curEquipitem_3 = Astral.SimpleLuaComponentContainer.Add(self._curEquipThird, CharacterRecomendEquipCell)

	curEquipitem_3:updateData(equipItem_3)
	self._inputName:SetText(onePreinstall.preinstallName)

	self._textContent.text = onePreinstall.preintstallDescription
end

function M:_onClickRecomendEcho()
	ToolTipsMgr.showTips(self._recommendedEcho.viewName, self._recommendedEcho)
end

function M:_onClickSave()
	local preinstallNum = CharacterPreinstallController.instance:getHeroPreinstallNum(self._curHeroId) or 0
	local numLimit = CharacterPreinstallConfig.instance:GetPreinstallNumLimit() or 20

	if numLimit <= preinstallNum then
		FloatWordMgr.instance:show(lang("tip_character_preinstall_num"))
		self:setCurPreinstallText()

		return
	end

	local count = 0
	local preinstallDate = {}

	preinstallDate.hero = self._curHeroId
	preinstallDate.id = 0

	if self._inputName:GetText() ~= "" then
		preinstallDate.name = self._inputName:GetText()
	else
		FloatWordMgr.instance:show(lang("tip_character_preinstall_name"))

		return
	end

	if self._curEchoDate then
		preinstallDate.echo = self._curEchoDate.id
	else
		preinstallDate.echo = 0
		count = count + 1
	end

	if self._curEquipFirstData then
		preinstallDate.equip1 = self._curEquipFirstData.id
	else
		preinstallDate.equip1 = 0
		count = count + 1
	end

	if self._curEquipSecondData then
		preinstallDate.equip2 = self._curEquipSecondData.id
	else
		preinstallDate.equip2 = 0
		count = count + 1
	end

	if self._curEquipThirdData then
		preinstallDate.equip3 = self._curEquipThirdData.id
	else
		preinstallDate.equip3 = 0
		count = count + 1
	end

	if self._curThinkingSkillId and self._curThinkingSkillId ~= 0 then
		preinstallDate.skill = self._curThinkingSkillId
	else
		preinstallDate.skill = 0
		count = count + 1
	end

	if self._curThinkingId and self._curThinkingId ~= 0 then
		preinstallDate.thinking = self._curThinkingId
	else
		preinstallDate.thinking = 0
	end

	if count == 5 then
		FloatWordMgr.instance:show(lang("tip_character_preinstall_nil"))
		self:setCurPreinstallText()

		return
	end

	preinstallDate.lastModifyTime = 0

	CharacterPreinstallAgent.instance:sendSavePresetRequest(preinstallDate)
end

function M:_onClickDelete()
	local function _doSentRequest()
		local preinstallDate = {}

		preinstallDate.hero = self._curHeroId
		preinstallDate.id = self._thisPreinstallId

		CharacterPreinstallAgent.instance:sendDeletePresetRequest(preinstallDate)
	end

	local dialog = Dialog.showWarnMessage(lang("tip_title"), string.format(lang("tip_character_preinstall_deleted"), self._thisPreinstallName))

	dialog:setConfirmListener(_doSentRequest, self)
end

function M:_onClickChange()
	local heroData = self:getCurHeroData()

	self:initCurHeroAllDate(heroData)

	local isthinkingSillSame = self._curThinkingSkillId == self._thisPreinstallSkill or (self._curThinkingSkillId == nil or self._curThinkingSkillId == 0) and self._thisPreinstallSkill == nil
	local isEchoSame = self._curEchoDate and self._curEchoDate.id == self._thisPreinstallEcho or self._curEchoDate == nil and self._thisPreinstallEcho == nil
	local isEquipSame_1 = self._curEquipFirstData and self._curEquipFirstData.id == self._thisPreinstallEQ_1 or self._curEquipFirstData == false and self._thisPreinstallEQ_1 == nil
	local isEquipSame_2 = self._curEquipSecondData and self._curEquipSecondData.id == self._thisPreinstallEQ_2 or self._curEquipSecondData == false and self._thisPreinstallEQ_2 == nil
	local isEquipSame_3 = self._curEquipThirdData and self._curEquipThirdData.id == self._thisPreinstallEQ_3 or self._curEquipThirdData == false and self._thisPreinstallEQ_3 == nil

	if isthinkingSillSame and isEchoSame and isEquipSame_1 and isEquipSame_2 and isEquipSame_3 then
		FloatWordMgr.instance:show(lang("tip_character_preinstall_change"))

		return
	end

	local tempHeroList = {}

	local function setList(heroId, itemUuid)
		local info = {}
		local length = #tempHeroList

		info.heroID = heroId
		info.itemUuid = itemUuid
		tempHeroList[length + 1] = info
	end

	if self._echoItem and self._echoItem:getHeroId() > 0 and self._echoItem:getHeroId() ~= self._curHeroId then
		setList(self._echoItem:getHeroId(), self._echoItem:getUuid())
	end

	if self._equipItem_1 and self._equipItem_1:getHeroId() and self._equipItem_1:getHeroId() > 0 and self._equipItem_1:getHeroId() ~= self._curHeroId then
		setList(self._equipItem_1:getHeroId(), self._equipItem_1:getUuid())
	end

	if self._equipItem_2 and self._equipItem_2:getHeroId() and self._equipItem_2:getHeroId() > 0 and self._equipItem_2:getHeroId() ~= self._curHeroId then
		setList(self._equipItem_2:getHeroId(), self._equipItem_2:getUuid())
	end

	if self._equipItem_3 and self._equipItem_3:getHeroId() and self._equipItem_3:getHeroId() > 0 and self._equipItem_3:getHeroId() ~= self._curHeroId then
		setList(self._equipItem_3:getHeroId(), self._equipItem_3:getUuid())
	end

	if #tempHeroList ~= 0 then
		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 2, tempHeroList, self)
	else
		self:_confirmCallbackPreinstall()
	end
end

function M:_confirmCallbackPreinstall()
	local preinstallDate = {}

	preinstallDate.hero = self._curHeroId
	preinstallDate.id = self._thisPreinstallId

	CharacterPreinstallAgent.instance:sendApplyPresetRequest(preinstallDate)
end

function M:setNameEditable(isEditable)
	self._inputName.input.interactable = isEditable
end

function M:setCurPreinstallText()
	self._inputDefaultName.text = lang("tip_charcter_preinstall_current")

	self._inputName:SetText("")
end

function M:setCurButton()
	goutil.setActive(self._btnChange.gameObject, false)
	goutil.setActive(self._btnDelete.gameObject, false)
	goutil.setActive(self._btnSave.gameObject, true)
end

function M:setOriginalNameOfPreinstall()
	self._inputName:SetText(self._thisPreinstallName)
end

function M:_onEndEditInput()
	local newName = self._inputName:GetText()

	if string.utf8len(newName) > 7 then
		if enableLog then
			print("输入名称过长")
		end

		return
	end

	if string.nilorempty(newName) and self._isCurPreinstall ~= PresetItemType.Current then
		FloatWordMgr.instance:show(lang("tip_character_preinstall_name"))
		self._inputName:SetText(self._thisPreinstallName)

		return
	end

	if newName == self._thisPreinstallName then
		return
	end

	if self._isCurPreinstall == PresetItemType.Saves then
		local preinstallDate = {}

		preinstallDate.hero = self._curHeroId
		preinstallDate.id = self._thisPreinstallId
		preinstallDate.name = self._inputName:GetText()

		CharacterPreinstallAgent.instance:sendSavePresetRequest(preinstallDate, true, self)
	end
end

function M:_onTipsShow()
	local skillInfo = ToolTipsMgr.getSkillTipsInfo()

	skillInfo.heroId = self._curHeroId
	skillInfo.defaultShowAll = true
	skillInfo.hangGO = self._thinktTipsPosition

	if self._isCurPreinstall == PresetItemType.Current then
		skillInfo.skillId = self._curThinkingSkillId
	elseif self._isCurPreinstall == PresetItemType.Saves then
		skillInfo.skillId = self._thisPreinstallSkill
	elseif self._isCurPreinstall == PresetItemType.Recommended then
		skillInfo.skillId = self._recommendedSkillId
		skillInfo.level = ThinkingConfig.instance:getMaxThinkingSkillLevel(self._recommendedSkillId)
		skillInfo.enhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(self._recommendedSkillId)
	end

	ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
end

function M:getCurHeroData()
	local heroData = HeroDepotModel.instance:getHeroInfoByID(self._curHeroId)

	return heroData or false
end

return M
