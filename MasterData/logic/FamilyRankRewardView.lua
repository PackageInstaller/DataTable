-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyRankRewardView.lua

module("logic.extensions.newfamily.view.FamilyRankRewardView", package.seeall)

local FamilyRankRewardView = class("FamilyRankRewardView", ViewComponent)

function FamilyRankRewardView:ctor()
	FamilyRankRewardView.super.ctor(self)

	self.cellArr = {}
	self.cellImg = {}
end

function FamilyRankRewardView:unbindEvents()
	FamilyRankRewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyRankRewardView:bindEvents()
	FamilyRankRewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.onClickClose, self)
end

function FamilyRankRewardView:onExit()
	FamilyRankRewardView.super.onExit(self)
	self:clearCell()
end

function FamilyRankRewardView:buildUI()
	FamilyRankRewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("Btn_Close")
	self._rewardCell = self:getGo("Pnl_Rank/Cell")
	self._rewardScroll = self:getGo("Pnl_Rank/Scrl")
	self._rewardContent = goutil.findChild(self._rewardScroll, "Viewport/Content")
end

function FamilyRankRewardView:onEnter()
	FamilyRankRewardView.super.onEnter(self)
	self:_init_rewardScroll()
end

function FamilyRankRewardView:onClickClose()
	self:close()
end

function FamilyRankRewardView:clearCell()
	for k, cell in pairs(self.cellImg) do
		uGuiUtil.clearImage(cell)
	end

	self.cellArr = {}
	self.cellImg = {}

	goutil.clearChildren(self._rewardContent)
end

function FamilyRankRewardView:_init_rewardScroll()
	self:clearCell()

	local activityId = FamilyCallOrderConfig.instance:getPlanIdInfo()

	if activityId then
		local data = FamilyCallOrderConfig.instance:getRewardCfgById(activityId.rankPrizePlanId or 1)
		local cellArrLenght
		local ranking = 1

		for i, k in ipairs(data) do
			local cell = goutil.cloneAndSetParent(self._rewardCell, self._rewardContent.transform, "cell_" .. i)
			local rankAreaTxt = goutil.findChildTextComponent(cell, "TxtArea")
			local curRanking = checknumber(k.top)

			rankAreaTxt.text = self:_getRank(ranking, curRanking)
			ranking = curRanking + 1

			goutil.setActive(cell, true)
			self:_init_rewardCell(k, cell)
			table.insert(self.cellArr, cell)
		end
	end
end

function FamilyRankRewardView:_init_rewardCell(data, cell)
	local medalImg = goutil.findChild(cell, "medalImg")
	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(data.medalId)
	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"
	local medalBtn = medalImg:GetComponent("Button")

	goutil.setActive(medalImg, true)
	uGuiUtil.setSpriteToImage(medalImg, uGuiUtil.SpriteType.BigBg, iconPath)
	table.insert(self.cellImg, medalImg)
	GameUtil.asBtn(medalBtn):RemoveClickListener()
	GameUtil.asBtn(medalBtn):AddClickListener(function()
		UIStateManager.instance:open(ViewName.FamilyInstructionView, data.medalId, medalImg)
	end)
end

function FamilyRankRewardView:_getRank(lastRank, curRank)
	if curRank <= lastRank then
		return string.format("第%s名", curRank)
	else
		return string.format("第%s~%s名", lastRank, curRank)
	end

	return string.format("第%s名", curRank)
end

return FamilyRankRewardView
