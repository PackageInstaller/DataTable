-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoolostanimalView.lua

module("logic.extensions.zoo.view.ZoolostanimalView", package.seeall)

local ZoolostanimalView = class("ZoolostanimalView", ViewComponent)

function ZoolostanimalView:buildUI()
	ZoolostanimalView.super.buildUI(self)

	self._feedBtn = self:getBtn("Btns/feedBtn")
	self._feedNum = self:getTxt("Btns/feedBtn/num")
	self._goHomeBtn = self:getBtn("Btns/goHomeBtn")
	self._ignoreBtn = self:getBtn("Btns/ignoreBtn")
	self._animal = self:getGo("animal")
	self._Btn_Close = self:getBtn("Btn_Close")
end

function ZoolostanimalView:bindEvents()
	ZoolostanimalView.super.bindEvents(self)
	self._Btn_Close:AddClickListener(self.close, self)
	self._feedBtn:AddClickListener(function()
		self:_handleLostAnimal(AnimalModel.LostAnimalHandleType_Feed)
	end)
	self._goHomeBtn:AddClickListener(function()
		self:_handleLostAnimal(AnimalModel.LostAnimalHandleType_SendHomd)
	end)
	self._ignoreBtn:AddClickListener(function()
		self:_handleLostAnimal(AnimalModel.LostAnimalHandleType_Ingore)
	end)
end

function ZoolostanimalView:unbindEvents()
	ZoolostanimalView.super.unbindEvents(self)
	self._Btn_Close:RemoveClickListener()
	self._feedBtn:RemoveClickListener()
	self._goHomeBtn:RemoveClickListener()
	self._ignoreBtn:RemoveClickListener()
end

function ZoolostanimalView:onEnter()
	local openParam = self:getOpenParam()

	self._animalMo = openParam[1]
	self._id = openParam[2]
	self._show, self._avatar = self._animalMo:showAnimalAvatar(self._animal, 600, 480, 0.63, 0.65)

	local matType, id, matNum = MaterialMgr.getMatParams(ZooConfig.instance:getFeedCostItem())

	self._feedNum.text = string.format(lang("petzoo_friuts_num"), matNum)

	GlobalDispatcher:addListener(GlobalNotify.OnZooHandleLostAnimal, self.close, self)
end

function ZoolostanimalView:onExit()
	ZoolostanimalView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooHandleLostAnimal, self.close, self)
end

function ZoolostanimalView:onExitFinished()
	self._show:clear()
	self._avatar:destroy()
	ZoolostanimalView.super.onExitFinished(self)
end

function ZoolostanimalView:_handleLostAnimal(handleType)
	ZooController.instance:sendPM_ZooHandleLostAnimalReq(self._animalMo.id, handleType, self._id)
end

return ZoolostanimalView
