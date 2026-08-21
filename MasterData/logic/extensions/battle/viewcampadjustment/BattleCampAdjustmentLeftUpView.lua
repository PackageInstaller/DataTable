-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentLeftUpView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentLeftUpView", package.seeall)

local BattleCampAdjustmentLeftUpView = class("BattleCampAdjustmentLeftUpView", ViewComponent)

function BattleCampAdjustmentLeftUpView:buildUI()
	self._goForbiddenCareerRoot = self:getGo("prewar_prepare_view_-6804780")

	if self._goForbiddenCareerRoot.transform.childCount > 0 then
		goutil.setActive(self._goForbiddenCareerRoot.transform:GetChild(0).gameObject, false)
	end

	self._btnRestrainHint = self:getBtn("prewar_prepare_view_1003807236")
	self._forbiddenItemCollection = ViewlibCollection:create(ViewlibResPath.BattleForbiddenCareerItem, 2)
end

function BattleCampAdjustmentLeftUpView:destroyUI()
	self._forbiddenItemCollection:clear()

	self._goForbiddenCareerRoot = nil
	self._forbiddenItemCollection = nil
	self._btnRestrainHint = nil
end

function BattleCampAdjustmentLeftUpView:bindEvents()
	self._btnRestrainHint:AddClickListener(self._onClickRestrainHint, self)
end

function BattleCampAdjustmentLeftUpView:unbindEvents()
	self._btnRestrainHint:RemoveClickListener()
end

function BattleCampAdjustmentLeftUpView:onEnter()
	self:_updateView()
end

function BattleCampAdjustmentLeftUpView:onExit()
	self._forbiddenItemCollection:clearAllInstance()
end

function BattleCampAdjustmentLeftUpView:_updateView()
	local forbiddenCampList = BattleCampAdjustmentModel.instance:getForbiddenCampList()

	for _, camp in pairs(forbiddenCampList) do
		local item = self._forbiddenItemCollection:createInstance(self._goForbiddenCareerRoot)

		item:setForbiddenCamp(camp)
	end

	local forbiddenCareerList = BattleCampAdjustmentModel.instance:getForbiddenCareerList()

	for _, career in pairs(forbiddenCareerList) do
		local item = self._forbiddenItemCollection:createInstance(self._goForbiddenCareerRoot)

		item:setForbiddenCareer(career)
	end
end

function BattleCampAdjustmentLeftUpView:_onClickRestrainHint()
	BattleAudioUtil.playSEByName("ui_battle_kezhiguanxi")
	ViewMgr.instance:open(ViewName.BattleExplainTips)
end

return BattleCampAdjustmentLeftUpView
