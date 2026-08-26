-- chunkname: @modules/logic/dungeon/view/DungeonEquipEntryItem.lua

module("modules.logic.dungeon.view.DungeonEquipEntryItem", package.seeall)

local DungeonEquipEntryItem = class("DungeonEquipEntryItem", BaseView)

function DungeonEquipEntryItem:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._txttitle = gohelper.findChildText(self.viewGO, "coverInfo/title/#txt_title")
	self._txttitleEn = gohelper.findChildText(self.viewGO, "coverInfo/title/#txt_titleEn")
	self._simagecoverpic = gohelper.findChildSingleImage(self.viewGO, "coverInfo/#simage_coverpic")
	self._txtcoverDesc = gohelper.findChildText(self.viewGO, "coverInfo/#txt_coverDesc")
	self._imagefill = gohelper.findChildImage(self.viewGO, "coverInfo/progress/#image_fill")
	self._txtprogress = gohelper.findChildText(self.viewGO, "coverInfo/progress/#txt_progress")
	self._txttype = gohelper.findChildText(self.viewGO, "detailInfo/clue/#txt_type")
	self._txttypeNameEn = gohelper.findChildText(self.viewGO, "detailInfo/clue/#txt_type/#txt_typeNameEn")
	self._txtclueName = gohelper.findChildText(self.viewGO, "detailInfo/clue/#txt_clueName")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "detailInfo/clue/#simage_pic")
	self._txtclueDesc = gohelper.findChildText(self.viewGO, "detailInfo/desc/#txt_clueDesc")
	self._goreward = gohelper.findChild(self.viewGO, "detailInfo/#go_reward")
	self._gocomplate = gohelper.findChild(self.viewGO, "detailInfo/#go_complate")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "detailInfo/#go_reward/#scroll_reward")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "detailInfo/#go_reward/#scroll_reward/#btn_reward")
	self._goitem = gohelper.findChild(self.viewGO, "detailInfo/#go_reward/#scroll_reward/Viewport/Content/#go_item")
	self._btnsurveybtn = gohelper.findChildButtonWithAudio(self.viewGO, "detailInfo/#go_reward/#btn_surveybtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonEquipEntryItem:addEvents()
	self._btnsurveybtn:AddClickListener(self._btnsurveybtnOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function DungeonEquipEntryItem:removeEvents()
	self._btnsurveybtn:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function DungeonEquipEntryItem:_btnsurveybtnOnClick()
	DungeonFightController.instance:enterFight(self._config.chapterId, self._episodeId)
end

function DungeonEquipEntryItem:_btnrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self._config)
end

function DungeonEquipEntryItem:_editableInitView()
	self._config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	self._simagebg1:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_diban"))
	self._simagebg2:LoadImage(ResUrl.getDungeonIcon("entry/bg_teshufuben_zhuangshi"))

	self._txttitle.text = self._config.name
	self._txttitleEn.text = self._config.name_En
	self._txtclueDesc.text = string.format("          %s", self._config.battleDesc)
	self._txtcoverDesc.text = self._config.desc

	local tag = {
		self._progress - 1,
		self._episodeNum
	}

	self._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_map_sp_equip_progress"), tag)
	self._imagefill.fillAmount = (self._progress - 1) / self._episodeNum

	local info = DungeonModel.instance:getEpisodeInfo(self._episodeId)
	local passed = DungeonModel.instance:hasPassLevel(self._episodeId) and info.challengeCount == 1

	gohelper.setActive(self._goreward, not passed)
	gohelper.setActive(self._gocomplate, passed)

	local navigationpic = self._config.navigationpic

	self._simagecoverpic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", navigationpic, 1)))
	self._simagepic:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_%s_%s", navigationpic, 2)))

	local rewardList = DungeonModel.instance:getEpisodeRewardDisplayList(self._episodeId)

	for i, reward in ipairs(rewardList) do
		local child = gohelper.cloneInPlace(self._goitem)

		gohelper.setActive(child, true)

		local item = IconMgr.instance:getCommonPropItemIcon(child)

		item:setMOValue(reward[1], reward[2], reward[3])
		item:isShowEquipAndItemCount(false)
		item:hideEquipLvAndBreak(true)
	end
end

function DungeonEquipEntryItem:ctor(param)
	self._episodeIndex = param[1]
	self._episodeNum = param[2]
	self._episodeId = param[3]
	self._progress = param[4]
end

function DungeonEquipEntryItem:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEvents()
end

function DungeonEquipEntryItem:onUpdateParam()
	return
end

function DungeonEquipEntryItem:onOpen()
	return
end

function DungeonEquipEntryItem:onClose()
	return
end

function DungeonEquipEntryItem:onDestroy()
	self:removeEvents()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagecoverpic:UnLoadImage()
	self._simagepic:UnLoadImage()
end

return DungeonEquipEntryItem
