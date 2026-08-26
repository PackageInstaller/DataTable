-- chunkname: @modules/logic/rouge/view/RougeTalentTreeView.lua

module("modules.logic.rouge.view.RougeTalentTreeView", package.seeall)

local RougeTalentTreeView = class("RougeTalentTreeView", BaseView)

function RougeTalentTreeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gotalenttree = gohelper.findChild(self.viewGO, "#go_talenttree")
	self._gotalentdec = gohelper.findChild(self.viewGO, "#go_talentdec")
	self._txttalentname = gohelper.findChildText(self.viewGO, "#go_talentdec/bg/#txt_talentname")
	self._txttalentdec = gohelper.findChildText(self.viewGO, "#go_talentdec/#txt_talentdec")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_point")
	self._gopointitem = gohelper.findChild(self.viewGO, "#go_point/point")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._btnarrowright = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_arrowright")
	self._btnarrowleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_arrowleft")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_overview")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._txtdetailname = gohelper.findChildText(self.viewGO, "#go_detail/#txt_talentname")
	self._txtdetaildec = gohelper.findChildText(self.viewGO, "#go_detail/#txt_talentdec")
	self._btnlocked = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#go_detail/#btn_locked/#txt_locked")
	self._txtlocked2 = gohelper.findChildText(self.viewGO, "#go_detail/#btn_locked/#txt_locked2")
	self._btnlack = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_lack")
	self._txtlack = gohelper.findChildText(self.viewGO, "#go_detail/#btn_lack/#txt_lack")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_detail/#btn_cancel")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._gotoprighttips = gohelper.findChild(self.viewGO, "#go_topright/tips")
	self._txttoprighttips = gohelper.findChildText(self.viewGO, "#go_topright/tips/#txt_tips")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_click")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._detailAnimator = self._godetail:GetComponent(typeof(UnityEngine.Animator))
	self._currentSelectId = nil
	self._isopentips = false
	self._animtime = 0.2
	self._pointList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeView:addEvents()
	self._btnarrowright:AddClickListener(self._btnarrowrightOnClick, self)
	self._btnarrowleft:AddClickListener(self._btnarrowleftOnClick, self)
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnlack:AddClickListener(self._btnlackOnClick, self)
	self._btnlocked:AddClickListener(self._btnlockOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.onSwitchTab, self._onSwitchTab, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickTreeNode, self._onClickTreeBranchItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickEmpty, self.clickEmpty, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.exitTalentView, self.exitTalentView, self)
end

function RougeTalentTreeView:removeEvents()
	self._btnarrowright:RemoveClickListener()
	self._btnarrowleft:RemoveClickListener()
	self._btnoverview:RemoveClickListener()
	self._btnlack:RemoveClickListener()
	self._btnlocked:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.onSwitchTab, self._onSwitchTab, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnClickTreeNode, self._onClickTreeBranchItem, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnClickEmpty, self.clickEmpty, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.exitTalentView, self.exitTalentView, self)
end

