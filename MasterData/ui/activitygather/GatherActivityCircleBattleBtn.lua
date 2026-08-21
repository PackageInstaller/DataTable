-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\ActivityGather\\GatherActivityCircleBattleBtn.lua

local GatherBaseChild = require("UI/ActivityGather/GatherBaseChild")
local GatherActivityCircleBattleBtn = Class("GatherActivityCircleBattleBtn", GatherBaseChild)

function GatherActivityCircleBattleBtn:setData(btnConfig, state)
	if not CurAvatar:isInCircle() then
		state = Const.SHOW_STATE_LOCK
	end

	GatherActivityCircleBattleBtn.super.setData(self, btnConfig, state)
end

function GatherActivityCircleBattleBtn:setDataByDefineConfig()
	local btnConfig = {}

	btnConfig.btn_args = {}
	btnConfig.btn_args[1] = Const.CIRCLE_BATTLE_ACTIVITY_ID

	local actId = btnConfig.btn_args[1]
	local showState = Const.SHOW_STATE_LOCK

	if CurAvatar:isActivityValid(actId) then
		showState = Const.SHOW_STATE_OPEN
	end

	self:setData(btnConfig, showState)
	self.imgIcon:setObjGray(false)
	self.panelLock:setVisible(false)
	self.panelPredict:setVisible(false)

	if self.textTitls then
		self.textTitls:setVisible(true)
	end

	self:_showOpenState(showState ~= Const.SHOW_STATE_OPEN)
end

function GatherActivityCircleBattleBtn:_showOpenState(dontShowRedHint)
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self.rdNew:clearHint()

	if self.actObj and self.actObj.actData then
		if self.panelWillEnd then
			self.panelWillEnd:setVisible(false)
		end

		local leftTime = self.actObj.actData:getLeftTimeToFreeze()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, nil, Lang.get(48654), Slot(self.onFreeze, self), nil)

			if leftTime < 64800 then
				if self.panelWillEnd then
					self.panelWillEnd:setVisible(true)
				end

				self.textTime:setFontColor(ResColor.RED)
				self.aniTime:startAniLoop("LoopBtnWorldBoss")
			else
				if self.panelWillEnd then
					self.panelWillEnd:setVisible(false)
				end

				self.textTime:setFontColor(ResColor.WHITE)
				self.aniTime:stopAni("LoopBtnWorldBoss")
			end
		else
			self.textTime:setText(Lang.get(30121))
			self.textTime:setFontColor(ResColor.WHITE)
		end

		if not dontShowRedHint then
			if self.actObj:isNewOpened() then
				self.rdNewOpen:setVisible(true)
			elseif self.actObj.redDotId then
				self.rdNewOpen:setVisible(false)
				self.rdNew:addHint({
					self.actObj.redDotId
				})
			end
		end
	end
end

function GatherActivityCircleBattleBtn:onSensorClick()
	if not VersionUtils.hasAbilityCircleBattle() then
		if CurAvatar:isActivityOpen(414) then
			UIManager.showConfirmWithId(1054, function(...)
				CurAvatar:jumpToShowActivity(414)
			end)
		else
			MsgManager.clientNotice(597)
		end

		return
	end

	if not CurAvatar:isInCircle() then
		MsgManager.notice(Lang.get(30050))

		return
	end

	if self:checkIsLock() then
		return
	end

	if self.actId and self.actObj then
		local isValid, unlockDesc = self.actObj:isValid()

		if isValid then
			if (CurAvatar.nextEnterCircleBattleTime or 0) > ClientUtils.getServerTime() then
				MsgManager.clientNotice(599)
			else
				local heros = CurAvatar:getCircleBattleHeroList()

				if #heros > 0 then
					local hero = heros[1]
					local data = {
						resid = hero.id,
						skin = hero.skin,
						base = hero.base
					}

					CurAvatar:tryCallCircleBattleRpc("clanBattleEnter", hero.gid, data)
				end
			end

			if self.actObj:isNewOpened() then
				RPC.opActSetFocus(self.actObj.opId, 1)
				self.rdNewOpen:setVisible(false)
			end
		else
			MsgManager.notice(unlockDesc)
		end
	end
end

return GatherActivityCircleBattleBtn
