-- chunkname: @modules/logic/rouge/view/RougeCollectionGiftView.lua

module("modules.logic.rouge.view.RougeCollectionGiftView", package.seeall)

local RougeCollectionGiftView = class("RougeCollectionGiftView", BaseView)

function RougeCollectionGiftView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "#simage_maskbg")
	self._gorougepageprogress = gohelper.findChild(self.viewGO, "#go_rougepageprogress")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._btnemptyBlock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBlock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionGiftView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnemptyBlock:AddClickListener(self._btnemptyBlockOnClick, self)
end

function RougeCollectionGiftView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnemptyBlock:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper

RougeCollectionGiftView.Type = {
	DropGroup = 2,
	Drop = 1,
	None = 0
}

function RougeCollectionGiftView:_btnstartOnClick()
	self:_submitFunc()
end

function RougeCollectionGiftView:_btnemptyBlockOnClick()
	self:setActiveBlock(false)
end

function RougeCollectionGiftView:_editableInitView()
	self._btnemptyBlockGo = self._btnemptyBlock.gameObject
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._tipsText = gohelper.findChildText(self.viewGO, "tips")
	self._scrollViewGo = self._scrollview.gameObject
	self._scrollViewLimitScrollCmp = self._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	self._scrollViewTrans = self._scrollViewGo.transform
	self._btnstartGo = self._btnstart.gameObject
	self._collectionObjList = {}

	self:_initPageProgress()
end

function RougeCollectionGiftView:onUpdateParam()
	self:_refresh()
end

function RougeCollectionGiftView:onOpen()
	self._isBlocked = nil
	self._hasSelectedCount = 0
	self._hasSelectedIndexDict = {}

	self:_setActiveBtn(false)
	self:onUpdateParam()

	self._tipsText.text = string.format(luaLang("rougecollectiongiftview_txt_tips"), self:_selectRewardNum())

	self.viewContainer:registerCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, self._onSelectIndexByUser, self)
end

function RougeCollectionGiftView:onOpenFinish()
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	gohelper.setActive(self._gocollectionitem, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function RougeCollectionGiftView:onClose()
	self:_killTween()
	self.viewContainer:unregisterCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, self._onSelectIndexByUser, self)
	GameUtil.onDestroyViewMemberList(self, "_collectionObjList")
end

function RougeCollectionGiftView:onDestroyView()
	return
end

function RougeCollectionGiftView:_refresh()
	self:_refreshList()
	self:_refreshConfirmBtn()
end

function RougeCollectionGiftView:_refreshConfirmBtn()
	local isActive = self._hasSelectedCount == self:_selectRewardNum()

	gohelper.setActive(self._btnstartGo, isActive)
	self:_tweenTipsText(not isActive)
end

local kTweenTipsTextDuration = 0.4

function RougeCollectionGiftView:_tweenTipsText(isActive)
	self:_killTween()

	local toAlpha = isActive and 1 or 0
	local fromAlpha = self._tipsText.alpha

	self._tweenId = csTweenHelper.DoFade(self._tipsText, fromAlpha, toAlpha, kTweenTipsTextDuration, nil, nil, nil, EaseType.OutQuad)
end

function RougeCollectionGiftView:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
end

function RougeCollectionGiftView:_refreshList()
	local rewardList = self:_getRewardList()

	for i, data in ipairs(rewardList) do
		local item

		if i > #self._collectionObjList then
			item = self:_create_RougeCollectionGiftViewItem(i)

			table.insert(self._collectionObjList, item)
		else
			item = self._collectionObjList[i]
		end

		item:onUpdateMO(data)
		item:setActive(true)
		item:setSelected(self._hasSelectedIndexDict[i] and true or false)
	end

	for i = #rewardList + 1, #self._collectionObjList do
		local item = self._collectionObjList[i]

		item:setActive(false)
	end
end

function RougeCollectionGiftView:_getRewardList()
	self._tmpRewardList = self._tmpRewardList or self:_rewardList()

	return self._tmpRewardList
end

function RougeCollectionGiftView:_create_RougeCollectionGiftViewItem(index)
	local go = gohelper.cloneInPlace(self._gocollectionitem)
	local item = RougeCollectionGiftViewItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function RougeCollectionGiftView:_setActiveBtn(isActive)
	gohelper.setActive(self._btnstartGo, isActive)
end

function RougeCollectionGiftView:_initPageProgress()
	local itemClass = RougePageProgress
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, self._gorougepageprogress, itemClass.__cname)

	self._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._pageProgress:setData()
end

function RougeCollectionGiftView:_selectRewardNum()
	if not self.viewParam then
		return self:_getRougeSelectRewardNum()
	end

	return self.viewParam.selectRewardNum or self:_getRougeSelectRewardNum()
end

function RougeCollectionGiftView:_rewardList()
	if not self.viewParam then
		return self:_getRougeLastRewardList()
	end

	return self.viewParam.rewardList or self:_getRougeLastRewardList()
end

function RougeCollectionGiftView:_submitFunc()
	if not self.viewParam then
		self:_defaultSubmitFunc()

		return
	end

	if self.viewParam.submitFunc then
		self.viewParam.submitFunc(self)
	else
		self:_defaultSubmitFunc()
	end
end

function RougeCollectionGiftView:_getRougeSelectRewardNum()
	return RougeModel.instance:getSelectRewardNum() or 0
end

