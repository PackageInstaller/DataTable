-- chunkname: @modules/logic/fight/view/FightRouge2TreasureView.lua

module("modules.logic.fight.view.FightRouge2TreasureView", package.seeall)

local FightRouge2TreasureView = class("FightRouge2TreasureView", FightBaseView)

function FightRouge2TreasureView:onInitView()
	self.rectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.goTip = gohelper.findChild(self.viewGO, "#go_tips")

	gohelper.setActive(self.goTip, false)

	self.tipItem = gohelper.findChild(self.viewGO, "#go_tips/tips/#scroll_tips/viewport/content/#go_tipsitem")

	gohelper.setActive(self.tipItem, false)

	self.contentTr = gohelper.findChildComponent(self.viewGO, "#go_tips/tips/#scroll_tips/viewport/content", gohelper.Type_RectTransform)
	self.viewportTr = gohelper.findChildComponent(self.viewGO, "#go_tips/tips/#scroll_tips/viewport", gohelper.Type_RectTransform)
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "click")
	self.goClick = self.click.gameObject

	self:com_registClick(self.click, self.onClickThis)

	self.descClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_tips/#btn_click")

	self:com_registClick(self.descClick, self.onClickDesc)

	self.goBaseItem = gohelper.findChild(self.viewGO, "baseItem")

	gohelper.setActive(self.goBaseItem, false)

	self.descItemList = {}
	self.itemList = {}

	self:initConfig()
end

function FightRouge2TreasureView:onClickThis()
	FightController.instance:dispatchEvent(FightEvent.RightElements_SetElementAtLast, FightRightElementEnum.Elements.Rouge2Treasure)
	gohelper.setActive(self.goTip, true)
end

function FightRouge2TreasureView:onClickDesc()
	gohelper.setActive(self.goTip, false)
end

function FightRouge2TreasureView:initConfig()
	self.buffId2RelicCoDict = {}

	local configList = lua_fight_rouge2_check_relic.configList

	for _, config in ipairs(configList) do
		self.buffId2RelicCoDict[config.buff] = config
	end
end

function FightRouge2TreasureView:createBaseItem()
	local baseItem = self:getUserDataTb_()

	baseItem.go = gohelper.cloneInPlace(self.goBaseItem)
	baseItem.imageProgress = gohelper.findChildImage(baseItem.go, "#image_progress")
	baseItem.imageIcon = gohelper.findChildImage(baseItem.go, "image_icon")
	baseItem.txtLevel = gohelper.findChild(baseItem.go, "#txt_level")

	gohelper.setActive(baseItem.txtLevel, false)

	baseItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(baseItem.go)

	return baseItem
end

function FightRouge2TreasureView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)
end

function FightRouge2TreasureView:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if buffActInfo.actId ~= FightEnum.BuffActId.Rouge2CheckCount then
		return
	end

	self:refreshUI()
end

function FightRouge2TreasureView:onBuffUpdate(entityId, effectType, buffId, buffUid, configEffect, buffMo)
	if not self:hasRouge2CheckCountBuff(buffMo) then
		return
	end

	self:refreshUI()
end

function FightRouge2TreasureView:onOpen()
	self:initRelicList()
	self:refreshUI()
end

function FightRouge2TreasureView:refreshUI()
	self:refreshBaseItem()
	self:refreshDescItem()
	gohelper.setAsLastSibling(self.goClick)
end

function FightRouge2TreasureView:initRelicList()
	self.relicId2BuffIdListDict = {}

	local customData = FightDataHelper.fieldMgr.customData
	local rouge2Data = customData and customData[FightCustomData.CustomDataType.Rouge2]
	local str = rouge2Data and rouge2Data.buffId2CheckRelicMap

	if string.nilorempty(str) then
		self.buffId2RelicListDict = {}

		return
	end

	self.buffId2RelicListDict = cjson.decode(str)
end

function FightRouge2TreasureView:hideAllItem()
	for _, item in pairs(self.itemList) do
		gohelper.setActive(item.go, false)
	end
end

