-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetTeamsView.lua

module("logic.extensions.petassist.view.PetTeamsView", package.seeall)

local PetTeamsView = class("PetTeamsView", TableViewComponent)

function PetTeamsView:ctor()
	PetTeamsView.super.ctor(self)

	self.goodsGoList = nil
	self.goodsInfoList = nil
	self.attrGoList = nil
	self._levelUIISCList = nil
end

function PetTeamsView:buildUI()
	PetTeamsView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.viewTitleTxt = self:getGo("viewTitleTxt"):GetComponent("Text")
	self.goldBarCon = self:getGo("goldBarCon")
	self.powerTxt = self:getGo("powerShowGo/powerTxt"):GetComponent(ComponentType.UIImgNumeralText)
	self.attrGo = self:getGo("attrGo")
	self.attrAllTran = self:getGo("attrAllTran").transform

	local consumeGo = self:getGo("consumeGo")

	self.teamIma = goutil.findChild(consumeGo, "teamIma"):GetComponent("UIImageSpriteChange")
	self.teamNameImg = goutil.findChild(consumeGo, "teamNameImg"):GetComponent("UIImageSpriteChange")
	self.teamLevelTxt = goutil.findChildTextComponent(consumeGo, "teamLevelTxt")
	self.goodsGoList = {
		goutil.findChild(consumeGo, "goodsGo_1"),
		goutil.findChild(consumeGo, "goodsGo_2"),
		goutil.findChild(consumeGo, "goodsGo_3"),
		goutil.findChild(consumeGo, "goodsGo_4"),
		goutil.findChild(consumeGo, "goodsGo_5")
	}

	local allLevelGo = goutil.findChild(consumeGo, "allLevelGo")
	local var_2_0 = {}

	var_2_0[1] = goutil.findChild(allLevelGo, "level_1"):GetComponent("UIImageSpriteChange")
	var_2_0[2] = goutil.findChild(allLevelGo, "level_2"):GetComponent("UIImageSpriteChange")
	var_2_0[3] = goutil.findChild(allLevelGo, "level_3"):GetComponent("UIImageSpriteChange")
	var_2_0[4] = goutil.findChild(allLevelGo, "level_4"):GetComponent("UIImageSpriteChange")
	var_2_0[5] = goutil.findChild(allLevelGo, "level_5"):GetComponent("UIImageSpriteChange")
	self._levelUIISCList = var_2_0
	self.upgradeBtn = Framework.ButtonAdapter.GetFrom(consumeGo, "upgradeBtn")
	self.upgradeTxt = goutil.findChildTextComponent(consumeGo, "upgradeBtn/upgradeTxt")
	self.upgradeRedGo = goutil.findChild(consumeGo, "upgradeBtn/upgradeRedGo")
	self.viewTitleTxt.text = ""

	self.attrGo:SetActive(false)

	self.teamLevelTxt.text = ""

	self.upgradeRedGo:SetActive(false)
end

function PetTeamsView:bindEvents()
	PetTeamsView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.upgradeBtn:AddClickListener(self.OnClickUpgradeBtn, self)
end

function PetTeamsView:unbindEvents()
	PetTeamsView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.upgradeBtn:RemoveClickListener()
end

function PetTeamsView:onExit()
	PetTeamsView.super.onExit(self)
	GlobalDispatcher:removeListener("PetTeamInfoChange", self.UpdataShowViewInfo, self)
end

function PetTeamsView:destroyUI()
	PetTeamsView.super.destroyUI(self)

	self.teamCfg = nil
	self.goodsGoList = nil
	self.goodsInfoList = nil

	for _, item in pairs(self.attrGoList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrGoList = nil
	self._levelUIISCList = nil
end

function PetTeamsView:onEnter()
	PetTeamsView.super.onEnter(self)

	local param = self._viewPresentor._openParam
	local teamType = 1

	if param and param[1] then
		teamType = param[1]
	end

	local cfg = PetAssistConfig.instance:GetPetTeamCfg(teamType)

	if cfg == nil then
		printError("sr--- PetTeamsView:onEnter()    战队配置空  teamType = ", teamType)

		return
	end

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Coin
		}
	}

	if not string.nilorempty(cfg.commCost) then
		btnList[3] = {
			showAdd = true,
			id = cfg.commCost
		}
	end

	if not string.nilorempty(cfg.starCost) then
		btnList[4] = {
			showAdd = true,
			id = cfg.starCost
		}
	end

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btnList)

	self.teamCfg = {
		teamLv = 0,
		teamType = teamType,
		teamName = cfg.teamName
	}
	self.teamName = cfg.teamName
	self.viewTitleTxt.text = self.teamName

	self:UpdataShowViewInfo()
	self._tableview:MoveCellInView(0, false)
	GlobalDispatcher:addListener("PetTeamInfoChange", self.UpdataShowViewInfo, self)
end

