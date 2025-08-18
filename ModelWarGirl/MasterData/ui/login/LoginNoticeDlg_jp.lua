-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginNoticeDlg_jp.lua

local UserData = require("Helper/UserData")
local UIControls = require("UI/UIControls")
local noticeCell = Class("noticeCell", UIControls.ScrollViewLoopCell)

function noticeCell:ctor()
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onTabClick)

	self.labelTitle = UIControls.Label(self, "Text")
	self.iconNew = UIControls.Panel(self, "IconNew")
end

function noticeCell:setData(data)
	self.cellData = data

	self.labelTitle:setText(data.title or "")
	self.iconNew:setVisible(not data.hasRead)
end

function noticeCell:onTabClick()
	if self.noticeCellClick then
		self:noticeCellClick()
	end
end

function noticeCell:setEnable(enable)
	self.sensor:setEnable(enable)
end

function noticeCell:setVisible(enable)
	self.sensor:setVisible(enable)
end

local LoginNoticeDlg_jp = Class("LoginNoticeDlg_jp", UIControls.Window)
local LoginNoticeKeyJP = "login_notice_id_jp"
local NOTICE_TYPE = {
	UPDATE = "update",
	ACTIVITY = "activity",
	BUG = "bug"
}
local MAX_CONTENT = 4

function LoginNoticeDlg_jp:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onDlgClose)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnEnter")

	self.btnConfirm:addEventClick(self.onDlgClose)

	self.btnTab1_activity = UIControls.Button(self, "BgPanel/TabPanel/Btn1", "Text")

	self.btnTab1_activity:addEventClick(Functor(self.refreshSubNoticeCell, self, NOTICE_TYPE.ACTIVITY, true))
	self.btnTab1_activity:setText(Lang.get(40578))

	self.btnTab1_iconNew = UIControls.Panel(self, "BgPanel/TabPanel/Btn1/IconNew")
	self.btnTab2_update = UIControls.Button(self, "BgPanel/TabPanel/Btn2", "Text")

	self.btnTab2_update:addEventClick(Functor(self.refreshSubNoticeCell, self, NOTICE_TYPE.UPDATE, true))
	self.btnTab2_update:setText(Lang.get(40579))

	self.btnTab2_iconNew = UIControls.Panel(self, "BgPanel/TabPanel/Btn2/IconNew")
	self.btnTab3_bug = UIControls.Button(self, "BgPanel/TabPanel/Btn3", "Text")

	self.btnTab3_bug:addEventClick(Functor(self.refreshSubNoticeCell, self, NOTICE_TYPE.BUG, true))
	self.btnTab3_bug:setText(Lang.get(40580))

	self.btnTab3_iconNew = UIControls.Panel(self, "BgPanel/TabPanel/Btn3/IconNew")
	self.noticesPanel = UIControls.ScrollViewLoopV(self, "BgPanel/SubTabList", 0, self.onCellChanged)

	if UIControls.checkControlFunc(self, "BgPanel/BtnGo") then
		self.btnGo = UIControls.Button(self, "BgPanel/BtnGo")

		self.btnGo:addEventClick(self.onGoClick)
		self.btnGo:setVisible(false)
	end

	self.subBtns = {}
	self.subBtns[NOTICE_TYPE.ACTIVITY] = self.btnTab1_activity
	self.subBtns[NOTICE_TYPE.UPDATE] = self.btnTab2_update
	self.subBtns[NOTICE_TYPE.BUG] = self.btnTab3_bug
	self.subIconNew = {}
	self.subIconNew[NOTICE_TYPE.ACTIVITY] = self.btnTab1_iconNew
	self.subIconNew[NOTICE_TYPE.UPDATE] = self.btnTab2_iconNew
	self.subIconNew[NOTICE_TYPE.BUG] = self.btnTab3_iconNew
	self.allNotice = {}
	self.allNotice[NOTICE_TYPE.ACTIVITY] = {}
	self.allNotice[NOTICE_TYPE.UPDATE] = {}
	self.allNotice[NOTICE_TYPE.BUG] = {}

	local label

	self.labelContents = {}

	for i = 1, MAX_CONTENT do
		label = UIControls.Label(self, "BgPanel/Scroll ViewContent/Viewport/Content/TextContent" .. i)
		self.labelContents[i] = label
	end

	self.noticeCells = {}
	self.tryList = {}
end

function LoginNoticeDlg_jp:show()
	local state = GameFsm.getState(Const.STATE_LOGIN)

	self.mNoticeInfo = state.mNoticeInfo
	self.hasReadConfig = state.hasReadConfig

	if self.mNoticeInfo == nil then
		state:checkLoginNotice()

		return
	end

	self:handleMessage()
	self:refreshSubTab()
	self:setVisible(true)
	self:refreshSubNoticeCell(NOTICE_TYPE.ACTIVITY, false)
end

function LoginNoticeDlg_jp:checkAutoOpen(mNoticeInfo, hasReadConfig)
	self.mNoticeInfo = mNoticeInfo
	self.hasReadConfig = hasReadConfig

	if self.mNoticeInfo then
		for _, v in ipairs(self.mNoticeInfo) do
			if not self.hasReadConfig[tostring(v.id)] then
				self:show()

				return
			end
		end
	end
