-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaExtClgResultView.lua

module("logic.extensions.kingkaya.view.KingKaYaExtClgResultView", package.seeall)

local KingKaYaExtClgResultView = class("KingKaYaExtClgResultView", ViewComponent)

function KingKaYaExtClgResultView:buildUI()
	KingKaYaExtClgResultView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc1 = goutil.findChildTextComponent(self.mainGO, "txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(self.mainGO, "txtDesc2")
	self._txtResult1 = goutil.findChildTextComponent(self.mainGO, "txtResult1")
	self._txtResult2 = goutil.findChildTextComponent(self.mainGO, "txtResult2")
	self._imgResult1 = goutil.findChild(self.mainGO, "imgResult1")
	self._imgResult2 = goutil.findChild(self.mainGO, "imgResult2")
	self._iconTag1 = goutil.findChild(self.mainGO, "tag1/icon")
	self._iconTag2 = goutil.findChild(self.mainGO, "tag2/icon")
	self._petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	self._petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")
	self._imgEmptyPet = goutil.findChild(self.mainGO, "petCol/imgEmpty")
	self._petScrollerList = ScrollerList.create(self._petScrView, self._petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function KingKaYaExtClgResultView:bindEvents()
	KingKaYaExtClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function KingKaYaExtClgResultView:unbindEvents()
	KingKaYaExtClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function KingKaYaExtClgResultView:onEnter()
	KingKaYaExtClgResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	if not params[1] then
		local msg = KingKaYaController.instance:getKingKaYaMo(self._activityId):getExtClgEndRes()

		if msg == nil or msg.activityId ~= self._activityId or msg.stageId ~= self._stageId then
			self:_onClickBtnSure()

			return
		end

		self._kingKaYaMo = KingKaYaController.instance:getKingKaYaMo(self._activityId)

		local lockRaceIds = msg.lockRaceIds
		local signScores = msg.signScores
		local stageData = KingKaYaConfig.instance:getExtStageData(self._activityId, self._stageId)
		local winScoreRequirements = stageData.winScoreRequirements
		local isWin = true
		local dic = self._kingKaYaMo:getPetPosInExt(self._stageId)

		self._signDic = {}

		for posId, raceId in pairs(dic) do
			self._signDic[raceId] = checknumber(stageData.selfPositionBuffs[posId])
		end

		local txtDescs = {
			self._txtDesc1,
			self._txtDesc2
		}
		local txtResults = {
			self._txtResult1,
			self._txtResult2
		}
		local imgResults = {
			self._imgResult1,
			self._imgResult2
		}
		local iconTags = {
			self._iconTag1,
			self._iconTag2
		}

		for signId, index in ipairs({
			1,
			2
		}) do
			local txtDesc = txtDescs[index]
			local txtResults = txtResults[index]
			local imgResult = imgResults[index]
			local iconTag = iconTags[index]
			local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)
			local curScore = checknumber(signScores[signId])
			local needScore = checknumber(winScoreRequirements[signId])
			local isEnough = needScore <= curScore

			if not isEnough then
				isWin = false
			end

			local color = "#20b376"

			if not isEnough then
				color = "#eb4624"
			end

			txtDesc.text = string.format("%s：%s", signData.desc, needScore)
			txtResults.text = string.format("（<color=%s>%s/%s</color>）", color, curScore, needScore)

			local spriteName = string.format("%s.png", signData.iconPath)

			uGuiUtil.setSpriteToImage(iconTag, uGuiUtil.SpriteType.BigBg, spriteName)
			GameUtil.setUIImageSpriteIdx(imgResult, isEnough and 1 or 0)
		end

		if isWin then
			self._petScrollerList:reloadData(lockRaceIds)
			GameUtil.SetActive(self._imgEmptyPet, #lockRaceIds <= 0)
		else
			self._petScrollerList:reloadData({})
			GameUtil.SetActive(self._imgEmptyPet, true)
		end

		self._txtTitle.text = isWin and "挑战成功" or "挑战失败"
	end
end

function KingKaYaExtClgResultView:onExit()
	KingKaYaExtClgResultView.super.onExit(self)
	self._petScrollerList:dispose()

	local iconTags = {
		self._iconTag1,
		self._iconTag2
	}

	for k, v in pairs(iconTags) do
		uGuiUtil.clearImage(v)
	end
end

function KingKaYaExtClgResultView:_updatePetCell(view, cell, raceId, tag)
	local signId = checknumber(self._signDic[raceId])
	local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local iconTag = goutil.findChild(mainGo, "tag/icon")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local spriteName = string.format("%s.png", signData.iconPath)

	uGuiUtil.setSpriteToImage(iconTag, uGuiUtil.SpriteType.BigBg, spriteName)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function KingKaYaExtClgResultView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local iconTag = goutil.findChild(mainGo, "tag/icon")

	MaterialMgr.clearIcon(item)
	uGuiUtil.clearImage(iconTag)
	GameUtil.rmClickHandler(mainGo)
end

function KingKaYaExtClgResultView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return KingKaYaExtClgResultView
