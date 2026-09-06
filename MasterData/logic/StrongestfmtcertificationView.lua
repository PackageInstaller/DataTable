-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/StrongestfmtcertificationView.lua

module("logic.extensions.recommendfmt.view.StrongestfmtcertificationView", package.seeall)

local StrongestfmtcertificationView = class("StrongestfmtcertificationView", ViewComponent)

function StrongestfmtcertificationView:ctor()
	StrongestfmtcertificationView.super.ctor(self)
end

function StrongestfmtcertificationView:unbindEvents()
	StrongestfmtcertificationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRank)
	GameUtil.rmClickHandler(self.btnCheck)
	GameUtil.rmClickHandler(self.btnTip)
end

function StrongestfmtcertificationView:bindEvents()
	StrongestfmtcertificationView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnRank, self.onClickRank, self)
	GameUtil.addClickHandler(self.btnCheck, self.onClickCheck, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickRule, self)
end

function StrongestfmtcertificationView:buildUI()
	StrongestfmtcertificationView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.tableview = self:getGo("petList/tableview")
	self.cell = self:getGo("petList/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.btnTip = self:getGo("btnTip")
	self.rank = self:getGo("rank")
	self.goEmpty = self:getGo("rank/goEmpty")
	self.btnRank = self:getGo("rank/btnRank")
	self.r_tableview = self:getGo("rank/tableview")
	self.r_cell = self:getGo("rank/cell")
	self.rankScrollList = ScrollerList.create(self.r_tableview, self.r_cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self.clearRankCell, self))
	self.bubble = self:getGo("rank/bubble")
	self.txtTip = self:getTxt("rank/bubble/txtTip")
	self.pointItem = self:getGo("rank/bubble/pointItem")
	self.txtMyRank = self:getTxt("rank/txtMyRank")
	self.txtTime = self:getTxt("txtTime")
	self.mission = self:getGo("mission")
	self.btnCheck = self:getGo("mission/btnCheck")
	self.zdl = self:getGo("mission/zdl")
	self.imgRecZdl = self:getGo("mission/zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	self.txtPower = self:getTxt("mission/maxPower/txtPower")
	self.txtTitle = self:getTxt("mission/txtTitle")
	self.items = {}

	for i = 1, 9 do
		local pet = self:getGo("mission/formation/pet" .. i)

		table.insert(self.items, pet)
	end
end

function StrongestfmtcertificationView:onExit()
	StrongestfmtcertificationView.super.onExit(self)
	self.scrollList:dispose()
	self.rankScrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.RecommendFormGetInfo, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.RecommendFormUpdateView, self.onRefreshEffect, self)

	for i, cell in ipairs(self.items) do
		local con = goutil.findChild(cell, "con")

		MaterialMgr.clearIcon(con)
	end

	self:clearAllEff()
	MaterialMgr.resetAll(self.pointItem)
	removetimer(self.onPosPlayEffEnd, self)
end

function StrongestfmtcertificationView:onEnter()
	StrongestfmtcertificationView.super.onEnter(self)

	self.effList = {}

	GlobalDispatcher:addListener(GlobalNotify.RecommendFormGetInfo, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.RecommendFormUpdateView, self.onRefreshEffect, self)
	RecommendFmtController.instance:sendGetInfo()
	self:onRefreshUI()

	local str = RecommendFmtConfig.instance:getCommonValue("RANK_GAIN_ITEM")

	MaterialMgr.setCellByCfg(str, self.pointItem)

	self.txtTime.text = RecommendFmtConfig.instance:getCommonValue("ACT_TIME_OVER")
end

function StrongestfmtcertificationView:clearAllEff()
	for i, v in ipairs(self.effList) do
		UIEffectManager.instance:stopEffect(v)
	end

	self.effList = {}
end

