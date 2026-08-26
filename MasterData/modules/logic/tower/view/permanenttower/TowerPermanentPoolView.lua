-- chunkname: @modules/logic/tower/view/permanenttower/TowerPermanentPoolView.lua

module("modules.logic.tower.view.permanenttower.TowerPermanentPoolView", package.seeall)

local TowerPermanentPoolView = class("TowerPermanentPoolView", BaseView)

function TowerPermanentPoolView:onInitView()
	self._goPoolContent = gohelper.findChild(self.viewGO, "Left/#go_altitudePool")
	self._goaltitudeItem = gohelper.findChild(self.viewGO, "Left/#go_altitudePool/#go_altitudeItem")
	self._goeliteItem = gohelper.findChild(self.viewGO, "episode/#go_eliteEpisode/#go_eliteItem")
	self._goEliteEpisodeContent = gohelper.findChild(self.viewGO, "episode/#go_eliteEpisode/#go_eliteEpisodeContent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerPermanentPoolView:_editableInitView()
	self.altitudeItemPoolTab = self:getUserDataTb_()
	self.altitudeItemPoolList = self:getUserDataTb_()

	gohelper.setActive(self._goPoolContent, false)
	gohelper.setActive(self._goeliteItem, false)
	recthelper.setAnchorX(self._goPoolContent.transform, -10000)

	self.eliteEpisodeItemPoolTab = self:getUserDataTb_()
	self.eliteEpisodeItemPoolList = self:getUserDataTb_()

	gohelper.setActive(self._goEliteEpisodeContent, false)
end

function TowerPermanentPoolView:createOrGetAltitudeItem(config, clickCallBack, obj)
	local altitudeItem = self.altitudeItemPoolTab[config.index]

	if not altitudeItem then
		altitudeItem = {
			go = gohelper.clone(self._goaltitudeItem, self._goPoolContent, "altitude" .. config.index)
		}
		altitudeItem.itemCanvasGroup = gohelper.findChild(altitudeItem.go, "item"):GetComponent(gohelper.Type_CanvasGroup)
		altitudeItem.goNormal = gohelper.findChild(altitudeItem.go, "item/go_normal")
		altitudeItem.goNormalSelect = gohelper.findChild(altitudeItem.go, "item/go_normal/go_select")
		altitudeItem.goNormalUnFinish = gohelper.findChild(altitudeItem.go, "item/go_normal/go_unfinish")
		altitudeItem.goNormalFinish = gohelper.findChild(altitudeItem.go, "item/go_normal/go_finish")
		altitudeItem.animNormalFinish = altitudeItem.goNormalFinish:GetComponent(gohelper.Type_Animator)
		altitudeItem.goNormalLock = gohelper.findChild(altitudeItem.go, "item/go_normal/go_lock")
		altitudeItem.goElite = gohelper.findChild(altitudeItem.go, "item/go_elite")
		altitudeItem.goEliteSelect = gohelper.findChild(altitudeItem.go, "item/go_elite/go_select")
		altitudeItem.goEliteUnFinish = gohelper.findChild(altitudeItem.go, "item/go_elite/go_unfinish")
		altitudeItem.goEliteFinish = gohelper.findChild(altitudeItem.go, "item/go_elite/go_finish")
		altitudeItem.animEliteFinish = altitudeItem.goEliteFinish:GetComponent(gohelper.Type_Animator)
		altitudeItem.goEliteLock = gohelper.findChild(altitudeItem.go, "item/go_elite/go_lock")
		altitudeItem.goArrow = gohelper.findChild(altitudeItem.go, "go_arrow/arrow")
		altitudeItem.goReward = gohelper.findChild(altitudeItem.go, "go_arrow/Reward/image_RewardBG")
		altitudeItem.simageReward = gohelper.findChildSingleImage(altitudeItem.go, "go_arrow/Reward/image_RewardBG/simage_reward")
		altitudeItem.txtNum = gohelper.findChildText(altitudeItem.go, "item/txt_num")
		altitudeItem.btnClick = gohelper.findChildButtonWithAudio(altitudeItem.go, "btn_click")
		self.altitudeItemPoolTab[config.index] = altitudeItem

		table.insert(self.altitudeItemPoolList, altitudeItem)
	end

	altitudeItem.btnClick:AddClickListener(clickCallBack, obj, config)

	return altitudeItem
end

function TowerPermanentPoolView:recycleAltitudeItem(configList)
	for i = #configList + 1, #self.altitudeItemPoolList do
		local altitudeItem = self.altitudeItemPoolList[i]

		if altitudeItem then
			gohelper.setActive(self.altitudeItemPoolList[i].go, false)
			self.altitudeItemPoolList[i].go.transform:SetParent(self._goPoolContent.transform, false)
			recthelper.setAnchor(self.altitudeItemPoolList[i].go.transform, 0, 0)
		end
	end
end

function TowerPermanentPoolView:getaltitudeItemPoolList()
	return self.altitudeItemPoolList, self.altitudeItemPoolTab
end

function TowerPermanentPoolView:createOrGetEliteEpisodeItem(episodeIndex, clickCallBack, obj)
	local episodeItem = self.eliteEpisodeItemPoolTab[episodeIndex]

	if not episodeItem then
		episodeItem = {
			go = gohelper.clone(self._goeliteItem, self._goEliteEpisodeContent, "eliteItem" .. episodeIndex)
		}
		episodeItem.imageIcon = gohelper.findChildImage(episodeItem.go, "image_icon")
		episodeItem.goSelect = gohelper.findChild(episodeItem.go, "go_select")
		episodeItem.imageSelectIcon = gohelper.findChildImage(episodeItem.go, "go_select/image_selectIcon")
		episodeItem.imageSelectFinishIcon = gohelper.findChildImage(episodeItem.go, "go_select/image_selectFinishIcon")
		episodeItem.goFinish = gohelper.findChild(episodeItem.go, "go_finish")
		episodeItem.goFinishEffect = gohelper.findChild(episodeItem.go, "go_finishEffect")
		episodeItem.imageFinishIcon = gohelper.findChildImage(episodeItem.go, "go_finish/image_finishIcon")
		episodeItem.txtName = gohelper.findChildText(episodeItem.go, "txt_name")
		episodeItem.btnClick = gohelper.findChildButtonWithAudio(episodeItem.go, "btn_click")
		episodeItem.isSelect = false
		episodeItem.episodeIndex = episodeIndex
		self.eliteEpisodeItemPoolTab[episodeIndex] = episodeItem

		table.insert(self.eliteEpisodeItemPoolList, episodeItem)
	end

	episodeItem.btnClick:AddClickListener(clickCallBack, obj, episodeIndex)

	return episodeItem
end

function TowerPermanentPoolView:recycleEliteEpisodeItem(episodeList)
	for i = #episodeList + 1, #self.eliteEpisodeItemPoolList do
		local episodeItem = self.eliteEpisodeItemPoolList[i]

		if episodeItem then
			gohelper.setActive(self.eliteEpisodeItemPoolList[i].go, false)
			self.eliteEpisodeItemPoolList[i].go.transform:SetParent(self._goEliteEpisodeContent.transform, false)
			recthelper.setAnchor(self.eliteEpisodeItemPoolList[i].go.transform, 0, 0)
		end
	end
end

function TowerPermanentPoolView:getEliteEpisodeItemPoolList()
	return self.eliteEpisodeItemPoolList, self.eliteEpisodeItemPoolTab
end

function TowerPermanentPoolView:onClose()
	for index, altitudeItem in pairs(self.altitudeItemPoolTab) do
		altitudeItem.btnClick:RemoveClickListener()
		altitudeItem.simageReward:UnLoadImage()
	end

	for index, episodeItem in pairs(self.eliteEpisodeItemPoolList) do
		episodeItem.btnClick:RemoveClickListener()
	end
end

return TowerPermanentPoolView