end

function LoginNoticeDlg_jp:handleMessage()
	local minID

	for i, value in ipairs(self.mNoticeInfo) do
		if self.hasReadConfig[tostring(value.id)] ~= nil then
			value.hasRead = true
		end

		if minID then
			if minID > value.id then
				minID = value.id
			end
		else
			minID = value.id
		end

		if tonumber(value.label) == 1 then
			table.insert(self.allNotice[NOTICE_TYPE.ACTIVITY], value)
		elseif tonumber(value.label) == 2 then
			table.insert(self.allNotice[NOTICE_TYPE.UPDATE], value)
		elseif tonumber(value.label) == 3 then
			table.insert(self.allNotice[NOTICE_TYPE.BUG], value)
		end
	end

	self:sortNotice(self.allNotice[NOTICE_TYPE.ACTIVITY])
	self:sortNotice(self.allNotice[NOTICE_TYPE.UPDATE])
	self:sortNotice(self.allNotice[NOTICE_TYPE.BUG])

	if self.hasReadConfig and minID then
		for k, value in pairs(self.hasReadConfig) do
			if minID > tonumber(value) then
				self.hasReadConfig[tostring(k)] = nil
			end
		end
	end
end

function LoginNoticeDlg_jp:refreshSubTab(refreshType)
	if refreshType then
		for _, v in pairs(self.allNotice[refreshType]) do
			if not self.hasReadConfig[tostring(v.id)] then
				self.subIconNew[refreshType]:setVisible(true)

				return
			end
		end

		self.subIconNew[refreshType]:setVisible(false)
	else
		local data

		for k, _ in pairs(NOTICE_TYPE) do
			data = self.allNotice[NOTICE_TYPE[k]]

			for _, v in ipairs(data) do
				if not v.hasRead then
					self.subIconNew[NOTICE_TYPE[k]]:setVisible(true)

					self.showMessagesType = NOTICE_TYPE[k]

					break
				end
			end
		end
	end
end

function LoginNoticeDlg_jp:onCellChanged(sender, targetCell, newIdx)
	local showData = self.showData

	if showData then
		if targetCell == nil then
			targetCell = noticeCell(sender, "System/Login/AnnounceSubTab_ja", newIdx, 0, 0)
		end

		if self.hasReadConfig[tostring(showData[newIdx].id)] then
			showData[newIdx].hasRead = true
		end

		targetCell:setData(showData[newIdx])

		targetCell.noticeCellClick = Slot(self.noticeCellClick, self)

		if newIdx == 1 then
			targetCell:noticeCellClick()
		end
	end
end

function LoginNoticeDlg_jp:refreshSubNoticeCell(type, forceRefresh)
	if #self.allNotice[type] == 0 then
		MsgManager.notice(Lang.get(45337))

		return
	end

	self:refreshContent()

	self.showType = type

	if forceRefresh then
		self.showData = self.allNotice[self.showType]
	else
		self.showType = self.showMessagesType or self.showType
		self.showData = self.allNotice[self.showType]
	end

	self.curSubTab = self.showType

	if self.curSelectTab then
		self.curSelectTab:setEnable(true)
	end

	self.curSelectTab = self.subBtns[self.showType]

	self.curSelectTab:setEnable(false)
	self.noticesPanel:setTotalCount(#self.showData)
end

function LoginNoticeDlg_jp:noticeCellClick(sender)
	local id = sender.cellData.id

	if not id then
		return
	end

	if self.curSelectBtn then
		self.curSelectBtn:setEnable(true)
	end

	self.curSelectBtn = sender

	self.curSelectBtn:setEnable(false)
	self.curSelectBtn.iconNew:setVisible(false)

	local content

	for _, value in ipairs(self.showData) do
		if value.id == id then
			content = value.content

			break
		end
	end

	self:refreshContent(content)

	self.hasReadConfig[tostring(id)] = id

	self:refreshSubTab(self.curSubTab)
end

function LoginNoticeDlg_jp:refreshContent(content)
	self.labelContents[1]:setText(content or "")
end

function LoginNoticeDlg_jp:sortNotice(data)
	table.sort(data, function(a, b)
		return a.priority > b.priority
	end)
end

function LoginNoticeDlg_jp:saveData()
	UserData.saveCommonData(LoginNoticeKeyJP, ClientUtils.table2String(self.hasReadConfig))
end

function LoginNoticeDlg_jp:onDlgClose()
	self:saveData()

	if self.mNoticeInfo then
		for _, v in ipairs(self.mNoticeInfo) do
			if not self.hasReadConfig[tostring(v.id)] then
				RedDotManager.setKeyState(UIConst.RD_HINT_NOTICE, true)

				break
			end

			RedDotManager.setKeyState(UIConst.RD_HINT_NOTICE, false)
		end
	end

	self:setVisible(false)
end

function LoginNoticeDlg_jp:onGoClick()
	local WebView = require("SDK/Plugin/WebView")

	WebView.unityOpenUrl("https://bytedance.sg.larkoffice.com/share/base/form/shrlgIswCy6oufsFDvetpOQWywg")
end

return LoginNoticeDlg_jp
