-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleBuffView.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleBuffView", package.seeall)

local HolyDragonTempleBuffView = class("HolyDragonTempleBuffView", ViewComponent)

function HolyDragonTempleBuffView:buildUI()
	HolyDragonTempleBuffView.super.buildUI(self)

	self._customInput = UICustomInput.Get(self.mainGO)
	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/txt")

	local descScrView = self:getGo("descScrView")
	local descScrCell = self:getGo("descScrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
end

function HolyDragonTempleBuffView:bindEvents()
	HolyDragonTempleBuffView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function HolyDragonTempleBuffView:unbindEvents()
	HolyDragonTempleBuffView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function HolyDragonTempleBuffView:onEnter()
	HolyDragonTempleBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._floorId = checknumber(params[2])
	self._subMo = HolyDragonTempleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleSignInRes, self._onSignInUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleInfoRes, self._onInfoUpdate, self)
	self:_onUpdate()
end

function HolyDragonTempleBuffView:onExit()
	HolyDragonTempleBuffView.super.onExit(self)
	self._descScrollerList:dispose()
end

function HolyDragonTempleBuffView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonTempleBuffView:_onInfoUpdate(msg)
	if checknumber(msg.activityId) ~= self._activityId then
		return
	end

	self:_onUpdate()
end

function HolyDragonTempleBuffView:_onSignInUpdate(msg)
	if checknumber(msg.activityId) ~= self._activityId then
		return
	end

	if checknumber(msg.floorId) ~= self._floorId then
		return
	end

	self:_onUpdate()
end

function HolyDragonTempleBuffView:_onUpdateData()
	self._floorData = HolyDragonTempleConfig.instance:getFloorData(self._activityId, self._floorId)
	self._signInDays = self._subMo:getSignInDays(self._floorId)
	self._isTodaySignUp = self._subMo:isTodaySignUp(self._floorId)
	self._buffDataList = {}

	local buffDatas = HolyDragonTempleConfig.instance:getSignInBuffDatas(self._activityId, self._floorId)

	self._maxSignInDays = 0

	for _, buffData in ipairs(buffDatas) do
		self._maxSignInDays = math.max(self._maxSignInDays, checknumber(buffData.signInDays))
	end

	self._isAllActivated = self._maxSignInDays <= 0 or self._signInDays >= self._maxSignInDays
	self._canSignInToday = not self._isTodaySignUp and not self._isAllActivated

	local activeSignInDays = self._signInDays

	if self._canSignInToday then
		if not (self._signInDays + 1) then
			local todaySignInDays = 0

			for _, buffData in ipairs(buffDatas) do
				local data = {}

				data.buffId = checknumber(buffData.buffId)
				data.signInDays = checknumber(buffData.signInDays)
				data.buffData = buffData
				data.isTodayActivated = todaySignInDays > 0 and data.signInDays == todaySignInDays
				data.isActivated = activeSignInDays > 0 and data.signInDays == activeSignInDays

				table.insert(self._buffDataList, data)
			end
		end
	end
end

function HolyDragonTempleBuffView:_onUpdateUI()
	self._txtTitle.text = langPara("%s祝福", self._floorData.name)

	self._descScrollerList:reloadData(self._buffDataList)
	self:_onUpdateBtnSure()
end

function HolyDragonTempleBuffView:_onUpdateBtnSure()
	self._txtBtnSure.text = self._isAllActivated and lang("已激活") or self._isTodaySignUp and lang("已签到") or lang("签到")

	GameUtil.SetGray(self._btnSure, not self._canSignInToday)
end

function HolyDragonTempleBuffView:_updateDescCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local tagActive = goutil.findChild(go, "tagActive")
	local tagToDay = goutil.findChild(go, "tagToDay")
	local buffData = data.buffData

	txtDesc.text = buffData.desc

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconUrl(buffData.icon))
	GameUtil.SetActive(tagActive, data.isActivated and not data.isTodayActivated)
	GameUtil.SetActive(tagToDay, data.isTodayActivated)
end

function HolyDragonTempleBuffView:_clearDescCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

function HolyDragonTempleBuffView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function HolyDragonTempleBuffView:_onClickBtnSure()
	if self._isAllActivated then
		FloatWordMgr.instance:show(lang("祝福已全部激活"))

		return
	elseif self._isTodaySignUp then
		FloatWordMgr.instance:show(lang("今日已签到"))

		return
	elseif not self._canSignInToday then
		FloatWordMgr.instance:show(lang("暂无可签到祝福"))

		return
	end

	HolyDragonTempleController.instance:sendPM_HolyDragonTempleSignInReq(self._activityId, self._floorId)
end

return HolyDragonTempleBuffView
