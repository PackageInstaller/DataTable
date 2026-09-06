-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeViewBase.lua

module("logic.extensions.bag.view.stack.PetAwakeViewBase", package.seeall)

local PetAwakeViewBase = class("PetAwakeViewBase", ViewComponent)

function PetAwakeViewBase:onEnter()
	PetAwakeViewBase.super.onEnter(self)
	goutil.setActive(self._mask, false)

	self._usedItemIds = {}
end

function PetAwakeViewBase:onExit()
	PetAwakeViewBase.super.onExit(self)
	removetimer(self._openLvupView, self)
	goutil.setActive(self._mask, false)
	self:_clearEff()
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._playStarEffect, self)
end

function PetAwakeViewBase:_clearEff()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)
	end

	self._eff = nil
end

function PetAwakeViewBase:_checkAndReq()
	local awakenType = CharacterConfig.instance:getPetAwakenType(self._mo.raceId, self._mo.awakenLv)
	local awakenTitle = ConstString.PetAwakenTypeText[awakenType]

	if self._isMaxAwaken then
		FloatWordMgr.instance:show(lang("该精灵已经满觉醒"))

		return
	end

	self._prePower = self._mo:getFightingPower()

	local isMatEnough = #self._selectedPetIds + #self._usedItemIds == self._costCfg.needPetNum

	if not isMatEnough then
		FloatWordMgr.instance:show("请选中觉醒需要的精灵")

		return
	end

	local isGoldEnough = self._costCfg.needCoinNum <= MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)
	local matExt = self._costCfg.extCostItem

	if not string.nilorempty(matExt) then
		local matArr = string.split(matExt, ":")
		local matType = matArr[1]
		local matId = matArr[2]
		local matNum = checknumber(matArr[3])
		local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if curNum < matNum then
			local matCfg = MaterialMgr.getMatCfg(matType, matId)
			local content = string.format("试炼所需的道具%s不足", matCfg.name)

			FloatWordMgr.instance:show(content)

			return
		end
	end

	if not isGoldEnough then
		FloatWordMgr.instance:show("金币不足")
	else
		local usedPetIds_i32_Ary = {}
		local hasSSR = false
		local hasSame = false
		local hasSameSSR = false

		for _, v in ipairs(self._selectedPetIds) do
			table.insert(usedPetIds_i32_Ary, v)

			local mo = BagModel.instance:getPet(v)

			if mo then
				local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)

				if petCfg and petCfg.initAwakenLv > 1 then
					if not hasSame and mo.raceId == self._mo.raceId then
						hasSame = true
					end

					if not hasSSR and mo.rare >= GameEnum.PetRare.SR then
						hasSSR = true
					end

					if not hasSameSSR and mo.raceId == self._mo.raceId and mo.rare >= GameEnum.PetRare.SR then
						hasSameSSR = true
					end
				end
			end
		end

		local isSameUpType = self._costCfg.petCostType == GameEnum.PetStarUpStrategy.RaceId
		local keyWords = {}

		if isSameUpType then
			if hasSSR then
				table.insert(keyWords, "<color=#C54949>超能及以上品质</color>")
			end
		elseif hasSameSSR then
			table.insert(keyWords, "<color=#C54949>同名</color>的<color=#C54949>超能及以上品质</color>")
		else
			if hasSSR then
				table.insert(keyWords, "<color=#C54949>超能及以上品质</color>")
			end

			if hasSame then
				table.insert(keyWords, "<color=#C54949>同名</color>")
			end
		end

		self._curIndex = 1
		self._tips = {}

		for _, v in ipairs(keyWords) do
			table.insert(self._tips, string.format("你选择的%s材料中包含%s精灵喔。你确定要继续进行%s吗？", awakenTitle, v, awakenTitle))
		end

		self._usedPetIds = usedPetIds_i32_Ary

		self:_tipsAndReq()
	end
end