function StrongestfmtcertificationView:onRefreshEffect(lastZdl, lastRank)
	self:onRefreshUI()

	local posLvMap = RecommendFmtModel.instance:getPetPosMap()

	self:clearAllEff()

	self.isPlayEff = true

	local effect_path = "common/fx_ui_renzheng_common.prefab"

	for i, cell in ipairs(self.items) do
		local obj = posLvMap[i]

		if obj then
			local eff = UIEffectManager.instance:playEffect(self, effect_path, cell, 0, 0, false, nil, function()
				return
			end, function(finishHandler, eff)
				return
			end)

			eff:setParent(cell.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)
			table.insert(self.effList, eff)
		end
	end

	self.lastZdl = lastZdl
	self.lastRank = lastRank

	removetimer(self.onPosPlayEffEnd, self)
	settimer(1, self.onPosPlayEffEnd, self)
end

function StrongestfmtcertificationView:onPosPlayEffEnd()
	local lastZdl = self.lastZdl
	local lastRank = self.lastRank

	self:showResultView(lastZdl, lastRank)
end

function StrongestfmtcertificationView:showResultView(lastZdl, lastRank)
	if self.isPlayEff == true then
		self.isPlayEff = false

		UIStateManager.instance:push(ViewName.FmtcertificationresultView, lastZdl, lastRank)
	end
end

function StrongestfmtcertificationView:onRefreshUI()
	local posList = RecommendFmtModel.instance.posList
	local posLvMap = RecommendFmtModel.instance:getPetPosMap()
	local list = {}

	for i, cell in ipairs(self.items) do
		local petMo = posList[i]

		GameUtil.SetActive(cell, false)

		if petMo then
			table.insert(list, petMo)
			GameUtil.SetActive(cell, true)

			local con = goutil.findChild(cell, "con")
			local info = goutil.findChild(cell, "info")
			local Img_attr = goutil.findChild(cell, "info/Nego_Attr/Img_attr")
			local contract = goutil.findChild(cell, "contract")
			local txtContract = goutil.findChildTextComponent(cell, "contract/txt")
			local atkType = goutil.findChild(cell, "info/atkType")
			local TxtC_Level = goutil.findChildTextComponent(cell, "info/TxtC_Level")

			GameUtil.SetActive(contract, petMo.summonMasterId > 0 or petMo.summonedPetId > 0)

			txtContract.text = petMo.summonMasterId > 0 and lang("strongestfmtcertificationview__2") or petMo.summonedPetId > 0 and lang("job_summoner") or ""

			local obj = posLvMap[i]

			if obj ~= nil then
				local skinId = 0
				local bagPet = BagModel.instance:getBagPetById(obj.petId)

				if bagPet then
					MaterialMgr.setIcon(con, MatType.Pet, bagPet.curFaceId)

					skinId = bagPet.curFaceId
				else
					MaterialMgr.setIcon(con, MatType.Pet, petMo.raceId)

					skinId = petMo.raceId
				end

				local careerClassify = PetSkinConfig.instance:getFirstJobClassify(petMo.curFaceId)
				local stateIndex = careerClassify - 1

				GameUtil.setUIImageSpriteIdx(atkType, stateIndex)

				TxtC_Level.text = langPara("lv_number_nospace", obj.petLv)

				local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

				race = math.fmod(race, 10)

				local targetValue = race - 1

				GameUtil.setUIImageSpriteIdx(Img_attr, targetValue)
				GameUtil.SetActive(info, true)
				GameUtil.SetGray(con, false)
			else
				MaterialMgr.setIcon(con, MatType.Pet, petMo.raceId)
				GameUtil.SetActive(info, false)
				GameUtil.SetGray(con, true)
			end
		end
	end

	self.scrollList:reloadData(list)

	local myRank = RecommendFmtModel.instance.myRank

	self.txtMyRank.text = myRank > 0 and langPara("text_wodepaiming", myRank) or lang("text_wodepaiming_wu")

	if not RecommendFmtModel.instance.rankInfoList then
		local rankList = {}
		local tmp = {}

		for i = 1, math.min(#rankList, 10) do
			table.insert(tmp, rankList[i])
		end

		self.rankScrollList:reloadData(tmp)
		GameUtil.SetActive(self.goEmpty, #rankList == 0)

		self.txtPower.text = langPara("strongestfmtcertificationview__1", RecommendFmtModel.instance.curMaxZdl)

		self.imgRecZdl:SetNum(RecommendFmtModel.instance.maxFmoPower)

		self.curFormCfg = RecommendFmtModel.instance.curFormCfg

		if self.curFormCfg then
			self.txtTitle.text = self.curFormCfg.name
		end
	end
end

function StrongestfmtcertificationView:_updateRankCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local head = goutil.findChild(cell, "head")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")

	if data.rank <= 3 then
		GameUtil.SetActive(imgRank, true)
		GameUtil.setUIImageSpriteIdx(imgRank, data.rank - 1)
	else
		GameUtil.SetActive(imgRank, false)
	end

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtPower.text = langPara("strongestfmtcertificationview__6", data.zdl)

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%s-%s-%s ", time.year, time.month, time.day)

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)
end

function StrongestfmtcertificationView:clearRankCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function StrongestfmtcertificationView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local tag = goutil.findChild(cell, "tag")
	local btnDevelop = goutil.findChild(cell, "btnDevelop")
	local btnGet = goutil.findChild(cell, "btnGet")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtPower")

	txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, data.curFaceId)

	local petInfo = CharacterConfig.instance:getPetInfoCo(data.raceId)
	local posLvMap = RecommendFmtModel.instance:getPetPosMap()
	local petMo
	local hasPut = false

	for k, v in pairs(posLvMap) do
		local tmp = BagModel.instance:getBagPetById(checknumber(v.petId))

		if tmp and tmp.raceId == data.raceId then
			petMo = tmp
			hasPut = true
			txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, tmp.curFaceId)

			break
		end
	end

	txtDesc.text = hasPut and langPara("strongestfmtcertificationview__7", petMo:getFightingPower(), data:getFightingPower()) or langPara("strongestfmtcertificationview__7", lang("strongestfmtcertificationview__8"), data:getFightingPower())

	local boo = HandbookModel.instance:isHasPet(data.raceId) or BagPetsController.instance:getPetNumByRaceId(data.raceId) > 0

	MaterialMgr.setCell(MatType.Pet, data.raceId, item)

	local mo = self:getPetEqualsMo(data)

	if mo then
		local proxy = MaterialMgr.setCellByMo(mo, item)

		if proxy then
			proxy.binder:SetGray(false)
		end
	else
		local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, item)

		if proxy then
			proxy.binder:SetGray(true)
		end
	end

	GameUtil.SetActive(tag, not boo)
	GameUtil.SetActive(btnDevelop, boo)
	GameUtil.SetActive(btnGet, not boo)
	GameUtil.addClickHandler(btnDevelop, GameUtil.handler(self.onClickGoPet, self, data))
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self.onClickJump, self, data))
end

