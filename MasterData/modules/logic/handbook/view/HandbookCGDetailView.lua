-- chunkname: @modules/logic/handbook/view/HandbookCGDetailView.lua

module("modules.logic.handbook.view.HandbookCGDetailView", package.seeall)

local HandbookCGDetailView = class("HandbookCGDetailView", BaseView)

function HandbookCGDetailView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagecg = gohelper.findChildSingleImage(self.viewGO, "#simage_cg")
	self._simagezone = gohelper.findChildSingleImage(self.viewGO, "#simage_cg/#simage_zone")
	self._simagecgold = gohelper.findChildSingleImage(self.viewGO, "#simage_cgold")
	self._simagezoneold = gohelper.findChildSingleImage(self.viewGO, "#simage_cgold/#simage_zoneold")
	self._btnprev = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_prev")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_next")
	self._txttitleNameEn = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_titleNameEn")
	self._txttitleName = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_titleName")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_ui/desc/#txt_desc")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_ui/page/#txt_curindex")
	self._txttotalpage = gohelper.findChildText(self.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	self._godrag = gohelper.findChild(self.viewGO, "#btn_click/#go_drag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookCGDetailView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnprev:AddClickListener(self._btnprevOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function HandbookCGDetailView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnprev:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

function HandbookCGDetailView:_btnclickOnClick()
	self:_setUIActive(not self._uiActive)
end

function HandbookCGDetailView:_btnprevOnClick()
	local prevCGConfig = HandbookModel.instance:getPrevCG(self._cgId, self._cgType)

	if not prevCGConfig then
		return
	end

	self._cgId = prevCGConfig.id

	self:_refreshUI()
end

function HandbookCGDetailView:_btnnextOnClick()
	local nextCGConfig = HandbookModel.instance:getNextCG(self._cgId, self._cgType)

	if not nextCGConfig then
		return
	end

	self._cgId = nextCGConfig.id

	self:_refreshUI()
end

function HandbookCGDetailView:_setUIActive(isActive)
	self._uiActive = isActive

	gohelper.setActive(self._goui, self._uiActive)
end

function HandbookCGDetailView:_editableInitView()
	self._cimagecg = self._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._imageZone = gohelper.findChildImage(self.viewGO, "#simage_cg/#simage_zone")
	self._cimagecgold = self._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	self._imageZoneOld = gohelper.findChildImage(self.viewGO, "#simage_cgold/#simage_zoneold")

	gohelper.setActive(self._simagecg.gameObject, false)
	gohelper.setActive(self._simagecgold.gameObject, false)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	gohelper.addUIClickAudio(self._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(self._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	self.loadedCgList = {}
end

function HandbookCGDetailView:_onDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x
end

function HandbookCGDetailView:_onDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		self:_btnprevOnClick()
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		self:_btnnextOnClick()
	end
end

function HandbookCGDetailView:onOpen()
	self._cgId = self.viewParam.id
	self._cgType = self.viewParam.cgType

	self:_refreshUI()
end

function HandbookCGDetailView:onUpdateParam()
	self._cgId = self.viewParam
	self._cgType = self.viewParam.cgType

	self:_refreshUI()
end

function HandbookCGDetailView:_refreshUI()
	local isRead = HandbookModel.instance:isRead(HandbookEnum.Type.CG, self._cgId)

	if not isRead then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.CG, self._cgId)
	end

	self:_setUIActive(true)

	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	UIBlockMgr.instance:startBlock("loadZone")

	if bgZoneMo then
		self._simagezone:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onZoneImageLoaded, self)
	else
		gohelper.setActive(self._simagezone.gameObject, false)

		self._cimagecg.vecInSide = Vector4.zero

		self:_startLoadOriginImg()
	end

	self._txttitleName.text = cgConfig.name
	self._txttitleNameEn.text = cgConfig.nameEn
	self._txtdesc.text = cgConfig.desc
	self._txtcurindex.text = HandbookModel.instance:getCGUnlockIndex(self._cgId, self._cgType)
	self._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(nil, self._cgType)
end

function HandbookCGDetailView:_startLoadOriginImg()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)

	self._simagecg:LoadImage(self:getImageName(cgConfig), self.onLoadedImage, self)
end

function HandbookCGDetailView:_onZoneImageLoaded()
	self._imageZone:SetNativeSize()
	self:_startLoadOriginImg()
end

function HandbookCGDetailView:getImageName(cgConfig)
	if not tabletool.indexOf(self.loadedCgList, cgConfig.id) then
		table.insert(self.loadedCgList, cgConfig.id)
	end

	self.lastLoadImageId = cgConfig.id

	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		return ResUrl.getStoryRes(bgZoneMo.sourcePath)
	end

	return ResUrl.getStoryBg(cgConfig.image)
end

function HandbookCGDetailView:onLoadedImage()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		gohelper.setActive(self._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(self._simagezone.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)

		local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
		local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

		self._cimagecg.vecInSide = Vector4(recthelper.getWidth(self._imageZone.transform), recthelper.getHeight(self._imageZone.transform), bgZoneMo.offsetX, bgZoneMo.offsetY)

		self:_loadOldZoneImage()
	else
		gohelper.setActive(self._simagezoneold.gameObject, false)
		self:_startLoadOldImg()
	end

	gohelper.setActive(self._simagecg.gameObject, true)

	if #self.loadedCgList <= 10 then
		return
	end

	self.loadedCgList = {
		self.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)
end

function HandbookCGDetailView:_loadOldZoneImage()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		self._simagezoneold:LoadImage(ResUrl.getStoryRes(bgZoneMo.path), self._onZoneImageOldLoaded, self)
	else
		gohelper.setActive(self._simagezoneold.gameObject, false)

		self._cimagecgold.vecInSide = Vector4.zero

		self:_startLoadOldImg()
	end
end

function HandbookCGDetailView:_onZoneImageOldLoaded()
	self._imageZoneOld:SetNativeSize()
	self:_startLoadOldImg()
end

function HandbookCGDetailView:_startLoadOldImg()
	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)

	self._simagecgold:LoadImage(self:getImageName(cgConfig), self._onLoadOldFinished, self)
end

function HandbookCGDetailView:_onLoadOldFinished()
	UIBlockMgr.instance:endBlock("loadZone")

	local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
	local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

	if bgZoneMo then
		gohelper.setActive(self._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(self._simagezoneold.gameObject.transform, bgZoneMo.offsetX, bgZoneMo.offsetY)

		local cgConfig = HandbookConfig.instance:getCGConfig(self._cgId, self._cgType)
		local bgZoneMo = StoryBgZoneModel.instance:getBgZoneByPath(cgConfig.image)

		self._cimagecgold.vecInSide = Vector4(recthelper.getWidth(self._imageZoneOld.transform), recthelper.getHeight(self._imageZoneOld.transform), bgZoneMo.offsetX, bgZoneMo.offsetY)
	end

	gohelper.setActive(self._simagecg.gameObject, false)
	gohelper.setActive(self._simagecgold.gameObject, true)
end

function HandbookCGDetailView:onClose()
	UIBlockMgr.instance:endBlock("loadZone")
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

function HandbookCGDetailView:onDestroyView()
	self._simagecg:UnLoadImage()
end

return HandbookCGDetailView
