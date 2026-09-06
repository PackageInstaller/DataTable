-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggSuccessView.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggSuccessView", package.seeall)

local DragonPsychicClgNormalEggSuccessView = class("DragonPsychicClgNormalEggSuccessView", ViewComponent)

function DragonPsychicClgNormalEggSuccessView:buildUI()
	DragonPsychicClgNormalEggSuccessView.super.buildUI(self)

	self._cardCell = goutil.findChild(self.mainGO, "cardCell")
	self._txtLvl = goutil.findChildTextComponent(self.mainGO, "cardCell/txtLvl")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "cardCell/txtName")
	self._con = goutil.findChild(self.mainGO, "cardCell/mask/con")
	self._btnSure = goutil.findChild(self.mainGO, "cardCell/btnSure")
	self._Img_attr = goutil.findChild(self.mainGO, "cardCell/Nego_Attr/Img_attr")
	self._ImgC_Job = goutil.findChild(self.mainGO, "cardCell/layout/Nego_Job/ImgC_Job")
	self._ImgC_Job_1 = goutil.findChild(self.mainGO, "cardCell/layout/Nego_Job1/ImgC_Job")
end

function DragonPsychicClgNormalEggSuccessView:bindEvents()
	DragonPsychicClgNormalEggSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DragonPsychicClgNormalEggSuccessView:unbindEvents()
	DragonPsychicClgNormalEggSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DragonPsychicClgNormalEggSuccessView:onEnter()
	DragonPsychicClgNormalEggSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._creepsId = checknumber(params[2])
	self._activityType = DragonPsychicClgController.instance:getActivityType()

	local isInTime = DragonPsychicClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._petData = DragonPsychicClgConfig.instance:getDpcSystemPetData(self._activityId, self._creepsId)

	if self._petData == nil then
		printError(string.format("无此精灵( xl-龙系通灵师挑战.xlsx | export_系统精灵 | activityId=%s, creepsId=%s )", self._activityId, self._creepsId))
		self:close()

		return
	end

	self._actData = DragonPsychicClgConfig.instance:getDpcData(self._activityId)

	local skinId = checknumber(self._petData.faceId)

	if skinId <= 0 then
		skinId = self._petData.raceId
	end

	local modelCo = CharacterConfig.instance:getModelCo(skinId)

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._con, uGuiUtil.SpriteType.BigBg, imgUrl)
	else
		uGuiUtil.clearImage(self._con)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	GameUtil.setUIImageSpriteIdx(self._Img_attr, race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	GameUtil.setUIImageSpriteIdx(self._ImgC_Job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(self._ImgC_Job_1, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(self._ImgC_Job_1, secondJobIdx - 1 - 20)
	end

	self._txtLvl.text = self._petData.lv
	self._txtName.text = self._petData.creepsName
end

function DragonPsychicClgNormalEggSuccessView:onExit()
	DragonPsychicClgNormalEggSuccessView.super.onExit(self)
	uGuiUtil.clearImage(self._con)
end

function DragonPsychicClgNormalEggSuccessView:_onClickBtnSure()
	self:close()
end

return DragonPsychicClgNormalEggSuccessView