function FightRouge2TreasureView:refreshDescItem()
	local count = 0

	for buffId, relicList in pairs(self.buffId2RelicListDict) do
		for _, relicId in ipairs(relicList) do
			local co = self:getRelicCo(relicId)
			local typeCo = self:getTypeCo(co.attributeTag)

			count = count + 1

			local descItem = self.descItemList[count]

			if not descItem then
				descItem = self:getUserDataTb_()
				descItem.go = gohelper.cloneInPlace(self.tipItem)
				descItem.txtName = gohelper.findChildText(descItem.go, "title/#txt_name")
				descItem.txtDesc = gohelper.findChildText(descItem.go, "txt_desc")

				SkillHelper.addHyperLinkClick(descItem.txtDesc, self.onClickHyperLink, self)

				descItem.txtProgress = gohelper.findChildText(descItem.go, "title/#txt_progress")

				table.insert(self.descItemList, descItem)
			end

			gohelper.setActive(descItem.go, true)
			gohelper.setAsLastSibling(descItem.go)

			local relicsCo = Rouge2_BackpackHelper.getItemConfig(relicId)

			descItem.txtName.text = string.format("<color=#%s>%s</color>", typeCo.color, relicsCo and relicsCo.name)
			descItem.txtDesc.text = FightRouge2TreasureView.getDescTxt(relicsCo.desc)

			local value = self:getRouge2CheckCountValue(buffId)
			local max = co.limit

			descItem.txtProgress.text = max > 0 and string.format("%d/%d", value, max) or ""
		end
	end

	for i = count + 1, #self.descItemList do
		local descItem = self.descItemList[i]

		if descItem then
			gohelper.setActive(descItem.go, false)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self.contentTr)
end

FightRouge2TreasureView.offsetX = 45
FightRouge2TreasureView.offsetY = -60

function FightRouge2TreasureView:onClickHyperLink(effId, clickPosition)
	local contentScreenPos = recthelper.uiPosToScreenPos(self.viewportTr)

	contentScreenPos.x = contentScreenPos.x + FightRouge2TreasureView.offsetX
	contentScreenPos.y = contentScreenPos.y + FightRouge2TreasureView.offsetY

	CommonBuffTipController.instance:openCommonTipView(effId, contentScreenPos)
end

function FightRouge2TreasureView.getDescTxt(desc)
	local customData = FightDataHelper.fieldMgr.customData
	local paramDict = customData and customData:getRouge2AttrParam()

	desc = Rouge2_ItemExpressionHelper.getDescResult(paramDict, nil, desc, true)
	desc = SkillHelper.buildDesc(desc)

	return desc
end

FightRouge2TreasureView.ItemHeight = 95

function FightRouge2TreasureView:refreshBaseItem()
	self:hideAllItem()

	local count = 0

	for buffId, relicList in pairs(self.buffId2RelicListDict) do
		for _, relicId in ipairs(relicList) do
			local co = self:getRelicCo(relicId)
			local typeCo = self:getTypeCo(co.attributeTag)

			count = count + 1

			local item = self.itemList[count]

			if not item then
				item = self:createBaseItem()

				table.insert(self.itemList, item)
			end

			gohelper.setActive(item.go, true)
			gohelper.setAsLastSibling(item.go)
			UISpriteSetMgr.instance:setFightSprite(item.imageProgress, typeCo.progressIcon)
			UISpriteSetMgr.instance:setFightSprite(item.imageIcon, typeCo.icon)

			local value = self:getRouge2CheckCountValue(buffId)
			local max = co.limit

			if max > 0 then
				item.imageProgress.fillAmount = value / max

				if max <= value then
					item.animatorPlayer:Play("full")
					AudioMgr.instance:trigger(20320607)
				end
			else
				item.imageProgress.fillAmount = 1
			end
		end
	end

	local height = count * FightRouge2TreasureView.ItemHeight

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge2Treasure, height)
	recthelper.setHeight(self.rectTr, height)
end

function FightRouge2TreasureView:getRelicCo(relicId)
	local co = relicId and lua_fight_rouge2_check_relic.configDict[relicId]

	if not co then
		logError("rouge2 relic co is nil, relicId : " .. tostring(relicId))

		co = lua_fight_rouge2_check_relic.configList[1]
	end

	return co
end

function FightRouge2TreasureView:getTypeCo(typeId)
	local co = lua_fight_rouge2_relic_type.configDict[typeId]

	if not co then
		logError("type co is nil, typeId : " .. tostring(typeId))

		co = lua_fight_rouge2_relic_type.configList[1]
	end

	return co
end

function FightRouge2TreasureView:getRouge2CheckCountValue(buffId)
	local entityDict = FightDataHelper.entityMgr:getAllEntityData()

	buffId = tonumber(buffId)

	for _, entityMo in pairs(entityDict) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			if buffMo.buffId == buffId then
				local buffActList = buffMo.actInfo

				if buffActList then
					for _, buffAct in ipairs(buffActList) do
						if buffAct.actId == FightEnum.BuffActId.Rouge2CheckCount then
							return buffAct.param[1]
						end
					end
				end

				return 0
			end
		end
	end

	return 0
end

function FightRouge2TreasureView:hasRouge2CheckCountBuff(buffMo)
	local buffActList = buffMo and buffMo.actInfo

	if buffActList then
		for _, buffAct in ipairs(buffActList) do
			if buffAct.actId == FightEnum.BuffActId.Rouge2CheckCount then
				return true
			end
		end
	end

	return false
end

function FightRouge2TreasureView:onDestroyView()
	return
end

return FightRouge2TreasureView
