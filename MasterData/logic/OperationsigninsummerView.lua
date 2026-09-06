-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationsigninsummerView.lua

module("logic.extensions.operationsignin.view.OperationsigninsummerView", package.seeall)

local OperationsigninsummerView = class("OperationsigninsummerView", ViewComponent)

function OperationsigninsummerView:ctor()
	OperationsigninsummerView.super.ctor(self)
end

function OperationsigninsummerView:buildUI()
	OperationsigninsummerView.super.buildUI(self)

	self._temCfgs = {
		{
			posY = -1.3,
			showPet = 10167,
			actId = 18007
		},
		{
			posY = -1.3,
			showPet = 10308,
			actId = 18008
		},
		{
			posY = -1.3,
			showPet = 10323,
			actId = 18009
		}
	}
	self._btnClose = self:getBtn("btnClose")
	self._txtSignDay = self:getTxt("txtSignDay")
	self._signInCells = {}

	for i = 1, 7 do
		local cell = {}

		cell.id = i
		cell.go = self:getGo("cell_" .. i)
		cell.btn = GameUtil.asBtn(cell.go)
		cell.item = goutil.findChild(cell.go, "item")
		cell.mark = goutil.findChild(cell.go, "gain")
		cell.showCfg = nil
		cell.isGain = false
		cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.tag = goutil.findChild(cell.go, "tag")
		cell.txtTag = goutil.findChildTextComponent(cell.tag, "txt")
		cell.effParent = goutil.findChild(cell.go, "eff")
		cell.eff = nil
		cell.eff2 = nil

		goutil.setActive(cell.tag, false)
		goutil.setActive(cell.mark, false)

		self._signInCells[i] = cell
	end

	self._switchBtns = {}

	for i = 1, 3 do
		local temCell = {}

		temCell.go = self:getGo("switchBtns/btn_" .. i)
		temCell.btn = GameUtil.asBtn(temCell.go)
		temCell.mark = goutil.findChild(temCell.go, "mark")
		temCell.cfg = self._temCfgs[i]
		self._switchBtns[i] = temCell
	end

	self._hasGainDay = {}
	self._onlineDay = 0
	self._curActId = nil
	self.petPhoto = PetPhotoShow.Get(self:getGo("con"))
	self._eff = nil
end

function OperationsigninsummerView:bindEvents()
	OperationsigninsummerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, #self._switchBtns do
		self._switchBtns[i].btn:AddClickListener(function()
			self:_onClickSwitch(i)
		end, self)
	end

	for i = 1, #self._signInCells do
		self._signInCells[i].btn:AddClickListener(function()
			self:_onClickSignIn(i)
		end, self)
	end
end

function OperationsigninsummerView:unbindEvents()
	OperationsigninsummerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, #self._switchBtns do
		self._switchBtns[i].btn:RemoveClickListener()
	end

	for i = 1, #self._signInCells do
		self._signInCells[i].btn:RemoveClickListener()
	end
end

function OperationsigninsummerView:destroyUI()
	OperationsigninsummerView.super.destroyUI(self)
end

function OperationsigninsummerView:onEnter()
	OperationsigninsummerView.super.onEnter(self)

	self._ableToClick = true

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SignIn)

	self._curActId = cfg and cfg.activityId

	local openParam = checkint(self:getFirstParam())
	local curActShowId = self:_getShowId(self._curActId)

	if curActShowId then
		OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(self._curActId, function(msg)
			self._onlineDay = checknumber(msg.onlineDay)
			self._hasGainDay = msg.hasGainPrizeDays or {}

			if openParam == 0 then
				self:_onClickSwitch(curActShowId, true)
			else
				self:_onClickSwitch(openParam, true)
			end
		end)
	elseif openParam == 0 then
		self:_onClickSwitch(1)
	else
		self:_onClickSwitch(openParam)
	end

	if self._showId ~= 1 or self._showId ~= 2 or self._showId ~= 3 then
		self:_onClickSwitch(1)
	end
end

