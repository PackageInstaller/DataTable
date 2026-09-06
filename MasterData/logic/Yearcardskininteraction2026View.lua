-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/Yearcardskininteraction2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.Yearcardskininteraction2026View", package.seeall)

local Yearcardskininteraction2026View = class("Yearcardskininteraction2026View", ViewComponent)

function Yearcardskininteraction2026View:ctor()
	Yearcardskininteraction2026View.super.ctor(self)

	self._cacheV3 = Vector3.New(0, 0, 0)
end

function Yearcardskininteraction2026View:buildUI()
	Yearcardskininteraction2026View.super.buildUI(self)

	self._btnClose = self:getBtn("Left/btn_close")
	self._spineInterface = self:getGo("mask/role/spineInterface")
	self._extendView = self:getGo("mask/role/extendView")
	self._role_image_1Go = self:getGo("mask/role/dragContent/role_image_1")
end

function Yearcardskininteraction2026View:bindEvents()
	Yearcardskininteraction2026View.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function Yearcardskininteraction2026View:unbindEvents()
	Yearcardskininteraction2026View.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function Yearcardskininteraction2026View:destroyUI()
	Yearcardskininteraction2026View.super.destroyUI(self)
end

function Yearcardskininteraction2026View:onEnter()
	Yearcardskininteraction2026View.super.onEnter(self)
	self.addGEvent(self, MsEnum.Notify_SpineInterfaceBagExtension, self._notify_SpineInterfaceBagExtension, self)

	self._isLihui = true
	self.currCfg = nil

	local param = self:getOpenParam() or {}
	local skinId = param[1]

	self._petPhotoShows = {}

	self:_updateState()

	self._curIndex = 1

	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if not cfg then
		printError("没配置皮肤 id:" .. skinId)
		self:close()
	end

	self:_updateSelectCell(skinId, self._role_image_1Go)
end

function Yearcardskininteraction2026View:onEnterFinished()
	Yearcardskininteraction2026View.super.onEnterFinished(self)
end

function Yearcardskininteraction2026View:onExit()
	Yearcardskininteraction2026View.super.onExit(self)
	PetCvController.instance:turnOffCurCv()
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	for _, v in pairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil
end

function Yearcardskininteraction2026View:onExitFinished()
	Yearcardskininteraction2026View.super.onExitFinished(self)
end

function Yearcardskininteraction2026View:_onClickClose()
	self:close()
end

function Yearcardskininteraction2026View:_updateState()
	self._showLihui = self._isLihui and self._hasLihui

	if self._curPetPhotoShow then
		self._curPetPhotoShow:switchState(self._showLihui)
	end
end

function Yearcardskininteraction2026View:_updateSelectCell(skinId, cell)
	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	self._curPetPhotoShow = petPhotoShow

	self._curPetPhotoShow:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
	self._curPetPhotoShow:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))

	self._petPhotoShows[cell.gameObject] = petPhotoShow

	local cfg = CharacterConfig.instance:getModelCo(checknumber(skinId))

	self._hasLihui = cfg ~= nil and not string.nilorempty(cfg.bustName)
	self._showLihui = self._isLihui and self._hasLihui

	petPhotoShow:showPetEffect(skinId, self._showLihui)
	PetCvController.instance:turnOffCurCv()
end

function Yearcardskininteraction2026View:_notify_SpineInterfaceBagExtension(eventParams)
	if self._spineInterfaceComp then
		self._extendViewPresentor = self._spineInterfaceComp:openExtension(self._extendView, self._viewPresentor, eventParams)
	end
end

function Yearcardskininteraction2026View:_closeSpineInterfaceExtension()
	if self._extendViewPresentor then
		ViewMgr.instance:close(self._extendViewPresentor.viewName)

		self._extendViewPresentor = nil
	end
end

function Yearcardskininteraction2026View:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	local skinId

	self._spineInterfaceComp, skinId = SpineInterfaceComp.reloadPhotoShow(self._spineInterfaceComp, self._spineInterface, photoShow, false)

	GameUtil.SetActive(self._spineInterface, self:_isInteractable(skinId))
end

function Yearcardskininteraction2026View:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	self:_closeSpineInterfaceExtension()

	if self._spineInterfaceComp then
		self._spineInterfaceComp:unload()
	end
end

function Yearcardskininteraction2026View:_isSpineInterfaceCompLoaded()
	return self._spineInterfaceComp and self._spineInterfaceComp:isLoaded() or false
end

function Yearcardskininteraction2026View:_isInteractable(skinId)
	return PetSkinConfig.instance:isSkinInteractable(skinId) and self:_isSpineInterfaceCompLoaded()
end

return Yearcardskininteraction2026View
