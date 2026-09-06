-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mingjing/MingjingMainView.lua

module("logic.extensions.timelimitedchallenge.view.amier.MingjingMainView", package.seeall)

local MingjingMainView = class("MingjingMainView", AruisiMainView)

function MingjingMainView:buildUI()
	MingjingMainView.super.buildUI(self)

	self._challengeId = 12
end

function MingjingMainView:_onClickStart()
	if self._isEmpty then
		FloatWordMgr.instance:show(lang("今天的挑战次数已经用完了"))

		return
	end

	UIStateManager.instance:push(ViewName.MingjingDetailView)
end

function MingjingMainView:onEnter()
	MingjingMainView.super.onEnter(self)
	self._btnBuffTip.gameObject:SetActive(false)
	self._btnTry.gameObject:SetActive(false)
	self._tipTry.gameObject:SetActive(false)
end

function MingjingMainView:_setEffectUrls()
	self._effPaths = {}
end

function MingjingMainView:_onClickVerify()
	if self._buffPlanId == nil then
		print("buffPlanId为空")

		return
	end

	UIStateManager.instance:push(ViewName.PetverifyView, self._buffPlanId)
end

function MingjingMainView:_onClickVerify()
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

return MingjingMainView
