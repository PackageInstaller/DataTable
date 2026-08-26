-- chunkname: @modules/logic/survival/view/shelter/ShelterRecruitView.lua

module("modules.logic.survival.view.shelter.ShelterRecruitView", package.seeall)

local ShelterRecruitView = class("ShelterRecruitView", BaseView)

function ShelterRecruitView:onInitView()
	self.goDemand = gohelper.findChild(self.viewGO, "Panel/#go_Demand")
	self.goTagItem = gohelper.findChild(self.viewGO, "Panel/#go_Demand/#scroll_List/Viewport/Content/#go_item")

	gohelper.setActive(self.goTagItem, false)

	self.txtDemandTips = gohelper.findChildTextMesh(self.viewGO, "Panel/#go_Demand/txt_Tips")
	self.goAnnounce = gohelper.findChild(self.viewGO, "Panel/#go_Demand/#go_Announce")
	self.btnRecuit = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_Demand/#go_Announce/#btn_Recruit")
	self.txtRecuitCost = gohelper.findChildTextMesh(self.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost")
	self.imageRecuitCost = gohelper.findChildImage(self.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost/#image_Currency")
	self.btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_Demand/#go_Announce/#btn_RefreshBtn")
	self.goStandby = gohelper.findChild(self.viewGO, "Panel/#go_Demand/#go_Standby")
	self.txtRefreshCost = gohelper.findChildTextMesh(self.viewGO, "Panel/#go_Demand/#go_Announce/RefreshCost")
	self.goMember = gohelper.findChild(self.viewGO, "Panel/#go_Member")
	self.goNpcItem = gohelper.findChild(self.viewGO, "Panel/#go_Member/#scroll_List/Viewport/#go_content/#go_item")

	gohelper.setActive(self.goNpcItem, false)

	self.btnMemberRecuit = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_Member/#btn_Recruit")
	self.btnCloseRecruit = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_Member/#btn_CloseRecruit")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_Close")
	self.tagList = {}
	self.npcList = {}
	self.selectTags = {}
	self.selectNpcId = 0
end

function ShelterRecruitView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addClickCb(self, self.btnRecuit, self.onClickBtnRecuit, self)
	self.addClickCb(self, self.btnRefresh, self.onClickBtnRefresh, self)
	self.addClickCb(self, self.btnMemberRecuit, self.onClickBtnMemberRecuit, self)
	self.addClickCb(self, self.btnCloseRecruit, self.onClickBtnCloseRecruit, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, self.onRecruitDataUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, self.onRecruitRefresh, self)
end

function ShelterRecruitView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnRecuit)
	self:removeClickCb(self.btnRefresh)
	self:removeClickCb(self.btnMemberRecuit)
	self:removeClickCb(self.btnCloseRecruit)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, self.onRecruitDataUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, self.onRecruitRefresh, self)
end

function ShelterRecruitView:onClickClose()
	self:closeThis()
end

function ShelterRecruitView:onRecruitRefresh()
	for i, v in ipairs(self.tagList) do
		v.animator:Play(UIAnimationName.Switch, 0, 0)
	end

	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function ShelterRecruitView:onShelterBagUpdate()
	self:refreshView()
end

function ShelterRecruitView:onClickBtnRecuit()
	if not self.recruitInfo or not self.recruitInfo:isCanRecruit() then
		return
	end

	local config = self.recruitInfo.config

	if not config then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local isEnough, itemId, costCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(config.cost)

	if not isEnough then
		local itemConfig = lua_survival_item.configDict[itemId]

		GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

		return
	end

	local selectCount = self.recruitInfo.selectCount
	local hasSelectCount = tabletool.len(self.selectTags)

	if hasSelectCount == 0 or hasSelectCount ~= selectCount then
		GameFacade.showToast(ToastEnum.ShelterRecruitSelectNotEnough)

		return
	end

	local tagIds = {}

	for k, v in pairs(self.selectTags) do
		table.insert(tagIds, k)
	end

	SurvivalWeekRpc.instance:sendSurvivalPublishRecruitTagRequest(tagIds)
end

function ShelterRecruitView:onClickBtnRefresh()
	if not self.recruitInfo then
		return
	end

	if self.recruitInfo.canRefreshTimes == 0 then
		local config = self.recruitInfo.config
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local isEnough, itemId = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(config and config.refreshCost)

		if not isEnough then
			local itemConfig = lua_survival_item.configDict[itemId]

			GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

			return
		end
	end

	SurvivalWeekRpc.instance:sendSurvivalRefreshRecruitTagRequest()
end

function ShelterRecruitView:onClickBtnMemberRecuit()
	if self.selectNpcId == nil or self.selectNpcId == 0 then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRecruitNpcRequest(self.selectNpcId, self.onSurvivalRecruitNpc, self)
end

