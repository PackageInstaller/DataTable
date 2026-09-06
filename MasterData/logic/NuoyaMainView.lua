-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/nuoya/NuoyaMainView.lua

module("logic.extensions.timelimitedchallenge.view.amier.NuoyaMainView", package.seeall)

local NuoyaMainView = class("NuoyaMainView", AruisiMainView)

function NuoyaMainView:bindEvents()
	NuoyaMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function NuoyaMainView:unbindEvents()
	NuoyaMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnShop)
end

function NuoyaMainView:buildUI()
	NuoyaMainView.super.buildUI(self)

	self._challengeId = 22
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function NuoyaMainView:_onClickStart()
	if self._isEmpty then
		FloatWordMgr.instance:show(lang("今天的挑战次数已经用完了"))

		return
	end

	UIStateManager.instance:push(ViewName.NuoyaDetailView)
end

function NuoyaMainView:onExit()
	NuoyaMainView.super.onExit(self)
	MaterialMgr.clearIcon(self.head)
end

function NuoyaMainView:onEnter()
	NuoyaMainView.super.onEnter(self)
	self:updateGoShop()
end

function NuoyaMainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function NuoyaMainView:onClickShop()
	local goodsId = NoahChallengeConfig.instance:getChallengeParamValue("NUOYA_GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function NuoyaMainView:_setEffectUrls()
	self._effPaths = {}
end

function NuoyaMainView:_onClickVerify()
	local function onSeletCallBack(petIds, petIdList)
		if petIdList and #petIdList > 0 then
			PetverifyController.instance:sendVerifyPetIds(self._buffPlanId, petIdList, nil, true)
		end
	end

	local planId = self._buffPlanId
	local verifyPlan = PetVerifyBuffConfig.instance:getPlanCfgById(planId)
	local validator = verifyPlan.validator
	local raceIds = string.split(validator, ",")
	local raceIdsList = {}

	for k, v in ipairs(raceIds) do
		table.insert(raceIdsList, checknumber(v))
	end

	local function filterFunc(petMo)
		local ret = false

		for k, v in ipairs(raceIdsList) do
			if petMo.raceId == v then
				ret = true
			end
		end

		return ret
	end

	local strTitle = lang("请选择验证精灵")

	PetSelectController.instance:setOneRaceState()
	PetSelectController.instance:OpenView(#raceIdsList, strTitle, filterFunc, onSeletCallBack, nil)
end

return NuoyaMainView
