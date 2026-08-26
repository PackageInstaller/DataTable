-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryTipView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryTipView", package.seeall)

local NecrologistStoryTipView = class("NecrologistStoryTipView", BaseView)

function NecrologistStoryTipView:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Layout/right/#txt_title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Layout/right/descNode/#go_Talk/Scroll DecView/Viewport/Content/info1")
	self.layoutElement = gohelper.findChildComponent(self.viewGO, "Layout/right/descNode/#go_Talk/Scroll DecView", typeof(UnityEngine.UI.LayoutElement))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryTipView:addEvents()
	return
end

function NecrologistStoryTipView:removeEvents()
	return
end

function NecrologistStoryTipView:_editableInitView()
	return
end

function NecrologistStoryTipView:onClickModalMask()
	self:closeThis()
end

function NecrologistStoryTipView:initViewParam()
	self.tagId = self.viewParam.tagId
end

function NecrologistStoryTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_paiqian_open)
	self:initViewParam()
	self:setTagTip(self.tagId)
end

function NecrologistStoryTipView:setTagTip(tagId)
	local tagId = tonumber(tagId)
	local tagCo = NecrologistStoryConfig.instance:getIntroduceCo(tagId)

	if not tagCo then
		return
	end

	self.txtTitle.text = tagCo.name
	self.txtDesc.text = tagCo.desc

	local viewHeight = recthelper.getHeight(self.viewGO.transform)
	local txtHeight = self.txtDesc.preferredHeight
	local maxHeight = viewHeight - 240

	self.layoutElement.preferredHeight = math.min(maxHeight, txtHeight)
end

function NecrologistStoryTipView:onClose()
	return
end

function NecrologistStoryTipView:onDestroyView()
	return
end

return NecrologistStoryTipView
