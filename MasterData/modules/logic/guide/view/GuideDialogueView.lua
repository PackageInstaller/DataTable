-- chunkname: @modules/logic/guide/view/GuideDialogueView.lua

module("modules.logic.guide.view.GuideDialogueView", package.seeall)

local GuideDialogueView = class("GuideDialogueView", BaseView)

function GuideDialogueView:onInitView()
	self._gotipsmask = gohelper.findChild(self.viewGO, "#go_tipsmask")
	self._gotype4 = gohelper.findChild(self.viewGO, "#go_type4")
	self._godialogue = gohelper.findChild(self.viewGO, "#go_dialogue")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_dialogue/#txt_content")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_dialogue/#txt_name")
	self._simageleft = gohelper.findChildSingleImage(self.viewGO, "#go_dialogue/left/#simage_left")
	self._simageright = gohelper.findChildSingleImage(self.viewGO, "#go_dialogue/right/#simage_right")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuideDialogueView:addEvents()
	return
end

function GuideDialogueView:removeEvents()
	return
end

function GuideDialogueView:_editableInitView()
	self._dialogueTr = self._godialogue.transform
end

function GuideDialogueView:onDestroyView()
	return
end

function GuideDialogueView:onOpen()
	self:_updateUI()
	self.addEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
end

function GuideDialogueView:onUpdateParam()
	self:_updateUI()
	self.removeEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
end

function GuideDialogueView:_updateUI()
	if not self.viewParam then
		return
	end

	gohelper.setActive(self._godialogue, self.viewParam.hasDialogue)

	if not self.viewParam.hasDialogue then
		return
	end

	self._txtcontent.text = string.gsub(self.viewParam.tipsContent, " ", " ")
	self._txtname.text = self.viewParam.tipsTalker

	gohelper.setActive(self._simageleft.gameObject, false)
	gohelper.setActive(self._simageright.gameObject, false)

	if string.nilorempty(self.viewParam.tipsHead) then
		return
	end

	local isLeft = self.viewParam.portraitPos == 0

	self._simageTemp = isLeft and self._simageleft or self._simageright

	gohelper.setActive(self._simageTemp.gameObject, true)
	self._simageTemp:LoadImage(ResUrl.getHeadIconImg(self.viewParam.tipsHead), self._loadFinish, self)
end

function GuideDialogueView:_loadFinish()
	ZProj.UGUIHelper.SetImageSize(self._simageTemp.gameObject)
	self:_setPortraitOffset(self._simageTemp.gameObject)
end

function GuideDialogueView:_setPortraitOffset(go)
	local skinCfg = SkinConfig.instance:getSkinCo(tonumber(self.viewParam.tipsHead))

	if not skinCfg then
		logError("no skin skinId:" .. self.viewParam.tipsHead)

		return
	end

	local isLeft = self.viewParam.portraitPos == 0

	if isLeft then
		local offsets = SkinConfig.instance:getSkinOffset(skinCfg.guideLeftPortraitOffset or skinCfg.guideRightPortraitOffset)
		local transform = go.transform

		recthelper.setAnchor(transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function GuideDialogueView:onClose()
	self._simageright:UnLoadImage()
	self._simageleft:UnLoadImage()
end

return GuideDialogueView
