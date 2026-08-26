-- chunkname: @modules/logic/explore/view/ExploreFinishView.lua

module("modules.logic.explore.view.ExploreFinishView", package.seeall)

local ExploreFinishView = class("ExploreFinishView", BaseView)

function ExploreFinishView:onInitView()
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")
	self._gohorizontal = gohelper.findChild(self.viewGO, "center/progressbar/content")
	self._txtchapter = gohelper.findChildTextMesh(self.viewGO, "center/bg/#txt_chaptername")
	self._txtchapterEn = gohelper.findChildTextMesh(self.viewGO, "center/bg/#txt_chapternameen")
	self._goitem = gohelper.findChild(self.viewGO, "center/progressbar/content/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreFinishView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ExploreFinishView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ExploreFinishView:_editableInitView()
	return
end

function ExploreFinishView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(mapCo.episodeId)

	self._txtchapter.text = episodeCo.name
	self._txtchapterEn.text = episodeCo.name_En

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
end

function ExploreFinishView:setItem(obj, data, index)
	local bg = gohelper.findChildImage(obj, "bg2")
	local icon = gohelper.findChildImage(obj, "bg2/image_icon")
	local progress = gohelper.findChildTextMesh(obj, "txt_progress")
	local isFull = data[1] == data[2]

	UISpriteSetMgr.instance:setExploreSprite(bg, isFull and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(icon, data[3] .. (isFull and "1" or "2"))

	local color = isFull and "E0BB6D" or "D5D4BC"

	progress.text = string.format("<color=#%s>%d/%d", color, data[1], data[2])
end

function ExploreFinishView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:exit()
end

return ExploreFinishView
