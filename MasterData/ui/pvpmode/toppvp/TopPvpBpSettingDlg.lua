-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpSettingDlg.lua

local TopPvpBpHeroIconCell = require("UI/PVPMode/TopPVP/TopPvpBpHeroIconCell")
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local ResBPPvpHeroAutoBanRule = require("ClientData/ResBPPvpHeroAutoBanRule")
local TopPvpBpSettingBanCell = Class("TopPvpBpSettingBanCell", UIControls.Child)

function TopPvpBpSettingBanCell:ctor()
	self.icon = UIControls.Image(self, "ContentPanel/Icon")
end

function TopPvpBpSettingBanCell:setData(index)
	if index then
		self.icon:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas17", "BgProfessional0" .. index)
	end
end

local strClassName = "TopPvpBpSettingDlg"
local TopPvpBpSettingDlg = Class(strClassName, UIControls.Window)

function TopPvpBpSettingDlg:ctor(...)
	self:initUI()
end

function TopPvpBpSettingDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnPick = UIControls.Button(self, "BgPanel/FuncPanel/BtnPick")

	self.btnPick:addEventClick(self.onBtnPickClick)

	self.btnBan = UIControls.Button(self, "BgPanel/FuncPanel/BtnBan")

	self.btnBan:addEventClick(self.onBtnBanClick)

	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnEdit = UIControls.Button(self, "BgPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.btnSave = UIControls.Button(self, "BgPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnTeam = {}

	for i = 1, 3 do
		self.btnTeam[i] = UIControls.Button(self, "BgPanel/PickPanel/TeamPanel/BtnTeam" .. i)
		self.btnTeam[i].index = i

		self.btnTeam[i]:addEventClick(self.onBtnTeamClick)
	end

	self.pickPanel = UIControls.Panel(self, "BgPanel/PickPanel")
	self.banPanel = UIControls.Panel(self, "BgPanel/BanPanel")
	self.item1 = UIControls.Panel(self, "BgPanel/PickPanel/CardList/Item1")
	self.nowSelectBtnIndex = nil
	self.pickCells = {}

	for i = 1, 10 do
		self.pickCells[i] = UIControls.Panel(self, "BgPanel/PickPanel/CardList/Item" .. i)
		self.pickCells[i].btn = UIControls.Button(self, "BgPanel/PickPanel/CardList/Item" .. i .. "/UIClick")
		self.pickCells[i].btn.index = i

		self.pickCells[i].btn:addEventClick(self.onPickBtnClick)

		self.pickCells[i].grid = TopPvpBpHeroIconCell(self, "BgPanel/PickPanel/CardList/Item" .. i .. "/GridItem", "System/StarUp/GridHeroStarUp")
	end

	self.banCells = {}

	for i = 1, 5 do
		local path = "BgPanel/BanPanel/CardList/Item" .. i

		self.banCells[i] = UIControls.Panel(self, path)
		self.banCells[i].btn = UIControls.Button(self, path .. "/UIClick")
		self.banCells[i].btn.index = i
		self.banCells[i].grid = TopPvpBpSettingBanCell(self, path .. "/GridItem", "System/Common/Grid/GridCareerItem")

		self.banCells[i].grid:setVisible(true)

		self.banCells[i].txtName = UIControls.Label(self, path .. "/TextTitle")

		self.banCells[i].btn:addEventClick(self.onBanBtnClick)
	end

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		self.actData = actData
	end

	self.nowSelectTeam = 1

	self:initData()
end

function TopPvpBpSettingDlg:initData(...)
	self.heroBag = {}
	self.careerPos = {}

	if self.actData then
		local data = self.actData:getBpBanRule()

		self.careerPos = utils.deepcopy(data)

		local nowServerData = self.actData:getMyBPAllHeros()

		for teamType, oneBag in pairs(nowServerData) do
			local newBag = {}

			for pos, hero in ipairs(oneBag) do
				newBag[pos] = {}
				newBag[pos].id = hero.id
				newBag[pos].gid = hero.gid
			end

			self.heroBag[teamType] = newBag
		end
	end
end

function TopPvpBpSettingDlg:updateData()
	self:initData()
	self:refreshUI()
end

function TopPvpBpSettingDlg:onBanBtnClick(sender)
	local index = sender.index

	if self.inEdit ~= true then
		return
	end

	if self.nowSelectBtnIndex == index then
		return
	end

	if self.nowSelectBtnIndex ~= nil then
		self:exchangeTwoIndex(index, self.nowSelectBtnIndex)

		self.nowSelectBtnIndex = nil
	else
		self.nowSelectBtnIndex = index
	end

	self:refreshUI()
end

function TopPvpBpSettingDlg:show(state)
	if state == "ban" then
		self:setMode("ban")
	else
		self:setMode("pick")
	end
end

function TopPvpBpSettingDlg:setMode(mode)
	self.mode = mode

	if self.mode == "ban" then
		self.pickPanel:setVisible(false)
		self.banPanel:setVisible(true)
		self.btnBan:setEnable(false)
		self.btnPick:setEnable(true)
	end

	if self.mode == "pick" then
		self.pickPanel:setVisible(true)
		self.banPanel:setVisible(false)
		self.btnBan:setEnable(true)
		self.btnPick:setEnable(false)
	end

	self:refreshUI()
end

function TopPvpBpSettingDlg:exchangeTwoIndex(index1, index2)
	if not index1 or not index2 then
		return
	end

	if self.mode == "ban" then
		if self.careerPos then
			local replaceCareer = self.careerPos[index2]

			self.careerPos[index2] = self.careerPos[index1]
			self.careerPos[index1] = replaceCareer
		end
	elseif self.nowSelectTeam and self.heroBag and self.heroBag[self.nowSelectTeam] then
		local selectHeroBag = self.heroBag[self.nowSelectTeam]
		local replaceHeroId = selectHeroBag[index2].id
		local replaceHeroGid = selectHeroBag[index2].gid

		selectHeroBag[index2].id = selectHeroBag[index1].id
		selectHeroBag[index2].gid = selectHeroBag[index1].gid
		selectHeroBag[index1].id = replaceHeroId
		selectHeroBag[index1].gid = replaceHeroGid
	end
end

function TopPvpBpSettingDlg:setBanCellData(index, career)
	local num2CareerName = {
		Lang.get(4485),
		Lang.get(4487),
		Lang.get(4489),
		Lang.get(88537),
		Lang.get(4493)
	}

	if not index or not career then
		return
	end

	if self.banCells[index] and self.banCells[index].grid then
		self.banCells[index].grid:setData(career)
		self.banCells[index].txtName:setText(num2CareerName[career])
	end
end

function TopPvpBpSettingDlg:setEditState(isInEdit)
	self.inEdit = isInEdit

	self.btnEdit:setVisible(not isInEdit)
	self.btnSave:setVisible(isInEdit)
	self.btnDeny:setVisible(isInEdit)
	self:refreshUI()
end

function TopPvpBpSettingDlg:refreshState()
	return
end

function TopPvpBpSettingDlg:refreshUI(...)
	if self.mode == "ban" then
		for i = 1, 5 do
			if self.careerPos and self.careerPos[i] then
				self:setBanCellData(i, self.careerPos[i])
			end
		end

		if self.inEdit == true then
			if self.nowSelectBtnIndex == nil then
				for i = 1, 5 do
					self.banCells[i]:playAnimator("SettingItemEdit", true)
				end
			else
				for i = 1, 5 do
					if i ~= self.nowSelectBtnIndex then
						self.banCells[i]:playAnimator("SettingItemChange", true)
					else
						self.banCells[i]:playAnimator("SettingItemSlc", true)
					end
				end
			end
		else
			for i = 1, 5 do
				self.banCells[i]:playAnimator("SettingItemNml", true)
			end
		end
	else
		for i = 1, 3 do
			self.btnTeam[i]:setEnable(self.nowSelectTeam ~= i)
		end

		if self.inEdit == true then
			if self.nowSelectBtnIndex == nil then
				for i = 1, 10 do
					self.pickCells[i]:playAnimator("SettingItemEdit", true)
				end
			else
				for i = 1, 10 do
					if i ~= self.nowSelectBtnIndex then
						self.pickCells[i]:playAnimator("SettingItemChange", true)
					else
						self.pickCells[i]:playAnimator("SettingItemSlc", true)
					end
				end
			end
		else
			for i = 1, 10 do
				self.pickCells[i]:playAnimator("SettingItemNml", true)
			end
		end

		self:refreshHeroShow()
	end
end

function TopPvpBpSettingDlg:refreshHeroShow(...)
	if not self.nowSelectTeam then
		return
	end

	if not self.heroBag then
		-- block empty
	elseif not self.heroBag[self.nowSelectTeam] then
		-- block empty
	else
		local heros = self.heroBag[self.nowSelectTeam]
		local count = math.min(#heros, 10)

		for i = 1, count do
			local cell = self.pickCells[i].grid

			cell:setVisible(true)

			local hero = BaseObject.GetObject(heros[i].id)

			cell:setHero(hero)
		end
	end
end

function TopPvpBpSettingDlg:onPickBtnClick(sender)
	if self.inEdit ~= true then
		return
	end

	if self.nowSelectBtnIndex == nil then
		self.nowSelectBtnIndex = sender.index
	elseif self.nowSelectBtnIndex ~= sender.index then
		self:exchangeTwoIndex(self.nowSelectBtnIndex, sender.index)

		self.nowSelectBtnIndex = nil
	end

	self:refreshUI()
end

function TopPvpBpSettingDlg:onBtnTeamClick(sender)
	self.nowSelectTeam = sender.index

	self:refreshUI()
end

function TopPvpBpSettingDlg:onBtnEditClick()
	if CurAvatar:TopPvpCanChangeBpHeros() then
		-- block empty
	else
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			if actData:checkKnockoutNowRoundQualification() == true then
				if ResBPPvpShow[13070025] and ResBPPvpShow[13070025].desc then
					local desc = ResBPPvpShow[13070025].desc

					MsgManager.notice(desc)
				end
			elseif ResBPPvpShow[13070027] and ResBPPvpShow[13070027].desc then
				local desc = ResBPPvpShow[13070027].desc

				MsgManager.notice(desc)
			end
		end

		return
	end

	if self.mode == "pick" then
		local notice
		local resData = ResBPPvpShow[13070026]

		if resData then
			notice = resData.desc
		end

		if not self.heroBag then
			if notice then
				MsgManager.notice(notice)
			end
		else
			for i = 1, 3 do
				if not self.heroBag[i] or #self.heroBag[i] ~= 10 then
					MsgManager.notice(notice)

					return
				end
			end
		end
	end

	self:setEditState(true)
end

function TopPvpBpSettingDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(439)
end

function TopPvpBpSettingDlg:onBtnDenyClick()
	self:initData()
	self:setEditState(false)
end

function TopPvpBpSettingDlg:saveBpTeamToServer(...)
	local actData = CurAvatar:getTopPVPActivityData()
	local actId = CurAvatar:getTopPVPActivityOpId()
	local actData = CurAvatar:getTopPVPActivityData()
	local data = {}

	for i = 1, 3 do
		for j = 1, #self.heroBag[i] do
			table.insert(data, self.heroBag[i][j].gid)
		end
	end

	RPC.bPPvpKnockoutSetBPPool(actId, actData.channel, actData.myKnockoutRoomId, data)
end

function TopPvpBpSettingDlg:onBtnSaveClick()
	if self.mode == "ban" then
		if CurAvatar:TopPvpCanChangeBpHeros() then
			if ResBPPvpHeroAutoBanRule then
				for i = 1, #ResBPPvpHeroAutoBanRule do
					local resData = ResBPPvpHeroAutoBanRule[i]

					if resData and self.careerPos and resData.career_1 == self.careerPos[1] and resData.career_2 == self.careerPos[2] and resData.career_3 == self.careerPos[3] and resData.career_4 == self.careerPos[4] and resData.career_5 == self.careerPos[5] then
						local index = i
						local actId = CurAvatar:getTopPVPActivityOpId()
						local myKnockoutRoomId

						if self.actData then
							myKnockoutRoomId = self.actData.myKnockoutRoomId
						end

						if index and actId and myKnockoutRoomId then
							RPC.bPPvpKnockouotBanRuleSet(actId, myKnockoutRoomId, index)
						end

						break
					end
				end
			end
		else
			local actData = CurAvatar:getTopPVPActivityData()

			if actData then
				if actData:checkKnockoutNowRoundQualification() == true then
					local resData = ResBPPvpShow[13070024]

					if resData and resData.desc then
						local desc = resData.desc

						MsgManager.notice(desc)
						self:initData()
					end
				elseif ResBPPvpShow[13070027] and ResBPPvpShow[13070027].desc then
					local desc = ResBPPvpShow[13070027].desc

					MsgManager.notice(desc)
				end
			end
		end
	elseif CurAvatar:TopPvpCanChangeBpHeros() then
		self:saveBpTeamToServer()
	else
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			if actData:checkKnockoutNowRoundQualification() == true then
				local resData = ResBPPvpShow[13070024]

				if resData and resData.desc then
					local desc = resData.desc

					MsgManager.notice(desc)
					self:initData()
				end
			elseif ResBPPvpShow[13070027] and ResBPPvpShow[13070027].desc then
				local desc = ResBPPvpShow[13070027].desc

				MsgManager.notice(desc)
			end
		end
	end

	self:setEditState(false)
end

function TopPvpBpSettingDlg:onBtnPickClick()
	if self.mode == "pick" then
		return
	end

	if self.inEdit == true then
		MsgManager.notice(Lang.get(88286))
	else
		self:show("pcik")
	end
end

function TopPvpBpSettingDlg:onBtnBanClick()
	if self.mode == "ban" then
		return
	end

	if self.inEdit == true then
		MsgManager.notice(Lang.get(88286))
	else
		self:show("ban")
	end
end

function TopPvpBpSettingDlg:onBtnCloseClick()
	local ui = UIManager.tryGetUI("topPvpBpTeamDlg")

	if ui and ui:getVisible() then
		ui:refreshUI()
	end

	self:setVisible(false)
end

return TopPvpBpSettingDlg
