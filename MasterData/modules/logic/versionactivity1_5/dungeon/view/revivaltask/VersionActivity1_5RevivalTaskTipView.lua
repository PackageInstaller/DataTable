-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5RevivalTaskTipView.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskTipView", package.seeall)

local VersionActivity1_5RevivalTaskTipView = class("VersionActivity1_5RevivalTaskTipView", BaseView)

function VersionActivity1_5RevivalTaskTipView:onInitView()
	self._gotipscontainer = gohelper.findChild(self.viewGO, "#go_tipcontainer")
	self._goclosetip = gohelper.findChild(self.viewGO, "#go_tipcontainer/#go_closetip")
	self._txtTipTitle = gohelper.findChildText(self.viewGO, "#go_tipcontainer/#go_tips/#txt_title")
	self._simageTipPic = gohelper.findChildSingleImage(self.viewGO, "#go_tipcontainer/#go_tips/#simage_pic")
	self._txtTipDesc = gohelper.findChildText(self.viewGO, "#go_tipcontainer/#go_tips/#txt_desc")
	self._btnReplay = gohelper.findChildButton(self.viewGO, "#go_tipcontainer/#go_tips/#btn_replay")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5RevivalTaskTipView:addEvents()
	self._btnReplay:AddClickListener(self.onClickBtnReplay, self)
end

function VersionActivity1_5RevivalTaskTipView:removeEvents()
	self._btnReplay:RemoveClickListener()
end

function VersionActivity1_5RevivalTaskTipView:onClickBtnReplay()
	if not self.isShowBtn then
		return
	end

	if self.showType == DungeonEnum.ElementType.None then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			fragmentId = self.showParam
		})
	elseif self.showType == DungeonEnum.ElementType.EnterDialogue then
		DialogueController.instance:enterDialogue(self.showParam)
	else
		logError("un support type, " .. tostring(self.showType))
	end
end

function VersionActivity1_5RevivalTaskTipView:onClickCloseBtn()
	self.config = nil

	gohelper.setActive(self._gotipscontainer, false)
end

function VersionActivity1_5RevivalTaskTipView:_editableInitView()
	gohelper.setActive(self._gotipscontainer, false)

	self.closeClick = gohelper.getClickWithDefaultAudio(self._goclosetip)

	self.closeClick:AddClickListener(self.onClickCloseBtn, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ShowSubTaskDetail, self.showSubTaskDetail, self)
end

function VersionActivity1_5RevivalTaskTipView:showSubTaskDetail(config)
	self.config = config

	gohelper.setActive(self._gotipscontainer, true)

	self._txtTipTitle.text = self.config.title
	self._txtTipDesc.text = self.config.desc .. self.config.descSuffix

	self._simageTipPic:LoadImage(ResUrl.getV1a5RevivalTaskSingleBg(self.config.image))
	self:showReplayBtn()
end

function VersionActivity1_5RevivalTaskTipView:showReplayBtn()
	local elementId = self.config.elementList[1]
	local elementCo = lua_chapter_map_element.configDict[elementId]

	self.isShowBtn = false

	if elementCo.type == DungeonEnum.ElementType.None then
		if elementCo.fragment ~= 0 then
			self.isShowBtn = true
			self.showType = DungeonEnum.ElementType.None
			self.showParam = elementCo.fragment
		end
	elseif elementCo.type == DungeonEnum.ElementType.EnterDialogue then
		self.isShowBtn = true
		self.showType = DungeonEnum.ElementType.EnterDialogue
		self.showParam = tonumber(elementCo.param)
	end

	gohelper.setActive(self._btnReplay, self.isShowBtn)
end

function VersionActivity1_5RevivalTaskTipView:onDestroyView()
	self._simageTipPic:UnLoadImage()
	self.closeClick:RemoveClickListener()
end

return VersionActivity1_5RevivalTaskTipView