function PetTeamsView:UpdataShowViewInfo()
	local teamInfo = PetAssistModel.instance:GetSubTeamInfo(self.teamCfg.teamType)

	if teamInfo then
		self.teamCfg.teamLv = teamInfo.teamLevel or 1
	end

	self:OnClickPetItemIndex()

	local isRed = PetAssistModel.instance:IsCanTeamUpgrade(self.teamCfg.teamType)

	self.upgradeRedGo:SetActive(isRed)
end

function PetTeamsView:OnClickPetItemIndex()
	self._curViewDatas = PetAssistModel.instance:GetTeamAllItems(self.teamCfg.teamType)

	self._tableview:ReloadData()
	self:ShowChpiseAttrShow()
	self:UpdataChoisePet()
end

function PetTeamsView:ShowChpiseAttrShow()
	local attrInfoList, power = PetAssistModel.instance:GetTeamAttrsAndPower(self.teamCfg.teamType)

	self.powerTxt:SetNum(power)

	self.attrGoList = self.attrGoList or {}

	if attrInfoList then
		if not #attrInfoList then
			local count = 0

			if count < #self.attrGoList then
				for i = count + 1, #self.attrGoList do
					if self.attrGoList[i] and self.attrGoList[i].itemGo and self.attrGoList[i].itemGo.activeSelf then
						self.attrGoList[i].itemGo:SetActive(false)
					end
				end
			end

			if count == 0 then
				return
			end

			for i = 1, count do
				if self.attrGoList[i] == nil then
					local attrGo = UnityEngine.GameObject.Instantiate(self.attrGo, self.attrAllTran)

					self.attrGoList[i] = {}
					self.attrGoList[i].itemGo = attrGo
					self.attrGoList[i].iconIma = goutil.findChildComponent(attrGo, "iconIma", "UIImageSpriteChange")
					self.attrGoList[i].countTxt = goutil.findChildTextComponent(attrGo, "countTxt")
					self.attrGoList[i].lineGo = goutil.findChild(attrGo, "lineGo")
				end

				local info = attrInfoList[i]

				self.attrGoList[i].itemGo:SetActive(true)
				self.attrGoList[i].iconIma:SetState(info.index - 1)

				self.attrGoList[i].countTxt.text = info.name .. "+" .. info.value

				self.attrGoList[i].lineGo:SetActive(i < count)
			end
		end
	end
end

function PetTeamsView:UpdataChoisePet()
	self.teamIma:SetState(self.teamCfg.teamType - 1)
	self.teamNameImg:SetState(self.teamCfg.teamType - 1)

	local cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(self.teamCfg.teamType, self.teamCfg.teamLv)

	if cfg then
		if not cfg.levelNum then
			local temp = 0

			self.teamLevelTxt.text = "Lv." .. temp

			for i = 1, #self._levelUIISCList do
				temp = cfg and cfg.starNum or 0

				if i <= temp then
					self._levelUIISCList[i]:SetState(1)
				else
					self._levelUIISCList[i]:SetState(0)
				end
			end

			if self.goodsGoList and #self.goodsGoList > 0 then
				for i = 1, #self.goodsGoList do
					if self.goodsGoList[i] then
						MaterialMgr.resetAll(self.goodsGoList[i])
					end
				end
			end

			local maxLv = PetAssistModel.instance:GetTeamMaxLevel(self.teamCfg.teamType)

			if maxLv <= self.teamCfg.teamLv then
				self.upgradeBtn.gameObject:GetComponent("UIImageSpriteChange"):SetState(1)

				self.upgradeTxt.text = "<color=#BFBFBFFF>满 级</color>"
			else
				self.upgradeBtn.gameObject:GetComponent("UIImageSpriteChange"):SetState(0)

				self.upgradeTxt.text = "<color=#692E0AFF>升 级</color>"
				cfg = PetAssistConfig.instance:GetTeamUpgradeCfg(self.teamCfg.teamType, self.teamCfg.teamLv + 1)

				if cfg == nil or string.nilorempty(cfg.cost) then
					return
				end

				local goodsList = self:ParsingGoodsStr(cfg.cost)

				if goodsList == nil or #goodsList == 0 then
					return
				end

				self.goodsInfoList = {}

				for i = 1, #goodsList do
					if goodsList[i] and checknumber(goodsList[i].itemType) > 0 then
						local have = MaterialModel.instance:getMaterialsNumber(goodsList[i].itemType, goodsList[i].itemId)

						table.insert(self.goodsInfoList, {
							itemType = goodsList[i].itemType,
							itemId = goodsList[i].itemId,
							needCount = goodsList[i].count,
							haveCount = checknumber(have)
						})

						local proxy = MaterialMgr.setCell(goodsList[i].itemType, goodsList[i].itemId, self.goodsGoList[i])

						proxy.binder:setNum(goodsList[i].count)
					end
				end
			end
		end
	end
end

