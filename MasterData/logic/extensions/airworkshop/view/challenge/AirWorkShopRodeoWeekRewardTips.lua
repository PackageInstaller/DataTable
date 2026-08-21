-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoWeekRewardTips.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoWeekRewardTips", package.seeall)

local M = class("AirWorkShopRodeoWeekRewardTips", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("air_workshop_week_reward_tips_1695943602")
	self._rectTrReward = self:getUIComponent("air_workshop_week_reward_tips_2111664586", UIComponentType.RectTransform)
	self._goLv1Bg_old = self:getGo("air_workshop_week_reward_tips_-1384499732")
	self._imgLv1_old = self:getImage("air_workshop_week_reward_tips_1948805602")
	self._imgLv2_old = self:getImage("air_workshop_week_reward_tips_-1533206328")
	self._imgLv2Bg_old = self:getImage("air_workshop_week_reward_tips_263587414")
	self._goLv1Bg_cur = self:getGo("air_workshop_week_reward_tips_-1393803244")
	self._imgLv1_cur = self:getImage("air_workshop_week_reward_tips_-320167359")
	self._imgLv2_cur = self:getImage("air_workshop_week_reward_tips_983668761")
	self._imgLv2Bg_cur = self:getImage("air_workshop_week_reward_tips_-2144251097")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)

	local info = self:getFirstParam()

	self._oldLv = info.oldLv
	self._curLv = info.curLv

	local offsetLv = self._curLv - self._oldLv

	printWarn(string.format("oldLv[%s] curLv[%s] offsetLv[%s]", self._oldLv, self._curLv, offsetLv))
	self:refreshView()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	AirWorkShopChallengeModel.instance:tryPopWeeklyRewardItemConvertView()
end

function M:_onClickClose()
	self:close()
end

function M:refreshView()
	AirWorkShopUtil.rodeoLvImgChange(self._oldLv, self._imgLv1_old, self._imgLv2_old, self._goLv1Bg_old, self._imgLv2Bg_old)
	AirWorkShopUtil.rodeoLvImgChange(self._curLv, self._imgLv1_cur, self._imgLv2_cur, self._goLv1Bg_cur, self._imgLv2Bg_cur)

	local rewardLst = AirWorkShopChallengeModel.instance:getWeeklyRewardItem()
	local len = #rewardLst

	while len > self._rectTrReward.childCount do
		goutil.cloneAndSetParent(self._rectTrReward:GetChild(0).gameObject, self._rectTrReward)
	end

	local rewardCellLst = {}

	for i = 0, self._rectTrReward.childCount - 1 do
		local itemCell = Astral.SimpleLuaComponentContainer.Add(self._rectTrReward:GetChild(i).gameObject, ItemCell)

		itemCell:setShowSelectedEffect(false)
		table.insert(rewardCellLst, itemCell)
	end

	for i = 1, #rewardCellLst do
		goutil.setActive(rewardCellLst[i]:getGo(), i <= len)

		if i <= len then
			rewardCellLst[i]:updateData(rewardLst[i])
		end
	end
end

function M:showTopToast(offsetLv)
	settimer(0.2, function()
		if offsetLv > 0 then
			ToolTipsMgr.showCharacterTopToast(lang("tip_air_rodeo_week_settle_toast_up"), CommEnum.CharacterTopToastIcon.Succ, 1)
		elseif offsetLv < 0 then
			ToolTipsMgr.showCharacterTopToast(lang("tip_air_rodeo_week_settle_toast_down"), CommEnum.CharacterTopToastIcon.Succ, 1)
		else
			ToolTipsMgr.showCharacterTopToast(lang("tip_air_rodeo_week_settle_toast_keep"), CommEnum.CharacterTopToastIcon.Succ, 1)
		end
	end, self, false)
end

return M