function RougeTalentTreeView:_btnlackOnClick()
	if not self._currentconfig then
		return
	end

	local bigtalent = self._currentconfig.talent

	if RougeTalentModel.instance:checkBigNodeLock(bigtalent) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(self._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end

	if RougeTalentModel.instance:getTalentPoint() < self._currentconfig.cost then
		GameFacade.showToast(ToastEnum.RougeTalentTreeNoPoint)

		return
	end

	if RougeModel.instance:inRouge() then
		GameFacade.showToast(ToastEnum.InRouge)

		return
	end

	if not RougeTalentModel.instance:checkNodeLight(self._currentSelectId) then
		RougeOutsideRpc.instance:sendRougeActiveGeniusRequest(self._season, self._currentSelectId)
	end
end

function RougeTalentTreeView:_btnlockOnClick()
	if not self._currentconfig then
		return
	end

	local bigtalent = self._currentconfig.talent

	if RougeTalentModel.instance:checkBigNodeLock(bigtalent) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(self._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end
end

function RougeTalentTreeView:_btncancelOnClick()
	self._isOpenDetail = false

	gohelper.setActive(self._godetail, self._isOpenDetail)
	gohelper.setActive(self._gopoint, not self._isOpenDetail)
	gohelper.setActive(self._btnoverview.gameObject, not self._isOpenDetail)
	RougeController.instance:dispatchEvent(RougeEvent.OnCancelTreeNode, self._currentSelectId)
end

function RougeTalentTreeView:_btnarrowrightOnClick()
	local maxNum = RougeTalentConfig.instance:getTalentNum(self._season)

	if maxNum > self._tabIndex then
		self._tabIndex = self._tabIndex + 1

		self._animator:Update(0)
		self._animator:Play("switch_right", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(self._switchfunc, self, self._animtime)
	end

	self:_btncancelOnClick()
	self:_refreshView()
end

function RougeTalentTreeView:_btnarrowleftOnClick()
	if self._tabIndex > 1 then
		self._tabIndex = self._tabIndex - 1

		self._animator:Update(0)
		self._animator:Play("switch_left", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(self._switchfunc, self, self._animtime)
	end

	self:_btncancelOnClick()
	self:_refreshView()
end

function RougeTalentTreeView:_onSwitchTab()
	RougeTalentModel.instance:setCurrentSelectIndex(self._tabIndex)
	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, self._tabIndex)
end

function RougeTalentTreeView:_btnoverviewOnClick()
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function RougeTalentTreeView:_btnclickOnClick()
	self._isopentips = not self._isopentips

	gohelper.setActive(self._gotoprighttips, self._isopentips)
end

function RougeTalentTreeView:clickEmpty()
	if self._isopentips then
		self._isopentips = false

		gohelper.setActive(self._gotoprighttips, self._isopentips)
	end

	if self._isOpenDetail then
		self:_btncancelOnClick()
	end
end

function RougeTalentTreeView:_onClickTreeBranchItem(config)
	if not config then
		return
	end

	if self._currentSelectId ~= config.id and self._currentSelectId ~= nil then
		if not self._isOpenDetail then
			self._isOpenDetail = not self._isOpenDetail

			gohelper.setActive(self._godetail, self._isOpenDetail)
			gohelper.setActive(self._gopoint, not self._isOpenDetail)
			gohelper.setActive(self._btnoverview.gameObject, not self._isOpenDetail)
			self:_refreshDetail(config)
		else
			self._detailAnimator:Update(0)
			self._detailAnimator:Play("close", 0, 0)

			function self._onDetailCloseEnd()
				TaskDispatcher.cancelTask(self._onDetailCloseEnd, self)
				self:_refreshDetail(config)
				self._detailAnimator:Update(0)
				self._detailAnimator:Play("open", 0, 0)
			end

			local clsoetime = 0.2

			TaskDispatcher.runDelay(self._onDetailCloseEnd, self, clsoetime)
		end
	elseif not self._isOpenDetail then
		self._isOpenDetail = not self._isOpenDetail

		gohelper.setActive(self._godetail, self._isOpenDetail)
		gohelper.setActive(self._gopoint, not self._isOpenDetail)
		gohelper.setActive(self._btnoverview.gameObject, not self._isOpenDetail)
		self:_refreshDetail(config)
	end
end

function RougeTalentTreeView:_onDetailOpenEnd()
	return
end

function RougeTalentTreeView:_refreshDetail(config, geniusId)
	self._currentconfig = config

	if not self._currentSelectId then
		self._currentSelectId = config.id
	elseif self._currentSelectId ~= config.id then
		self._currentSelectId = config.id
		self._showDetailAnim = true
	end

	self._txtdetailname.text = config.name
	self._txtdetaildec.text = config.desc
	self._txtlack.text = config.cost

	local isLock = true

	if config.isOrigin == 1 then
		if config.id == RougeEnum.OutsideConst.StartNode then
			isLock = false
		else
			isLock = RougeTalentModel.instance:checkBigNodeLock(config.talent)
		end
	else
		isLock = RougeTalentModel.instance:checkNodeLock(config)
	end

	if not isLock then
		local isLight = RougeTalentModel.instance:checkNodeLight(config.id)

		gohelper.setActive(self._btnlocked.gameObject, false)
		gohelper.setActive(self._btnlack.gameObject, not isLight)
		gohelper.setActive(self._btncancel.gameObject, not isLight)

		local talentPoint = RougeTalentModel.instance:getTalentPoint()

		self._txtlack.color = talentPoint < config.cost and GameUtil.parseColor("#9F342C") or GameUtil.parseColor("#E99B56")
	else
		gohelper.setActive(self._btnlocked.gameObject, isLock)
		gohelper.setActive(self._btnlack.gameObject, not isLock)

		local isOrigin = config.isOrigin == 1

		gohelper.setActive(self._txtlocked.gameObject, not isOrigin)
		gohelper.setActive(self._txtlocked2.gameObject, isOrigin)

		if isOrigin then
			local co = RougeTalentConfig.instance:getConfigByTalent(self._season, config.talent)
			local allCost = RougeTalentModel.instance:getHadConsumeTalentPoint()
			local tag = {
				allCost,
				co.cost
			}

			self._txtlocked2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_origin"), tag)
		else
			self._txtlocked.text = luaLang("rouge_talenttree_normal")
		end
	end

	if geniusId then
		self._detailAnimator:Update(0)
		self._detailAnimator:Play("close", 0, 0)

		self._isOpenDetail = false

		gohelper.setActive(self._godetail, self._isOpenDetail)
		gohelper.setActive(self._gopoint, not self._isOpenDetail)
		gohelper.setActive(self._btnoverview.gameObject, not self._isOpenDetail)
	end
end

function RougeTalentTreeView:_editableInitView()
	function self._switchfunc()
		TaskDispatcher.cancelTask(self._switchfunc, self)
		RougeController.instance:dispatchEvent(RougeEvent.onSwitchTab, self._tabIndex)
	end
end

function RougeTalentTreeView:_refreshUI(geniusId)
	local currentco = self._configList[self._tabIndex]

	self._txttalentname.text = currentco.name
	self._txttalentdec.text = currentco.desc

	if self._tabIndex == 1 then
		gohelper.setActive(self._btnarrowleft.gameObject, false)
	else
		gohelper.setActive(self._btnarrowleft.gameObject, true)
	end

	if self._tabIndex == #self._configList then
		gohelper.setActive(self._btnarrowright.gameObject, false)
	else
		gohelper.setActive(self._btnarrowright.gameObject, true)
	end

	self._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	local maxtalentpoint = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	local getAllPoint = RougeTalentModel.instance:getHadAllTalentPoint()
	local param = {
		getAllPoint,
		maxtalentpoint
	}

	self._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), param)

	if geniusId then
		local config = RougeTalentConfig.instance:getBranchConfigByID(self._season, geniusId)

		self:_refreshDetail(config, geniusId)
	end
end

function RougeTalentTreeView:_refreshView()
	for index, point in ipairs(self._pointList) do
		if self._tabIndex ~= index then
			gohelper.setActive(point.light, false)
		else
			gohelper.setActive(point.light, true)
		end
	end

	self:_refreshUI()
end

function RougeTalentTreeView:onOpen()
	self._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTreeView)

	self._isOpenDetail = false

	gohelper.setActive(self._godetail, self._isOpenDetail)

	self._tabIndex = nil

	if self.viewParam then
		self._tabIndex = self.viewParam

		self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, self._tabIndex)
	end

	self._configList = RougeTalentConfig.instance:getRougeTalentDict(self._season)

	for index, value in ipairs(self._configList) do
		local point = self._pointList[index]

		if not point then
			point = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._gopointitem, "talent" .. index)

			point.go = go
			point.light = gohelper.findChild(go, "point_light")

			gohelper.setActive(go, true)
			table.insert(self._pointList, point)
		end

		if self._tabIndex ~= index then
			gohelper.setActive(point.light, false)
		else
			gohelper.setActive(point.light, true)
		end
	end

	self._animator:Update(0)
	self._animator:Play("open", 0, 0)
	self:_refreshUI()
end

function RougeTalentTreeView:exitTalentView()
	self._animator:Update(0)
	self._animator:Play("close", 0, 0)
end

function RougeTalentTreeView:onClose()
	return
end

function RougeTalentTreeView:onDestroyView()
	return
end

return RougeTalentTreeView
