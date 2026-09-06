-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareListView.lua

module("logic.extensions.sharetask.view.ShareListView", package.seeall)

local ShareListView = class("ShareListView", TableViewComponent)

function ShareListView:ctor()
	ShareListView.super.ctor(self)

	self.cellTextList = nil
end

function ShareListView:buildUI()
	ShareListView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self.closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
	self.tipsBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "tipsBtn")
	self.buddyChllgTxt = goutil.findChildTextComponent(viewBgGo, "buddyChllgTxt")
	self.noZhuzhanGo = goutil.findChild(viewBgGo, "noZhuzhanGo")
	self.jumpBtn = Framework.ButtonAdapter.GetFrom(self.noZhuzhanGo, "jumpBtn")
	self.buddyChllgTxt.text = ""

	self.noZhuzhanGo:SetActive(false)
end

function ShareListView:bindEvents()
	ShareListView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "sharelist")
	end, self)
	self.jumpBtn:AddClickListener(function()
		UIStateManager.instance:clear(true)
		UIStateManager.instance:push(ViewName.chat, GameEnum.ChatChannel.World)
	end, self)
end

function ShareListView:unbindEvents()
	ShareListView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	self.jumpBtn:RemoveClickListener()
end

function ShareListView:onExit()
	ShareListView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataShareTaskBossAssistList, self.UpdataBossAssistSR, self)

	self._curViewDatas = nil
	self.cellTextList = nil
end

function ShareListView:destroyUI()
	ShareListView.super.destroyUI(self)
end

function ShareListView:onEnter()
	ShareListView.super.onEnter(self)

	self.baseInfo = ShareTaskModel.instance:GetShareTaskBaseInfo()

	local sup = self.baseInfo.helpHave - self.baseInfo.helpUse

	if sup < 0 then
		sup = 0
	end

	self.buddyChllgTxt.text = string.format("助战次数：%s/%s", sup, self.baseInfo.helpHave)
	self.showTime = ShareTaskConfig.instance:GetBossShowTime()

	self:UpdataBossAssistSR()
	GlobalDispatcher:addListener(GlobalNotify.UpdataShareTaskBossAssistList, self.UpdataBossAssistSR, self)
end

function ShareListView:UpdataBossAssistSR()
	removetimer(self.CalculationSurplusTime, self)

	self.cellTextList = {}
	self._curViewDatas = ShareTaskModel.instance:GetBossAssistList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self.noZhuzhanGo:SetActive(true)
	else
		self.noZhuzhanGo:SetActive(false)
		settimer(1, self.CalculationSurplusTime, self, true)
	end

	self._tableview:ReloadData()
end

function ShareListView:_getPath()
	return {
		cellPath = "viewBgGo/buddyItem",
		viewPath = "viewBgGo/buddyListSR"
	}
end

function ShareListView:_cellSize()
	return 905, 105
end

function ShareListView:_updateCell(view, cell, data)
	local peopleTxt = goutil.findChildTextComponent(cell, "peopleTxt")
	local timerTxt = goutil.findChildTextComponent(cell, "timerTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local bangzhuBtn = goutil.findChildButtonComponent(cell, "bangzhuBtn")
	local monsterImaGo = goutil.findChild(cell, "monsterIconIma")
	local runTimeGo = goutil.findChild(cell, "runTimeGo")
	local friendGo = goutil.findChild(cell, "friendGo")
	local monsterLevelTxt = goutil.findChildTextComponent(cell, "monsterLevelTxt")
	local monsterNameTxt = goutil.findChildTextComponent(cell, "monsterNameTxt")
	local monsterBloodTxt = goutil.findChildTextComponent(cell, "monsterBloodTxt")

	self.cellTextList[timerTxt] = nil

	local bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(data.bossTypeId)

	if bossCfg == nil then
		printError("sr---- ShareListView:_updateCell()   Boss配置为空  Lv = " .. data.bossTypeId)
		cell:SetActive(false)

		return
	end

	timerTxt.text = "00:00"
	peopleTxt.text = string.format("%s/%s", data.challTiems, bossCfg.memberLimit)

	local supTime = math.ceil(data.startTime / 1000 + self.showTime - checknumber(ServerTime.now()))

	if supTime > 0 then
		self.cellTextList[timerTxt] = {
			supTime = supTime,
			timerTxt = timerTxt,
			runTimeGo = runTimeGo
		}
		timerTxt.text = self:ShowSurplusTime(supTime)
	end

	runTimeGo:SetActive(supTime <= 120)

	if FriendModel.instance:getGroupTypeById(data.userId) == GameEnum.FriendGroup.Friend then
		friendGo:SetActive(true)
	else
		friendGo:SetActive(false)
	end

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	nameTxt.text = data.userName
	powerTxt.text = tostring(data.everMaxZdl)

	local modelCfg = CharacterConfig.instance:getModelCo(bossCfg.monsterId)

	if modelCfg then
		if not modelCfg.headName then
			local headIcon = "icon_10002_xiaobao"

			uGuiUtil.setSpriteToImage(monsterImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(headIcon))

			monsterLevelTxt.text = "Lv." .. bossCfg.monsterLevel
			monsterNameTxt.text = bossCfg.name

			local value = math.floor(data.curHp * 100 / data.maxHp)

			monsterBloodTxt.text = string.format("剩余血量：%s%%", value)

			local index = cell.data

			GameUtil.addClickHandler(bangzhuBtn, GameUtil.handler(self.OnClickHelpChallBoss, self, index))
		end
	end
end

function ShareListView:OnClickHelpChallBoss(index)
	if checknumber(index) < 1 then
		return
	end

	if self._curViewDatas == nil or self._curViewDatas[index] == nil then
		return
	end

	local supTime = math.ceil(self._curViewDatas[index].startTime + self.showTime - checknumber(ServerTime.now()))

	if supTime <= 0 then
		FloatWordMgr.instance:show("怪物已经逃离啦！")

		return
	end

	local cfg = ShareTaskConfig.instance:GetBossLevelCfg(self.baseInfo.bossMaxLv)

	if cfg and cfg.unlockMonsterLevel < self._curViewDatas[index].bossLevel then
		FloatWordMgr.instance:show("怪物等级过高，不可挑战！")

		return
	end

	ShareTaskModel.instance:SetShareListOtherBossInfo(self._curViewDatas[index])
	UIStateManager.instance:open(ViewName.ShareConfirm, self._curViewDatas[index].userName, self._curViewDatas[index].bossId)
end

function ShareListView:CalculationSurplusTime()
	for _, info in pairs(self.cellTextList or {}) do
		if info and info.supTime > 0 and info.timerTxt and info.runTimeGo then
			info.supTime = info.supTime - 1
			info.timerTxt.text = self:ShowSurplusTime(info.supTime)

			info.runTimeGo:SetActive(info.supTime <= 120)

			if info.supTime <= -5 then
				self:UpdataBossAssistSR()
			end
		end
	end
end

function ShareListView:ShowSurplusTime(supTime)
	if supTime <= 0 then
		return "0分0秒"
	end

	local hour = math.floor(supTime / 3600)
	local min = math.floor((supTime - hour * 3600) / 60)
	local sec = supTime - hour * 3600 - min * 60

	return hour > 0 and string.format("%s时%s分", hour, min) or string.format("%s分%s秒", min, sec)
end

return ShareListView
