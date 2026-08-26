-- chunkname: @modules/logic/fight/view/FightCommonalitySlider2.lua

module("modules.logic.fight.view.FightCommonalitySlider2", package.seeall)

local FightCommonalitySlider2 = class("FightCommonalitySlider2", FightBaseView)

function FightCommonalitySlider2:onInitView()
	self.sliderBg = gohelper.findChild(self.viewGO, "slider/sliderbg")
	self._slider = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg")
	self._sliderText = gohelper.findChildText(self.viewGO, "slider/sliderbg/#txt_slidernum")
	self.effective = gohelper.findChild(self.viewGO, "slider/#max")
	self.durationText = gohelper.findChildText(self.viewGO, "slider/#max/#txt_round")
end

function FightCommonalitySlider2:onConstructor(root)
	self.fightRoot = root
end

function FightCommonalitySlider2:onOpen()
	self:_refreshData(true)
	self:com_registMsg(FightMsgId.FightProgressValueChange, self._refreshData)
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self._refreshData)
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._refreshData)
end

function FightCommonalitySlider2:_refreshData(isOpen)
	local progress = FightDataHelper.fieldMgr.progress
	local max = FightDataHelper.fieldMgr.progressMax
	local isMax = max <= progress

	if self._lastMax ~= isMax then
		gohelper.setActive(self._max, isMax)
	end

	local percent = progress / max

	self._sliderText.text = Mathf.Clamp(percent * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(self._slider)

	if isOpen then
		self._slider.fillAmount = percent
	else
		ZProj.TweenHelper.DOFillAmount(self._slider, percent, 0.2 / FightModel.instance:getUISpeed())
	end

	gohelper.setActive(self.sliderBg, true)
	gohelper.setActive(self.effective, false)

	self._lastMax = isMax

	local showScreenEffect = false
	local progressId = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressId]

	if progressId == 2 then
		local myVertin = FightDataHelper.entityMgr:getMyVertin()

		if myVertin then
			local buffDic = myVertin.buffDic

			for k, buffMO in pairs(buffDic) do
				if buffMO.buffId == 9260101 then
					gohelper.setActive(self.sliderBg, false)
					gohelper.setActive(self.effective, true)

					self.durationText.text = buffMO.duration
					showScreenEffect = true

					break
				end
			end
		end
	end

	self:checkShowScreenEffect(showScreenEffect)
end

function FightCommonalitySlider2:checkShowScreenEffect(showScreenEffect)
	if not self._effectRoot then
		self._effectRoot = gohelper.create2d(self.fightRoot, "FightCommonalitySlider2ScreenEffect")

		local transform = self._effectRoot.transform

		transform.anchorMin = Vector2.zero
		transform.anchorMax = Vector2.one
		transform.offsetMin = Vector2.zero
		transform.offsetMax = Vector2.zero

		self:com_loadAsset("ui/viewres/fight/fight_weekwalk_screeneff.prefab", self.onScreenEffectLoaded)
	end

	gohelper.setActive(self._effectRoot, showScreenEffect)
end

function FightCommonalitySlider2:onScreenEffectLoaded(success, loader)
	if not success then
		return
	end

	local obj = loader:GetResource()

	gohelper.clone(obj, self._effectRoot)
end

function FightCommonalitySlider2:_onBuffUpdate(entityId, effectType, buffId)
	if buffId == 9260101 then
		self:_refreshData()
	end
end

function FightCommonalitySlider2:onClose()
	ZProj.TweenHelper.KillByObj(self._slider)
end

return FightCommonalitySlider2
