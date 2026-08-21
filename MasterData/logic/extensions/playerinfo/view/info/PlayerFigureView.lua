-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerFigureView.lua

module("logic.extensions.playerinfo.view.info.PlayerFigureView", package.seeall)

local M = class("PlayerFigureView", DynamicFragmentView)

function M:buildUI()
	self._photoCenterPointGoMan = self._registry:findUIElement("player_figure_panel_-1336150555")
	self._photoUnitMan = PhotoUnit.Get(self:getGo("player_figure_panel_1921791407"))

	self._photoUnitMan:clear()

	self._photoCenterPointGoWoman = self._registry:findUIElement("player_figure_panel_1681063324")
	self._photoUnitWoman = PhotoUnit.Get(self:getGo("player_figure_panel_-1626976555"))

	self._photoUnitWoman:clear()

	self._togMan = self:getUIComponent("player_figure_panel_1817645295", UIComponentType.SpaceXToggle)
	self._togWoman = self:getUIComponent("player_figure_panel_937679517", UIComponentType.SpaceXToggle)
	self._btnMan = self:getBtn("player_figure_panel_1817645295")
	self._btnWoman = self:getBtn("player_figure_panel_937679517")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))
	self._RoleImg = {
		self:getGo("player_figure_panel_-1421823487"),
		self:getGo("player_figure_panel_875990132")
	}
end

function M:destroyUI()
	self._photoCenterPointGoMan = nil
	self._photoUnitMan = nil
	self._photoCenterPointGoWoman = nil
	self._photoUnitWoman = nil
	self._togMan = nil
	self._togWoman = nil
end

function M:bindEvents()
	self._btnMan:AddClickListener(self._clickSelectMan, self)
	self._btnWoman:AddClickListener(self._clickSelectWoman, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_IMAGE_SUC, self._onChangeImageSuc, self)
end

function M:unbindEvents()
	self._btnMan:RemoveClickListener()
	self._btnWoman:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_IMAGE_SUC, self._onChangeImageSuc, self)
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	local playerInfo = PlayerModel.instance:getPlayerCardInfo()

	self._curSelect = playerInfo.image

	local isMan = playerInfo.image == CommEnum.ImageEnum.Boy

	self._togMan.IsOn = isMan
	self._togWoman.IsOn = not isMan

	self:_loadPlayerImage()
end

function M:onExit()
	self._photoUnitWoman:clear()
	self._photoUnitMan:clear()
end

function M:_loadPlayerImage()
	local manModelId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.DefaultManModelId)
	local transform = self._photoCenterPointGoMan.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = false,
		isShowEnter = false,
		photo = self._photoUnitMan,
		modelId = manModelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	function paramTable.func()
		self:_setMask()
	end

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)

	local womanModelId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.DefaultWoManModelId)

	transform = self._photoCenterPointGoWoman.transform
	cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	paramTable = {
		isShowEgg = false,
		isShowEnter = false,
		photo = self._photoUnitWoman,
		modelId = womanModelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	function paramTable.func()
		self:_setMask()
	end

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
end

function M:_setMask()
	local unitSelect = self._curSelect == CommEnum.ImageEnum.Boy and self._photoUnitMan or self._photoUnitWoman
	local unitElse = self._curSelect == CommEnum.ImageEnum.Boy and self._photoUnitWoman or self._photoUnitMan

	unitSelect:setSpineColor("#FFFFFFFF")
	unitSelect:toggleMask(true, 0.524, 1)
	unitElse:setSpineColor("#6C6C6CFF")
	unitElse:toggleMask(false)
end

function M:_clickSelectMan()
	if self._curSelect == CommEnum.ImageEnum.Boy then
		return
	end

	self._curSelect = CommEnum.ImageEnum.Boy

	self:_setMask()
	self:_saveImage()
end

function M:_clickSelectWoman()
	if self._curSelect == CommEnum.ImageEnum.Girl then
		return
	end

	self._curSelect = CommEnum.ImageEnum.Girl

	self:_setMask()
	self:_saveImage()
end

function M:_saveImage()
	PlayerAgent.instance:sendChangeImageRequest(self._curSelect)

	local playerInfo = PlayerModel.instance:getPlayerCardInfo()
	local portraitId = ConstConfig.instance:getNumValuesByKey("DefaultPortrait")
	local gentle = self._curSelect == CommEnum.ImageEnum.Boy and 2 or 1

	if playerInfo.portrait == portraitId[1] or playerInfo.portrait == portraitId[2] then
		GlobalDispatcher:dispatchEvent(EventType.CHANGE_PLAYER_PORTRAIT_SUC, portraitId[gentle])
	end

	self._RoleImg[gentle].transform:DOLocalMoveZ(-20, 0.3)
	self._RoleImg[gentle % 2 + 1].transform:DOLocalMoveZ(0, 0.3)
end

function M:_onChangeImageSuc(key, image)
	local isMan = image == CommEnum.ImageEnum.Boy

	self._togMan.IsOn = isMan
end

return M
