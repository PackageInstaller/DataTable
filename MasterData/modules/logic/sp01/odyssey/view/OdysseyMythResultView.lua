-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythResultView.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythResultView", package.seeall)

local OdysseyMythResultView = class("OdysseyMythResultView", BaseView)

function OdysseyMythResultView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._imagerecord = gohelper.findChildImage(self.viewGO, "root/Left/go_level/#image_record")
	self._txtlevel = gohelper.findChildText(self.viewGO, "root/Left/go_level/image_levelbg/#txt_level")
	self._txtbossName = gohelper.findChildText(self.viewGO, "root/Left/#txt_bossName")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#btn_detail")
	self._goheroitem = gohelper.findChild(self.viewGO, "root/Right/herogroupcontain/hero/heroitem")
	self._goReward = gohelper.findChild(self.viewGO, "root/Right/#go_Reward")
	self._goRewardRoot = gohelper.findChild(self.viewGO, "root/Right/#go_Reward/#go_RewardRoot/#scroll_rewards/Viewport/rewardroot")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/Right/#go_Reward/#go_RewardRoot/item")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/Left/simage_boss")
	self._simageLevel = gohelper.findChildSingleImage(self.viewGO, "root/Left/go_level/simage_level")
	self._rewardList = {}
	self._heroList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyMythResultView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._click:AddClickListener(self._onClickClose, self)
end

function OdysseyMythResultView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._click:RemoveClickListener()
end

function OdysseyMythResultView:_onClickClose()
	self:closeThis()

	local storyId = FightModel.instance:getAfterStory()
	local curChapterConfig = DungeonConfig.instance:getChapterCO(self._curChapterId)
	local noCheckFinish = curChapterConfig and curChapterConfig.type == DungeonEnum.ChapterType.RoleStory or curChapterConfig.id == DungeonEnum.ChapterId.RoleDuDuGu

	if storyId > 0 and (noCheckFinish or not StoryModel.instance:isStoryFinished(storyId)) then
		OdysseyMythResultView._storyId = storyId
		OdysseyMythResultView._clientFinish = false
		OdysseyMythResultView._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, OdysseyMythResultView._finishStoryFromServer)

		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, function()
			TaskDispatcher.runDelay(OdysseyMythResultView.onStoryEnd, nil, 3)

			OdysseyMythResultView._clientFinish = true

			OdysseyMythResultView.checkStoryEnd()
		end)

		return
	end

	OdysseyMythResultView.onStoryEnd()
end

function OdysseyMythResultView._finishStoryFromServer(storyId)
	if OdysseyMythResultView._storyId == storyId then
		OdysseyMythResultView._serverFinish = true

		OdysseyMythResultView.checkStoryEnd()
	end
end

function OdysseyMythResultView.checkStoryEnd()
	if OdysseyMythResultView._clientFinish and OdysseyMythResultView._serverFinish then
		OdysseyMythResultView.onStoryEnd()
	end
end

function OdysseyMythResultView.onStoryEnd()
	OdysseyMythResultView._storyId = nil
	OdysseyMythResultView._clientFinish = false
	OdysseyMythResultView._serverFinish = false

	TaskDispatcher.cancelTask(OdysseyMythResultView.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, OdysseyMythResultView._finishStoryFromServer)
	FightController.onResultViewClose()
end

function OdysseyMythResultView:_btndetailOnClick()
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function OdysseyMythResultView:_editableInitView()
	return
end

function OdysseyMythResultView:onUpdateParam()
	return
end

function OdysseyMythResultView:onOpen()
	self._resultMo = OdysseyModel.instance:getFightResultInfo()
	self._curChapterId = DungeonModel.instance.curSendChapterId

	local fightResultModel = FightResultModel.instance

	self._curEpisodeId = fightResultModel.episodeId
	self._maxHeroCount = 5

	self:_initHeroList()
	self:_updateHeroList()
	self:_updateRewardList()
	self:_updateBoss()
end