function PetTeamsView:ParsingGoodsStr(goodsStr)
	if string.nilorempty(goodsStr) then
		return
	end

	local itemTb = string.split(goodsStr, "#")

	if itemTb == nil or #itemTb == 0 then
		return
	end

	local itemList = {}

	for i = 1, #itemTb do
		if not string.nilorempty(itemTb[i]) then
			local item = string.split(itemTb[i], ":")

			if item and #item > 2 then
				table.insert(itemList, {
					itemType = checknumber(item[1]),
					itemId = checknumber(item[2]),
					count = checknumber(item[3])
				})
			end
		end
	end

	return itemList
end

function PetTeamsView:OnClickUpgradeBtn()
	if self.teamCfg.teamLv >= PetAssistModel.instance:GetTeamMaxLevel(self.teamCfg.teamType) then
		FloatWordMgr.instance:show("当前已是最高等级！")

		return
	end

	if self.goodsInfoList and #self.goodsInfoList > 0 then
		for i = 1, #self.goodsInfoList do
			if self.goodsInfoList[i] and self.goodsInfoList[i].needCount > self.goodsInfoList[i].haveCount then
				FloatWordMgr.instance:show("升级所需材料不足！")
				MaterialMgr.openGetSource(self.goodsInfoList[i].itemType, self.goodsInfoList[i].itemId)

				return
			end
		end
	end

	PetAssistController.instance:CSUpgradePetTeamReq(self.teamCfg.teamType)
end

function PetTeamsView:_getPath()
	return {
		cellPath = "petItem",
		viewPath = "petListSR"
	}
end

function PetTeamsView:_cellSize()
	return 236, 428
end

function PetTeamsView:_updateCell(view, cell, data)
	local noPetGo = goutil.findChild(cell, "noPetGo")
	local nopetIma = goutil.findChild(noPetGo, "nopetIma"):GetComponent("UIImageSpriteChange")
	local lockTxt = goutil.findChildTextComponent(noPetGo, "lockTxt")
	local havePetGo = goutil.findChild(cell, "havePetGo")
	local petQualityIma = havePetGo:GetComponent("UIImageSpriteChange")
	local iconImaGo = goutil.findChild(havePetGo, "mask/iconIma")
	local typeIma = goutil.findChild(havePetGo, "typeIma"):GetComponent("UIImageSpriteChange")
	local levelTxt = goutil.findChildTextComponent(havePetGo, "levelTxt")
	local nameTxt = goutil.findChildTextComponent(havePetGo, "nameTxt")
	local starGoList = {
		goutil.findChild(havePetGo, "start_1"),
		goutil.findChild(havePetGo, "start_2"),
		goutil.findChild(havePetGo, "start_3"),
		goutil.findChild(havePetGo, "start_4"),
		goutil.findChild(havePetGo, "start_5"),
		goutil.findChild(havePetGo, "start_6")
	}
	local onClickGo = goutil.findChild(cell, "onClickGo")
	local redGo = goutil.findChild(cell, "redGo")

	GameUtil.asBtn(onClickGo):RemoveClickListener()

	if not data.isUnlock then
		havePetGo:SetActive(false)
		noPetGo:SetActive(true)
		nopetIma:SetState(0)
		redGo:SetActive(false)

		lockTxt.text = string.format("%s\n需达到%s级解锁", self.teamName, data.unlockLv)
	else
		lockTxt.text = ""

		if checknumber(data.petId) > 0 then
			noPetGo:SetActive(false)
			havePetGo:SetActive(true)
			petQualityIma:SetState(self.teamCfg.teamType - 1)
			typeIma:SetState(self.teamCfg.teamType - 1)

			local petInfo = BagPetsController.instance:getPet(data.petId)

			if petInfo == nil then
				cell:SetActive(false)

				return
			end

			local skinId = PetSkinConfig.instance:tryChangePetSkinId(checknumber(petInfo.curFaceId), self.teamCfg.teamType)
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

			if not modelCo then
				printError("sr---- PetTeamsView:_updateCell()   精灵图片为空 petId = ", data.petId, petInfo.raceId)

				return
			end

			uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

			levelTxt.text = "等级：" .. petInfo.level
			nameTxt.text = petInfo.name

			local rareCfg = CharacterConfig.instance:getAwakenRareCfg(petInfo.awakeLevel)

			if rareCfg then
				if not rareCfg.starNum then
					for i = 1, #starGoList do
						goutil.setActive(starGoList[i], false)
					end
				end
			end
		else
			havePetGo:SetActive(false)
			noPetGo:SetActive(true)
			nopetIma:SetState(1)
		end

		local isRed = PetAssistModel.instance:IsTeamPosShowRedpoint(data.teamType, data.posId)

		redGo:SetActive(isRed)
	end

	GameUtil.asBtn(onClickGo):AddClickListener(function()
		if not data.isUnlock then
			FloatWordMgr.instance:show(string.format("需要%s达到%s级解锁", self.teamName, data.unlockLv))

			return
		end

		UIStateManager.instance:open(ViewName.PetChoiseAdd, {
			teamType = data.teamType,
			pos = data.posId
		})
	end, self)
end

return PetTeamsView
