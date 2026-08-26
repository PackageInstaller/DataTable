-- chunkname: @modules/logic/character/view/CharacterRankUpView.lua

module("modules.logic.character.view.CharacterRankUpView", package.seeall)

local CharacterRankUpView = class("CharacterRankUpView", BaseView)

function CharacterRankUpView:onInitView()
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._simagecenterbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_centerbg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gospineContainer = gohelper.findChild(self.viewGO, "spineContainer")
	self._gospine = gohelper.findChild(self.viewGO, "spineContainer/#go_spine")
	self._goitems = gohelper.findChild(self.viewGO, "#go_items")
	self._goitem = gohelper.findChild(self.viewGO, "#go_items/#go_item")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_items/level/#txt_level")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_items/level/#txt_count")
	self._goranknormal = gohelper.findChild(self.viewGO, "rank/#go_ranknormal")
	self._goranklarge = gohelper.findChild(self.viewGO, "rank/#go_ranklarge")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_upgrade")
	self._goupgradeeffect = gohelper.findChild(self.viewGO, "#btn_upgrade/#go_levelupbeffect")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "txt_onceCombine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRankUpView:addEvents()
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
end

function CharacterRankUpView:removeEvents()
	self._btnupgrade:RemoveClickListener()
end

CharacterRankUpView.characterTalentLevel = {
	[2] = 10,
	[3] = 15
}

function CharacterRankUpView:_btnupgradeOnClick(notMsgBox)
	if not CharacterModel.instance:isHeroRankReachCeil(self.viewParam.heroId) then
		local rankCo = SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1)
		local consumes = string.split(rankCo.consume, "|")
		local consumeCos = {}

		for i = 1, #consumes do
			local consume = string.splitToNumber(consumes[i], "#")
			local o = {}

			o.type = consume[1]
			o.id = consume[2]
			o.quantity = consume[3]

			table.insert(consumeCos, o)
		end

		local levelNeed = 0
		local demands = string.split(rankCo.requirement, "|")

		for _, v in pairs(demands) do
			local demand = string.split(v, "#")

			if demand[1] == "1" then
				levelNeed = tonumber(demand[2])
			end
		end

		if levelNeed > self.viewParam.level then
			GameFacade.showToast(ToastEnum.CharacterRankUp)

			return
		end

		local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(consumeCos)

		if not enough then
			if self._canEasyCombine then
				PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
				RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onEasyCombineFinished, self)

				return
			else
				GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

				return
			end
		end

		if notMsgBox then
			self:_confirmRankUp()
		else
			local heroname = HeroConfig.instance:getHeroCO(self.viewParam.heroId).name

			GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRankup, MsgBoxEnum.BoxType.Yes_No, self._confirmRankUp, nil, nil, self, nil, nil, heroname)
		end
	end
end

function CharacterRankUpView:_confirmRankUp()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshItems, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItems, self)
	HeroRpc.instance:sendHeroRankUpRequest(self.viewParam.heroId, self._onReceiveHeroRankUp, self)
end

function CharacterRankUpView:_onEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnupgradeOnClick(true)
end

function CharacterRankUpView:_onReceiveHeroRankUp(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshItems, self)
		self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
		self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItems, self)
	end
end

function CharacterRankUpView:selfViewIsTop()
	self.ignoreViewList = self.ignoreViewList or {
		ViewName.CharacterTipView,
		ViewName.CommonBuffTipView,
		ViewName.ShareTipView
	}

	return ViewHelper.instance:checkViewOnTheTop(self.viewName, self.ignoreViewList)
end

function CharacterRankUpView:_onCloseView()
	local isTop = self:selfViewIsTop()

	gohelper.setActive(self._gospineContainer, isTop)

	if self.needReloadSpine and isTop and self._uiSpine and self._uiSpine:isSpine() then
		self.needReloadSpine = false

		gohelper.onceAddComponent(self._uiSpine:_getSpine()._rawImageGo, typeof(ZProj.UISpineImage)):RefreshLayer()
	end
end

function CharacterRankUpView:_onOpenView()
	gohelper.setActive(self._gospineContainer, self:selfViewIsTop())
end

