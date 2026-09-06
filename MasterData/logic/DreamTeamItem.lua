-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/DreamTeamItem.lua

module("logic.extensions.dreamteam.view.DreamTeamItem", package.seeall)

local DreamTeamItem = class("DreamTeamItem")
local MinY = -165
local MaxY = 165

function DreamTeamItem:ctor()
	return
end

function DreamTeamItem:buildUI(go)
	self._go = go
	self._crystalChange = goutil.findChild(go, "crystal"):GetComponent("UIImageSpriteChange")
	self._btnReward = Framework.ButtonAdapter.GetFrom(go, "tag/btnReward")
	self._img = goutil.findChild(go, "tag/img")
	self._txtNum = goutil.findChildTextComponent(go, "tag/txtNum")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtProgress = goutil.findChildTextComponent(go, "txtProgress")
	self._effectGo = goutil.findChild(go, "tag/effect")
	self._btnCrystal = Framework.ButtonAdapter.GetFrom(go, "crystal")
	self._getedGo = goutil.findChild(go, "tag/geted")
	self._shuijingEffectGo = goutil.findChild(go, "effect")
	self._dlEffectGo = goutil.findChild(go, "dleffect")
	self._cardEffectGo = goutil.findChild(go, "cardeffect")

	self._btnReward:AddClickListener(self._onClick, self)
	self._btnCrystal:AddClickListener(self._onClickCrystal, self)

	self._position = go.transform.position
end

function DreamTeamItem:init(data)
	self._data = data
	self._txtName.text = data.cfg.name
	self._txtProgress.text = Mathf.Floor(self:_getPercent() * 100) .. "%"

	local matType, matId, matNum = MaterialMgr.getMatParams(data.cfg.prize)

	MaterialMgr.setIcon(self._img, matType, matId)

	self._txtNum.text = "x" .. matNum

	local isMax = self:_isMax()
	local isGeted = self:_isGeted()

	self:_setGoActive(isMax, isGeted)
	self:_loadEffect()
	self:_setActiveOnEffect(isMax, isGeted)

	self._isClickReward = false
end

function DreamTeamItem:getPosition()
	if not goutil.isNil(self._go) then
		return self._go.transform.position
	end

	return self._position
end

function DreamTeamItem:setCurEnergy(curEnergy)
	self._data.curEnergy = curEnergy

	local isMax = self:_isMax()
	local isGeted = self:_isGeted()

	self:_setGoActive(isMax, isGeted)
	self:_setActiveOnEffect(isMax, isGeted)
end

function DreamTeamItem:_setGoActive(isMax, isGeted)
	self._txtName.gameObject:SetActive(isMax and isGeted)
	self._txtProgress.gameObject:SetActive(not isMax)
	self._getedGo:SetActive(isGeted)
	self._crystalChange:SetState(isMax and isGeted and 1 or 0)
end

function DreamTeamItem:reset()
	MaterialMgr.clearIcon(self._img)

	self._data = nil

	self:_removeEffect()

	if self._numTween then
		self._numTween:Kill()

		self._numTween = nil
	end
end

function DreamTeamItem:_isGeted()
	return DreamTeamModel.instance:isGainOutPrizeById(self._data.cfg.id)
end

function DreamTeamItem:_isMax()
	return self._data.curEnergy >= self._data.cfg.energy
end

function DreamTeamItem:_getPercent()
	if self._data.cfg.energy == 0 then
		return 1
	end

	return self._data.curEnergy / self._data.cfg.energy
end

function DreamTeamItem:_getPercentByNum(energy)
	if self._data.cfg.energy == 0 then
		return 1
	end

	return energy / self._data.cfg.energy
end

function DreamTeamItem:_onClick()
	if not self:_isMax() then
		CommonTipsMgr.instance:openTipsByConfStr(self._btnReward.gameObject, self._data.cfg.prize)

		return
	end

	if self:_isGeted() then
		FloatWordMgr.instance:show("奖励已领取哦")

		return
	end

	if self._isClickReward then
		return
	end

	self._isClickReward = true

	self:_setGoActive(true, true)
	self:_setActiveOnEffect(true, true)
	DreamTeamController.instance:sendFlipTouchGainOutPrizeReq(self._data.activityId, self._data.cfg.id)
end

function DreamTeamItem:_onClickCrystal()
	if not self:_isMax() then
		FloatWordMgr.instance:show(lang("flipgame_tip1"))

		return
	end

	if self:_isGeted() then
		UIStateManager.instance:push(ViewName.PetDrawing, self._data.cfg.raceId)

		return
	end

	if self._isClickReward then
		return
	end

	self._isClickReward = true

	self:_setGoActive(true, true)
	self:_setActiveOnEffect(true, true)
	DreamTeamController.instance:sendFlipTouchGainOutPrizeReq(self._data.activityId, self._data.cfg.id)
