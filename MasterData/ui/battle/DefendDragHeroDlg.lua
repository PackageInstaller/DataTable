-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\DefendDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")
local DefendHeroScrollCell = Class("DefendHeroScrollCell", UIControls.HeroCardLoop)

function DefendHeroScrollCell:ctor()
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnGet(self.onDragGet)
	self.sensor:addEventDragOnClick(self.onDragClick)
end

function DefendHeroScrollCell:onDragGet(sender)
	local obj = DragPlane.addDragObj(true, self.hero, nil, BattleConst.CAMP_PLAYER)

	DragPlane.showBlock(obj, self.hero)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function DefendHeroScrollCell:onDragClick(sender)
	local tips = UIManager.getUI("battleDragHeroTips")

	tips:show(self)
	tips:correctPos(true)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function DefendHeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected
end

local strClassName = "DefendDragHeroDlg"
local DefendDragHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(DefendDragHeroDlg, DragHeroMixin)

function DefendDragHeroDlg:ctor()
	self:initUI()
end

function DefendDragHeroDlg:_initUI()
	self.listHeros:initHeroList(DefendHeroScrollCell, "System/Hero/GridHeroCard")
end

function DefendDragHeroDlg:onBtnCloseClick(sender)
	if self:isSameFormation() == false then
		local function save(...)
			self:onBattleConfirm()
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[157].notice, save, Slot(self.exit, self))
	else
		self:exit()
	end
end

function DefendDragHeroDlg:exit(...)
	DragPlane.stop()
	UIManager.getUI("battleDragHeroTips", false)
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():exitBattle()
end

function DefendDragHeroDlg:onOpenOver()
	DefendDragHeroDlg.super.onOpenOver(self)
	self:onListToggle(self.btnListOpen)
end

function DefendDragHeroDlg:isSameFormation()
	local formation = CurAvatar:getNowFormation(Const.FORMATION_ASYNC_DEFEND)
	local isSame = true
	local preCount = utils.getTableElemCount(formation)
	local nowCount = 0

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			nowCount = nowCount + 1

			if formation[obj.hero.gid] and formation[obj.hero.gid] == pos then
				-- block empty
			else
				isSame = false

				break
			end
		end
	end

	if isSame and nowCount == preCount then
		return true
	else
		return false
	end
end

function DefendDragHeroDlg:onBattleConfirm(sender)
	local result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			table.insert(result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	if #result < 1 then
		MsgManager.notice(ResClientNotice[148].notice)

		return
	end

	local function ConfirmFormation()
		RPC.asyncPVPFormation(result, self.nowSelectPetId)
		MsgManager.notice(Lang.get(30126))
		self:exit()
	end

	local hasCount = CurAvatar:getHeroCount()

	if hasCount >= 5 and #result < 5 then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[108].notice, ConfirmFormation)
	elseif hasCount < 5 and hasCount > #result then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[108].notice, ConfirmFormation)
	else
		ConfirmFormation()
	end
end

return DefendDragHeroDlg
