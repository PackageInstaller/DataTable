-- chunkname: @modules/logic/rouge/view/RougeStoryListItem.lua

module("modules.logic.rouge.view.RougeStoryListItem", package.seeall)

local RougeStoryListItem = class("RougeStoryListItem", ListScrollCellExtend)

function RougeStoryListItem:onInitView()
	self._golayout = gohelper.findChild(self.viewGO, "#go_layout")
	self._simagestoryicon = gohelper.findChildSingleImage(self.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	self._txtid = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_id")
	self._txtstorynameen = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_storynameen")
	self._txtstorynamecn = gohelper.findChildText(self.viewGO, "#go_layout/basic/#txt_storynamecn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeStoryListItem:addEvents()
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function RougeStoryListItem:removeEvents()
	self._btnplay:RemoveClickListener()
end

function RougeStoryListItem:_btnplayOnClick()
	if not string.nilorempty(self._config.storyIdList) then
		local storyList = string.splitToNumber(self._config.storyIdList, "#")
		local levelIdDict = {}

		if not string.nilorempty(self._config.levelIdDict) then
			local levelIdPairs = string.split(self._config.levelIdDict, "|")

			for _, levelIdPair in ipairs(levelIdPairs) do
				local levelIdParam = string.splitToNumber(levelIdPair, "#")

				levelIdDict[levelIdParam[1]] = levelIdParam[2]
			end
		end

		local data = {}

		data.levelIdDict = levelIdDict
		data.isReplay = true

		StoryController.instance:playStories(storyList, data)
	end
end

function RougeStoryListItem:_editableInitView()
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "")

	gohelper.addUIClickAudio(self._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function RougeStoryListItem:_refreshUI()
	self._txtstorynamecn.text = self._config.name
	self._txtstorynameen.text = self._config.nameEn

	self._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(self._config.image))

	self._txtid.text = self._mo.index > 9 and tostring(self._mo.index) or "0" .. tostring(self._mo.index)
end

function RougeStoryListItem:onUpdateMO(mo)
	self._mo = mo
	self._config = mo.config

	self:_refreshUI()
end

function RougeStoryListItem:getAnimator()
	return self._anim
end

function RougeStoryListItem:onDestroy()
	self._simagestoryicon:UnLoadImage()
end

return RougeStoryListItem
