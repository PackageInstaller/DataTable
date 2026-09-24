-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessCard.lua

module("modules.logic.autochess.main.view.comp.AutoChessCard", package.seeall)

local AutoChessCard = class("AutoChessCard", LuaCompBase)

AutoChessCard.ShowType = {
	HandBook = 4,
	Buy = 1,
	ForcePick = 3,
	Sell = 2
}

function AutoChessCard:init(go)
	self._go = go
	self._imageBg = gohelper.findChildImage(go, "critters/image_bg")
	self._goMesh = gohelper.findChild(go, "critters/Mesh")
	self._txtName = gohelper.findChildText(go, "critters/#txt_Name")
	self._goRaceItem = gohelper.findChild(go, "layout/TypeList/#go_RaceItem")
	self._goHp = gohelper.findChild(go, "#go_Hp")
	self._txtHp = gohelper.findChildText(go, "#go_Hp/#txt_Hp")
	self._goAttack = gohelper.findChild(go, "#go_Attack")
	self._txtAttack = gohelper.findChildText(go, "#go_Attack/#txt_Attack")
	self._goLevel = gohelper.findChild(go, "#go_Level")
	self._imageLevel = gohelper.findChildImage(go, "#go_Level/#image_Level")
	self._txtLevel = gohelper.findChildText(go, "#go_Level/#txt_Level")
	self._goStar = gohelper.findChild(go, "#go_Level/#go_Star")
	self._goStar1 = gohelper.findChild(go, "#go_Level/#go_Star/#go_Star1")
	self._goLight1 = gohelper.findChildImage(go, "#go_Level/#go_Star/#go_Star1/#go_Light1")
	self._goStar2 = gohelper.findChild(go, "#go_Level/#go_Star/#go_Star2")
	self._goLight2 = gohelper.findChildImage(go, "#go_Level/#go_Star/#go_Star2/#go_Light2")
	self._goStar3 = gohelper.findChild(go, "#go_Level/#go_Star/#go_Star3")
	self._goLight3 = gohelper.findChildImage(go, "#go_Level/#go_Star/#go_Star3/#go_Light3")
	self._goArrow = gohelper.findChild(go, "#go_arrow")
	self._txtSkillDesc = gohelper.findChildText(go, "layout/scroll_desc/viewport/#txt_SkillDesc")
	self._imageTag = gohelper.findChildImage(go, "#image_Tag")
	self._btnSell = gohelper.findChildButtonWithAudio(go, "#btn_Sell")
	self._txtSellCoin = gohelper.findChildText(go, "#btn_Sell/#txt_SellCoin")
	self._btnBuy = gohelper.findChildButtonWithAudio(go, "#btn_Buy")
	self._txtBuyCost = gohelper.findChildText(go, "#btn_Buy/#txt_BuyCost")
	self._imageBuyCost = gohelper.findChildImage(go, "#btn_Buy/#txt_BuyCost/#image_BuyCost")
	self._goNotEnough = gohelper.findChild(go, "#btn_Buy/#go_notEnough")
	self._btnFree = gohelper.findChildButtonWithAudio(go, "#btn_Free")
	self._btnFull = gohelper.findChildButtonWithAudio(go, "#btn_Full")
	self._txtBuyCost1 = gohelper.findChildText(go, "#btn_Full/#txt_BuyCost1")
	self._imageBuyCost1 = gohelper.findChildImage(go, "#btn_Full/#txt_BuyCost1/#image_BuyCost1")
	self._btnSelect = gohelper.findChildButtonWithAudio(go, "#btn_Select")
	self._goSkillTip = gohelper.findChild(go, "#go_SkillTip")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(go, "#go_SkillTip/#btn_CloseTip")
	self._txtSkillTipTitle = gohelper.findChildText(go, "#go_SkillTip/#txt_SkillTipTitle")
	self._txtSkillTip = gohelper.findChildText(go, "#go_SkillTip/scroll_tips/viewport/#txt_SkillTip")
	self._btnCheck = gohelper.findChildButtonWithAudio(go, "#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCard:addEventListeners()
	self._btnSell:AddClickListener(self._btnSellOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnFree:AddClickListener(self._btnFreeOnClick, self)
	self._btnFull:AddClickListener(self._btnFullOnClick, self)
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self._btnCloseTip:AddClickListener(self._btnCloseTipOnClick, self)
	self._btnCheck:AddClickListener(self._btnCheckOnClick, self)
end

function AutoChessCard:removeEventListeners()
	self._btnSell:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnFree:RemoveClickListener()
	self._btnFull:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
end

function AutoChessCard:_btnSellOnClick()
	local moduleId = AutoChessModel.instance.moduleId
	local entity = self.param.entity
	local warZone = entity.warZone

	AutoChessRpc.instance:sendAutoChessBuildRequest(moduleId, AutoChessEnum.BuildType.Sell, warZone, entity.index, entity.mo.uid)
end

function AutoChessCard:_btnBuyOnClick()
	local moduleId = AutoChessModel.instance.moduleId
	local sceneMo = AutoChessModel.instance:getSceneMo()
	local costEnough, toastId = sceneMo:checkCostEnough(self.costType, self.cost)

	if self.isFree or costEnough then
		local warZone, pos = sceneMo.fight:getEmptyPos(self.config.type)

		if not warZone then
			GameFacade.showToast(ToastEnum.AutoChessBoardFull)

			return
		end

		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
		AutoChessRpc.instance:sendAutoChessBuyChessRequest(moduleId, self.param.mallId, self.itemData.uid, warZone, pos - 1)
	else
		GameFacade.showToast(toastId)
	end
end

function AutoChessCard:_btnFreeOnClick()
	self:_btnBuyOnClick()
end

function AutoChessCard:_btnFullOnClick()
	self:_btnBuyOnClick()
end

function AutoChessCard:_btnSelectOnClick()
	local moduleId = AutoChessModel.instance.moduleId

	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)
	AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(moduleId, self.param.itemId)
end

function AutoChessCard:_btnCloseTipOnClick()
	gohelper.setActive(self._goSkillTip, false)
end

function AutoChessCard:_btnCheckOnClick()
	local param = {
		chessId = self.param.itemId
	}

	AutoChessController.instance:openHandbookPreviewView(param)
end

function AutoChessCard:_editableInitView()
	gohelper.setActive(self._goRaceItem, false)

	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(self._txtSkillDesc, self.clcikHyperLink, self)
end

function AutoChessCard:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function AutoChessCard:setData(param)
	self.param = param

	local showType = self.param.type

	if showType == AutoChessCard.ShowType.Sell then
		self:refreshSell()
	elseif showType == AutoChessCard.ShowType.Buy then
		self:refreshBuy()
	elseif showType == AutoChessCard.ShowType.ForcePick then
		self:refreshForcePick()
	elseif showType == AutoChessCard.ShowType.HandBook then
		self:refreshHandbook()
	end
end

function AutoChessCard:refreshSell()
	local chessMo = self.param.entity.mo

	self.config = chessMo.config

	local isEnemy = self.param.entity.teamType == AutoChessEnum.TeamType.Enemy

	self.meshComp:setData(self.config.image, isEnemy)

	local scale = self.config.type == AutoChessStrEnum.ChessType.Boss and 0.5 or 1

	transformhelper.setLocalScale(self._goMesh.transform, -scale, scale, 1)

	self._txtSellCoin.text = AutoChessHelper.getSellPrice(self.config.race)
	self._txtAttack.text = chessMo.battle
	self._txtHp.text = chessMo.hp

	self:refreshConfigAttr(chessMo)
	self:refreshLevelStar(chessMo.star, chessMo.exp, chessMo.maxExpLimit)
	gohelper.setActive(self._btnSell, self.param.showSell)
end

function AutoChessCard:refreshBuy()
	self.itemData = self.param.data

	local chessMo = self.itemData.chess

	self.config = chessMo.config

	self.meshComp:setData(self.config.image)

	local mallCo = AutoChessConfig.instance:getMallCfg(self.param.mallId)

	self.isFree = mallCo.type == AutoChessEnum.MallType.Free
	self._txtAttack.text = chessMo.battle
	self._txtHp.text = chessMo.hp

	self:refreshConfigAttr()
	self:refreshLevelStar(chessMo.star, chessMo.exp, chessMo.maxExpLimit)

	local sceneMo = AutoChessModel.instance:getSceneMo()
	local warZone = sceneMo.fight:getEmptyPos(self.config.type)

	if self.isFree then
		self.cost = 0

		if not warZone then
			self._txtBuyCost1.text = luaLang("p_autochesscard_txt_free")

			gohelper.setActive(self._imageBuyCost1, false)
		end
	else
		self.costType, self.cost = AutoChessConfig.instance:getItemBuyCost(self.itemData.id)
		self.cost = self.cost + self.itemData.fixCost

		local costEnough = sceneMo:checkCostEnough(self.costType, self.cost)

		if costEnough then
			if not self.cost then
				local costStr = string.format("<color=#BD2C2C>%s</color>", self.cost)
				local name = "v2a5_autochess_cost" .. self.costType

				if warZone then
					UISpriteSetMgr.instance:setAutoChessSprite(self._imageBuyCost, name)

					self._txtBuyCost.text = costStr

					gohelper.setActive(self._goNotEnough, not costEnough)
				else
					UISpriteSetMgr.instance:setAutoChessSprite(self._imageBuyCost1, name)
					gohelper.setActive(self._imageBuyCost1, true)

					self._txtBuyCost1.text = costStr
				end
			end
		end
	end

	if warZone then
		gohelper.setActive(self._btnFull, false)
		gohelper.setActive(self._btnFree, self.isFree)
		gohelper.setActive(self._btnBuy, not self.isFree)
	else
		gohelper.setActive(self._btnFull, true)
		gohelper.setActive(self._btnFree, false)
		gohelper.setActive(self._btnBuy, false)
	end
end

function AutoChessCard:refreshForcePick()
	local itemCo = AutoChessConfig.instance:getMallItemCfg(self.param.itemId)
	local params = string.splitToNumber(itemCo.context, "#")

	self.config = AutoChessConfig.instance:getChessCfg(params[1], params[2])

	self.meshComp:setData(self.config.image)

	self._txtAttack.text = self.config.attack
	self._txtHp.text = self.config.hp

	self:refreshConfigAttr()
	gohelper.setActive(self._btnSelect, true)
end

function AutoChessCard:refreshHandbook()
	local star = self.param.star

	self.config = star and AutoChessConfig.instance:getChessCfg(self.param.itemId, star) or AutoChessConfig.instance:getChessCfgAnyway(self.param.itemId)

	self.meshComp:setData(self.config.image)

	self._txtAttack.text = self.config.attack
	self._txtHp.text = self.config.hp

	self:refreshConfigAttr()
	gohelper.setActive(self._btnSelect, false)

	local hasArrow = self.param.arrow

	gohelper.setActive(self._goArrow, hasArrow)
	gohelper.setActive(self._btnCheck.gameObject, star == nil)
	gohelper.setActive(self._goLevel, star ~= nil)

	if star then
		local txt = luaLang("autochess_malllevelupview_level")

		UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel, "v2a5_autochess_levelbg_" .. star)

		self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, star)

		gohelper.setActive(self._goStar, false)
	end
