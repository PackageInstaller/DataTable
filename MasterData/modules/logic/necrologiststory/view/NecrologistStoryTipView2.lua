-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTipView2.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTipView2", package.seeall)

local NecrologistStoryTipView2 = class("NecrologistStoryTipView2", BaseView)

function NecrologistStoryTipView2:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "root/#txt_title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/ScrollView/Viewport/Content/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryTipView2:addEvents()
	return
end

function NecrologistStoryTipView2:removeEvents()
	return
end

function NecrologistStoryTipView2:_editableInitView()
	return
end

function NecrologistStoryTipView2:onClickModalMask()
	self:closeThis()
end

function NecrologistStoryTipView2:initViewParam()
	self.tagId = self.viewParam.tagId
end

function NecrologistStoryTipView2:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_paiqian_open)
	self:initViewParam()
	self:setTagTip(self.tagId)
end

function NecrologistStoryTipView2:setTagTip(tagId)
	local tagId = tonumber(tagId)
	local tagCo = NecrologistStoryConfig.instance:getIntroduceCo(tagId)

	if not tagCo then
		return
	end

	self.txtTitle.text = tagCo.name
	self.txtDesc.text = tagCo.desc
end

function NecrologistStoryTipView2:onClose()
	return
end

function NecrologistStoryTipView2:onDestroyView()
	return
end

return NecrologistStoryTipView2
