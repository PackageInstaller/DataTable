-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogNormalRightItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalRightItem", package.seeall)

local AergusiDialogNormalRightItem = class("AergusiDialogNormalRightItem", AergusiDialogItem)

function AergusiDialogNormalRightItem:initView()
	self._gorolebg = gohelper.findChild(self.go, "rolebg")
	self._simageAvatar = gohelper.findChildSingleImage(self.go, "rolebg/image_avatar")
	self._gorolebggrey = gohelper.findChild(self.go, "rolebg_grey")
	self._simageAvatarGrey = gohelper.findChildSingleImage(self.go, "rolebg_grey/image_avatar")
	self._txtName = gohelper.findChildText(self.go, "name")
	self._txtNameGrey = gohelper.findChildText(self.go, "name_grey")
	self._txtContent = gohelper.findChildText(self.go, "content_bg/txt_content")
	self._goreference = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference")
	self._txtreference = gohelper.findChildText(self.go, "content_bg/txt_content/#go_reference/#txt_reference")
	self._goiconobjection = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_objection")
	self._goiconask = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference/#txt_reference/icon_ask")
	self._goreferencegrey = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference_grey")
	self._txtreferencegrey = gohelper.findChildText(self.go, "content_bg/txt_content/#go_reference_grey/#txt_reference")
	self._goiconobjectiongrey = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_objection")
	self._goiconaskgrey = gohelper.findChild(self.go, "content_bg/txt_content/#go_reference_grey/#txt_reference/icon_ask")
	self._goselectframe = gohelper.findChild(self.go, "content_bg/selectframe")
	self._gomaskgrey = gohelper.findChild(self.go, "content_bg/mask_grey")
	self._contentBgRt = gohelper.findChildComponent(self.go, "content_bg", gohelper.Type_RectTransform)
	self._contentRt = self._txtContent:GetComponent(gohelper.Type_RectTransform)
	self.go.name = string.format("normalrightitem_%s_%s", self.stepCo.id, self.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)

	self._isReference = false
end

function AergusiDialogNormalRightItem:refresh()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(self._gorolebg, curGroupId == self.stepCo.id)
	gohelper.setActive(self._gorolebggrey, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._txtName.gameObject, curGroupId == self.stepCo.id)
	gohelper.setActive(self._txtNameGrey.gameObject, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._gomaskgrey, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._goreference, curGroupId == self.stepCo.id)
	gohelper.setActive(self._goreferencegrey, curGroupId ~= self.stepCo.id)

	self._txtContent.text = self.stepCo.content

	self._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.speakerIcon))
	self._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.speakerIcon))

	self._txtName.text = self.stepCo.speaker
	self._txtNameGrey.text = self.stepCo.speaker

	gohelper.setActive(self._goreference, self._isReference)
	gohelper.setActive(self._goreferencegrey, self._isReference)
	gohelper.setActive(self._goselectframe, false)
end

function AergusiDialogNormalRightItem:setQutation(qutationStepCo)
	if not qutationStepCo then
		gohelper.setActive(self._goreference, false)

		return
	end

	local type = string.splitToNumber(qutationStepCo.condition, "#")[1]

	self._isReference = true

	gohelper.setActive(self._goreference, true)

	self._txtreference.text = qutationStepCo.content
	self._txtreferencegrey.text = qutationStepCo.content

	gohelper.setActive(self._goiconask, type == AergusiEnum.OperationType.Probe)
	gohelper.setActive(self._goiconobjection, type == AergusiEnum.OperationType.Refutation)
	gohelper.setActive(self._goiconaskgrey, type == AergusiEnum.OperationType.Probe)
	gohelper.setActive(self._goiconobjectiongrey, type == AergusiEnum.OperationType.Refutation)
	self:refresh()
	self:calculateHeight()
end

function AergusiDialogNormalRightItem:calculateHeight()
	local width = self._txtContent.preferredWidth

	if width <= AergusiEnum.MessageTxtMaxWidth then
		local contentBgHeight = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		recthelper.setSize(self._contentBgRt, width + AergusiEnum.MessageBgOffsetWidth, contentBgHeight)
		recthelper.setSize(self._contentRt, width, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	width = AergusiEnum.MessageTxtMaxWidth

	local height = self._txtContent.preferredHeight
	local contentBgHeight = height + AergusiEnum.MessageBgOffsetHeight

	recthelper.setSize(self._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, contentBgHeight)
	recthelper.setSize(self._contentRt, width, height)
end

function AergusiDialogNormalRightItem:getHeight()
	if self._isReference then
		if not AergusiEnum.DialogDoubtOffsetHeight then
			local heightOffset = 0
			local width = self._txtContent.preferredWidth

			if width <= AergusiEnum.MessageTxtMaxWidth then
				local contentBgHeight = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

				self.height = Mathf.Max(AergusiEnum.MinHeight[self.type] + heightOffset + AergusiEnum.DialogDoubtOffsetHeight, contentBgHeight + AergusiEnum.MessageNameHeight + heightOffset + AergusiEnum.DialogDoubtOffsetHeight)

				return self.height
			end

			width = AergusiEnum.MessageTxtMaxWidth

			local height = AergusiEnum.MessageTxtOneLineHeight * self._txtContent:GetTextInfo(self.stepCo.content).lineCount
			local contentBgHeight = height + AergusiEnum.MessageBgOffsetHeight

			self.height = Mathf.Max(AergusiEnum.MinHeight[self.type] + heightOffset + AergusiEnum.DialogDoubtOffsetHeight, contentBgHeight + AergusiEnum.MessageNameHeight + heightOffset + AergusiEnum.DialogDoubtOffsetHeight)

			return self.height
		end
	end
end

function AergusiDialogNormalRightItem:onDestroy()
	self._simageAvatar:UnLoadImage()
	self._simageAvatarGrey:UnLoadImage()
end

return AergusiDialogNormalRightItem