end

function AutoChessCard:refreshConfigAttr(mo)
	self._txtName.text = self.config.name

	if mo then
		if #mo.replaceSkillChessIds ~= 0 then
			local skillId2CntMap = {}

			for _, chessId in ipairs(mo.replaceSkillChessIds) do
				skillId2CntMap[chessId] = skillId2CntMap[chessId] and skillId2CntMap[chessId] + 1 or 1
			end

			local skillDesc = ""
			local txt = luaLang("autochess_copyskill_multi")
			local recordMap = {}

			for _, skillId in ipairs(mo.replaceSkillChessIds) do
				if not recordMap[skillId] then
					recordMap[skillId] = true

					local count = skillId2CntMap[skillId]
					local config = AutoChessConfig.instance:getChessCfgBySkillId(skillId)

					if config then
						skillDesc = count == 1 and string.format("%s%s<br>", skillDesc, config.skillDesc) or string.format("%s%s%s<br>", skillDesc, config.skillDesc, GameUtil.getSubPlaceholderLuaLangOneParam(txt, count))
					end
				end
			end

			self._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(skillDesc)
		elseif mo.cd ~= 0 then
			local skillDesc = AutoChessHelper.buildSkillDesc(self.config.skillDesc)
			local tip = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochesscard_growup_tip"), mo.cd)

			self._txtSkillDesc.text = string.format("%s%s", skillDesc, tip)
		else
			self._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(self.config.skillDesc)
		end
	else
		self._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(self.config.skillDesc)
	end

	self.raceItemList = self.raceItemList or {}

	local races = AutoChessHelper.getChessExtraRaceList(self.config.race)

	for k, race in ipairs(races) do
		local campCo = AutoChessConfig.instance:getCampCfg(race)
		local raceItem = self.raceItemList[k]

		if not raceItem then
			raceItem = self:getUserDataTb_()
			raceItem.go = gohelper.cloneInPlace(self._goRaceItem)
			raceItem.imageType = gohelper.findChildImage(raceItem.go, "image_Type")
			raceItem.txtType = gohelper.findChildText(raceItem.go, "image_Type/txt_Type")
			self.raceItemList[k] = raceItem
		end

		SLFramework.UGUI.GuiHelper.SetColor(raceItem.imageType, campCo.color)

		raceItem.txtType.text = campCo.name

		gohelper.setActive(raceItem.go, true)

		if race == self.config.race then
			if string.nilorempty(campCo.tagResName) then
				gohelper.setActive(self._imageTag, false)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(self._imageTag, campCo.tagResName)
				gohelper.setActive(self._imageTag, true)
			end
		end
	end

	local qualityName = AutoChessHelper.getChessQualityBg(self.config.type, self.config.levelFromMall)

	UISpriteSetMgr.instance:setAutoChessSprite(self._imageBg, qualityName)
	gohelper.setActive(self._goHp, self.config.type == AutoChessStrEnum.ChessType.Attack)
	gohelper.setActive(self._goAttack, self.config.type == AutoChessStrEnum.ChessType.Attack)