function OdysseyMythResultView:_initHeroList()
	gohelper.setActive(self._goheroitem, false)

	for i = 1, self._maxHeroCount do
		local go = gohelper.findChild(self.viewGO, "root/Right/herogroupcontain/hero/bg" .. i)
		local goempty = gohelper.findChild(go, "empty")
		local goroot = gohelper.findChild(go, "bg")
		local heroItem = self:getUserDataTb_()

		heroItem.go = go
		heroItem.goempty = goempty
		heroItem.goroot = goroot

		table.insert(self._heroList, heroItem)
	end
end

function OdysseyMythResultView:_creatItem(obj, mo, index)
	local item = self._rewardList[index]

	if not item then
		item = self:getUserDataTb_()

		local itemPos = obj

		item.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], itemPos)
		item.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(item.itemGO, OdysseyItemIcon)

		if mo.rewardType == OdysseyEnum.ResultRewardType.Item then
			item.itemIcon:initItemInfo(mo.itemType, mo.itemId, mo.count)
		elseif mo.rewardType == OdysseyEnum.ResultRewardType.Exp then
			item.itemIcon:showTalentItem(mo.count)
		elseif mo.rewardType == OdysseyEnum.ResultRewardType.Talent then
			item.itemIcon:showExpItem(mo.count)
		elseif mo.itemType and mo.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local dataParam = {
				type = tonumber(mo.type),
				id = tonumber(mo.id)
			}

			item.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, dataParam, tonumber(mo.addCount))
		end

		table.insert(self._rewardList, item)
	end
end

function OdysseyMythResultView:_updateHeroList()
	local fightParam = FightModel.instance:getFightParam()
	local heroEquipList, subHeroEquipList = fightParam:getHeroEquipAndTrialMoList()

	for index, heroEquipMo in ipairs(heroEquipList) do
		local heroItem = self._heroList[index]

		if heroEquipMo and heroEquipMo.heroMo then
			local cloneGO = gohelper.clone(self._goheroitem, heroItem.goroot, "heroItem" .. index)
			local itemcomp = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, OdysseyMythResultItem, self)

			gohelper.setActive(heroItem.goempty, false)
			gohelper.setActive(cloneGO, true)
			itemcomp:setResFunc(self.getEquipPrefab, self)
			itemcomp:setData(heroEquipMo.heroMo, heroEquipMo.equipMo, index)
		else
			gohelper.setActive(heroItem.goempty, true)
		end
	end
end

function OdysseyMythResultView:getEquipPrefab(parent)
	return self:getResInst(self.viewContainer:getSetting().otherRes[2], parent)
end

function OdysseyMythResultView:_updateRewardList()
	local rewardList = self._resultMo:getRewardList()
	local showAddOuterItemList = OdysseyItemModel.instance:getAddOuterItemList()
	local allRewardList = {}

	tabletool.addValues(allRewardList, showAddOuterItemList)
	tabletool.addValues(allRewardList, rewardList)

	if allRewardList and #allRewardList > 0 then
		gohelper.setActive(self._goReward, true)
		gohelper.CreateObjList(self, self._creatItem, allRewardList, self._goRewardRoot, self._goRewardItem)
	else
		gohelper.setActive(self._goReward, false)
	end
end

function OdysseyMythResultView:_updateBoss()
	local bossCo = OdysseyConfig.instance:getMythConfigByElementId(self._resultMo:getElementId())

	self._simageBoss:LoadImage(ResUrl.getSp01OdysseySingleBg(bossCo.res))

	self._txtbossName.text = bossCo.name

	local fightFinishedTaskIdList = self._resultMo:getFightFinishedTaskIdList()
	local fightrecord = #fightFinishedTaskIdList
	local name = "pingji_x_" .. fightrecord
	local levelname = "mythcreatures/odyssey_mythcreatures_level_" .. fightrecord

	self._simageLevel:LoadImage(ResUrl.getSp01OdysseySingleBg(levelname))
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imagerecord, name)

	self._txtlevel.text = luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. fightrecord)
end

function OdysseyMythResultView:onClose()
	return
end

function OdysseyMythResultView:onDestroyView()
	OdysseyModel.instance:clearResultInfo()
end

return OdysseyMythResultView