function StrongestfmtcertificationView:getPetEqualsMo(petMo)
	local arrAllPets = BagModel.instance:getBagPets()
	local maxLevel = -1
	local maxZdl = -1
	local mo

	for k, v in pairs(arrAllPets) do
		if v.raceId == petMo.raceId and (maxLevel <= v.awakenLv or maxZdl < v:getFightingPower()) then
			mo = v
			maxLevel = v.awakenLv
			maxZdl = v:getFightingPower()
		end
	end

	return mo
end

function StrongestfmtcertificationView:onClickGoPet(petMo)
	local mo = self:getPetEqualsMo(petMo)

	if mo then
		SurveyController.instance:reportBehavior(200476, mo.raceId)
		BagPetsController.instance:openBagPetView(mo.petId)
	else
		SurveyController.instance:reportBehavior(200476, 0)
		print(">>>>>>>>>>该精灵不在背包中，无法转跳哦")
	end
end

function StrongestfmtcertificationView:onClickJump(petMo)
	SurveyController.instance:reportBehavior(200477, petMo.raceId)
	MaterialMgr.openGetSource(MatType.Pet, petMo.raceId)
end

function StrongestfmtcertificationView:clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function StrongestfmtcertificationView:onClickRank()
	UIStateManager.instance:push(ViewName.StrongFmtrankView)
end

function StrongestfmtcertificationView:onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "strongestfmt_rule")
end

function StrongestfmtcertificationView:onClickCheck()
	RecommendFmtController.instance:sendCheckMaxFmt()
end

return StrongestfmtcertificationView
