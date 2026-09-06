-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/CheckupdetailView.lua

module("logic.extensions.handbook.view.CheckupdetailView", package.seeall)

local CheckupdetailView = class("CheckupdetailView", ViewComponent)

function CheckupdetailView:ctor()
	CheckupdetailView.super.ctor(self)
end

function CheckupdetailView:bindEvents()
	CheckupdetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnRecommend, self.onGift, self)
end

function CheckupdetailView:unbindEvents()
	CheckupdetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRecommend)
end

function CheckupdetailView:buildUI()
	CheckupdetailView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnRecommend = self:getGo("left/btnRecommend")
	self.equip = self:getGo("left/equip")
	self.item = self:getGo("left/item")
	self.txtTitle = self:getTxt("left/txtTitle")
	self.imgEmpty = self:getGo("left/imgEmpty")
	self.level = self:getGo("left/level")
	self.itemTemp = self:getGo("left/level/itemTemp")
	self.skillTemp = self:getGo("left/level/skillTemp")
	self.cellTemp = self:getGo("left/level/cellTemp")
	self.txtLevelNow = self:getTxt("left/level/txtNow/txtLevel")
	self.itemConNow = self:getGo("left/level/txtNow/itemCon")
	self.txtLevelMax = self:getTxt("left/level/txtMax/txtLevel")
	self.itemConMax = self:getGo("left/level/txtMax/itemCon")
	self.txtSpace = self:getTxt("right/upSpace/txtSpace")
	self.tableview = self:getGo("right/tableview")
	self.cell = self:getGo("right/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function CheckupdetailView:onExit()
	CheckupdetailView.super.onExit(self)
	self.scrollList:dispose()
end

function CheckupdetailView:onEnter()
	CheckupdetailView.super.onEnter(self)

	local params = self:getOpenParam()
	local petMo = params[1]
	local idx = checknumber(params[2])
	local type = checknumber(params[3])
	local per = checknumber(params[4])

	SurveyController.instance:reportBehavior(200463, idx)

	self.giftStr = ""

	local cfg = HandbookConfig.instance:getPowerCheckDefine(idx)

	self.curCfg = cfg

	if cfg then
		if type == PowerCheckModel.TYPE_LOW then
			self.giftStr = table.concat(cfg.lowGiftIdList or {}, "#")
		elseif type == PowerCheckModel.TYPE_HIGH then
			self.giftStr = table.concat(cfg.highGiftIdList or {}, "#")
		end

		self.txtTitle.text = cfg.desc
		self.txtSpace.text = langPara("checkupdetailview__space", math.floor((1 - per) * 100))

		self:updateLeftUI(petMo, idx)

		local list = HandbookConfig.instance:getPowerCheckStrategyCfg(cfg.strategyId)

		self.scrollList:reloadData(list)
	else
		self:close()
	end
end

function CheckupdetailView:updateLeftUI(petMo, type)
	goutil.clearChildren(self.equip)
	goutil.clearChildren(self.itemConNow)
	goutil.clearChildren(self.itemConMax)
	GameUtil.SetActive(self.level, false)
	GameUtil.SetActive(self.imgEmpty, false)

	self.txtLevelNow.text = ""
	self.txtLevelMax.text = ""

	if type == 1 then
		GameUtil.SetActive(self.level, true)

		self.txtLevelNow.text = langPara("checkupdetailview__lvl", petMo.level)

		local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
		local maxLvl = petCo.maxLv

		self.txtLevelMax.text = langPara("checkupdetailview__lvl", maxLvl)
	elseif type == 2 then
		GameUtil.SetActive(self.level, true)

		self.txtLevelNow.text = CharacterConfig.instance:getTalentName(petMo.raceId, petMo.talentLevel)

		local max = FightingPowerPetMo._getMaxTalentLevel(petMo.raceId) or 1

		self.txtLevelMax.text = CharacterConfig.instance:getTalentName(petMo.raceId, max)
	elseif type == 3 then
		GameUtil.SetActive(self.level, true)

		if checknumber(petMo.awakeLevel) > 0 then
			local num = GameUtil.toRomanNumber(checknumber(petMo.awakeLevel))

			self.txtLevelNow.text = langPara("checkupdetailview__awaken", num)
		else
			self.txtLevelNow.text = lang("checkupdetailview__not_awaken")
		end

		local max = FightingPowerPetMo._getMaxAwakenLevel(petMo.raceId) or 1

		if checknumber(max) > 0 then
			local num = GameUtil.toRomanNumber(checknumber(max))

			self.txtLevelMax.text = langPara("checkupdetailview__awaken", num)
		else
			self.txtLevelMax.text = lang("checkupdetailview__not_awaken")
		end
	elseif type == 4 then
		local list = {}
		local exclInfo = {}

		for _, v in pairs(petMo.equipments) do
			if v.defineId and v.lv then
				local equipInfo = EquipInfoMo.New()

				exclInfo.exclRaceId = checknumber(v.bonusRaceId)
				exclInfo.wearOnlyId = checknumber(petMo.petId)

				equipInfo:GetTemporaryEquip(v.defineId, v.lv, exclInfo)
				table.insert(list, equipInfo)
			else
				local equip = PetEquipModel.instance:GetEquipInfo(v.id)

				if equip then
					table.insert(list, equip)
				end
			end
		end

		for i, v in ipairs(list) do
			local item = goutil.clone(self.itemTemp)

			GameUtil.SetActive(item, true)
			GameUtil.setLocalScale(item, 0.7, 0.7, 0.7)
			MaterialMgr.setCellByMo(v, item)
			goutil.addChildToParent(item, self.equip)
		end

		GameUtil.SetActive(self.imgEmpty, #list == 0)
	elseif type == 5 then
		local list = {}
		local slotDatas = petMo:getStarGodPlusSlots()

		for _, slotData in ipairs(slotDatas) do
			if slotData.fillerDefineId > 0 then
				local item = goutil.clone(self.itemTemp)

				GameUtil.SetActive(item, true)
				GameUtil.setLocalScale(item, 0.7, 0.7, 0.7)

				local cell = goutil.clone(self.cellTemp)

				GameUtil.SetActive(cell, true)
				goutil.addChildToParent(cell, item)
				GameUtil.setLocalPos(cell, 0, 0, 0)
				goutil.addChildToParent(item, self.equip)

				local iconGo = goutil.findChild(cell, "icon")
				local raycast = goutil.findChild(cell, "raycast")
				local lockGo = goutil.findChild(cell, "lock")
				local lvText = goutil.findChildTextComponent(cell, "lvText")
				local lv = StargodplusModel.instance:getSlotLv(slotData.slot, slotData.exp)

				lvText.text = "Lv." .. lv

				MaterialMgr.setIcon(iconGo, MatType.StarGodPlus, slotData.fillerDefineId)
				table.insert(list, slotData.fillerDefineId)
			end
		end

		GameUtil.SetActive(self.imgEmpty, #list == 0)
	elseif type == 6 then
		GameUtil.SetActive(self.level, true)

		local arr = {
			petMo.passiveSkillLv,
			petMo.normalSkillLv,
			petMo.ultimateSkillLv
		}

		for i, v in ipairs(arr) do
			local item = goutil.clone(self.itemTemp)

			GameUtil.SetActive(item, true)

			local cell = goutil.clone(self.skillTemp)

			GameUtil.SetActive(cell, true)
			goutil.addChildToParent(cell, item)
			GameUtil.setLocalPos(cell, 0, 0, 0)
			goutil.addChildToParent(item, self.itemConNow)
			GameUtil.setUIImageSpriteIdx(cell, i - 1)

			local txt = goutil.findChildTextComponent(cell, "txt")

			txt.text = "lv." .. v
		end

		local petCo = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)
		local skillLevelStrategyId = petCo.skillLevelStrategyId
		local passiveSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PASSIVE)
		local normalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.NORMAL)
		local ultimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.ULTIMATE)
		local psychicedNormalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_NORMAL)
		local psychicedUltimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, GameEnum.SeverSkillType.PSYCHICED_ULTIMATE)
		local arr = {
			passiveSkillLv,
			normalSkillLv,
			ultimateSkillLv,
			psychicedUltimateSkillLv,
			psychicedNormalSkillLv
		}

		for i, v in ipairs(arr) do
			local item = goutil.clone(self.itemTemp)

			GameUtil.SetActive(item, true)

			local cell = goutil.clone(self.skillTemp)

			GameUtil.SetActive(cell, true)
			goutil.addChildToParent(cell, item)
			GameUtil.setLocalPos(cell, 0, 0, 0)
			goutil.addChildToParent(item, self.itemConMax)
			GameUtil.setUIImageSpriteIdx(cell, i - 1)

			local txt = goutil.findChildTextComponent(cell, "txt")

			txt.text = "lv." .. v
		end
	elseif type == 7 then
		GameUtil.SetActive(self.level, true)

		local num = #petMo.collectRelationIds
		local list = CharacterConfig.instance:getBondCfgsCollectIds(petMo.raceId) or {}

		self.txtLevelNow.text = langPara("checkupdetailview__bond", num)
		self.txtLevelMax.text = langPara("checkupdetailview__bond", #list)
	end
end

function CheckupdetailView:clearCell(cell)
	return
end

function CheckupdetailView:_updateCell(view, cell, data, tag)
	local txtTask = goutil.findChildTextComponent(cell, "txtTask")
	local btnSure = goutil.findChild(cell, "btnSure")

	txtTask.text = data.desc

	GameUtil.rmClickHandler(btnSure)
	GameUtil.addClickHandler(btnSure, function()
		self:close()
		GotoMgr.gotoByString(data.jumpTo)
	end)
end

function CheckupdetailView:onGift()
	local goodsCfg = self:getCanBuyCfg()

	if goodsCfg ~= nil then
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(goodsCfg.id)
		local data = {
			id = goodsCfg.id,
			times = buyTimes
		}

		UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
	else
		TipsFacade.instance:openCommonTips(lang("checkupdetailview__gift"))
	end
end

function CheckupdetailView:getCanBuyCfg()
	local arr = string.splitToNumber(self.giftStr, "#")

	for i, v in ipairs(arr) do
		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(v)

		if self:checkCanBuy(goodsCfg) then
			return goodsCfg
		end
	end

	return nil
end

function CheckupdetailView:checkCanBuy(goodsCfg)
	if goodsCfg.sellTargetLimit ~= "none" and goodsCfg.limitTimes > 0 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(goodsCfg.id)

		if times >= goodsCfg.limitTimes then
			return false
		end
	end

	if not PayShopController.instance:checkTimeStr(goodsCfg.sellTime) then
		return false
	end

	if not FuncOpenController.instance:getConditionReached(goodsCfg.openCondition) then
		return false
	end

	return true
end

return CheckupdetailView
