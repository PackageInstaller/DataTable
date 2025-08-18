-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleMorePlayerDlg.lua

local ResColor = require("ClientData/ResColor")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local CircleBattleMorePlayerCell = Class("CircleBattleMorePlayerCell", UIControls.ScrollViewLoopCell)

function CircleBattleMorePlayerCell:ctor(...)
	self:initUI()
end

function CircleBattleMorePlayerCell:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtJob = UIControls.Label(self, "TextJob")
	self.txtAction = UIControls.Label(self, "TextAction")
	self.txtContribution = UIControls.Label(self, "TextContributionNum")
	self.imgContributionIcon = UIControls.Image(self, "TextContributionNum/Icon")
end

function CircleBattleMorePlayerCell:setData(uid)
	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(uid)

		if member then
			self.btnHead:setCommInfo(member.base, true, self)

			local name = utils.GetPlayerName(member.base.name)

			self.txtName:setText(name)

			if uid == CurAvatar.uid then
				self.txtName:setFontColor(ResColor.ORANGEBTN)
			else
				self.txtName:setFontColor(ResColor.WHITE)
			end

			local dutyName = CurAvatar:getDutyName(member.duty)

			self.txtJob:setText(dutyName)
			self.txtJob:setFontColor(CurAvatar:getDutyNameColor(member.duty))
			self.txtContribution:setText(member.battle_data.contribution)

			local path = BaseObject.getItemIconPath(ResClanBattleMisc[1].contribution_id)

			if path then
				self.imgContributionIcon:setImage(path[1], path[2])
			end

			if member.battle_data then
				if member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.NONE then
					self.txtAction:setText("")
				elseif member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
					self.txtAction:setText(Lang.get(40195))
					self.txtAction:setFontColor(ResColor.DARKBLUE)
				else
					self.txtAction:setText(Lang.get(40196))
					self.txtAction:setFontColor(ResColor.RED03)
				end
			end
		end
	end
end

local strClassName = "CircleBattleMorePlayerDlg"
local CircleBattleMorePlayerDlg = Class(strClassName, UIControls.Window)

function CircleBattleMorePlayerDlg:ctor(...)
	self:initUI()
end

function CircleBattleMorePlayerDlg:initUI(...)
	self.scrollView = UIControls.ScrollViewLoopV(self, "Bg/PlayerList", 0, self.onCellChanged)
end

function CircleBattleMorePlayerDlg:setData(uids)
	self.uids = uids

	if self.uids then
		self.scrollView:setTotalCount(#self.uids)
	end
end

function CircleBattleMorePlayerDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = CircleBattleMorePlayerCell(sender, "System/CircleBattle/MorePlayerCell", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.uids[newIdx])
end

return CircleBattleMorePlayerDlg
