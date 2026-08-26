-- chunkname: @modules/logic/fight/view/FightCommonalitySlider.lua

module("modules.logic.fight.view.FightCommonalitySlider", package.seeall)

local FightCommonalitySlider = class("FightCommonalitySlider", FightBaseView)

function FightCommonalitySlider:onInitView()
	self._slider = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg")
	self._skillName = gohelper.findChildText(self.viewGO, "slider/txt_commonality")
	self._sliderText = gohelper.findChildText(self.viewGO, "slider/sliderbg/#txt_slidernum")
	self._tips = gohelper.findChild(self.viewGO, "tips")
	self._tipsTitle = gohelper.findChildText(self.viewGO, "tips/#txt_title")
	self._desText = gohelper.findChildText(self.viewGO, "tips/desccont/#txt_descitem")
	self._max = gohelper.findChild(self.viewGO, "slider/max")
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
end

function FightCommonalitySlider:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.FightProgressValueChange, self._refreshData)
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self._refreshData)
	self:com_registClick(self._click, self._onBtnClick)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
end

function FightCommonalitySlider:_onTouchFightViewScreen()
	gohelper.setActive(self._tips, false)
end

function FightCommonalitySlider:_onBtnClick()
	gohelper.setActive(self._tips, true)
end

function FightCommonalitySlider:_refreshData()
	local skillId = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]
	local skillConfig = lua_skill.configDict[skillId]

	if skillConfig then
		self._skillName.text = skillConfig.name
		self._tipsTitle.text = skillConfig.name
		self._desText.text = FightConfig.instance:getSkillEffectDesc(nil, skillConfig)
	end

	local progress = FightDataHelper.fieldMgr.progress
	local max = FightDataHelper.fieldMgr.progressMax
	local isMax = max <= progress

	if self._lastMax ~= isMax then
		gohelper.setActive(self._max, isMax)
	end

	local percent = progress / max

	self._sliderText.text = Mathf.Clamp(percent * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(self._slider)
	ZProj.TweenHelper.DOFillAmount(self._slider, percent, 0.2 / FightModel.instance:getUISpeed())

	self._lastMax = isMax

	local progressId = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId]

	if progressId == 2 then
		local enemyVertin = FightDataHelper.entityMgr:getEnemyVertin()

		if enemyVertin then
			local buffDic = enemyVertin.buffDic

			for k, buffMO in pairs(buffDic) do
				if buffMO.buffId == 9260101 then
					self._sliderText.text = buffMO.duration

					break
				end
			end
		end
	end
end

function FightCommonalitySlider:onClose()
	ZProj.TweenHelper.KillByObj(self._slider)
end

return FightCommonalitySlider
