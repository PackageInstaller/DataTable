-- chunkname: @modules/logic/versionactivity1_4/dungeon/view/VersionActivity1_4DungeonEpisodeView.lua

module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeView", package.seeall)

local VersionActivity1_4DungeonEpisodeView = class("VersionActivity1_4DungeonEpisodeView", BaseView)

function VersionActivity1_4DungeonEpisodeView:onInitView()
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "rotate/layout/top/title/#txt_title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "rotate/#go_bg/#txt_info")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/#go_fight/#btn_fight")
	self._btnbg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_closetip")
	self._txtcost = gohelper.findChildText(self.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	self.goRewardContent = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	self.rewardItems = self:getUserDataTb_()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_4DungeonEpisodeView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnbg:AddClickListener(self._btnbgOnClick, self)
	self._btnclosetip:AddClickListener(self._btnbgOnClick, self)
end

function VersionActivity1_4DungeonEpisodeView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnbg:RemoveClickListener()
	self._btnclosetip:RemoveClickListener()
end

function VersionActivity1_4DungeonEpisodeView:_btnbgOnClick()
	self:closeThis()
end

function VersionActivity1_4DungeonEpisodeView:_btnyesOnClick()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)

	if not episodeCo then
		return
	end

	DungeonFightController.instance:enterFight(episodeCo.chapterId, episodeCo.id, 1)
end

function VersionActivity1_4DungeonEpisodeView:_editableInitView()
	return
end

function VersionActivity1_4DungeonEpisodeView:onUpdateParam()
	self.episodeId = self.viewParam.episodeId

	self:refreshView()
end

function VersionActivity1_4DungeonEpisodeView:onOpen()
	self.episodeId = self.viewParam.episodeId

	self._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204_btn"))
	self:refreshView()
end

function VersionActivity1_4DungeonEpisodeView:refreshView()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(self.episodeId)

	if not episodeCo then
		return
	end

	self.txtName.text = episodeCo.name
	self.txtDesc.text = episodeCo.desc

	local cost = 0

	if not string.nilorempty(episodeCo.cost) then
		cost = string.splitToNumber(episodeCo.cost, "#")[3]
	end

	self._txtcost.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#800015")
	end

	self:refreshReward(episodeCo)
end

function VersionActivity1_4DungeonEpisodeView:refreshReward(episodeCo)
	gohelper.setActive(self._goactivityrewarditem, false)

	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0
	local episodeMO = DungeonModel.instance:getEpisodeInfo(episodeCo.id)

	if episodeMO and episodeMO.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(episodeCo.id))

		advancedRewardIndex = #rewardList
	end

	if episodeMO and episodeMO.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(episodeCo.id))

		firstRewardIndex = #rewardList
	end

	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeRewardDisplayList(episodeCo.id))

	local rewardCount = #rewardList

	if rewardCount == 0 then
		gohelper.setActive(self.goRewardContent, false)

		return
	end

	gohelper.setActive(self.goRewardContent, true)

	local count = math.min(#rewardList, 3)
	local reward, rewardItem

	for i = 1, count do
		rewardItem = self.rewardItems[i]

		if not self.rewardItems[i] then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.cloneInPlace(self._goactivityrewarditem, "item" .. i)
			rewardItem.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(rewardItem.go, "itemicon"))
			rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
			rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
			rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
			rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
			rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")

			table.insert(self.rewardItems, rewardItem)
		end

		reward = rewardList[i]

		gohelper.setActive(rewardItem.gonormal, false)
		gohelper.setActive(rewardItem.gofirst, false)
		gohelper.setActive(rewardItem.goadvance, false)
		gohelper.setActive(rewardItem.gofirsthard, false)

		local goFirstRare, goAdvanceRare

		if not reward[4] then
			local quantity = reward[3]

			if i <= advancedRewardIndex then
				gohelper.setActive(rewardItem.goadvance, true)
			elseif i <= firstRewardIndex then
				gohelper.setActive(rewardItem.gofirst, true)
			else
				gohelper.setActive(rewardItem.gonormal, true)

				rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. reward[3])
			end

			rewardItem.iconItem:setMOValue(reward[1], reward[2], quantity, nil, true)
			rewardItem.iconItem:setCountFontSize(42)
			rewardItem.iconItem:setHideLvAndBreakFlag(true)
			rewardItem.iconItem:hideEquipLvAndBreak(true)
			rewardItem.iconItem:customOnClickCallback(self._onRewardItemClick, self)
			gohelper.setActive(rewardItem.go, true)
		end
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivity1_4DungeonEpisodeView:createRewardItem(index)
	local item = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

	self.rewardItemList[index] = item

	return item
end

function VersionActivity1_4DungeonEpisodeView:onClose()
	VersionActivity1_4DungeonModel.instance:setSelectEpisodeId()
end

function VersionActivity1_4DungeonEpisodeView:onDestroyView()
	self._simagecosticon:UnLoadImage()
end

return VersionActivity1_4DungeonEpisodeView
