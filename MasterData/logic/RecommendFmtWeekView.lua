-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendFmtWeekView.lua

module("logic.extensions.mangtower.view.RecommendFmtWeekView", package.seeall)

local RecommendFmtWeekView = class("RecommendFmtWeekView", FormationLeftView)

function RecommendFmtWeekView:onEnter()
	RecommendFmtWeekView.super.onEnter(self)

	self.currSelectTabId = -1

	local list = RecommendFmtModel.instance:getTabList()

	self.scrollList:reloadData(list)

	if #list > 0 then
		self:onClickTab(list[1])
	end
end

function RecommendFmtWeekView:onExit()
	RecommendFmtWeekView.super.onExit(self)
	self.scrollList:dispose()

	self.currSelectTabId = -1
end

function RecommendFmtWeekView:bindEvents()
	RecommendFmtWeekView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function RecommendFmtWeekView:unbindEvents()
	RecommendFmtWeekView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function RecommendFmtWeekView:buildUI()
	RecommendFmtWeekView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.formationName = self:getTxt("formation/txtName")
	self.imgRecZdl = self:getGo("formation/zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))

	local cell = self:getGo("btnAttr")
	local scrollerGo = self:getGo("tableview")

	self.scrollList = ScrollerList.create(scrollerGo, cell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self.clearCell, self))
	self.selectArrow = self:getGo("Nego_Left/time/arrow")
	self.showDateObjs = {}

	for i = 1, 9 do
		self.showDateObjs[i] = self:getGo("Nego_Left/time/time" .. i)
	end
end

function RecommendFmtWeekView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local select = goutil.findChild(cell, "select")
	local attr = goutil.findChild(cell, "attr")

	GameUtil.SetActive(select, data.id == self.currSelectTabId)

	txtName.text = data.name

	GameUtil.setUIImageSpriteIdx(attr, checknumber(data.target))
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickTab, self, data))
end

function RecommendFmtWeekView:onClickTab(data)
	if self.currSelectTabId ~= data.id then
		self.currSelectTabId = data.id

		RecommendFmtModel.instance:setFmt(data.id)
		self:_initSelfFormation()

		self.formationName.text = data.desc

		self.scrollList:refresh()

		local list = {}

		self._gotTipRoot:SetActive(true)

		local pos = self:_getCurPositions()

		self.petid2index = {}

		local fristPet

		for i, v in ipairs(pos) do
			self._gotTips[i]:SetActive(false)

			local petMo

			if v > 0 then
				self._gotTips[i]:SetActive(true)

				petMo = self:_getPet(v)

				table.insert(list, petMo)

				if BagPetsController.instance:getPetNumByRaceId(petMo.raceId) > 0 then
					self._gotTips[i]:SetActive(false)
				end

				self.petid2index[v] = i
				fristPet = fristPet or v
			end

			self:_showOpenDate(petMo, i)
		end

		self:_setPetShowInfo(fristPet)
	end
end

function RecommendFmtWeekView:clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function RecommendFmtWeekView:_SetPowerAndSpeed()
	local power, speed = self:_getPowerAndSpeed()

	self.imgRecZdl:SetNum(power)
end

function RecommendFmtWeekView:_getCurFormId()
	return 0
end

function RecommendFmtWeekView:_getCurFormation()
	return RecommendFmtModel.instance:getFmt()
end

function RecommendFmtWeekView:_refreshBuffForm()
	local cfgs = BattleConfig.instance:getFormStrengthTriggerCfgs()
	local positions = self:_getCurPositions()
	local posDataList = {}
	local compA = 0

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo.summonMasterId <= 0 then
				table.insert(posDataList, i)

				compA = compA + math.pow(2, i)
			end
		end
	end

	local fsMap = FormationNewModel.instance:getAllFormStrengthInfo()

	for k, v in pairs(fsMap or {}) do
		local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(v.formStrengthId)

		if posCfg then
			local posList = posCfg.posList

			if posList and #posList == #posDataList then
				local compB = 0

				for i = 1, #posList do
					local pp_b = posList[i]

					compB = compB + math.pow(2, pp_b)
				end

				if compA == compB then
					self:_onUpdateBuffFormById(v)

					return
				end
			end
		end
	end

	self:_onUpdateBuffFormById(nil)