end

function DreamTeamItem:_setActiveOnEffect(isMax, isGeted)
	self._effectGo:SetActive(isMax and not isGeted)
	self._shuijingEffectGo:SetActive(not isMax and not isGeted)
	self._dlEffectGo:SetActive(isMax and not isGeted)
	self._cardEffectGo:SetActive(isMax and isGeted)
end

function DreamTeamItem:_loadEffect()
	self:_removeEffect()
	self:_loadSmallRewardEffect()
	self:_loadShuijingEffect()
	self:_loadCardEffect()
	self:_loadDianliangEffect()
end

function DreamTeamItem:_getHeight(percent)
	return (MaxY - MinY) * percent + MinY
end

function DreamTeamItem:_loadSmallRewardEffect()
	self._uiEffect = UIEffectManager.instance:playEffect(self._data.view, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", self._effectGo.transform, 0, 0, true, false)

	self._uiEffect:setParent(self._effectGo.transform)
	self._uiEffect:setScale(0.5)
	self._uiEffect:setSortingOrder(211)
end

function DreamTeamItem:_loadShuijingEffect()
	local newHeight = self:_getHeight(self:_getPercent())

	self._shuijingEffect = UIEffectManager.instance:playEffect(self._data.view, DreamTeamViewPresentor.Shuijing[self._data.index], self._shuijingEffectGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
		if not goutil.isNil(uiEffect.effGo) then
			local trans = uiEffect.effGo.transform:GetChild(1)

			if not goutil.isNil(trans) then
				trans.localPosition = Vector3.New(trans.localPosition.x, newHeight, trans.localPosition.z)
			end
		end
	end, self)

	self._shuijingEffect:setParent(self._shuijingEffectGo.transform)
	self._shuijingEffect:setScale(1)

	self._shuijingEffect.hideEffWhileNotOnTop = false
end

function DreamTeamItem:_loadCardEffect()
	self._cardEffect = UIEffectManager.instance:playEffect(self._data.view, DreamTeamViewPresentor.Card[self._data.index], self._cardEffectGo.transform, 0, 0, true, false)

	self._cardEffect:setParent(self._cardEffectGo.transform)
	self._cardEffect:setScale(1)

	self._cardEffect.hideEffWhileNotOnTop = false
end

function DreamTeamItem:_loadDianliangEffect()
	self._dianliangEffect = UIEffectManager.instance:playEffect(self._data.view, DreamTeamViewPresentor.Dianliang, self._dlEffectGo.transform, 0, 0, true, false)

	self._dianliangEffect:setParent(self._dlEffectGo.transform)
	self._dianliangEffect:setScale(1)

	self._dianliangEffect.hideEffWhileNotOnTop = false
end

function DreamTeamItem:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end

	if self._shuijingEffect then
		UIEffectManager.instance:stopEffect(self._shuijingEffect)

		self._shuijingEffect = nil
	end

	if self._cardEffect then
		UIEffectManager.instance:stopEffect(self._cardEffect)

		self._cardEffect = nil
	end

	if self._dianliangEffect then
		UIEffectManager.instance:stopEffect(self._dianliangEffect)

		self._dianliangEffect = nil
	end
end

function DreamTeamItem:playAnimation(oldEnergy, newEnergy)
	if self._shuijingEffect then
		self._numTween = TweenUtil.DOTweenNum(self:_getPercentByNum(oldEnergy), self:_getPercentByNum(newEnergy), 0.5, function(percent)
			printInfo("test 百分比增长", percent, oldEnergy, newEnergy)

			if self._shuijingEffect and not goutil.isNil(self._shuijingEffect.effGo) then
				local trans = self._shuijingEffect.effGo.transform:GetChild(1)

				if not goutil.isNil(trans) then
					trans.localPosition = Vector3.New(trans.localPosition.x, self:_getHeight(percent), trans.localPosition.z)
				end
			end

			if not goutil.isNil(self._txtProgress) then
				self._txtProgress.text = Mathf.Floor(percent * 100) .. "%"
			end
		end, self):SetEase(DG.Tweening.Ease.Linear):SetDelay(0.6)

		local function onCompleteFunc()
			self:setCurEnergy(newEnergy)
		end

		TweenUtil.SetComplete(self._numTween, nil, onCompleteFunc)
	else
		self:setCurEnergy(newEnergy)
	end
end

return DreamTeamItem
