-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareConfirmView.lua

module("logic.extensions.sharetask.view.ShareConfirmView", package.seeall)

local ShareConfirmView = class("ShareConfirmView", ViewComponent)

function ShareConfirmView:ctor()
	ShareConfirmView.super.ctor(self)

	self.cellTextList = nil
end

function ShareConfirmView:buildUI()
	ShareConfirmView.super.buildUI(self)

	local popupGo = self:getGo("popupGo")

	self.popupCloseBtn = Framework.ButtonAdapter.GetFrom(popupGo, "popupCloseBtn")
	self.popupDesTxt = goutil.findChildTextComponent(popupGo, "popupDesTxt")
	self.freeCountTxt = goutil.findChildTextComponent(popupGo, "freeCountTxt")
	self.freeBtn = Framework.ButtonAdapter.GetFrom(popupGo, "freeBtn")
	self.helpCountTxt = goutil.findChildTextComponent(popupGo, "helpCountTxt")
	self.helpBtn = Framework.ButtonAdapter.GetFrom(popupGo, "helpBtn")
end

function ShareConfirmView:bindEvents()
	ShareConfirmView.super.bindEvents(self)
	self.popupCloseBtn:AddClickListener(self.close, self)
	self.freeBtn:AddClickListener(self.OnClickFreeBtn, self)
	self.helpBtn:AddClickListener(self.OnClickHelpBtn, self)
end

function ShareConfirmView:unbindEvents()
	ShareConfirmView.super.unbindEvents(self)
	self.popupCloseBtn:RemoveClickListener()
	self.freeBtn:RemoveClickListener()
	self.helpBtn:RemoveClickListener()
end

function ShareConfirmView:onExit()
	ShareConfirmView.super.onExit(self)
end

function ShareConfirmView:destroyUI()
	ShareConfirmView.super.destroyUI(self)
end

function ShareConfirmView:onEnter()
	ShareConfirmView.super.onEnter(self)

	if self._viewPresentor._openParam == nil then
		return
	end

	self.desStr = self._viewPresentor._openParam[1] or ""
	self.bossId = self._viewPresentor._openParam[2]
	self.bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()
	self.isMyBoss = true

	if self.bossInfo == nil or checknumber(self.bossInfo.bossId) ~= self.bossId then
		self.isMyBoss = false
		self.bossInfo = ShareTaskModel.instance:GetOtherShareBossInfo()
	end

	self.baseInfo = ShareTaskModel.instance:GetShareTaskBaseInfo()

	local lvCfg = ShareTaskConfig.instance:GetBossLevelCfg(self.baseInfo.bossMaxLv)

	if lvCfg then
		if not lvCfg.unlockMonsterLevel then
			local maxLv = 1
			local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.baseInfo.bossTypeId)

			if bossCfg then
				if not bossCfg.name then
					local bossName = "怪物"

					self.popupDesTxt.text = string.format("<color=#466687FF>您当前最高可助战怪物等级<color=#EB4642FF>%s</color>级\n是否确认帮助好友</color><color=#EB4642FF>%s</color><color=#466687FF>击退<color=#EB4642FF>Lv.%s%s</color>？</color>", maxLv, self.desStr, self.bossInfo.bossLevel, bossName)
					self.freeCountTxt.text = string.format("无偿次数：%s/%s", self.baseInfo.freeHelpHave - self.baseInfo.freeHelpUse, self.baseInfo.freeHelpHave)
					self.helpCountTxt.text = string.format("助战次数：%s/%s", self.baseInfo.helpHave - self.baseInfo.helpUse, self.baseInfo.helpHave)
				end
			end
		end
	end
end

function ShareConfirmView:OnClickFreeBtn()
	if self.leftFunc then
		self.leftFunc()

		return
	end

	if not self.bossInfo.isHaveBoss then
		FloatWordMgr.instance:show("分享任务已结束!")

		return
	end

	if self.bossInfo.isFleeBoss then
		FloatWordMgr.instance:show("该怪物已逃离!")

		return
	end

	if self.bossInfo.isKillBoss then
		FloatWordMgr.instance:show("该怪物已击杀!")

		return
	end

	local cfg = ShareTaskConfig.instance:GetBossLevelCfg(self.baseInfo.bossMaxLv)

	if cfg and cfg.unlockMonsterLevel < self.bossInfo.bossLevel then
		FloatWordMgr.instance:show("玩家怪物等级过高，不可挑战！")

		return
	end

	if self.bossInfo.isMaxChall then
		FloatWordMgr.instance:show("该怪物挑战已达上限!")

		return
	end

	if self.baseInfo.freeHelpUse >= self.baseInfo.freeHelpHave then
		FloatWordMgr.instance:show("您的无偿次数不足!")

		return
	end

	UIStateManager.instance:clear(true)

	if self.isMyBoss then
		ShareTaskModel.instance:SetBattleBossInfo({
			isMyBoss = true,
			isParam = true,
			bossId = self.bossId
		})
		UIStateManager.instance:push(ViewName.ShareMission)
	else
		ShareTaskModel.instance:SetBattleBossInfo({
			isMyBoss = false,
			isParam = true,
			bossId = self.bossId
		})

		local otherBossInfo = ShareTaskModel.instance:GetOtherShareBossInfo()

		if otherBossInfo == nil or checknumber(otherBossInfo.bossId) ~= self.bossId then
			ShareTaskController.instance:CSGetOtherBossInfoReq(self.bossId, ViewName.ShareMission)
		else
			UIStateManager.instance:push(ViewName.ShareMission)
		end
	end
end

function ShareConfirmView:OnClickHelpBtn()
	if self.rightFunc then
		self.rightFunc()

		return
	end

	if not self.bossInfo.isHaveBoss then
		FloatWordMgr.instance:show("分享任务已结束!")

		return
	end

	if self.bossInfo.isFleeBoss then
		FloatWordMgr.instance:show("该怪物已逃离!")

		return
	end

	if self.bossInfo.isKillBoss then
		FloatWordMgr.instance:show("该怪物已击杀!")

		return
	end

	local cfg = ShareTaskConfig.instance:GetBossLevelCfg(self.baseInfo.bossMaxLv)

	if cfg and cfg.unlockMonsterLevel < self.bossInfo.bossLevel then
		FloatWordMgr.instance:show("怪物等级过高，不可挑战！")

		return
	end

	if self.bossInfo.isMaxChall then
		FloatWordMgr.instance:show("该怪物挑战已达上限!")

		return
	end

	if self.baseInfo.helpUse >= self.baseInfo.helpHave then
		FloatWordMgr.instance:show("您的助战次数不足!")

		return
	end

	UIStateManager.instance:clear(true)

	if self.isMyBoss then
		ShareTaskModel.instance:SetBattleBossInfo({
			isMyBoss = true,
			isParam = true,
			bossId = self.bossId
		})
		UIStateManager.instance:push(ViewName.ShareMission)
	else
		if ShareTaskModel.instance:IsHelpFriendChallBossId(self.bossId) then
			FloatWordMgr.instance:show("此怪物您已助战过!")

			return
		end

		ShareTaskModel.instance:SetBattleBossInfo({
			isMyBoss = false,
			isParam = false,
			bossId = self.bossId
		})

		local otherBossInfo = ShareTaskModel.instance:GetOtherShareBossInfo()

		if otherBossInfo == nil or checknumber(otherBossInfo.bossId) ~= self.bossId then
			ShareTaskController.instance:CSGetOtherBossInfoReq(self.bossId, ViewName.ShareMission)
		else
			UIStateManager.instance:push(ViewName.ShareMission)
		end
	end
end

return ShareConfirmView
