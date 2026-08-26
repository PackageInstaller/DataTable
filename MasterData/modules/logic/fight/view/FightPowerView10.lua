-- chunkname: @modules/logic/fight/view/FightPowerView10.lua

module("modules.logic.fight.view.FightPowerView10", package.seeall)

local FightPowerView10 = class("FightPowerView10", FightBaseView)

function FightPowerView10:onInitView()
	self.listenClass = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.FightSceneActiveState))

	self.listenClass:setCallback(self.onActiveChange, self)

	self.batAnimator = gohelper.findChildComponent(self.viewGO, "content/bar", typeof(UnityEngine.Animator))
	self.img_fg = gohelper.findChildImage(self.viewGO, "content/bar/#image_fg")
	self.img_fg.raycastTarget = true
	self.sliderClick = gohelper.getClickWithDefaultAudio(self.img_fg.gameObject)
	self.img_reduce = gohelper.findChildImage(self.viewGO, "content/bar/#image_reduce")
	self.click_witness = gohelper.findChildClickWithDefaultAudio(self.viewGO, "content/bar/#btn_underwitness")
	self.click_find = gohelper.findChildClickWithDefaultAudio(self.viewGO, "content/bar/#btn_find")
	self.shield = gohelper.findChild(self.viewGO, "content/bar/#Shield")
	self.go_tips = gohelper.findChild(self.viewGO, "content/#go_tips")

	local canvas = gohelper.onceAddComponent(self.go_tips, typeof(UnityEngine.Canvas))

	canvas.overrideSorting = true
	canvas.sortingOrder = 3

	gohelper.setActive(self.go_tips, false)

	self.text_desc1 = gohelper.findChildText(self.viewGO, "content/#go_tips/tipsbg/desc1/#txt_desc1")
	self.text_desc2 = gohelper.findChildText(self.viewGO, "content/#go_tips/tipsbg/#txt_desc2")
	self.go_eyeWitnessRound = gohelper.findChild(self.viewGO, "content/#go_eyewitnessround")
	canvas = gohelper.onceAddComponent(self.go_eyeWitnessRound, typeof(UnityEngine.Canvas))
	canvas.overrideSorting = true
	canvas.sortingOrder = -10

	gohelper.setActive(self.go_eyeWitnessRound, false)
end

function FightPowerView10:addEvents()
	self:com_registClick(self.sliderClick, self.onClickSlider)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self.onTouchFightViewScreen)
	self:com_registFightEvent(FightEvent.BeforeDestroyEntity, self.onBeforeDestroyEntity)

	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registClick(self.click_witness, self.onClickWitness)
	self:com_registClick(self.click_find, self.onClickFind)
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
end

function FightPowerView10:removeEvents()
	return
end

function FightPowerView10:onConstructor(entityId, powerData)
	self.entityId = entityId
	self.powerData = powerData

	self:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, self.onBeforeEnterStepBehaviour)
end

function FightPowerView10:onBeforeEnterStepBehaviour()
	self.showView = true

	gohelper.setActive(self.viewGO, true)
end

function FightPowerView10:onTouchFightViewScreen()
	gohelper.setActive(self.go_tips, false)
end

function FightPowerView10:onClickSlider()
	gohelper.setActive(self.go_tips, true)
end

function FightPowerView10:onClickWitness()
	return
end

function FightPowerView10:onClickFind()
	return
end

function FightPowerView10:onPowerChange(targetId, powerId, oldValue, newValue)
	if powerId ~= 10 then
		return
	end

	self:refreshSlider()

	if oldValue == 0 and newValue == self.powerData.max then
		self.batAnimator:Play("max", 0, 0)

		self.curAniName = "idle"

		AudioMgr.instance:trigger(20320141)
	end
end

function FightPowerView10:playAni(aniName)
	self.batAnimator:Play(aniName, 0, 0)

	self.curAniName = aniName
end

function FightPowerView10:onAddBuff(buffData)
	if buffData.buffId == lua_activity128_const.configDict[7].value1 then
		self:playAni("zero")
		AudioMgr.instance:trigger(20320142)
	elseif buffData.buffId == lua_activity128_const.configDict[8].value1 then
		gohelper.setActive(self.go_eyeWitnessRound, true)
		AudioMgr.instance:trigger(20320144)
	elseif buffData.buffId == lua_activity128_const.configDict[9].value1 then
		gohelper.setActive(self.go_eyeWitnessRound, false)
		gohelper.setActive(self.shield, true)
	end
end

function FightPowerView10:onRemoveBuff(buffData)
	if buffData.buffId == lua_activity128_const.configDict[7].value1 then
		-- block empty
	elseif buffData.buffId == lua_activity128_const.configDict[8].value1 then
		gohelper.setActive(self.go_eyeWitnessRound, false)
	elseif buffData.buffId == lua_activity128_const.configDict[9].value1 then
		gohelper.setActive(self.shield, false)
	end
end

function FightPowerView10:onOpen()
	if not self.showView then
		gohelper.setActive(self.viewGO, false)
	end

	self:refreshSlider()

	local descConfig = lua_activity128_conceal_desc.configDict[FightDataHelper.fieldMgr.episodeId]

	if descConfig then
		local arr = string.split(descConfig.spDesc, "|")

		self.text_desc2.text = arr[1]

		for i = 1, #arr - 1 do
			local childObj = gohelper.clone(self.text_desc2.gameObject, self.text_desc2.transform.parent.gameObject)
			local text = gohelper.onceAddComponent(childObj, gohelper.Type_TextMesh)

			text.text = arr[i + 1]
		end
	else
		self.text_desc2.text = ""
	end
end

function FightPowerView10:refreshSlider()
	self.tweenComp:DOFillAmount(self.img_fg, self.powerData.num / self.powerData.max, 0.2)
	self:com_registSingleTimer(self.refreshReduceSlider, 0.1)

	self.text_desc1.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("fight_conceal_value"), self.powerData.num)
end

function FightPowerView10:refreshReduceSlider()
	self.tweenComp:DOFillAmount(self.img_reduce, self.powerData.num / self.powerData.max, 0.2)
end

function FightPowerView10:onActiveChange(isActive)
	if isActive then
		self.batAnimator:Play(self.curAniName, 0, 1)
	end
end

function FightPowerView10:onBeforeDestroyEntity(entity)
	if entity.id == self.entityId then
		self.showView = false

		gohelper.setActive(self.viewGO, false)
	end
end

function FightPowerView10:onClose()
	self.listenClass:releaseCallback()
end

function FightPowerView10:onDestroyView()
	return
end

return FightPowerView10
