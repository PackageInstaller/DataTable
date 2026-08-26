-- chunkname: @modules/logic/seasonver/act166/view/talent/Season166TalentView.lua

module("modules.logic.seasonver.act166.view.talent.Season166TalentView", package.seeall)

local Season166TalentView = class("Season166TalentView", BaseView)

function Season166TalentView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166TalentView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.SetTalentSkill, self._refreshTalentSlot, self)
end

function Season166TalentView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.SetTalentSkill, self._refreshTalentSlot, self)
end

function Season166TalentView:_editableInitView()
	self._actId = Season166Model.instance:getCurSeasonId()

	self:_initTalent()
end

function Season166TalentView:onUpdateParam()
	return
end

function Season166TalentView:onOpen()
	self.actId = Season166Model.instance:getCurSeasonId()

	self:_refreshUI()
	self:refreshReddot()
end

function Season166TalentView:_initTalent()
	local talentCfgList = {}
	local talentList = lua_activity166_talent.configList

	for _, cfg in ipairs(talentList) do
		if cfg.activityId == self._actId then
			talentCfgList[#talentCfgList + 1] = cfg
		end
	end

	self.talentItemDic = {}

	for i = 1, #talentCfgList do
		local go = gohelper.findChild(self.viewGO, "root/talents/talent" .. i)

		if not gohelper.isNil(go) then
			local talentItem = self:getUserDataTb_()

			talentItem.config = talentCfgList[i]

			local talentId = talentItem.config.talentId
			local btnClick = gohelper.findChildButtonWithAudio(go, "up")
			local txtName = gohelper.findChildText(go, "up/txt_talentName")

			txtName.text = talentItem.config.name

			local txtNameEn = gohelper.findChildText(go, "up/en")

			txtNameEn.text = talentItem.config.nameEn
			talentItem.goEquip = gohelper.findChild(go, "go_Equip")
			talentItem.btnEquip = gohelper.findChildButtonWithAudio(go, "go_Equip/btn_equip")
			talentItem.btnLock = gohelper.findChildButtonWithAudio(go, "go_Equip/locked")
			talentItem.goequiping = gohelper.findChild(go, "go_Equip/go_equiping")
			talentItem.reddotGO = gohelper.findChild(go, "reddot")
			talentItem.goslot1 = gohelper.findChild(go, "equipslot/1")
			talentItem.goslotLight1 = gohelper.findChild(go, "equipslot/1/light")
			talentItem.goslot2 = gohelper.findChild(go, "equipslot/2")
			talentItem.goslotLight2 = gohelper.findChild(go, "equipslot/2/light")
			talentItem.goslot3 = gohelper.findChild(go, "equipslot/3")
			talentItem.goslotLight3 = gohelper.findChild(go, "equipslot/3/light")
			talentItem.anim = go:GetComponent(gohelper.Type_Animator)

			self.addClickCb(self, btnClick, self._clickTalent, self, talentId)
			self.addClickCb(self, talentItem.btnEquip, self._clickEquip, self, talentId)
			self.addClickCb(self, talentItem.btnLock, self._clickLock, self)

			self.talentItemDic[talentId] = talentItem
		end
	end
end

function Season166TalentView:_clickTalent(talentId)
	ViewMgr.instance:openView(ViewName.Season166TalentSelectView, {
		talentId = talentId
	})
end

function Season166TalentView:_clickEquip(talentId)
	local selectTalentId = Season166Model.getPrefsTalent()

	if selectTalentId == talentId then
		return
	end

	Season166Model.setPrefsTalent(talentId)
	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentId, talentId)
	self:_refreshEquipBtn()
end

function Season166TalentView:_clickLock()
	GameFacade.showToast(ToastEnum.Season166TalentLock)
end

function Season166TalentView:_refreshUI()
	self:_refreshTalentSlot()

	if self.viewParam then
		if self.viewParam then
			self:_refreshEquipBtn()
		end

		for _, talentItem in pairs(self.talentItemDic) do
			gohelper.setActive(talentItem.goEquip, self.viewParam)
		end
	end
end

function Season166TalentView:_refreshEquipBtn()
	if not self.viewParam.talentId then
		local talentId = Season166Model.getPrefsTalent()

		for id, talentItem in pairs(self.talentItemDic) do
			if self.viewParam.talentId then
				gohelper.setActive(talentItem.btnEquip, false)
				gohelper.setActive(talentItem.goequiping, id == talentId)
				gohelper.setActive(talentItem.btnLock, id ~= talentId)
			else
				gohelper.setActive(talentItem.btnEquip, id ~= talentId)
				gohelper.setActive(talentItem.goequiping, id == talentId)
				gohelper.setActive(talentItem.btnLock, false)
			end

			local animName = id == talentId and "start" or "idle"

			talentItem.anim:Play(animName)
		end
	end
end

function Season166TalentView:_refreshTalentSlot()
	for talentId, talentItem in pairs(self.talentItemDic) do
		local talentInfo = Season166Model.instance:getTalentInfo(self.actId, talentId)
		local slotNum = talentInfo.config.slot
		local skillIds = talentInfo.skillIds

		for i = 1, 3 do
			local key = "goslot" .. i

			gohelper.setActive(talentItem[key], i <= slotNum)

			if i <= slotNum then
				local lightKey = "goslotLight" .. i

				gohelper.setActive(talentItem[lightKey], i <= #skillIds)
			end
		end
	end
end

function Season166TalentView:refreshReddot()
	local talentConfigList = lua_activity166_talent.configDict[self._actId]

	for _, talentCo in pairs(talentConfigList) do
		local reddotGO = self.talentItemDic[talentCo.talentId].reddotGO

		gohelper.setActive(reddotGO, Season166Model.instance:checkHasNewTalent(talentCo.talentId))
	end
end

function Season166TalentView:checkTalentReddotShow(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local talentId = redDotIcon.infoDict[RedDotEnum.DotNode.Season166Talent]

	redDotIcon.show = Season166Model.instance:checkHasNewTalent(talentId)

	if redDotIcon.show then
		redDotIcon:showRedDot(RedDotEnum.Style.Green)
	end
end

function Season166TalentView:_onCloseView(viewName)
	if viewName == ViewName.Season166TalentSelectView then
		self:refreshReddot()
	end
end

return Season166TalentView
