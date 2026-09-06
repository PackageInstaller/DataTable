-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooplaceView.lua

module("logic.extensions.zoo.view.ZooplaceView", package.seeall)

local ZooplaceView = class("ZooplaceView", ViewComponent)

function ZooplaceView:buildUI()
	ZooplaceView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._itemCon = self:getGo("right")
	self._itemList = {}

	for i = 1, 8 do
		self._itemList[i] = GameUtil.AddLuaOnce(self:getGo("right/cell_" .. i), ZooPlaceItem)
	end

	self._clearBtn = self:getBtn("clearBtn")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "tipText")
end

function ZooplaceView:bindEvents()
	ZooplaceView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._clearBtn:AddClickListener(self._onClickClear, self)
end

function ZooplaceView:unbindEvents()
	ZooplaceView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._clearBtn:RemoveClickListener()
end

function ZooplaceView:destroyUI()
	ZooplaceView.super.destroyUI(self)

	for i, v in ipairs(self._itemList) do
		v:onExit()
		GameUtil.RemoveLua(v.mainGO, ZooPlaceItem)
	end

	self._itemList = nil
end

function ZooplaceView:onEnter()
	ZooplaceView.super.onEnter(self)

	self._myZoo = ZooModel.instance:getCurrZoo()
	self._currMainBuilding = self._myZoo:getMainBuilding()

	local maxNum = self._currMainBuilding:getAnimalNum()
	local placeAnimalList = self._myZoo:getPlaceAnimalIds()

	for i, v in ipairs(self._itemList) do
		v:onEnter(i, self._myZoo:getAnimalById(placeAnimalList[i]))
		v:setLock(maxNum < i)
	end

	self:_updateCurrPutNum()
	GlobalDispatcher:addListener(GlobalNotify.OnZooCancelAnimalInZoo, self._onZooCancelAnimalInZoo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooSetAnimalInZoo, self._onZooSetAnimalInZoo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnClearAllInZooState, self._onClearAllInZooState, self)
end

function ZooplaceView:onExit()
	ZooplaceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnClearAllInZooState, self._onClearAllInZooState, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooCancelAnimalInZoo, self._onZooCancelAnimalInZoo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooSetAnimalInZoo, self._onZooSetAnimalInZoo, self)

	for i, v in ipairs(self._itemList) do
		v:onExit()
	end
end

function ZooplaceView:onExitFinished()
	self._myZoo = nil
	self._currMainBuilding = nil

	ZooplaceView.super.onExitFinished(self)
end

function ZooplaceView:_updateCurrPutNum()
	local placeAnimalList = self._myZoo:getPlaceAnimalIds()
	local currPlacedNum = #placeAnimalList
	local maxNum = self._currMainBuilding:getAnimalNum()

	self._tipText.text = string.format(lang("petzoo_place_petsnum"), currPlacedNum, maxNum)
end

function ZooplaceView:_onClickClear()
	local placeAnimalList = self._myZoo:getPlaceAnimalIds()

	if #placeAnimalList == 0 then
		FloatWordMgr.instance:show(lang("petzoo_place_placed_empty"))

		return
	end

	ZooAgent.instance:sendPM_ClearAllInZooStateReq()
end

function ZooplaceView:_onZooCancelAnimalInZoo(animalId)
	self:_updateCurrPutNum()

	for i, value in ipairs(self._itemList) do
		if value:getAnimalId() == animalId then
			value:clearData()

			break
		end
	end
end

function ZooplaceView:_onClearAllInZooState()
	for i, value in ipairs(self._itemList) do
		value:clearData()
	end
end

function ZooplaceView:_onZooSetAnimalInZoo()
	self:_updateCurrPutNum()
end

return ZooplaceView
