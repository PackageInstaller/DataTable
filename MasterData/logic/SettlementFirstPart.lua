-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementFirstPart.lua

module("logic.extensions.battlesettlement.view.SettlementFirstPart", package.seeall)

local SettlementFirstPart = class("SettlementFirstPart")

function SettlementFirstPart:ctor()
	self._time1 = 0.5
	self._delayTime1 = 0.4
	self._time2 = 0.3
	self._delayTime2 = 0.7
	self._time3 = 0.2
	self._delayTime3 = 1.3
	self._needTime = self._time3 + self._delayTime3
end

function SettlementFirstPart:buildUI(parent)
	self._parent = parent
	self._roleModel = goutil.findChild(parent, "roleModel")
	self._dialogbox = goutil.findChild(parent, "dialogbox")
	self._dialogTxt = goutil.findChild(parent, "dialogbox/txt"):GetComponent(goutil.Type_UIText)
	self._dialogBg = goutil.findChild(parent, "dialogbox/bg"):GetComponent(goutil.Type_UIImage)
	self._animShow = goutil.findChild(parent, "animShow"):GetComponent(goutil.Type_RectTransform)
	self._animShowImg = goutil.findChildComponent(parent, "animShow/imgEffect", "UIImageSpriteChange")
	self._effectParent = goutil.findChild(parent, "animShow/effect")
end

function SettlementFirstPart:destroyUI()
	return
end

function SettlementFirstPart:bindEvents()
	return
end

function SettlementFirstPart:unbindEvents()
	return
end

function SettlementFirstPart:onEnter(isSuccess, view)
	if self._isEntered then
		return
	end

	self._isEntered = true
	self._isSuccess = isSuccess

	local raceId = self:_getRaceIdByHurtValue()

	self:_reset()
	self:_init()
	self:_showRoleModel(raceId)
	self:_showDialogTxt(raceId)

	if EndlessBattleModel.instance:getBattleFlag() and self._isSuccess then
		goutil.setActive(self._animShowImg.gameObject, true)
		self._animShowImg:SetState(1)
	elseif BattleSettlementModel.instance:getType() == BattleSettlementModel.Enum.SixArtdaoguanNumbers then
		local params = BattleSettlementModel.instance:getParams()

		self:_loadEffect(view, params.isRead)
	else
		self:_loadEffect(view, self._isSuccess)
	end

	GlobalDispatcher:addListener(GlobalNotify.BattlePetCvUpdate, self._updateBubble, self)
end

function SettlementFirstPart:_updateBubble(word)
	word = word or ""
	self._dialogTxt.text = word
end

function SettlementFirstPart:onExit()
	self._isEntered = false

	PetCvController.instance:turnOffCurCv()

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	GlobalDispatcher:removeListener(GlobalNotify.BattlePetCvUpdate, self._updateBubble, self)
	self:doKillTween()

	if EndlessBattleModel.instance:getBattleFlag() then
		goutil.setActive(self._animShowImg.gameObject, false)
		self._animShowImg:SetState(0)
		EndlessBattleModel.instance:setBattleFlag(false)
	else
		self:_removeEffect()
	end
end

function SettlementFirstPart:getNeedTime()
	return self._needTime
end

function SettlementFirstPart:doKillTween()
	self._dialogBg:DOKill(true)
	self._dialogTxt:DOKill(true)
end

function SettlementFirstPart:doCompleteTween()
	self:doKillTween()

	local dialogBgColor = self._dialogBg.color

	self._dialogBg.color = Color.New(dialogBgColor.r, dialogBgColor.g, dialogBgColor.b, 1)

	local dialogTxtColor = self._dialogTxt.color

	self._dialogTxt.color = Color.New(dialogTxtColor.r, dialogTxtColor.g, dialogTxtColor.b, 1)
end

function SettlementFirstPart:_init()
	self._dialogBg:DOFade(1, self._time2):SetDelay(self._delayTime2)
	self._dialogTxt:DOFade(1, self._time2):SetDelay(self._delayTime2)
end

function SettlementFirstPart:_reset()
	local dialogBgColor = self._dialogBg.color

	self._dialogBg.color = Color.New(dialogBgColor.r, dialogBgColor.g, dialogBgColor.b, 0)

	local dialogTxtColor = self._dialogTxt.color

	self._dialogTxt.color = Color.New(dialogTxtColor.r, dialogTxtColor.g, dialogTxtColor.b, 0)
end

function SettlementFirstPart:_showRoleModel(skinId)
	skinId = checknumber(skinId)

	if skinId == 0 then
		return
	end

	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	local isAuto = true
	local callback

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleModel, scale, callback, isAuto, x, y)
end

function SettlementFirstPart:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SettlementFirstPart:_showDialogTxt(raceId)
	self._dialogbox:SetActive(false)

	if not raceId or raceId == 0 then
		return
	end

	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(raceId)

	self._dialogTxt.text = ""

	local isPerfectWin = BattleSettlementModel.instance:isPerfectWin()

	if isPerfectWin then
		local word = PetCvController.instance:playPetCv(raceId, GameEnum.PetCvType.BattlePerfect)

		self:_updateBubble(word)
	elseif self._isSuccess then
		self._dialogTxt.text = PetCvController.instance:playPetCv(raceId, GameEnum.PetCvType.BattleWin)
	else
		local originRaceId = raceId
		local cfgSkin = PetSkinConfig.instance:getPetSkinCfg(originRaceId)

		if cfgSkin then
			originRaceId = cfgSkin.raceId
		end

		local rare = CharacterConfig.instance:getInitRare(originRaceId)

		if rare > GameEnum.PetRare.R then
			self._dialogTxt.text = PetCvController.instance:playPetCv(raceId, GameEnum.PetCvType.BattleLose)
		end
	end

	self._dialogbox:SetActive(not string.nilorempty(self._dialogTxt.text))
end

function SettlementFirstPart:_isHasLihui(raceId)
	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(raceId))
	local bustName = modelCfg.bustName

	return not string.nilorempty(bustName)
end

function SettlementFirstPart:_getRaceIdByHurtValue()
	local leftTeamId = BattleModel.instance:getLeftTeamId()
	local playerDatas = BattleStatisticsDataModel.instance:getStatistics(leftTeamId)
	local hightHurtData = playerDatas[1]

	for i, v in pairs(playerDatas) do
		if Mathf.Abs(hightHurtData.damage) < Mathf.Abs(v.damage) then
			hightHurtData = v
		end
	end

	local scene = SceneMgr.instance:getCurScene()
	local unit

	if hightHurtData then
		unit = scene.unitFactory:getUnit(hightHurtData.teamId, hightHurtData.charactorId)
	else
		local units = BattleModel.instance:getUnits()

		unit = units[1]
	end

	return unit.attrs:getOriginSkinId()
end

function SettlementFirstPart:_loadEffect(view, isSuccess)
	local effectPath
	local effect = UIEffectManager.instance:playEffect(view, isSuccess and "fx_ui_zhandoujiesuan/fx_ui_shenglijiesuan_shengli.prefab" or "fx_ui_zhandoujiesuan/fx_ui_shenglijiesuan_shibai.prefab", self._effectParent.transform, 0, 0, true, false)

	effect:setParent(self._effectParent.transform)
	effect:setScale(1)

	effect.hideEffWhileNotOnTop = false
	self._uiEffect = effect
end

function SettlementFirstPart:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return SettlementFirstPart
