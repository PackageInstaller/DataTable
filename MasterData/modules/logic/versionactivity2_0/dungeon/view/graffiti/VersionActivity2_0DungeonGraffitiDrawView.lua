-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiDrawView.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawView", package.seeall)

local VersionActivity2_0DungeonGraffitiDrawView = class("VersionActivity2_0DungeonGraffitiDrawView", BaseView)

function VersionActivity2_0DungeonGraffitiDrawView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gograffiti = gohelper.findChild(self.viewGO, "#go_graffiti")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_graffiti/#simage_icon")
	self._simagemaskicon = gohelper.findChildSingleImage(self.viewGO, "#go_graffiti/#simage_maskicon")
	self._imagemaskicon = gohelper.findChildImage(self.viewGO, "#go_graffiti/#simage_maskicon")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._btnfinish = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_finish")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_info/image_TitleBG/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/Scroll View/Viewport/#txt_desc")
	self._godrawcan = gohelper.findChild(self.viewGO, "#go_drawcan")
	self._gotips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._graffitiAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gograffiti)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonGraffitiDrawView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnfinish:AddClickListener(self._btnfinishOnClick, self)
end

function VersionActivity2_0DungeonGraffitiDrawView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnfinish:RemoveClickListener()
end

function VersionActivity2_0DungeonGraffitiDrawView:_btnstartOnClick()
	self._graffitiAnimatorPlayer:Play(UIAnimationName.Click, self.hideBlock, self)
	gohelper.setActive(self._btnstart.gameObject, false)
	gohelper.setActive(self._gotips.gameObject, true)
	TaskDispatcher.runDelay(self.addComp, self, 0.01)
	UIBlockMgr.instance:startBlock("enlargePictureAnim")
	self.viewContainer:setIsBeginDrawState(true)
	gohelper.setActive(self._gotopleft, false)
end

function VersionActivity2_0DungeonGraffitiDrawView:hideBlock()
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function VersionActivity2_0DungeonGraffitiDrawView:_btnfinishOnClick()
	self:closeThis()
end

function VersionActivity2_0DungeonGraffitiDrawView:_editableInitView()
	gohelper.setActive(self._godrawcan, false)
	gohelper.setActive(self._gotips, false)

	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
end

function VersionActivity2_0DungeonGraffitiDrawView:setNativeSize()
	ZProj.UGUIHelper.SetImageSize(self._simageicon.gameObject)
end

function VersionActivity2_0DungeonGraffitiDrawView:setMaskNativeSize()
	ZProj.UGUIHelper.SetImageSize(self._simagemaskicon.gameObject)
end

function VersionActivity2_0DungeonGraffitiDrawView:onOpen()
	self:initData()
	self:refreshUI()
end

function VersionActivity2_0DungeonGraffitiDrawView:initData()
	self.state = self.viewParam.graffitiMO.state
	self.graffitiId = self.viewParam.graffitiMO.id
	self.config = self.viewParam.graffitiMO.config
	self.normalMaterial = self.viewParam.normalMaterial
	self.isFinish = self.state == Activity161Enum.graffitiState.IsFinished

	local pictureRes = string.format("%s_manual", self.config.picture)
	local pictureMaskRes = string.format("%s_manual", self.config.picture)

	self._simageicon:LoadImage(ResUrl.getGraffitiIcon(pictureRes), self.setNativeSize, self)
	self._simagemaskicon:LoadImage(ResUrl.getGraffitiIcon(pictureMaskRes), self.setMaskNativeSize, self)

	self._imagemaskicon.material = self.normalMaterial
	self.uiCamera = CameraMgr.instance:getUICamera()

	gohelper.setActive(self._gotopleft, true)
end

function VersionActivity2_0DungeonGraffitiDrawView:addComp()
	self.erasePicture = ZProj.ErasePicture.AddComp(self._gograffiti)

	self.erasePicture:InitData(self.config.brushSize, self.config.finishRate, self._imagemaskicon, self.uiCamera)
	self.erasePicture:setCallBack(self.startDraw, self, self.showRate, self, self.endDraw, self, self.finishDraw, self)
end

function VersionActivity2_0DungeonGraffitiDrawView:refreshUI()
	self._txttitle.text = self.config.finishTitle
	self._txtdesc.text = self.config.finishDesc

	gohelper.setActive(self._goinfo, self.isFinish)
	gohelper.setActive(self._btnstart, not self.isFinish)
	gohelper.setActive(self._btnfinish.gameObject, self.isFinish)
	gohelper.setActive(self._simagemaskicon.gameObject, not self.isFinish)
end

function VersionActivity2_0DungeonGraffitiDrawView:startDraw()
	if self.isFinish then
		return
	end

	gohelper.setActive(self._godrawcan, true)
	self:setDrawCanPos()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_loop)
end

function VersionActivity2_0DungeonGraffitiDrawView:showRate()
	if self.isFinish then
		return
	end

	gohelper.setActive(self._godrawcan, true)
	self:setDrawCanPos()
end

function VersionActivity2_0DungeonGraffitiDrawView:endDraw()
	gohelper.setActive(self._godrawcan, false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
end

function VersionActivity2_0DungeonGraffitiDrawView:setDrawCanPos()
	local uiCanPosX, uiCanPosY = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), self.rectTrViewGo)

	recthelper.setAnchor(self._godrawcan.transform, uiCanPosX, uiCanPosY)
end

function VersionActivity2_0DungeonGraffitiDrawView:finishDraw()
	if self.isFinish then
		return
	end

	self.isFinish = true

	gohelper.setActive(self._godrawcan, false)
	gohelper.setActive(self._gotips.gameObject, false)
	self:refreshUI()
	DungeonRpc.instance:sendMapElementRequest(self.config.elementId)
	Activity161Model.instance:setGraffitiState(self.config.elementId, Activity161Enum.graffitiState.IsFinished)
	self.viewContainer:setIsBeginDrawState(false)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_spray_loop)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_spray_finish)
	self._graffitiAnimatorPlayer:Play("finish")
	Activity161Controller.instance:dispatchEvent(Activity161Event.FinishDrawGraffiti)
end

function VersionActivity2_0DungeonGraffitiDrawView:onClose()
	self._simageicon:UnLoadImage()
	self._simagemaskicon:UnLoadImage()
	TaskDispatcher.cancelTask(self.addComp, self)
	TaskDispatcher.cancelTask(self.hideBlock, self)
	UIBlockMgr.instance:endBlock("enlargePictureAnim")
end

function VersionActivity2_0DungeonGraffitiDrawView:onDestroyView()
	return
end

return VersionActivity2_0DungeonGraffitiDrawView
