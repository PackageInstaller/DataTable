-- chunkname: @modules/logic/explore/view/ExploreBonusRewardView.lua

module("modules.logic.explore.view.ExploreBonusRewardView", package.seeall)

local ExploreBonusRewardView = class("ExploreBonusRewardView", BaseView)

function ExploreBonusRewardView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gobtnsitem = gohelper.findChild(self.viewGO, "#go_btns/#btn_level")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "top/title/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreBonusRewardView:addEvents()
	self._btnclose1:AddClickListener(self.closeThis, self)
	self._btnclose2:AddClickListener(self.closeThis, self)
end

function ExploreBonusRewardView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function ExploreBonusRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

	local chapterCo = self.viewParam
	local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterCo.id)

	self._episodeCoList = episodeCoList
	self._btns = {}

	gohelper.CreateObjList(self, self.createItem, episodeCoList, self._gobtns, self._gobtnsitem)

	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getChapterCoinCount(chapterCo.id)

	self._txtnum.text = string.format("<color=#f68736>%d</color>/%d", bonusNum, bonusNumTotal)

	self:onClickLevel(1)
end

function ExploreBonusRewardView:createItem(obj, data, index)
	local name = gohelper.findChildTextMesh(obj, "#txt_name")
	local select = gohelper.findChild(obj, "#select_btn")

	name.text = data.name

	local bg = gohelper.findChildImage(obj, "")
	local btn = gohelper.findButtonWithAudio(obj)

	self.addClickCb(self, btn, self.onClickLevel, self, index)

	self._btns[index] = {
		name,
		bg,
		select
	}
end

function ExploreBonusRewardView:onClickLevel(index)
	local episodeCo = self._episodeCoList[index]

	ExploreTaskModel.instance:getTaskList(0):setList(ExploreConfig.instance:getRewardConfig(self.viewParam.id, episodeCo.id))

	for i = 1, #self._btns do
		ZProj.UGUIHelper.SetColorAlpha(self._btns[i][1], i == index and 1 or 0.5)
		ZProj.UGUIHelper.SetColorAlpha(self._btns[i][2], i == index and 1 or 0.3)
		gohelper.setActive(self._btns[i][3], i == index)
	end
end

function ExploreBonusRewardView:onClickModalMask()
	self:closeThis()
end

return ExploreBonusRewardView