function CharacterRankUpView:_editableInitView()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self, LuaEventSystem.High)
	self._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self._uiSpine:useRT()

	self._items = {}
	self._norrank = {}
	self._norrank.insights = {}
	self._effect = gohelper.findChild(self._goeffect, "#scroll_info/viewport/effect")

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._goranknormal, "insightlight" .. tostring(i))
		o.lights = {}

		for j = 1, i do
			table.insert(o.lights, gohelper.findChild(o.go, "star" .. j))
		end

		self._norrank.insights[i] = o
	end

	self._norrank.eyes = self:getUserDataTb_()

	for i = 1, 2 do
		table.insert(self._norrank.eyes, gohelper.findChild(self._goranknormal, "eyes/eye" .. tostring(i)))
	end

	self._uprank = {}
	self._uprank.insights = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._goranklarge, "insightlight" .. tostring(i))
		o.lights = {}

		for j = 1, i do
			table.insert(o.lights, gohelper.findChild(o.go, "star" .. j))
		end

		self._uprank.insights[i] = o
	end

	self._uprank.eyes = self:getUserDataTb_()

	for i = 1, 2 do
		table.insert(self._uprank.eyes, gohelper.findChild(self._goranklarge, "eyes/eye" .. tostring(i)))
	end

	self._effects = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._effect, "effect" .. tostring(i))
		o.txt = gohelper.findChildText(self._effect, "effect" .. tostring(i))
		self._effects[i] = o
	end

	self:_initSpecialEffectItem()

	self._hyperLinkClick = self._effects[2].txt.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._viewAnim:Play(UIAnimationName.Open)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function CharacterRankUpView:_initSpecialEffectItem()
	self._specialEffectItem = self:getUserDataTb_()

	local specailEffectItemGo = gohelper.findChild(self._effect, "SpecialEffect")
	local item = self:getUserDataTb_()

	item.go = specailEffectItemGo
	item.txt = gohelper.findChildText(specailEffectItemGo, "#txt_SpecialEffect")
	self._specialEffectItem[1] = item

	gohelper.setSibling(item.go, 0)

	local item1 = self:getUserDataTb_()

	item1.go = gohelper.cloneInPlace(specailEffectItemGo)
	item1.txt = gohelper.findChildText(item1.go, "#txt_SpecialEffect")

	gohelper.setSibling(item1.go, 1)

	self._specialEffectItem[2] = item1
end

function CharacterRankUpView:_onHyperLinkClick(skillName)
	local info = {}

	info.tag = "passiveskill"
	info.heroid = self.viewParam.heroId
	info.tipPos = Vector2.New(-292, -51.1)
	info.anchorParams = {
		Vector2.New(1, 0.5),
		Vector2.New(1, 0.5)
	}
	info.buffTipsX = -776

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	CharacterController.instance:openCharacterTipView(info)
end

function CharacterRankUpView:_onSpineLoaded()
	if self._uiSpine:isSpine() and self.viewGO.transform.parent.name == "POPUPBlur" then
		self.needReloadSpine = true
	end

	self._uiSpine:setUIMask(true)
end

function CharacterRankUpView:onOpen()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshItems, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItems, self)
	self:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, self.viewContainer.refreshHelp, self.viewContainer)
	self:_initItems()
	self:_refreshView()
end

function CharacterRankUpView:_initItems()
	local rankCo = SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1)

	if not rankCo then
		return
	end

	local consumes = string.split(rankCo.consume, "|")

	for i = 1, #consumes do
		local path = self.viewContainer:getSetting().otherRes[1]
		local child = self:getResInst(path, self._goitem)
		local o = self:getUserDataTb_()

		o.go = child
		o.rare = child:GetComponent(typeof(UnityEngine.UI.Image))
		o.icon = gohelper.findChild(o.go, "icon")
		self._items[i] = o
	end
end

function CharacterRankUpView:onOpenFinish()
	if self.viewParam.level == 30 then
		CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideInsight)
	end
end

function CharacterRankUpView:onUpdateParam()
	self:_refreshView()
end

function CharacterRankUpView:_onOpenViewFinish(viewName)
	if viewName == ViewName.CharacterGetView then
		self:closeThis()
	end
end

function CharacterRankUpView:_refreshView()
	self:_refreshSpine()
	self:_refreshItems()
	self:_refreshRank()
	self:_refreshEffect()
	self:_refreshButton()
end

