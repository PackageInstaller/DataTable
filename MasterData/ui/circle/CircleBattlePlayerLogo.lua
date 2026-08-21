-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattlePlayerLogo.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local CircleBattleGetCell = Class("CircleBattleGetCell", UIControls.Child)

function CircleBattleGetCell:ctor(...)
	self:initUI()

	self.logoType = Const.CIRCLE_LOGO_TYPE.PLAYER
end

function CircleBattleGetCell:initUI(...)
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtContent = UIControls.Label(self, "Text")
end

function CircleBattleGetCell:setData(info)
	local type = info.type

	self.type = type

	local param = info.param

	self.info = info

	local data = UIConst.CIRCLE_BATTLE_HEAD_MSG[type]

	if data then
		self.imgIcon:setImage(data.iconPath, data.iconName)

		local content = ""

		if type == Const.CIRCLE_BATTLE_MSG_TYPE.MOVE_POINT then
			content = data.name .. " -" .. info.param
		else
			content = data.name .. " +" .. info.param
		end

		self.txtContent:setText(content)
	end

	self:setVisible(true)

	self.coShow = coroutine.start(function(...)
		self:flyToEnd()
		coroutine.wait(0.5)

		if self.mWindow.id ~= nil then
			self:setVisible(false)
			self.mWindow:onShowOver(self.info)
		end
	end)
end

function CircleBattleGetCell:flyToEnd(...)
	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if not ui then
			return
		end

		if self.type == Const.CIRCLE_BATTLE_MSG_TYPE.SCORE then
			FlyIconUtils.setFlyUItoUI(self.imgIcon, ui:getScoreUI())
		elseif self.type == Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_SEARCH or self.type == Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_BATTLE then
			FlyIconUtils.setFlyUItoUI(self.imgIcon, ui:getProficientUI())
		end
	end
end

function CircleBattleGetCell:destroy(...)
	CircleBattleGetCell.super.destroy(self)

	if self.coShow then
		coroutine.stop(self.coShow)
	end

	self.coShow = nil
end

local UIUtils = require("Framework.UI.UIUtils")
local CircleBattlePlayerLogo = Class("CircleBattlePlayerLogo", UIControls.Logo)

function CircleBattlePlayerLogo:ctor(...)
	self:initUI()

	self._playMyAni = true
end

function CircleBattlePlayerLogo:initUI(...)
	self.aniSelf = UIControls.UIAni(self, "SelfPanel")
	self.panelBattle = UIControls.Panel(self, "BattlePanel")
	self.imgSelf = UIControls.Image(self, "BattlePanel/IconSelf")
	self.msgCell = CircleBattleGetCell(self, "GetPanel", "System/CircleBattle/CircleBattleGetCell", 0, 0)
	self.msgs = {}
end

function CircleBattlePlayerLogo:setTarget(player)
	self.player = player

	if player then
		UIUtils.SetLogoTarget(self.id, player:getLogoTran())
		self.aniSelf:setVisible(player.data.uid == CurAvatar.uid)
	end
end

function CircleBattlePlayerLogo:refreshState(state)
	if not self.player then
		self.panelBattle:setVisible(false)
		self.aniSelf:setVisible(false)

		return
	end

	if state ~= Const.CIRCLE_PLAYER_STATE.NONE and state ~= Const.CIRCLE_PLAYER_STATE.SEARCH then
		self.panelBattle:setVisible(true)
		self.aniSelf:setVisible(false)

		if self.player and self.player.data.uid == CurAvatar.uid then
			self.imgSelf:setVisible(true)
		else
			self.imgSelf:setVisible(false)
		end
	else
		self.panelBattle:setVisible(false)
		self.aniSelf:setVisible(self.player.data.uid == CurAvatar.uid)

		if state == Const.CIRCLE_PLAYER_STATE.NONE and self.player.data.uid ~= CurAvatar.uid then
			self.player:returnLogo()
		end
	end
end

function CircleBattlePlayerLogo:onMsgNotify(type, param)
	table.insert(self.msgs, {
		showing = false,
		type = type,
		param = param
	})
	self:checkShowMsg()
end

function CircleBattlePlayerLogo:onShowOver(info)
	info.showing = false

	for i = #self.msgs, 1, -1 do
		if self.msgs[i] == info then
			table.remove(self.msgs, i)
		end
	end

	self:checkShowMsg()
end

function CircleBattlePlayerLogo:checkShowMsg()
	if #self.msgs > 0 then
		local info = self.msgs[1]

		if info.showing then
			-- block empty
		else
			info.showing = true

			self.msgCell:setData(info)
		end
	end
end

function CircleBattlePlayerLogo:onReturn(...)
	return
end

function CircleBattlePlayerLogo:setHide(v)
	if v or not self.player then
		CircleBattlePlayerLogo.super.setHide(self, true)

		return
	end

	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		CircleBattlePlayerLogo.super.setHide(self, true)

		return
	end

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and not state:isInHalfNear() then
		CircleBattlePlayerLogo.super.setHide(self, true)

		return
	end

	if not v and self.player then
		v = not self.player:getVisible()
	end

	CircleBattlePlayerLogo.super.setHide(self, v)
	self:showMyAni()
end

function CircleBattlePlayerLogo:showMyAni(force)
	if Const.CIRCLE_BATTLE_DEBUG_MODE then
		return
	end

	if force then
		self._playMyAni = true
	end

	if self.player and self.player.data.uid == CurAvatar.uid and self._playMyAni then
		self.aniSelf:startAni("CircleBattleLogoSelf")

		self._playMyAni = nil
	end
end

return CircleBattlePlayerLogo
