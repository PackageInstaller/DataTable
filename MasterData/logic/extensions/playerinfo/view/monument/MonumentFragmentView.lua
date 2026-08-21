-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentFragmentView.lua

module("logic.extensions.playerinfo.view.monument.MonumentFragmentView", package.seeall)

local M = class("MonumentFragmentView", PlayerInfoBaseFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local mainGo = self._registry:getMainGO()
	local monumentScrollGo = goutil.findChild(mainGo, "syndromeCardScroll")

	self._showItem = goutil.findChild(mainGo, "syndromeCardScroll/syndrome_card_item_copy")
	self._offset = goutil.findChild(mainGo, "syndromeCardScroll/viewPort/content")
	self._node = goutil.findChild(mainGo, "node")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))
	self._loopGridHelper = LoopGridViewHelper.New(monumentScrollGo)

	self._loopGridHelper:InitGridView(0, self._onCellUpdate, self)

	self._txtName = self._registry:getText("syndrome_card_panel_copy_1900836124")
	self._imgFill = self._registry:getImage("syndrome_card_panel_copy_-1209622706")
	self._txtLv1 = self._registry:getText("syndrome_card_panel_copy_1395023169")
	self._txtLv2 = self._registry:getText("syndrome_card_panel_copy_517780921")
	self._txtContent = self._registry:getText("syndrome_card_panel_copy_-48308326")
	self._txtTime = self._registry:getText("syndrome_card_panel_copy_1247718171")
	self._txtDesc = self._registry:getText("syndrome_card_panel_copy_-1937261755")

	local lightGo1 = self._registry:getGo("syndrome_card_panel_copy_-323301894")
	local lightGo2 = self._registry:getGo("syndrome_card_panel_copy_1634132392")
	local lightGo3 = self._registry:getGo("syndrome_card_panel_copy_-651889919")
	local lightGo4 = self._registry:getGo("syndrome_card_panel_copy_1185791107")

	self._ligthGos = {
		lightGo1,
		lightGo2,
		lightGo3,
		lightGo4
	}

	local txtRate1 = goutil.findChildTextComponent(lightGo1, "txtRate")
	local txtRate2 = goutil.findChildTextComponent(lightGo2, "txtRate")
	local txtRate3 = goutil.findChildTextComponent(lightGo3, "txtRate")
	local txtRate4 = goutil.findChildTextComponent(lightGo4, "txtRate")

	self._rateTxts = {
		txtRate1,
		txtRate2,
		txtRate3,
		txtRate4
	}
	self._showView = Astral.LuaComponentContainer.Add(self._showItem, MonumentItemCell)
end

function M:destroyUI()
	self._loopGridHelper = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.CHANGE_MONUMENTS_EVENT, self._onChangeMonuments, self)
	GlobalDispatcher:addEventListener(EventType.UPDATA_MONUMENT, self._refresh, self)
	GlobalDispatcher:addEventListener(EventType.RED_DOT_VIEW_EVENT, self._refresh, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_MOUNMENT_REFRESH, self._onClickItem, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_MONUMENTS_EVENT, self._onChangeMonuments, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATA_MONUMENT, self._refresh, self)
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_VIEW_EVENT, self._refresh, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_MOUNMENT_REFRESH, self._onClickItem, self)
end

