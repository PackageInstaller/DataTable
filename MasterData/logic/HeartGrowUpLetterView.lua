-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/view/HeartGrowUpLetterView.lua

module("logic.extensions.growup.view.HeartGrowUpLetterView", package.seeall)

local HeartGrowUpLetterView = class("HeartGrowUpLetterView", BuryGameLetterView)

function HeartGrowUpLetterView:buildUI()
	HeartGrowUpLetterView.super.buildUI(self)

	self._txtDesc = self:getTxt("letterAnim/txtDesc")
end

function HeartGrowUpLetterView:onEnter()
	self._btnClick.gameObject:SetActive(false)
	self._btnAccept.gameObject:SetActive(false)

	local url = "fx_ui_20211014/xinxinniannian_xinfengspine/xinxinniannian_xinfeng-ui_p.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, url, self._effPoint, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	local openParam = self:getOpenParam()

	self._type = openParam[1]
	self._activityId = openParam[2]

	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGainPetRes, self.close, self)
end

function HeartGrowUpLetterView:onExit()
	HeartGrowUpLetterView.super.onExit(self)
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGainPetRes, self.close, self)
	removetimer(self._effectEnd, self)
end

function HeartGrowUpLetterView:_onClickAccept()
	PetGrowthPathAgent.instance:sendPM_PetGrowthPathGainPetReq(self._activityId)
	PetGrowthPathAgent.instance:sendPM_PetGrowthPathGetInfoReq(self._activityId)
end

function HeartGrowUpLetterView:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._effPoint.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	self._btnClick.gameObject:SetActive(true)

	if self._type then
		self:_playAnimation("xinxin_1", true)
	else
		self:_playAnimation("niannian_1", true)
	end
end

function HeartGrowUpLetterView:_onClickSelf()
	self._btnClick.gameObject:SetActive(false)

	if self._type then
		self:_playAnimation("xinxin_2", false)
	else
		self:_playAnimation("niannian_2", false)
	end

	self._btnAccept.gameObject:SetActive(true)
end

return HeartGrowUpLetterView