function CharacterRankUpView:_refreshSpine()
	local skinCo = SkinConfig.instance:getSkinCo(self.viewParam.skin)

	self._uiSpine:setResPath(skinCo, self._onSpineLoaded, self)

	local offsetStr = skinCo.characterRankUpViewOffset
	local offsets

	if string.nilorempty(offsetStr) then
		offsets = SkinConfig.instance:getSkinOffset(skinCo.characterViewOffset)
		offsets = SkinConfig.instance:getAfterRelativeOffset(503, offsets)
	else
		offsets = SkinConfig.instance:getSkinOffset(offsetStr)
	end

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterRankUpView:_refreshItems()
	local rankCo = SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1)

	if not rankCo then
		gohelper.setActive(self._goitems, false)
		gohelper.setActive(self._gocaneasycombinetip, false)

		return
	end

	gohelper.setActive(self._goitems, true)

	local demands = string.split(rankCo.requirement, "|")

	for _, v in pairs(demands) do
		local demand = string.split(v, "#")

		if demand[1] == "1" then
			local showLevel = HeroConfig.instance:getShowLevel(self.viewParam.level)
			local showMaxLevel = HeroConfig.instance:getShowLevel(tonumber(demand[2]))

			self._txtlevel.text = showMaxLevel
			self._txtcount.text = showLevel < showMaxLevel and "<color=#cd5353>" .. tostring(showLevel) .. "</color>" .. "/" .. showMaxLevel or tostring(showLevel) .. "/" .. showMaxLevel
		end
	end

	local consumes = string.split(rankCo.consume, "|")
	local consumeCos = {}

	for i = 1, #consumes do
		local consume = string.splitToNumber(consumes[i], "#")
		local o = {}

		o.type = tonumber(consume[1])
		o.id = tonumber(consume[2])
		o.quantity = tonumber(consume[3])
		o.rare = ItemModel.instance:getItemConfig(o.type, o.id).rare

		table.insert(consumeCos, o)
	end

	for i = 1, #consumeCos do
		gohelper.setActive(self._items[i].go, i <= #consumeCos)
	end

	self._lackedItemDataList = {}
	self._occupyItemDic = {}

	for i = 1, #consumeCos do
		local type = consumeCos[i].type
		local id = consumeCos[i].id
		local costQuantity = consumeCos[i].quantity

		self._items[i].item = self._items[i].item or IconMgr.instance:getCommonItemIcon(self._items[i].icon)

		self._items[i].item:setMOValue(type, id, costQuantity)
		self._items[i].item:setConsume(true)
		self._items[i].item:setCountFontSize(38)

		local countTxt = self._items[i].item:getCount()

		self._items[i].item:setRecordFarmItem({
			type = type,
			id = id,
			quantity = costQuantity
		})
		self._items[i].item:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)

		local quantity = ItemModel.instance:getItemQuantity(type, id)

		if costQuantity <= quantity then
			countTxt.text = type == MaterialEnum.MaterialType.Currency and tostring(GameUtil.numberDisplay(costQuantity)) or tostring(GameUtil.numberDisplay(quantity)) .. "/" .. tostring(GameUtil.numberDisplay(costQuantity))
			self._occupyItemDic[type] = self._occupyItemDic[type] or {}
			self._occupyItemDic[type][id] = (self._occupyItemDic[type][id] or 0) + costQuantity
		else
			countTxt.text = type == MaterialEnum.MaterialType.Currency and "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(costQuantity)) .. "</color>" or "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(quantity)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(costQuantity))

			local lackedQuantity = costQuantity - quantity

			table.insert(self._lackedItemDataList, {
				type = type,
				id = id,
				quantity = lackedQuantity
			})
		end
	end

	self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, self._occupyItemDic)
	self._occupyItemDic = nil

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
end

function CharacterRankUpView:_refreshRank()
	local haseff = self:_hasEffect()

	gohelper.setActive(self._goranknormal, haseff)
	gohelper.setActive(self._goranklarge, not haseff)

	if haseff then
		if not self._norrank then
			local rankConfig = self._uprank
			local rare = self.viewParam.config.rare
			local rank = HeroModel.instance:getByHeroId(self.viewParam.heroId).rank
			local target = HeroConfig.instance:getMaxRank(rare)

			for i = 1, 3 do
				gohelper.setActive(rankConfig.insights[i].go, target == i)

				for j = 1, i do
					if j <= rank - 1 then
						SLFramework.UGUI.GuiHelper.SetColor(rankConfig.insights[i].lights[j]:GetComponent("Image"), "#f59d3d")
					else
						SLFramework.UGUI.GuiHelper.SetColor(rankConfig.insights[i].lights[j]:GetComponent("Image"), "#646161")
					end
				end
			end

			gohelper.setActive(rankConfig.eyes[1], target ~= rank - 1)
			gohelper.setActive(rankConfig.eyes[2], target == rank - 1)
		end
	end
end