function RougeCollectionGiftView:_getRougeLastRewardList()
	local lastReward = RougeModel.instance:getLastRewardList()
	local list = {}

	if not lastReward or #lastReward == 0 then
		return list
	end

	local cfg = RougeOutsideModel.instance:config()

	for _, v in ipairs(lastReward) do
		local id = v.id
		local param = v.param
		local lastRewardCO = cfg:getLastRewardCO(id)
		local type = lastRewardCO.type
		local item = {
			title = "",
			id = id,
			descList = {},
			type = RougeCollectionGiftView.Type.unknown
		}

		if type == "drop" then
			item.type = RougeCollectionGiftView.Type.Drop
			item.title = lastRewardCO.title

			table.insert(item.descList, lastRewardCO.desc)

			item.resUrl = ResUrl.getRougeSingleBgCollection(lastRewardCO.iconName)
		elseif type == "dropGroup" then
			item.type = RougeCollectionGiftView.Type.DropGroup
			item.resUrl = nil
			item.title = lastRewardCO.title
			item.data = {}

			local collectionIds = string.splitToNumber(param, "#")

			item.data.collectionId = collectionIds[1]

			for _, collectionId in ipairs(collectionIds) do
				local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionId)

				if item.resUrl == nil and not string.nilorempty(collectionCfg.iconPath) then
					item.resUrl = ResUrl.getRougeSingleBgCollection(collectionCfg.iconPath)
				end

				local effectDescList, effectDescIdList = RougeCollectionConfig.instance:getCollectionEffectsInfo(collectionId)

				for _, desc in ipairs(effectDescList) do
					table.insert(item.descList, HeroSkillModel.instance:skillDesToSpot(desc))
				end

				for _, effectDescId in ipairs(effectDescIdList) do
					local effectCfg = SkillConfig.instance:getSkillEffectDescCo(effectDescId)
					local desc = RougeCollectionHelper.instance:getHeroSkillDesc(effectCfg.name, effectCfg.desc)

					table.insert(item.descList, HeroSkillModel.instance:skillDesToSpot(desc))
				end
			end
		else
			local errMsg = string.format("[RougeInfoMO:getLastRewardList] unsupported error type=%s, id=%s", type, id)

			logError(errMsg)
		end

		table.insert(list, item)
	end

	return list
end

function RougeCollectionGiftView:_isSingleSelect()
	return self:_selectRewardNum() == 1
end

function RougeCollectionGiftView:_onSelectIndexByUser(index)
	if self:_isSingleSelect() then
		self:_onSelectIndex_SingleSelect(index)
	else
		self:_onSelectIndex_MultiSelect(index)
	end
end

function RougeCollectionGiftView:_onSelectIndex_SingleSelect(index)
	local curItem = self._collectionObjList[index]

	if self._hasSelectedIndexDict[index] then
		return
	end

	local lastIndex, _ = next(self._hasSelectedIndexDict)

	if lastIndex then
		self._hasSelectedIndexDict[lastIndex] = nil

		local lastItem = self._collectionObjList[lastIndex]

		lastItem:setSelected(false)
	end

	curItem:setSelected(true)

	self._hasSelectedIndexDict[index] = true
	self._hasSelectedCount = math.min(1, self._hasSelectedCount + 1)

	self:_refreshConfirmBtn()
end

function RougeCollectionGiftView:_onSelectIndex_MultiSelect(index)
	local curItem = self._collectionObjList[index]

	if self._hasSelectedIndexDict[index] then
		self._hasSelectedIndexDict[index] = false
		self._hasSelectedCount = self._hasSelectedCount - 1

		curItem:setSelected(false)
		self:_refreshConfirmBtn()

		return
	end

	if self._hasSelectedCount >= self:_selectRewardNum() then
		GameFacade.showToast(ToastEnum.RougeCollectionGiftView_ReachMaxSelectedCount)

		return
	end

	curItem:setSelected(true)

	self._hasSelectedIndexDict[index] = true
	self._hasSelectedCount = self._hasSelectedCount + 1

	self:_refreshConfirmBtn()
end

local kBlockKey = "RougeCollectionGiftView:_defaultSubmitFunc"

function RougeCollectionGiftView:_defaultSubmitFunc()
	UIBlockHelper.instance:startBlock(kBlockKey, 1, self.viewName)

	local season = RougeOutsideModel.instance:season()
	local rewardId = {}
	local rewardList = self:_getRewardList()

	for index, bool in pairs(self._hasSelectedIndexDict) do
		local data = rewardList[index]
		local id = data.id

		if bool then
			table.insert(rewardId, id)
		end
	end

	RougeRpc.instance:sendEnterRougeSelectRewardRequest(season, rewardId, function(_, resultCode)
		if resultCode ~= 0 then
			logError("RougeCollectionGiftView:_defaultSubmitFunc resultCode=" .. tostring(resultCode))

			return
		end

		UIBlockHelper.instance:endBlock(kBlockKey)
		RougeController.instance:openRougeFactionView()
	end)
end

function RougeCollectionGiftView:getScrollViewGo()
	return self._scrollViewGo
end

function RougeCollectionGiftView:getScrollRect()
	return self._scrollViewLimitScrollCmp
end

function RougeCollectionGiftView:setActiveBlock(isActive)
	if self._isBlocked == isActive then
		return
	end

	self._isBlocked = isActive

	gohelper.setActive(self._btnemptyBlockGo, isActive)

	if not isActive then
		for _, item in ipairs(self._collectionObjList) do
			item:onCloseBlock()
		end
	end
end

return RougeCollectionGiftView
