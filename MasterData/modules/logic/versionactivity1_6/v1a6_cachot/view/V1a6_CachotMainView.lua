-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotMainView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainView", package.seeall)

local V1a6_CachotMainView = class("V1a6_CachotMainView", BaseView)

function V1a6_CachotMainView:onInitView()
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_collection")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._goreddot = gohelper.findChild(self.viewGO, "#btn_reward/#go_reddot")
	self._txtscore = gohelper.findChildText(self.viewGO, "#btn_reward/scorebg/#txt_score")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#btn_reward/scorebg/#txt_score/#simage_icon")
	self._gocontrol = gohelper.findChild(self.viewGO, "#go_control")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotMainView:addEvents()
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function V1a6_CachotMainView:removeEvents()
	self._btncollection:RemoveClickListener()
	self._btnreward:RemoveClickListener()
end

function V1a6_CachotMainView:_btnrewardOnClick()
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function V1a6_CachotMainView:_btncollectionOnClick()
	V1a6_CachotController.instance:openV1a6_CachotCollectionView()
end

function V1a6_CachotMainView:_editableInitView()
	return
end

function V1a6_CachotMainView:onUpdateParam()
	return
end

function V1a6_CachotMainView:onOpen()
	self.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	self._txtscore.text = self.stateMo.totalScore

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_interface_open)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function V1a6_CachotMainView:onClose()
	return
end

function V1a6_CachotMainView:onDestroyView()
	return
end

return V1a6_CachotMainView
