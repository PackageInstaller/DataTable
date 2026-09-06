-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeLvupView.lua

module("logic.extensions.bag.view.stack.PetAwakeLvupView", package.seeall)

local PetAwakeLvupView = class("PetAwakeLvupView", PetAwakeLvupBaseView)

function PetAwakeLvupView:destroyUI()
	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self._effs = nil

	removetimer(self._playStarEffect, self)
	PetAwakeLvupView.super.destroyUI(self)
end

function PetAwakeLvupView:onExitFinished()
	PetAwakeLvupView.super.onExitFinished(self)

	if self._closeCall then
		self._closeCall()
	end
end

function PetAwakeLvupView:onExit()
	PetAwakeLvupView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self._effs = nil

	removetimer(self._playStarEffect, self)
	MaterialMgr.resetAll(self._oldRare)
	MaterialMgr.resetAll(self._newRare)
end

function PetAwakeLvupView:buildUI()
	PetAwakeLvupView.super.buildUI(self)

	self._txtLeftPower = goutil.findChildTextComponent(self.mainGO, "Info/AttrTxtOld")
	self._txtRightPower = goutil.findChildTextComponent(self.mainGO, "Info/AttrTxt")

	GameUtil.SetActive(self:getGo("starGird"), false)

	self._starImgs = {}

	for i = 1, 6 do
		table.insert(self._starImgs, goutil.findChildComponent(self.mainGO, "starGird/star_" .. i, typeof(UIImageSpriteChange)))
	end

	self.txtAwake = self:getTxt("txtAwake")
	self._attrsLayout = self:getGo("Info/attrsLayout"):GetComponent("UILayoutSingleLine")
	self._attrs = GameUtil.getChildren(self._attrsLayout.gameObject)
	self._skillUpBg = self:getGo("Bg/skillUpBg")
	self._textList = GameUtil.getChildren(self._skillUpBg)
	self._rare = self:getGo("rare")
	self._oldRare = goutil.findChild(self._rare, "oldRare")
	self._newRare = goutil.findChild(self._rare, "newRare")
end

function PetAwakeLvupView:_updateUI()
	self:_updateAttrs()
	self:_updateSkillUp()

	local awakenLv = self._mo.awakeLevel

	if awakenLv == 0 then
		self.txtAwake.text = lang("无觉醒")
	else
		local lvl = GameUtil.toRomanNumber(awakenLv)

		self.txtAwake.text = langPara("觉醒%s", lvl)
	end

	self._txtLeftPower.text = self._preMo:getFightingPower()
	self._txtRightPower.text = self._mo:getFightingPower()
	self._curIndex = 1

	local oldRare = self._preMo.rare
	local newRare = self._mo.rare
	local raceId = self._mo.raceId

	print("oldRare = " .. oldRare .. " newRare = " .. newRare)

	if oldRare ~= newRare then
		local proxy = MaterialMgr.setCell(MatType.Rare, raceId, self._oldRare)

		proxy.binder:setRare(oldRare)

		proxy = MaterialMgr.setCell(MatType.Rare, raceId, self._newRare)

		proxy.binder:setRare(newRare)
		self._rare:SetActive(true)
	else
		MaterialMgr.resetAll(self._oldRare)
		MaterialMgr.resetAll(self._newRare)
		self._rare:SetActive(false)
	end
end

function PetAwakeLvupView:_playStarEffect()
	if self._curIndex <= self._stars then
		local parent = self._starImgs[self._curIndex].gameObject
		local path = "fx_ui_shengxingchenggong_02/fx_ui_shengxing01_huang.prefab"
		local eff = UIEffectManager.instance:playHUDEffect(path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		self._curIndex = self._curIndex + 1

		table.insert(self._effs, eff)
		settimer(0.1, self._playStarEffect, self, false)
	end
end

local effPaths = {}

function PetAwakeLvupView:onEnter()
	PetAwakeLvupView.super.onEnter(self)

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._mo = params[1]
	self._preMo = params[2]
	self._closeCall = params[3]

	self:_updateUI()
end

function PetAwakeLvupView:_onClickClose()
	self:close()
end

return PetAwakeLvupView
