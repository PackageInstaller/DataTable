-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleGridLogo.lua

local UIUtils = require("Framework.UI.UIUtils")
local ResColor = require("ClientData/ResColor")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local COLOR_CONFIG = {
	[Const.CIRCLE_PLAYER_STATE.NONE] = ResColor.WHITE,
	[Const.CIRCLE_PLAYER_STATE.SEARCH] = ResColor.BLUE,
	[Const.CIRCLE_PLAYER_STATE.FORMATION] = ResColor.RED,
	[Const.CIRCLE_PLAYER_STATE.BATTLE] = ResColor.RED
}
local CircleBattleGridLogo = Class("CircleBattleGridLogo", UIControls.Logo)

function CircleBattleGridLogo:ctor(...)
	self:initUI()

	self.logoType = Const.CIRCLE_LOGO_TYPE.GRID
	self.uponPlayerNum = 0
end

function CircleBattleGridLogo:initUI(...)
	self.panelMore = UIControls.Panel(self, "MorePanel")
	self.panelPlayerMore = UIControls.Panel(self, "MorePanel/PlayerMore")
	self.moreUI = {}

	for i = 1, 3 do
		local path = "MorePanel/Player" .. i
		local t = {}

		t.panel = UIControls.Panel(self, path)
		t.imgIcon = UIControls.Image(self, path .. "/Mask/IconPlayer")
		t.imgFront = UIControls.Image(self, path .. "/ImgFront")

		table.insert(self.moreUI, t)
	end
end

function CircleBattleGridLogo:setTarget(grid)
	self.grid = grid

	if grid then
		UIUtils.SetLogoTarget(self.id, grid:getLogoTran())
	end
end

function CircleBattleGridLogo:onPlayerNumChange()
	if not self.grid then
		return
	end

	local data = self.grid:getUponUids()

	self.uponPlayerNum = #data

	if #data <= 1 then
		self.panelMore:setVisible(false)
	else
		self.panelMore:setVisible(true)

		if #data > 4 then
			self.panelPlayerMore:setVisible(true)

			for i, info in ipairs(self.moreUI) do
				if i <= 2 then
					info.panel:setVisible(true)
					self:refreshPlayerUI(info, data[i + 1])
				else
					info.panel:setVisible(false)
				end
			end
		else
			self.panelPlayerMore:setVisible(false)

			for i, info in ipairs(self.moreUI) do
				if data[i + 1] then
					info.panel:setVisible(true)
					self:refreshPlayerUI(info, data[i + 1])
				else
					info.panel:setVisible(false)
				end
			end
		end
	end

	self:_checkHide()
end

function CircleBattleGridLogo:refreshPlayerUI(uiData, uidData)
	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(uidData.uid)

		if member then
			HeadHelper.setHeadIcon(uiData.imgIcon, member.base.head, uidData.uid)

			local color = COLOR_CONFIG[member.battle_data.optype]

			uiData.imgFront:setColorByRGBA(color.r, color.g, color.b, color.a)
		end
	end
end

function CircleBattleGridLogo:_checkHide(...)
	if self.uponPlayerNum <= 0 and not self.occuping and self.grid then
		self.grid:returnLogo()
	end
end

function CircleBattleGridLogo:onReturn(...)
	return
end

function CircleBattleGridLogo:setHide(v)
	if v or not self.grid then
		CircleBattleGridLogo.super.setHide(self, true)

		return
	end

	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		CircleBattleGridLogo.super.setHide(self, true)

		return
	end

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and not state:isInHalfNear() then
		CircleBattleGridLogo.super.setHide(self, true)

		return
	end

	CircleBattleGridLogo.super.setHide(self, v)
end

function CircleBattleGridLogo:destroy(...)
	CircleBattleGridLogo.super.destroy(self)

	if self.barTimer then
		self.barTimer:Stop()
	end

	self.barTimer = nil

	if self.efxTimer then
		self.efxTimer:Stop()
	end

	self.efxTimer = nil
end

return CircleBattleGridLogo
