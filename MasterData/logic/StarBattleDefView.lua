-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefView.lua

module("logic.extensions.starbattle.view.StarBattleDefView", package.seeall)

local StarBattleDefView = class("StarBattleDefView", ViewComponent)

function StarBattleDefView:ctor()
	StarBattleDefView.super.ctor(self)
end

function StarBattleDefView:unbindEvents()
	StarBattleDefView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnShowPrize)
end

function StarBattleDefView:bindEvents()
	StarBattleDefView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnShowPrize, self._onClickShowPrize, self)
end

function StarBattleDefView:buildUI()
	StarBattleDefView.super.buildUI(self)

	self._btnGoto = self:getGo("btnGoto")
	self._petCellList = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("petlist/cell" .. i)
		cell.container = goutil.findChild(cell.go, "container")
		cell.empty = goutil.findChild(cell.go, "empty")
		cell.con = goutil.findChild(cell.container, "mask/con")
		cell.attrImg = goutil.findChild(cell.container, "cover/Img_attr")
		cell.tag = goutil.findChild(cell.container, "cover/tag")
		cell.txtName = goutil.findChildTextComponent(cell.container, "cover/txtName")

		table.insert(self._petCellList, cell)
	end

	self._verRaceCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("verRaces/items/item_" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")

		table.insert(self._verRaceCellList, cell)
	end

	self._addTips = self:getGo("addTips")
	self._txtAddTips = self:getTxt("addTips/txt")
	self._imgNum = self:getGo("power/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._itemShowPrize1 = self:getGo("showprize/item_1")
	self._itemShowPrize2 = self:getGo("showprize/item_2")
	self._btnShowPrize = self:getGo("showprize/btn")
	self._tagShowPrize = self:getGo("showprize/tag")
	self._txtTitleShowPrize = self:getTxt("showprize/txtTitle")
	self._rp = self:getGo("showprize/rp")
end

function StarBattleDefView:onExit()
	StarBattleDefView.super.onExit(self)

	for _, cell in ipairs(self._petCellList) do
		uGuiUtil.clearImage(cell.go)
	end

	for _, cell in ipairs(self._verRaceCellList) do
		MaterialMgr.instance:resetAll(cell.icon)
	end

	RedPointController.instance:unregRedPoint(self._rp)
end

function StarBattleDefView:onEnter()
	StarBattleDefView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGainDefensePrize, self._updatePrizeUI, self)

	self._activityId = 510001
	self._periodId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)
	end

	StarBattleController.instance:getInfo(self._activityId, self._periodId)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	StarBattleController.instance:recordLastTab(self._activityId, self._periodId, 1)
	RedPointController.instance:regRedPoint(self._rp, RedPointModel.ID_STAR_BATTLE_DEF_PRIZE)
end

function StarBattleDefView:_updateUIByCfg()
	self._curActCfg = StarBattleConfig.instance:getActCfg(self._activityId)
	self._periodCfg = StarBattleConfig.instance:getPeriodCfg(self._activityId, self._periodId)
end

function StarBattleDefView:_updateUIByInfo()
	self._isNewHand = false
	self._curDefenseZdl = 0
	self._defPets = {}

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._curDefenseZdl = info.curDefenseZdl or 0
		self._isNewHand = info.isBeginner

		local form = info.form

		if form then
			if not form.pos then
				local pos = {}

				for i, petId in ipairs(pos) do
					if petId and petId > 0 then
						table.insert(self._defPets, petId)
					end
				end
			end
		end
	end

	self._imgNum:SetNum(self._curDefenseZdl)

	self._prizeCfgs = nil

	if self._isNewHand then
		self._txtAddTips.text = ""

		goutil.setActive(self._addTips, false)

		self._prizeCfgs = StarBattleConfig.instance:getDefensePrizeCfgs(self._periodCfg.newDefensePlanId)
	else
		if not self._periodCfg.defTipDesc then
			self._txtAddTips.text = ""
		end

		goutil.setActive(self._addTips, true)

		self._prizeCfgs = StarBattleConfig.instance:getDefensePrizeCfgs(self._periodCfg.oldDefensePlanId)
	end

	goutil.setActive(self._tagShowPrize, self._isNewHand)

	if self._prizeCfgs then
		local firstPrizeCfg = self._prizeCfgs[1]

		self._addRaces = {}

		if firstPrizeCfg then
			self._addRaces = StarBattleConfig.instance:getDefenseRaces(firstPrizeCfg.defenseRacePlanId)
		end

		for i, cell in ipairs(self._verRaceCellList) do
			local raceId = self._addRaces[i]

			if raceId and raceId > 0 then
				MaterialMgr.setCell(MatType.Pet, raceId, cell.icon)
				goutil.setActive(cell.go, true)
			else
				goutil.setActive(cell.go, false)
			end
		end

		for i, cell in ipairs(self._petCellList) do
			local petId = self._defPets[i]

			if petId and petId > 0 then
				goutil.setActive(cell.empty, false)
				goutil.setActive(cell.container, true)

				local petMo = BagPetsController.instance:getPet(petId)

				if petMo then
					local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

					race = race % 10

					local targetValue = race - 1

					GameUtil.setUIImageSpriteIdx(cell.attrImg, targetValue)

					local isExist = table.keyof(self._addRaces, petMo.raceId) ~= nil

					cell.txtName.text = petMo:getName()

					goutil.setActive(cell.tag, isExist)

					local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))

					uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
				end
			else
				goutil.setActive(cell.empty, true)
				goutil.setActive(cell.container, false)
			end
		end

		self:_updatePrizeUI()
	end
end

function StarBattleDefView:_updatePrizeUI()
	if not self._prizeCfgs then
		return
	end

	self._txtTitleShowPrize.text = string.format("%s\n可领", 10)

	local hasGainDefencePrizeIdMap = {}
	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		if not info.hasGainDefencePrizeIds then
			do
				local hasGainDefencePrizeIds = {}

				for _, v in ipairs(hasGainDefencePrizeIds) do
					hasGainDefencePrizeIdMap[v] = true
				end
			end

			local prizeCfg

			for i, cfg in ipairs(self._prizeCfgs) do
				prizeCfg = cfg

				if not hasGainDefencePrizeIdMap[cfg.prizeId] then
					break
				end
			end

			if prizeCfg then
				local num = checknumber(prizeCfg.range) or 0

				num = Mathf.Max(num, 0)
				self._txtTitleShowPrize.text = string.format("%s\n可领", num >= 100000000 and (num % 100000000 == 0 and string.format("%.0f亿", num / 100000000) or string.format("%.2f亿", num / 100000000)) or num >= 10000 and (num % 10000 == 0 and string.format("%.0f万", num / 10000) or string.format("%.2f万", num / 10000)) or tostring(num))

				if not self._curActCfg.showItem then
					if not GameUtil.isEmptyString(self._curActCfg.showItem) then
						MaterialMgr.setCellByCfg(self._curActCfg.showItem .. ":" .. prizeCfg.score, self._itemShowPrize1)
					end

					MaterialMgr.setCellByCfg(prizeCfg.prize, self._itemShowPrize2)
				end
			end
		end
	end
end

function StarBattleDefView:_onClickGoto()
	StarBattleController.instance:showDefMissionFormation(self._activityId, self._periodId, self._isNewHand)
end

function StarBattleDefView:_onClickShowPrize()
	UIStateManager.instance:push(ViewName.StarBattleDefPrizeView, self._activityId, self._isNewHand)
end

return StarBattleDefView
