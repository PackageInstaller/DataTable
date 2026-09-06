-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareHelpItem.lua

module("logic.extensions.sharetask.view.ShareHelpItem", package.seeall)

local ShareHelpItem = class("ShareHelpItem")

function ShareHelpItem:ctor()
	self.curViewDatas = {}
end

function ShareHelpItem:buildUI(parent)
	self.mainGO = parent
	self.infoShowGo = goutil.findChild(parent, "infoShowGo")
	self.helpMeBtn = Framework.ButtonAdapter.GetFrom(self.infoShowGo, "helpMeBtn")
	self.helpOtherBtn = Framework.ButtonAdapter.GetFrom(self.infoShowGo, "helpOtherBtn")
	self.worldBtn = Framework.ButtonAdapter.GetFrom(self.infoShowGo, "worldBtn")
	self.tableScroll = goutil.findChild(parent, "itemListSR"):GetComponent("UITableview")
	self.tableCell = goutil.findChild(parent, "itemListSR/listItem")

	self.tableCell:SetActive(false)
end

function ShareHelpItem:unbindEvents()
	self.helpMeBtn:RemoveClickListener()
	self.helpOtherBtn:RemoveClickListener()
	self.worldBtn:RemoveClickListener()
end

function ShareHelpItem:onExit()
	self.tableScroll:Travel(self.OnClearTableView, self)

	self.curViewDatas = {}

	self.tableScroll:UnRegisterAllCallbacks()
end

function ShareHelpItem:onEnter(view)
	local battleInfo = ShareTaskModel.instance:GetBattleBossInfo()
	local bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

	if battleInfo.isMyBoss and not battleInfo.isParam then
		self.tableScroll.gameObject:SetActive(false)
		self.infoShowGo:SetActive(true)

		if bossInfo == nil or not bossInfo.isHaveBoss or bossInfo.isFleeBoss or bossInfo.isMaxChall then
			self.helpMeBtn.gameObject:SetActive(false)
			self.helpOtherBtn.gameObject:SetActive(false)
			self.worldBtn.gameObject:SetActive(false)

			return
		end

		if not self.helpMeBtn.gameObject.activeSelf then
			self.helpMeBtn.gameObject:SetActive(true)
		end

		self.helpMeBtn:AddClickListener(function()
			if bossInfo.isKillBoss then
				FloatWordMgr.instance:show("你太强了，无需求助他人！")

				return
			end

			UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareBoss, bossInfo.bossId, bossInfo.bossTypeId)
		end, self)

		if not self.helpOtherBtn.gameObject.activeSelf then
			self.helpOtherBtn.gameObject:SetActive(true)
		end

		self.helpOtherBtn:AddClickListener(function()
			UIJumper.instance:pushClearCurStack(ViewName.ShareTask, true)
			BattleController.instance:endBattle()
		end, self)

		if not self.worldBtn.gameObject.activeSelf then
			self.worldBtn.gameObject:SetActive(true)
		end

		self.worldBtn:AddClickListener(function()
			UIJumper.instance:pushClearCurStack(ViewName.chat, true, GameEnum.ChatChannel.Share)
			BattleController.instance:endBattle()
		end, self)

		return
	end

	self.infoShowGo:SetActive(false)
	self.tableScroll.gameObject:SetActive(true)

	self.curViewDatas = {}
	self.bossMaxHp = 0

	if battleInfo.isMyBoss then
		if bossInfo.partnerList then
			self.curViewDatas = bossInfo.partnerList
		end

		self.bossMaxHp = bossInfo.maxHp
	else
		local tempInfo = ShareTaskModel.instance:GetOtherShareBossInfo()

		if tempInfo then
			if tempInfo.partnerList then
				self.curViewDatas = tempInfo.partnerList
			end

			self.bossMaxHp = tempInfo.maxHp
		end
	end

	self.tableScroll:RegisterCallback(self.GetViewCellCount, function()
		return 550, 65
	end, self.OnCellAtIndex, self)

	self.ownId = RoleModel.instance:getUserId()

	self.tableScroll:ReloadData()
end

function ShareHelpItem:GetViewCellCount()
	if not self.curViewDatas then
		return 0
	end

	return #self.curViewDatas
end

function ShareHelpItem:OnCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.tableCell)

	local data = self.curViewDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ShareHelpItem:_updateCell(view, cell, data)
	local headGo = goutil.findChild(cell, "headGo")
	local meGo = goutil.findChild(cell, "meGo")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local levelTxt = goutil.findChildTextComponent(cell, "levelTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local barSli = goutil.findChild(cell, "barSli"):GetComponent("Slider")

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)
	meGo:SetActive(data.headInfo.userId == self.ownId)

	rankTxt.text = tostring(cell.data)
	levelTxt.text = tostring(data.headInfo.playerLv)
	nameTxt.text = data.headInfo.userName
	powerTxt.text = tostring(data.causeDamage)
	barSli.value = data.causeDamage / self.bossMaxHp
end

function ShareHelpItem:OnClearTableView(cell)
	local parentGo = cell.gameObject

	MaterialMgr.resetAll(parentGo)
end

return ShareHelpItem