function M:onEnter()
	self._refresh()

	local newCups = Astral.LocalStorage.Instance:GetString("NEW_CUP")
	local upgradeCups = Astral.LocalStorage.Instance:GetString("UPGRADE_CUP")
	local recordId = Astral.LocalStorage.Instance:GetString("MONUMENT_PLAYER_ID")

	self._upgradeHintStatus = {}

	if recordId == PlayerModel.instance:getId() and newCups ~= "" then
		newCups = string.split(newCups, ",")

		MonumentModel.instance:setNewCups(newCups)
	end

	if recordId == PlayerModel.instance:getId() and upgradeCups ~= "" then
		upgradeCups = string.split(upgradeCups, ",")

		MonumentModel.instance:setUpgradeCups(upgradeCups)
		self:_setUpgradeMap(upgradeCups)
	end

	local finished = MonumentModel.instance:getFinishedMonuments()

	goutil.setActive(self._node, #finished > 0)

	if #finished > 0 then
		self._syndromeCards = MonumentModel.instance:getMonumentListModel():getMoList()

		self:_onClickItem(_, 1)
		self._loopGridHelper:SetListItemCount(#self._syndromeCards, false)
		self._loopGridHelper:RefreshAllShownItem()
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
	end
end

function M:onExit()
	goutil.setActive(self._showItem, false)

	self._upgradeHintStatus = {}

	MonumentModel.instance:setNewCups(false)
	MonumentModel.instance:setUpgradeCups(false)

	local recordId = Astral.LocalStorage.Instance:GetString("MONUMENT_PLAYER_ID")

	if string.nilorempty(recordId) or recordId == PlayerModel.instance:getId() then
		Astral.LocalStorage.Instance:SetString("NEW_CUP", "")
		Astral.LocalStorage.Instance:SetString("UPGRADE_CUP", "")
	end
end

function M:_setUpgradeMap(cups)
	self._upgradeHintStatus = {}

	for _, v in ipairs(cups) do
		self._upgradeHintStatus[v] = true
	end
end

function M:_onClickItem(_, index)
	self._curSelect = index

	local mo = self._syndromeCards[index]

	self:showMonumentInfo(mo)
	self._loopGridHelper:RefreshAllShownItem()
end

function M:showMonumentInfo(monumentMo)
	local maxLevel = MonumentModel.instance:getMaxLevel(monumentMo:getNo())

	self._txtName.text = monumentMo:getName()
	self._txtLv1.text = monumentMo:getLv()
	self._txtLv2.text = "/" .. maxLevel

	if monumentMo:getIsFinish() then
		self._txtTime.gameObject:SetActive(true)

		local dateStr = TimeUtil.instance:stampToDateStr(monumentMo:getObtTime())

		self._txtTime.text = dateStr
	else
		self._txtTime.gameObject:SetActive(false)
	end

	local tempStr = string.format("（%d/%d）", monumentMo:getUpgradeFinishCnt(), monumentMo:getUpgradeMaxCnt())

	self._imgFill.fillAmount = monumentMo:getUpgradeFinishCnt() / monumentMo:getUpgradeMaxCnt()

	if monumentMo:getIsNoShow() and not monumentMo:getIsFinish() then
		self._txtContent.text = TextUtils.GetPunctuationFixedText("???" .. tempStr, self._txtContent, 0, 200)
		self._txtDesc.text = "???"
	else
		self._txtContent.text = TextUtils.GetPunctuationFixedText(monumentMo:getUpgradeDesc() .. tempStr, self._txtContent, 0, 200)
		self._txtDesc.text = monumentMo:getCupDesc()
	end

	local rate = monumentMo:getRate() * 100

	if rate < 0.01 then
		rate = 0.01
	end

	local rateStr = string.format("%.2f%%", rate)
	local layer = self:_getRateLayer(monumentMo:getRate())

	for i = 1, #self._rateTxts do
		self._rateTxts[i].text = rateStr

		goutil.setActive(self._rateTxts[i].gameObject, i == layer)
	end

	for i = 1, #self._ligthGos do
		goutil.setActive(self._ligthGos[i], i == layer)
	end
end

function M:_getRateLayer(rate)
	local layer = 1

	layer = rate >= 0 and rate <= 0.25 and 1 or rate > 0.25 and rate <= 0.5 and 2 or rate > 0.5 and rate <= 0.75 and 3 or 4

	return layer
end

function M:_onChangeMonuments(_, ids)
	MonumentModel.instance:updateMonumentListModel(ids)

	local count = MonumentModel.instance:getMonumentListModel():getMoCount()
end

function M:_refresh()
	local ids = MonumentModel.instance:getAllMonumentIds()

	MonumentModel.instance:updateMonumentListModel(ids)
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridHelper:NewListViewItem("syndrome_card_item_copy")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, MonumentItemCell)
	local monumentMo = self._syndromeCards[curIndex]

	view:updateData(monumentMo, self._upgradeHintStatus[tostring(monumentMo:getId())], self._curSelect)

	return item
end

return M