end

function AutoChessCard:refreshLevelStar(star, curExp, maxExp)
	if star == 0 then
		return
	end

	local txt = luaLang("autochess_malllevelupview_level")

	UISpriteSetMgr.instance:setAutoChessSprite(self._imageLevel, "v2a5_autochess_levelbg_" .. star)

	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, star)

	if maxExp == 0 then
		gohelper.setActive(self._goStar, false)
	else
		for i = 1, 3 do
			local goLight = self["_goLight" .. i]

			gohelper.setActive(goLight, i <= curExp)

			local goStar = self["_goStar" .. i]

			gohelper.setActive(goStar, i <= maxExp)
		end
	end

	gohelper.setActive(self._goLevel, true)
end

function AutoChessCard:clcikHyperLink(effId, _)
	if self.param.type == AutoChessCard.ShowType.ForcePick then
		recthelper.setAnchor(self._goSkillTip.transform, 0, 120)
		gohelper.setAsLastSibling(self._go)
	elseif self.param.type == AutoChessCard.ShowType.HandBook then
		recthelper.setAnchor(self._goSkillTip.transform, 0, 129)
	end

	local descCo = AutoChessConfig.instance:getSkillEffectDesc(tonumber(effId))

	if descCo then
		self._txtSkillTipTitle.text = descCo.name
		self._txtSkillTip.text = descCo.desc

		gohelper.setActive(self._goSkillTip, true)
	end
end

return AutoChessCard
