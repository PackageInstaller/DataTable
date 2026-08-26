-- chunkname: @modules/logic/fight/view/FightViewTechniqueCell.lua

module("modules.logic.fight.view.FightViewTechniqueCell", package.seeall)

local FightViewTechniqueCell = class("FightViewTechniqueCell", ListScrollCell)

function FightViewTechniqueCell:init(go)
	self._click = gohelper.getClickWithAudio(go)
	self._txtName = gohelper.findChildText(go, "effectname")
	self._img = gohelper.findChildSingleImage(go, "icon")
	self._animator = go:GetComponent(typeof(UnityEngine.Animator))
	self._moPlayHistory = {}
end

function FightViewTechniqueCell:addEventListeners()
	self.addEventCb(self, FightController.instance, FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	self._click:AddClickListener(self._onClickItem, self)
end

function FightViewTechniqueCell:removeEventListeners()
	self._click:RemoveClickListener()
end

function FightViewTechniqueCell:_onStartSequenceFinish()
	if self._mo and not gohelper.isNil(self._animator) then
		self._animator:Play("fight_effecttips_loop")
		self._animator:Update(0)
	end
end

function FightViewTechniqueCell:onUpdateMO(mo)
	if (not self._mo or self._mo ~= mo) and not mo.hasPlayAnimin and not gohelper.isNil(self._animator) then
		mo.hasPlayAnimin = true
		self._moPlayHistory[mo] = true

		self._animator:Play("fight_effecttips")
		self._animator:Update(0)
	end

	self._mo = mo

	local co = lua_fight_technique.configDict[mo.id]

	if co then
		self._txtName.text = co.title_cn or ""
	end

	if co and not string.nilorempty(co.icon) then
		self._img:LoadImage(ResUrl.getFightIcon(co.icon) .. ".png")
	end
end

function FightViewTechniqueCell:onDestroy()
	if self._img then
		self._img:UnLoadImage()

		self._img = nil
	end

	if self._moPlayHistory then
		for mo, _ in pairs(self._moPlayHistory) do
			mo.hasPlayAnimin = nil
		end

		self._moPlayHistory = nil
	end
end

function FightViewTechniqueCell:_onClickItem()
	local guideFlag = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickTechnique)

	if guideFlag then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local doingGuideIdList = GuideModel.instance:getDoingGuideIdList()

	if doingGuideIdList then
		if not #doingGuideIdList then
			local doingGuideIdCount = 0

			if not FightModel.instance:isStartFinish() and doingGuideIdCount > 0 then
				return
			end

			ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, lua_fight_technique.configDict[self._mo.id])
		end
	end
end

return FightViewTechniqueCell
