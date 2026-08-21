-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpMainDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local TopPVPGroupMatchPanel = require("UI/PVPMode/TopPVP/TopPVPGroupMatchPanel")
local TopPvpKnockoutPanel = require("UI/PVPMode/TopPVP/TopPvpKnockoutPanel")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local strClassName = "TopPvpMainDlg"
local TopPvpTabCell = Class("TopPvpTabCell", UIControls.Child)
local TopPvpState = {
	KNOCKOUT = 2,
	GROUPMATCH = 1
}

function TopPvpTabCell:ctor()
	self.btnChangeMode = UIControls.Button(self, "BtnNml")
	self.textMode = UIControls.Label(self, "BtnNml/Text")
	self.imgBg = UIControls.Image(self, "BtnNml/Bg")
	self.iconNew = UIControls.Image(self, "BtnNml/IconNew")
end

local descForMode = {
	Lang.get(75848),
	Lang.get(77978)
}

function TopPvpTabCell:setData(index)
	self.index = index

	self.textMode:setText(descForMode[index])

	if index == 1 then
		self.btnChangeMode:addEventClick(self.changetoGroupMatch)
	else
		self.btnChangeMode:addEventClick(self.changeToKnockout)
	end
end

function TopPvpTabCell:onChooseCell(index)
	self.btnChangeMode:setEnable(self.index ~= index)
end

function TopPvpTabCell:changetoGroupMatch(...)
	if self.mParent.mode == TopPvpState.GROUPMATCH then
		return
	end

	self.mParent.aniInfo:startAni("ChangeTopPVPMain", true)
	self.mParent:setMode(TopPvpState.GROUPMATCH)
end

function TopPvpTabCell:changeToKnockout(...)
	if self.mParent.mode == TopPvpState.KNOCKOUT then
		return
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local remainTime = actData:getGroupMatchRemainTime()

		if remainTime >= 0 then
			local hour = math.floor(remainTime / 3600)

			if hour < 10 then
				hour = "0" .. hour
			end

			local minute = math.floor(remainTime % 3600 / 60)

			if minute < 10 then
				minute = "0" .. minute
			end

			local second = remainTime % 60

			if second < 10 then
				second = "0" .. second
			end

			local nowState = actData:getTopPvpStage()

			if actData.stateMap[nowState] == "GroupFormation" then
				local remainTime = actData:getCurStageRemainTime()

				if remainTime and remainTime > 0 then
					local hour = math.floor(remainTime / 3600)

					if hour < 10 then
						hour = "0" .. hour
					end

					local minute = math.floor(remainTime % 3600 / 60)

					if minute < 10 then
						minute = "0" .. minute
					end

					local second = remainTime % 60

					if second < 10 then
						second = "0" .. second
					end

					local replaceContent = string.format("%s:%s:%s", hour, minute, second)
					local resData = ResBPPvpShow[13070021]

					if resData and resData.desc then
						local content = resData.desc
						local notice = string.gsub(content, "$1", replaceContent)

						MsgManager.notice(string.format(notice))
					end
				end
			else
				local resData = ResBPPvpShow[13070022]

				if resData and resData.desc then
					local content = resData.desc

					MsgManager.notice(string.format(content))
				end
			end

			return
		end
	end

	self.mParent.aniInfo:startAni("ChangeTopPVPMain", true)
	self.mParent:setMode(TopPvpState.KNOCKOUT)
end

local TopPvpMainDlg = Class(strClassName, UIControls.Window)

MixinClass(TopPvpMainDlg, ActivityPanelMixin)

function TopPvpMainDlg:initUI(...)
	self.aniInfo = UIControls.UIAni(self, "")
	self.tabs = {}
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self.onBtnTipClick)

	self.panelTab = UIControls.Panel(self, "TabTopPVPPanel")

	for index = 1, 2 do
		local newTab = TopPvpTabCell(self, "TabTopPVPPanel/ListTab", "System/TopPVP/BtnTabTopPVP")

		newTab:setVisible(true)
		newTab:setData(index)

		newTab.index = index

		table.insert(self.tabs, newTab)
	end

	self.panelGroupMatchPanel = TopPVPGroupMatchPanel(self, "GroupMatchPanel")
	self.panelKnockoutPanel = TopPvpKnockoutPanel(self, "EliminateMatchPanel")

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local nowState = actData:getTopPvpStage()

		if nowState then
			if nowState <= actData.reStateMap.GroupSettle then
				self:setMode(TopPvpState.GROUPMATCH)
			else
				self:setMode(TopPvpState.KNOCKOUT)
			end
		end

		if actData:checkFirstShowBetRoom() then
			local actId = CurAvatar:getTopPVPActivityOpId()
			local roomId = actData.betRoomId
			local areaId = actData:getBetKnockoutAreaId()

			if actId and areaId and roomId and areaId ~= 0 and roomId ~= 0 then
				RPC.bPPvpKnockoutRoomInfoGet(actId, areaId, roomId)
			end
		end
	end
end

function TopPvpMainDlg:setMode(mode)
	self.mode = mode

	self:refreshUI()
end

function TopPvpMainDlg:refreshUI()
	self.panelTab:setVisible(CurAvatar:checkTopPVPGroupMatchQualification())

	if self.mode == TopPvpState.GROUPMATCH then
		self.panelGroupMatchPanel:setVisible(true)
		self.panelKnockoutPanel:setVisible(false)

		local actObj = CurAvatar:getTopPVPActivity()
		local opId = actObj.opId
		local groupId = actObj.actData.groupId

		if groupId and groupId ~= 0 then
			RPC.bPPvpGroupEnterRoom(opId, groupId)
		end
	else
		self.panelGroupMatchPanel:setVisible(false)
		self.panelKnockoutPanel:setVisible(true)
		self.panelKnockoutPanel:refreshUI()
	end

	for k, v in pairs(self.tabs) do
		v:onChooseCell(self.mode)
	end

	self:refreshRedDot()
end

function TopPvpMainDlg:refreshState()
	if self.mode == TopPvpState.GROUPMATCH then
		self.panelGroupMatchPanel:setVisible(true)
		self.panelKnockoutPanel:setVisible(false)

		local actObj = CurAvatar:getTopPVPActivity()
		local opId = actObj.opId
		local groupId = actObj.actData.groupId

		if groupId and groupId ~= 0 then
			RPC.bPPvpGroupEnterRoom(opId, groupId)
		end
	else
		self.panelGroupMatchPanel:setVisible(false)
		self.panelKnockoutPanel:setVisible(true)
		self.panelKnockoutPanel:setIndex()
	end

	for k, v in pairs(self.tabs) do
		v:onChooseCell(self.mode)
	end

	self:refreshRedDot()
end

function TopPvpMainDlg:refreshRedDot()
	for k, v in pairs(self.tabs) do
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			if v.index == 1 then
				v.iconNew:setVisible(actData:checkGroupMatchTabRedDot())
			end

			if v.index == 2 then
				v.iconNew:setVisible(actData:checkKnockoutTabRedDot())
			end
		end
	end

	self.panelGroupMatchPanel:refreshRedDot()
	self.panelKnockoutPanel:refreshRedDot()
end

function TopPvpMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function TopPvpMainDlg:onBtnTipClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.GAME_PLAY_NOTICE_TOP_PVP)
end

function TopPvpMainDlg:destroy()
	self.panelKnockoutPanel.panelMatchTable:destroy()
	TopPvpMainDlg.super.destroy(self)
end

return TopPvpMainDlg
