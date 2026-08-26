-- chunkname: @modules/logic/explore/view/ExploreEnterView.lua

module("modules.logic.explore.view.ExploreEnterView", package.seeall)

local ExploreEnterView = class("ExploreEnterView", BaseView)

function ExploreEnterView:onInitView()
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._txtnamecn = gohelper.findChildTextMesh(self.viewGO, "center/#txt_namecn")
	self._imagenum = gohelper.findChildImage(self.viewGO, "center/bg/#image_num")
	self._txtlevelname = gohelper.findChildTextMesh(self.viewGO, "center/bg/#txt_levelname")
	self._gohorizontal = gohelper.findChild(self.viewGO, "center/progressbar/horizontal")
	self._goitem = gohelper.findChild(self.viewGO, "center/progressbar/horizontal/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreEnterView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ExploreEnterView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ExploreEnterView:_editableInitView()
	return
end

function ExploreEnterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)
	local chapterCoList = DungeonConfig.instance:getExploreChapterList()
	local chapterIndex = 1

	for index, chapterCo in ipairs(chapterCoList) do
		if chapterCo.id == mapCo.chapterId then
			chapterIndex = index

			break
		end
	end

	local name = chapterCoList[chapterIndex].name
	local len = GameUtil.utf8len(name)
	local showName

	if len >= 2 then
		local first = GameUtil.utf8sub(name, 1, 1)
		local center = GameUtil.utf8sub(name, 2, len - 2)
		local last = GameUtil.utf8sub(name, len, 1)

		showName = string.format("<size=50>%s</size>%s<size=50>%s</size>", first, center, last)
	else
		showName = "<size=50>" .. name
	end

	self._txtnamecn.text = showName

	local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterCoList[chapterIndex].id)
	local episodeIndex = 1

	for index, co in ipairs(episodeCoList) do
		if co.id == mapCo.episodeId then
			episodeIndex = index

			break
		end
	end

	UISpriteSetMgr.instance:setExploreSprite(self._imagenum, "dungeon_secretroom_num_" .. episodeIndex)

	self._txtlevelname.text = episodeCoList[episodeIndex].name

	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getCoinCountByMapId(mapId)
	local data = {
		{
			purpleCoin,
			purpleCoinTotal,
			"dungeon_secretroom_btn_triangle"
		},
		{
			goldCoin,
			goldCoinTotal,
			"dungeon_secretroom_btn_sandglass"
		},
		{
			bonusNum,
			bonusNumTotal,
			"dungeon_secretroom_btn_box"
		}
	}

	gohelper.CreateObjList(self, self.setItem, data, self._gohorizontal, self._goitem)
	TaskDispatcher.runDelay(self.closeThis, self, 3)
end

function ExploreEnterView:setItem(obj, data, index)
	local bg = gohelper.findChildImage(obj, "bg")
	local icon = gohelper.findChildImage(obj, "image_icon")
	local progress = gohelper.findChildTextMesh(obj, "txt_progress")

	UISpriteSetMgr.instance:setExploreSprite(bg, data[1] == data[2] and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(icon, data[3] .. (data[1] == data[2] and "1" or "2"))

	progress.text = string.format("%d/%d", data[1], data[2])
end

function ExploreEnterView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	TaskDispatcher.cancelTask(self.closeThis, self)

	local map = ExploreController.instance:getMap()

	if not map then
		return
	end

	map:getHero():onRoleFirstEnter()
end

return ExploreEnterView
