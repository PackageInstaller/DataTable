-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerLevelView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerLevelView", package.seeall)

local CrazyPartnerLevelView = class("CrazyPartnerLevelView", ViewComponent)
local MainEffectPath = "20220513/baozouhuoban/fx_ui_baozouhuoban_jiemian1.prefab"

function CrazyPartnerLevelView:ctor()
	CrazyPartnerLevelView.super.ctor(self)
end

function CrazyPartnerLevelView:unbindEvents()
	CrazyPartnerLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function CrazyPartnerLevelView:bindEvents()
	CrazyPartnerLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CrazyPartnerLevelView:buildUI()
	CrazyPartnerLevelView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtBubble = self:getTxt("bubble/txtBubble")
	self._lihui = self:getGo("Base")
	self._activityId = CrazyPartnerModel.instance:getActivityId()
	self._mainEffectGo = self:getGo("effect")
end

function CrazyPartnerLevelView:onExit()
	CrazyPartnerLevelView.super.onExit(self)
	CrazyPartnerController.instance:unregisterLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updateUI, self)
	RoleObjectPool.instance:removeRole(self._chara)

	for i = 1, 3 do
		local item = goutil.findChild(self.mainGO, string.format("btnEnter_%d", i))
		local petAnchor = goutil.findChild(item, "container/mask/con")

		uGuiUtil.clearImage(petAnchor)
	end

	self:_removeMainEffect()
end

function CrazyPartnerLevelView:onEnter()
	CrazyPartnerLevelView.super.onEnter(self)
	CrazyPartnerController.instance:registerLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updateUI, self)

	self._txtBubble.text = lang(CrazyPartnerConfig.instance:getCommonValue("LEVEL_BUBBLE"))

	local raceId = checknumber(CrazyPartnerConfig.instance:getCommonValue("LEVEL_PET_RACE_ID"))
	local displayBagOffset = CharactorFacade.instance:getPetBagLihuiModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._chara = RoleObjectPool.instance:addRoleToParent(self._chara, raceId, self._lihui, scale, nil, true, x, y)

	self:_setActivityTime()
	self:_updateUI()
	self:_addMainEffect()
end

function CrazyPartnerLevelView:_setActivityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CRAZY_PARTNER, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function CrazyPartnerLevelView:_updateUI()
	if goutil.isNil(self.mainGO) then
		return
	end

	local model = CrazyPartnerModel.instance
	local raceIdConf = CrazyPartnerConfig.instance:getLevelRaceIdsConf()
	local raceIds = raceIdConf.raceIds

	for i = 1, 3 do
		local item = goutil.findChild(self.mainGO, string.format("btnEnter_%d", i))
		local petAnchor = goutil.findChild(item, "container/mask/con")
		local txtMostDamage = goutil.findChildTextComponent(item, "container/txtMostDamage")
		local txtScore = goutil.findChildTextComponent(item, "container/txtScore")
		local info = model:getDifficultyInfoByIndex(i)
		local raceId = checknumber(raceIds[i])

		if info then
			txtMostDamage.text = info.damage
			txtScore.text = info.score
		end

		if raceId > 0 then
			local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

			if not modelCo then
				printError("t_model id not exist:" .. raceId)

				return
			end

			local url = GameUrl.getPetImgUrl(modelCo.cardName)

			uGuiUtil.setSpriteToImage(petAnchor, uGuiUtil.SpriteType.BigBg, url)
		end

		GameUtil.addClickHandler(goutil.findChildButtonComponent(item, "container"), GameUtil.handler(self._onClickEnter, self, i))
	end
end

function CrazyPartnerLevelView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function CrazyPartnerLevelView:_addMainEffect()
	self:_removeMainEffect()

	local eff = UIEffectManager.instance:playEffect(self, MainEffectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function CrazyPartnerLevelView:_onClickTip()
	local ruleKey = CrazyPartnerConfig.instance:getCommonValue("LEVEL_RULE_KEY")

	UIStateManager.instance:push(ViewName.RulesView, ruleKey)
end

function CrazyPartnerLevelView:_onClickEnter(index)
	CrazyPartnerModel.instance:clearViewInfos()
	CrazyPartnerModel.instance:addViewInfo(ViewName.CrazyPartnerMainView)
	CrazyPartnerModel.instance:addViewInfo(ViewName.CrazyPartnerLevelView)
	CrazyPartnerController.instance:enterFightPrepare(index)
end

return CrazyPartnerLevelView