function OperationsigninsummerView:onEnterFinished()
	OperationsigninsummerView.super.onEnterFinished(self)
end

function OperationsigninsummerView:onExit()
	OperationsigninsummerView.super.onExit(self)
	self.petPhoto:clear()

	for i = 1, #self._signInCells do
		MaterialMgr.clearIcon(self._signInCells[i].item)

		if self._signInCells[i].eff then
			UIEffectManager.instance:stopEffect(self._signInCells[i].eff)

			self._signInCells[i].eff = nil
		end

		if self._signInCells[i].eff2 then
			UIEffectManager.instance:stopEffect(self._signInCells[i].eff2)

			self._signInCells[i].eff2 = nil
		end
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	self._showId = nil

	self:_showCI()
end

function OperationsigninsummerView:onExitFinished()
	OperationsigninsummerView.super.onExitFinished(self)
end

function OperationsigninsummerView:_getShowId(actId)
	if actId then
		for i = 1, #self._temCfgs do
			if self._temCfgs[i].actId == actId then
				return i
			end
		end
	end
end

function OperationsigninsummerView:_onClickSignIn(id)
	local cell = self._signInCells[id]

	if cell.eff then
		if not self._ableToClick then
			return
		end

		self._ableToClick = false

		OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(self._curActId, cell.id, function(msg)
			local ci = msg.changeSetId

			MaterialController.instance:saveChangeSetToTemp(ci)

			if ci then
				self.ciList = ci
			end

			table.insert(self._hasGainDay, cell.id)
			goutil.setActive(cell.mark, true)

			if cell.eff then
				UIEffectManager.instance:stopEffect(cell.eff)

				cell.eff = nil
			end

			self:_playEff(id)
		end)

		return
	end

	if cell.go and cell.id and cell.showCfg then
		CommonTipsMgr.instance:openTipsByConfStr(cell.go, cell.showCfg.showPrize)
	end
end

function OperationsigninsummerView:_showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function OperationsigninsummerView:_onClickSwitch(id, force)
	if not self._ableToClick then
		return
	end

	for i = 1, #self._switchBtns do
		goutil.setActive(self._switchBtns[i].mark, id == i)
	end

	if self._showId ~= id then
		self._showId = id

		self:_refreshUI()
	elseif force then
		self:_refreshUI()
	end
end

function OperationsigninsummerView:_refreshUI()
	self:_showCI()

	if self._showId == 3 then
		self._signInCells[7].id = nil
	else
		self._signInCells[7].id = 7
	end

	local showActId = self._switchBtns[self._showId].cfg.actId
	local showList = OperationSignInConfig.instance:getSignInShowCfgsByActId(showActId)

	table.sort(showList, function(a, b)
		return a.day < b.day
	end)
	self.petPhoto:showPetEffect(self._switchBtns[self._showId].cfg.showPet, true, 5.5)

	if self._showId == 3 then
		self.petPhoto:setPetLocalPosAndScale(1.8, self._switchBtns[self._showId].cfg.posY, 1.3)
	else
		self.petPhoto:setPetLocalPosAndScale(0, self._switchBtns[self._showId].cfg.posY, 1.3)
	end

	for i = 1, #self._signInCells do
		local cell = self._signInCells[i]

		MaterialMgr.clearIcon(cell.item)

		if cell.eff then
			UIEffectManager.instance:stopEffect(cell.eff)

			cell.eff = nil
		end

		goutil.setActive(cell.mark, false)
		goutil.setActive(cell.tag, false)
		goutil.setActive(cell.go, cell.id)

		if cell.id then
			cell.txtTime.text = "Day." .. cell.id
			cell.showCfg = showList[cell.id]

			local matType, matId, matNum = MaterialMgr.getMatParams(cell.showCfg.showPrize)

			cell.txtNum.text = "x" .. matNum

			MaterialMgr.updateItemByStr(cell.item, cell.showCfg.showPrize)
		end
	end

	if self._curActId then
		if showActId == self._curActId then
			self._txtSignDay.text = string.format("本周已登录 <color=#FFE64EFF>%s</color> 天", self._onlineDay)

			for i = 1, #self._signInCells do
				local cell = self._signInCells[i]

				GameUtil.SetGray(cell.item, false)

				cell.isGain = table.keyof(self._hasGainDay, cell.id)

				if cell.isGain then
					goutil.setActive(cell.mark, true)

					if cell.showCfg.showEffType ~= 0 then
						for k, v in pairs(cell.showCfg.showTags) do
							self:_showTag(v)
						end
					end
				else
					goutil.setActive(self._signInCells[i].mark, false)

					if i <= self._onlineDay then
						self:_createEff(i)
					end
				end

				if i <= self._onlineDay then
					self:_showTag(i)
				end
			end

			self:_updateHasGainShowTag()
		elseif showActId > self._curActId then
			self._txtSignDay.text = "本周活动未开启"

			for i = 1, #self._signInCells do
				GameUtil.SetGray(self._signInCells[i].item, false)
			end
		else
			self._txtSignDay.text = "本周活动已结束"

			for i = 1, #self._signInCells do
				GameUtil.SetGray(self._signInCells[i].item, true)
			end
		end
	else
		self._txtSignDay.text = "本周活动未开启"
	end