function ShelterRecruitView:onSurvivalRecruitNpc(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local itemMo = SurvivalBagItemMo.New()

	itemMo:init({
		count = 1,
		id = self.selectNpcId
	})

	itemMo.source = SurvivalEnum.ItemSource.Drop

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
		items = {
			itemMo
		}
	})
	self:closeThis()
end

function ShelterRecruitView:onClickBtnCloseRecruit()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalAbandonRecruitNpc, MsgBoxEnum.BoxType.Yes_No, self._sendAbandonRecruitNpc, nil, nil, self, nil, nil)
end

function ShelterRecruitView:_sendAbandonRecruitNpc()
	SurvivalWeekRpc.instance:sendSurvivalAbandonRecruitNpcRequest()
	self:closeThis()
end

function ShelterRecruitView:onClickTag(tag)
	if not self.recruitInfo then
		return
	end

	local tagId = tag.tagId

	if tagId == nil or tagId == 0 then
		return
	end

	local isCanRecruit = self.recruitInfo:isCanRecruit()

	if not isCanRecruit then
		return
	end

	local isSelect = self.selectTags[tagId] ~= nil

	if isSelect then
		self.selectTags[tagId] = nil
	else
		local selectCount = self.recruitInfo.selectCount
		local hasSelectCount = tabletool.len(self.selectTags)

		if selectCount == hasSelectCount then
			return
		end

		self.selectTags[tagId] = true
	end

	self:refreshTagList()
end

function ShelterRecruitView:onClickNpc(item)
	if not item.data then
		return
	end

	local npcId = item.data.npcId
	local isSelect = npcId == self.selectNpcId

	self.selectNpcId = isSelect and 0 or npcId

	self:refreshNpcList()
end

function ShelterRecruitView:onRecruitDataUpdate()
	self:refreshView()
end

function ShelterRecruitView:onOpen()
	self:refreshView()
end

function ShelterRecruitView:refreshView()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.recruitInfo = weekInfo:getRecruitInfo()

	if not self.recruitInfo then
		return
	end

	local isCanSelectNpc = self.recruitInfo:isCanSelectNpc()

	gohelper.setActive(self.goDemand, not isCanSelectNpc)
	gohelper.setActive(self.goMember, isCanSelectNpc)

	if isCanSelectNpc then
		self:refreshMemberView()
	else
		self:refreshDemandView()
	end
end

function ShelterRecruitView:refreshDemandView()
	local isCanRecruit = self.recruitInfo:isCanRecruit()

	if isCanRecruit then
		gohelper.setActive(self.goStandby, false)
		gohelper.setActive(self.goAnnounce, true)
		self:refreshDemandButton()
	else
		gohelper.setActive(self.goStandby, true)
		gohelper.setActive(self.goAnnounce, false)
	end

	local selectedTags = self.recruitInfo.selectedTags

	self.selectTags = {}

	for i, v in ipairs(selectedTags) do
		self.selectTags[v] = true
	end

	self:refreshTagList()
end

function ShelterRecruitView:refreshDemandButton()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local config = self.recruitInfo.config
	local canRefreshTimes = self.recruitInfo.canRefreshTimes
	local hasFree = canRefreshTimes > 0

	gohelper.setActive(self.txtRefreshCost, not hasFree)

	if not hasFree then
		local isEnough, itemId, costCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(config and config.refreshCost)

		self.txtRefreshCost.text = isEnough and tostring(costCount) or string.format("<color=#D74242>%s</color>", costCount)
	end

	local isEnough, itemId, costCount, curCount = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(config and config.cost)

	self.txtRecuitCost.text = isEnough and tostring(costCount) or string.format("<color=#D74242>%s</color>", costCount)
end

