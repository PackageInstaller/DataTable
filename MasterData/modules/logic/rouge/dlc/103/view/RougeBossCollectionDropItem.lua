-- chunkname: @modules/logic/rouge/dlc/103/view/RougeBossCollectionDropItem.lua

module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropItem", package.seeall)

local RougeBossCollectionDropItem = class("RougeBossCollectionDropItem", UserDataDispose)

function RougeBossCollectionDropItem:init(go, parent)
	self:__onInit()

	self.go = go
	self.parent = parent

	self:_editableInitView()
end

function RougeBossCollectionDropItem:_editableInitView()
	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._goenchantlist = gohelper.findChild(self.go, "#go_enchantlist")
	self._gohole = gohelper.findChild(self.go, "#go_enchantlist/#go_hole")
	self._gridLayout = gohelper.findChild(self.go, "Grid")
	self._gogriditem = gohelper.findChild(self.go, "Grid/#go_grid")
	self._simagecollection = gohelper.findChildSingleImage(self.go, "#simage_collection")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._scrollreward = gohelper.findChild(self.go, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._godescContent = gohelper.findChild(self.go, "scroll_desc/Viewport/#go_descContent")
	self._scrollbossattr = gohelper.findChildScrollRect(self.go, "#scroll_bossattr")
	self._gobossDescContent = gohelper.findChild(self.go, "#scroll_bossattr/Viewport/#go_bossDescContent")
	self._txtbossattrdesc = gohelper.findChildText(self.go, "#scroll_bossattr/Viewport/#go_bossDescContent/go_bossattritem/#txt_desc")
	self._gotags = gohelper.findChild(self.go, "tagcontent/tags")
	self._gotagitem = gohelper.findChild(self.go, "tagcontent/tags/#go_tagitem")
	self._gotips = gohelper.findChild(self.go, "#go_tips")
	self._gotipscontent = gohelper.findChild(self.go, "#go_tips/#go_tipscontent")
	self._gotipitem = gohelper.findChild(self.go, "#go_tips/#go_tipscontent/#txt_tagitem")
	self._btnopentagtips = gohelper.findChildButtonWithAudio(self.go, "tagcontent/#btn_opentagtips")
	self._btnclosetagtips = gohelper.findChildButtonWithAudio(self.go, "#go_tips/#btn_closetips")
	self._btnfresh = gohelper.findChildButtonWithAudio(self.go, "#scroll_bossattr/#btn_fresh")
	self._gofreshicon_drak = gohelper.findChild(self.go, "#scroll_bossattr/#btn_fresh/dark")
	self._gofreshicon_light = gohelper.findChild(self.go, "#scroll_bossattr/#btn_fresh/light")
	self.holeGoList = self:getUserDataTb_()

	table.insert(self.holeGoList, self._gohole)

	self.gridList = self:getUserDataTb_()
	self._itemInstTab = self:getUserDataTb_()
	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self.click:AddClickListener(self.onClickSelf, self)
	self._btnopentagtips:AddClickListener(self._opentagtipsOnClick, self)
	self._btnclosetagtips:AddClickListener(self._closetagtipsOnClick, self)
	self._btnfresh:AddClickListener(self._btnfreshOnClick, self)

	self._bossviewportclick = gohelper.findChildClickWithDefaultAudio(self.go, "#scroll_bossattr/Viewport")

	self._bossviewportclick:AddClickListener(self.onClickSelf, self)

	self._bossdescclick = gohelper.getClickWithDefaultAudio(self._txtbossattrdesc.gameObject)

	self._bossdescclick:AddClickListener(self.onClickSelf, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectDropChange, self.onSelectDropChange, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.ShowMonsterRuleDesc, self.switchShowMonsterRuleDesc, self)
end

function RougeBossCollectionDropItem:onClickSelf()
	self.parent:selectPos(self.index)
	self:refreshSelect()
end

function RougeBossCollectionDropItem:_opentagtipsOnClick()
	gohelper.setActive(self._gotips, true)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(self.collectionId, nil, self._gotipscontent, self._gotipitem)
end

function RougeBossCollectionDropItem:_closetagtipsOnClick()
	gohelper.setActive(self._gotips, false)
end

function RougeBossCollectionDropItem:_btnfreshOnClick()
	if not self._canFresh then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeBossCollection)
	self.animator:Play("open", 0, 0)

	local season = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeRefreshMonsterRuleRequest(season, self.index)
end

function RougeBossCollectionDropItem:onSelectDropChange()
	self.select = self.parent:isSelect(self.index)

	self:refreshSelect()
end

function RougeBossCollectionDropItem:setParentScroll(parentScroll)
	self._scrollreward.parentGameObject = parentScroll
end