end

function RecommendFmtWeekView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, 20
end

function RecommendFmtWeekView:_OnDropSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_OnBeginDragSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_OnEndDragSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_OnDragSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_onEnterSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_onExitSeat(_go, eventData)
	return
end

function RecommendFmtWeekView:_saveCurrFmt()
	return
end

function RecommendFmtWeekView:_getPet(petId)
	return RecommendFmtModel.instance:getPet(petId)
end

function RecommendFmtWeekView:_getItemSeatCls()
	return RecommendItemSeat
end

function RecommendFmtWeekView:_OnClickSeat(go, eventData)
	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)

	self:_setPetShowInfo(petId)
end

function RecommendFmtWeekView:_setPetShowInfo(petId)
	local index = self.petid2index[petId]
	local petMo = self:_getPet(petId)
	local parent = self.showDateObjs[index].transform
	local x, y, z = Framework.TransformUtil.GetLocalPos(parent, 0, 0, 0)

	Framework.TransformUtil.SetLocalPos(self.selectArrow.transform, x, y + 190, z)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId) % 10 - 1
	local isGet = BagPetsController.instance:getPetNumByRaceId(petMo.raceId) > 0
	local isOpen = true
	local isSkin = not PetskinController.instance:checkIsOriginalSkinBySkinId(petMo.curFaceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petMo.curFaceId))
	local rare = CharacterConfig.instance:getInitRare(petMo.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId).quality
	local btnObj = self:getGo("cell/container")

	goutil.findChildTextComponent(btnObj, "namebg/txt").text = MaterialMgr.getMaterialsName(MatType.Pet, petMo.raceId)
	goutil.findChildTextComponent(btnObj, "imgDown/txt").text = PetStrategyConfig.instance:getStrategyById(petMo.raceId).resume

	goutil.findChild(btnObj, "openTime"):SetActive(not isOpen)
	goutil.findChild(btnObj, "noGet"):SetActive(not isGet)
	goutil.findChild(btnObj, "layout/Nego_Skin"):SetActive(isSkin)
	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "layout/Nego_Skin/skin")):SetState(rareSkin)

	local attrIcon = goutil.findChildComponent(btnObj, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")

	attrIcon:SetState(race)

	local imageObj = goutil.findChild(btnObj, "mask/con")

	uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local attrObj = goutil.findChild(btnObj, "layout/Nego_Attr")

	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "bg")):SetState(rare)
	GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
	attrObj:SetActive(true)

	local btnBook = goutil.findChild(btnObj, "imgBook")

	GameUtil.asBtn(btnBook):AddClickListener(function()
		PetbookController.instance:openPetinfoView(petMo.raceId)
	end, self)
	GameUtil.asBtn(btnObj):AddClickListener(function()
		self:_onClickPetPage(isOpen, petMo)
	end, self)
end

function RecommendFmtWeekView:_onClickPetPage(isOpen, petMo)
	if not isOpen then
		FloatWordMgr.instance:show("暂未开放")

		return
	end

	MaterialMgr.openGetSource(MatType.Pet, petMo.raceId)
end

function RecommendFmtWeekView:_showOpenDate(petMo, index)
	self.showDateObjs[index]:SetActive(false)

	if petMo == nil then
		return
	end

	local showDate = PetNoticeConfig.instance:getOpenDateById(petMo.curFaceId)

	if showDate == nil then
		return
	end

	local diff = GameUtil.string2time(showDate) - ServerTime.now()

	if diff < 0 then
		return
	end

	local dateTime = GameUtil.parseToTimeTable(showDate)

	goutil.findChildTextComponent(self.showDateObjs[index], "txt").text = string.format("%s月%s日上线", dateTime.month, dateTime.day)

	self.showDateObjs[index]:SetActive(true)
end

function RecommendFmtWeekView:_getContractId(groupId, summonPetMo)
	return summonPetMo.contractSkillId
end

return RecommendFmtWeekView