function CharacterRankUpView:_refreshEffect()
	local haseff = self:_hasEffect()

	if not haseff then
		gohelper.setActive(self._goeffect, false)

		return
	end

	gohelper.setActive(self._goeffect, true)
	self:_refreshSpecialEffect()

	local effects = string.split(SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1).effect, "|")

	for i = 1, 5 do
		gohelper.setActive(self._effects[i].go, i <= #effects)
	end

	for i = 1, #effects do
		local effect = string.split(effects[i], "#")
		local desc = self:_getEffectTxt(effect[1], effect[2])

		if desc then
			self._effects[i].txt.text = desc
		else
			gohelper.setActive(self._effects[i].go, false)
		end
	end

	local heroMo = HeroModel.instance:getByHeroId(self.viewParam.heroId)
	local rank = heroMo.rank

	if rank > 1 then
		local formatStr = luaLang("talent_characterrankup_talentlevellimit" .. heroMo:getTalentTxtByHeroType())

		self._effects[5].txt.text = string.format(formatStr, CharacterRankUpView.characterTalentLevel[rank])
	end

	gohelper.setActive(self._effects[5].go, rank > 1)
	self:_checkExtra(heroMo)
end

function CharacterRankUpView:_checkExtra(heroMo)
	if heroMo.extraMo then
		local showTxt
		local nextRank = self.viewParam.rank + 1
		local mo = heroMo.extraMo:getSkillTalentMo()

		if mo then
			showTxt = mo:getUnlockRankStr(nextRank)
		end

		if heroMo.extraMo:hasWeapon() then
			local mo = heroMo.extraMo:getWeaponMo()

			if mo then
				showTxt = mo:getUnlockRankStr(nextRank)
			end
		end

		if showTxt then
			local index = 6

			for _, txt in ipairs(showTxt) do
				local item = self:_getEffectItem(index)

				item.txt.text = txt
				index = index + 1
			end
		end
	end
end

function CharacterRankUpView:_getEffectItem(index)
	local item = self._effects[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._effects[1].go, "effect" .. index)

		item.go = go
		item.txt = go:GetComponent(typeof(TMPro.TMP_Text))
		self._effects[index] = item
	end

	return item
end

function CharacterRankUpView:_getEffectTxt(type, value)
	type = tonumber(type)

	local result

	if type == 1 then
		local tag = {
			self.viewParam.config.name,
			HeroConfig.instance:getShowLevel(tonumber(value))
		}

		result = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankup_levellimit"), tag)
	elseif type == 2 then
		local pskillid = SkillConfig.instance:getpassiveskillCO(self.viewParam.heroId, 1).skillPassive
		local skillCo = lua_skill.configDict[pskillid]

		if skillCo then
			local skillname = string.format("<u><link=%s>%s</link></u>", skillCo.name, skillCo.name)

			result = string.format(luaLang("character_rankup_skill"), skillname)
		end
	elseif type == 3 then
		if not CharacterEnum.SkinOpen then
			return nil
		end

		local skinCo = SkinConfig.instance:getSkinCo(tonumber(value))

		result = string.format(luaLang("character_rankup_skinunlock"), tostring(skinCo.name))
	elseif type == 4 then
		result = luaLang("character_rankup_attribute")
	end

	return result
end

function CharacterRankUpView:_refreshSpecialEffect()
	local descList = CharacterModel.instance:getSpecialEffectDesc(self.viewParam.skin, self.viewParam.rank)
	local count = 0

	if descList then
		for i, desc in ipairs(descList) do
			self._specialEffectItem[i].txt.text = desc
			count = count + 1
		end
	end

	for i = 1, #self._specialEffectItem do
		gohelper.setActive(self._specialEffectItem[i].go, i <= count)
	end
end

function CharacterRankUpView:_hasEffect()
	local rankCo = SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1)

	if rankCo and rankCo.effects ~= "" then
		return true
	end

	return false
end

function CharacterRankUpView:_refreshButton()
	gohelper.setActive(self._btnupgrade.gameObject, not self:_hasfull())

	if self:_hasfull() then
		return
	end

	local rankCo = SkillConfig.instance:getherorankCO(self.viewParam.heroId, self.viewParam.rank + 1)
	local consumes = string.split(rankCo.consume, "|")
	local consumeCos = {}

	for i = 1, #consumes do
		local consume = string.splitToNumber(consumes[i], "#")
		local o = {}

		o.type = consume[1]
		o.id = consume[2]
		o.quantity = consume[3]

		table.insert(consumeCos, o)
	end

	local _, enough, _ = ItemModel.instance:hasEnoughItems(consumeCos)
	local demands = string.split(rankCo.requirement, "|")
	local levelNeed = 0

	for _, v in pairs(demands) do
		local demand = string.splitToNumber(v, "#")

		if demand[1] == 1 then
			levelNeed = demand[2]
		end
	end

	gohelper.setActive(self._goupgradeeffect, enough and levelNeed <= self.viewParam.level)
end

function CharacterRankUpView:_hasfull()
	return self.viewParam.rank == CharacterModel.instance:getMaxRank(self.viewParam.heroId)
end

function CharacterRankUpView:onClose()
	if not self._uiSpine then
		return
	end

	self._uiSpine:setModelVisible(false)
end

function CharacterRankUpView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simagecenterbg:UnLoadImage()

	if self._items then
		self._items = nil
	end
end

return CharacterRankUpView
