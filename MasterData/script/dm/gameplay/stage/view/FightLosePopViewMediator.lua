-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/FightLosePopViewMediator.lua

FightLosePopViewMediator = class("FightLosePopViewMediator", DmPopupViewMediator, _M)

FightLosePopViewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
FightLosePopViewMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
FightLosePopViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	mTouchLayout = "onTouchLayout",
	["content.mRecruitBtn"] = "onClickRecruit",
	["content.mSkillBtn"] = "onClickSkill",
	["content.mEquipBtn"] = "onClickEquip"
}

function FightLosePopViewMediator:initialize()
	super.initialize(self)
end

function FightLosePopViewMediator:dispose()
	super.dispose(self)
end

function FightLosePopViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function FightLosePopViewMediator:onRemove()
	super.onRemove(self)
end

function FightLosePopViewMediator:enterWithData(data)
	self._data = data

	self:initWidget()
	self:refreshView()
end

function FightLosePopViewMediator:initWidget()
	self._bg = self:getView():getChildByName("content")
	self._title = self:getView():getChildByFullName("content.title")

	local lineGradiantVec1 = {
		{
			ratio = 0.1,
			color = cc.c4b(230, 230, 250, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(160, 160, 200, 255)
		},
		{
			ratio = 0.9,
			color = cc.c4b(160, 150, 180, 255)
		}
	}

	self._title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	self._level = self:getView():getChildByFullName("content.mLevelNum")
	self._exp = self:getView():getChildByFullName("content.mExpNum")
	self._crystal = self:getView():getChildByFullName("content.mCrystalNum")
	self._gold = self:getView():getChildByFullName("content.mGoldNum")
	self._expBar = self:getView():getChildByFullName("content.mExpBar")
end

function FightLosePopViewMediator:refreshView()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local percent = player:getExp() / config.PlayerExp * 100

	self._expBar:setPercent(percent)
	self._exp:setString("+0")
	self._level:setString(player:getLevel())

	local bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()
	local text, huge = CurrencySystem:formatCurrency(bagSystem:getItemCount(CurrencyIdKind.kGold))

	self._gold:setString("0")

	local text = bagSystem:getItemCount(CurrencyIdKind.kCrystal)

	self._crystal:setString("0")
end

function FightLosePopViewMediator:leaveWithData()
	if self._done then
		return
	end

	self._done = true

	self:toStageView()
end

function FightLosePopViewMediator:onTouchLayout(sender, eventType)
	if eventType ~= ccui.TouchEventType.ended then
		return
	end

	if self._done then
		return
	end

	self._done = true

	self:toStageView()
end

function FightLosePopViewMediator:onClickSkill()
	local unlock, tips = self._systemKeeper:isUnlock("Master_Skill")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local view = "MasterMainView"
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId
	data.id = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getMasterId()
	data.showType = 2

	BattleLoader:popBattleView(self, data, view, data)
end

function FightLosePopViewMediator:onClickRecruit()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Item_PleaseWait")
	}))

	do return end

	local unlock, tips = self._systemKeeper:isUnlock("Draw_Equip")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local view = "RecruitEquipView"
	local data = {}

	data.pointId = self._data.pointId
	data.chapterId = self._data.mapId

	BattleLoader:popBattleView(self, data, view)
end

function FightLosePopViewMediator:onClickEquip()
	return
end

function FightLosePopViewMediator:toStageView()
	if self._data.isMaze and self._data.mazeState == 1 then
		local dispatchdata = self._data

		BattleLoader:popBattleView(self, nil)

		local view = dispatchdata.mazedispatcher:getInjector():getInstance("MazeEventMainView")

		dispatchdata.mazedispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
		print("-------迷宫结束-----------")
	elseif self._data.isMaze then
		BattleLoader:popBattleView(self, {
			viewName = "MazeMainView"
		})
	else
		self._stageSystem:requestStageProgress(function()
			local data = {}

			data.pointId = self._data.pointId
			data.chapterId = self._data.mapId

			BattleLoader:popBattleView(self, data)
		end, false)
	end
end
