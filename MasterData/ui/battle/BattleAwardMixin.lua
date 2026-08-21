-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleAwardMixin.lua

local Analytics = require("SDK/Analytics")
local BattleAwardMixin = {}

function BattleAwardMixin:ctorMixin(...)
	self:initCommonUI()
end

function BattleAwardMixin:initCommonUI(...)
	if UIControls.checkControlFunc(self, "BgPanel/BtnShare") then
		self.btnShare = UIControls.Button(self, "BgPanel/BtnShare")

		self.btnShare:addEventClick(self.onBtnShareClick)
	end

	if self.btnShare then
		local battleState = GameFsm.getCurState()

		self.battleType = battleState.battleType

		if battleState.battleResult then
			-- block empty
		end

		if CurAvatar:isChatLimit() then
			self.btnShare:setVisible(false)
		elseif battleState and (battleState.battleConfig.check_off == 1 or battleState.battleResult and battleState.battleResult[5] ~= 1) then
			self.btnShare:setVisible(false)
		elseif self.battleType == BattleConst.BATTLE_TYPE_BEGINNER or self.battleType == BattleConst.BATTLE_TYPE_MAZE or self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER or self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE or self.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
			self.btnShare:setVisible(false)
		end
	end

	if UIControls.checkControlFunc(self, "BgPanel/NoticePanel") then
		self.noticePanel = UIControls.Panel(self, "BgPanel/NoticePanel")

		self.noticePanel:setVisible(false)

		self.textDesc = UIControls.Label(self, "BgPanel/NoticePanel/TextDesc")
		self.btnMore = UIControls.Button(self, "BgPanel/NoticePanel/BtnMore")

		self.btnMore:addEventClick(self.onBtnMoreClick)
		self:checkShowNoticePanel()
	end
end

function BattleAwardMixin:checkShowNoticePanel()
	if self.noticePanel and #CurAvatar.pushAssistNoticeCache >= 1 then
		local pushData = CurAvatar.pushAssistNoticeCache[#CurAvatar.pushAssistNoticeCache]

		if pushData.condition == Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail then
			self.noticePanel:setVisible(true)
			self.textDesc:setText(pushData.push_text)
			table.remove(CurAvatar.pushAssistNoticeCache, #CurAvatar.pushAssistNoticeCache)
		end
	end
end

function BattleAwardMixin:onBtnMoreClick()
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 7
	end

	self:setVisible(false)
end

function BattleAwardMixin:showShareBtn(v)
	if self.btnShare then
		self.btnShare:setVisible(v)
	end
end

function BattleAwardMixin:onBtnShareClick(...)
	CurAvatar.cachedShareUIName = self.mUIName

	RPC.pVEShare(Const.CHANNEL_WORLD, "", nil)
	Analytics.onShare(nil, "")
end

function BattleAwardMixin:refreshUI(...)
	if self.btnShare then
		self.btnShare:setEnable(false)
	end
end

function BattleAwardMixin:checkExitBattle(needCheckAvg)
	local state = GameFsm.getCurState()

	if state then
		if state:isNeedMvpShow() then
			if state:isBattleOverShowEnd() then
				state:exitBattle(needCheckAvg)
			elseif self.coExit == nil then
				self.coExit = coroutine.start(function(...)
					for i = 1, 20 do
						coroutine.wait(0.1)

						if state:isBattleOverShowEnd() then
							break
						end
					end

					state:exitBattle(needCheckAvg)

					self.coExit = nil
				end)
			end
		else
			state:exitBattle(needCheckAvg)
		end
	end
end

function BattleAwardMixin:setAwardDataCommon(data)
	for _, it in ipairs(data.items or {}) do
		local grid = UIControls.getGridAwardContainer(self, data.path)

		grid.mDisableWays = true

		grid:setObj(it)
		self:checkCustomEquipGet(grid)
		grid:setVisible(true)

		if data.speType then
			if data.speConfigId then
				grid:setSpe(true, data.speType, data.speConfigId)
			else
				grid:setSpe(true, data.speType)
			end
		end
	end
end

function BattleAwardMixin:checkCustomEquipGet(grid)
	if grid.object.itemType == Const.ITEM_TYPE_EQUIP and grid.object:isDefineHeroEquip() then
		if not grid.customEquipEfx then
			local child = UIControls.Child(grid, "", "System/Common/Grid/GridAwardContainerEfxSpe", 0, 0, true)

			grid.customEquipEfx = child
		else
			grid.customEquipEfx:setVisible(true)
		end
	elseif grid.customEquipEfx then
		grid.customEquipEfx:setVisible(false)
	end
end

return BattleAwardMixin