function PetAwakeViewBase:startAwake()
	local isMax = self._mo.awakenLv >= BagModel.instance:getMaxAwakenLv(self._mo.raceId)
	local awakenType = CharacterConfig.instance:getPetAwakenType(self._mo.raceId, self._mo.awakenLv)
	local awakenTitle = ConstString.PetAwakenTypeText[awakenType]

	if not isMax and self._mo.awakenLv >= 5 then
		local tip = string.format("你背包中已经有1只<color=#eb4642>更高星级</color>的<color=#eb4642>%s</color>喔。你确定要<color=#eb4642>继续进行%s</color>吗？", self._mo.name, awakenTitle)

		TipsFacade.instance:openPopupWindow("提示", tip, function()
			self:_checkAndReq()
		end, nil, "确定", "取消")
	else
		self:_checkAndReq()
	end
end

function PetAwakeViewBase:_getPetSelectTitle(cfg, num)
	local title = ""
	local upType = self._costCfg.petCostType
	local lvText = CharacterConfig.instance:getAwakenLvText(self._costCfg.needPetAwakenLv)

	if upType == GameEnum.PetStarUpStrategy.RaceId then
		title = string.format("需要%s名%s<color=#00ff>%s</color>", num or self._costCfg.needPetNum, lvText, cfg.name)
	elseif upType == GameEnum.PetStarUpStrategy.Attr then
		local firstEle = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.raceId)
		local eleName = ConstString.Race[firstEle]

		title = string.format("需要%s名%s<color=#ebad32>%s属性</color>精灵", num or self._costCfg.needPetNum, lvText, eleName)
	elseif upType == GameEnum.PetStarUpStrategy.Job then
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		title = string.format("需要%s名%s%s职业精灵", num or self._costCfg.needPetNum, lvText, ConstString.JobIdxToStr[firstJobIdx])
	end

	return title
end

function PetAwakeViewBase:_getCardTag(mo)
	if self._costCfg == nil then
		return 1
	end

	local cfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local upType = self._costCfg.petCostType
	local rare = CharacterConfig.instance:getRareByAwakenLv(mo.awakenLv, mo.raceId)

	if upType == GameEnum.PetStarUpStrategy.RaceId then
		if rare == GameEnum.PetRare.UR then
			return GameEnum.AwakenCardTag.SameRaceIdUR
		else
			return GameEnum.AwakenCardTag.SameRaceIdSSR
		end
	elseif upType == GameEnum.PetStarUpStrategy.Attr then
		return PetSkinConfig.instance:getFisrtEleAttrIdx(mo.curFaceId)
	elseif upType == GameEnum.PetStarUpStrategy.Job then
		return 1
	end
end

function PetAwakeViewBase:_reqAwake()
	goutil.setActive(self._mask, true)

	self._isAwaking = true
	self._preMo = self._mo:GetClone()

	PetAgent.instance:sendPM_PetAwakenReq(self._mo.petId, self._usedPetIds, self._usedItemIds, self._onAwakeSuccess, self)
end

function PetAwakeViewBase:_tipsAndReq()
	if #self._tips >= self._curIndex then
		local tip = self._tips[self._curIndex]

		self._curIndex = self._curIndex + 1

		TipsFacade.instance:openPopupWindow("提示", tip, function()
			self:_tipsAndReq()
		end, nil, "确定", "取消")
	else
		self:_reqAwake()
	end
end

function PetAwakeViewBase:_onAwakeSuccess(msg)
	self._changeSetId = msg.changeSetId

	ItemGetController.instance:setTitleType(self._changeSetId, ItemGetController.TITLE_RETURNMAT)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._selectedPetIds = {}
	self._usedItemIds = 0

	self:_playStarEffect()
	settimer(0.3, self._openLvupView, self, false)
	GlobalDispatcher:dispatch(GlobalNotify.PetRedPointUpdate)
end

function PetAwakeViewBase:_playStarEffect()
	self._isAwaking = false

	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._playStarEffect, self)
end

function PetAwakeViewBase:_openLvupView()
	self:_clearEff()
	MaterialController.instance:showChangeSetInTemp(self._changeSetId)
	goutil.setActive(self._mask, false)
	UIStateManager.instance:open(ViewName.PetUp, GameEnum.PetUpType.PetAwake, self._mo, self._preMo)
end

return PetAwakeViewBase