function ShelterRecruitView:refreshTagList()
	local selectCount = self.recruitInfo.selectCount
	local hasSelectCount = tabletool.len(self.selectTags)
	local isInRecruit = self.recruitInfo:isInRecruit()
	local isSelectFull = selectCount == hasSelectCount or isInRecruit
	local tags = self.recruitInfo.tags

	for i = 1, math.max(#tags, #self.tagList) do
		local item = self:getTagItem(i)

		self:refreshTagItem(item, tags[i], isSelectFull)
	end

	if isInRecruit then
		self.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_menber_tips"), hasSelectCount, selectCount)
	else
		self.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_demand_tips"), hasSelectCount, selectCount)

		ZProj.UGUIHelper.SetGrayscale(self.btnRecuit.gameObject, not isSelectFull)
	end
end

function ShelterRecruitView:getTagItem(index)
	local tag = self.tagList[index]

	if not tag then
		tag = self:getUserDataTb_()
		tag.go = gohelper.cloneInPlace(self.goTagItem, tostring(index))
		tag.imageBg = gohelper.findChildImage(tag.go, "#image_BG")
		tag.goSelect = gohelper.findChild(tag.go, "#go_Selected")
		tag.txtTile = gohelper.findChildTextMesh(tag.go, "#txt_Title")
		tag.txtDesc = gohelper.findChildTextMesh(tag.go, "#txt_Descr")
		tag.canvasGroup = gohelper.onceAddComponent(tag.go, typeof(UnityEngine.CanvasGroup))
		tag.goMask = gohelper.findChild(tag.go, "mask")
		tag.btn = gohelper.findChildButtonWithAudio(tag.go, "Click")

		tag.btn:AddClickListener(self.onClickTag, self, tag)

		tag.animator = tag.go:GetComponent(gohelper.Type_Animator)
		self.tagList[index] = tag
	end

	return tag
end

function ShelterRecruitView:refreshTagItem(tag, tagId, isSelectFull)
	tag.tagId = tagId

	if not tagId then
		gohelper.setActive(tag.go, false)

		return
	end

	gohelper.setActive(tag.go, true)

	local config = SurvivalConfig.instance:getTagCo(tagId)

	if not config then
		return
	end

	tag.txtTile.text = config.name
	tag.txtDesc.text = config.desc

	local isSelect = self.selectTags[tagId]

	gohelper.setActive(tag.goSelect, isSelect)

	local alpha = isSelectFull and not isSelect and 0.5 or 1

	tag.canvasGroup.alpha = alpha

	gohelper.setActive(tag.goMask, alpha ~= 1)
	UISpriteSetMgr.instance:setSurvivalSprite(tag.imageBg, string.format("survivalshelterrecruit_charbg%s", config.color))
end

function ShelterRecruitView:refreshMemberView()
	self.selectNpcId = 0

	self:refreshNpcList()
end

function ShelterRecruitView:refreshNpcList()
	local list = self.recruitInfo.goodList

	for i = 1, math.max(#list, #self.npcList) do
		local item = self:getNpcItem(i)

		self:refreshNpcItem(item, list[i])
	end

	local hasSelelct = self.selectNpcId ~= nil and self.selectNpcId ~= 0

	ZProj.UGUIHelper.SetGrayscale(self.btnMemberRecuit.gameObject, not hasSelelct)
end

function ShelterRecruitView:getNpcItem(index)
	local item = self.npcList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.goNpcItem, tostring(index))
		item.imageChess = gohelper.findChildSingleImage(item.go, "#image_Chess")
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_PartnerName")
		item.goSelect = gohelper.findChild(item.go, "#go_Selected")
		item.goAttrItem = gohelper.findChild(item.go, "Scroll View/Viewport/#go_content/#go_Attr")

		gohelper.setActive(item.goAttrItem, false)

		item.attrItemList = {}
		item.btn = gohelper.findChildButtonWithAudio(item.go, "")

		item.btn:AddClickListener(self.onClickNpc, self, item)

		self.npcList[index] = item
	end

	return item
end

function ShelterRecruitView:refreshNpcItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local npcId = data.npcId
	local npcConfig = SurvivalConfig.instance:getNpcConfig(npcId)

	gohelper.setActive(item.goSelect, npcId == self.selectNpcId)

	if not npcConfig then
		return
	end

	item.txtName.text = npcConfig.name

	SurvivalUnitIconHelper.instance:setNpcIcon(item.imageChess, npcConfig.headIcon)

	local _, tagList = SurvivalConfig.instance:getNpcConfigTag(npcId)

	for i = 1, math.max(#tagList, #item.attrItemList) do
		local attrItem = self:getNpcAttrItem(item, i)

		self:refreshNpcAttrItem(attrItem, tagList[i])
	end
end

function ShelterRecruitView:getNpcAttrItem(item, index)
	local attrItem = item.attrItemList[index]

	if not attrItem then
		attrItem = self:getUserDataTb_()
		attrItem.go = gohelper.cloneInPlace(item.goAttrItem, tostring(index))
		attrItem.txtTitle = gohelper.findChildTextMesh(attrItem.go, "image_TitleBG/#txt_Title")
		attrItem.txtDesc = gohelper.findChildTextMesh(attrItem.go, "")
		attrItem.imgTitle = gohelper.findChildImage(attrItem.go, "image_TitleBG")
		item.attrItemList[index] = attrItem
	end

	return attrItem
end

function ShelterRecruitView:refreshNpcAttrItem(item, tagId)
	if not tagId then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = lua_survival_tag.configDict[tagId]

	item.txtTitle.text = config.name
	item.txtDesc.text = config.desc

	UISpriteSetMgr.instance:setSurvivalSprite(item.imgTitle, string.format("survivalpartnerteam_attrbg%s", config.color))
end

function ShelterRecruitView:onDestroyView()
	for _, v in pairs(self.tagList) do
		v.btn:RemoveClickListener()
	end

	for _, v in pairs(self.npcList) do
		v.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.refreshView, self)
end

return ShelterRecruitView