end

function OperationsigninsummerView:_createEff(id)
	local cell = self._signInCells[id]

	if cell.eff then
		UIEffectManager.instance:stopEffect(cell.eff)

		cell.eff = nil
	end

	cell.eff = UIEffectManager.instance:playEffect(self, (id == 2 or id == 5 or id == 7) and "fx_ui_shujiadenglu/fx_ui_shujiadenglu_k1.prefab" or "fx_ui_shujiadenglu/fx_ui_shujiadenglu_k2.prefab", cell.effParent, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(cell.effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function OperationsigninsummerView:_showTag(id)
	local cell = self:_getSignInCellById(id)

	if cell and cell.id and cell.showCfg and cell.showCfg.showTimes > 1 then
		cell.txtTag.text = string.format("X%s倍", cell.showCfg.showTimes)

		if cell.eff2 then
			UIEffectManager.instance:stopEffect(cell.eff2)

			cell.eff2 = nil
		end

		local effPath = "fx_ui_shujiadenglu/fx_ui_shujiadenglu_2bei.prefab"

		cell.eff2 = UIEffectManager.instance:playEffect(self, effPath, cell.tag, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(cell.tag.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			goutil.setActive(cell.tag, true)
		end)
	end
end

function OperationsigninsummerView:_getSignInCellById(id)
	for k, v in pairs(self._signInCells) do
		if v.id == id then
			return v
		end
	end
end

function OperationsigninsummerView:_playEff(id)
	local cell = self:_getSignInCellById(id)

	if cell.showCfg.showEffType ~= 0 then
		for k, v in pairs(cell.showCfg.showTags) do
			local tagCell = self:_getSignInCellById(v)

			if not GameUtil.GetActive(tagCell.tag) then
				if self._eff then
					UIEffectManager.instance:stopEffect(self._eff)

					self._eff = nil
				end

				local effPath = string.format("fx_ui_shujiadenglu/fx_ui_shujiadenglu_zi0%s.prefab", cell.showCfg.showEffType)

				self._eff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false, false, function(target, eff)
					self:_updateHasGainShowTag()
				end, function(target, eff)
					eff.effGo.transform:SetParent(self.mainGO.transform)
					GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
					GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

					eff.hideEffWhileNotOnTop = true
				end)

				return
			end
		end
	end

	self:_updateHasGainShowTag()
end

function OperationsigninsummerView:_updateHasGainShowTag()
	for k, v in pairs(self._hasGainDay) do
		local cell = self:_getSignInCellById(v)

		if cell then
			if not cell.showCfg.showTags then
				for k1, v1 in pairs(cell.showCfg.showTags) do
					self:_showTag(v1)
				end
			end
		end
	end

	self._ableToClick = true

	self:_showCI()
end

return OperationsigninsummerView