function RougeBossCollectionDropItem:update(index, collectionId, monsterRuleId, isShowMonsterRule)
	self.select = false
	self.index = index
	self.collectionId = tonumber(collectionId)
	self.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(self.collectionId)
	self.monsterRuleId = tonumber(monsterRuleId)
	self.monsterRuleCo = RougeDLCConfig103.instance:getMonsterRuleConfig(self.monsterRuleId)
	self.isShowMonsterRule = isShowMonsterRule

	self:refreshHole()
	RougeCollectionHelper.loadShapeGrid(self.collectionId, self._gridLayout, self._gogriditem, self.gridList)
	RougeCollectionHelper.loadCollectionTags(self.collectionId, self._gotags, self._gotagitem)
	self._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshCollectionDesc()
	self:refreshSelect()
end

function RougeBossCollectionDropItem:refreshHole()
	local holeNum = self.collectionCo.holeNum

	gohelper.setActive(self._goenchantlist, holeNum > 0)

	if holeNum > 1 then
		for i = 1, holeNum do
			local hole = self.holeGoList[i]

			if not hole then
				hole = gohelper.cloneInPlace(self._gohole)

				table.insert(self.holeGoList, hole)
			end

			gohelper.setActive(hole, true)
		end

		for i = holeNum + 1, #self.holeGoList do
			gohelper.setActive(self.holeGoList[i], false)
		end
	end
end

function RougeBossCollectionDropItem:refreshEffectDesc()
	self._allClicks = self._allClicks or self:getUserDataTb_()
	self._clickLen = self._clickLen or 0

	for i = 1, self._clickLen do
		self._allClicks[i]:RemoveClickListener()
	end

	self._clickLen = 0

	RougeCollectionDescHelper.setCollectionDescInfos2(self.collectionId, nil, self._godescContent, self._itemInstTab)

	local clicks = self._scrollreward.gameObject:GetComponentsInChildren(typeof(SLFramework.UGUI.UIClickListener), true)

	self._clickLen = clicks.Length

	for i = 0, self._clickLen - 1 do
		self._allClicks[i + 1] = clicks[i]

		self._allClicks[i + 1]:AddClickListener(self.onClickSelf, self)
		gohelper.addUIClickAudio(self._allClicks[i + 1].gameObject)
	end
end

function RougeBossCollectionDropItem:refreshBossAttrDesc()
	if self.monsterRuleCo then
		if not self.monsterRuleCo.desc then
			local attrDesc = ""

			self._txtbossattrdesc.text = SkillHelper.addLink(attrDesc)

			SkillHelper.addHyperLinkClick(self._txtbossattrdesc)
		end
	end
end

function RougeBossCollectionDropItem:refreshFreshBtn()
	local remainCanFreshNum = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum()

	self._canFresh = remainCanFreshNum and remainCanFreshNum > 0

	gohelper.setActive(self._gofreshicon_light, self._canFresh)
	gohelper.setActive(self._gofreshicon_drak, not self._canFresh)
end

function RougeBossCollectionDropItem:refreshCollectionDesc()
	gohelper.setActive(self._scrollreward.gameObject, not self.isShowMonsterRule)
	gohelper.setActive(self._scrollbossattr.gameObject, self.isShowMonsterRule)

	if self.isShowMonsterRule then
		self:refreshBossAttrDesc()
		self:refreshFreshBtn()
	else
		self:refreshEffectDesc()
	end
end

function RougeBossCollectionDropItem:switchShowMonsterRuleDesc(isShowMonsterRule)
	self.animator:Play("open", 0, 0)

	self.isShowMonsterRule = isShowMonsterRule

	self:refreshCollectionDesc()
end

function RougeBossCollectionDropItem:refreshSelect()
	gohelper.setActive(self._goselect, self.select)
end

function RougeBossCollectionDropItem:_onSwitchCollectionInfoType()
	self:refreshEffectDesc()
end

function RougeBossCollectionDropItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeBossCollectionDropItem:show()
	if self.go.activeInHierarchy then
		return
	end

	self.animator:Play("open", 0, 0)
	gohelper.setActive(self.go, true)
end

function RougeBossCollectionDropItem:onClose()
	self.animator:Play(self.select and "close" or "normal", 0, 0)
end

function RougeBossCollectionDropItem:destroy()
	if self._clickLen then
		for i = 1, self._clickLen do
			self._allClicks[i]:RemoveClickListener()
		end
	end

	self.click:RemoveClickListener()
	self._btnopentagtips:RemoveClickListener()
	self._btnclosetagtips:RemoveClickListener()
	self._btnfresh:RemoveClickListener()
	self._bossdescclick:RemoveClickListener()
	self._bossviewportclick:RemoveClickListener()
	self._simagecollection:UnLoadImage()
	self:__onDispose()
end

return RougeBossCollectionDropItem
